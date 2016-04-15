ifeq ($(OS),Windows_NT)
SHELL = $(ComSpec)
RMDIR = rmdir /s /q
mymkdir = if not exist "$1" mkdir "$1"
else
RMDIR = rm -fr
mymkdir = mkdir -p $1
endif

PROJECT_OBJS = \
	generic/project/BH1750.cpp.o \
	generic/project/LUX.cpp.o \

PLATFORM_OBJS = \
	generic/platform/cores/esp8266/abi.cpp.o \
	generic/platform/cores/esp8266/base64.cpp.o \
	generic/platform/cores/esp8266/CapacitiveSensor.cpp.o \
	generic/platform/cores/esp8266/cbuf.cpp.o \
	generic/platform/cores/esp8266/cont.S.o \
	generic/platform/cores/esp8266/cont_util.c.o \
	generic/platform/cores/esp8266/core_esp8266_eboot_command.c.o \
	generic/platform/cores/esp8266/core_esp8266_flash_utils.c.o \
	generic/platform/cores/esp8266/core_esp8266_i2s.c.o \
	generic/platform/cores/esp8266/core_esp8266_main.cpp.o \
	generic/platform/cores/esp8266/core_esp8266_noniso.c.o \
	generic/platform/cores/esp8266/core_esp8266_phy.c.o \
	generic/platform/cores/esp8266/core_esp8266_postmortem.c.o \
	generic/platform/cores/esp8266/core_esp8266_si2c.c.o \
	generic/platform/cores/esp8266/core_esp8266_timer.c.o \
	generic/platform/cores/esp8266/core_esp8266_wiring.c.o \
	generic/platform/cores/esp8266/core_esp8266_wiring_analog.c.o \
	generic/platform/cores/esp8266/core_esp8266_wiring_digital.c.o \
	generic/platform/cores/esp8266/core_esp8266_wiring_pulse.c.o \
	generic/platform/cores/esp8266/core_esp8266_wiring_pwm.c.o \
	generic/platform/cores/esp8266/core_esp8266_wiring_shift.c.o \
	generic/platform/cores/esp8266/debug.cpp.o \
	generic/platform/cores/esp8266/EEPROM.cpp.o \
	generic/platform/cores/esp8266/Esp.cpp.o \
	generic/platform/cores/esp8266/ESP8266HTTPUpdateServer.cpp.o \
	generic/platform/cores/esp8266/ESP8266mDNS.cpp.o \
	generic/platform/cores/esp8266/ESP8266WebServer.cpp.o \
	generic/platform/cores/esp8266/ESP8266WiFi.cpp.o \
	generic/platform/cores/esp8266/ESP8266WiFiAP.cpp.o \
	generic/platform/cores/esp8266/ESP8266WiFiGeneric.cpp.o \
	generic/platform/cores/esp8266/ESP8266WiFiMesh.cpp.o \
	generic/platform/cores/esp8266/ESP8266WiFiMulti.cpp.o \
	generic/platform/cores/esp8266/ESP8266WiFiScan.cpp.o \
	generic/platform/cores/esp8266/ESP8266WiFiSTA.cpp.o \
	generic/platform/cores/esp8266/FS.cpp.o \
	generic/platform/cores/esp8266/HardwareSerial.cpp.o \
	generic/platform/cores/esp8266/heap.c.o \
	generic/platform/cores/esp8266/IPAddress.cpp.o \
	generic/platform/cores/esp8266/libb64/cdecode.c.o \
	generic/platform/cores/esp8266/libb64/cencode.c.o \
	generic/platform/cores/esp8266/libc_replacements.c.o \
	generic/platform/cores/esp8266/MD5Builder.cpp.o \
	generic/platform/cores/esp8266/Parsing.cpp.o \
	generic/platform/cores/esp8266/pgmspace.cpp.o \
	generic/platform/cores/esp8266/Print.cpp.o \
	generic/platform/cores/esp8266/spiffs/spiffs_cache.c.o \
	generic/platform/cores/esp8266/spiffs/spiffs_check.c.o \
	generic/platform/cores/esp8266/spiffs/spiffs_gc.c.o \
	generic/platform/cores/esp8266/spiffs/spiffs_hydrogen.c.o \
	generic/platform/cores/esp8266/spiffs/spiffs_nucleus.c.o \
	generic/platform/cores/esp8266/spiffs_api.cpp.o \
	generic/platform/cores/esp8266/spiffs_hal.cpp.o \
	generic/platform/cores/esp8266/Stream.cpp.o \
	generic/platform/cores/esp8266/StreamString.cpp.o \
	generic/platform/cores/esp8266/time.c.o \
	generic/platform/cores/esp8266/Tone.cpp.o \
	generic/platform/cores/esp8266/uart.c.o \
	generic/platform/cores/esp8266/umm_malloc/umm_malloc.c.o \
	generic/platform/cores/esp8266/Updater.cpp.o \
	generic/platform/cores/esp8266/WiFiClient.cpp.o \
	generic/platform/cores/esp8266/WiFiClientSecure.cpp.o \
	generic/platform/cores/esp8266/WiFiServer.cpp.o \
	generic/platform/cores/esp8266/WiFiUdp.cpp.o \
	generic/platform/cores/esp8266/Wire.cpp.o \
	generic/platform/cores/esp8266/WMath.cpp.o \
	generic/platform/cores/esp8266/WString.cpp.o \

