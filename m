Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884733D9022
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248857; cv=none; b=JWNrKRxaJd57628d/T18hbyA/nCUm/cD0vcr/IJx/L6bxHcrNCk6Cj7y6x5SNoLryQQHJ/IyS8LOqidlz5/5uw+DDcbOq65hwdrqM7xSGb+RdTJYIUKrJjWi9H2TdN9utTBwdVwxbfiDf63Ma9YfZZWLQt8RLyvgUJBu+Yl8AW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248857; c=relaxed/simple;
	bh=dTakRFq+3hjeVloe4iHCXNw7Dee9NH42FeVhCpT0lVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=isQuUgClotsYjYH5Voo5gyxuuAVcALZt/epHaTkLycm7jjW39KIR/+RROj+PXjItHy8hFFhTDH6qvXMp7AJn5e3WAX097oDWWOyG4n5t1wPOyXarh5kTT0juKRzimvoulpLlMILBXnDOf4sos1NeKQXM+jRCHalRQYXGSev/aAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLxHO7XX; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLxHO7XX"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12721cd1a2aso11297459c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248850; x=1775853650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2FLhx5V0ymgc8/HiT98CwKQoIrTyFPHn++TN0eREEo=;
        b=eLxHO7XXbQi7baT1EJ3Jt7MUtzfj7wlnN9uQBibyK/QeOQrYJ2ZE+uBWG+MuoBGwMl
         td+UY89mCkklNMtVRWuSaRX+5vHES2oI/t0Qp7pa9hhsjC81aWtuSDmiqNT7HR77HHYg
         Qp1Ed7GpYl0xI9PeasDTpCf9t/CF529CQLHxBbJDQVNXxDi6IwZwylGlYMATnR/g59Vt
         hZaan94LslWDupBd7SJf8TXA0yQ5qeqLZUshUFA9BXx9pePhzbWyHRQpRzdyslq458zz
         RXsI1eBqBgi7edJSp+gKASvz3WaP7MTZGp8xFF+0Dj+NmrTxrgchfl7jxjrQp2gKAYUN
         aH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248850; x=1775853650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2FLhx5V0ymgc8/HiT98CwKQoIrTyFPHn++TN0eREEo=;
        b=nQnu9QdXm2pM7Sc7z7tqrYM2pNtmvGJ4RmWwiiEpyJ/AJ3CyEoeBL+PhS+mf0cUG0Y
         G38/5N9CadiVh6pdTXfan0Ws3JNZEQ8ga1xs9I89XKMLZxxuzEgck0urb7dpItTpyM0p
         R92zZxWHnSwBnlzRUtXWerTxxIuXZyiVXuvFf5rGxAnZGDDzdYgveqfRBWfzp04vCWCo
         1IxJK++SEChvS5PY75wqpNBLLa4PSZUD1XRW/N4LlvU3NQOpPRrx6aVOrNegAnMO77nP
         OIEKW/No9ctgo9Az6Fqyoq6fVcJhkWdUGiw3zeBiFm2MrDa2JCc1nfs4b3n7dpQljJwC
         pMYg==
X-Forwarded-Encrypted: i=1; AJvYcCUsL6zdleWbHQarLltklV5RDcgnH31s2IEf5M6eQTv3w3CxApYmudOLut54BZTMZXdrg3zU8CrCrNmgIuS8o3Jb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy769sDVc6NsLA+CCXAjcMcJCicDCyrqzdlDUPeebGPw45VQL2h
	QgpNq1CJhMRNyrt0bUA/OBPJdkmY04I3wKskStcsQKBNcH6vIVEZsl3OKhF78T4EfwPq57OerAQ
	2YBVfEnq4jg==
X-Received: from dldnz7.prod.google.com ([2002:a05:701a:ca07:b0:12a:6c72:daa3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea31:b0:128:ce44:be8f
 with SMTP id a92af1059eb24-12bfb6e980bmr2195283c88.2.1775248849648; Fri, 03
 Apr 2026 13:40:49 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:03 -0700
In-Reply-To: <20260403204017.2919994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
 <20260403204017.2919994-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-12-irogers@google.com>
Subject: [PATCH v5 11/25] perf hist: Remove evsel parameter from inc samples functions
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
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
index c97a0fe159f8..c2d0599fe5f5 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -177,16 +177,15 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
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
@@ -276,7 +275,7 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
 	if (he == NULL)
 		return -ENOMEM;
 
-	ret = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
+	ret = hist_entry__inc_addr_samples(he, sample, al->addr);
 	hists__inc_nr_samples(hists, true);
 	return ret;
 }
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f9ac871264af..5684c14c2bf6 100644
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
index 507002cbdd5b..39968ae5cfb0 100644
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
index 37950efb28ac..b879592ae745 100644
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
index 63f0ee9d4c03..d97cb087a63e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -214,9 +214,10 @@ static int __symbol__account_cycles(struct cyc_hist *ch,
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
@@ -319,7 +320,7 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 }
 
 static int symbol__inc_addr_samples(struct map_symbol *ms,
-				    struct evsel *evsel, u64 addr,
+				    u64 addr,
 				    struct perf_sample *sample)
 {
 	struct symbol *sym = ms->sym;
@@ -327,8 +328,8 @@ static int symbol__inc_addr_samples(struct map_symbol *ms,
 
 	if (sym == NULL)
 		return 0;
-	src = symbol__hists(sym, evsel->evlist->core.nr_entries);
-	return src ? __symbol__inc_addr_samples(ms, src, evsel, addr, sample) : 0;
+	src = symbol__hists(sym, sample->evsel->evlist->core.nr_entries);
+	return src ? __symbol__inc_addr_samples(ms, src, addr, sample) : 0;
 }
 
 static int symbol__account_br_cntr(struct annotated_branch *branch,
@@ -582,16 +583,14 @@ static int annotation__compute_ipc(struct annotation *notes, size_t size,
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

