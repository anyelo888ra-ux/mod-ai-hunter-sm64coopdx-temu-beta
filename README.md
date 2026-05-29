# 💀 SM64 Coop DX: AI Hunter ULTRA Mod

¡Bienvenido al mod oficial de la **cO0lcompany** para **Super Mario 64 Coop DX**! Este script de Lua introduce un sistema de Inteligencia Artificial cazadora avanzada (Hunter ULTRA) que persigue a los jugadores a través de los niveles, se adapta a diferentes dificultades y desata el caos total lanzando a las víctimas por los aires.

---

## 🚀 Características Principales

* **🤖 Sistema de Caza Inteligente:** El Hunter selecciona objetivos conectados aleatoriamente y los persigue sin descanso.
* **💨 Sincronización de Niveles NATIVA:** Si intentas huir a otro mapa o entrar a un cuadro, el Hunter se teletransportará instantáneamente a tu misma área.
* **👻 Modo Fantasma (Atravesar Paredes):** Si la víctima se aleja demasiado, el Hunter se teletransporta cerca usando coordenadas aleatorias.
* **🚀 Ataque de Lanzamiento Extremo:** Al alcanzar a su objetivo, lo atrapa y lo lanza volando por los aires usando físicas masivas y la acción `ACT_THROWN_FORWARD`.
* **🎭 Menú de Dificultades Dinámico:** Sistema de velocidades y advertencias personalizadas en el chat según el nivel de amenaza elegido.

---

## 🛠️ Comandos del Chat

Activa y configura el mod directamente desde la consola de chat del juego con los siguientes comandos:

* `/hunter facil` -> ⚠️ El Hunter camina tranquilo... por ahora. (Velocidad baja).
* `/hunter normal` -> 💀 El cazador está al acecho de sus presas. (Velocidad estándar).
* `/hunter dificil` -> 🚨 ¡Hunter está furioso y te alcanzará rápido! (Velocidad alta).
* `/hunter ultra` -> 👹 **ERROR DE SISTEMA:** ¡El Hunter Ultra es imparable! ¡Corre por tu vida! (Velocidad extrema de 190).
* `/hunter` -> Desactiva el modo Hunter.

> 💡 **Nota:** También incluye el comando `/mario_ia` para activar el modo pacífico de exploración automática (Copilot), ideal para pruebas en el mapa sin agresividad.

---

## 📦 Instalación

1. Descarga el archivo de script `.lua` de este repositorio.
2. Copia el archivo en la carpeta de mods de tu cliente de **SM64 Coop DX**:
   `%appdata%/sm64ex-coop/mods/` (o la ruta correspondiente de tu instalación).
3. Inicia el juego, aloja un servidor cooperativo y asegúrate de habilitar el mod en la lista.
4. ¡Abre el chat y desata el caos!

---

## 🧑‍💻 Créditos y Desarrollo

* **Desarrollador Principal:** Angelo Ramirez (`c00lkidd_v2yt`)
* **Colaborador de Código:** Copilot AI & Gemini
* **Organización:** cO0lcompany Systems 🚀

*Este proyecto es un experimento de simulación y desarrollo en Lua para la comunidad de Super Mario 64.*

# AI Hunter Temu v1.1 - SM64 Coop DX Compatibility Update

## 🔄 Estado General
**Versión:** 1.1  
**Objetivo Principal:** Compatibilidad total con SM64 Coop DX v1.5  
**Estado:** 🟡 En Desarrollo Activo

---

## 📋 Cambios en SM64 Coop DX v1.5 (Problemas Identificados)

La actualización 1.5 de SM64 Coop DX introdujo cambios arquitectónicos significativos que rompieron:
- ❌ Movimiento del bot de IA
- ❌ Sistema de detección de jugadores
- ❌ Lógica de persecución y búsqueda
- ❌ Sincronización de red entre cliente-servidor
- ❌ Behavior scripts obsoletos

---

## ✨ Mejoras y Fixes en v1.1

### 1. **Restauración del Motor de Movimiento**
   - Reescribir las funciones de velocidad y aceleración del bot
   - Adaptar el sistema de colisiones a la nueva física de v1.5
   - Pruebas de movimiento fluido en diferentes terrenos

### 2. **Actualización de Detección de Jugadores**
   - Migrar del sistema antiguo de raycast a la nueva API de escaneo
   - Mejorar el rango de visión del bot
   - Agregar detección de múltiples jugadores simultáneos

### 3. **Reparación del Sistema de Persecución**
   - Recalcular la IA de pathfinding
   - Ajustar velocidad de seguimiento según dificultad
   - Evitar persecuciones infinitas o bugueadas

### 4. **Adaptación de Behavior Scripts**
   - Convertir scripts legados a la nueva API de eventos
   - Implementar hooks correctos para comunicación de red
   - Validar cada comportamiento (ataque, defensa, exploración)

### 5. **Prevención de Crashes y Errores de Networking**
   - Manejo robusto de excepciones
   - Sincronización de estado entre instancias
   - Logs detallados para debugging

---

## 🚀 Próximos Pasos

- [ ] Análisis completo del código de v1.5
- [ ] Implementación de cambios en el motor de movimiento
- [ ] Testing con un bot en modo single-player
- [ ] Testing multijugador (P2P / Server)
- [ ] Optimización de rendimiento
- [ ] Release de v1.1 stable

---

## 🤝 Contribuyentes
- **Angelo** (Creador Original)
- **Copilot Windows 11** (Asistencia de desarrollo)
- **[Tu nuevo developer]** (Desarrollo activo)

---

## 📝 Notas Técnicas
- Requiere SM64 Coop DX v1.5 o superior
- Compatible con roms modificadas y versiones de hack
- En caso de errores, reporta en Issues con logs del bot

---

## 📞 Soporte
¿Problemas con el AI Hunter? Abre un issue en GitHub o contacta al equipo de desarrollo.

