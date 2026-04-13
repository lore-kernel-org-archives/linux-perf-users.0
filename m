Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B820299B
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043371; cv=none; b=nwaV3a/jvK2cvCOkxqefbfXth1EJLeEj9tS/YQE+uyxYXzccjt0beU97EqOuI5Pe3EU4R9X2kvM7F3aAxGtBntKGma184pCvjSMXhKk8AVmcp9IxlD8jSNR1lmH5DULYSSiu/Vgv8LqfLoJUfwbp6lsWwhBQo1vyyV1Hx3JwpXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043371; c=relaxed/simple;
	bh=nrE8NbjgL5GodtjlelQu6WKY5Rt5ryJ3pELk9LbtElA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JNJw4UY7R9WrzTlqg40EuzFX247u+ErVrwNWEp8XUxGt9Ou8N9rVQSrAa11OPsLFJMso3h9IEerq0KFaFk52lyp1msops07TeM/3mzBHDBQgo/6TUJMUMMyenGKO5XO8LZ0N5VT5EwE+doJZjT4DstAXTYGHwYdsyDfL75uGj2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fTkxMdcA; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTkxMdcA"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d889997495so2294989eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043369; x=1776648169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYe/pTSkEo3bwawbKUcGMi5fd/X0VJXe6Y5bot3/3gQ=;
        b=fTkxMdcArzgz855QKL+Hi/ACQ6nRt6ISP2fQRmuiffA8qvwlh8KlkqPDW4VdEnM9tF
         NmrxoMaZd74xcnbI+RnBLEVuMhtQF6Eu6pnfDI2Qa7B4gXcU63V3X/K887plm1hMWfmW
         tdBtqmMlOU063GyLFfKakU745SPpwB1xlQPF1QRpLGKIzHQavQal9xJPNzu7SWfyk/0M
         4o59jbH54izcTa+IzaTmFgrCxyzxl8lmCLyySvftQ76OG64RKGo1+G7+5l/PgvQKevJ/
         pMn4ZhIwtwwkSjdun4jQLdOh1c7e9acgt0yqAya0nmCvRRC88IdgpuJMe78QacSa8KgF
         cQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043369; x=1776648169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYe/pTSkEo3bwawbKUcGMi5fd/X0VJXe6Y5bot3/3gQ=;
        b=eNpgCABKNTRMlVG5vWlWCK/guigYG4CVftFNkJuB9SiPLmQroyTtP/YbheBCe9a59V
         FWXPL3eNyXmcklyT4aEVKUCLwPdqk0fys/6d2gw6G3yAyekR0yN95y95Xb50jfJc84Zw
         Jt37cWFOdordAmMSfx5LoebyYD3Rj/yVGPUbBfiSfyKvjWp5QtS7QBw2GEIBeDuCADIY
         IcegtPz5bsQgpxcVecirhMen+wSxwe6JqCm/B9tdbwdf8WxlWyNjHEClJJrqonfiCxTF
         vlU6uLl3VAe/X4lFDJaUmSvTl/DZjPKVOnvPVLiu0e9DyHFZbUanAx2embXpyyc8quHN
         0JqA==
X-Forwarded-Encrypted: i=1; AFNElJ8+agqEnXvl7D5HHTnfLu3s4/rb78tkJrzVAbXOv/yka2zdo9HfdQGq9wmkO7Xscuc2f9HixMv18byD99i0lBon@vger.kernel.org
X-Gm-Message-State: AOJu0YxjMawOVTQdZ50cpuvblb6Rc+SGvlUfJs6ePCrn/fc7rd21C1QR
	XnB2iA7WKMWFlv2j9f3GsNbFEABegp+BoqKsqDifHPbSXpu+7WOaxjZQ4tq6lPz6xCpqby0ORow
	ELkw21I6JgQ==