LIBRARIES_OBJS = \

TARGETS = \
	generic/LUX.hex \

all: $(TARGETS)

generic/LUX.hex: generic/LUX.elf
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/esptool/0.4.8/esptool" -eo "d:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/bootloaders/eboot/eboot.elf" -bo "generic/LUX.bin" -bm dio -bf 40 -bz 512K -bs .text -bp 4096 -ec -eo "generic/LUX.elf" -bs .irom0.text -bs .text -bs .data -bs .rodata -bc -ec

generic/LUX.elf: $(PROJECT_OBJS) $(LIBRARIES_OBJS) generic/core.a
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -g -w -Os -nostdlib -Wl,--no-check-sections -u call_user_start -Wl,-static "-Ld:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/lib" "-Ld:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/ld" "-Teagle.flash.512k64.ld" -Wl,--gc-sections -Wl,-wrap,system_restart_local -Wl,-wrap,register_chipv6_phy  -o "generic/LUX.elf" -Wl,--start-group $(PROJECT_OBJS) $(LIBRARIES_OBJS) "generic/arduino.ar" -lm -lgcc -lhal -lphy -lpp -lnet80211 -llwip -lwpa -lcrypto -lmain -lwps -laxtls -lsmartconfig -lmesh -lwpa2 -Wl,--end-group  "-Lgeneric"

generic/core.a:	$(PLATFORM_OBJS)

clean:
	$(RMDIR) generic

size:
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-size" -A "generic/LUX.elf"

generic/project/BH1750.cpp.o: ../BH1750.cpp generic/project/BH1750.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"

generic/project/BH1750.cpp.d: ;

-include generic/project/BH1750.cpp.d 

generic/project/LUX.cpp.o: ../LUX.cpp generic/project/LUX.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"

generic/project/LUX.cpp.d: ;

-include generic/project/LUX.cpp.d 


generic/platform/cores/esp8266/abi.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/abi.cpp generic/platform/cores/esp8266/abi.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/abi.cpp.d: ;

-include generic/platform/cores/esp8266/abi.cpp.d

generic/platform/cores/esp8266/base64.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/base64.cpp generic/platform/cores/esp8266/base64.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/base64.cpp.d: ;

-include generic/platform/cores/esp8266/base64.cpp.d

generic/platform/cores/esp8266/CapacitiveSensor.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/CapacitiveSensor.cpp generic/platform/cores/esp8266/CapacitiveSensor.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/CapacitiveSensor.cpp.d: ;

-include generic/platform/cores/esp8266/CapacitiveSensor.cpp.d

generic/platform/cores/esp8266/cbuf.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/cbuf.cpp generic/platform/cores/esp8266/cbuf.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/cbuf.cpp.d: ;

