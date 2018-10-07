VERSION=1.08

#CFLAGS = -Wall -g
CFLAGS = -pg -fpermissive -fPIC
CXX = g++
#LDFLAGS = -Wl,--version-script=linker.version
BIN = ../../out/device/vxi11-device-logic-analyzer/bin
TMP = ../../out/device/vxi11-device-logic-analyzer/tmp
VXI11LIB = ../../external/vxi11/library
INCLUDE = -I$(TMP) -I$(VXI11LIB)
SOVERSION = 1

.PHONY : all clean svc library

all: svc library

svc: $(BIN)/vxi11_svc

$(BIN)/vxi11_svc: $(TMP)/vxi11_svc_core.o $(TMP)/vxi11_svc.o $(TMP)/vxi11_xdr.o
	$(CXX) $(CFLAGS) -o $@ $^

$(TMP)/%.o: %.c $(TMP)/vxi11.h
	$(CXX) $(CFLAGS) $(INCLUDE) -c $< -o $@

#$(TMP)/%.o: vxi11/library/%.cc $(TMP)/vxi11.h
#	$(CXX) $(CFLAGS) $(INCLUDE) -c $< -o $@

library: $(BIN)/libvxi11.so.$(SOVERSION)

$(BIN)/libvxi11.so.$(SOVERSION) : $(TMP)/vxi11_user.o $(TMP)/vxi11_clnt.o $(TMP)/vxi11_xdr.o
	$(CXX) $(LDFLAGS) -shared -Wl,-soname,libvxi11.so.$(SOVERSION) $^ -o $@

$(TMP)/%.o: $(VXI11LIB)/%.c $(TMP)/vxi11.h
	$(CXX) $(CFLAGS) $(INCLUDE) -c $< -o $@

$(TMP)/%.o: $(TMP)/%.c $(TMP)/vxi11.h
	$(CXX) $(CFLAGS) $(INCLUDE) -c $< -o $@

$(TMP)/vxi11.h $(TMP)/vxi11_clnt.c $(TMP)/vxi11_svc.c $(TMP)/vxi11_xdr.c: $(VXI11LIB)/vxi11.x
	cp $(VXI11LIB)/vxi11.x $(TMP)/
	cd $(TMP) && rpcgen -M $(notdir $<)

TAGS: $(wildcard *.c) $(wildcard *.h) $(wildcard *.cc)
	etags $^

clean:
	rm -fr out
	rm -f TAGS

$(shell mkdir -p $(BIN))
$(shell mkdir -p $(TMP))