X-Received: from dykp42.prod.google.com ([2002:a05:7300:caa:b0:2cb:a16b:ff43])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4194:b0:2d1:a3ea:d8c5
 with SMTP id 5a478bee46e88-2d5881acd82mr6333076eec.17.1776043368820; Sun, 12
 Apr 2026 18:22:48 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:02 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-9-irogers@google.com>
Subject: [PATCH v11 08/33] perf hist: Remove evsel parameter from inc samples functions
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

hist_entry__inc_addr_samples and addr_map_symbol__inc_samples
unnecessarily take an evsel argument. Read the evsel from the sample
instead.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c |  7 +++----
 tools/perf/builtin-c2c.c      |  2 +-
 tools/perf/builtin-report.c   | 18 ++++++++----------
 tools/perf/builtin-top.c      |  6 +++---
 tools/perf/util/annotate.c    | 19 +++++++++----------
 tools/perf/util/annotate.h    |  6 ++----
 6 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 58e56f826367..ee1ba2dc35f4 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -176,16 +176,15 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	struct hist_entry *he = iter->he;
 	struct branch_info *bi;
 	struct perf_sample *sample = iter->sample;
-	struct evsel *evsel = iter->evsel;
 	int err;
 
 	bi = he->branch_info;
-	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
+	err = addr_map_symbol__inc_samples(&bi->from, sample);
 
 	if (err)
 		goto out;
 
-	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
+	err = addr_map_symbol__inc_samples(&bi->to, sample);
 
 out:
 	return err;
@@ -275,7 +274,7 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
 	if (he == NULL)
 		return -ENOMEM;
 
-	ret = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
+	ret = hist_entry__inc_addr_samples(he, sample, al->addr);
 	hists__inc_nr_samples(hists, true);
 	return ret;
 }
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 2fa3d7ec8a09..36f386949923 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -371,7 +371,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 	if (perf_c2c__has_annotation(NULL)) {
 		perf_c2c__evsel_hists_inc_stats(evsel, he, sample);
-		addr_map_symbol__inc_samples(mem_info__iaddr(mi), sample, evsel);
+		addr_map_symbol__inc_samples(mem_info__iaddr(mi), sample);
 	}
 
 	ret = hist_entry__append_callchain(he, sample);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 848e2ccb1420..46d839bbaeef 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -170,7 +170,6 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	int err = 0;
 	struct report *rep = arg;
 	struct hist_entry *he = iter->he;
-	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
 	struct mem_info *mi;
 	struct branch_info *bi;
@@ -180,25 +179,25 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 
 	if (sort__mode == SORT_MODE__BRANCH) {
 		bi = he->branch_info;
-		err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
+		err = addr_map_symbol__inc_samples(&bi->from, sample);
 		if (err)
 			goto out;
 
-		err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
+		err = addr_map_symbol__inc_samples(&bi->to, sample);
 
 	} else if (rep->mem_mode) {
 		mi = he->mem_info;
-		err = addr_map_symbol__inc_samples(mem_info__daddr(mi), sample, evsel);
+		err = addr_map_symbol__inc_samples(mem_info__daddr(mi), sample);
 		if (err)
 			goto out;
 
-		err = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
+		err = hist_entry__inc_addr_samples(he, sample, al->addr);
 
 	} else if (symbol_conf.cumulate_callchain) {
 		if (single)
-			err = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
+			err = hist_entry__inc_addr_samples(he, sample, al->addr);
 	} else {
-		err = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
+		err = hist_entry__inc_addr_samples(he, sample, al->addr);
 	}
 
 out:
@@ -214,7 +213,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	struct report *rep = arg;
 	struct branch_info *bi = he->branch_info;
 	struct perf_sample *sample = iter->sample;
