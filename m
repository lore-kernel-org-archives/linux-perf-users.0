From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/44] perf trace: Setup the augmented syscalls bpf-output event fields
Date: Thu,  9 Aug 2018 11:58:19 -0300
Message-ID: <20180809145822.21391-42-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The payload that is put in place by the eBPF script attached to
syscalls:sys_enter_openat (and other syscalls with pointers, in the
future) can be consumed by the existing sys_enter beautifiers if
evsel->priv is setup with a struct syscall_tp with struct tp_fields for
the 'syscall_id' and 'args' fields expected by the beautifiers, this
patch does just that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-xfjyog8oveg2fjys9r1yy1es@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 43a699cfcadf..06215acb1481 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -77,7 +77,8 @@ struct trace {
 		struct syscall  *table;
 		struct {
 			struct perf_evsel *sys_enter,
-					  *sys_exit;
+					  *sys_exit,
+					  *augmented;
 		}		events;
 	} syscalls;
 	struct record_opts	opts;
@@ -263,6 +264,30 @@ static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel)
 	return -ENOENT;
 }
 
+static int perf_evsel__init_augmented_syscall_tp(struct perf_evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
+
+	if (evsel->priv != NULL) {       /* field, sizeof_field, offsetof_field */
+		if (__tp_field__init_uint(&sc->id, sizeof(long), sizeof(long long), evsel->needs_swap))
+			goto out_delete;
+
+		return 0;
+	}
+
+	return -ENOMEM;
+out_delete:
+	zfree(&evsel->priv);
+	return -EINVAL;
+}
+
+static int perf_evsel__init_augmented_syscall_tp_args(struct perf_evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv;
+
+	return __tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64));
+}
+
 static int perf_evsel__init_raw_syscall_tp(struct perf_evsel *evsel, void *handler)
 {
 	evsel->priv = malloc(sizeof(struct syscall_tp));
@@ -3248,6 +3273,13 @@ int cmd_trace(int argc, const char **argv)
 		goto out;
 	}
 
+	if (evsel) {
+		if (perf_evsel__init_augmented_syscall_tp(evsel) ||
+		    perf_evsel__init_augmented_syscall_tp_args(evsel))
+			goto out;
+		trace.syscalls.events.augmented = evsel;
+	}
+
 	err = bpf__setup_stdout(trace.evlist);
 	if (err) {
 		bpf__strerror_setup_stdout(trace.evlist, err, bf, sizeof(bf));
-- 
2.14.4
