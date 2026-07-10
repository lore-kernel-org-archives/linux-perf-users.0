Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CFE35F170
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651823; cv=none; b=akhH7lFopGlEWp3srCxXTqCCyXADde6lrW1ZE96KlBl9/+Deq0YrmSBsR51CPfYY5x35sZDXFlX+HwUuZ5dE5AyhU4oRCDSs7lh7OECx2FTRpmhlhhypLlAK/9nPbXffWngpNLbgFzuFczrt3AuLNC3eUl2TTiBtHEi+/JXjrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651823; c=relaxed/simple;
	bh=FaXoyj3CsPDRnu6tCLt/5YLGi9CO1ERVxtPJEECvcVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JcCw2P05wDW5Nsvbs2uZA24WSljf4UhgoT86/eWS5N80AM8IP3GEJ6hUGD2aPb3zJU53XxA3ZUOKTk/8fuzQzihMlc10sd14kejFYB6N9U9qc6z8AvNxqHN1eFyvnx4pS+c0JrUCMs61QMBu6KvuXFXqm/fXTGQ9UQr92ipYWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRzaZLJZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRzaZLJZ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso539401a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 19:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783651817; x=1784256617; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sTgvuS32veVYipNeVaKM375K0LMaG1BN9qZc3iIrX3Y=;
        b=vRzaZLJZfdY0j8NlOPc3ZWuyoeJAQtcux8ICrn8Mq2YlyyJiJg+9ivLjVHZW1JeArC
         RhEakgtCjQXM58fn20OOy9/3Sx2F8tZcWlfkwcpSiNENHkGRDIQV3ltJeDiKiC/lvFzG
         6ILZZ2nAxlpaRUc2V3mXS4HPnCg9C35T1T+PoyIeUvmKyPI2VTVSnfVNtVcLYa/HUsF6
         Hhx71CGjLn2HSpQ2n2e6P+32C5x/RH7eqFT77+9gdQyg+MChwr7yryY7rtcHD4zbg5mK
         2EWIUWp2/LZyBGJFQJ7lHDkjivZHWddSeI464G6c3alx/W15rizhYihdGHd0r66DUXzT
         2xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783651817; x=1784256617;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sTgvuS32veVYipNeVaKM375K0LMaG1BN9qZc3iIrX3Y=;
        b=hL46Lvd+H2sh9Ve2jzhq9n/J5Bj0Xwp7ho4pXWuC0viiKO9GH+4f3x3mIjwxqgA3lh
         tzIwKcAodqEsHM4OyigDIHlox2x4Q9iXc7vsZagrRK/rl/OMIeQ0P3yACiDHdPWtjaL8
         z53GVMVmFce3aibZZhlVr76b4nascPizEdjOK0LaMZ6Xi40DAJ2zAd9LFBTaCvLaZFhu
         VAXD60WUtcWkD0LRpxEDaPwOmE3B1nbq5j2SZadpQU3F7/t8V9RVCsASPtCxHVeJRItt
         sAWW02ylAsib5RdRCeTnBP78B+LgsdswH9zoLa0Ho4oTc19opF3CDM9uhIy2jrELAkBl
         GShw==
X-Forwarded-Encrypted: i=1; AHgh+RqTPyA9uJZcxfbXFk2qT+8z0HFo4++kcEISzrbcpihlXJqKpMN5L+cmr1hI/bVkLehxd+/5JADYaaB/nSsYSLHx@vger.kernel.org
X-Gm-Message-State: AOJu0YzdnTf1C4UQzKimg46BtGsp7D5BoPKuReWnaFEMtmLvNvzW9BsT
	PgDTxWP/98tD/ZwlNQTbA6N/foQ4ly8NcvGqWWqw7Z5iLhJN8SSbAuQ9ETYHUshhlfmTcLdJu4I
	vkCc9aTtZRQ==
