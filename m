Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F439C00E
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615952; cv=none; b=d7EaszyZKabjNC22+ODxOo5Iwtfn4kwb4uDpOYcQLtHfBhvaMEcw0W0eGH6zvEzaD0tCGLU6fcKD/XHR7PCJPyHvSBEH00voZnewyqufNnK4gu+NZDRAFbS3g2vIDPc7wRFlTEtgAtAi//50FRCdGzGWoyJFD0vY07FPpkQdlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615952; c=relaxed/simple;
	bh=gkbUZSv1IkcP2JjkH2BoRblI0lY4yzcMa3wqiJX61Bg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XjurL7Y2eV8EDi2RJav20ICQNFsJXzxEZn3K2fR/N636VDNEfC/tUOY+aaV0TAd8WQdyDl/55FZAxm7zBqvV4rVT/3E83tS1V2qnK77Q6z3D0OnHqSzm1NOi9LLwVdsn0ewK2i6oq5eGLDJ1BUDQBOa4d375L9fC5VoWEa276kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4eyBAO/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4eyBAO/"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8478423e020so2165646b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783615950; x=1784220750; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A0dOTuG8VEVnNvie2kB1nAkSuQG5znqFcvurtqvn0Vk=;
        b=V4eyBAO/SsQPvV4XM7u3hKwxtzexUfIgSX2OTdROQl2OSjkK4fVt9KRwSFFVtfMGmO
         0SCqOzz5qkEM2By4f/iMuhgOTAOND2vavzY+nW4U+Pbkujh2F0rcBf7w+oZFYsbk0ZaV
         QoN27x8PGdX+D3FctYWnqX4qZC1S9jqtW5HDJaph7b0DPAPAxrJY3y869oZT6mLKyUGL
         sCbeUUl/ztpaBrpPAEfdFWvxB4wqaKDKZ1zNA+8anDE2cRI4BgACSME0gpmiKB4Pdunw
         d7aN1wnHeEufoGfxoLdDU7G56E5PNb6zRiR4cVNSEXKX84eCMtCWCIvSj3r3KTN3/D8y
         ihfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615950; x=1784220750;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A0dOTuG8VEVnNvie2kB1nAkSuQG5znqFcvurtqvn0Vk=;
        b=KIOrPEv4ePUYZkYc8G1YW1ebVJWq/AiruX9Tgy0D2PelyWlRn+qvgjMM4Lfm45GJG3
         WwQoVT3+PnZ0vsHKpyRorVzMj6ZRIoYNnvIXBC265FiIu2PHPRHuiEGKwaXSrEilLPzk
         kjijXeAFngIAC/MaYrADlNsAqFgN6xQYaDrJAId4xKdCE+1ykkoIbeiihLAjBdcrIumo
         4YgrXG+U39rXOzDSOQLrmIpdkGNUdYjd9p/DgkmI9nqyg2Q8PAwNZB9Ty25fjv2LHq7u
         bnaYM28nLLu2KfISjwu2aco1oprift3N8T7w3oqD1MzSDOmTXbCkU38Dos5sipI+D7iP
         hqPA==
X-Forwarded-Encrypted: i=1; AHgh+RoWSTzCzcDBBCLgguWPzZidDsZMh5Q2YRmjgM494HSWCZ+2Al5TQPYLrQoeFU7Zuv6eFjagxGozW7gfXT0CPzKq@vger.kernel.org
X-Gm-Message-State: AOJu0YxXW3c9GXsw5S7BlPb23/uFPOKQCCrKyx9PIhX30U1oPKjUfizN
	zRl5w5Xb7G68ge1Vf72h9E6SLthlpLkhqZpCDTuy9YCYbYIntPAsP8N/a4ixPSpODKH8aiUAzqv
	umzGMYlQ2jQ==
