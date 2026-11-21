Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245448;
	b=jUpG9jfc1c1/skrSbS0qIVeqO5zs8s9B+rtH89X1a2twz7FmsLzzpgvSlOi1agW72ISS
	 Zk7LFEBWdA5+TwdVXQWuQO8Jvz81PWOBHvAJPs72CgJ9wsItizP87aonJR23ZXkyePjiI
	 K0u/2ESHstM38kuCM0vMIu6cD0KSeLgs7mPjv6EPJX2huDi5I3MXYIkqz1HV/6CStUHju
	 QFlIQlro4SsZACJbYnW+JT0vrlQecbBV0ucKMW847d/+wiMbmpPGU1AYn3tnV5mQIeoTF
	 V4egCq4/riHmBrdoOzrghZGkkCbkRft46AqhwcttNvQcpEB/1hLQCikyZsJk08Waz5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bloS2q4OY6hjXoBAubk0PTrzYUKsUzPQ5EAD0Tp7wgg=;
	b=p2kxyFcqiOCmsK8p+bEFVzw1DTm785ilMP5ocgHiJ/DjpNVwZO4JTxd7RTYcOGN7Ixh+
	 a6yXcbI6vJpr7LNOJ+n8SXnqBCxSCA4Q5Q++HIfqihHq0DZ1q7QT0+p0RN67eFtrHC2DU
	 tejFzTDb23kamhSw513SS4ksoFfTiHlcbKdsGz9nf7p80zOX1H214aDQAinGwzeRVUagk
	 8R8nbR1qIl4T9J+MEWhNw8qK2c76pBn1q45dFXzlJOJ9P9Ldl/BmLTy3C3QYQuVo9zGLv
	 pPQN0xGQWeuL8n3APRAE3MpTlNxbItV1g15i1wWhqGqSPkZfFeelfsfQ1yXvhWhQx4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lF+Q5zmV;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F9D606A334
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 07:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61F9D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lF+Q5zmV
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1a71dd190b0so4933305c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 23:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795245447; x=1795850247; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bloS2q4OY6hjXoBAubk0PTrzYUKsUzPQ5EAD0Tp7wgg=;
        b=lF+Q5zmVsmcIDgLAYTZ3e001fiMVR1H3f3lpesOSVLuW1yCjNRuisY+uQhult4cmle
         YLA0VhRzICMpJfEpxuim+SYJcwHJRKk43zKcXVu/MSrtp97LY3dULhLIUkA+ChfRFp8W
         +T7AEacJbFNq9+vVrFL4/1zFetWIL8SIbiE2cJiD+ZvFkZsfMl+11+eH7ijyGjry7Cpi
         pm0+GwN1076pZkdZo4iZPfO89aUHRHCJMkutihd2uW+rSLYbq3vmh6XUjDq8iSL+Mf6I
         v1rSJBxTpnIO6jiH7EfYbe/eu4+/UN6rFBALO7+PcmZuIqbcys/l697pR2W2auAkTPbQ
         aW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245447; x=1795850247;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bloS2q4OY6hjXoBAubk0PTrzYUKsUzPQ5EAD0Tp7wgg=;
        b=sh0Q4FgiZORQ4RqXOgR6WtnHOYfE4SRdd8BRXtnE5SRgaHEdOj4uPuf4UAXU6ObjdP
         qxDt09ha5Z7xUZMvpNsbLplLn7E2bysPlyb++ALIIXSKf+o1aSnP1mtuji/omh5pu6aK
         hJ9wef+hPPDTE2CyyNhEIshDvwz1ISBIBTwkOkSf3an9bHgO5HeXC0KRULYqO3oRae91
         L8/hnjr8aOmajqFQgTMXOP15gwm9uzXZr393cEN+bdxCZ/6UmtSHyr6kvzxh19bqHWEY
         vW3hDtEXbAhx985Up8q/wSX+j+GzElFYNgVpf/8nWgbFJjkh1H3mn9hPrYsQLVD7VTuN
         RBoQ==
