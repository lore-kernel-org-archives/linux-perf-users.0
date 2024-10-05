Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8C17BB2E
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Oct 2024 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158183; cv=none; b=uBObIIIc0nwncb2KaP5KwIH+HG1p5o7ftlSk2bceoMjEpToe6guSKuT5Sw3McZh5S5ty9cwNDsylgKRvzBXv+9Np72b/bY3c3FUiqQFthfhxACYKVY/bs51iPwIY3GpO6f4gYNJzIH9p9CkI+J5Fw0Zv8cQR1fssj6WfuzwjaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158183; c=relaxed/simple;
	bh=CRvvf13d3q83pWTqjfT6czVP0IY2S+zPjy6zwF2yPMs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=a4EC5I93O0/f9W+DJftOZo0hSoEZb975GEDbqHhDf1P+EocyL2zb3Myj8QCxinnbovx7WzWDwJIK2KFyoYjVmGmxNN7rtMMWeucaCHU8hSQH+rJDHhm5UYFm6DIJrdQbI79j4Uk3PTdw0raRkNDsYQE7Hn45779qoyxxiu7TTuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMaZqdhl; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMaZqdhl"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so4310346276.2
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 12:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158181; x=1728762981; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2weo1u6eJab13hudlOmWRO+RLXcMfS57bPP8mqYQr4Q=;
        b=lMaZqdhltBX6pR8kLB75QRMUdqiYCTOX5qGgN1N0W6IIRAxflY/in2MTVoS84I5AfA
         rmSqJvl6A7IUucJLrgS+pheB5YA4ZABjUvvj906gyxiYj5W2hKS9+GvdIvAgNTeUaCeR
         hRKhi4UjzUGn/UzsBphTRxQbIUVfQxgjLLmkJ3VLdUks4k9cwrMBXIG29GqvGH/i2QKs
         kOUpkaxtJdjmzZaO72rgVduTtxHx1kvyrvD6nlRVj5Ad2/weabWY6pJFKwmGo9kUu+rx
         AC84PqocXZ8R3TcnLHZtjYLwSs6uWX8psICPabSgpRBFmCEUBWEhsDAXkWbaRuG40ryp
         ODkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158181; x=1728762981;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2weo1u6eJab13hudlOmWRO+RLXcMfS57bPP8mqYQr4Q=;
        b=T4SsN9V65yoM8GJeF48i5Rtpo+BG49N9aT52HyUMmxWz1HGZ6cVYzocTk5dxXaxUuP
         FZI+q6at9b8e+dem/2ik2BfCxUQDCtDRzOdzbzu3p5ixXzZoGreoGbnwfYkYP2XJU4F5
         2LqZad2xY2ygP5z8eCE3eUqVmMGuoaAogf14UWzG58s0LlbXAOE+R4wk9kZLd9V7ryLX
         y/okD1rMTE8GczUUuvpVlO9WSAotKQOyjYvJxTzYKnmXnaXzCnPKDUzMDMmwEVd6c5n8
         V8jf7udnVHZ8SnqyKDPRYR1h1F95/BGUD9FXCi53VvtOlL8DwALfoI4dSjMIlFmT9RDp
         3fpg==
X-Forwarded-Encrypted: i=1; AJvYcCVdhKREcowIRfebD2fY7CtXe0/UmRwPSAM0ooGUiSwFYqFBgMvtw+epHcUEuaTza9p7ZeEQmCTzv5VfemsC2a83@vger.kernel.org
X-Gm-Message-State: AOJu0YzaWKPyYmzhPhK2Rf13qJu0R7P2bH+ns7YtEHz3xVNwKk8uaReQ
	n/MLZs1YIK/Vq6fAPOdDfUbRSHBd0xQnZrkzlBZADzi1MdNhMsCODfgtivdEVU27irOr4iojM+6
	4gCRvQw==
