From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 85/91] perf symbol: Fix kernel symbol address display
Date: Wed,  6 May 2020 12:22:28 -0300
Message-ID: <20200506152234.21977-86-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Running commands

   ./perf record -e rb0000 -- find .
   ./perf report -v

reveals symbol names and its addresses. There is a mismatch between
kernel symbol and address. Here is an example for kernel symbol
check_chain_key:

 3.55%  find /lib/modules/.../build/vmlinux  0xf11ec  v [k] check_chain_key

This address is off by 0xff000 as can be seen with:

[root@t35lp46 ~]# fgrep check_chain_key /proc/kallsyms
00000000001f00d0 t check_chain_key
[root@t35lp46 ~]# objdump -t ~/linux/vmlinux| fgrep check_chain_key
00000000001f00d0 l     F .text	00000000000001e8 check_chain_key
[root@t35lp46 ~]#

This function is located in main memory 0x1f00d0 - 0x1f02b4. It has
several entries in the perf data file with the correct address:

[root@t35lp46 perf]# ./perf report -D -i perf.data.find-bad | \
				fgrep SAMPLE| fgrep 0x1f01ec
PERF_RECORD_SAMPLE(IP, 0x1): 22228/22228: 0x1f01ec period: 1300000 addr: 0
PERF_RECORD_SAMPLE(IP, 0x1): 22228/22228: 0x1f01ec period: 1300000 addr: 0

The root cause happens when reading symbol tables during perf report.
A long gdb call chain leads to

   machine__deliver_events
     perf_evlist__deliver_event
       perf_evlist__deliver_sample
         build_id__mark_dso_hits
	   thread__find_map(1)      Read correct address from sample entry
	     map__load
	       dso__load            Some more functions to end up in
	         ....
		 dso__load_sym.

Function dso__load_syms  checks for kernel relocation and symbol
adjustment for the kernel and results in kernel map adjustment of
	 kernel .text segment address (0x100000 on s390)
	 kernel .text segment offset in file (0x1000 on s390).
This results in all kernel symbol addresses to be changed by subtracting
0xff000 (on s390). For the symbol check_chain_key we end up with

    0x1f00d0 - 0x100000 + 0x1000 = 0xf11d0

and this address is saved in the perf symbol table. This calculation is
also applied by the mapping functions map__mapip() and map__unmapip()
to map IP addresses to dso mappings.

During perf report processing functions

   process_sample_event    (builtin-report.c)
     machine__resolve
       thread__find_map
     hist_entry_iter_add

are called. Function thread__find_map(1)
takes the correct sample address and applies the mapping function
map__mapip() from the kernel dso and saves the modified address
in struct addr_location for further reference. From now on this address
is used.

Funktion process_sample_event() then calls hist_entry_iter_add() to save
the address in member ip of struct hist_entry.

When samples are displayed using

    perf_evlist__tty_browse_hists
      hists__fprintf
        hist_entry__fprintf
	  hist_entry__snprintf
	    __hist_entry__snprintf
	      _hist_entry__sym_snprintf()

This simply displays the address of the symbol and ignores the dso <-> map
mappings done in function thread__find_map. This leads to the address
mismatch.

Output before:

ot@t35lp46 perf]# ./perf report -v | fgrep check_chain_key
     3.55%  find     /lib/modules/5.6.0d-perf+/build/vmlinux
     						0xf11ec v [k] check_chain_key
[root@t35lp46 perf]#

Output after:

[root@t35lp46 perf]# ./perf report -v | fgrep check_chain_key
     3.55%  find     /lib/modules/5.6.0d-perf+/build/vmlinux
     						0x1f01ec v [k] check_chain_key
[root@t35lp46 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200415070744.59919-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index dc23b349fff9..c1f8879f92cc 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -300,8 +300,14 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 
 	if (verbose > 0) {
 		char o = map ? dso__symtab_origin(map->dso) : '!';
+		u64 rip = ip;
+
+		if (map && map->dso && map->dso->kernel
+		    && map->dso->adjust_symbols)
+			rip = map->unmap_ip(map, ip);
+
 		ret += repsep_snprintf(bf, size, "%-#*llx %c ",
-				       BITS_PER_LONG / 4 + 2, ip, o);
+				       BITS_PER_LONG / 4 + 2, rip, o);
 	}
 
 	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", level);
-- 
2.21.1
