From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/21] perf tests: Fix complex event name parsing
Date: Wed,  1 Aug 2018 18:36:30 -0300
Message-ID: <20180801213648.4814-4-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sandipan Das <sandipan@linux.ibm.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

The 'umask' event parameter is unsupported on some architectures like
powerpc64.

This can be observed on a powerpc64le system running Fedora 27 as shown
below.

  # perf test "Parse event definition strings" -v
   6: Parse event definition strings                        :
  --- start ---
  test child forked, pid 45915
  ...
  running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp'Invalid event/parameter 'umask'
  Invalid event/parameter 'umask'
  failed to parse event 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp', err 1, str 'unknown term'
  event syntax error: '..,event=0x2,umask=0x3/ukp'
                                    \___ unknown term

  valid terms: event,mark,pmc,cache_sel,pmcxsel,unit,thresh_stop,thresh_start,combine,thresh_sel,thresh_cmp,sample_mode,config,config1,config2,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,no-overwrite,overwrite,driver-config

  mem_access -> cpu/event=0x10401e0/
  running test 0 'config=10,config1,config2=3,umask=1'
  test child finished with 1
  ---- end ----
  Parse event definition strings: FAILED!

Committer testing:

After applying the patch these test passes and in verbose mode we get:

  # perf test -v "event definition"
   6: Parse event definition strings:
  --- start ---
  test child forked, pid 11061
  running test 0 'syscalls:sys_enter_openat'Using CPUID GenuineIntel-6-9E
  <SNIP>
  running test 53 'cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk'
  running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
  running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
  running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
  running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp'
  <SNIP>
  test child finished with 0
  ---- end ----
  Parse event definition strings: Ok
  #

Suggested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Fixes: 06dc5bf21f3f ("perf tests: Check that complex event name is parsed correctly")
Link: http://lkml.kernel.org/r/20180726105502.31670-1-sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index a36313daec4e..3b97ac018d5a 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1690,7 +1690,7 @@ static struct evlist_test test__events_pmu[] = {
 		.id    = 2,
 	},
 	{
-		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp",
+		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
 		.check = test__checkevent_complex_name,
 		.id    = 3,
 	}
-- 
2.14.4
