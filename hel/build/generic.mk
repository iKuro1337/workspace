ifeq ($(OS),Windows_NT)
SHELL = $(ComSpec)
RMDIR = rmdir /s /q
mymkdir = if not exist "$1" mkdir "$1"
else
RMDIR = rm -fr
mymkdir = mkdir -p $1
endif

PROJECT_OBJS = \
	generic4/project/hel.cpp.o \

PLATFORM_OBJS = \
	generic4/platform/cores/esp8266/abi.cpp.o \
	generic4/platform/cores/esp8266/base64.cpp.o \
	generic4/platform/cores/esp8266/CapacitiveSensor.cpp.o \
	generic4/platform/cores/esp8266/cbuf.cpp.o \
	generic4/platform/cores/esp8266/cont.S.o \
	generic4/platform/cores/esp8266/cont_util.c.o \
	generic4/platform/cores/esp8266/core_esp8266_eboot_command.c.o \
	generic4/platform/cores/esp8266/core_esp8266_flash_utils.c.o \
	generic4/platform/cores/esp8266/core_esp8266_i2s.c.o \
	generic4/platform/cores/esp8266/core_esp8266_main.cpp.o \
	generic4/platform/cores/esp8266/core_esp8266_noniso.c.o \
	generic4/platform/cores/esp8266/core_esp8266_phy.c.o \
	generic4/platform/cores/esp8266/core_esp8266_postmortem.c.o \
	generic4/platform/cores/esp8266/core_esp8266_si2c.c.o \
	generic4/platform/cores/esp8266/core_esp8266_timer.c.o \
	generic4/platform/cores/esp8266/core_esp8266_wiring.c.o \
	generic4/platform/cores/esp8266/core_esp8266_wiring_analog.c.o \
	generic4/platform/cores/esp8266/core_esp8266_wiring_digital.c.o \
	generic4/platform/cores/esp8266/core_esp8266_wiring_pulse.c.o \
	generic4/platform/cores/esp8266/core_esp8266_wiring_pwm.c.o \
	generic4/platform/cores/esp8266/core_esp8266_wiring_shift.c.o \
	generic4/platform/cores/esp8266/debug.cpp.o \
	generic4/platform/cores/esp8266/EEPROM.cpp.o \
	generic4/platform/cores/esp8266/Esp.cpp.o \
	generic4/platform/cores/esp8266/ESP8266HTTPUpdateServer.cpp.o \
	generic4/platform/cores/esp8266/ESP8266mDNS.cpp.o \
	generic4/platform/cores/esp8266/ESP8266WebServer.cpp.o \
	generic4/platform/cores/esp8266/ESP8266WiFi.cpp.o \
	generic4/platform/cores/esp8266/ESP8266WiFiAP.cpp.o \
	generic4/platform/cores/esp8266/ESP8266WiFiGeneric.cpp.o \
	generic4/platform/cores/esp8266/ESP8266WiFiMesh.cpp.o \
	generic4/platform/cores/esp8266/ESP8266WiFiMulti.cpp.o \
	generic4/platform/cores/esp8266/ESP8266WiFiScan.cpp.o \
	generic4/platform/cores/esp8266/ESP8266WiFiSTA.cpp.o \
	generic4/platform/cores/esp8266/FS.cpp.o \
	generic4/platform/cores/esp8266/HardwareSerial.cpp.o \
	generic4/platform/cores/esp8266/heap.c.o \
	generic4/platform/cores/esp8266/IPAddress.cpp.o \
	generic4/platform/cores/esp8266/libb64/cdecode.c.o \
	generic4/platform/cores/esp8266/libb64/cencode.c.o \
	generic4/platform/cores/esp8266/libc_replacements.c.o \
	generic4/platform/cores/esp8266/MD5Builder.cpp.o \
	generic4/platform/cores/esp8266/Parsing.cpp.o \
	generic4/platform/cores/esp8266/pgmspace.cpp.o \
	generic4/platform/cores/esp8266/Print.cpp.o \
	generic4/platform/cores/esp8266/spiffs/spiffs_cache.c.o \
	generic4/platform/cores/esp8266/spiffs/spiffs_check.c.o \
	generic4/platform/cores/esp8266/spiffs/spiffs_gc.c.o \
	generic4/platform/cores/esp8266/spiffs/spiffs_hydrogen.c.o \
	generic4/platform/cores/esp8266/spiffs/spiffs_nucleus.c.o \
	generic4/platform/cores/esp8266/spiffs_api.cpp.o \
	generic4/platform/cores/esp8266/spiffs_hal.cpp.o \
	generic4/platform/cores/esp8266/Stream.cpp.o \
	generic4/platform/cores/esp8266/StreamString.cpp.o \
	generic4/platform/cores/esp8266/time.c.o \
	generic4/platform/cores/esp8266/Tone.cpp.o \
	generic4/platform/cores/esp8266/uart.c.o \
	generic4/platform/cores/esp8266/umm_malloc/umm_malloc.c.o \
	generic4/platform/cores/esp8266/Updater.cpp.o \
	generic4/platform/cores/esp8266/WiFiClient.cpp.o \
	generic4/platform/cores/esp8266/WiFiClientSecure.cpp.o \
	generic4/platform/cores/esp8266/WiFiServer.cpp.o \
	generic4/platform/cores/esp8266/WiFiUdp.cpp.o \
	generic4/platform/cores/esp8266/Wire.cpp.o \
	generic4/platform/cores/esp8266/WMath.cpp.o \
	generic4/platform/cores/esp8266/WString.cpp.o \