X-Google-Smtp-Source: AGHT+IGTVKp5glYfe2LcW/QBGKVgQh88dtHx+qbHTcL04F4exiXlFCRXn1VDeNIb6C1tqNw4F+4YBmNj+fNW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:c54e:0:b0:e25:17cb:352e with SMTP id
 3f1490d57ef6-e2893939e1cmr3895276.9.1728158180743; Sat, 05 Oct 2024 12:56:20
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:20 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 10/31] perf build: Rename HAVE_DWARF_SUPPORT to HAVE_LIBDW_SUPPORT
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

In Makefile.config for unwinding the name dwarf implies either
libunwind or libdw. Make it clearer that HAVE_DWARF_SUPPORT is really
just defined when libdw is present by renaming to HAVE_LIBDW_SUPPORT.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-check.txt         |  6 +++---
 tools/perf/Makefile.config                      |  2 +-
 tools/perf/arch/powerpc/annotate/instructions.c |  4 ++--
 tools/perf/arch/x86/annotate/instructions.c     |  2 +-
 tools/perf/builtin-annotate.c                   |  2 +-
 tools/perf/builtin-check.c                      |  6 +++---
 tools/perf/builtin-probe.c                      | 12 ++++++------
 tools/perf/builtin-report.c                     |  4 ++--
 tools/perf/util/annotate-data.h                 |  8 ++++----
 tools/perf/util/debuginfo.h                     |  6 +++---
 tools/perf/util/disasm.c                        |  4 ++--
 tools/perf/util/disasm.h                        |  4 ++--
 tools/perf/util/genelf.c                        |  4 ++--
 tools/perf/util/genelf.h                        |  2 +-
 tools/perf/util/include/dwarf-regs.h            |  6 +++---
 tools/perf/util/probe-event.c                   |  4 ++--
 tools/perf/util/probe-finder.h                  |  4 ++--
 17 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index 45101a8e4154..31741499e786 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -47,15 +47,15 @@ feature::
                 bpf                     /  HAVE_LIBBPF_SUPPORT
                 bpf_skeletons           /  HAVE_BPF_SKEL
                 debuginfod              /  HAVE_DEBUGINFOD_SUPPORT
-                dwarf                   /  HAVE_DWARF_SUPPORT
-                dwarf_getlocations      /  HAVE_DWARF_SUPPORT
+                dwarf                   /  HAVE_LIBDW_SUPPORT
+                dwarf_getlocations      /  HAVE_LIBDW_SUPPORT
                 dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
                 auxtrace                /  HAVE_AUXTRACE_SUPPORT
                 libaudit                /  HAVE_LIBAUDIT_SUPPORT
                 libbfd                  /  HAVE_LIBBFD_SUPPORT
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
                 libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
-                libdw-dwarf-unwind      /  HAVE_DWARF_SUPPORT
+                libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
                 libelf                  /  HAVE_LIBELF_SUPPORT
                 libnuma                 /  HAVE_LIBNUMA_SUPPORT
                 libopencsd              /  HAVE_CSTRACE_SUPPORT
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index db79b25ada6f..9ed0909db170 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -556,7 +556,7 @@ ifndef NO_LIBELF
       $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
       NO_LIBDW := 1
     else
-      CFLAGS += -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
+      CFLAGS += -DHAVE_LIBDW_SUPPORT $(LIBDW_CFLAGS)
       LDFLAGS += $(LIBDW_LDFLAGS)
       EXTLIBS += ${DWARFLIBS}
       $(call detected,CONFIG_DWARF)
diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
index ede9eeade0ab..54478cf5cccc 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/arch/powerpc/annotate/instructions.c
@@ -255,7 +255,7 @@ static struct ins_ops *check_ppc_insn(struct disasm_line *dl)
  * is moved to r31. update_insn_state_powerpc tracks these state
  * changes
  */
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 static void update_insn_state_powerpc(struct type_state *state,
 		struct data_loc_info *dloc, Dwarf_Die * cu_die __maybe_unused,
 		struct disasm_line *dl)
@@ -300,7 +300,7 @@ static void update_insn_state_powerpc(struct type_state *state,
 			insn_offset, src->reg1, dst->reg1);
 	pr_debug_type_name(&tsr->type, tsr->kind);
 }