-include generic/platform/cores/esp8266/cbuf.cpp.d

generic/platform/cores/esp8266/cont.S.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/cont.S
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -g -x assembler-with-cpp -MMD -mlongcalls -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/cont_util.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/cont_util.c generic/platform/cores/esp8266/cont_util.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/cont_util.c.d: ;

-include generic/platform/cores/esp8266/cont_util.c.d

generic/platform/cores/esp8266/core_esp8266_eboot_command.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_eboot_command.c generic/platform/cores/esp8266/core_esp8266_eboot_command.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_eboot_command.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_eboot_command.c.d

generic/platform/cores/esp8266/core_esp8266_flash_utils.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_flash_utils.c generic/platform/cores/esp8266/core_esp8266_flash_utils.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_flash_utils.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_flash_utils.c.d

generic/platform/cores/esp8266/core_esp8266_i2s.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_i2s.c generic/platform/cores/esp8266/core_esp8266_i2s.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_i2s.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_i2s.c.d

generic/platform/cores/esp8266/core_esp8266_main.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_main.cpp generic/platform/cores/esp8266/core_esp8266_main.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/core_esp8266_main.cpp.d: ;

-include generic/platform/cores/esp8266/core_esp8266_main.cpp.d

generic/platform/cores/esp8266/core_esp8266_noniso.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_noniso.c generic/platform/cores/esp8266/core_esp8266_noniso.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_noniso.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_noniso.c.d

generic/platform/cores/esp8266/core_esp8266_phy.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_phy.c generic/platform/cores/esp8266/core_esp8266_phy.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_phy.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_phy.c.d

generic/platform/cores/esp8266/core_esp8266_postmortem.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_postmortem.c generic/platform/cores/esp8266/core_esp8266_postmortem.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_postmortem.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_postmortem.c.d

generic/platform/cores/esp8266/core_esp8266_si2c.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_si2c.c generic/platform/cores/esp8266/core_esp8266_si2c.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_si2c.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_si2c.c.d

generic/platform/cores/esp8266/core_esp8266_timer.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_timer.c generic/platform/cores/esp8266/core_esp8266_timer.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_timer.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_timer.c.d

generic/platform/cores/esp8266/core_esp8266_wiring.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_wiring.c generic/platform/cores/esp8266/core_esp8266_wiring.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_wiring.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_wiring.c.d

generic/platform/cores/esp8266/core_esp8266_wiring_analog.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_wiring_analog.c generic/platform/cores/esp8266/core_esp8266_wiring_analog.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_wiring_analog.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_wiring_analog.c.d

generic/platform/cores/esp8266/core_esp8266_wiring_digital.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_wiring_digital.c generic/platform/cores/esp8266/core_esp8266_wiring_digital.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_wiring_digital.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_wiring_digital.c.d

generic/platform/cores/esp8266/core_esp8266_wiring_pulse.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_wiring_pulse.c generic/platform/cores/esp8266/core_esp8266_wiring_pulse.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_wiring_pulse.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_wiring_pulse.c.d

generic/platform/cores/esp8266/core_esp8266_wiring_pwm.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_wiring_pwm.c generic/platform/cores/esp8266/core_esp8266_wiring_pwm.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_wiring_pwm.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_wiring_pwm.c.d

generic/platform/cores/esp8266/core_esp8266_wiring_shift.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/core_esp8266_wiring_shift.c generic/platform/cores/esp8266/core_esp8266_wiring_shift.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/core_esp8266_wiring_shift.c.d: ;

-include generic/platform/cores/esp8266/core_esp8266_wiring_shift.c.d

generic/platform/cores/esp8266/debug.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/debug.cpp generic/platform/cores/esp8266/debug.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/debug.cpp.d: ;

-include generic/platform/cores/esp8266/debug.cpp.d

generic/platform/cores/esp8266/EEPROM.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/EEPROM.cpp generic/platform/cores/esp8266/EEPROM.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/EEPROM.cpp.d: ;

-include generic/platform/cores/esp8266/EEPROM.cpp.d

