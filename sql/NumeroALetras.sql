create function numero_a_letras(numero in number) return varchar2 is

        fuera_de_rango EXCEPTION;

        millares_de_millon number;
        millones number;
        millares number;
        centenas number;
        centimos number;

        en_letras varchar2(200);
        entero number;

        aux varchar2(15);
    begin

        if numero < 0 or numero > 999999999999.99 then
            raise fuera_de_rango;
        end if;

        entero := trunc(numero);

        millares_de_millon := trunc(entero / 1000000000);

        millones := trunc((entero mod 1000000000) / 1000000);

        millares := trunc((entero mod 1000000) / 1000);

        centenas := entero mod 1000;

        centimos := (round(numero,2) * 100) mod 100;


        -- MILLARES DE MILLON
        if millares_de_millon = 1 then
            if millones = 0 then
                en_letras := 'mil millones ';
            else
                en_letras := 'mil ';
            end if;
        elsif millares_de_millon > 1 then

            en_letras := numero_menor_mil(millares_de_millon);

            if millones = 0 then
                en_letras := en_letras || 'mil millones ';
            else
                en_letras := en_letras || 'mil ';
            end if;
        end if;

        -- MILLONES
        if millones = 1 and  millares_de_millon = 0 then
            en_letras := 'un millón ';
        elsif millones > 0 then
            en_letras := en_letras || numero_menor_mil(millones) || 'millones ';
        end if;

        -- MILLARES
        if millares = 1 and millares_de_millon = 0 and millones = 0 then
            en_letras := 'mil ';
        elsif millares > 0 then
            en_letras := en_letras || numero_menor_mil(millares) || 'mil ';
        end if;

        -- CENTENAS
        if centenas > 0 or (entero = 0 and centimos = 0) then
            en_letras := en_letras || numero_menor_mil(centenas);
        end if;

        if centimos > 0 then
            if centimos = 1 then
                aux := 'céntimo';
            else
                aux := 'céntimos';
            end if;
            if entero > 0 then
                en_letras := en_letras || 'con ' || replace(numero_menor_mil(centimos),'uno ','un ') || aux;
            else
                en_letras := en_letras || replace(numero_menor_mil(centimos),'uno','un') || aux;
            end if;
        end if;

        return(en_letras);


    EXCEPTION
        when fuera_de_rango then
            return('Error: entrada fuera de rango');
        when others then
            raise;
    end;

create  function numero_menor_mil(numero in number) 
	return varchar2 
	is
        fuera_de_rango EXCEPTION;
        no_entero EXCEPTION;

        centenas number;
        decenas number;
        unidades number;

        en_letras varchar2(100);
        unir varchar2(2);

    begin

        if trunc(numero) <> numero then
            raise no_entero;
        end if;

        if numero < 0 or numero > 999 then
            raise fuera_de_rango;
        end if;


        if numero = 100 then
            return ('cien ');
        elsif numero = 0 then
            return ('cero ');
        elsif numero = 1 then
            return ('uno ');
        else
            centenas := trunc(numero / 100);
            decenas  := trunc((numero mod 100)/10);
            unidades := numero mod 10;
            unir := 'y ';

            -- CENTENAS
            if centenas = 1 then
                en_letras := 'ciento ';
            elsif centenas = 2 then
                en_letras := 'doscientos ';
            elsif centenas = 3 then
                en_letras := 'trescientos ';
            elsif centenas = 4 then
                en_letras := 'cuatrocientos ';
            elsif centenas = 5 then
                en_letras := 'quinientos ';
            elsif centenas = 6 then
                en_letras := 'seiscientos ';
            elsif centenas = 7 then
                en_letras := 'setecientos ';
            elsif centenas = 8 then
                en_letras := 'ochocientos ';
            elsif centenas = 9 then
                en_letras := 'novecientos ';
            end if;



            -- DECENAS
            if decenas = 3 then
                en_letras := en_letras || 'treinta ';
            elsif decenas = 4 then
                en_letras := en_letras || 'cuarenta ';
            elsif decenas = 5 then
                en_letras := en_letras || 'cincuenta ';
            elsif decenas = 6 then
                en_letras := en_letras || 'sesenta ';
            elsif decenas = 7 then
                en_letras := en_letras || 'setenta ';
            elsif decenas = 8 then
                en_letras := en_letras || 'ochenta ';
            elsif decenas = 9 then
                en_letras := en_letras || 'noventa ';
            elsif decenas = 1 then
                if unidades < 6 then
                    if unidades = 0 then
                        en_letras := en_letras || 'diez ';
                    elsif unidades = 1 then
                        en_letras := en_letras || 'once ';
                    elsif unidades = 2 then
                        en_letras := en_letras || 'doce ';
                    elsif unidades = 3 then
                        en_letras := en_letras || 'trece ';
                    elsif unidades = 4 then
                        en_letras := en_letras || 'catorce ';
                    elsif unidades = 5 then
                        en_letras := en_letras || 'quince ';
                    end if;
                    unidades := 0;
                else
                    en_letras := en_letras || 'dieci';
                    unir := null;
                end if;
            elsif decenas = 2 then
                if unidades = 0 then
                    en_letras := en_letras || 'veinte ';
                else
                    en_letras := en_letras || 'veinti';
                end if;
                unir := null;
            elsif decenas = 0 then
                unir := null;
            end if;

            -- UNIDADES
            if unidades = 1 then
                en_letras := en_letras || unir || 'uno ';
            elsif unidades = 2 then
                en_letras := en_letras || unir || 'dos ';
            elsif unidades = 3 then
                en_letras := en_letras || unir || 'tres ';
            elsif unidades = 4 then
                en_letras := en_letras || unir || 'cuatro ';
            elsif unidades = 5 then
                en_letras := en_letras || unir || 'cinco ';
            elsif unidades = 6 then
                en_letras := en_letras || unir || 'seis ';
            elsif unidades = 7 then
                en_letras := en_letras || unir || 'siete ';
            elsif unidades = 8 then
                en_letras := en_letras || unir || 'ocho ';
            elsif unidades = 9 then
                en_letras := en_letras || unir || 'nueve ';
            end if;
        end if;

        return(en_letras);

    EXCEPTION
        when no_entero then
            return('Error: entrada no es un número entero');
        when fuera_de_rango then
            return('Error: entrada fuera de rango');
        when others then
            raise;

    end;