X-Forwarded-Encrypted: i=1; AL+hErENzmxYB0QM2rPedAw8fweMHOPELVqj00GDXgLk7WX/vCJUL3YRX/l6YcEB7DqTKQjScSy+jRAoHEDpxlyP9b45@vger.kernel.org
X-Gm-Message-State: APuU4Z9wSCSSB8WYi7mLNFlTdWHVRgh7LW3FAouLYQ5GBENDL8Sj1wDr
	VVIlEBTbQOU1uY2x5dPmYgZvTQtBP5MVJcSEXsbZI/Lk/OmB/wRgcquH93XJQ0fsF/61QjZVwhV
	rPAAPwAw/gg==
X-Received: from dleb8-n1.prod.google.com ([2002:a05:701b:4248:10b0:161:df69:3983])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4584:b0:1ac:9da7:e86e
 with SMTP id a92af1059eb24-1b556908c17mr5458277c88.30.1795245446892; Fri, 20
 Nov 2026 23:17:26 -0800 (PST)
Date: Fri, 20 Nov 2026 23:16:45 -0800
In-Reply-To: <20261121071651.67118-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121071651.67118-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121071651.67118-5-irogers@google.com>
Subject: [PATCH v7 04/10] perf symbol: Use callback iteration instead of
 open-coded symbol loops
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert open-coded dso__first_symbol() / dso__next_symbol(),
rb_first_cached() / rb_next(), and dso__symbol_names() loops across
auxtrace, intel-pt, machine, dso, probe-event, symbol_fprintf, and
tests/symbols.c to use dso__for_each_symbol(), map__for_each_symbol(),
and a new dso__for_each_symbol_by_name() callback helper.

With no remaining callers, remove dso__first_symbol(), dso__last_symbol(),
and dso__next_symbol().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/symbols.c       |  61 ++++++++++-------
 tools/perf/util/auxtrace.c       | 109 ++++++++++++++++++++-----------
 tools/perf/util/dso.c            |  34 ++++++----
 tools/perf/util/dso.h            |   3 +
 tools/perf/util/intel-pt.c       |  74 +++++++++++++--------
 tools/perf/util/machine.c        |  28 ++++----
 tools/perf/util/probe-event.c    |  16 +++--
 tools/perf/util/symbol.c         |  52 ++++-----------
 tools/perf/util/symbol.h         |   7 +-
 tools/perf/util/symbol_fprintf.c |  25 +++++--
 10 files changed, 239 insertions(+), 170 deletions(-)

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index d3180db45ee6..b73da581f895 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -116,39 +116,50 @@ static int create_map(struct test_info *ti, char *filename, struct map **map_p)
 	return TEST_OK;
 }
 
+struct test_dso_args {
+	struct symbol *last_sym;
+	int ret;
+};
+
+static int test_dso_cb(struct symbol *sym, void *data)
+{
+	struct test_dso_args *args = data;
+	struct symbol *last_sym = args->last_sym;
+
+	if (symbol__type(sym) != STT_FUNC && symbol__type(sym) != STT_GNU_IFUNC)
+		return 0;
+
+	/* Check for overlapping function symbols */
+	if (last_sym && sym->start < last_sym->end) {
+		pr_debug("Overlapping symbols:\n");
+		symbol__fprintf(last_sym, stderr);
+		symbol__fprintf(sym, stderr);
+		args->ret = TEST_FAIL;
+	}
+	/* Check for zero-length function symbol */
+	if (sym->start == sym->end) {
+		pr_debug("Zero-length symbol:\n");
+		symbol__fprintf(sym, stderr);
+		args->ret = TEST_FAIL;
+	}
+	args->last_sym = sym;
+	return 0;
+}
+
 static int test_dso(struct dso *dso)
 {
-	struct symbol *last_sym = NULL;
-	struct rb_node *nd;
-	int ret = TEST_OK;
+	struct test_dso_args args = {
+		.last_sym = NULL,
+		.ret = TEST_OK,
+	};
 
 	/* dso__fprintf() prints all the symbols */
 	if (verbose > 1)
 		dso__fprintf(dso, stderr);
 
-	for (nd = rb_first_cached(dso__symbols(dso)); nd; nd = rb_next(nd)) {
-		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
+	dso__for_each_symbol(dso, test_dso_cb, &args);
 
-		if (symbol__type(sym) != STT_FUNC && symbol__type(sym) != STT_GNU_IFUNC)
-			continue;
-
-		/* Check for overlapping function symbols */
-		if (last_sym && sym->start < last_sym->end) {
-			pr_debug("Overlapping symbols:\n");
-			symbol__fprintf(last_sym, stderr);
-			symbol__fprintf(sym, stderr);
-			ret = TEST_FAIL;
-		}
-		/* Check for zero-length function symbol */
-		if (sym->start == sym->end) {
-			pr_debug("Zero-length symbol:\n");
-			symbol__fprintf(sym, stderr);
-			ret = TEST_FAIL;
-		}
-		last_sym = sym;
-	}
-
-	return ret;
+	return args.ret;
 }
 
 static int subdivided_dso_cb(struct dso *dso, struct machine *machine __maybe_unused, void *d)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 8bb491d389a2..fdffdf60983a 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2713,61 +2713,96 @@ static bool dso_sym_match(struct symbol *sym, const char *name, int *cnt,
 		idx < 0);
 }
 
