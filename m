Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7508122AE71
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 04:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086280; cv=none; b=Ba2j4qeJk1Vxqc5zln6phy6dfBRADdCvV5RVS8Nl8Tyo42pbmaSeKvUpAtZlAwZZeb7RtyMKYJp/byzANy8yG/GG8YGNSqGKZyjpM/FeK9ehBc252r8kW0M34vhMvXwBnyVlp0xhNz0STEhILX+kAA4dvBDrqGyir+biaEl+Xgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086280; c=relaxed/simple;
	bh=K+1J9DOC96kiAfgOJ+dEW4omGKvaRGy1l3ASnzwBZLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=paxwIDSNUq1w/3t7yYDS4BuC1HozGOhdCKBgPyHBDhrB6tGeHMrljumiGx2J2leTPurwG8ttQWlpCUEnIAb+/E2GZrysI9eRUS+lAeWamh5BhxNECRrjYVgafkIQstrVJ/rhZ8rnkLs6PkhoBnNI/TTFALZI/5Wf3LxJW1TBQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/bdkh9m; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/bdkh9m"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748e6457567so3019002b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 21:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086278; x=1751691078; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReFJ9O4xKROX2HGDj/nIarZNxigTNc/RAGO4Q9N4u6I=;
        b=O/bdkh9mxn+qDTekqHcahfai04m9UdT+vVMdeYAK5cPWRbTAIc1dmm1hMQ/xKQTcWC
         92x1R8AG7nmeYKtDcUbIfZRprytupJvCsPiBKkkRxUFdcoDmmyyFxt5a397XodYRRKBL
         FSjv5HQiyyax0M+Vd7ixbEP0lmqgikxXP01Me+V3tpc6YM3s72Tl97yegggbq5VwMCcP
         flhMRuMLg1TKUVaIQ4EygVJHNXw1jvfBPJeVo4oMlByHA0D49DVnhJuGtUD3MhqFW/ZU
         8n0DEil/3IcjROQuJtdqLQdxMx+bf2WABumtBp2qqH83LTH6j55MXdXv7iPG1r7pmjqx
         4KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086278; x=1751691078;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReFJ9O4xKROX2HGDj/nIarZNxigTNc/RAGO4Q9N4u6I=;
        b=DpEErx3yht9li39AE2b+shcpJzRmsw62VxZa7kR3jVfObqSQQJbOxzwICpn/VHzQja
         3Qeg4BjiiKTFyZypoaXZhO0UEzH7N7i0ovJqXXfhg2ENOUyliTP4jFFVmDM5CMyzknLY
         rOWmqW8ouZHI4k8Py/BiNd8XBYUmK0BmqctzRH+WWbk2gh9m46F45AYXo0rrQmW26gxt
         aSTFHf26hjn0UF1O80SWAqPfYCO1ruPoQBxNTdM5+TlZKUGwlO/f7PwdaIMDYh8N4clj
         oc/RxkLZKV/gxS6m/H7wHtBODWikP93f2k3oE6wNzKN//Lkr+7k7VM2rH7IT1QLpsmSB
         7Y3g==
X-Forwarded-Encrypted: i=1; AJvYcCVlMemZus8HO3oHp/t2NmRkmzIeMMJrKqIqXZWmZQ/rzFVTemENs+oMjpuU0MR3VE3nWCiWUJy0606Y85Erj5j7@vger.kernel.org
X-Gm-Message-State: AOJu0YwFraxoHaYLneXWjOmXex3HPLc13pwdMmTx9g45Vtqe/JSE501J
	0xFqWyqdD/oP5RjYrfIO8Y8adFyL/iE0euqxGzEo5SrepWtfztOt7+ZYNkWB1VqI1exbIpbsK0B
	50SW0MfOZwA==
