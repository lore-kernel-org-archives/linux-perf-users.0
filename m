From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/29] perf trace: Check if the raw_syscalls:sys_{enter,exit} are setup before setting tp filter
Date: Thu,  3 Jan 2019 09:45:41 -0300
Message-ID: <20190103124609.29672-2-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

While updating 'perf trace' on an machine with an old precompiled
augmented_raw_syscalls.o that didn't setup the syscall map the new 'perf
trace' codebase notices the augmented_raw_syscalls.o eBPF event, decides
to use it instead of the old raw_syscalls:sys_{enter,exit} method, but
then because we don't have the syscall map tries to set the tracepoint
filter on the sys_{enter,exit} evsels, that are NULL, segfaulting.

Make the code more robust by checking it those tracepoints have
their respective evsels in place before trying to set the tp filter.

With this we still get everything to work, just not setting up the
syscall filters, which is better than a segfault. Now to update the
precompiled augmented_raw_syscalls.o and continue development :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-3ft5rjdl05wgz2pwpx2z8btu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ebde59e61133..6689c1a114fe 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2686,7 +2686,9 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
 {
 	if (trace->syscalls.map)
 		return trace__set_ev_qualifier_bpf_filter(trace);
-	return trace__set_ev_qualifier_tp_filter(trace);
+	if (trace->syscalls.events.sys_enter)
+		return trace__set_ev_qualifier_tp_filter(trace);
+	return 0;
 }
 
 static int bpf_map__set_filter_pids(struct bpf_map *map __maybe_unused,
-- 
2.19.2