generic/platform/cores/esp8266/Esp.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Esp.cpp generic/platform/cores/esp8266/Esp.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/Esp.cpp.d: ;

-include generic/platform/cores/esp8266/Esp.cpp.d

generic/platform/cores/esp8266/ESP8266HTTPUpdateServer.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266HTTPUpdateServer.cpp generic/platform/cores/esp8266/ESP8266HTTPUpdateServer.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/ESP8266HTTPUpdateServer.cpp.d: ;

-include generic/platform/cores/esp8266/ESP8266HTTPUpdateServer.cpp.d

generic/platform/cores/esp8266/ESP8266mDNS.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266mDNS.cpp generic/platform/cores/esp8266/ESP8266mDNS.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/ESP8266mDNS.cpp.d: ;

-include generic/platform/cores/esp8266/ESP8266mDNS.cpp.d

generic/platform/cores/esp8266/ESP8266WebServer.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WebServer.cpp generic/platform/cores/esp8266/ESP8266WebServer.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/ESP8266WebServer.cpp.d: ;

-include generic/platform/cores/esp8266/ESP8266WebServer.cpp.d

generic/platform/cores/esp8266/ESP8266WiFi.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFi.cpp generic/platform/cores/esp8266/ESP8266WiFi.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/ESP8266WiFi.cpp.d: ;

-include generic/platform/cores/esp8266/ESP8266WiFi.cpp.d

generic/platform/cores/esp8266/ESP8266WiFiAP.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFiAP.cpp generic/platform/cores/esp8266/ESP8266WiFiAP.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/ESP8266WiFiAP.cpp.d: ;

-include generic/platform/cores/esp8266/ESP8266WiFiAP.cpp.d

generic/platform/cores/esp8266/ESP8266WiFiGeneric.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFiGeneric.cpp generic/platform/cores/esp8266/ESP8266WiFiGeneric.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/ESP8266WiFiGeneric.cpp.d: ;

-include generic/platform/cores/esp8266/ESP8266WiFiGeneric.cpp.d

generic/platform/cores/esp8266/ESP8266WiFiMesh.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFiMesh.cpp generic/platform/cores/esp8266/ESP8266WiFiMesh.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/ESP8266WiFiMesh.cpp.d: ;

-include generic/platform/cores/esp8266/ESP8266WiFiMesh.cpp.d

generic/platform/cores/esp8266/ESP8266WiFiMulti.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFiMulti.cpp generic/platform/cores/esp8266/ESP8266WiFiMulti.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/ESP8266WiFiMulti.cpp.d: ;

-include generic/platform/cores/esp8266/ESP8266WiFiMulti.cpp.d

generic/platform/cores/esp8266/ESP8266WiFiScan.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFiScan.cpp generic/platform/cores/esp8266/ESP8266WiFiScan.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/ESP8266WiFiScan.cpp.d: ;

-include generic/platform/cores/esp8266/ESP8266WiFiScan.cpp.d

generic/platform/cores/esp8266/ESP8266WiFiSTA.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/ESP8266WiFiSTA.cpp generic/platform/cores/esp8266/ESP8266WiFiSTA.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/ESP8266WiFiSTA.cpp.d: ;

-include generic/platform/cores/esp8266/ESP8266WiFiSTA.cpp.d

generic/platform/cores/esp8266/FS.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/FS.cpp generic/platform/cores/esp8266/FS.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/FS.cpp.d: ;

-include generic/platform/cores/esp8266/FS.cpp.d

generic/platform/cores/esp8266/HardwareSerial.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/HardwareSerial.cpp generic/platform/cores/esp8266/HardwareSerial.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/HardwareSerial.cpp.d: ;

-include generic/platform/cores/esp8266/HardwareSerial.cpp.d

generic/platform/cores/esp8266/heap.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/heap.c generic/platform/cores/esp8266/heap.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/heap.c.d: ;

-include generic/platform/cores/esp8266/heap.c.d

generic/platform/cores/esp8266/IPAddress.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/IPAddress.cpp generic/platform/cores/esp8266/IPAddress.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/IPAddress.cpp.d: ;

