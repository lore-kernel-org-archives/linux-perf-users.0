Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07403A1685
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782810; cv=none; b=Fe1Va7CcIUYhc4TLroLPihsSaSCvnJrglrxWhH5aBa5vlG+s3rluaCl2wJM8f1W8umyeCPwSoG/+UL7GCQE7IOQh4TcFIEbD293D4DSm7ncMYU3P+h1qwBDRzqevLia5mcJb3pyc0V/SyT55EeCiyhtFzWwjoZJ+mDniTe5/aJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782810; c=relaxed/simple;
	bh=ur9sGuruywhNMqRiQsy1Ld6QOnicJt/sGJaHf6t0oVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fe1pXjOpg09PVGKR9oDMcMI+ocLNXX3V8QLdH3gTHtw/hZ4JTrjrwmAaKsfHsVVh1V/TkNSndeYoN3IvNL5SFnU422WuOJivHZrIryLTk3MGvy8tQaBV3b84PkbbDDdvxY6/uNG/NXDv1YKGcZUNGDVuwoJIJgU5jshjhg1KZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SSbp0LI6; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSbp0LI6"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c7f385887bso6113345ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 22:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784782804; x=1785387604; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Dw3Ru1rBnPydLVKpmkZz3+u53JIr3+tqrnhDwtUDh4=;
        b=SSbp0LI6h5IrrlQTDdYUyhwr1+SjM5FYBp+D2xBLVmtjzcgDXfzPQn86t86Sv5C2rG
         agtiSU2m2dh1ez8JuAuoeCW0SWds2l3xe+1i8iy9TooGApsfffdNdgSecPeXLE4EU0PA
         UBWFsLpJuQxjxpcpHxlEJZZKOCXKxGMSC3sg07Gl62aaazvtML9oX1mfcImPFyIbQE0/
         42rCWOlbwkpPSQbks5lkK6mNx6Y+3W/ED/xk1p0NF/MpWgb+AGzr37JAwlkG4eGUaTxz
         llZzBfAyD0tJ+IvBi+SxV+uz7R77cWXkHNJBJd/1vYhW3PAc1WEQdc+BFt2TScFFKtoZ
         rBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784782804; x=1785387604;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Dw3Ru1rBnPydLVKpmkZz3+u53JIr3+tqrnhDwtUDh4=;
        b=lJosQe1bc8+Ueov4eqpnYiVqgbkQ4CWU9sjfE7BXbYbNetGReWodywOFw0qR9N1ok+
         +clEbYK9zg0KLc2a6rpJDp40f9dMzoXSsb1LuFZverYbIOcXsifZO5QaPJjhwHDR1YbQ
         lqA1xvIXcQ2dOncrHdNsWqgi64y5CPz46tVa4kXpjydmx+UulWLVcS2ZqoJMgqSENdlY
         9EWYPox2TByS58L21He4ns985eva7VtXTiLAqehTCiyC5ByzHxTEuxYLe3AiP6AWy1Q/
         maDw8a9XADpwCoJ4+9XYZgzB3ThrQI1rpfNTvotrHrPdVFPzfYLHpchOak3DyCmMsbRr
         aWmA==
X-Forwarded-Encrypted: i=1; AHgh+RqXSGC/muisME9ogAMWdP+vtcSMjWXNvYPz88lFFlcnCu4zl7sFoD8Rdc32iOJ/GrkiUTTEqOd8+9PPj96MSoPT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Y9WCRjPDpKtlQ5jN1hIVSYVIChIsVpXT7ZYvcgWnJZCZtnaT
	TOUTWj6pyiU753X+SfkNZwBnzUkCguZnM5Q3d18g+2IIIqAGUSIx6XyL91krviZicCsOd3guIFD
	n8r67WTZcuQ==
X-Received: from dycno8.prod.google.com ([2002:a05:7301:1448:b0:311:4853:3d70])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:394c:b0:3c3:7cb2:8aee
 with SMTP id adf61e73a8af0-3c44b21101emr1704557637.57.1784782803716; Wed, 22
 Jul 2026 22:00:03 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:59:48 -0700