X-Received: from dlbqd12.prod.google.com ([2002:a05:7023:b0c:b0:13a:4c0:f1f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f11:b0:3bf:6c07:b2f0
 with SMTP id adf61e73a8af0-3c0bd1e79e7mr10040325637.51.1783651817092; Thu, 09
 Jul 2026 19:50:17 -0700 (PDT)
Date: Thu,  9 Jul 2026 19:49:52 -0700
In-Reply-To: <20260710024952.1668911-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709165220.1411149-1-irogers@google.com> <20260710024952.1668911-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710024952.1668911-9-irogers@google.com>
Subject: [PATCH v4 9/9] perf annotate: Be robust to annotating without a thread
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

If a thread isn't given to thread__get_arch try harder to determine the
arch for disassembly. Do this by passing an entire map_symbol and using
fallback paths such as reading the e_machine from a map's dso. At the
same time ensure some other uses of map_symbol thread don't assume it is
non-NULL to avoid segvs.

Tested running perf report without a previous fix to populate the
map_symbol thread field.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/annotate.c             |  2 +-
 .../util/annotate-arch/annotate-loongarch.c   |  4 +-
 tools/perf/util/annotate-arch/annotate-s390.c |  2 +-
 tools/perf/util/annotate.c                    | 57 ++++++++++++++-----
 tools/perf/util/annotate.h                    |  2 +-
 tools/perf/util/capstone.c                    | 30 ++++++++--
 tools/perf/util/disasm.c                      |  7 ++-
 7 files changed, 77 insertions(+), 27 deletions(-)

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
diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
index c2addca77320..26217cb2d8f3 100644
--- a/tools/perf/util/annotate-arch/annotate-loongarch.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -51,7 +51,7 @@ static int loongarch_call__parse(const struct arch *arch, struct ins_operands *o
 		.addr = map__objdump_2mem(map, ops->target.addr),
 	};
 
-	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
+	if (ms->thread && maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -95,7 +95,7 @@ static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *o
 
 	ops->target.outside = target.addr < start || target.addr >= end;
 
-	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
+	if (ms->thread && maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
diff --git a/tools/perf/util/annotate-arch/annotate-s390.c b/tools/perf/util/annotate-arch/annotate-s390.c
index af9cabd0a586..3ea6ad588998 100644
--- a/tools/perf/util/annotate-arch/annotate-s390.c
+++ b/tools/perf/util/annotate-arch/annotate-s390.c
@@ -50,7 +50,7 @@ static int s390_call__parse(const struct arch *arch, struct ins_operands *ops,
 		.addr = map__objdump_2mem(map, ops->target.addr),
 	};
 
-	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
+	if (ms->thread && maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 53b2a224b21d..cdfaeb2388d0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -982,21 +982,46 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
-int thread__get_arch(struct thread *thread, const struct arch **parch)
+int map_symbol__get_arch(struct map_symbol *ms, const struct arch **parch)
 {
+	struct machine *machine = NULL;
+	const char *cpuid = NULL;
 	const struct arch *arch;
-	struct machine *machine;
-	uint32_t e_flags;
-	uint16_t e_machine;
+	uint32_t e_flags = 0;
+	uint16_t e_machine = EM_NONE;
 
-	if (!thread) {
-		*parch = NULL;
-		return -1;
+	/*
+	 * If we have a thread then derive the e_machine using it. The thread
+	 * can determine the machine and perf_env, so is generally pretty robust
+	 * as well as benefitting from a cache.
+	 */
+	if (ms->thread) {
+		struct maps *maps = thread__maps(ms->thread);
+
+		machine = maps__machine(maps);
+		e_machine = thread__e_machine(ms->thread, machine, &e_flags);
+		if (machine && machine->env)
+			cpuid = machine->env->cpuid;
+	}
+	if (e_machine == EM_NONE && ms->map) {
+		/*
+		 * If the thread look up failed then try to use a dso that may
+		 * be associated with the map.
+		 */
+		struct dso *dso = map__dso(ms->map);
+
+		if (dso)
+			e_machine = dso__e_machine(dso, machine, &e_flags);
+	}
+	if (e_machine == EM_NONE) {
+		/*
+		 * Still no e_machine, use the default for this kind of perf
+		 * build that will determine a value using uname, etc.
+		 */
+		e_machine = thread__e_machine(ms->thread, machine, &e_flags);
 	}
 
-	machine = maps__machine(thread__maps(thread));
-	e_machine = thread__e_machine(thread, machine, &e_flags);
-	arch = arch__find(e_machine, e_flags, machine->env ? machine->env->cpuid : NULL);
+	arch = arch__find(e_machine, e_flags, cpuid);
 	if (arch == NULL) {
 		pr_err("%s: unsupported arch %d\n", __func__, e_machine);
 		return errno;
@@ -1018,7 +1043,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	const struct arch *arch = NULL;
 	int err, nr;
 
-	err = thread__get_arch(ms->thread, &arch);
+	err = map_symbol__get_arch(ms, &arch);
 	if (err)
 		return err;
 
@@ -1266,7 +1291,10 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 
 	apd.addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source,
 							      notes->src->start);
-	thread__get_arch(ms->thread, &apd.arch);
+	if (map_symbol__get_arch(ms, &apd.arch)) {
+		free(filename);
+		return -ENOTSUP;
+	}
 	apd.dbg = dso__debuginfo(dso);
 
 	list_for_each_entry(pos, &notes->src->source, node) {
@@ -1369,9 +1397,12 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 		.write_graph		 = FILE__write_graph,
 	};
 	struct annotation_line *al;
+	int err;
 
 	if (annotate_opts.code_with_type) {
-		thread__get_arch(apd->he->ms.thread, &apd->arch);
+		err = map_symbol__get_arch(&apd->he->ms, &apd->arch);
+		if (err)
+			return err;
 		apd->dbg = dso__debuginfo(map__dso(apd->he->ms.map));
 	}
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 1aa6df7d1618..d54f851035ec 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -584,5 +584,5 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
 			     int num_aggr, struct evsel *evsel);
 int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool header);
 
-int thread__get_arch(struct thread *thread, const struct arch **parch);
+int map_symbol__get_arch(struct map_symbol *ms, const struct arch **parch);
 #endif	/* __PERF_ANNOTATE_H */
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 5ad537fea436..15152a2c1b25 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -411,9 +411,18 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
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
+		e_machine = dso__e_machine_endian(dso, /*machine=*/NULL, /*e_flags=*/NULL,
+						  &is_big_endian);
+	} else {
+		e_machine = thread__e_machine_endian(NULL,
+						     /*machine=*/NULL,
+						     /*e_flags=*/NULL, &is_big_endian);
+	}
 	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassembler_style) < 0)
 		goto err;
 
@@ -526,9 +535,18 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
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
+		e_machine = dso__e_machine_endian(dso, /*machine=*/NULL, /*e_flags=*/NULL,
+						  &is_big_endian);
+	} else {
+		e_machine = thread__e_machine_endian(NULL,
+						     /*machine=*/NULL,
+						     /*e_flags=*/NULL, &is_big_endian);
+	}
 	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassembler_style) < 0)
 		goto err;
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 5b114f089d56..46b9c292d5eb 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -271,7 +271,7 @@ static int call__parse(const struct arch *arch, struct ins_operands *ops, struct
 		.addr = map__objdump_2mem(map, ops->target.addr),
 	};
 
-	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
+	if (ms->thread && maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -405,7 +405,7 @@ static int jump__parse(const struct arch *arch, struct ins_operands *ops, struct
 	 * Actual navigation will come next, with further understanding of how
 	 * the symbol searching and disassembly should be done.
 	 */
-	if (maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
+	if (ms->thread && maps__find_ams(thread__maps(ms->thread), &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -1068,7 +1068,8 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 			.ms = { .map = map__get(map), },
 		};
 
-		if (!maps__find_ams(thread__maps(args->ms->thread), &target) &&
+		if (args->ms->thread &&
+		    !maps__find_ams(thread__maps(args->ms->thread), &target) &&
 		    target.ms.sym->start == target.al_addr)
 			dl->ops.target.sym = target.ms.sym;
 
-- 
2.55.0.795.g602f6c329a-goog

