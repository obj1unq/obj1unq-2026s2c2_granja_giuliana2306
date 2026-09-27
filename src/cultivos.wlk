import wollok.game.*

class Maiz {
	var property position = game.center()
	var crecio = false

	method image() {
		return "maiz_" + self.nombreEstado() + ".png"
	}
	method  nombreEstado() {
		return if (self.crecio()) {
			"adulto"
		} else {
			"bebe"
		}
	}
	method crecio() {
		return crecio 
	}
	method regar(granja) {
		crecio = true
	}
	method sePuedeCosechar() {
		return crecio
	}
	method valor() {
		return 150
	}
}


class Trigo {
	var property position = game.center()
	var evolucion = 0

	method image() {
		return "trigo_" + evolucion + ".png"
	}
	method regar(granja) {
		if (evolucion == 3) {
			evolucion = 0
		} else {
			evolucion = evolucion + 1
		}
	}
	method sePuedeCosechar() {
		return evolucion >= 2
	}
	method valor() {
		return (evolucion - 1) * 100
	}
}

class Tomaco {
	var property position = game.center()

	method image() {
		return "tomaco.png"
	}

	method regar(granja) {
		if (granja.puedeOcupar(self.posicionSiguiente())) {
			self.position(self.posicionSiguiente())
		}
	}

	method posicionSiguiente() {
		return if (self.position().y() == game.height() - 1) {
			game.at(self.position().x(), 0)
		} else {
			game.at(self.position().x(), self.position().y() + 1)
		}
	}
	method sePuedeCosechar() {
		return true
	}
	method valor() {
		return 80
	}
}