In-Reply-To: <20260723045949.988740-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716072351.560311-1-irogers@google.com> <20260723045949.988740-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723045949.988740-6-irogers@google.com>
Subject: [PATCH v7 5/6] perf annotate: Be robust to annotating without a thread
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

If a thread isn't given to map_symbol__get_arch(), try harder to determine
the arch for disassembly. Do this by utilizing fallback paths such as
reading the e_machine from a map's DSO ELF header for user-space libraries.
Additionally, rely on map__kmaps() and maps__machine() to reliably extract
the recorded machine environment and e_machine for kernel and kallsyms maps,
perfectly preventing silent, incorrect host fallbacks to uname() during
cross-platform Capstone annotation sessions.

At the same time, ensure all remaining uses of a map_symbol's thread pointer
do not assume it is non-NULL to eliminate UI segmentation faults, and remove
the fragile, redundant thread__get_arch() function to streamline the
annotate and disassembly subsystem architecture.

Fixes: 0e26ba5a8774 ("perf disasm: Refactor arch__find and initialization of arch structs")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/util/annotate.c        | 51 ++++++++++++++++++++++---------
 tools/perf/util/annotate.h        |  3 +-
 tools/perf/util/capstone.c        | 42 ++++++++++++++++++++-----
 4 files changed, 74 insertions(+), 24 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d25761a8d25e..e47a46775089 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1201,7 +1201,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 				ui__warning("Annotation has no source code.");
 		}
 	} else {
-		err = thread__get_arch(ms->thread, &browser.arch);
+		err = map_symbol__get_arch(ms, &browser.arch);
 		if (err) {
 			annotate_browser__symbol_annotate_error(&browser, err);
 			return -1;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 53b2a224b21d..df70e95a8470 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -982,24 +982,43 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
-int thread__get_arch(struct thread *thread, const struct arch **parch)
+
+
+int map_symbol__get_arch(struct map_symbol *ms, const struct arch **parch)
 {
 	const struct arch *arch;
-	struct machine *machine;
-	uint32_t e_flags;
-	uint16_t e_machine;
+	struct machine *machine = NULL;
+	struct map *map = ms->map;
+	struct dso *dso = map ? map__dso(map) : NULL;
+	uint32_t e_flags = 0;
+	uint16_t e_machine = EM_NONE;
 
-	if (!thread) {
-		*parch = NULL;
-		return -1;
+	const char *cpuid = NULL;
+
+	if (ms->thread) {
+		machine = maps__machine(thread__maps(ms->thread));
+		e_machine = thread__e_machine(ms->thread, machine, &e_flags);
+		if (machine && machine->env)
+			cpuid = machine->env->cpuid;
+	} else if (dso) {
+		struct maps *kmaps = (map && dso__kernel(dso)) ? map__kmaps(map) : NULL;
+		struct machine *kmap_machine = kmaps ? maps__machine(kmaps) : NULL;
+
+		e_machine = dso__e_machine(dso, kmap_machine, &e_flags);
+		if (kmap_machine && kmap_machine->env)
+			cpuid = kmap_machine->env->cpuid;
 	}
 
-	machine = maps__machine(thread__maps(thread));
-	e_machine = thread__e_machine(thread, machine, &e_flags);
-	arch = arch__find(e_machine, e_flags, machine->env ? machine->env->cpuid : NULL);
+	if (e_machine == EM_NONE)
+		e_machine = thread__e_machine(NULL, NULL, &e_flags);
+
+	arch = arch__find(e_machine, e_flags, cpuid);
 	if (arch == NULL) {
 		pr_err("%s: unsupported arch %d\n", __func__, e_machine);
-		return errno;
+		/* TODO: Refactor annotate/disassemble subsystem error
+		 * codes to uniformly return negative integers.
+		 */
+		return errno ? errno : ENOTSUP;
 	}
 	if (parch)
 		*parch = arch;
@@ -1018,7 +1037,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	const struct arch *arch = NULL;
 	int err, nr;
 
-	err = thread__get_arch(ms->thread, &arch);
+	err = map_symbol__get_arch(ms, &arch);
 	if (err)
 		return err;
 
@@ -1251,6 +1270,11 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 		evsel_name = buf;
 	}
 
+	if (map_symbol__get_arch(ms, &apd.arch)) {
+		free(filename);
+		return ENOTSUP;
+	}
+
 	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples, "
 				  "percent: %s)\n",
 				  width, width, symbol_conf.show_total_period ? "Period" :
@@ -1266,7 +1290,6 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 
 	apd.addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source,
 							      notes->src->start);
-	thread__get_arch(ms->thread, &apd.arch);
 	apd.dbg = dso__debuginfo(dso);
 
 	list_for_each_entry(pos, &notes->src->source, node) {
@@ -1371,7 +1394,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 	struct annotation_line *al;
 
 	if (annotate_opts.code_with_type) {
-		thread__get_arch(apd->he->ms.thread, &apd->arch);
+		map_symbol__get_arch(&apd->he->ms, &apd->arch);
 		apd->dbg = dso__debuginfo(map__dso(apd->he->ms.map));
 	}
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 1aa6df7d1618..fa08d09b80f7 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -584,5 +584,6 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
 			     int num_aggr, struct evsel *evsel);
 int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool header);
 
-int thread__get_arch(struct thread *thread, const struct arch **parch);
+
+int map_symbol__get_arch(struct map_symbol *ms, const struct arch **parch);
 #endif	/* __PERF_ANNOTATE_H */
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 00e0141cae8d..74213daf8786 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -392,7 +392,7 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
 	char disasm_buf[512];
 	struct disasm_line *dl;
 	bool disassembler_style = false;
-	uint16_t e_machine;
+	uint16_t e_machine = EM_NONE;
 	bool is_big_endian = false;
 
 	if (args->options->objdump_path)
@@ -423,9 +423,22 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
 	    !strcmp(args->options->disassembler_style, "att"))
 		disassembler_style = true;
 