X-Google-Smtp-Source: AGHT+IFGvelhSrCM2RA5nnBmIxvyIpSp0s02cz5WyYFv8AD1s88QjzS2QLJVoTKFROWcFh1giXEuCCk3k2Cb
X-Received: from pfwz25.prod.google.com ([2002:a05:6a00:1d99:b0:747:aac7:7c2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:700a:b0:21f:54e0:b0a3
 with SMTP id adf61e73a8af0-220a0893965mr9201705637.2.1751086277663; Fri, 27
 Jun 2025 21:51:17 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:50:11 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-18-irogers@google.com>
Subject: [PATCH v5 17/23] perf machine: Explicitly pass in host perf_env
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

When creating a machine for the host explicitly pass in a scoped
perf_env. This removes a use of the global perf_env.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-buildid-list.c     |  5 ++++-
 tools/perf/builtin-kallsyms.c         | 21 ++++++++++++++++-----
 tools/perf/builtin-trace.c            | 24 +++++++++++++++++-------
 tools/perf/tests/code-reading.c       |  3 +--
 tools/perf/tests/dlfilter-test.c      |  3 +--
 tools/perf/tests/dwarf-unwind.c       | 10 +++++++---
 tools/perf/tests/mmap-thread-lookup.c |  6 +++++-
 tools/perf/tests/symbols.c            |  8 +++++++-
 tools/perf/util/debug.c               |  9 ++++++++-
 tools/perf/util/machine.c             | 16 ++++++++--------
 tools/perf/util/machine.h             |  6 +++---
 tools/perf/util/probe-event.c         |  5 ++++-
 12 files changed, 81 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 151cd84b6dfe..a91bbb34ac94 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -45,11 +45,14 @@ static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
 
 static void buildid__show_kernel_maps(void)
 {
+	struct perf_env host_env;
 	struct machine *machine;
 
-	machine = machine__new_host();
+	perf_env__init(&host_env);
+	machine = machine__new_host(&host_env);
 	machine__for_each_kernel_map(machine, buildid__map_cb, NULL);
 	machine__delete(machine);
+	perf_env__exit(&host_env);
 }
 
 static int sysfs__fprintf_build_id(FILE *fp)
diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index a3c2ffdc1af8..3c4339982b16 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -12,18 +12,28 @@
 #include <subcmd/parse-options.h>
 #include "debug.h"
 #include "dso.h"
+#include "env.h"
 #include "machine.h"
 #include "map.h"
 #include "symbol.h"
 
 static int __cmd_kallsyms(int argc, const char **argv)
 {
-	int i;
-	struct machine *machine = machine__new_kallsyms();
+	int i, err;
+	struct perf_env host_env;
+	struct machine *machine = NULL;
 
+
+	perf_env__init(&host_env);
+	err = perf_env__set_cmdline(&host_env, argc, argv);
+	if (err)
+		goto out;
+
+	machine = machine__new_kallsyms(&host_env);
 	if (machine == NULL) {
 		pr_err("Couldn't read /proc/kallsyms\n");
-		return -1;
+		err = -1;
+		goto out;
 	}
 
 	for (i = 0; i < argc; ++i) {
@@ -42,9 +52,10 @@ static int __cmd_kallsyms(int argc, const char **argv)
 			map__unmap_ip(map, symbol->start), map__unmap_ip(map, symbol->end),
 			symbol->start, symbol->end);
 	}
-
+out:
 	machine__delete(machine);
-	return 0;
+	perf_env__exit(&host_env);
+	return err;
 }
 
 int cmd_kallsyms(int argc, const char **argv)
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 9e2439f9bb00..d52f21afdeb1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -143,6 +143,7 @@ struct syscall_fmt {
 };
 
 struct trace {
+	struct perf_env		host_env;
 	struct perf_tool	tool;
 	struct {
 		/** Sorted sycall numbers used by the trace. */
@@ -1983,17 +1984,24 @@ static char *trace__machine__resolve_kernel_addr(void *vmachine, unsigned long l
 	return machine__resolve_kernel_addr(vmachine, addrp, modp);
 }
 
-static int trace__symbols_init(struct trace *trace, struct evlist *evlist)
+static int trace__symbols_init(struct trace *trace, int argc, const char **argv,
+			       struct evlist *evlist)
 {
 	int err = symbol__init(NULL);
 
 	if (err)
 		return err;
 
-	trace->host = machine__new_host();
-	if (trace->host == NULL)
-		return -ENOMEM;
+	perf_env__init(&trace->host_env);
+	err = perf_env__set_cmdline(&trace->host_env, argc, argv);
+	if (err)
+		goto out;
 
+	trace->host = machine__new_host(&trace->host_env);
+	if (trace->host == NULL) {
+		err = -ENOMEM;
+		goto out;
+	}
 	thread__set_priv_destructor(thread_trace__delete);
 
 	err = trace_event__register_resolver(trace->host, trace__machine__resolve_kernel_addr);
@@ -2004,9 +2012,10 @@ static int trace__symbols_init(struct trace *trace, struct evlist *evlist)
 					    evlist->core.threads, trace__tool_process,
 					    true, false, 1);
 out:
-	if (err)
+	if (err) {
+		perf_env__exit(&trace->host_env);
 		symbol__exit();
-
+	}
 	return err;
 }
 
@@ -2015,6 +2024,7 @@ static void trace__symbols__exit(struct trace *trace)
 	machine__exit(trace->host);
 	trace->host = NULL;
 
+	perf_env__exit(&trace->host_env);
 	symbol__exit();
 }
 
@@ -4456,7 +4466,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
-	err = trace__symbols_init(trace, evlist);
+	err = trace__symbols_init(trace, argc, argv, evlist);
 	if (err < 0) {
 		fprintf(trace->output, "Problems initializing symbol libraries!\n");
 		goto out_delete_evlist;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 4b2461e93b2b..e327d892c725 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -655,9 +655,8 @@ static int do_test_code_reading(bool try_kcore)
 
 	pid = getpid();
 
-	machine = machine__new_host();
 	perf_env__init(&host_env);
-	machine->env = &host_env;
+	machine = machine__new_host(&host_env);
 
 	ret = machine__create_kernel_maps(machine);
 	if (ret < 0) {
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index 6427e3382711..80a1c941138d 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -353,9 +353,8 @@ static int test__dlfilter_test(struct test_data *td)
 		return test_result("Failed to find program symbols", TEST_FAIL);
 
 	pr_debug("Creating new host machine structure\n");
-	td->machine = machine__new_host();
 	perf_env__init(&host_env);
-	td->machine->env = &host_env;
+	td->machine = machine__new_host(&host_env);
 
 	td->fd = creat(td->perf_data_file_name, 0644);
 	if (td->fd < 0)
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 525c46b7971a..9ed78d00fb87 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include "tests.h"
 #include "debug.h"
+#include "env.h"
 #include "machine.h"
 #include "event.h"
 #include "../util/unwind.h"
@@ -180,6 +181,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *th
 noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
 				int subtest __maybe_unused)
 {
+	struct perf_env host_env;
 	struct machine *machine;
 	struct thread *thread;
 	int err = -1;
@@ -188,15 +190,16 @@ noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
 	callchain_param.record_mode = CALLCHAIN_DWARF;
 	dwarf_callchain_users = true;
 
-	machine = machine__new_live(/*kernel_maps=*/true, pid);
+	perf_env__init(&host_env);
+	machine = machine__new_live(&host_env, /*kernel_maps=*/true, pid);
 	if (!machine) {
 		pr_err("Could not get machine\n");
-		return -1;
+		goto out;
 	}
 
 	if (machine__create_kernel_maps(machine)) {
 		pr_err("Failed to create kernel maps\n");
-		return -1;
+		goto out;
 	}
 
 	if (verbose > 1)
@@ -213,6 +216,7 @@ noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
 
  out:
 	machine__delete(machine);
+	perf_env__exit(&host_env);
 	return err;
 }
 
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 446a3615d720..0c5619c6e6e9 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include "debug.h"
+#include "env.h"
 #include "event.h"
 #include "tests.h"
 #include "machine.h"
@@ -155,6 +156,7 @@ static int synth_process(struct machine *machine)
 
 static int mmap_events(synth_cb synth)
 {
+	struct perf_env host_env;
 	struct machine *machine;
 	int err, i;
 
@@ -167,7 +169,8 @@ static int mmap_events(synth_cb synth)
 	 */
 	TEST_ASSERT_VAL("failed to create threads", !threads_create());
 
-	machine = machine__new_host();
+	perf_env__init(&host_env);
+	machine = machine__new_host(&host_env);
 
 	dump_trace = verbose > 1 ? 1 : 0;
 
@@ -209,6 +212,7 @@ static int mmap_events(synth_cb synth)
 	}
 
 	machine__delete(machine);
+	perf_env__exit(&host_env);
 	return err;
 }
 
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index b07fdf831868..f4ffe5804f40 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -5,6 +5,7 @@
 #include <limits.h>
 #include "debug.h"
 #include "dso.h"
+#include "env.h"
 #include "machine.h"
 #include "thread.h"
 #include "symbol.h"
@@ -13,15 +14,18 @@
 #include "tests.h"
 
 struct test_info {
+	struct perf_env host_env;
 	struct machine *machine;
 	struct thread *thread;
 };
 
 static int init_test_info(struct test_info *ti)
 {
-	ti->machine = machine__new_host();
+	perf_env__init(&ti->host_env);
+	ti->machine = machine__new_host(&ti->host_env);
 	if (!ti->machine) {
 		pr_debug("machine__new_host() failed!\n");
+		perf_env__exit(&ti->host_env);
 		return TEST_FAIL;
 	}
 
@@ -29,6 +33,7 @@ static int init_test_info(struct test_info *ti)
 	ti->thread = machine__findnew_thread(ti->machine, 100, 100);
 	if (!ti->thread) {
 		pr_debug("machine__findnew_thread() failed!\n");
+		perf_env__exit(&ti->host_env);
 		return TEST_FAIL;
 	}
 
@@ -39,6 +44,7 @@ static void exit_test_info(struct test_info *ti)
 {
 	thread__put(ti->thread);
 	machine__delete(ti->machine);
+	perf_env__exit(&ti->host_env);
 }
 
 struct dso_map {
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 2878a7363ac8..1dfa4d0eec4d 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -17,6 +17,7 @@
 #include "addr_location.h"
 #include "color.h"
 #include "debug.h"
+#include "env.h"
 #include "event.h"
 #include "machine.h"
 #include "map.h"
@@ -309,8 +310,12 @@ void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
 {
 	/* TODO: async safety. printf, malloc, etc. aren't safe inside a signal handler. */
 	pid_t pid = getpid();
-	struct machine *machine = machine__new_live(/*kernel_maps=*/false, pid);
+	struct machine *machine;
 	struct thread *thread = NULL;
+	struct perf_env host_env;
+
+	perf_env__init(&host_env);
+	machine = machine__new_live(&host_env, /*kernel_maps=*/false, pid);
 
 	if (machine)
 		thread = machine__find_thread(machine, pid, pid);
@@ -323,6 +328,7 @@ void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
 		 */
 		backtrace_symbols_fd(stackdump, stackdump_size, fileno(file));
 		machine__delete(machine);
+		perf_env__exit(&host_env);
 		return;
 	}
 #endif
@@ -349,6 +355,7 @@ void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
 	}
 	thread__put(thread);
 	machine__delete(machine);
+	perf_env__exit(&host_env);
 }
 
 /* Obtain a backtrace and print it to stdout. */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2ef8c1cfae1e..b5dd42588c91 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -129,7 +129,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	return 0;
 }
 
