From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/86] perf record: Do not ask for precise_ip with --no-samples
Date: Wed, 19 Jul 2017 11:29:05 -0300
Message-ID: <20170719142950.3747-42-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When the user doesn't specify an event with -e/--event, 'perf record'
will use as a default the "cycles" event with the highest level of
precision in perf_event_attr.precise_ip, but --no-samples, if present,
is incompatible with precise_ip != 0, so use the newly introduced
__perf_event__add_default(precise = false) to fix that:

Before:

  # perf record -n usleep 1
  Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles:ppp).
  /bin/dmesg may provide additional information.
  No CONFIG_PERF_EVENTS=y kernel support configured?
  #

After:

  # perf record -n usleep 1
  Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.018 MB perf.data ]
  [root@jouet /]# perf evlist -v
  cycles: size: 112, sample_type: IP|TID|TIME|PERIOD, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
  [root@jouet /]#

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-q991fw6s6rhjvrd5ye4t7qom@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 17a14bcce34a..64eef9a567d9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1821,7 +1821,7 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->nr_entries == 0 &&
-	    perf_evlist__add_default(rec->evlist) < 0) {
+	    __perf_evlist__add_default(rec->evlist, !record.opts.no_samples) < 0) {
 		pr_err("Not enough memory for event selector list\n");
 		goto out;
 	}
-- 
2.9.4
