Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5C3B8BC3;
	Wed,  1 Apr 2026 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077359; cv=none; b=nQ0N82NEYWJnFY/k5Vb0JmpxL7qH7sQFdXVGDQ+2qRvygEKBfqLSyGCrUFtuzvI9UpPxVlbdQTnQjFdzjzppBDddW/v/5FjPEsmflbi6ELDI/pn5t7e21mP1puJF5eS1HIVnJb71VJIRkilG4P/iEKFUlh9c7X922Di+if6g8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077359; c=relaxed/simple;
	bh=T09XRGHw0wt4kIggFrmFysE/zDedHmSZ60pG0WfLjVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUmlLEmpVSu5O4k0qoTHD2CHvFKcLujGrXmcRGtVAgl1stoOILJjRhVOGVG1Dfi+gjQCiso93Bm/8N9SnP0md4AWryDycU6neAau6QspvsTj0NUpmpVNa75woKy4PdVOw4kQP48ChINcSPt/XDufhTxHUej7snQZ2pNLwqsYV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/jqTu2G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/jqTu2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DD4C4CEF7;
	Wed,  1 Apr 2026 21:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775077359;
	bh=T09XRGHw0wt4kIggFrmFysE/zDedHmSZ60pG0WfLjVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/jqTu2GcMowgDyGAJoFfLap7n8tCurxeS08mx9r1/py+3Jy8g/Ted9E7f7AU83au
	 UA1DHJLABQf+uIJDNHsOCloSTZIRgw4+ZqExw9fNA6xd8svOQ3f2vXQuIuIFjTEB87
	 ebbzHl+W1U2whek2Bq+esAMHqSOIVWSn5MxggrsN8gYoJsyC1eGPmrzLUPEKFva1XH
	 uCIc0Bg0Rjc/UMtUck9RGda0i+iyBft6uOT58K6dBLyaMnsc7u4AzfH9b9DMyXkQCh
	 PjlhwTNqMpXdW9f0C3y8IT3CThxrEgdvKjzzKIshKj/tUAIuKdZ+EP6BNZhx3q16Yt
	 BnyTmtd1nX1BQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/4] perf bench: Constify tables
Date: Wed,  1 Apr 2026 18:02:01 -0300
Message-ID: <20260401210203.2150651-5-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401210203.2150651-1-acme@kernel.org>
References: <20260401210203.2150651-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Those tables and variables don't change, better capture this by
explicitely using 'const'.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-bench.c | 42 +++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 02dea1b8822864e8..02d47913cc6a3fae 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -37,14 +37,14 @@ struct bench {
 };
 
 #ifdef HAVE_LIBNUMA_SUPPORT