X-Received: from dlea1-n2.prod.google.com ([2002:a05:701b:4201:20b0:139:d69b:dabd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a11d:b0:3bf:6c08:fba2
 with SMTP id adf61e73a8af0-3c0bcf282c5mr10359096637.54.1783615950079; Thu, 09
 Jul 2026 09:52:30 -0700 (PDT)
Date: Thu,  9 Jul 2026 09:52:19 -0700
In-Reply-To: <20260709165220.1411149-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709033701.1117943-1-irogers@google.com> <20260709165220.1411149-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709165220.1411149-3-irogers@google.com>
Subject: [PATCH v3 3/4] perf annotate: Be robust to annotating without a thread
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

If a thread isn't given to thread__get_arch try harder to determine
the arch for disassembly. Do this by passing an entire map_symbol and
using fallback paths such as reading the e_machine from a map's
dso. At the same time ensure some other uses of map_symbol thread
don't assume it is non-NULL to avoid segvs.

Tested running perf report without a previous fix to populate the
map_symbol thread field.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/annotate.c             |  2 +-
 .../util/annotate-arch/annotate-loongarch.c   |  4 +-
 tools/perf/util/annotate-arch/annotate-s390.c |  2 +-
 tools/perf/util/annotate.c                    | 55 ++++++++++++++-----
 tools/perf/util/annotate.h                    |  2 +-
 tools/perf/util/capstone.c                    |  8 +++
 tools/perf/util/disasm.c                      | 11 ++--
 7 files changed, 61 insertions(+), 23 deletions(-)

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
index 53b2a224b21d..061b5cb9de8a 100644
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
 	}
+	if (e_machine == EM_NONE && ms->map) {
+		/*
+		 * If the thread look up failed then try to use a dso that may
+		 * be associated with the map.
+		 */
+		struct dso *dso = map__dso(ms->map);
 
-	machine = maps__machine(thread__maps(thread));
-	e_machine = thread__e_machine(thread, machine, &e_flags);
-	arch = arch__find(e_machine, e_flags, machine->env ? machine->env->cpuid : NULL);
+		if (dso)
+			e_machine = dso__e_machine(dso, machine, &e_flags);
+	}
+	if (e_machine == EM_NONE) {
+		/*
+		 * Still no e_machine, use the default for this kind of perf
+		 * build that will determine a value using uname, etc.
+		 */
+		e_machine = thread__e_machine(ms->thread, machine, &e_flags);
+	}
+
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
 
@@ -1266,7 +1291,8 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 
 	apd.addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source,
 							      notes->src->start);
-	thread__get_arch(ms->thread, &apd.arch);
+	if (map_symbol__get_arch(ms, &apd.arch))
+		return -ENOTSUP;
 	apd.dbg = dso__debuginfo(dso);
 
 	list_for_each_entry(pos, &notes->src->source, node) {
@@ -1369,9 +1395,12 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
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
index 5ad537fea436..c2b776c6982d 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -414,6 +414,10 @@ int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
 	e_machine = thread__e_machine_endian(args->ms->thread,
 					     /*machine=*/NULL,
 					     /*e_flags=*/NULL, &is_big_endian);
+	if (e_machine == EM_NONE && dso) {
+		e_machine = dso__e_machine_endian(dso, /*machine=*/NULL, /*e_flags=*/NULL,
+						  &is_big_endian);
+	}
 	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassembler_style) < 0)
 		goto err;
 
@@ -529,6 +533,10 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 	e_machine = thread__e_machine_endian(args->ms->thread,
 					     /*machine=*/NULL,
 					     /*e_flags=*/NULL, &is_big_endian);
+	if (e_machine == EM_NONE && dso) {
+		e_machine = dso__e_machine_endian(dso, /*machine=*/NULL, /*e_flags=*/NULL,
+						  &is_big_endian);
+	}
 	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassembler_style) < 0)
 		goto err;
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 0a1a7e9cf3ef..46b9c292d5eb 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -182,8 +182,8 @@ const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *
 
 	result = arch_new_fn[e_machine](&key, cpuid);
 	if (!result) {
-		pr_err("%s: failed to initialize %s (%u) arch priv area\n",
-			__func__, result->name, e_machine);
+		pr_err("%s: failed to initialize %u arch priv area\n",
+			__func__, e_machine);
 		free(tmp);
 		return NULL;
 	}
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