LIBRARIES_OBJS = \

TARGETS = \
	generic4/hel.hex \

all: $(TARGETS)

generic4/hel.hex: generic4/hel.elf
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/esptool/0.4.8/esptool" -eo "d:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/bootloaders/eboot/eboot.elf" -bo "generic4/hel.bin" -bm dio -bf 40 -bz 512K -bs .text -bp 4096 -ec -eo "generic4/hel.elf" -bs .irom0.text -bs .text -bs .data -bs .rodata -bc -ec

generic4/hel.elf: $(PROJECT_OBJS) $(LIBRARIES_OBJS) generic4/core.a
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -g -w -Os -nostdlib -Wl,--no-check-sections -u call_user_start -Wl,-static "-Ld:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/lib" "-Ld:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/ld" "-Teagle.flash.512k64.ld" -Wl,--gc-sections -Wl,-wrap,system_restart_local -Wl,-wrap,register_chipv6_phy  -o "generic4/hel.elf" -Wl,--start-group $(PROJECT_OBJS) $(LIBRARIES_OBJS) "generic4/arduino.ar" -lm -lgcc -lhal -lphy -lpp -lnet80211 -llwip -lwpa -lcrypto -lmain -lwps -laxtls -lsmartconfig -lmesh -lwpa2 -Wl,--end-group  "-Lgeneric4"

generic4/core.a:	$(PLATFORM_OBJS)

clean:
	$(RMDIR) generic4

size:
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-size" -A "generic4/hel.elf"

generic4/project/hel.cpp.o: ../hel.cpp generic4/project/hel.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"

generic4/project/hel.cpp.d: ;

-include generic4/project/hel.cpp.d 


generic4/platform/cores/esp8266/abi.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/abi.cpp generic4/platform/cores/esp8266/abi.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/abi.cpp.d: ;

-include generic4/platform/cores/esp8266/abi.cpp.d

generic4/platform/cores/esp8266/base64.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/base64.cpp generic4/platform/cores/esp8266/base64.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/base64.cpp.d: ;

-include generic4/platform/cores/esp8266/base64.cpp.d

generic4/platform/cores/esp8266/CapacitiveSensor.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/CapacitiveSensor.cpp generic4/platform/cores/esp8266/CapacitiveSensor.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/CapacitiveSensor.cpp.d: ;

-include generic4/platform/cores/esp8266/CapacitiveSensor.cpp.d