-#endif /* HAVE_DWARF_SUPPORT */
+#endif /* HAVE_LIBDW_SUPPORT */
 
 static int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 5caf5a17f03d..c869abe3c31d 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -207,7 +207,7 @@ static int x86__annotate_init(struct arch *arch, char *cpuid)
 	return err;
 }
 
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 static void update_insn_state_x86(struct type_state *state,
 				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				  struct disasm_line *dl)
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 04af13eb4a4c..bb87e6e7687d 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -840,7 +840,7 @@ int cmd_annotate(int argc, const char **argv)
 	}
 #endif
 
-#ifndef HAVE_DWARF_SUPPORT
+#ifndef HAVE_LIBDW_SUPPORT
 	if (annotate.data_type) {
 		pr_err("Error: Data type profiling is disabled due to missing DWARF support\n");
 		return -ENOTSUP;
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 18c0a815243b..2346536a5ee1 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -27,15 +27,15 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("bpf", HAVE_LIBBPF_SUPPORT),
 	FEATURE_STATUS("bpf_skeletons", HAVE_BPF_SKEL),
 	FEATURE_STATUS("debuginfod", HAVE_DEBUGINFOD_SUPPORT),
-	FEATURE_STATUS("dwarf", HAVE_DWARF_SUPPORT),
-	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_SUPPORT),
+	FEATURE_STATUS("dwarf", HAVE_LIBDW_SUPPORT),
+	FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
 	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
 	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
