From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/15] perf symbols: Stop using map->groups, we can use kmaps instead
Date: Tue, 12 Nov 2019 15:37:44 -0300
Message-ID: <20191112183757.28660-3-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To test that that function is being called I just added a probe on that
place, enabled it via 'perf trace' asking for at most 16 levels of
backtraces, system wide, and then ran 'perf top' on another xterm,
voilà:

  # perf probe -x ~/bin/perf dso__process_kernel_symbol
  Added new event:
    probe_perf:dso__process_kernel_symbol (on dso__process_kernel_symbol in /home/acme/bin/perf)

  You can now use it in all perf tools, such as:

  	perf record -e probe_perf:dso__process_kernel_symbol -aR sleep 1

  # perf trace -e probe_perf:dso__process_kernel_symbol/max-stack=16/ --max-events=2
  # perf trace -e probe_perf:dso__process_kernel_symbol/max-stack=16/ --max-events=2
       0.000 :17345/17345 probe_perf:dso__process_kernel_symbol(__probe_ip: 5680224)
                                         dso__process_kernel_symbol (/home/acme/bin/perf)
                                         dso__load_vmlinux (/home/acme/bin/perf)
                                         dso__load_vmlinux_path (/home/acme/bin/perf)
                                         dso__load (/home/acme/bin/perf)
                                         map__load (/home/acme/bin/perf)
                                         thread__find_map (/home/acme/bin/perf)
                                         machine__resolve (/home/acme/bin/perf)
                                         deliver_event (/home/acme/bin/perf)
                                         __ordered_events__flush.part.0 (/home/acme/bin/perf)
                                         process_thread (/home/acme/bin/perf)
                                         start_thread (/usr/lib64/libpthread-2.29.so)
       0.064 :17345/17345 probe_perf:dso__process_kernel_symbol(__probe_ip: 5680224)
                                         dso__process_kernel_symbol (/home/acme/bin/perf)
                                         dso__load_vmlinux (/home/acme/bin/perf)
                                         dso__load_vmlinux_path (/home/acme/bin/perf)
                                         dso__load (/home/acme/bin/perf)
                                         map__load (/home/acme/bin/perf)
                                         thread__find_map (/home/acme/bin/perf)
                                         machine__resolve (/home/acme/bin/perf)
                                         deliver_event (/home/acme/bin/perf)
                                         __ordered_events__flush.part.0 (/home/acme/bin/perf)
                                         process_thread (/home/acme/bin/perf)
                                         start_thread (/usr/lib64/libpthread-2.29.so)
  #
  # perf stat -e probe_perf:dso__process_kernel_symbol
  ^C
   Performance counter stats for 'system wide':

           107,308      probe_perf:dso__process_kernel_symbol

       8.215399813 seconds time elapsed
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5fy66x5hr5ct9pmw84jkiwvm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66f4be1df573..16776d5fbaea 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -934,7 +934,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		 * we still are sure to have a reference to this DSO via
 		 * *curr_map->dso.
 		 */
-		dsos__add(&map->groups->machine->dsos, curr_dso);
+		dsos__add(&kmaps->machine->dsos, curr_dso);
 		/* kmaps already got it */
 		map__put(curr_map);
 		dso__set_loaded(curr_dso);
-- 
2.21.0
