//Morte
if (morto)
{
	sprite_index = spr_inimigo_porco_dead
	
	//Sumir com o inimigo
	if (image_speed <= 0)
	{
		image_alpha -= 0.01;
	}
	//Se eu sumi, logo, n existo
	if (image_alpha <=0)
	{
		instance_destroy();
	}
	
	exit;
}

//Movimentação do Porco
var _chao = place_meeting(x, y + 1, obj_chao)

if (estado == "normal")
{
	//Checando se eu colidi com uma bomba
	var _bomba = instance_place(x, y, obj_bomba)
	
	if (_bomba)
	{
		//Checando se ela ta apagada
		if (_bomba.momento == "off")
		{
			estado = "fosforo_on"	
		}
	}
	
	if (_chao)
	{
		//Controlando a animação do Inimigo
		if (velh != 0)
		{	
			//Mudo a sprite
			sprite_index = spr_inimigo_porco_run
			//Faço olhar para o outro lado
			image_xscale = sign(velh)
		}
		else
		{
			sprite_index = spr_inimigo_porco_run
			velh = choose(vel, -vel)
		}

		//Se eu bato na parede eu mudo a direção
		if (place_meeting(x + velh, y, obj_chao))
		{
			velh *= -1
		}

		//Se eu n puder cair, então dou meia volta
		if (pode_cair == false)
		{
			if (place_meeting(x + (velh * 10), y + 1, obj_chao) == false)
			{
				//Se eu n cair e n tocar o chão eu mudo a direção
				velh *= -1	
			}
		}		
	}
	else
	{	//Se eu não estou no chão, eu aplico a gravidade
		velv += grav;
		if (velh != 0)
		{
			image_xscale = sign(velh)	
		}
	}
}
//Checando o dano tomado

else if (estado == "fosforo_on")
{
	//Mudando a sprite dele
	if (sprite_index != spr_porco_acend)
	{
		sprite_index = spr_porco_acend
		image_index = 0
	}
	velh = 0
	
	//Depois que ele acendeu? O fosforo ele muda de estado
	if (image_index >= image_number - 1)
	{
		estado = "fosforo_bomba"	
	}
}
else if (estado == "fosforo_bomba")
{
	if (sprite_index != spr_porco_ativo)
	{
		sprite_index = spr_porco_ativo
		image_index = 0
	}
	
	if (image_index >= image_number)
	{
		var _bomba = instance_place(x, y, obj_bomba)
		if (_bomba)
		{
			_bomba.momento = "on"
			estado = "normal"
		}
	}
}
if (dano == true)
{
	sprite_index = spr_inimigo_porco_dano
	velh = 0
	morto = true
}