+struct print_duplicate_syms_args {
+	const char *sym_name;
+	bool near;
+	int cnt;
+};
+
+static int print_duplicate_syms_cb(struct symbol *sym, void *data)
+{
+	struct print_duplicate_syms_args *args = data;
+
+	if (dso_sym_match(sym, args->sym_name, &args->cnt, -1)) {
+		pr_err("#%d\t0x%"PRIx64"\t%c\t%s\n",
+		       ++args->cnt, sym->start,
+		       symbol__binding(sym) == STB_GLOBAL ? 'g' :
+		       symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w',
+		       sym->name);
+		args->near = true;
+	} else if (args->near) {
+		args->near = false;
+		pr_err("\t\twhich is near\t\t%s\n", sym->name);
+	}
+	return 0;
+}
+
 static void print_duplicate_syms(struct dso *dso, const char *sym_name)
 {
-	struct symbol *sym;
-	bool near = false;
-	int cnt = 0;
+	struct print_duplicate_syms_args args = {
+		.sym_name = sym_name,
+		.near = false,
+		.cnt = 0,
+	};
 
 	pr_err("Multiple symbols with name '%s'\n", sym_name);
 
-	sym = dso__first_symbol(dso);
-	while (sym) {
-		if (dso_sym_match(sym, sym_name, &cnt, -1)) {
-			pr_err("#%d\t0x%"PRIx64"\t%c\t%s\n",
-			       ++cnt, sym->start,
-			       symbol__binding(sym) == STB_GLOBAL ? 'g' :
-			       symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w',
-			       sym->name);
-			near = true;
-		} else if (near) {
-			near = false;
-			pr_err("\t\twhich is near\t\t%s\n", sym->name);
-		}
-		sym = dso__next_symbol(sym);
-	}
+	dso__for_each_symbol(dso, print_duplicate_syms_cb, &args);
 
 	pr_err("Disambiguate symbol name by inserting #n after the name e.g. %s #2\n",
 	       sym_name);
 	pr_err("Or select a global symbol by inserting #0 or #g or #G\n");
 }
 
+struct find_dso_sym_args {
+	const char *sym_name;
+	u64 *start;
+	u64 *size;
+	int idx;
+	int cnt;
+	bool duplicate;
+};
+
+static int find_dso_sym_cb(struct symbol *sym, void *data)
+{
+	struct find_dso_sym_args *args = data;
+
+	if (*args->start) {
+		if (!*args->size)
+			*args->size = sym->start - *args->start;
+		if (args->idx > 0) {
+			if (*args->size)
+				return 1;
+		} else if (dso_sym_match(sym, args->sym_name, &args->cnt, args->idx)) {
+			args->duplicate = true;
+			return 1;
+		}
+	} else if (dso_sym_match(sym, args->sym_name, &args->cnt, args->idx)) {
+		*args->start = sym->start;
+		*args->size = sym->end - sym->start;
+	}
+	return 0;
+}
+
 static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 			u64 *size, int idx)
 {
-	struct symbol *sym;
-	int cnt = 0;
+	struct find_dso_sym_args args = {
+		.sym_name = sym_name,
+		.start = start,
+		.size = size,
+		.idx = idx,
+		.cnt = 0,
+		.duplicate = false,
+	};
 
 	*start = 0;
 	*size = 0;
 
-	sym = dso__first_symbol(dso);
-	while (sym) {
-		if (*start) {
-			if (!*size)
-				*size = sym->start - *start;
-			if (idx > 0) {
-				if (*size)
-					return 0;
-			} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
-				print_duplicate_syms(dso, sym_name);
-				return -EINVAL;
-			}
-		} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
-			*start = sym->start;
-			*size = sym->end - sym->start;
-		}
-		sym = dso__next_symbol(sym);
+	dso__for_each_symbol(dso, find_dso_sym_cb, &args);
+	if (args.duplicate) {
+		print_duplicate_syms(dso, sym_name);
+		return -EINVAL;
 	}
 
 	if (!*start)
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e46cd614eb21..73d22e5c8253 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -2011,22 +2011,34 @@ static size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
 	return fprintf(fp, "%s", sbuild_id);
 }
 
