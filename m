Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992403FB04B
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034912; cv=none; b=bKwdE3D5SOK5tG9df7akDkCi2KLcwA4xQocVTKNo+lafX13Mc7OlgLpxsinNPpbvbM80i53qa3zZyVlH39xqOBBZjLkDN7S3NQh/DczTj+Jx29ady6DIwrndQ2Tagftahv9ns2sP9GEo6eZ754Va6myjSB2/TRpZ5a+DOBsL2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034912; c=relaxed/simple;
	bh=pkK9HPaXhZiS9d2kBp5ohDgmZW3haOyp+PwoUwhtDmA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ARzf4hndaORsDbeh0xhRjVTYbFP4JUdVQZIteaQVuLTvdZSFx4jdDc/IF7dpxB+cYJ77RvQJAj0gA/GReOtp86L6nbGgo/0qi/TlBc17Fk21G7gYhO53bkHVNzY1bzgV1pGxWFp4FwIe8hD5touYLvnC4dxDoUqSZRmCu/DFs+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJQc2ac3; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJQc2ac3"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so1923862eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034904; x=1774639704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbiMPzKFzZoIFy8R/jHDMJz/PJAmM+Tp0jhZyflDyj8=;
        b=SJQc2ac3mnj7MJIEHVkeREmlkcNbTyqxP/CEumEjlSHmfCoaS05Xa1Y0bPUSI3XdIc
         QtgpS166GAQ/okGOuZg0FQrRzOMWoBFuzMCQ1lQOlot5Y3mqFFmvYcvcCOtUSPjPdOZq
         xX3joZG7MYSZIiOo5/KTKD0AdwSDxQ+6e6pyq7L/2lNQH4pe9OoddkpJZBDA3CWywWih
         bW0tul/kWm4sZuEPYwSl+5ywEdpz+2FUiFIC0NlyTF/dea6hWA1ESuTLeLoe1f6aAd0/
         V1YQG23+TeGHtdEdnDoIeATHeRUDLzHPL53wdnoOCf78N7FHpFnBdmlhznNdD9TAUKmk
         7XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034904; x=1774639704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbiMPzKFzZoIFy8R/jHDMJz/PJAmM+Tp0jhZyflDyj8=;
        b=n48OCjsJTXmE4iieZIQhgSQimj5iMVE8+AUV8ptVc5AnZp8bLKquHWc5HcdNiu8nz3
         koOe0xukV36LQZVTbQK8ymz1ZV9M+Rd+vZKuYtjPn8uZYddds4IAHb08MIjqvJcP3RPc
         svrR8qiFChgbwz4nvs5yn++9hUL/ta7GWB6gmfV77PFq0MnPlwj9kMknB5VdD1uxL84C
         8pDYvASiK4uym0ejawoLYX4zkbjU9JGVaD7Gy5acQl5/Ziik31NwD+4xHDK53phbHPij
         ZnLR/yLG998XRj9RmTl9JVDTi7yymfE4qbPRRtTniG8aUJb+0CJ3WP0LIMrPn8WgsuaL
         YKYg==
X-Forwarded-Encrypted: i=1; AJvYcCWVOw6WEfnD+Y2wZ7sHYJd3ezKAxP2CpPK4WHeVT1bPjRPfkGI3gb7NNAk1OHqKnMYKx9AvQvBRDySozB9LBKo3@vger.kernel.org
X-Gm-Message-State: AOJu0YzgSWRyx0lOtJMUoXAxFPRCA0M//c575Bun85DEnZV0jpQa0iqs
	H23sNH3y48U9a9TOqhr7I4b9DkFjZyXISIJaEB9JNsIg52eJRHvkPAbCCIe9i+5CTUBRL3Atzck
	OyVtqP097JA==
X-Received: from dybmx13.prod.google.com ([2002:a05:7300:d40d:b0:2be:77bc:5c34])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4083:b0:2bd:cfce:4c4b
 with SMTP id 5a478bee46e88-2c1095a4e80mr2036396eec.2.1774034904321; Fri, 20
 Mar 2026 12:28:24 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:13 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-12-irogers@google.com>
Subject: [PATCH v4 11/25] perf hist: Remove evsel parameter from inc samples functions
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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
index 710604c4f6f6..e863f9ef581f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -198,7 +198,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 static void perf_top__record_precise_ip(struct perf_top *top,
 					struct hist_entry *he,
 					struct perf_sample *sample,
-					struct evsel *evsel, u64 ip)
+					u64 ip)
 	EXCLUSIVE_LOCKS_REQUIRED(he->hists->lock)
 {
 	struct annotation *notes;
@@ -215,7 +215,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 	if (!annotation__trylock(notes))
 		return;
 
-	err = hist_entry__inc_addr_samples(he, sample, evsel, ip);
+	err = hist_entry__inc_addr_samples(he, sample, ip);
 
 	annotation__unlock(notes);
 
@@ -734,7 +734,7 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
 	struct evsel *evsel = iter->evsel;
 
 	if (perf_hpp_list.sym && single)
-		perf_top__record_precise_ip(top, iter->he, iter->sample, evsel, al->addr);
+		perf_top__record_precise_ip(top, iter->he, iter->sample, al->addr);
 
 	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
 			     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY),
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2e3522905046..15ff0443c312 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -211,9 +211,10 @@ static int __symbol__account_cycles(struct cyc_hist *ch,
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
@@ -316,7 +317,7 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 }
 
 static int symbol__inc_addr_samples(struct map_symbol *ms,
-				    struct evsel *evsel, u64 addr,
+				    u64 addr,
 				    struct perf_sample *sample)
 {
 	struct symbol *sym = ms->sym;
@@ -324,8 +325,8 @@ static int symbol__inc_addr_samples(struct map_symbol *ms,
 
 	if (sym == NULL)
 		return 0;
-	src = symbol__hists(sym, evsel->evlist->core.nr_entries);
-	return src ? __symbol__inc_addr_samples(ms, src, evsel, addr, sample) : 0;
+	src = symbol__hists(sym, sample->evsel->evlist->core.nr_entries);
+	return src ? __symbol__inc_addr_samples(ms, src, addr, sample) : 0;
 }
 
 static int symbol__account_br_cntr(struct annotated_branch *branch,
@@ -579,16 +580,14 @@ static int annotation__compute_ipc(struct annotation *notes, size_t size,
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
2.53.0.959.g497ff81fa9-goog

