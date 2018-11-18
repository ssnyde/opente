TARGET = devmem2

CFLAGS = -static -g -Wall -std=gnu99
LDFLAGS = -g -Wall
CC = $(CROSS_COMPILE)gcc
ARCH = arm
BIN = ../../out/device/devmem2/bin
TMP = ../../out/device/devmem2/tmp

.PHONY: build
build: $(BIN)/$(TARGET)
$(BIN)/$(TARGET): $(TMP)/$(TARGET).o
	$(CC) $(LDFLAGS) $^ -o $@

$(TMP)/%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -fr $(BIN)
	rm -rf $(TMP)

$(shell mkdir -p $(BIN))
$(shell mkdir -p $(TMP))