+struct dso__fprintf_cb_args {
+	FILE *fp;
+	size_t ret;
+};
+
+static int dso__fprintf_cb(struct symbol *pos, void *data)
+{
+	struct dso__fprintf_cb_args *args = data;
+
+	args->ret += symbol__fprintf(pos, args->fp);
+	return 0;
+}
+
 size_t dso__fprintf(struct dso *dso, FILE *fp)
 {
-	struct rb_node *nd;
-	size_t ret = fprintf(fp, "dso: %s (", dso__short_name(dso));
+	struct dso__fprintf_cb_args args = {
+		.fp = fp,
+		.ret = fprintf(fp, "dso: %s (", dso__short_name(dso)),
+	};
 
 	if (dso__short_name(dso) != dso__long_name(dso))
-		ret += fprintf(fp, "%s, ", dso__long_name(dso));
-	ret += fprintf(fp, "%sloaded, ", dso__loaded(dso) ? "" : "NOT ");
-	ret += dso__fprintf_buildid(dso, fp);
-	ret += fprintf(fp, ")\n");
-	for (nd = rb_first_cached(dso__symbols(dso)); nd; nd = rb_next(nd)) {
-		struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
-		ret += symbol__fprintf(pos, fp);
-	}
+		args.ret += fprintf(fp, "%s, ", dso__long_name(dso));
+	args.ret += fprintf(fp, "%sloaded, ", dso__loaded(dso) ? "" : "NOT ");
+	args.ret += dso__fprintf_buildid(dso, fp);
+	args.ret += fprintf(fp, ")\n");
+	dso__for_each_symbol(dso, dso__fprintf_cb, &args);
 
-	return ret;
+	return args.ret;
 }
 
 enum dso_type dso__type(struct dso *dso, struct machine *machine)
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 532ad3ec156f..ed5cea45897e 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -371,6 +371,9 @@ int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
 #define dso__for_each_symbol(dso, cb, data)	\
 	symbols__visit(dso__symbols(dso), cb, data)
 
+#define dso__for_each_symbol_by_name(dso, cb, data)	\
+	dso__visit_symbols_by_name(dso, cb, data)
+
 static inline void *dso__a2l(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->a2l;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index e8b9c8a67b0a..9b7d315ca391 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2988,13 +2988,37 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	return 0;
 }
 
