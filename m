Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD8516F0DC
	for <linux-perf-users@vger.kernel.org>; Tue,  7 May 2024 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106987; cv=none; b=CeImGmcZWA3VVri7QfB6qL/uOu0zMJXPWd2Yg/hkKqu8UstEoqSXxqEhM4DXB5MLTJyq38SOOQw2h6Jg1Ur1T/1q0w88+hwFePQQh3v089Gl9TJM+XvjLYRTqzg0kMM3bLYd6lR0lpCE5HS9rv1y7k+koXUiE+oqithXxCFpvMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106987; c=relaxed/simple;
	bh=CZSkYQ87LqNxKB6+cfjHvCInBypTk1PVj9bAsiWh/bE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pX4pNs+nlwj4HTy3DGIuDLJI6zhlZGJGCvz/3wBLf31kBro639QplherjCNu6nqEtKf+6QN8X07PtCuRbN0tYzb5qWm7Tas8LGK5bzit+rl9R2IEFGvyOPifIQFEnQUjAJhSRZ8S2ywf1R07ymryqQAwyKY12fxzjTe/NGoNxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ay1tSMhi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ay1tSMhi"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bb09d8fecso63130347b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 May 2024 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106984; x=1715711784; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6D30HL2E3T95rFOwqlYE0nA8a5DhBCmO1MCVWhQ7Mk=;
        b=Ay1tSMhi21TTlL3dMkSsNI6cn2NMUTKxF67VxgWYUOACov7XLxuf3wOS6m1UrGCGQY
         0oO5gB8kguHk8LUmqkc7AKkb3m78V+o9lWrFObW/xDmIFlwSeKylS0A4MA5X+3VIw/5Z
         Rc5UEv2Htr6Cmwtwo2x52wH6OfqAUXyXeKeKGbxGqV2vit3eAkvvdL28haC00mhv8gal
         Vs97MIdUWywFOj+au74U6XfzI81i4l+uDePd+K8neD3M926ab9l9n/aorIwo6IZz9Jt4
         0n0iKpPDznKmMZYk+smJH86rmjBPySf3KfrkPTwFRXPxgDGX37xq0usi5jEPxdh5i6IK
         fu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106984; x=1715711784;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6D30HL2E3T95rFOwqlYE0nA8a5DhBCmO1MCVWhQ7Mk=;
        b=FVxaNXtz3okyo0WcwwR5JTzDB4BWNOI7avknFQaibP5xluWq6OXH+CCnAXHvXDTjYO
         NPP6PR6SlzFEVmHnvbqIVjsTV6p4PG3YsSHTGYR9v2VjOdYNqTUkEnQcb7GTSXooRdcX
         0yo6aycRmqWLBUnmsGOf507JpCKEivseHQ9CAIvaWVLN0SKPKlYanhmp3tYBXDbZoMEc
         4X1nnKrt+ovwAE7UFkEQ+rkf+yhUu765iv7qHNA5/3ktSaqklzGvOkwWjWeqsWBhoqBt
         DUUP9W7GXzwLiBwZPW7b2NG1ZUkDf6y2SUN+V9K7MZGzEYmy8BPMr2p3wObiRdD7ZEeV
         +XbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXllnDKOaHSeFS32qzT2zEPgq4h6PFql3zLJD5pF6T+vDj0Ab7Iwg6L5UAuA6CrRSG7CZvgXBSTNweWAmEBmJ/NCxFnMcXUo+jv7cWpcqSZxQ==
X-Gm-Message-State: AOJu0YxWgwvmGY761EyWRTgPyM3Fx2AAuVJSK3RVePAJaLwNuSUtvbh8
	/QUc2dKRNqvqS3yuhpp5NmfQ6Bs2aTelXVunQcvOzdBhsJWqFswDTikxhZxoA6eGg/3kC3lk7mf
	yk21kRw==
X-Google-Smtp-Source: AGHT+IF51C/3SpPdz7yAAmpM3m/2eFLFQvf09wiZMfBZyHHt5wFNxaj5W703N9kTg9Oz3vcP8x6FeMr4s8u7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8095:fd7:9773:b1df])
 (user=irogers job=sendgmr) by 2002:a25:c78d:0:b0:de6:141a:b0de with SMTP id
 3f1490d57ef6-debb9d887e9mr46121276.10.1715106983803; Tue, 07 May 2024
 11:36:23 -0700 (PDT)
Date: Tue,  7 May 2024 11:35:45 -0700
In-Reply-To: <20240507183545.1236093-1-irogers@google.com>
Message-Id: <20240507183545.1236093-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 8/8] perf hist: Avoid hist_entry_iter mem_info memory leak
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	James Clark <james.clark@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct mem_info is reference counted while branch_info and he_cache
are not. Break apart the priv field in hist_entry_iter so that we can
know which values are owned by the iter and do the appropriate free or
put. Move hide_unresolved to marginally shrink the size of the now
grown struct.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hist.c | 39 ++++++++++++++-------------------------
 tools/perf/util/hist.h |  8 +++++---
 2 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 00814d42d5f1..2e9e193179dd 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -476,13 +476,6 @@ static int hist_entry__init(struct hist_entry *he,
 		he->branch_info->to.ms.map = map__get(he->branch_info->to.ms.map);
 	}
 
-	if (he->mem_info) {
-		mem_info__iaddr(he->mem_info)->ms.map =
-			map__get(mem_info__iaddr(he->mem_info)->ms.map);
-		mem_info__daddr(he->mem_info)->ms.map =
-			map__get(mem_info__daddr(he->mem_info)->ms.map);
-	}
-
 	if (hist_entry__has_callchains(he) && symbol_conf.use_callchain)
 		callchain_init(he->callchain);
 
