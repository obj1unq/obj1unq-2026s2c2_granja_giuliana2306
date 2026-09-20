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
	method regar() {
		crecio = true
	}
}


class Trigo {
	var property position = game.center()
	var evolucion = 0

	method image() {
		return "trigo_" + evolucion + ".png"
	}
	method regar() {
		if (evolucion == 3) {
			evolucion = 0
		} else {
			evolucion = evolucion + 1
		}
	}
}

class Tomaco {
	var property position = game.center()

	method image() {
		return "tomaco.png"
	}
	method regar() {
    if (self.position().y() == game.height() - 1) {
        self.position(game.at(self.position().x(), 0))
    } else {
        self.position(game.at(self.position().x(), self.position().y() + 1))
    }
}
}

