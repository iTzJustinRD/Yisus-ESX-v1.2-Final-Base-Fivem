Config = {}
Config['Debug'] = false -- crear clon para probar sincronización

Config['SelectableButtons'] = { -- https://docs.fivem.net/docs/game-references/controls/
    {'~INPUT_VEH_NEXT_RADIO~', 81},
    {'~INPUT_VEH_PREV_RADIO~', 82}
}

Config['OpenMenu'] = 170
Config['CancelAnimation'] = 105

Config['PoleDance'] = { -- barras de baile del puti o donde quieras XD
    ['Enabled'] = true,
    ['Locations'] = {
        {['Position'] = vector3(112.60, -1286.76, 28.56), ['Number'] = '3'},
        {['Position'] = vector3(104.18, -1293.94, 29.26), ['Number'] = '1'},
        {['Position'] = vector3(102.24, -1290.54, 29.26), ['Number'] = '2'}
    }
}

Strings = {
    ['Choose_Favorite'] = 'Que tecla quieres usar para %s?',
    ['Select_Favorite'] = 'Añadir animación a una tecla rápida',
    ['Manage_Favorites'] = 'Configurar teclas rápidas',
    ['Close'] = 'Cancelar',
    ['Updated_Favorites'] = 'Teclas rápidas actualizadas',
    ['Remove?'] = '¿Eliminar "%s" de las teclas rápidas?',
    ['Yes'] = 'Sí',
    ['No'] = 'No',
    ['Animations'] = 'Animaciones',
    ['Synced'] = 'Animaciones sincronizadas',
    ['Sync_Request'] = '¿Quieres %s %s?',
    ['Pole_Dance'] = '[~r~E~w~] Baile en la barra',
    ['Noone_Close'] = 'No hay nadie cerca.',
    ['Not_In_Car'] = '¡No estás en un coche!'
}

Config['Synced'] = {
    {
        ['Label'] = 'Abrazo',
        ['RequesterLabel'] = 'abrazar',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'kisses_guy_a', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'kisses_guy_b', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Chocar los cinco',
        ['RequesterLabel'] = 'chocar los cinco con',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'highfive_guy_a', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'highfive_guy_b', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = -0.5,
                ['yP'] = 1.25,
                ['zP'] = 0.0,

                ['xR'] = 0.9,
                ['yR'] = 0.3,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Abrazo de bros',
        ['RequesterLabel'] = 'abrazar a tu bro',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'hugs_guy_a', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'hugs_guy_b', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = -0.025,
                ['yP'] = 1.15,
                ['zP'] = 0.0,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Chocar nudillos',
        ['RequesterLabel'] = 'chocar nudillos',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationpaired@f_f_fist_bump', ['Anim'] = 'fist_bump_left', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationpaired@f_f_fist_bump', ['Anim'] = 'fist_bump_right', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = -0.6,
                ['yP'] = 0.9,
                ['zP'] = 0.0,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 270.0,
            }
        }
    },
    {
        ['Label'] = 'Dar la mano (amigos)',
        ['RequesterLabel'] = 'estechar la mano con',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'handshake_guy_a', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'handshake_guy_b', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.0,
                ['yP'] = 1.2,
                ['zP'] = 0.0,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Dar la mano (trabajo)',
        ['RequesterLabel'] = 'dar la mano a',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_common', ['Anim'] = 'givetake1_a', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_common', ['Anim'] = 'givetake1_b', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.075,
                ['yP'] = 1.0,
                ['zP'] = 0.0,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
        -- FORNIQUEOOOOOOOOO
        {
            ['Label'] = 'Dar mamada',
            ['RequesterLabel'] = 'obtener una mamada de',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'pimpsex_hooker', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.0,
                    ['yP'] = 0.65,
                    ['zP'] = 0.0,
    
                    ['xR'] = 120.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'pimpsex_punter', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = 'Ser follado',
            ['RequesterLabel'] = 'follar con',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'shagloop_hooker', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 0.4,
                    ['zP'] = 0.0,
    
                    ['xR'] = 120.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'shagloop_pimp', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = 'Anal', 
            ['RequesterLabel'] = 'ser follado por detrás por',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'rcmpaparazzo_2', ['Anim'] = 'shag_loop_a', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'rcmpaparazzo_2', ['Anim'] = 'shag_loop_poppy', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.015,
                    ['yP'] = 0.35,
                    ['zP'] = 0.0,
    
                    ['xR'] = 0.9,
                    ['yR'] = 0.3,
                    ['zR'] = 0.0,
                },
            },
        },
        {
            ['Label'] = "Tener sexo (Asiento del conductor)", 
            ['RequesterLabel'] = 'follar con',
            ['Car'] = true,
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@assassinate@vice@sex', ['Anim'] = 'frontseat_carsex_loop_m', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@assassinate@vice@sex', ['Anim'] = 'frontseat_carsex_loop_f', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = "Tener sexo (el otro da) (asiento del conductor)", 
            ['RequesterLabel'] = 'follar con',
            ['Car'] = true,
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'random@drunk_driver_2', ['Anim'] = 'cardrunksex_loop_f', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'random@drunk_driver_2', ['Anim'] = 'cardrunksex_loop_m', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = "Recibir mama (asiento del conductor)", 
            ['RequesterLabel'] = 'dar mamada a',
            ['Car'] = true,
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@towing', ['Anim'] = 'm_blow_job_loop', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@towing', ['Anim'] = 'f_blow_job_loop', ['Flags'] = 1,
            },
        },
}

