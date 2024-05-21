
velv += grav

if (momento == "off")
{
	//Code OFF
	sprite_index = spr_bomba
}
else if (momento == "on")
{
	//Code ON
	sprite_index = spr_bomba_on
	
	//Rodando o boom timer
	if (boom_timer > 0)
	{
		boom_timer--
	}
	else
	{
		//Se o boom for 0 ou menos
		momento = "boom"
	}
}
else if (momento == "boom")
{
	//Code BOOM
	
	//Checar se ele já mudou de sprite
	if (sprite_index != spr_bomba_boom)
	{
		//Mudo de sprite
		sprite_index = spr_bomba_boom
		//Começo do zero
		image_index = 0
	}
	//Animação acabou, destruir
	if (image_index >= image_number-1)
	{
		instance_destroy()
	}
	//Checando se estou colidindo com o player
	var _player = instance_place(x, y, obj_player)
	if (_player)
	{
		with(_player)
		{
			dano = true
			//Dando valor ao timer
			timer_dano = tempo_dano;
			inv_timer = inv_tempo
		}
	}
}

