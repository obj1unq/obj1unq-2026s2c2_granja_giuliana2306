import wollok.game.*

object femenino{
	method prefijo() {
		return "f"
	}
	method otro() {
		return masculino
	}
}
object masculino{
	method prefijo() {
		return "m"
	}
	method otro() {
		return femenino
	}
}

object personaje {
	var property genero = femenino
	var property position = game.center()
	const propiedad = granja
	
	method  image() {
		return genero.prefijo() + "-player-" + self.estado() + ".png"
	} 
	method estado() {
		return if (self.estaSobreAlgo())  "abajo" else "normal" 
	}
	method estaSobreAlgo() {
		return not game.colliders(self).isEmpty()
	}
	method cambiarGenero() {
		genero = genero.otro()
	}

	method plantar(cultivo) {
		propiedad.plantar(cultivo, self.position())
	}
	method regar() {
		self.validarRegar()
		granja.cultivoEn(self.position()).regar(granja)
    }
	method validarRegar(){
		if (not granja.hayCultivo(self.position())) {
			self.error("no tengo nada para regar")
		}
	}
	method cosechar() {
        var cultivo = granja.cultivoEn(self.position())
        self.validarCosechar()
        granja.agregarPlantaCosechada(cultivo)
        game.removeVisual(cultivo)
    }
	method validarCosechar() {
		if (not granja.hayCultivo(self.position()) || 
		    not granja.cultivoEn(self.position()).sePuedeCosechar()) {
				self.error("No se puede cosechar")
			}
	}
	
	method informarVenta() {
		game.say(self, "Tengo " + granja.cantidadDeCosecha() + " plantas para vender por " + granja.oroPorVenta() + 
		                " monedas ")
	}
	method text() {
		return "Tengo" + granja.totalDeOro() + "monedas"
	}
}

object mercado {
	const property position = game.at(5,5)
	const property image = "mercado.png"
}



object granja {
	const property cultivos = #{}
	var plantasCosechadas = []
	var oroObtenido = 0

	method plantar(cultivo, position) {
		self.validarPlantar(cultivo, position)
		cultivo.position(position)
		cultivos.add(cultivo)
		game.addVisual(cultivo)
	}
	method validarPlantar(cultivo, position) {
		if (not self.puedePlantar(cultivo, position)) {
			self.error("No se puede plantar")
		}
	}
	method puedePlantar(cultivo, position) {
		return self.puedeOcupar(position)
    }
	method hayCultivo(position) {
		return cultivos.any({cultivo => cultivo.position() == position})
	}
	method cultivoEn(position) {
		return cultivos.find({cultivo => cultivo.position() == position})
    }
	method agregarPlantaCosechada(cultivo) {
		plantasCosechadas.add(cultivo)
		cultivos.remove(cultivo)
	}
	method cultivosCosechados() {
		return plantasCosechadas

    } method venderTodo() {
		oroObtenido = oroObtenido + self.oroPorVenta()
		plantasCosechadas.clear()
	}
	method cantidadDeCosecha() {
		return plantasCosechadas.size()
	}
	method oroPorVenta() {
		return plantasCosechadas.sum({planta => planta.valor()})
	}
	method totalDeOro() {
		return oroObtenido
	}
	method puedeOcupar(position) {
		return not self.hayCultivo(position) && position != mercado.position()
    }
}

object objetoParaPrueba {
    var property position = game.center()
}