generic4/platform/cores/esp8266/cbuf.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/cbuf.cpp generic4/platform/cores/esp8266/cbuf.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/cbuf.cpp.d: ;

-include generic4/platform/cores/esp8266/cbuf.cpp.d

generic4/platform/cores/esp8266/cont.S.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/cont.S
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -g -x assembler-with-cpp -MMD -mlongcalls -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/cont_util.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/cont_util.c generic4/platform/cores/esp8266/cont_util.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/cont_util.c.d: ;

-include generic4/platform/cores/esp8266/cont_util.c.d

generic4/platform/cores/esp8266/core_esp8266_eboot_command.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_eboot_command.c generic4/platform/cores/esp8266/core_esp8266_eboot_command.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_eboot_command.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_eboot_command.c.d

generic4/platform/cores/esp8266/core_esp8266_flash_utils.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_flash_utils.c generic4/platform/cores/esp8266/core_esp8266_flash_utils.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_flash_utils.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_flash_utils.c.d

generic4/platform/cores/esp8266/core_esp8266_i2s.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_i2s.c generic4/platform/cores/esp8266/core_esp8266_i2s.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_i2s.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_i2s.c.d

generic4/platform/cores/esp8266/core_esp8266_main.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_main.cpp generic4/platform/cores/esp8266/core_esp8266_main.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/core_esp8266_main.cpp.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_main.cpp.d

generic4/platform/cores/esp8266/core_esp8266_noniso.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_noniso.c generic4/platform/cores/esp8266/core_esp8266_noniso.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_noniso.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_noniso.c.d

generic4/platform/cores/esp8266/core_esp8266_phy.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_phy.c generic4/platform/cores/esp8266/core_esp8266_phy.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_phy.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_phy.c.d

generic4/platform/cores/esp8266/core_esp8266_postmortem.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_postmortem.c generic4/platform/cores/esp8266/core_esp8266_postmortem.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_postmortem.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_postmortem.c.d

generic4/platform/cores/esp8266/core_esp8266_si2c.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_si2c.c generic4/platform/cores/esp8266/core_esp8266_si2c.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_si2c.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_si2c.c.d

generic4/platform/cores/esp8266/core_esp8266_timer.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_timer.c generic4/platform/cores/esp8266/core_esp8266_timer.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_timer.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_timer.c.d

generic4/platform/cores/esp8266/core_esp8266_wiring.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_wiring.c generic4/platform/cores/esp8266/core_esp8266_wiring.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_wiring.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_wiring.c.d

generic4/platform/cores/esp8266/core_esp8266_wiring_analog.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_wiring_analog.c generic4/platform/cores/esp8266/core_esp8266_wiring_analog.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_wiring_analog.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_wiring_analog.c.d

generic4/platform/cores/esp8266/core_esp8266_wiring_digital.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_wiring_digital.c generic4/platform/cores/esp8266/core_esp8266_wiring_digital.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_wiring_digital.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_wiring_digital.c.d

generic4/platform/cores/esp8266/core_esp8266_wiring_pulse.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_wiring_pulse.c generic4/platform/cores/esp8266/core_esp8266_wiring_pulse.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_wiring_pulse.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_wiring_pulse.c.d

generic4/platform/cores/esp8266/core_esp8266_wiring_pwm.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_wiring_pwm.c generic4/platform/cores/esp8266/core_esp8266_wiring_pwm.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_wiring_pwm.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_wiring_pwm.c.d

generic4/platform/cores/esp8266/core_esp8266_wiring_shift.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_wiring_shift.c generic4/platform/cores/esp8266/core_esp8266_wiring_shift.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/core_esp8266_wiring_shift.c.d: ;

-include generic4/platform/cores/esp8266/core_esp8266_wiring_shift.c.d

generic4/platform/cores/esp8266/debug.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/debug.cpp generic4/platform/cores/esp8266/debug.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/debug.cpp.d: ;

-include generic4/platform/cores/esp8266/debug.cpp.d