-static struct bench numa_benchmarks[] = {
+static const struct bench numa_benchmarks[] = {
 	{ "mem",	"Benchmark for NUMA workloads",			bench_numa		},
 	{ "all",	"Run all NUMA benchmarks",			NULL			},
 	{ NULL,		NULL,						NULL			}
 };
 #endif
 
-static struct bench sched_benchmarks[] = {
+static const struct bench sched_benchmarks[] = {
 	{ "messaging",	"Benchmark for scheduling and IPC",		bench_sched_messaging	},
 	{ "pipe",	"Benchmark for pipe() between two processes",	bench_sched_pipe	},
 	{ "seccomp-notify",	"Benchmark for seccomp user notify",	bench_sched_seccomp_notify},
@@ -52,7 +52,7 @@ static struct bench sched_benchmarks[] = {
 	{ NULL,		NULL,						NULL			}
 };
 
-static struct bench syscall_benchmarks[] = {
+static const struct bench syscall_benchmarks[] = {
 	{ "basic",	"Benchmark for basic getppid(2) calls",		bench_syscall_basic	},
 	{ "getpgid",	"Benchmark for getpgid(2) calls",		bench_syscall_getpgid	},
 	{ "fork",	"Benchmark for fork(2) calls",			bench_syscall_fork	},
@@ -61,7 +61,7 @@ static struct bench syscall_benchmarks[] = {
 	{ NULL,		NULL,						NULL			},
 };
 
-static struct bench mem_benchmarks[] = {
+static const struct bench mem_benchmarks[] = {
 	{ "memcpy",	"Benchmark for memcpy() functions",		bench_mem_memcpy	},
 	{ "memset",	"Benchmark for memset() functions",		bench_mem_memset	},
 	{ "find_bit",	"Benchmark for find_bit() functions",		bench_mem_find_bit	},
@@ -70,7 +70,7 @@ static struct bench mem_benchmarks[] = {
 	{ NULL,		NULL,						NULL			}
 };
 
-static struct bench futex_benchmarks[] = {
+static const struct bench futex_benchmarks[] = {
 	{ "hash",	"Benchmark for futex hash table",               bench_futex_hash	},
 	{ "wake",	"Benchmark for futex wake calls",               bench_futex_wake	},
 	{ "wake-parallel", "Benchmark for parallel futex wake calls",   bench_futex_wake_parallel },
@@ -82,7 +82,7 @@ static struct bench futex_benchmarks[] = {
 };
 
 #ifdef HAVE_EVENTFD_SUPPORT
-static struct bench epoll_benchmarks[] = {
+static const struct bench epoll_benchmarks[] = {
 	{ "wait",	"Benchmark epoll concurrent epoll_waits",       bench_epoll_wait	},
 	{ "ctl",	"Benchmark epoll concurrent epoll_ctls",        bench_epoll_ctl		},
 	{ "all",	"Run all futex benchmarks",			NULL			},
@@ -90,7 +90,7 @@ static struct bench epoll_benchmarks[] = {
 };
 #endif // HAVE_EVENTFD_SUPPORT
 
-static struct bench internals_benchmarks[] = {
+static const struct bench internals_benchmarks[] = {
 	{ "synthesize", "Benchmark perf event synthesis",	bench_synthesize	},
 	{ "kallsyms-parse", "Benchmark kallsyms parsing",	bench_kallsyms_parse	},
 	{ "inject-build-id", "Benchmark build-id injection",	bench_inject_build_id	},
@@ -99,14 +99,14 @@ static struct bench internals_benchmarks[] = {
 	{ NULL,		NULL,					NULL			}
 };
 
-static struct bench breakpoint_benchmarks[] = {
+static const struct bench breakpoint_benchmarks[] = {
 	{ "thread", "Benchmark thread start/finish with breakpoints", bench_breakpoint_thread},
 	{ "enable", "Benchmark breakpoint enable/disable", bench_breakpoint_enable},
 	{ "all", "Run all breakpoint benchmarks", NULL},
 	{ NULL,	NULL, NULL },
 };
 
-static struct bench uprobe_benchmarks[] = {
+static const struct bench uprobe_benchmarks[] = {
 	{ "baseline",	"Baseline libc usleep(1000) call",				bench_uprobe_baseline,	},
 	{ "empty",	"Attach empty BPF prog to uprobe on usleep, system wide",	bench_uprobe_empty,	},
 	{ "trace_printk", "Attach trace_printk BPF prog to uprobe on usleep syswide",	bench_uprobe_trace_printk,	},
@@ -116,12 +116,12 @@ static struct bench uprobe_benchmarks[] = {
 };
 
 struct collection {
-	const char	*name;
-	const char	*summary;
-	struct bench	*benchmarks;
+	const char		*name;
+	const char		*summary;
+	const struct bench	*benchmarks;
 };
 
-static struct collection collections[] = {
+static const struct collection collections[] = {
 	{ "sched",	"Scheduler and IPC benchmarks",			sched_benchmarks	},
 	{ "syscall",	"System call benchmarks",			syscall_benchmarks	},
 	{ "mem",	"Memory access benchmarks",			mem_benchmarks		},
@@ -147,9 +147,9 @@ static struct collection collections[] = {
 #define for_each_bench(coll, bench) \
 	for (bench = coll->benchmarks; bench && bench->name; bench++)
 
-static void dump_benchmarks(struct collection *coll)
+static void dump_benchmarks(const struct collection *coll)
 {
-	struct bench *bench;
+	const struct bench *bench;
 
 	printf("\n        # List of available benchmarks for collection '%s':\n\n", coll->name);
 
@@ -178,7 +178,7 @@ static const char * const bench_usage[] = {
 
 static void print_usage(void)
 {
-	struct collection *coll;
+	const struct collection *coll;
 	int i;
 
 	printf("Usage: \n");
@@ -234,9 +234,9 @@ static int run_bench(const char *coll_name, const char *bench_name, bench_fn_t f
 	return ret;
 }
 
-static void run_collection(struct collection *coll)
+static void run_collection(const struct collection *coll)
 {
-	struct bench *bench;
+	const struct bench *bench;
 	const char *argv[2];
 
 	argv[1] = NULL;
@@ -260,7 +260,7 @@ static void run_collection(struct collection *coll)
 
 static void run_all_collections(void)
 {
-	struct collection *coll;
+	const struct collection *coll;
 
 	for_each_collection(coll)
 		run_collection(coll);
@@ -268,7 +268,7 @@ static void run_all_collections(void)
 
 int cmd_bench(int argc, const char **argv)
 {
-	struct collection *coll;
+	const struct collection *coll;
 	int ret = 0;
 
 	/* Unbuffered output */
@@ -306,7 +306,7 @@ int cmd_bench(int argc, const char **argv)
 	}
 
 	for_each_collection(coll) {
-		struct bench *bench;
+		const struct bench *bench;
 
 		if (strcmp(coll->name, argv[0]))
 			continue;
-- 
2.53.0

