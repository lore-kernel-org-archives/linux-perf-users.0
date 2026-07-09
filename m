Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1339B94F
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568256; cv=none; b=YCePp4quSy+Gl26glh5b49NbZP1GCQqF8yWgCB7dMoRG7kIGp5RcFa7Fo489sBxi4nfedXKaAxC2XiA0jenGIpUkk7pTKJKNl8lN3pmFPVvAU4IAhx6U7FrLH4E7VNJVZwZh1UTreIq0h/Qa6I2g/6J4SzGffJmiG6EE9nDPa8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568256; c=relaxed/simple;
	bh=PP8fc1pw1AxB1qnPLoGLnGlDaf/JFDxAROfHao6Ms3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pnn1/cS69WAJFjeL1XtFk6YDNrB+kVO/ymwbDLjM3YXfEJqreMO/2WzoFXkCMFZgf5wwXnE1uqqjGnO7QqaNmazGsKtWaCkW+o58DOyBrHCIZu6r6WloRCQN+Ldd+cCUGjLFavfIPB0OWoFa8ViKOXcHs79mtzvkG0z9/K2iMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V0Wt9Qfd; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V0Wt9Qfd"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8478423e020so953849b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jul 2026 20:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783568255; x=1784173055; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VudpoVTolu5BKRka35Akq7VusYrDFPlfTtJifI+pldw=;
        b=V0Wt9QfdHvNoJ02ZL+KKbpb4H7h/o/5nZ4aZe6abKYaBRTRFVUvGnxUXWsuLkbxM/o
         nC4JMkb8FDWC9WJ9B0JeWMOpanHWTeLq6p7bp65xmfch7QKiBlUsFiSmIeY2IrX93HWi
         D+sC9tvX55MRsJ99eKTgzk+q6K5IPHSKo9HcMeEkCfDN05wxlDCbkSSMczif+0HxT4h4
         KPtDvYZFKPvsdddzUwfHq+qXdZ+PLW6fZ7yl8REu+6By/j9z+KQmebG4eK6moUFBLqHF
         4atzKZr7mbtQEg4yjf2eOSMNh8x3iLLt0fG1DPfxflg+0E95vGq4UqEkXM41CIPlQpC6
         4SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783568255; x=1784173055;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VudpoVTolu5BKRka35Akq7VusYrDFPlfTtJifI+pldw=;
        b=gxHfJdtSNFX4R0+lRASZthk3ArjJLIH1mqXgEUB7kMq/zqCK0bMpsLjVAYy7TRAOkX
         +ve0aOQ7d+egKlc8ob3xRL+dqWofG+YrGHyngxhYn0XCKP2zglnJwJvK33OIMe8flAfS
         nSmr58H733czvuQc4oQhD1O6X4t0DU8BznyLOJ7RUv/PvuIHvY8U2aUO9zfc/mftV2dP
         t38vaPe2zvxDTjWDQTLP2At9Jru1zinfe+O66y/pXLKKUzOpapeLXzPPqsSJr0nWlW3H
         FV5/S06c+Kirn3wuQoOr/G7kijaAI6bQ44QuLP75Ml1snzFhnEYeFA/IUNlTyW8yoxA6
         0LbQ==
X-Forwarded-Encrypted: i=1; AHgh+RrFp7DuEZQ8z6V8GTP5U2NO6nc2mOBOpsuQdqRXxcgpDFwZMyteoVI/EkIDZJMAyaqg+d5c3NDwFbqjYBvDc8cl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3OXatJ5Srh3hT9HUMnjT3RR/Vxn9B7sVDJz9Rv5s3Fv9aSWYq
	GTvLZ9NZ/JQyAxwZhvaqfRg+15XxNIMOAnpRsOypGrhKHN1ZMDN6qUC3qLwvqt5KBv5XZgdl/iL
	3EO4arT8dIA==
X-Received: from dybia1.prod.google.com ([2002:a05:7301:301:b0:30f:298d:5895])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:60c8:b0:3c0:9c19:6586
 with SMTP id adf61e73a8af0-3c0bcf9d052mr6845093637.64.1783568254401; Wed, 08
 Jul 2026 20:37:34 -0700 (PDT)
Date: Wed,  8 Jul 2026 20:37:00 -0700
In-Reply-To: <20260709033701.1117943-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708234646.1040003-1-irogers@google.com> <20260709033701.1117943-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709033701.1117943-3-irogers@google.com>
Subject: [PATCH v2 3/4] perf annotate: Be robust to annotating without a thread
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
 tools/perf/util/annotate.c                    | 51 ++++++++++++++-----
 tools/perf/util/annotate.h                    |  2 +-
 tools/perf/util/disasm.c                      |  7 +--
 6 files changed, 47 insertions(+), 21 deletions(-)

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