generic4/platform/cores/esp8266/EEPROM.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/EEPROM.cpp generic4/platform/cores/esp8266/EEPROM.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/EEPROM.cpp.d: ;

-include generic4/platform/cores/esp8266/EEPROM.cpp.d

generic4/platform/cores/esp8266/Esp.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Esp.cpp generic4/platform/cores/esp8266/Esp.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/Esp.cpp.d: ;

-include generic4/platform/cores/esp8266/Esp.cpp.d

generic4/platform/cores/esp8266/ESP8266HTTPUpdateServer.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266HTTPUpdateServer.cpp generic4/platform/cores/esp8266/ESP8266HTTPUpdateServer.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/ESP8266HTTPUpdateServer.cpp.d: ;

-include generic4/platform/cores/esp8266/ESP8266HTTPUpdateServer.cpp.d

generic4/platform/cores/esp8266/ESP8266mDNS.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266mDNS.cpp generic4/platform/cores/esp8266/ESP8266mDNS.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/ESP8266mDNS.cpp.d: ;

-include generic4/platform/cores/esp8266/ESP8266mDNS.cpp.d

generic4/platform/cores/esp8266/ESP8266WebServer.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WebServer.cpp generic4/platform/cores/esp8266/ESP8266WebServer.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/ESP8266WebServer.cpp.d: ;

-include generic4/platform/cores/esp8266/ESP8266WebServer.cpp.d

generic4/platform/cores/esp8266/ESP8266WiFi.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFi.cpp generic4/platform/cores/esp8266/ESP8266WiFi.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/ESP8266WiFi.cpp.d: ;

-include generic4/platform/cores/esp8266/ESP8266WiFi.cpp.d

generic4/platform/cores/esp8266/ESP8266WiFiAP.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFiAP.cpp generic4/platform/cores/esp8266/ESP8266WiFiAP.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/ESP8266WiFiAP.cpp.d: ;

-include generic4/platform/cores/esp8266/ESP8266WiFiAP.cpp.d

generic4/platform/cores/esp8266/ESP8266WiFiGeneric.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFiGeneric.cpp generic4/platform/cores/esp8266/ESP8266WiFiGeneric.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/ESP8266WiFiGeneric.cpp.d: ;

-include generic4/platform/cores/esp8266/ESP8266WiFiGeneric.cpp.d

generic4/platform/cores/esp8266/ESP8266WiFiMesh.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFiMesh.cpp generic4/platform/cores/esp8266/ESP8266WiFiMesh.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/ESP8266WiFiMesh.cpp.d: ;

-include generic4/platform/cores/esp8266/ESP8266WiFiMesh.cpp.d

generic4/platform/cores/esp8266/ESP8266WiFiMulti.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFiMulti.cpp generic4/platform/cores/esp8266/ESP8266WiFiMulti.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/ESP8266WiFiMulti.cpp.d: ;

-include generic4/platform/cores/esp8266/ESP8266WiFiMulti.cpp.d

generic4/platform/cores/esp8266/ESP8266WiFiScan.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFiScan.cpp generic4/platform/cores/esp8266/ESP8266WiFiScan.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/ESP8266WiFiScan.cpp.d: ;

-include generic4/platform/cores/esp8266/ESP8266WiFiScan.cpp.d

generic4/platform/cores/esp8266/ESP8266WiFiSTA.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFiSTA.cpp generic4/platform/cores/esp8266/ESP8266WiFiSTA.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/ESP8266WiFiSTA.cpp.d: ;

-include generic4/platform/cores/esp8266/ESP8266WiFiSTA.cpp.d

generic4/platform/cores/esp8266/FS.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/FS.cpp generic4/platform/cores/esp8266/FS.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/FS.cpp.d: ;

-include generic4/platform/cores/esp8266/FS.cpp.d

generic4/platform/cores/esp8266/HardwareSerial.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/HardwareSerial.cpp generic4/platform/cores/esp8266/HardwareSerial.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/HardwareSerial.cpp.d: ;