-	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_DWARF_SUPPORT),
+	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
 	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 91672bb3047c..69800e4d9530 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -229,7 +229,7 @@ static int opt_set_target_ns(const struct option *opt __maybe_unused,
 
 /* Command option callbacks */
 
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 static int opt_show_lines(const struct option *opt,
 			  const char *str, int unset __maybe_unused)
 {
@@ -505,7 +505,7 @@ static int perf_del_probe_events(struct strfilter *filter)
 	return ret;
 }
 
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 #define PROBEDEF_STR	\
 	"[EVENT=]FUNC[@SRC][+OFF|%return|:RL|;PT]|SRC:AL|SRC;PT [[NAME=]ARG ...]"
 #else
@@ -521,7 +521,7 @@ __cmd_probe(int argc, const char **argv)
 		"perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]",
 		"perf probe [<options>] --del '[GROUP:]EVENT' ...",
 		"perf probe --list [GROUP:]EVENT ...",
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 		"perf probe [<options>] --line 'LINEDESC'",
 		"perf probe [<options>] --vars 'PROBEPOINT'",
 #endif
@@ -545,7 +545,7 @@ __cmd_probe(int argc, const char **argv)
 		"\t\tFUNC:\tFunction name\n"
 		"\t\tOFF:\tOffset from function entry (in byte)\n"
 		"\t\t%return:\tPut the probe at function return\n"
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 		"\t\tSRC:\tSource code path\n"
 		"\t\tRL:\tRelative line number from function entry.\n"
 		"\t\tAL:\tAbsolute line number in file.\n"
@@ -612,7 +612,7 @@ __cmd_probe(int argc, const char **argv)
 	set_option_flag(options, 'd', "del", PARSE_OPT_EXCLUSIVE);
 	set_option_flag(options, 'D', "definition", PARSE_OPT_EXCLUSIVE);
 	set_option_flag(options, 'l', "list", PARSE_OPT_EXCLUSIVE);
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 	set_option_flag(options, 'L', "line", PARSE_OPT_EXCLUSIVE);
 	set_option_flag(options, 'V', "vars", PARSE_OPT_EXCLUSIVE);
 #else
@@ -694,7 +694,7 @@ __cmd_probe(int argc, const char **argv)
 		if (ret < 0)
 			pr_err_with_code("  Error: Failed to show functions.", ret);
 		return ret;
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 	case 'L':
 		ret = show_line_range(&params->line_range, params->target,
 				      params->nsi, params->uprobes);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 426cbc9110d1..13cc57e99d35 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -455,7 +455,7 @@ static int report__setup_sample_type(struct report *rep)
 	if (!(evlist__combined_branch_type(session->evlist) & PERF_SAMPLE_BRANCH_ANY))
 		rep->nonany_branch_mode = true;
 
-#if !defined(HAVE_LIBUNWIND_SUPPORT) && !defined(HAVE_DWARF_SUPPORT)
+#if !defined(HAVE_LIBUNWIND_SUPPORT) && !defined(HAVE_LIBDW_SUPPORT)
 	if (dwarf_callchain_users) {
 		ui__warning("Please install libunwind or libdw "
 			    "development packages during the perf build.\n");
@@ -1701,7 +1701,7 @@ int cmd_report(int argc, const char **argv)
 		report.data_type = true;
 		annotate_opts.annotate_src = false;
 
-#ifndef HAVE_DWARF_SUPPORT
+#ifndef HAVE_LIBDW_SUPPORT
 		pr_err("Error: Data type profiling is disabled due to missing DWARF support\n");
 		goto error;
 #endif
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 8ac0fd94a0ba..98c80b2268dd 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -9,7 +9,7 @@
 #include "dwarf-regs.h"
 #include "annotate.h"
 
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 #include "debuginfo.h"
 #endif
 
@@ -165,7 +165,7 @@ struct annotated_data_stat {
 };
 extern struct annotated_data_stat ann_data_stat;
 
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 /*
  * Type information in a register, valid when @ok is true.
  * The @caller_saved registers are invalidated after a function call.
@@ -244,7 +244,7 @@ bool get_global_var_info(struct data_loc_info *dloc, u64 addr,
 				const char **var_name, int *var_offset);
 void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind);
 
-#else /* HAVE_DWARF_SUPPORT */
+#else /* HAVE_LIBDW_SUPPORT */
 
 static inline struct annotated_data_type *
 find_data_type(struct data_loc_info *dloc __maybe_unused)
@@ -276,7 +276,7 @@ static inline int hist_entry__annotate_data_tty(struct hist_entry *he __maybe_un
 	return -1;
 }
 
-#endif /* HAVE_DWARF_SUPPORT */
+#endif /* HAVE_LIBDW_SUPPORT */
 
 #ifdef HAVE_SLANG_SUPPORT
 int hist_entry__annotate_data_tui(struct hist_entry *he, struct evsel *evsel,
diff --git a/tools/perf/util/debuginfo.h b/tools/perf/util/debuginfo.h
index ad6422c3f8ca..a52d69932815 100644
--- a/tools/perf/util/debuginfo.h
+++ b/tools/perf/util/debuginfo.h
@@ -5,7 +5,7 @@
 #include <errno.h>
 #include <linux/compiler.h>
 
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 
 #include "dwarf-aux.h"
 
@@ -25,7 +25,7 @@ void debuginfo__delete(struct debuginfo *dbg);
 int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
 			       bool adjust_offset);
 
-#else /* HAVE_DWARF_SUPPORT */
+#else /* HAVE_LIBDW_SUPPORT */
 
 /* dummy debug information structure */
 struct debuginfo {
@@ -49,7 +49,7 @@ static inline int debuginfo__get_text_offset(struct debuginfo *dbg __maybe_unuse
 	return -EINVAL;
 }
 
-#endif /* HAVE_DWARF_SUPPORT */
+#endif /* HAVE_LIBDW_SUPPORT */
 
 #ifdef HAVE_DEBUGINFOD_SUPPORT
 int get_source_from_debuginfod(const char *raw_path, const char *sbuild_id,
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 2c8063660f2e..aef06a36bf40 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -151,14 +151,14 @@ static struct arch architectures[] = {
 			.memory_ref_char = '(',
 			.imm_char = '$',
 		},
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 		.update_insn_state = update_insn_state_x86,
 #endif
 	},
 	{
 		.name = "powerpc",
 		.init = powerpc__annotate_init,
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 		.update_insn_state = update_insn_state_powerpc,
 #endif
 	},
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index f56beedeb9da..486c269b29ba 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -4,7 +4,7 @@
 
 #include "map_symbol.h"
 
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 #include "dwarf-aux.h"
 #endif
 
@@ -39,7 +39,7 @@ struct arch {
 		char memory_ref_char;
 		char imm_char;
 	} objdump;
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 	void		(*update_insn_state)(struct type_state *state,
 				struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				struct disasm_line *dl);
diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index c8f6bee1fa61..cdce7f173d00 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -16,7 +16,7 @@
 #include <inttypes.h>
 #include <fcntl.h>
 #include <err.h>
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 #include <dwarf.h>
 #endif
 
@@ -499,7 +499,7 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
 	shdr->sh_size = sizeof(bnote);
 	shdr->sh_entsize = 0;
 
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 	if (debug && nr_debug_entries) {
 		retval = jit_add_debug_info(e, load_addr, debug, nr_debug_entries);
 		if (retval)
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index 4e2e4f40e134..9f0b875d6548 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -8,7 +8,7 @@
 int jit_write_elf(int fd, uint64_t code_addr, const char *sym,
 		  const void *code, int csize, void *debug, int nr_debug_entries,
 		  void *unwinding, uint64_t unwinding_header_size, uint64_t unwinding_size);
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 /* genelf_debug.c */
 int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_entries);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 75b28dcc8317..29a7d0546b82 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -6,7 +6,7 @@
 #define DWARF_REG_PC  0xd3af9c /* random number */
 #define DWARF_REG_FB  0xd3affb /* random number */
 
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 const char *get_arch_regstr(unsigned int n);
 /*
  * get_dwarf_regstr - Returns ftrace register string from DWARF regnum
@@ -23,7 +23,7 @@ int get_arch_regnum(const char *name);
  */
 int get_dwarf_regnum(const char *name, unsigned int machine);
 
-#else /* HAVE_DWARF_SUPPORT */
+#else /* HAVE_LIBDW_SUPPORT */
 
 static inline int get_dwarf_regnum(const char *name __maybe_unused,
 				   unsigned int machine __maybe_unused)
@@ -32,7 +32,7 @@ static inline int get_dwarf_regnum(const char *name __maybe_unused,
 }
 #endif
 
-#if !defined(__powerpc__) || !defined(HAVE_DWARF_SUPPORT)
+#if !defined(__powerpc__) || !defined(HAVE_LIBDW_SUPPORT)
 static inline void get_powerpc_regs(u32 raw_insn __maybe_unused, int is_source __maybe_unused,
 		struct annotated_op_loc *op_loc __maybe_unused)
 {
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a17c9b8a7a79..fd94614a4022 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -342,7 +342,7 @@ static char *find_module_name(const char *module)
 	return mod_name;
 }
 
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 
 static int kernel_get_module_dso(const char *module, struct dso **pdso)
 {
@@ -1250,7 +1250,7 @@ int show_available_vars(struct perf_probe_event *pevs, int npevs,
 	return ret;
 }
 
-#else	/* !HAVE_DWARF_SUPPORT */
+#else	/* !HAVE_LIBDW_SUPPORT */
 
 static void debuginfo_cache__exit(void)
 {
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index f0149d72310c..b9a5afca4cc1 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -21,7 +21,7 @@ static inline int is_c_varname(const char *name)
 	return isalpha(name[0]) || name[0] == '_';
 }
 
-#ifdef HAVE_DWARF_SUPPORT
+#ifdef HAVE_LIBDW_SUPPORT
 
 #include "dwarf-aux.h"
 #include "debuginfo.h"
@@ -102,6 +102,6 @@ struct line_finder {
 	int			found;
 };
 
-#endif /* HAVE_DWARF_SUPPORT */
+#endif /* HAVE_LIBDW_SUPPORT */
 
 #endif /*_PROBE_FINDER_H */
-- 
2.47.0.rc0.187.ge670bccf7e-goog

