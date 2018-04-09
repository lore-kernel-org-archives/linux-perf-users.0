From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/13] perf annotate: Show group details on the title line
Date: Mon,  9 Apr 2018 16:34:26 -0300
Message-ID: <20180409193437.14199-3-acme@kernel.org>
References: <20180409193437.14199-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180409193437.14199-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To match what is shown in the main 'perf report/top' title lines, i.e.
if a group is being shown, either a real group (recorded with "-e
'{a,b,c}') or a forced group (using 'perf report --group' for a
perf.data file recorded without {}) we will show multiple columns,
one per event, but we were failing to show the group details, so, for:

 # perf report --header-only | grep cmdline
 # cmdline : /home/acme/bin/perf record -e {cycles,instructions,cache-misses}
 # perf report --group

The first line was showing just "cycles", now it shows the correct line,
which is:

  Samples: 578  of events 'anon group { cycles, instructions, cache-misses }', 4000 Hz, Event count (approx.): 487421794
  syscall_return_via_sysret  /lib/modules/4.16.0-rc7/build/vmlinux
    0.22   2.97   0.00 │    ↓ jmp    6c
                       │      mov    %cr3,%rdi
    1.33  10.89   4.00 │    ↓ jmp    62
                       │      mov    %rdi,%rax
<SNIP>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 6920e2854e9a ("perf annotate browser: Show extra title line with event information")
Link: https://lkml.kernel.org/n/tip-i41tqh17c2dabnyzjh99r1oz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index fffe16af9797..fbad8dfbb186 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2600,7 +2600,7 @@ int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   bool show_freq)
 {
 	const char *ev_name = perf_evsel__name(evsel);
-	char ref[30] = " show reference callgraph, ";
+	char buf[1024], ref[30] = " show reference callgraph, ";
 	char sample_freq_str[64] = "";
 	unsigned long nr_samples = 0;
 	int nr_members = 1;
@@ -2609,8 +2609,11 @@ int __annotation__scnprintf_samples_period(struct annotation *notes,
 	char unit;
 	int i;
 
-	if (perf_evsel__is_group_event(evsel))
+	if (perf_evsel__is_group_event(evsel)) {
+		perf_evsel__group_desc(evsel, buf, sizeof(buf));
+		ev_name = buf;
                 nr_members = evsel->nr_members;
+	}
 
 	for (i = 0; i < nr_members; i++) {
 		struct sym_hist *ah = annotation__histogram(notes, evsel->idx + i);
-- 
2.14.3