-include generic4/platform/cores/esp8266/HardwareSerial.cpp.d

generic4/platform/cores/esp8266/heap.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/heap.c generic4/platform/cores/esp8266/heap.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/heap.c.d: ;

-include generic4/platform/cores/esp8266/heap.c.d

generic4/platform/cores/esp8266/IPAddress.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/IPAddress.cpp generic4/platform/cores/esp8266/IPAddress.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/IPAddress.cpp.d: ;

-include generic4/platform/cores/esp8266/IPAddress.cpp.d

generic4/platform/cores/esp8266/libb64/cdecode.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/libb64/cdecode.c generic4/platform/cores/esp8266/libb64/cdecode.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/libb64/cdecode.c.d: ;

-include generic4/platform/cores/esp8266/libb64/cdecode.c.d

generic4/platform/cores/esp8266/libb64/cencode.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/libb64/cencode.c generic4/platform/cores/esp8266/libb64/cencode.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/libb64/cencode.c.d: ;

-include generic4/platform/cores/esp8266/libb64/cencode.c.d

generic4/platform/cores/esp8266/libc_replacements.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/libc_replacements.c generic4/platform/cores/esp8266/libc_replacements.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/libc_replacements.c.d: ;

-include generic4/platform/cores/esp8266/libc_replacements.c.d

generic4/platform/cores/esp8266/MD5Builder.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/MD5Builder.cpp generic4/platform/cores/esp8266/MD5Builder.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/MD5Builder.cpp.d: ;

-include generic4/platform/cores/esp8266/MD5Builder.cpp.d

generic4/platform/cores/esp8266/Parsing.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Parsing.cpp generic4/platform/cores/esp8266/Parsing.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/Parsing.cpp.d: ;

-include generic4/platform/cores/esp8266/Parsing.cpp.d

generic4/platform/cores/esp8266/pgmspace.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/pgmspace.cpp generic4/platform/cores/esp8266/pgmspace.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/pgmspace.cpp.d: ;

-include generic4/platform/cores/esp8266/pgmspace.cpp.d

generic4/platform/cores/esp8266/Print.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Print.cpp generic4/platform/cores/esp8266/Print.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/Print.cpp.d: ;

-include generic4/platform/cores/esp8266/Print.cpp.d

generic4/platform/cores/esp8266/spiffs/spiffs_cache.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs/spiffs_cache.c generic4/platform/cores/esp8266/spiffs/spiffs_cache.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/spiffs/spiffs_cache.c.d: ;

-include generic4/platform/cores/esp8266/spiffs/spiffs_cache.c.d

generic4/platform/cores/esp8266/spiffs/spiffs_check.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs/spiffs_check.c generic4/platform/cores/esp8266/spiffs/spiffs_check.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/spiffs/spiffs_check.c.d: ;

-include generic4/platform/cores/esp8266/spiffs/spiffs_check.c.d

generic4/platform/cores/esp8266/spiffs/spiffs_gc.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs/spiffs_gc.c generic4/platform/cores/esp8266/spiffs/spiffs_gc.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/spiffs/spiffs_gc.c.d: ;

-include generic4/platform/cores/esp8266/spiffs/spiffs_gc.c.d

generic4/platform/cores/esp8266/spiffs/spiffs_hydrogen.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs/spiffs_hydrogen.c generic4/platform/cores/esp8266/spiffs/spiffs_hydrogen.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/spiffs/spiffs_hydrogen.c.d: ;

-include generic4/platform/cores/esp8266/spiffs/spiffs_hydrogen.c.d

generic4/platform/cores/esp8266/spiffs/spiffs_nucleus.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs/spiffs_nucleus.c generic4/platform/cores/esp8266/spiffs/spiffs_nucleus.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/spiffs/spiffs_nucleus.c.d: ;

-include generic4/platform/cores/esp8266/spiffs/spiffs_nucleus.c.d

