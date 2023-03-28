.PHONY: default all all_pcap all_pfring debug debug_pcap debug_pfring clean

default: snidump_pfring snidump_pfring_dbg

all: all_pcap all_pfring debug_pcap debug_pfring

all_pcap: snidump snidump_noether

all_pfring: snidump_pfring snidump_pfring_noether

debug: debug_pcap debug_pfring

debug_pcap: snidump_dbg snidump_noether_dbg

debug_pfring: snidump_pfring_dbg snidump_pfring_noether_dbg

snidump: src/*
	mkdir -p bin && \
	gcc -D__DEBUG__=0 -Wall \
		src/snidump.c src/tls.c src/http.c \
		-lpcap -lpcre \
		-o bin/snidump

snidump_dbg: src/*
	mkdir -p bin && \
	gcc -D__DEBUG__=1 -Wall -ggdb \
		src/snidump.c src/tls.c src/http.c \
		-lpcap -lpcre \
		-o bin/snidump_dbg

snidump_pfring: src/*
	mkdir -p bin && \
	gcc -D__DEBUG__=0 \
		-Wall \
		-DHAVE_PF_RING -DENABLE_BPF  -DHAVE_PF_RING_ZC -DHAVE_PF_RING_FT \
		-I../libpcap/ ../libpcap/libpcap.a \
		src/snidump.c src/tls.c src/http.c \
		-lpcap -lpcre -lpthread -lrt -ldl -O2 \
		-o bin/snidump_pfring

snidump_pfring_dbg: src/*
	mkdir -p bin && \
	gcc -D__DEBUG__=1 \
		-Wall -Wno-unused-function -Wno-format-truncation -Wno-address-of-packed-member \
		-DHAVE_PF_RING -DENABLE_BPF  -DHAVE_PF_RING_ZC -DHAVE_PF_RING_FT \
		-I../libpcap/ ../libpcap/libpcap.a \
		src/snidump.c src/tls.c src/http.c \
		-lpcap -lpcre -lpthread -lrt -ldl -O2 \
		-o bin/snidump_pfring_dbg

snidump_noether: src/*
	mkdir -p bin && \
	gcc -D__DEBUG__=0 -Wall \
		-D__NO_ETHERNET__ \
		src/snidump.c src/tls.c src/http.c \
		-lpcap -lpcre \
		-o bin/snidump_noether

snidump_noether_dbg: src/*
	mkdir -p bin && \
	gcc -D__DEBUG__=1 -Wall -ggdb \
		-D__NO_ETHERNET__ \
		src/snidump.c src/tls.c src/http.c \
		-lpcap -lpcre \
		-o bin/snidump_noether_dbg

snidump_pfring_noether: src/*
	mkdir -p bin && \
	gcc -D__DEBUG__=0 -D__NO_ETHERNET__ \
		-Wall -Wno-unused-function -Wno-format-truncation -Wno-address-of-packed-member \
		-DHAVE_PF_RING -DENABLE_BPF  -DHAVE_PF_RING_ZC -DHAVE_PF_RING_FT \
		-I../libpcap/ ../libpcap/libpcap.a \
		src/snidump.c src/tls.c src/http.c \
		-lpcap -lpcre -lpthread -lrt -ldl -O2 \
		-o bin/snidump_pfring_noether

snidump_pfring_noether_dbg: src/*
	mkdir -p bin && \
	gcc -D__DEBUG__=1 -D__NO_ETHERNET__ \
		-Wall -Wno-unused-function -Wno-format-truncation -Wno-address-of-packed-member \
		-DHAVE_PF_RING -DENABLE_BPF  -DHAVE_PF_RING_ZC -DHAVE_PF_RING_FT \
		-I../libpcap/ ../libpcap/libpcap.a \
		src/snidump.c src/tls.c src/http.c \
		-lpcap -lpcre -lpthread -lrt -ldl -O2 \
		-o bin/snidump_pfring_noether_dbg

clean:
	rm -rf bin
