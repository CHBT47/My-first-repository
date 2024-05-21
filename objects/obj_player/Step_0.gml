//controlando o player
var _chao = place_meeting(x, y + 1, obj_chao);

var _left, _right, _jump;
_left	= keyboard_check(inputs.left);
_right	= keyboard_check(inputs.right);
_jump	= keyboard_check_pressed(inputs.jump);

//So me controlo se o timer estiver zerado
if (timer_dano <= 0)
{
	velh	= (_right - _left) * vel;
}

//Pulando
if (_chao)
{
	if (_jump)
	{
		velv -= vel_jump;	
	}
	//Se eu estou no chão e me movendo
	if (velh != 0)
	{	
		//Mudo a sprite
		sprite_index = spr_player_run
		//Faço olhar para o outro lado
		image_xscale = sign(velh)
	}
	else
	{
		sprite_index = spr_player_idle
	}
}
else //Não estou no chão
{
	//Mudando a sprite
	if (velv < 0)
	{
		sprite_index = spr_player_jump;
	}
	else
	{
		sprite_index = spr_player_fall;
		//Se eu estou caindo, inimigo toma dano
		var _inimigo = instance_place(x, y + 5, obj_inimigo_pai)
		
		//Se eu cai no inimgo
		if (_inimigo)
		{
			dano = false
			//Se o inimigo não ta morto
			if (_inimigo.morto == false)
			{
				//Quico de novo
				velv = -vel_jump
			
				//Aviso o inimigo do dano recebido
				_inimigo.dano = true
			}
		}
	}
	
	//Aplicando a gravidadez
	velv += grav;
	if (velh != 0)
	{
		image_xscale = sign(velh);	
	}
}

//Tomar dano
if (dano)
{
	timer_dano--;
	sprite_index = spr_player_dano;
}

//Se o timer do dano é maior que zero, eu diminuo ele
if (timer_dano > 0)
{
	timer_dano--
}
else
{
	//Acabou meu timer
	dano = false	
}

if (inv_timer > 0)
{
	inv_timer--	
	
	image_alpha = .5
}
else
{
	image_alpha = 1	
}

var _inimigo = instance_place(x, y, obj_inimigo_pai)
if (_inimigo && inv_timer <= 0)
{
	if (_inimigo.morto == false && _inimigo.dano == false)
	{
		dano = true
		//Dando valor ao timer
		timer_dano = tempo_dano;
		inv_timer = inv_tempo
	}
}