+struct intel_pt_switch_ip_args {
+	struct map *map;
+	const char *name;
+	bool check_global;
+	u64 ip;
+};
+
+static int intel_pt_switch_ip_cb(struct symbol *sym, void *data)
+{
+	struct intel_pt_switch_ip_args *args = data;
+	u64 ip;
+
+	if (args->check_global && symbol__binding(sym) != STB_GLOBAL)
+		return 0;
+
+	if (!strcmp(sym->name, args->name)) {
+		ip = map__unmap_ip(args->map, sym->start);
+		if (ip >= map__start(args->map) && ip < map__end(args->map)) {
+			args->ip = ip;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 {
 	struct machine *machine = pt->machine;
 	struct map *map;
-	struct symbol *sym, *start;
-	u64 ip, switch_ip = 0;
-	const char *ptss;
+	struct intel_pt_switch_ip_args args;
+	u64 switch_ip = 0;
 
 	if (ptss_ip)
 		*ptss_ip = 0;
@@ -3006,36 +3030,28 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 	if (map__load(map))
 		return 0;
 
-	start = dso__first_symbol(map__dso(map));
-
-	for (sym = start; sym; sym = dso__next_symbol(sym)) {
-		if (symbol__binding(sym) == STB_GLOBAL &&
-		    !strcmp(sym->name, "__switch_to")) {
-			ip = map__unmap_ip(map, sym->start);
-			if (ip >= map__start(map) && ip < map__end(map)) {
-				switch_ip = ip;
-				break;
-			}
-		}
-	}
+	args = (struct intel_pt_switch_ip_args) {
+		.map = map,
+		.name = "__switch_to",
+		.check_global = true,
+		.ip = 0,
+	};
+	map__for_each_symbol(map, intel_pt_switch_ip_cb, &args);
+	switch_ip = args.ip;
 
 	if (!switch_ip || !ptss_ip)
 		return 0;
 
-	if (pt->have_sched_switch == 1)
-		ptss = "perf_trace_sched_switch";
-	else
-		ptss = "__perf_event_task_sched_out";
-
-	for (sym = start; sym; sym = dso__next_symbol(sym)) {
-		if (!strcmp(sym->name, ptss)) {
-			ip = map__unmap_ip(map, sym->start);
-			if (ip >= map__start(map) && ip < map__end(map)) {
-				*ptss_ip = ip;
-				break;
-			}
-		}
-	}
+	args = (struct intel_pt_switch_ip_args) {
+		.map = map,
+		.name = pt->have_sched_switch == 1 ?
+			"perf_trace_sched_switch" :
+			"__perf_event_task_sched_out",
+		.check_global = false,
+		.ip = 0,
+	};
+	map__for_each_symbol(map, intel_pt_switch_ip_cb, &args);
+	*ptss_ip = args.ip;
 
 	return switch_ip;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5b4550e97172..1c417d012bcc 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1121,29 +1121,35 @@ int machine__create_extra_kernel_map(struct machine *machine,
 	return err;
 }
 
-static u64 find_entry_trampoline(struct dso *dso)
+static int find_entry_trampoline_cb(struct symbol *sym, void *data)
 {
 	/* Duplicates are removed so lookup all aliases */
-	const char *syms[] = {
+	static const char * const syms[] = {
 		"_entry_trampoline",
 		"__entry_trampoline_start",
 		"entry_SYSCALL_64_trampoline",
 	};
-	struct symbol *sym = dso__first_symbol(dso);
-	unsigned int i;
+	u64 *addr = data;
 
-	for (; sym; sym = dso__next_symbol(sym)) {
-		if (symbol__binding(sym) != STB_GLOBAL)
-			continue;
-		for (i = 0; i < ARRAY_SIZE(syms); i++) {
-			if (!strcmp(sym->name, syms[i]))
-				return sym->start;
+	if (symbol__binding(sym) != STB_GLOBAL)
+		return 0;
+	for (unsigned int i = 0; i < ARRAY_SIZE(syms); i++) {
+		if (!strcmp(sym->name, syms[i])) {
+			*addr = sym->start;
+			return 1;
 		}
 	}
-
 	return 0;
 }
 
+static u64 find_entry_trampoline(struct dso *dso)
+{
+	u64 addr = 0;
+
+	dso__for_each_symbol(dso, find_entry_trampoline_cb, &addr);
+	return addr;
+}
+
 /*
  * These values can be used for kernels that do not have symbols for the entry
  * trampolines in kallsyms.
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 3d506c09b749..e3f8e3cd68c0 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -3788,6 +3788,15 @@ void cleanup_perf_probe_events(struct perf_probe_event *pevs, int npevs)
 	}
 }
 
+static int show_available_funcs_cb(struct symbol *pos, void *data)
+{
+	struct strfilter *_filter = data;
+
+	if (strfilter__compare(_filter, pos->name))
+		printf("%s\n", pos->name);
+	return 0;
+}
+
 int show_available_funcs(const char *target, struct nsinfo *nsi,
 			 struct strfilter *_filter, bool user)
 {
@@ -3824,12 +3833,7 @@ int show_available_funcs(const char *target, struct nsinfo *nsi,
 	/* Show all (filtered) symbols */
 	setup_pager();
 
-	for (size_t i = 0; i < dso__symbol_names_len(dso); i++) {
-		struct symbol *pos = dso__symbol_names(dso)[i];
-
-		if (strfilter__compare(_filter, pos->name))
-			printf("%s\n", pos->name);
-	}
+	dso__for_each_symbol_by_name(dso, show_available_funcs_cb, _filter);
 end:
 	map__put(map);
 	exit_probe_symbol_maps();
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1f7faae5a357..8e724f71aa94 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -451,36 +451,6 @@ static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
 	return NULL;
 }
 
-static struct symbol *symbols__first(struct rb_root_cached *symbols)
-{
-	struct rb_node *n = rb_first_cached(symbols);
-
-	if (n)
-		return rb_entry(n, struct symbol, rb_node);
-
-	return NULL;
-}
-
-static struct symbol *symbols__last(struct rb_root_cached *symbols)
-{
-	struct rb_node *n = rb_last(&symbols->rb_root);
-
-	if (n)
-		return rb_entry(n, struct symbol, rb_node);
-
-	return NULL;
-}
-
-static struct symbol *symbols__next(struct symbol *sym)
-{
-	struct rb_node *n = rb_next(&sym->rb_node);
-
-	if (n)
-		return rb_entry(n, struct symbol, rb_node);
-
-	return NULL;
-}
-
 static int symbols__sort_name_cmp(const void *vlhs, const void *vrhs)
 {
 	const struct symbol *lhs = *((const struct symbol **)vlhs);
@@ -637,19 +607,21 @@ struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr)
 	return symbols__find(dso__symbols(dso), addr);
 }
 
-struct symbol *dso__first_symbol(struct dso *dso)
+int dso__visit_symbols_by_name(struct dso *dso,
+			       int (*cb)(struct symbol *sym, void *data),
+			       void *data)
 {
-	return symbols__first(dso__symbols(dso));
-}
+	if (!dso)
+		return 0;
 
-struct symbol *dso__last_symbol(struct dso *dso)
-{
-	return symbols__last(dso__symbols(dso));
-}
+	dso__sort_by_name(dso);
+	for (size_t i = 0; i < dso__symbol_names_len(dso); i++) {
+		int ret = cb(dso__symbol_names(dso)[i], data);
 
-struct symbol *dso__next_symbol(struct symbol *sym)
-{
-	return symbols__next(sym);
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
 
 struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 5a105b10a089..784c87b72f38 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -197,10 +197,9 @@ struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr);
 
 struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx);
 struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx);
-
-struct symbol *dso__first_symbol(struct dso *dso);
-struct symbol *dso__last_symbol(struct dso *dso);
-struct symbol *dso__next_symbol(struct symbol *sym);
+int dso__visit_symbols_by_name(struct dso *dso,
+			       int (*cb)(struct symbol *sym, void *data),
+			       void *data);
 
 enum dso_type dso__type_fd(int fd);
 
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 4dc8d5761f52..f818e7ad1519 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -59,15 +59,26 @@ size_t symbol__fprintf_symname(const struct symbol *sym, FILE *fp)
 	return __symbol__fprintf_symname_offs(sym, NULL, false, false, fp);
 }
 
+struct fprintf_symbols_by_name_args {
+	FILE *fp;
+	size_t ret;
+};
+
+static int fprintf_symbols_by_name_cb(struct symbol *pos, void *data)
+{
+	struct fprintf_symbols_by_name_args *args = data;
+
+	args->ret += fprintf(args->fp, "%s\n", pos->name);
+	return 0;
+}
+
 size_t dso__fprintf_symbols_by_name(struct dso *dso,
 				    FILE *fp)
 {
-	size_t ret = 0;
-
-	for (size_t i = 0; i < dso__symbol_names_len(dso); i++) {
-		struct symbol *pos = dso__symbol_names(dso)[i];
+	struct fprintf_symbols_by_name_args args = {
+		.fp = fp,
+	};
 
-		ret += fprintf(fp, "%s\n", pos->name);
-	}
-	return ret;
+	dso__for_each_symbol_by_name(dso, fprintf_symbols_by_name_cb, &args);
+	return args.ret;
 }
-- 
2.56.1.750.gf70dc682cf-goog