@@ -574,7 +567,6 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 			he = NULL;
 		}
 	}
-
 	return he;
 }
 
@@ -747,7 +739,7 @@ __hists__add_entry(struct hists *hists,
 		.filtered = symbol__parent_filter(sym_parent) | al->filtered,
 		.hists	= hists,
 		.branch_info = bi,
-		.mem_info = mi,
+		.mem_info = mem_info__get(mi),
 		.kvm_info = ki,
 		.block_info = block_info,
 		.transaction = sample->transaction,
@@ -836,7 +828,7 @@ iter_prepare_mem_entry(struct hist_entry_iter *iter, struct addr_location *al)
 	if (mi == NULL)
 		return -ENOMEM;
 
-	iter->priv = mi;
+	iter->mi = mi;
 	return 0;
 }
 
@@ -844,7 +836,7 @@ static int
 iter_add_single_mem_entry(struct hist_entry_iter *iter, struct addr_location *al)
 {
 	u64 cost;
-	struct mem_info *mi = iter->priv;
+	struct mem_info *mi = iter->mi;
 	struct hists *hists = evsel__hists(iter->evsel);
 	struct perf_sample *sample = iter->sample;
 	struct hist_entry *he;
@@ -891,12 +883,7 @@ iter_finish_mem_entry(struct hist_entry_iter *iter,
 	err = hist_entry__append_callchain(he, iter->sample);
 
 out:
-	/*
-	 * We don't need to free iter->priv (mem_info) here since the mem info
-	 * was either already freed in hists__findnew_entry() or passed to a
-	 * new hist entry by hist_entry__new().
-	 */
-	iter->priv = NULL;
+	mem_info__zput(iter->mi);
 
 	iter->he = NULL;
 	return err;
@@ -915,7 +902,7 @@ iter_prepare_branch_entry(struct hist_entry_iter *iter, struct addr_location *al
 	iter->curr = 0;
 	iter->total = sample->branch_stack->nr;
 
-	iter->priv = bi;
+	iter->bi = bi;
 	return 0;
 }
 
@@ -929,7 +916,7 @@ iter_add_single_branch_entry(struct hist_entry_iter *iter __maybe_unused,
 static int
 iter_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *al)
 {
-	struct branch_info *bi = iter->priv;
+	struct branch_info *bi = iter->bi;
 	int i = iter->curr;
 
 	if (bi == NULL)
@@ -958,7 +945,7 @@ iter_add_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *a
 	int i = iter->curr;
 	int err = 0;
 
-	bi = iter->priv;
+	bi = iter->bi;
 
 	if (iter->hide_unresolved && !(bi[i].from.ms.sym && bi[i].to.ms.sym))
 		goto out;
@@ -987,7 +974,7 @@ static int
 iter_finish_branch_entry(struct hist_entry_iter *iter,
 			 struct addr_location *al __maybe_unused)
 {
-	zfree(&iter->priv);
+	zfree(&iter->bi);
 	iter->he = NULL;
 
 	return iter->curr >= iter->total ? 0 : -1;
@@ -1055,7 +1042,7 @@ iter_prepare_cumulative_entry(struct hist_entry_iter *iter,
 	if (he_cache == NULL)
 		return -ENOMEM;
 
-	iter->priv = he_cache;
+	iter->he_cache = he_cache;
 	iter->curr = 0;
 
 	return 0;
@@ -1068,7 +1055,7 @@ iter_add_single_cumulative_entry(struct hist_entry_iter *iter,
 	struct evsel *evsel = iter->evsel;
 	struct hists *hists = evsel__hists(evsel);
 	struct perf_sample *sample = iter->sample;
-	struct hist_entry **he_cache = iter->priv;
+	struct hist_entry **he_cache = iter->he_cache;
 	struct hist_entry *he;
 	int err = 0;
 
@@ -1126,7 +1113,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 {
 	struct evsel *evsel = iter->evsel;
 	struct perf_sample *sample = iter->sample;
-	struct hist_entry **he_cache = iter->priv;
+	struct hist_entry **he_cache = iter->he_cache;
 	struct hist_entry *he;
 	struct hist_entry he_tmp = {
 		.hists = evsel__hists(evsel),
@@ -1192,7 +1179,9 @@ static int
 iter_finish_cumulative_entry(struct hist_entry_iter *iter,
 			     struct addr_location *al __maybe_unused)
 {
-	zfree(&iter->priv);
+	mem_info__zput(iter->mi);
+	zfree(&iter->bi);
+	zfree(&iter->he_cache);
 	iter->he = NULL;
 
 	return 0;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 5260822b9773..8fb3bdd29188 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -132,18 +132,20 @@ struct hist_entry_iter {
 	int total;
 	int curr;
 
-	bool hide_unresolved;
-
 	struct evsel *evsel;
 	struct perf_sample *sample;
 	struct hist_entry *he;
 	struct symbol *parent;
-	void *priv;
+
+	struct mem_info *mi;
+	struct branch_info *bi;
+	struct hist_entry **he_cache;
 
 	const struct hist_iter_ops *ops;
 	/* user-defined callback function (optional) */
 	int (*add_entry_cb)(struct hist_entry_iter *iter,
 			    struct addr_location *al, bool single, void *arg);
+	bool hide_unresolved;
 };
 
 extern const struct hist_iter_ops hist_iter_normal;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

