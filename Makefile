VERSION=1.08

#CFLAGS = -Wall -g
CFLAGS = -g -fpermissive -fPIC
CXX = g++
#LDFLAGS = -Wl,--version-script=linker.version
INCLUDE = -Iout/tmp -Ivxi11/library
BIN = out/bin
TMP = out/tmp
SOVERSION = 1

.PHONY : all clean svc cmd library

all: svc cmd library

svc: $(BIN)/vxi11_svc

$(BIN)/vxi11_svc: $(TMP)/vxi11_svc_core.o $(TMP)/vxi11_svc.o $(TMP)/vxi11_xdr.o
	$(CXX) $(CFLAGS) -o $@ $^

$(TMP)/%.o: vxi11_svc/%.c $(TMP)/vxi11.h
	$(CXX) $(CFLAGS) $(INCLUDE) -c $< -o $@

cmd: $(BIN)/vxi11_cmd

$(BIN)/vxi11_cmd: $(TMP)/vxi11_cmd.o $(TMP)/vxi11_user.o $(TMP)/vxi11_clnt.o $(TMP)/vxi11_xdr.o
	$(CXX) $(CFLAGS) -o $@ $^

#$(TMP)/%.o: vxi11/library/%.cc $(TMP)/vxi11.h
#	$(CXX) $(CFLAGS) $(INCLUDE) -c $< -o $@

library: $(BIN)/libvxi11.so.$(SOVERSION)

$(BIN)/libvxi11.so.$(SOVERSION) : $(TMP)/vxi11_user.o $(TMP)/vxi11_clnt.o $(TMP)/vxi11_xdr.o
	$(CXX) $(LDFLAGS) -shared -Wl,-soname,libvxi11.so.$(SOVERSION) $^ -o $@

$(TMP)/%.o: vxi11/utils/%.c $(TMP)/vxi11.h
	$(CXX) $(CFLAGS) $(INCLUDE) -c $< -o $@

$(TMP)/%.o: vxi11/library/%.c $(TMP)/vxi11.h
	$(CXX) $(CFLAGS) $(INCLUDE) -c $< -o $@

$(TMP)/%.o: $(TMP)/%.c $(TMP)/vxi11.h
	$(CXX) $(CFLAGS) $(INCLUDE) -c $< -o $@

#$(TMP)/vxi11.h: vxi11/library/vxi11.x $(TMP)/.f
#	rpcgen -M -h -o $@ $<

#$(TMP)/vxi11_clnt.c: vxi11/library/vxi11.x $(TMP)/.f
#	rpcgen -M -l -o $@ $<

#$(TMP)/vxi11_svc.c: vxi11/library/vxi11.x $(TMP)/.f
#	rpcgen -M -m -o $@ $<

#$(TMP)/vxi11_xdr.c: vxi11/library/vxi11.x $(TMP)/.f
#	rpcgen -M -c -o $@ $<

$(TMP)/vxi11.h $(TMP)/vxi11_clnt.c $(TMP)/vxi11_svc.c $(TMP)/vxi11_xdr.c: vxi11/library/vxi11.x
	cp vxi11/library/vxi11.x $(TMP)/
	cd $(TMP) && rpcgen -M $(notdir $<)

#$(BIN)/.f $(TMP)/.f $(HEADER_VXI)/.f:
#	mkdir -p $(dir $@)
#	touch $@

TAGS: $(wildcard *.c) $(wildcard *.h) $(wildcard *.cc)
	etags $^

clean:
	rm -fr out
	rm -f TAGS

$(shell mkdir -p $(BIN))
$(shell mkdir -p $(TMP))