-static struct machine *__machine__new_host(bool kernel_maps)
+static struct machine *__machine__new_host(struct perf_env *host_env, bool kernel_maps)
 {
 	struct machine *machine = malloc(sizeof(*machine));
 
@@ -142,13 +142,13 @@ static struct machine *__machine__new_host(bool kernel_maps)
 		free(machine);
 		return NULL;
 	}
-	machine->env = &perf_env;
+	machine->env = host_env;
 	return machine;
 }
 
-struct machine *machine__new_host(void)
+struct machine *machine__new_host(struct perf_env *host_env)
 {
-	return __machine__new_host(/*kernel_maps=*/true);
+	return __machine__new_host(host_env, /*kernel_maps=*/true);
 }
 
 static int mmap_handler(const struct perf_tool *tool __maybe_unused,
@@ -168,9 +168,9 @@ static int machine__init_live(struct machine *machine, pid_t pid)
 						  mmap_handler, machine, true);
 }
 
-struct machine *machine__new_live(bool kernel_maps, pid_t pid)
+struct machine *machine__new_live(struct perf_env *host_env, bool kernel_maps, pid_t pid)
 {
-	struct machine *machine = __machine__new_host(kernel_maps);
+	struct machine *machine = __machine__new_host(host_env, kernel_maps);
 
 	if (!machine)
 		return NULL;
@@ -182,9 +182,9 @@ struct machine *machine__new_live(bool kernel_maps, pid_t pid)
 	return machine;
 }
 