-	struct evsel *evsel = iter->evsel;
 	int err;
 
 	branch_type_count(&rep->brtype_stat, &bi->flags,
@@ -223,11 +221,11 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
-	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
+	err = addr_map_symbol__inc_samples(&bi->from, sample);
 	if (err)
 		goto out;
 
-	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
+	err = addr_map_symbol__inc_samples(&bi->to, sample);
 
 out:
 	return err;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f6eb543de537..b4fc991b4eeb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -199,7 +199,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 static void perf_top__record_precise_ip(struct perf_top *top,
 					struct hist_entry *he,
 					struct perf_sample *sample,
-					struct evsel *evsel, u64 ip)
+					u64 ip)
 	EXCLUSIVE_LOCKS_REQUIRED(he->hists->lock)
 {
 	struct annotation *notes;
@@ -216,7 +216,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 	if (!annotation__trylock(notes))
 		return;
 
-	err = hist_entry__inc_addr_samples(he, sample, evsel, ip);
+	err = hist_entry__inc_addr_samples(he, sample, ip);
 
 	annotation__unlock(notes);
 
@@ -735,7 +735,7 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
 	struct evsel *evsel = iter->evsel;
 
 	if (perf_hpp_list.sym && single)
-		perf_top__record_precise_ip(top, iter->he, iter->sample, evsel, al->addr);
+		perf_top__record_precise_ip(top, iter->he, iter->sample, al->addr);
 
 	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
 			     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY),
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e745f3034a0e..470569745abe 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -213,9 +213,10 @@ static int __symbol__account_cycles(struct cyc_hist *ch,
 }
 
 static int __symbol__inc_addr_samples(struct map_symbol *ms,
-				      struct annotated_source *src, struct evsel *evsel, u64 addr,
+				      struct annotated_source *src, u64 addr,
 				      struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	struct symbol *sym = ms->sym;
 	long hash_key;
 	u64 offset;
@@ -318,7 +319,7 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 }
 
 static int symbol__inc_addr_samples(struct map_symbol *ms,
-				    struct evsel *evsel, u64 addr,
+				    u64 addr,
 				    struct perf_sample *sample)
 {
 	struct symbol *sym = ms->sym;
@@ -326,8 +327,8 @@ static int symbol__inc_addr_samples(struct map_symbol *ms,
 
 	if (sym == NULL)
 		return 0;
-	src = symbol__hists(sym, evsel->evlist->core.nr_entries);
-	return src ? __symbol__inc_addr_samples(ms, src, evsel, addr, sample) : 0;
+	src = symbol__hists(sym, sample->evsel->evlist->core.nr_entries);
+	return src ? __symbol__inc_addr_samples(ms, src, addr, sample) : 0;
 }
 
 static int symbol__account_br_cntr(struct annotated_branch *branch,
@@ -581,16 +582,14 @@ static int annotation__compute_ipc(struct annotation *notes, size_t size,
 	return 0;
 }
 
-int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
-				 struct evsel *evsel)
+int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample)
 {
-	return symbol__inc_addr_samples(&ams->ms, evsel, ams->al_addr, sample);
+	return symbol__inc_addr_samples(&ams->ms, ams->al_addr, sample);
 }
 
-int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
-				 struct evsel *evsel, u64 ip)
+int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample, u64 ip)
 {
-	return symbol__inc_addr_samples(&he->ms, evsel, ip, sample);
+	return symbol__inc_addr_samples(&he->ms, ip, sample);
 }
 
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 696e36dbf013..1aa6df7d1618 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -422,8 +422,7 @@ static inline struct annotation *symbol__annotation(struct symbol *sym)
 	return (void *)sym - symbol_conf.priv_size;
 }
 
-int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
-				 struct evsel *evsel);
+int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample);
 
 struct annotated_branch *annotation__get_branch(struct annotation *notes);
 
@@ -433,8 +432,7 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 				    struct evsel *evsel,
 				    u64 br_cntr);
 
-int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
-				 struct evsel *evsel, u64 addr);
+int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample, u64 addr);
 
 struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists);
 void symbol__annotate_zero_histograms(struct symbol *sym);
-- 
2.53.0.1213.gd9a14994de-goog