-include generic/platform/cores/esp8266/IPAddress.cpp.d

generic/platform/cores/esp8266/libb64/cdecode.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/libb64/cdecode.c generic/platform/cores/esp8266/libb64/cdecode.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/libb64/cdecode.c.d: ;

-include generic/platform/cores/esp8266/libb64/cdecode.c.d

generic/platform/cores/esp8266/libb64/cencode.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/libb64/cencode.c generic/platform/cores/esp8266/libb64/cencode.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/libb64/cencode.c.d: ;

-include generic/platform/cores/esp8266/libb64/cencode.c.d

generic/platform/cores/esp8266/libc_replacements.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/libc_replacements.c generic/platform/cores/esp8266/libc_replacements.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/libc_replacements.c.d: ;

-include generic/platform/cores/esp8266/libc_replacements.c.d

generic/platform/cores/esp8266/MD5Builder.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/MD5Builder.cpp generic/platform/cores/esp8266/MD5Builder.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/MD5Builder.cpp.d: ;

-include generic/platform/cores/esp8266/MD5Builder.cpp.d

generic/platform/cores/esp8266/Parsing.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Parsing.cpp generic/platform/cores/esp8266/Parsing.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/Parsing.cpp.d: ;

-include generic/platform/cores/esp8266/Parsing.cpp.d

generic/platform/cores/esp8266/pgmspace.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/pgmspace.cpp generic/platform/cores/esp8266/pgmspace.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/pgmspace.cpp.d: ;

-include generic/platform/cores/esp8266/pgmspace.cpp.d

generic/platform/cores/esp8266/Print.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Print.cpp generic/platform/cores/esp8266/Print.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/Print.cpp.d: ;

-include generic/platform/cores/esp8266/Print.cpp.d

generic/platform/cores/esp8266/spiffs/spiffs_cache.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs/spiffs_cache.c generic/platform/cores/esp8266/spiffs/spiffs_cache.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/spiffs/spiffs_cache.c.d: ;

-include generic/platform/cores/esp8266/spiffs/spiffs_cache.c.d

generic/platform/cores/esp8266/spiffs/spiffs_check.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs/spiffs_check.c generic/platform/cores/esp8266/spiffs/spiffs_check.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/spiffs/spiffs_check.c.d: ;

-include generic/platform/cores/esp8266/spiffs/spiffs_check.c.d

generic/platform/cores/esp8266/spiffs/spiffs_gc.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs/spiffs_gc.c generic/platform/cores/esp8266/spiffs/spiffs_gc.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/spiffs/spiffs_gc.c.d: ;

-include generic/platform/cores/esp8266/spiffs/spiffs_gc.c.d

generic/platform/cores/esp8266/spiffs/spiffs_hydrogen.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs/spiffs_hydrogen.c generic/platform/cores/esp8266/spiffs/spiffs_hydrogen.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/spiffs/spiffs_hydrogen.c.d: ;

-include generic/platform/cores/esp8266/spiffs/spiffs_hydrogen.c.d

generic/platform/cores/esp8266/spiffs/spiffs_nucleus.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs/spiffs_nucleus.c generic/platform/cores/esp8266/spiffs/spiffs_nucleus.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/spiffs/spiffs_nucleus.c.d: ;

-include generic/platform/cores/esp8266/spiffs/spiffs_nucleus.c.d

generic/platform/cores/esp8266/spiffs_api.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs_api.cpp generic/platform/cores/esp8266/spiffs_api.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/spiffs_api.cpp.d: ;

-include generic/platform/cores/esp8266/spiffs_api.cpp.d

generic/platform/cores/esp8266/spiffs_hal.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/spiffs_hal.cpp generic/platform/cores/esp8266/spiffs_hal.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/spiffs_hal.cpp.d: ;

-include generic/platform/cores/esp8266/spiffs_hal.cpp.d

generic/platform/cores/esp8266/Stream.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Stream.cpp generic/platform/cores/esp8266/Stream.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/Stream.cpp.d: ;

-include generic/platform/cores/esp8266/Stream.cpp.d

