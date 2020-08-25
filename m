From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf stat: Fix s390x compile error on F32 utils/stat-display.c
Date: Tue, 25 Aug 2020 08:33:04 +0200
Message-ID: <20200825063304.77733-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com, jolsa@redhat.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Fix a compile error on F32 and gcc version 10.1 on s390 in file
utils/stat-display.c.  The error does not show up with make DEBUG=y.
In fact the issue shows up when using both compiler options
-O6 and -D_FORTIFY_SOURCE=2 (which are omitted with DEBUG=Y).

This is the offending call chain:
print_counter_aggr()
  printout(config, -1, 0, ...)  with 2nd parm id set to -1
    aggr_printout(config, x, id --> -1, ...) which leads to this code:
		case AGGR_NONE:
                if (evsel->percore && !config->percore_show_thread) {
                        ....
                } else {
                        fprintf(config->output, "CPU%*d%s",
                                config->csv_output ? 0 : -7,
                                evsel__cpus(evsel)->map[id],
				                        ^^ id is -1 !!!!
                                config->csv_sep);
                }

This is a compiler inlining issue which is detected on s390 but not on
other plattforms.

Output before:
 # make util/stat-display.o
    .....

  util/stat-display.c: In function ‘perf_evlist__print_counters’:
  util/stat-display.c:121:4: error: array subscript -1 is below array
      bounds of ‘int[]’ [-Werror=array-bounds]
  121 |    fprintf(config->output, "CPU%*d%s",
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  122 |     config->csv_output ? 0 : -7,
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  123 |     evsel__cpus(evsel)->map[id],
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  124 |     config->csv_sep);
      |     ~~~~~~~~~~~~~~~~
  In file included from util/evsel.h:13,
                 from util/evlist.h:13,
                 from util/stat-display.c:9:
  /root/linux/tools/lib/perf/include/internal/cpumap.h:10:7:
  note: while referencing ‘map’
   10 |  int  map[];
      |       ^~~
  cc1: all warnings being treated as errors
  mv: cannot stat 'util/.stat-display.o.tmp': No such file or directory
  make[3]: *** [/root/linux/tools/build/Makefile.build:97: util/stat-display.o]
  Error 1
  make[2]: *** [Makefile.perf:716: util/stat-display.o] Error 2
  make[1]: *** [Makefile.perf:231: sub-make] Error 2
  make: *** [Makefile:110: util/stat-display.o] Error 2
  [root@t35lp46 perf]#

Output after:
  # make util/stat-display.o
    .....
  CC       util/stat-display.o
  [root@t35lp46 perf]#

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/stat-display.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 57d0706e1330..cbe836649f84 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -117,12 +117,11 @@ static void aggr_printout(struct perf_stat_config *config,
 				cpu_map__id_to_die(id),
 				config->csv_output ? 0 : -3,
 				cpu_map__id_to_cpu(id), config->csv_sep);
-		} else {
+		} else if (id > -1)
 			fprintf(config->output, "CPU%*d%s",
 				config->csv_output ? 0 : -7,
 				evsel__cpus(evsel)->map[id],
 				config->csv_sep);
-		}
 		break;
 	case AGGR_THREAD:
 		fprintf(config->output, "%*s-%*d%s",
-- 
2.26.2
