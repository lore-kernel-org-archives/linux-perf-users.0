From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/37] perf trace: Add pointer to BPF object containing __augmented_syscalls__
Date: Mon, 22 Jul 2019 14:38:06 -0300
Message-ID: <20190722173839.22898-5-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can use it when looking for other components of that object
file, such as other programs to add to the BPF_MAP_TYPE_PROG_ARRAY and
use with bpf_tail_call().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1ibmz7ouv6llqxajy7m8igtd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4f0bbffee05f..6aa080845a84 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -96,6 +96,7 @@ struct trace {
 	struct perf_evlist	*evlist;
 	struct machine		*host;
 	struct thread		*current;
+	struct bpf_object	*bpf_obj;
 	struct cgroup		*cgroup;
 	u64			base_time;
 	FILE			*output;
@@ -3895,6 +3896,20 @@ int cmd_trace(int argc, const char **argv)
 
 	if (evsel) {
 		trace.syscalls.events.augmented = evsel;
+
+		evsel = perf_evlist__find_tracepoint_by_name(trace.evlist, "raw_syscalls:sys_enter");
+		if (evsel == NULL) {
+			pr_err("ERROR: raw_syscalls:sys_enter not found in the augmented BPF object\n");
+			goto out;
+		}
+
+		if (evsel->bpf_obj == NULL) {
+			pr_err("ERROR: raw_syscalls:sys_enter not associated to a BPF object\n");
+			goto out;
+		}
+
+		trace.bpf_obj = evsel->bpf_obj;
+
 		trace__set_bpf_map_filtered_pids(&trace);
 		trace__set_bpf_map_syscalls(&trace);
 	}
-- 
2.21.0