generic/platform/cores/esp8266/StreamString.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/StreamString.cpp generic/platform/cores/esp8266/StreamString.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/StreamString.cpp.d: ;

-include generic/platform/cores/esp8266/StreamString.cpp.d

generic/platform/cores/esp8266/time.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/time.c generic/platform/cores/esp8266/time.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/time.c.d: ;

-include generic/platform/cores/esp8266/time.c.d

generic/platform/cores/esp8266/Tone.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Tone.cpp generic/platform/cores/esp8266/Tone.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/Tone.cpp.d: ;

-include generic/platform/cores/esp8266/Tone.cpp.d

generic/platform/cores/esp8266/uart.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/uart.c generic/platform/cores/esp8266/uart.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/uart.c.d: ;

-include generic/platform/cores/esp8266/uart.c.d

generic/platform/cores/esp8266/umm_malloc/umm_malloc.c.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/umm_malloc/umm_malloc.c generic/platform/cores/esp8266/umm_malloc/umm_malloc.c.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -MMD -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"
	
generic/platform/cores/esp8266/umm_malloc/umm_malloc.c.d: ;

-include generic/platform/cores/esp8266/umm_malloc/umm_malloc.c.d

generic/platform/cores/esp8266/Updater.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Updater.cpp generic/platform/cores/esp8266/Updater.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/Updater.cpp.d: ;

-include generic/platform/cores/esp8266/Updater.cpp.d

generic/platform/cores/esp8266/WiFiClient.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/WiFiClient.cpp generic/platform/cores/esp8266/WiFiClient.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/WiFiClient.cpp.d: ;

-include generic/platform/cores/esp8266/WiFiClient.cpp.d

generic/platform/cores/esp8266/WiFiClientSecure.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/WiFiClientSecure.cpp generic/platform/cores/esp8266/WiFiClientSecure.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/WiFiClientSecure.cpp.d: ;

-include generic/platform/cores/esp8266/WiFiClientSecure.cpp.d

generic/platform/cores/esp8266/WiFiServer.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/WiFiServer.cpp generic/platform/cores/esp8266/WiFiServer.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/WiFiServer.cpp.d: ;

-include generic/platform/cores/esp8266/WiFiServer.cpp.d

generic/platform/cores/esp8266/WiFiUdp.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/WiFiUdp.cpp generic/platform/cores/esp8266/WiFiUdp.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/WiFiUdp.cpp.d: ;

-include generic/platform/cores/esp8266/WiFiUdp.cpp.d

generic/platform/cores/esp8266/Wire.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/Wire.cpp generic/platform/cores/esp8266/Wire.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/Wire.cpp.d: ;

-include generic/platform/cores/esp8266/Wire.cpp.d

generic/platform/cores/esp8266/WMath.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/WMath.cpp generic/platform/cores/esp8266/WMath.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/WMath.cpp.d: ;

-include generic/platform/cores/esp8266/WMath.cpp.d

generic/platform/cores/esp8266/WString.cpp.o: d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266/WString.cpp generic/platform/cores/esp8266/WString.cpp.d
	@$(call mymkdir,$(dir $@))
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-g++" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-Id:\Users\simtech\.arduinocdt\packages\esp8266\hardware\esp8266\esp8266\2.1.0/tools/sdk/include" -c -w -Os -g -mlongcalls -mtext-section-literals -fno-exceptions -fno-rtti -falign-functions=4 -std=c++11 -MMD -ffunction-sections -fdata-sections -DF_CPU=160000000L   -DARDUINO=10607 -DARDUINO_ESP8266_ESP01 -DARDUINO_ARCH_ESP8266  -DESP8266 -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/cores/esp8266" -I"d:/Users/simtech/.arduinocdt/packages/esp8266/hardware/esp8266/esp8266/2.1.0/variants/generic" "$<" -o "$@"
	"d:/Users/simtech/.arduinocdt/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-ar" cru  "generic/arduino.ar" "$@"

generic/platform/cores/esp8266/WString.cpp.d: ;

-include generic/platform/cores/esp8266/WString.cpp.d


