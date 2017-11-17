From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 55/83] perf machine: Guard against NULL in machine__exit()
Date: Fri, 17 Nov 2017 17:15:33 -0300
Message-ID: <20171117201601.24110-56-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andrei Vagin <avagin@openvz.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vasily Averin <vvs@virtuozzo.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

A recent fix for 'perf trace' introduced a bug where
machine__exit(trace->host) could be called while trace->host was still
NULL, so make this more robust by guarding against NULL, just like
free() does.

The problem happens, for instance, when !root users try to run 'perf
trace':

  [acme@jouet linux]$ trace
  Error:	No permissions to read /sys/kernel/debug/tracing/events/raw_syscalls/sys_(enter|exit)
  Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/debug/tracing'

  perf: Segmentation fault
  Obtained 7 stack frames.
  [0x4f1b2e]
  /lib64/libc.so.6(+0x3671f) [0x7f43a1dd971f]
  [0x4f3fec]
  [0x47468b]
  [0x42a2db]
  /lib64/libc.so.6(__libc_start_main+0xe9) [0x7f43a1dc3509]
  [0x42a6c9]
  Segmentation fault (core dumped)
  [acme@jouet linux]$

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vasily Averin <vvs@virtuozzo.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 33974a414ce2 ("perf trace: Call machine__exit() at exit")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6a8d03c3d9b7..270f3223c6df 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -172,6 +172,9 @@ void machine__exit(struct machine *machine)
 {
 	int i;
 
+	if (machine == NULL)
+		return;
+
 	machine__destroy_kernel_maps(machine);
 	map_groups__exit(&machine->kmaps);
 	dsos__exit(&machine->dsos);
-- 
2.13.6