-	e_machine = thread__e_machine_endian(args->ms->thread,
-					     /*machine=*/NULL,
-					     /*e_flags=*/NULL, &is_big_endian);
+	if (args->ms->thread) {
+		e_machine = thread__e_machine_endian(args->ms->thread,
+						     /*machine=*/NULL,
+						     /*e_flags=*/NULL, &is_big_endian);
+	} else if (dso) {
+		struct maps *kmaps = (map && dso__kernel(dso)) ? map__kmaps(map) : NULL;
+		struct machine *kmap_machine = kmaps ? maps__machine(kmaps) : NULL;
+
+		e_machine = dso__e_machine_endian(dso, kmap_machine, /*e_flags=*/NULL,
+						  &is_big_endian);
+	}
+	if (!e_machine || e_machine == EM_NONE) {
+		e_machine = thread__e_machine_endian(NULL,
+						     /*machine=*/NULL,
+						     /*e_flags=*/NULL, &is_big_endian);
+	}
 	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassembler_style) < 0)
 		goto err;
 
@@ -518,7 +531,7 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	struct disasm_line *dl;
 	u32 *line;
 	bool disassembler_style = false;
-	uint16_t e_machine;
+	uint16_t e_machine = EM_NONE;
 	bool is_big_endian = false;
 
 	if (args->options->objdump_path)
@@ -538,9 +551,22 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	    !strcmp(args->options->disassembler_style, "att"))
 		disassembler_style = true;
 
-	e_machine = thread__e_machine_endian(args->ms->thread,
-					     /*machine=*/NULL,
-					     /*e_flags=*/NULL, &is_big_endian);
+	if (args->ms->thread) {
+		e_machine = thread__e_machine_endian(args->ms->thread,
+						     /*machine=*/NULL,
+						     /*e_flags=*/NULL, &is_big_endian);
+	} else if (dso) {
+		struct maps *kmaps = (map && dso__kernel(dso)) ? map__kmaps(map) : NULL;
+		struct machine *kmap_machine = kmaps ? maps__machine(kmaps) : NULL;
+
+		e_machine = dso__e_machine_endian(dso, kmap_machine, /*e_flags=*/NULL,
+						  &is_big_endian);
+	}
+	if (!e_machine || e_machine == EM_NONE) {
+		e_machine = thread__e_machine_endian(NULL,
+						     /*machine=*/NULL,
+						     /*e_flags=*/NULL, &is_big_endian);
+	}
 	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassembler_style) < 0)
 		goto err;
 
-- 
2.55.0.229.g6434b31f56-goog