generic4/platform/cores/esp8266/spiffs_api.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs_api.cpp generic4/platform/cores/esp8266/spiffs_api.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/spiffs_api.cpp.d: ;

-include generic4/platform/cores/esp8266/spiffs_api.cpp.d

generic4/platform/cores/esp8266/spiffs_hal.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs_hal.cpp generic4/platform/cores/esp8266/spiffs_hal.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/spiffs_hal.cpp.d: ;

-include generic4/platform/cores/esp8266/spiffs_hal.cpp.d

generic4/platform/cores/esp8266/Stream.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Stream.cpp generic4/platform/cores/esp8266/Stream.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/Stream.cpp.d: ;

-include generic4/platform/cores/esp8266/Stream.cpp.d

generic4/platform/cores/esp8266/StreamString.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/StreamString.cpp generic4/platform/cores/esp8266/StreamString.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/StreamString.cpp.d: ;

-include generic4/platform/cores/esp8266/StreamString.cpp.d

generic4/platform/cores/esp8266/time.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/time.c generic4/platform/cores/esp8266/time.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/time.c.d: ;

-include generic4/platform/cores/esp8266/time.c.d

generic4/platform/cores/esp8266/Tone.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Tone.cpp generic4/platform/cores/esp8266/Tone.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/Tone.cpp.d: ;

-include generic4/platform/cores/esp8266/Tone.cpp.d

generic4/platform/cores/esp8266/uart.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/uart.c generic4/platform/cores/esp8266/uart.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/uart.c.d: ;

-include generic4/platform/cores/esp8266/uart.c.d

generic4/platform/cores/esp8266/umm_malloc/umm_malloc.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/umm_malloc/umm_malloc.c generic4/platform/cores/esp8266/umm_malloc/umm_malloc.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"
	
generic4/platform/cores/esp8266/umm_malloc/umm_malloc.c.d: ;

-include generic4/platform/cores/esp8266/umm_malloc/umm_malloc.c.d

generic4/platform/cores/esp8266/Updater.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Updater.cpp generic4/platform/cores/esp8266/Updater.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/Updater.cpp.d: ;

-include generic4/platform/cores/esp8266/Updater.cpp.d

generic4/platform/cores/esp8266/WiFiClient.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/WiFiClient.cpp generic4/platform/cores/esp8266/WiFiClient.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/WiFiClient.cpp.d: ;

-include generic4/platform/cores/esp8266/WiFiClient.cpp.d

generic4/platform/cores/esp8266/WiFiClientSecure.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/WiFiClientSecure.cpp generic4/platform/cores/esp8266/WiFiClientSecure.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/WiFiClientSecure.cpp.d: ;

-include generic4/platform/cores/esp8266/WiFiClientSecure.cpp.d

generic4/platform/cores/esp8266/WiFiServer.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/WiFiServer.cpp generic4/platform/cores/esp8266/WiFiServer.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/WiFiServer.cpp.d: ;

-include generic4/platform/cores/esp8266/WiFiServer.cpp.d

generic4/platform/cores/esp8266/WiFiUdp.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/WiFiUdp.cpp generic4/platform/cores/esp8266/WiFiUdp.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/WiFiUdp.cpp.d: ;

-include generic4/platform/cores/esp8266/WiFiUdp.cpp.d

generic4/platform/cores/esp8266/Wire.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Wire.cpp generic4/platform/cores/esp8266/Wire.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/Wire.cpp.d: ;

-include generic4/platform/cores/esp8266/Wire.cpp.d

generic4/platform/cores/esp8266/WMath.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/WMath.cpp generic4/platform/cores/esp8266/WMath.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/WMath.cpp.d: ;

-include generic4/platform/cores/esp8266/WMath.cpp.d

generic4/platform/cores/esp8266/WString.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/WString.cpp generic4/platform/cores/esp8266/WString.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic4/arduino.ar" "$@"

generic4/platform/cores/esp8266/WString.cpp.d: ;

-include generic4/platform/cores/esp8266/WString.cpp.d