Config['Animations'] = {
    {
    
        ['Label'] = 'Festivos',
        ['Data'] = {
            {['Label'] = "Fumar", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_SMOKING'},
            {['Label'] = "Musico", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_MUSICIAN'},
            {['Label'] = "Dj", ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationmale@dj', ['Anim'] = 'dj', ['Flags'] = 0},
            {['Label'] = "Cafe", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_DRINKING'},
            {['Label'] = "Cerveza", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_PARTYING'},
            {['Label'] = "Guitarra invisible", ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationmale@air_guitar', ['Anim'] = 'air_guitar', ['Flags'] = 0},
            {['Label'] = "Follarse el aire", ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationfemale@air_shagging', ['Anim'] = 'air_shagging', ['Flags'] = 0},
            {['Label'] = "Rock'n'roll", ['Type'] = 'animation', ['Dict'] = 'mp_player_int_upperrock', ['Anim'] = 'mp_player_int_rock', ['Flags'] = 0},
            {['Label'] = "Borracho en pie", ['Type'] = 'animation', ['Dict'] = 'amb@world_human_bum_standing@drunk@idle_a', ['Anim'] = 'idle_a', ['Flags'] = 0},
            {['Label'] = "Vomitar", ['Type'] = 'animation', ['Dict'] = 'oddjobs@taxi@tie', ['Anim'] = 'vomit_outside', ['Flags'] = 0},
    
        }    
    },
    {
        
        ['Label'] = 'Saludos',
        ['Data'] = {
            {['Label'] = "Hola", ['Type'] = 'animation', ['Dict'] = 'gestures@m@standing@casual', ['Anim'] = 'gesture_hello', ['Flags'] = 0},
            {['Label'] = "Señal", ['Type'] = 'animation', ['Dict'] = 'mp_common', ['Anim'] = 'givetake1_a', ['Flags'] = 0},
            {['Label'] = "Apretón de manos", ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'handshake_guy_a', ['Flags'] = 0},
            {['Label'] = "Abrazar", ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'hugs_guy_a', ['Flags'] = 0},
            {['Label'] = "Salud", ['Type'] = 'animation', ['Dict'] = 'mp_player_int_uppersalute', ['Anim'] = 'mp_player_int_salute', ['Flags'] = 0},
    
        }    
    },
    {
        
        ['Label'] = 'Trabajos',
        ['Data'] = {
            {['Label'] = "Sospechoso: Rendición", ['Type'] = 'animation', ['Dict'] = 'random@arrests@busted', ['Anim'] = 'idle_c', ['Flags'] = 0},
            {['Label'] = "Pescando", ['Type'] = 'scenario', ['Anim'] = 'world_human_stand_fishing'},
            {['Label'] = "Policia: Investigar", ['Type'] = 'animation', ['Dict'] = 'amb@code_human_police_investigate@idle_b', ['Anim'] = 'idle_f', ['Flags'] = 0},
            {['Label'] = "Policia: Usar radio", ['Type'] = 'animation', ['Dict'] = 'random@arrests', ['Anim'] = 'generic_radio_chatter', ['Flags'] = 0},
            {['Label'] = "Policia: Trafico", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_CAR_PARK_ATTENDANT'},
            {['Label'] = "Policia: Prismaticos", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_BINOCULARS'},
            {['Label'] = "Agricultor: Plantando", ['Type'] = 'scenario', ['Anim'] = 'world_human_gardener_plant'},
            {['Label'] = "Mecánico: Reparando", ['Type'] = 'animation', ['Dict'] = 'mini@repair', ['Anim'] = 'fixing_a_ped', ['Flags'] = 0},
            {['Label'] = "Medico: Arrodillarse", ['Type'] = 'scenario', ['Anim'] = 'CODE_HUMAN_MEDIC_KNEEL'},
            {['Label'] = "Taxi: Hablar con el cliente", ['Type'] = 'animation', ['Dict'] = 'oddjobs@taxi@driver', ['Anim'] = 'leanover_idle', ['Flags'] = 0},
            {['Label'] = "Taxi: Hacer factura", ['Type'] = 'animation', ['Dict'] = 'oddjobs@taxi@cyi', ['Anim'] = 'std_hand_off_ps_passenger', ['Flags'] = 0},
            {['Label'] = "Tendero: Dar", ['Type'] = 'animation', ['Dict'] = 'mp_am_hold_up', ['Anim'] = 'purchase_beerbox_shopkeeper', ['Flags'] = 0},
            {['Label'] = "Barman: Servir chupito", ['Type'] = 'animation', ['Dict'] = 'mini@drinking', ['Anim'] = 'shots_barman_b', ['Flags'] = 0},
            {['Label'] = "Periodista: Hacer fotos", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_PAPARAZZI'},
            {['Label'] = "Cualquiera: Apuntar en la libreta", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_CLIPBOARD'},
            {['Label'] = "Cualquiera: Martillando", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_HAMMERING'},
            {['Label'] = "Holgazán: Sosteniendo señal", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_BUM_FREEWAY'},
            {['Label'] = "Holgazán: Estatua humana", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_HUMAN_STATUE'},
    
        }    
    },
    {
        
        ['Label'] = 'Divertidos',
        ['Data'] = {
            {['Label'] = "Aplaudir", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_CHEERING'},
            {['Label'] = "Agradecer", ['Type'] = 'animation', ['Dict'] = 'mp_action', ['Anim'] = 'thanks_male_06', ['Flags'] = 0},
            {['Label'] = "Señalar", ['Type'] = 'animation', ['Dict'] = 'gestures@m@standing@casual', ['Anim'] = 'gesture_point', ['Flags'] = 0},
            {['Label'] = "Ven aquí", ['Type'] = 'animation', ['Dict'] = 'gestures@m@standing@casual', ['Anim'] = 'gesture_come_here_soft', ['Flags'] = 0},
            {['Label'] = "Dale", ['Type'] = 'animation', ['Dict'] = 'gestures@m@standing@casual', ['Anim'] = 'gesture_bring_it_on', ['Flags'] = 0},
            {['Label'] = "Yo", ['Type'] = 'animation', ['Dict'] = 'gestures@m@standing@casual', ['Anim'] = 'gesture_me', ['Flags'] = 0},
            {['Label'] = "Lo sabía", ['Type'] = 'animation', ['Dict'] = 'anim@am_hold_up@male', ['Anim'] = 'shoplift_high', ['Flags'] = 0},
            {['Label'] = "Agotado", ['Type'] = 'scenario', ['Anim'] = 'idle_d'},
            {['Label'] = "Estoy en la mierda", ['Type'] = 'scenario', ['Anim'] = 'idle_a'},
            {['Label'] = "Facepalm", ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationmale@face_palm', ['Anim'] = 'face_palm', ['Flags'] = 0},
            {['Label'] = "Calma", ['Type'] = 'animation', ['Dict'] = 'gestures@m@standing@casual', ['Anim'] = 'gesture_easy_now', ['Flags'] = 0},
            {['Label'] = "¿Qué he hecho?", ['Type'] = 'animation', ['Dict'] = 'oddjobs@assassinate@multi@', ['Anim'] = 'react_big_variations_a', ['Flags'] = 0},
            {['Label'] = "Miedo", ['Type'] = 'animation', ['Dict'] = 'amb@code_human_cower_stand@male@react_cowering', ['Anim'] = 'base_right', ['Flags'] = 0},
            {['Label'] = "¿Pelea?", ['Type'] = 'animation', ['Dict'] = 'anim@deathmatch_intros@unarmed', ['Anim'] = 'intro_male_unarmed_e', ['Flags'] = 0},
            {['Label'] = "¡Imposible!", ['Type'] = 'animation', ['Dict'] = 'gestures@m@standing@casual', ['Anim'] = 'gesture_damn', ['Flags'] = 0},
            {['Label'] = "Abrazo", ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'kisses_guy_a', ['Flags'] = 0},
            {['Label'] = "Dedo de honor", ['Type'] = 'animation', ['Dict'] = 'mp_player_int_upperfinger', ['Anim'] = 'mp_player_int_finger_01_enter', ['Flags'] = 0},
            {['Label'] = "Idiota", ['Type'] = 'animation', ['Dict'] = 'mp_player_int_upperwank', ['Anim'] = 'mp_player_int_wank_01', ['Flags'] = 0},
            {['Label'] = "Suicidarse (bala en la cabeza)", ['Type'] = 'animation', ['Dict'] = 'mp_suicide', ['Anim'] = 'pistol', ['Flags'] = 0},
    
        }    
    },
    {
        
        ['Label'] = 'Deportes',
        ['Data'] = {
            {['Label'] = "Flexionar músculos", ['Type'] = 'animation', ['Dict'] = 'amb@world_human_muscle_flex@arms_at_side@base', ['Anim'] = 'base', ['Flags'] = 0},
            {['Label'] = "Hacer flexiones", ['Type'] = 'animation', ['Dict'] = 'amb@world_human_push_ups@male@base', ['Anim'] = 'base', ['Flags'] = 0},
            {['Label'] = "Hacer sentadillas", ['Type'] = 'animation', ['Dict'] = 'amb@world_human_sit_ups@male@base', ['Anim'] = 'base', ['Flags'] = 0},
            {['Label'] = "Hacer yoga", ['Type'] = 'animation', ['Dict'] = 'amb@world_human_yoga@male@base', ['Anim'] = 'base_a', ['Flags'] = 0},
    
        }    
    },
    {
        
        ['Label'] = 'Diversos',
        ['Data'] = {
            {['Label'] = "Beber café", ['Type'] = 'animation', ['Dict'] = 'amb@world_human_aa_coffee@idle_a', ['Anim'] = 'idle_a', ['Flags'] = 0},
            {['Label'] = "Sentarse", ['Type'] = 'animation', ['Dict'] = 'anim@heists@prison_heistunfinished_biztarget_idle', ['Anim'] = 'target_idle', ['Flags'] = 0},
            {['Label'] = "Escuchar a través", ['Type'] = 'scenario', ['Anim'] = 'world_human_leaning'},
            {['Label'] = "Tomar el sol de vuelta", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_SUNBATHE_BACK'},
            {['Label'] = "Tomar el sol de frente", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_SUNBATHE'},
            {['Label'] = "Limpiar", ['Type'] = 'scenario', ['Anim'] = 'world_human_maid_clean'},
            {['Label'] = "Barbacoa", ['Type'] = 'scenario', ['Anim'] = 'PROP_HUMAN_BBQ'},
            {['Label'] = "Buscar", ['Type'] = 'animation', ['Dict'] = 'mini@prostitutes@sexlow_veh', ['Anim'] = 'low_car_bj_to_prop_female', ['Flags'] = 0},
            {['Label'] = "Selfie", ['Type'] = 'scenario', ['Anim'] = 'world_human_tourist_mobile'},
            {['Label'] = "Escuchar pared/puerta", ['Type'] = 'animation', ['Dict'] = 'mini@safe_cracking', ['Anim'] = 'idle_base', ['Flags'] = 0},
    
        }    
    },
    {
        
        ['Label'] = 'Andares',
        ['Data'] = {
            {['Label'] = "Normal M", ['Type'] = 'walking_style', ['Style'] = 'move_m@confident'},
            {['Label'] = "Normal F", ['Type'] = 'walking_style', ['Style'] = 'move_f@heels@c'},
            {['Label'] = "Deprimido", ['Type'] = 'walking_style', ['Style'] = 'move_m@depressed@a'},
            {['Label'] = "Deprimida", ['Type'] = 'walking_style', ['Style'] = 'move_f@depressed@a'},
            {['Label'] = "Negocios", ['Type'] = 'walking_style', ['Style'] = 'move_m@business@a'},
            {['Label'] = "Determinado", ['Type'] = 'walking_style', ['Style'] = 'move_m@brave@a'},
            {['Label'] = "Casual", ['Type'] = 'walking_style', ['Style'] = 'move_m@casual@a'},
            {['Label'] = "He comido demasiado", ['Type'] = 'walking_style', ['Style'] = 'move_m@fat@a'},
            {['Label'] = "Hipster", ['Type'] = 'walking_style', ['Style'] = 'move_m@hipster@a'},
            {['Label'] = "Lesionado", ['Type'] = 'walking_style', ['Style'] = 'move_m@injured'},
            {['Label'] = "Apurado", ['Type'] = 'walking_style', ['Style'] = 'move_m@hurry@a'},
            {['Label'] = "Obrero", ['Type'] = 'walking_style', ['Style'] = 'move_m@hobo@a'},
            {['Label'] = "Triste", ['Type'] = 'walking_style', ['Style'] = 'move_m@sad@a'},
            {['Label'] = "Musculoso", ['Type'] = 'walking_style', ['Style'] = 'move_m@muscle@a'},
            {['Label'] = "En shock", ['Type'] = 'walking_style', ['Style'] = 'move_m@shocked@a'},
            {['Label'] = "Sombrío", ['Type'] = 'walking_style', ['Style'] = 'move_m@shadyped@a'},
            {['Label'] = "Zumbido", ['Type'] = 'walking_style', ['Style'] = 'move_m@buzzed'},
            {['Label'] = "Apurado", ['Type'] = 'walking_style', ['Style'] = 'move_m@hurry_butch@a'},
            {['Label'] = "Orgulloso", ['Type'] = 'walking_style', ['Style'] = 'move_m@money'},
            {['Label'] = "Carrera corta", ['Type'] = 'walking_style', ['Style'] = 'move_m@quick'},
            {['Label'] = "Come-hombres", ['Type'] = 'walking_style', ['Style'] = 'move_f@maneater'},
            {['Label'] = "Descarado", ['Type'] = 'walking_style', ['Style'] = 'move_f@sassy'},
            {['Label'] = "Arrogante", ['Type'] = 'walking_style', ['Style'] = 'move_f@arrogant@a'},
    
        }    
    },
    {
        
        ['Label'] = '+18',
        ['Data'] = {
            {['Label'] = "Hombre recibiendo en elcoche", ['Type'] = 'animation', ['Dict'] = 'oddjobs@towing', ['Anim'] = 'm_blow_job_loop', ['Flags'] = 0},
            {['Label'] = "Mujer dando en el coche", ['Type'] = 'animation', ['Dict'] = 'oddjobs@towing', ['Anim'] = 'f_blow_job_loop', ['Flags'] = 0},
            {['Label'] = "Hombre debajo en el coche", ['Type'] = 'animation', ['Dict'] = 'mini@prostitutes@sexlow_veh', ['Anim'] = 'low_car_sex_loop_player', ['Flags'] = 0},
            {['Label'] = "Mujer arriba en el coche", ['Type'] = 'animation', ['Dict'] = 'mini@prostitutes@sexlow_veh', ['Anim'] = 'low_car_sex_loop_female', ['Flags'] = 0},
            {['Label'] = "Nueces del rasguño", ['Type'] = 'animation', ['Dict'] = 'mp_player_int_uppergrab_crotch', ['Anim'] = 'mp_player_int_grab_crotch', ['Flags'] = 0},
            {['Label'] = "Prostituta 1", ['Type'] = 'animation', ['Dict'] = 'mini@strip_club@idles@stripper', ['Anim'] = 'stripper_idle_02', ['Flags'] = 0},
            {['Label'] = "Prostituta 2", ['Type'] = 'scenario', ['Anim'] = 'WORLD_HUMAN_PROSTITUTE_HIGH_CLASS'},
            {['Label'] = "Prostituta 3", ['Type'] = 'animation', ['Dict'] = 'mini@strip_club@backroom@', ['Anim'] = 'stripper_b_backroom_idle_b', ['Flags'] = 0},
            {['Label'] = "StripTease 1", ['Type'] = 'animation', ['Dict'] = 'mini@strip_club@lap_dance@ld_girl_a_song_a_p1', ['Anim'] = 'ld_girl_a_song_a_p1_f', ['Flags'] = 0},
            {['Label'] = "StripTease 2", ['Type'] = 'animation', ['Dict'] = 'mini@strip_club@private_dance@part2', ['Anim'] = 'priv_dance_p2', ['Flags'] = 0},
            {['Label'] = "StipTease de rodillas", ['Type'] = 'animation', ['Dict'] = 'mini@strip_club@private_dance@part3', ['Anim'] = 'priv_dance_p3', ['Flags'] = 0},
    
        }    
    },
    
}
