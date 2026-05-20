Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F133F5A2
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303960; cv=none; b=kjcq/dE2tZMg53smT8A6AcAOHZuPjLDP+yqmYpRzgzRMAIHAoE28Gf5NaLegRf4p9rJizBCj6X5eRWSUCbOJ1yFjMuL04Bv0LEHO7u81f3VG9v6bFgwo0dpAS185UkuzKUkTFyx1r5Ass9OzHodMvnwfej+dS/Kk3uCNn40Y30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303960; c=relaxed/simple;
	bh=dKLnSxAoHXvJeW1Hqq96YCMdphK0FAgj/mwypvNpb1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uD+jfmdc3SRASkVzs//efuGZGiV/1/RsA8G1QQet6uCYYWr6lv0N8XGgrZsyvQHl483FgN5gH273zN8rEvZsE1pDpiEVosEtKPdtDEHGLExLw7IkPYvzNJBkYPIBOLx4lST564SF5V1AoS1OCeryV5ErmnJDJVLVcPBpNZq3mnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lk7dN3JU; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lk7dN3JU"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-135916eefa0so4934572c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303957; x=1779908757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=raizxW2Hr9qQ3yLUpsiLIti5Puq0sLfgWAi/JxOOiyA=;
        b=Lk7dN3JUdA/M5PMCq4XJs46ydJfybf5cdsDvl4XggNdt5wh3264mB4kBPFj+G+rGpz
         xHn5S12YVLt/7H9S0h9SnFD/qPrEtlgLnI/sNftVUPvVDyxJxyXo5ngQcSgeZv6k75I3
         yF+PR4DrPpn/h13ihVU+3/JeU7BIeCKzsy4CH1agEwolpWadI2hOXI1wCk+T+vu8SBVx
         P1eNmxOMVewXdf/FdiW6eGLvCXckxKLcKzNFW7OHUq9XZz5E5d8zW9G7/+pmR1jKyaJs
         OD7/yArycbDuvnkLXXAqA27iRv8LO6PfInuANodFd8nACc9gpPy2I5vo6n7ftxKgSQF/
         HeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303957; x=1779908757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=raizxW2Hr9qQ3yLUpsiLIti5Puq0sLfgWAi/JxOOiyA=;
        b=i+eq5eVEykPKxMio3dEDcOuoWnyomJ/3a05Fjs2s5kAGaDcNL2oW/3NfupOw+hYAfX
         u7BdAhJRKu6U71dvQttU/+b00qqGuHmj/SVwEmzvwPSFa20a6YArtK/GQ/DgNWfGMoxV
         STrwx5qsBOfUWBtdD0Y5Ov3ulHwwrTwj+t3y/nLR8vcuRTsK9cx5EwznTS3WMHR8QhOr
         hMe45aRgbxXjzvEwQZNnIk3zGu11kiM18N8on9IERMHAZBwoQv5Oe0dz8AJCDafRHK3V
         quVbguo5wiJrxRahrr7aa7admTwfDCQlmwkkSudF2IHq01I057dQYa7BcDQjbm/Q/5VD
         F/AA==
X-Forwarded-Encrypted: i=1; AFNElJ94RNO8JFx4cYFw40/Uao9OYOuGeCQkMLyM8TAniYBjCD/mOsoJ3NxW1dmmWIalO7/WbAb8xZ0VIrEHmZe45Y8B@vger.kernel.org
X-Gm-Message-State: AOJu0YwPlCNQ1gt7wYBC7qI+rRRZqZ4sgX9v5jlcMXvkNGXwSYooXeVQ
	BIcsnRPBI16CadZfsQzJe1c+evGRB8rQuLxpHEJM4gW957OTUuinOeguC2Uoy3Nxq4bd+MDmD5/
	GAZr2NfjMVw==
X-Received: from dled19-n2.prod.google.com ([2002:a05:701b:42d3:20b0:12d:b839:d0b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2202:b0:135:245e:4dba
 with SMTP id a92af1059eb24-135246db81bmr6961603c88.22.1779303957025; Wed, 20
 May 2026 12:05:57 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:13 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-8-irogers@google.com>
Subject: [PATCH v14 07/32] perf hist: Remove evsel parameter from inc samples functions
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

As struct perf_sample now directly contains its own resolved evsel pointer,
passing the evsel separately is redundant and clutters the interface.

Remove the redundant evsel parameter from hist-specific handlers and
structures, ensuring the tool always directly accesses the evsel bound to the
sample. This simplifies the API signatures and eliminates the risk of passing
an inconsistent evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
index 9955ce8cce00..cc3ee712fe62 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -171,7 +171,6 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	int err = 0;
 	struct report *rep = arg;
 	struct hist_entry *he = iter->he;
-	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
 	struct mem_info *mi;
 	struct branch_info *bi;
@@ -181,25 +180,25 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 
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
@@ -215,7 +214,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	struct report *rep = arg;
 	struct branch_info *bi = he->branch_info;
 	struct perf_sample *sample = iter->sample;
-	struct evsel *evsel = iter->evsel;
 	int err;
 
 	branch_type_count(&rep->brtype_stat, &bi->flags,
@@ -224,11 +222,11 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
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
2.54.0.746.g67dd491aae-goog

