From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/63] perf trace: Switch to using a struct for the aumented_raw_syscalls syscalls map values
Date: Tue, 18 Dec 2018 19:06:55 -0300
Message-ID: <20181218220733.15839-26-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll start adding more perf-syscall stuff, so lets do this prep step so
that the next ones are just about adding more fields.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vac4sn1ns1vj4y07lzj7y4b8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index de81918c7ad4..096380e8c213 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -908,6 +908,10 @@ struct syscall {
 	struct syscall_arg_fmt *arg_fmt;
 };
 
+struct bpf_map_syscall_entry {
+	bool	enabled;
+};
+
 /*
  * We need to have this 'calculated' boolean because in some cases we really
  * don't know what is the duration of a syscall, for instance, when we start
@@ -2583,7 +2587,9 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 static int trace__set_ev_qualifier_bpf_filter(struct trace *trace)
 {
 	int fd = bpf_map__fd(trace->syscalls.map);
-	bool value = !trace->not_ev_qualifier;
+	struct bpf_map_syscall_entry value = {
+		.enabled = !trace->not_ev_qualifier,
+	};
 	int err = 0;
 	size_t i;
 
@@ -2601,10 +2607,13 @@ static int trace__set_ev_qualifier_bpf_filter(struct trace *trace)
 static int __trace__init_syscalls_bpf_map(struct trace *trace, bool enabled)
 {
 	int fd = bpf_map__fd(trace->syscalls.map);
+	struct bpf_map_syscall_entry value = {
+		.enabled = enabled,
+	};
 	int err = 0, key;
 
 	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
-		err = bpf_map_update_elem(fd, &key, &enabled, BPF_ANY);
+		err = bpf_map_update_elem(fd, &key, &value, BPF_ANY);
 		if (err)
 			break;
 	}
-- 
2.19.2
