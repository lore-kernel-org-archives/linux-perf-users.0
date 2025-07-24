Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3ED2EF2AE
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374838; cv=none; b=FrVZLiAG6znmhs4xi0fXSpBymS5NxTXjTt41Q90oz+qwWloHSQ/4b32hjB9ddzH6CzEY4WmnfaWmZUQhAOv4ibAGr7x1NUCzyPpSU9gPykKrgkk/Z1qJOfrW3l2U6zdiO+usmXvUBnuPbOnqPM+R59dkxQ3E0X+pbWXLU0LqfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374838; c=relaxed/simple;
	bh=gpSlR0ht3SUqBmpJ17/QyzKwFWFkf2MsIuwkYslnOC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bYV7HazGGZtxCEHDLGms4+KUUk2dO7Tw6R514UhpXdgSKptaW3ILe7DzXeLPdsmzQbvmAaoCBpCbJqATaZMZycgNJ5D5Vh2aci4ENW/L+PfQwO5K//3feBm+WW6vXvpNrn2SREL9hNYNig+yNXx1wNUcDMjNMtSuOyLzRDEwHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=enQwic+J; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enQwic+J"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3f321dc6abso935365a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374836; x=1753979636; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TvIgDx3hdm9MFGvj7TyBUyq2eXQ45SEy4Oqh3QlaoGU=;
        b=enQwic+J9xlLuWTBfurZI8g2tCncoCCLa7gJg3UGPD9MKeZh+QyGNA52qEuy5Cw+oz
         cFXtQpb+kgX1bXpPvTSPgMd0lFhkne+9tiJPJACGKUe6qVqKsr+gauiWvJ9aF9HggiU+
         WDRtNVMAd4ixiuzpgmX8f1pj6dBbHLyypbk+P3Ka384ej3VON6CY5yT5Kh8bhsOZucoq
         PeGNv3SWgtfl483x9KvaSaU6N0QPIn9hkglihzT8KelLNaapSaYiT6TtvtTj+ThOlVtB
         fNRkgKoRChuLHfZ/ITu2TjKN1r3dvvGS27QjEHfe/bgyQMVFNO1edSShOCfym0gp3xK7
         8VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374836; x=1753979636;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvIgDx3hdm9MFGvj7TyBUyq2eXQ45SEy4Oqh3QlaoGU=;
        b=RGRnbxSv84r0LDl329O0IF6GXNH8Yg0vqXo+jHoqkNUr6CfKE+hnct8QV2NOux95kp
         5QE8qP5WmMmf2szWzcaGR9qyWpM95L7ALBDISyr+MvlXrPY8UCtQVWpkcuqQHQa+EKgd
         +ScBsXmLfUZ1y9LMiMfjStSyhQgDrqETtbMYopHLJ1vOhMFXRq3RnGi7ngYNcdjO1Mnd
         co3qBof9Rw6HitlepjA4w5It4W3g6R/DCUNrdg9W5oMAQz2HPCog3z/Pplt2YGr67W+z
         8bC5qVJLJCCqBXOTkmilg8F6XA0RMjJvYpzC8rvP8w8iHcshxdi3c+zRA2XblsI4lXOM
         Kc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXL8ko1JRjZkAM+28zjya+nGOV7mTBZ6OKmdBHR0YtM05OHLfijUE7kvLZlEOBuF+5aPQ/7FiCjF2nSvhlBemo2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2d97iu0Ox3Ox2Oxs8jn14lnquaJ/6ZQzoV2UbbEc/42ZcQnZw
	1xntTEpEkpFzf1qlQj04nlqHZYDnfxF0fJP4bOqmZ9sQVaWvklj+TQd0iSRxg6aAepG/yK8rHlL
	uoUY+owZhCQ==
X-Google-Smtp-Source: AGHT+IGY5+X5VenXLw4NgsPz1dwZLOq94AaciEsnNpmT8YVcLOiUIbz4W6A+tuywnF/VSXiWpM+G+Sts0TLw
X-Received: from plwp2.prod.google.com ([2002:a17:903:2482:b0:234:bcd2:f39b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da92:b0:23d:dcf5:4806
 with SMTP id d9443c01a7336-23f981d601emr106539755ad.39.1753374835791; Thu, 24
 Jul 2025 09:33:55 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:56 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-17-irogers@google.com>
Subject: [PATCH v6 16/22] perf machine: Explicitly pass in host perf_env
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
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Matt Fleming <matt@readmodwrite.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
index 0261f4eefe6d..5b53571de400 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -140,6 +140,7 @@ struct syscall_fmt {
 };
 
 struct trace {
+	struct perf_env		host_env;
 	struct perf_tool	tool;
 	struct {
 		/** Sorted sycall numbers used by the trace. */
@@ -1977,17 +1978,24 @@ static char *trace__machine__resolve_kernel_addr(void *vmachine, unsigned long l
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
@@ -1998,9 +2006,10 @@ static int trace__symbols_init(struct trace *trace, struct evlist *evlist)
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
 
@@ -2009,6 +2018,7 @@ static void trace__symbols__exit(struct trace *trace)
 	machine__exit(trace->host);
 	trace->host = NULL;
 
+	perf_env__exit(&trace->host_env);
 	symbol__exit();
 }
 
@@ -4428,7 +4438,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
-	err = trace__symbols_init(trace, evlist);
+	err = trace__symbols_init(trace, argc, argv, evlist);
 	if (err < 0) {
 		fprintf(trace->output, "Problems initializing symbol libraries!\n");
 		goto out_delete_evlist;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 0ec7004f90fe..9c2091310191 100644
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
index e11c1be5c6d5..85e096ed07e6 100644
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