-struct machine *machine__new_kallsyms(void)
+struct machine *machine__new_kallsyms(struct perf_env *host_env)
 {
-	struct machine *machine = machine__new_host();
+	struct machine *machine = machine__new_host(host_env);
 	/*
 	 * FIXME:
 	 * 1) We should switch to machine__load_kallsyms(), i.e. not explicitly
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 180b369c366c..22a42c5825fa 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -169,9 +169,9 @@ struct thread *machine__findnew_guest_code(struct machine *machine, pid_t pid);
 void machines__set_id_hdr_size(struct machines *machines, u16 id_hdr_size);
 void machines__set_comm_exec(struct machines *machines, bool comm_exec);
 
-struct machine *machine__new_host(void);
-struct machine *machine__new_kallsyms(void);
-struct machine *machine__new_live(bool kernel_maps, pid_t pid);
+struct machine *machine__new_host(struct perf_env *host_env);
+struct machine *machine__new_kallsyms(struct perf_env *host_env);
+struct machine *machine__new_live(struct perf_env *host_env, bool kernel_maps, pid_t pid);
 int machine__init(struct machine *machine, const char *root_dir, pid_t pid);
 void machine__exit(struct machine *machine);
 void machine__delete_threads(struct machine *machine);
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 3c87aa6f7d3b..ac77ed0b7031 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -75,12 +75,14 @@ int e_snprintf(char *str, size_t size, const char *format, ...)
 }
 
 static struct machine *host_machine;
+static struct perf_env host_env;
 
 /* Initialize symbol maps and path of vmlinux/modules */
 int init_probe_symbol_maps(bool user_only)
 {
 	int ret;
 
+	perf_env__init(&host_env);
 	symbol_conf.allow_aliases = true;
 	ret = symbol__init(NULL);
 	if (ret < 0) {
@@ -94,7 +96,7 @@ int init_probe_symbol_maps(bool user_only)
 	if (symbol_conf.vmlinux_name)
 		pr_debug("Use vmlinux: %s\n", symbol_conf.vmlinux_name);
 
-	host_machine = machine__new_host();
+	host_machine = machine__new_host(&host_env);
 	if (!host_machine) {
 		pr_debug("machine__new_host() failed.\n");
 		symbol__exit();
@@ -111,6 +113,7 @@ void exit_probe_symbol_maps(void)
 	machine__delete(host_machine);
 	host_machine = NULL;
 	symbol__exit();
+	perf_env__exit(&host_env);
 }
 
 static struct ref_reloc_sym *kernel_get_ref_reloc_sym(struct map **pmap)
-- 
2.50.0.727.gbf7dc18ff4-goog

