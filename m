Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1247ACE7
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068989; cv=none; b=Vu+Vy0cVGLSKNHK04ZCIjs8tsgg4APM4z/eOaq4/Mq7SBjLy/ZHGd/c8P04/8mKp4Hqiuv+GGgN9eD7Uzo6MJ8uRJ7MxKv894lfuK+hOfMuzfAhJksZMI2DxYy39VxdEdFLxukMHWcCZ4/wvE6jYngcSb8Xhjqa7suCpcsj9QEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068989; c=relaxed/simple;
	bh=D1eJ/geZJZR/PZqhePLfozr+1pR2qAIBlaiQQbSpEoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RigZrLwttlGxX6NvtXoqMPXAm78Ulkb7EYFVEcMB18Yyy7Y5o7OlG/snZSafeqQw8ShGzppN1pFrK//aCuQr2oRF7KIg6aaXsJy3QFmLFSF2rF/tC11s05oJVemyk0lo8+w1hwi9kTmqSrnDcYfMwZQ3f7R4j+ifVMS/ggQrvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=rFqfimw5; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="rFqfimw5"
Received: from ms-a2 (M106072126074.v4.enabler.ne.jp [106.72.126.74])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67IEfpNT058426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 18 Aug 2026 23:41:51 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=heCAkoDy66DtvJFNPPuf/D8VWawYbQ5I8BNIOs+N8y8=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1787064111; v=1;
        b=rFqfimw5+ZHcyZod9yxIOghCsTK694udJFvnUyzxQgbRN5rT7CMVCbnjdweyJE17
         mzkE1X0Lc76wx+plp+EBtuKjO20GVyyojrDbjZQHYLANBS4kc+52J4A5XCL8sXH3
         IQIJVF0QVtJ3ENcp0cXSgWMg/wKZxL7aBToD5mJGNOa3Zoi4h0bNSrcKIbLjfeU4
         XjuxBvqSYow2lRr06I5MM1/lH8eoIGAdriu9FT/h47VZAEhNt9I2mH3DqIG6EHNL
         KMT6I/uyuIAxBU1SfYSAjR6eRhv04fwj/p0PQ4Qh373K76/KAP5MpXgd4lU386o/
         +IjPHHjoj69uU6epAHty1w==
From: Kohei Enju <kohei@enjuk.jp>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 2/2] perf annotate: Honor explicit --source option
Date: Tue, 18 Aug 2026 14:40:13 +0000
Message-ID: <20260818144149.101248-3-kohei@enjuk.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144149.101248-1-kohei@enjuk.jp>
References: <20260818144149.101248-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Source annotation is hidden by default to avoid forcing objdump -S, but
currently an explicit --source doesn't override annotate.hide_src_code.

In TUI mode, source code can be shown later with the 's' hotkey, which
re-runs annotation with hide_src_code cleared. In --stdio/--stdio2 mode,
there is no such interactive fallback, so --source did not show source
code unless users also set annotate.hide_src_code=false globally in
advance.

Track whether --source/--no-source was specified and synchronize
hide_src_code only in that case.

Fixes: e201757f7a0a ("perf annotate: Fix source code annotate with objdump")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 tools/perf/Documentation/perf-annotate.txt | 4 ++--
 tools/perf/Documentation/perf-report.txt   | 4 ++--
 tools/perf/Documentation/perf-top.txt      | 4 ++--
 tools/perf/builtin-annotate.c              | 7 +++++--
 tools/perf/builtin-report.c                | 7 +++++--
 tools/perf/builtin-top.c                   | 7 +++++--
 6 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index a688738809c4..dc5866cf6666 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -107,8 +107,8 @@ include::itrace.txt[]
 --show-total-period:: Show a column with the sum of periods.
 
 --source::
-	Interleave source code with assembly code. Enabled by default,
-	disable with --no-source.
+	Interleave source code with assembly code. This may use objdump and be
+	slower than the default disassembly. Disable with --no-source.
 
 --symfs=<directory[,layout]>::
         Look for files with symbols relative to this directory. The optional
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 22f87eaa3279..d494b9a37663 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -388,8 +388,8 @@ OPTIONS
 --disassembler-style=:: Set disassembler style for objdump.
 
 --source::
-	Interleave source code with assembly code. Enabled by default,
-	disable with --no-source.
+	Interleave source code with assembly code. This may use objdump and be
+	slower than the default disassembly. Disable with --no-source.
 
 --asm-raw::
 	Show raw instruction encoding of assembly instructions.
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index af3e4230c72f..0e5372988a1f 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -178,8 +178,8 @@ Default is to monitor all CPUS.
         with different file system layout.
 
 --source::
