Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E5939F18A
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554428; cv=none; b=Fz8JyrE6FQZLlNrpWihSBz3GOEdPrP0MwuFlNSBn3Ncv9MkWo852kdbrj8FIijYHJRmXczAGhmq+2IAziCyhl4iGJfy7SdLfrlPR+xjP6z9GSHEVDXCWN16gRgNMMyhhGliV+GV5vd+aqF/uK47lx7bFGVRMd6uLt4YzYmeGKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554428; c=relaxed/simple;
	bh=PaHIfCD+qyhPgE58h1250BYLG7x2WqnkquMAZGkBT9E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Lews9Zwb1ZsFIk4EjQmTC5ECDy52QzbtoNVo0i8EDYRK0FgnnBqB3zLZThPVZx+RUaeHAWWS/P6MOssX/tZ7TULAGyzHsObHNKx9mivuM55HfARo6XfGCDxiNvU/kDAv+Pz/HJS9oEP3l2Rbx4l7upIVFJeEd/diJny0zVyUvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dgnqgbt9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dgnqgbt9"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so1266371a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jul 2026 16:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554426; x=1784159226; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7f/RngMo/mCtf+UaSd8RJzrwrxTDBxtQ215H6QNbQtc=;
        b=Dgnqgbt9PqWU/gyaKJhuTXaIEYMRyU1K6MS65wXq2HwAOOgnEpRyNjmZu+hg8Ab1Hk
         rDht0C7ONN60FmgV04yeOUGBG+9LpGFcHHYjsMV0uDGsZMKwb99pKdx2l0viezXKrMbo
         Q5ArkhEUlRLM0AF8BgSJPFuMJeKk3AIHzHPp/MEOqVL2Ga2uh42/CG2lqpYuxq60ncOm
         yEV8ofVsIpt5wMfCFDPbFrV3egn5U0Lqa49NtWyfoNTDXYfQ6DiQQ9j6XLs6dNopZ17K
         1TTZ1EwJU/rKResgUhaESxbmWNQQRINmLrmVXqEA4560Hm+LU9kbAFlkm0QX5eb08rMF
         jo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554426; x=1784159226;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7f/RngMo/mCtf+UaSd8RJzrwrxTDBxtQ215H6QNbQtc=;
        b=VHMYByVwEimjqqdSq9gz5ApP+fB70Sho1RbvumkZQSWSquurzuRRFBH7b8ZwCnJaJa
         vZ2Mw/UVpM8mQvy4Tp8gfkdHQzhCbCqd1qaY6L36F7C5HQfbf1LuhDePc0S9HPHqqYIp
         Sz68NRh+OJ1+QVD9wjXPY7bKMcrB45WWER3V8QMDKrrYyR1kisqU7D0+t1x19L4UxfhP
         P+uLTVaKFHbx7L5R1ZiADI8AX0YBnTHKxhRfq+6a2qzVqxw2lqf4vZXCiKElyj/6UuRM
         XdnxIJWA5DxiQ40TodDF6IrilIQrinfFD7xFyhMGssLfm7PE59dS4K7p+l+EIgRNzFA4
         f9JQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro4ykdDe7ZHTALkqJH98un6X/HuSSpfDcmRyhbop/LtTPX9Bm499/BqDgEB5ljm+FQ3Fj9Li+ZNHvFIZbOe+q3U@vger.kernel.org
X-Gm-Message-State: AOJu0YwaFo/JeXCarjb3jG/bG3Tha37Dd235wuowXJwWuTA9tMECQsMP
	ZufxpxGQkngIdroyAus6GkJ9CR0kXCYAXX99+5+46TjXXnM5i4K7EXFh+V4RHAEMY9FsdN3C98Q
	9ueC3R1ZnMg==
X-Received: from dlbcm27.prod.google.com ([2002:a05:7022:689b:b0:13b:6234:83dd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e293:b0:3bf:c12c:2ecf
 with SMTP id adf61e73a8af0-3c0bcc0b643mr5782694637.59.1783554426162; Wed, 08
 Jul 2026 16:47:06 -0700 (PDT)
Date: Wed,  8 Jul 2026 16:46:46 -0700
In-Reply-To: <20260708234646.1040003-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708234646.1040003-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234646.1040003-3-irogers@google.com>
Subject: [PATCH v1 3/3] perf annotate: Be robust to annotating without a thread
From: Ian Rogers <irogers@google.com>
To: Josh Stone <jistone@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Tianyou Li <tianyou.li@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Zecheng Li <zecheng@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/util/annotate.c        | 51 +++++++++++++++++++++++--------
 tools/perf/util/annotate.h        |  2 +-
 tools/perf/util/disasm.c          |  7 +++--
 4 files changed, 44 insertions(+), 18 deletions(-)

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
index 53b2a224b21d..82eee0f417e0 100644
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
 
@@ -1266,7 +1291,7 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 
 	apd.addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source,
 							      notes->src->start);
-	thread__get_arch(ms->thread, &apd.arch);
+	map_symbol__get_arch(ms, &apd.arch);
 	apd.dbg = dso__debuginfo(dso);
 
 	list_for_each_entry(pos, &notes->src->source, node) {
@@ -1371,7 +1396,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 	struct annotation_line *al;
 
 	if (annotate_opts.code_with_type) {
-		thread__get_arch(apd->he->ms.thread, &apd->arch);
+		map_symbol__get_arch(&apd->he->ms, &apd->arch);
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
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 0a1a7e9cf3ef..8cd90a0a0f8a 100644
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