-	Interleave source code with assembly code. Enabled by default,
-	disable with --no-source.
+	Interleave source code with assembly code. This may use objdump and be
+	slower than the default disassembly. Disable with --no-source.
 
 --asm-raw::
 	Show raw instruction encoding of assembly instructions.
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8a0eb30eac24..cb8ce851a81e 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -692,6 +692,7 @@ static const char * const annotate_usage[] = {
 int cmd_annotate(int argc, const char **argv)
 {
 	struct perf_annotate annotate = {};
+	bool source_set = false;
 	struct perf_data data = {
 		.mode  = PERF_DATA_MODE_READ,
 	};
@@ -738,8 +739,8 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_STRING('C', "cpu", &annotate.cpu_list, "cpu", "list of cpus to profile"),
 	OPT_CALLBACK(0, "symfs", NULL, "directory[,layout]", SYMFS_HELP,
 		     symbol__config_symfs),
-	OPT_BOOLEAN(0, "source", &annotate_opts.annotate_src,
-		    "Interleave source code with assembly code (default)"),
+	OPT_BOOLEAN_SET(0, "source", &annotate_opts.annotate_src, &source_set,
+			"Interleave source code with assembly code"),
 	OPT_BOOLEAN(0, "asm-raw", &annotate_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
@@ -798,6 +799,8 @@ int cmd_annotate(int argc, const char **argv)
 	annotation_config__init();
 
 	argc = parse_options(argc, argv, options, annotate_usage, 0);
+	if (source_set)
+		annotate_opts.hide_src_code = !annotate_opts.annotate_src;
 	if (argc) {
 		/*
 		 * Special case: if there's an argument left then assume that
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index dd1309c32094..cfd611ca6ffe 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1306,6 +1306,7 @@ int cmd_report(int argc, const char **argv)
 	struct itrace_synth_opts itrace_synth_opts = { .set = 0, };
 	struct stat st;
 	bool has_br_stack = false;
+	bool source_set = false;
 	int branch_mode = -1;
 	int last_key = 0;
 	bool branch_call_mode = false;
@@ -1420,8 +1421,8 @@ int cmd_report(int argc, const char **argv)
 		   "only consider these parallelism levels (cpu set format)"),
 	OPT_BOOLEAN('I', "show-info", &report.show_full_info,
 		    "Display extended information about perf.data file"),
-	OPT_BOOLEAN(0, "source", &annotate_opts.annotate_src,
-		    "Interleave source code with assembly code (default)"),
+	OPT_BOOLEAN_SET(0, "source", &annotate_opts.annotate_src, &source_set,
+			"Interleave source code with assembly code"),
 	OPT_BOOLEAN(0, "asm-raw", &annotate_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
@@ -1853,6 +1854,8 @@ int cmd_report(int argc, const char **argv)
 			symbol_conf.priv_size += sizeof(u32);
 		}
 		annotation_config__init();
+		if (source_set)
+			annotate_opts.hide_src_code = !annotate_opts.annotate_src;
 	}
 
 	if (symbol__init(perf_session__env(session)) < 0)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1211401616ee..cc06e7332e47 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1483,6 +1483,7 @@ int cmd_top(int argc, const char **argv)
 		.evlistp = &top.evlist,
 	};
 	bool branch_call_mode = false;
+	bool source_set = false;
 	struct record_opts *opts = &top.record_opts;
 	struct target *target = &opts->target;
 	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
@@ -1566,8 +1567,8 @@ int cmd_top(int argc, const char **argv)
 		   "only consider symbols in these comms"),
 	OPT_STRING(0, "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
 		   "only consider these symbols"),
-	OPT_BOOLEAN(0, "source", &annotate_opts.annotate_src,
-		    "Interleave source code with assembly code (default)"),
+	OPT_BOOLEAN_SET(0, "source", &annotate_opts.annotate_src, &source_set,
+			"Interleave source code with assembly code"),
 	OPT_BOOLEAN(0, "asm-raw", &annotate_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
@@ -1851,6 +1852,8 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 
 	annotation_config__init();
+	if (source_set)
+		annotate_opts.hide_src_code = !annotate_opts.annotate_src;
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
 	status = symbol__init(NULL);
-- 
2.53.0

