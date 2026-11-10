Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348510;
	b=lsGanUtvx/6Z0O4MUmhcIQMbXJE4OoBYk95sVpxkhXgzkUmYsqgzEBcJvtWaU/24CjIS
	 DNMcVH2tl8ZC8QpV8Orwka/jQKbPFENdxBk5hUSn8+fThcOy3KSLo3bei/iI0s6rGk5lm
	 alFiEVuH9AlQbKlOvIsqcOEQNYNKLzzVUsYJiqEHXoL3b4i3kA2T733q7wM6rarjPcB6j
	 THA0EzlcvUI1uZHMFZCqwBECEmcJsbVlfNGN+d7ViU/mR56HyELvX9aiBZWHcydvNhYyM
	 JPZF3Dy17pC6POyC4oZyf/YsltUIJknaAFqx5yheSZ17kU5yoSaFn3EUruvuKCVoA8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=o8NfY6QXepnRzVcxSI2K+IgQFzT16Nb/aT0AwSC9ihM=;
	b=Bele611fdtfBP00Y1KDYMKG+Hll+VVLjEpxvg5z4Ro58YStCb4yhzy/o0ee6xwPrd2OE
	 dyt61yGIdhMx3OzfB38sTbPlQANvHvrOJkZQVhHzpe9NhpGVz8V+WUUTMIsVU/tdfFwM0
	 2MDAb37AcDHOuzMfVnx4oJrA8SA29MIm53dlpdf+fFD5uNwdHcRarwEGQWg+E3jZYyqpJ
	 9fgidnmxmmIHfO6zYGaGltfiAo+fFwRU6hdI6R1rquTKLtQKOLb8K+o69eb+Kwl7ddr8c
	 MbQ9KvR4kEAKBK+2kuxsMqRyB7EwISZK4pW/HkxWYYxylNKpA4MB8UGOzwpN1lnMFxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZJhMKIaY;
	arc=none smtp.remote-ip=209.85.160.72
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6E260A6F54
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B6E260A6F54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZJhMKIaY
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-47d75bcf3ebso2423472fac.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794348509; x=1794953309; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o8NfY6QXepnRzVcxSI2K+IgQFzT16Nb/aT0AwSC9ihM=;
        b=ZJhMKIaY52Axxi+Y5d1NgXFg/bfxqocZbTFbmlpc2q2W1jJlb1hr1oW21EsXpa+w/5
         0wGfd9lnkrznjxfDHdcvsYIWMooLIu+/9lBpSlrkMrotWdzCRwsLKlC6jpbeU1Cj4/DY
         m3K7qkueUbn9H2CEKZ6o1nQK0RH6gVkOBsM+cJ048rj/zoEfIglwkDOsMpqdAgitJvvS
         w1C6wzAIiphIvaEd5w+6sqH2h6o8x5epwr5siA6BLLOjVQLquffngyTwSmTS1tMQUMcw
         nN4tszawnFuMUgmQK4y/wfJSFIaZIsLv7YfG1jxLCe4pp10hZKd/k/2MS/MlIJw7+yeN
         8n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348509; x=1794953309;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o8NfY6QXepnRzVcxSI2K+IgQFzT16Nb/aT0AwSC9ihM=;
        b=cJngCS168m11SK/CibuSs+4BcWY/zvb6EVPC/kbKNPjkd0YA7s/zgffQFd46ru6oPn
         s20sEjL8LgZl2KHiLU0gyYJ31L89ORBO1wqXJVbD6z6aCIzHrO6vXqzFgPN8XXRZp185
         9DH7oEXa76y0iPEV38MYjYOW1CV96dqB1CfOh/xhxbenFa1Ri7HwW3cM1763e4Qry2c9
         1jPi1xklA+SYM48QAujgQ5Cnd1cmv7k2tLsn0Gr9vK7dGAsy7tVarr02DtQc6Kj/f0+N
         dldfgjuPNCGOhIIaldfo6Tr9EP7UH1KA2FUImjHS08ENSft1WOWH7m+5zUL8XDPHg6ZF
         r6rg==
X-Forwarded-Encrypted: i=1; AL+hErGE8g7Xe8BDSlDwwcsy+5It5aSz1yX8blDg0XlRqsKLm5/LaAKzL+VhUT32GmKtooNMV8ckgsDswkk9e5jom0Nh@vger.kernel.org
X-Gm-Message-State: APuU4Z+Zxojg762mJBmMofEPNL+DC00iuiyiRwWCZNhXp2pEJgLVBTjK
	fSDQpmQQsxU2Qn53p5stCdCZqK5aTAVZ3apXVERBMDsoqgQr/gq0VmEBhHwChel00CVknZ8sYW+
	Gecc/a9L8JQ==
X-Received: from oacpx27-n1.prod.google.com ([2002:a05:6871:291b:10b0:46a:e400:19f4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:b28:b0:4a2:809d:8fcd
 with SMTP id 586e51a60fabf-4ae46b1b394mr593712fac.35.1794348508915; Tue, 10
 Nov 2026 14:08:28 -0800 (PST)
Date: Tue, 10 Nov 2026 14:07:48 -0800
In-Reply-To: <20261110220803.2503416-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027231513.816148-1-irogers@google.com> <20261110220803.2503416-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110220803.2503416-6-irogers@google.com>
Subject: [PATCH v3 05/20] perf map_symbol: Add struct dso_symbol and use for
 parent symbols
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

A struct symbol's lifetime is owned by the struct dso containing its
symbol table rather than by an individual struct map. When retaining a
symbol pointer beyond the scope of a temporary addr_location or map
reference without holding the map itself, the owning struct dso must be
refcounted alongside the symbol pointer.

Introduce struct dso_symbol pairing a refcounted struct dso * with a
struct symbol *, along with dso_symbol__copy(), dso_symbol__exit(), and
dso_symbol__from_al() lifecycle helpers in map_symbol.[ch].

Convert parent symbol tracking across callchain resolution,
hist_entry_iter, and hist_entry from bare struct symbol * pointers to
struct dso_symbol so that parent symbols pin their owning DSOs until the
iterator or histogram entry is destroyed. Also drop the unused
perf_session__resolve_callchain() prototype from session.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/stdio/hist.c   |  4 ++--
 tools/perf/util/callchain.c  |  3 ++-
 tools/perf/util/callchain.h  |  3 ++-
 tools/perf/util/hist.c       | 31 +++++++++++++++++++------------
 tools/perf/util/hist.h       |  8 ++++----
 tools/perf/util/machine.c    | 36 +++++++++++++++++++++++-------------
 tools/perf/util/machine.h    |  5 +++--
 tools/perf/util/map_symbol.c | 30 ++++++++++++++++++++++++++++++
 tools/perf/util/map_symbol.h | 11 +++++++++++
 tools/perf/util/session.h    |  6 ------
 tools/perf/util/sort.c       |  6 +++---
 11 files changed, 99 insertions(+), 44 deletions(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 8c4c8925df2c..3240c39bd025 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -424,7 +424,7 @@ int __hist_entry__snprintf(struct hist_entry *he, struct perf_hpp *hpp,
 	int ret;
 	bool first = true;
 
-	if (symbol_conf.exclude_other && !he->parent)
+	if (symbol_conf.exclude_other && !he->parent.sym)
 		return 0;
 
 	perf_hpp_list__for_each_format(hpp_list, fmt) {
@@ -471,7 +471,7 @@ static int hist_entry__hierarchy_fprintf(struct hist_entry *he,
 	int ret, printed = 0;
 	bool first = true;
 
-	if (symbol_conf.exclude_other && !he->parent)
+	if (symbol_conf.exclude_other && !he->parent.sym)
 		return 0;
 
 	ret = scnprintf(hpp->buf, hpp->size, "%*s", he->depth * HIERARCHY_INDENT, "");
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 6d5212be466d..4e4696cfa6d4 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1170,7 +1170,8 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 }
 
 int sample__resolve_callchain(struct perf_sample *sample,
-			      struct callchain_cursor *cursor, struct symbol **parent,
+			      struct callchain_cursor *cursor,
+			      struct dso_symbol *parent,
 			      struct addr_location *al,
 			      int max_stack)
 {
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 8b1e405d1cdf..23f59b389799 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -242,7 +242,8 @@ int record_opts__parse_callchain(struct record_opts *record,
 				 const char *arg, bool unset);
 
 int sample__resolve_callchain(struct perf_sample *sample,
-			      struct callchain_cursor *cursor, struct symbol **parent,
+			      struct callchain_cursor *cursor,
+			      struct dso_symbol *parent,
 			      struct addr_location *al,
 			      int max_stack);
 int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *sample);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 364754e9d12a..d516ce469c7e 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -119,8 +119,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		hists__new_col_len(hists, HISTC_DSO, len);
 	}
 
-	if (h->parent)
-		hists__new_col_len(hists, HISTC_PARENT, h->parent->namelen);
+	if (h->parent.sym)
+		hists__new_col_len(hists, HISTC_PARENT, h->parent.sym->namelen);
 
 	if (h->branch_info) {
 		if (h->branch_info->from.ms.sym) {
@@ -543,6 +543,7 @@ static int hist_entry__init(struct hist_entry *he,
 
 	he->ms.thread = thread__get(he->ms.thread);
 	he->ms.map = map__get(he->ms.map);
+	dso_symbol__copy(&he->parent, &template->parent);
 
 	if (he->branch_info) {
 		/*
@@ -616,6 +617,7 @@ static int hist_entry__init(struct hist_entry *he,
 	if (he->mem_info)
 		mem_info__zput(he->mem_info);
 err:
+	dso_symbol__exit(&he->parent);
 	map_symbol__exit(&he->ms);
 	zfree(&he->stat_acc);
 	return -ENOMEM;
@@ -796,7 +798,7 @@ static void hists__res_sample(struct hist_entry *he, struct perf_sample *sample)
 static struct hist_entry*
 __hists__add_entry(struct hists *hists,
 		   struct addr_location *al,
-		   struct symbol *sym_parent,
+		   const struct dso_symbol *sym_parent,
 		   struct branch_info *bi,
 		   struct mem_info *mi,
 		   struct kvm_info *ki,
@@ -835,8 +837,9 @@ __hists__add_entry(struct hists *hists,
 			.weight3 = sample->weight3,
 			.latency = al->latency,
 		},
-		.parent = sym_parent,
-		.filtered = symbol__parent_filter(sym_parent) | al->filtered,
+		.parent = sym_parent ? *sym_parent : (struct dso_symbol){},
+		.filtered = symbol__parent_filter(sym_parent ? sym_parent->sym : NULL) |
+			    al->filtered,
 		.hists	= hists,
 		.branch_info = bi,
 		.mem_info = mi,
@@ -862,7 +865,7 @@ __hists__add_entry(struct hists *hists,
 
 struct hist_entry *hists__add_entry(struct hists *hists,
 				    struct addr_location *al,
-				    struct symbol *sym_parent,
+				    const struct dso_symbol *sym_parent,
 				    struct branch_info *bi,
 				    struct mem_info *mi,
 				    struct kvm_info *ki,
@@ -876,7 +879,7 @@ struct hist_entry *hists__add_entry(struct hists *hists,
 struct hist_entry *hists__add_entry_ops(struct hists *hists,
 					struct hist_entry_ops *ops,
 					struct addr_location *al,
-					struct symbol *sym_parent,
+					const struct dso_symbol *sym_parent,
 					struct branch_info *bi,
 					struct mem_info *mi,
 					struct kvm_info *ki,
@@ -957,7 +960,7 @@ iter_add_single_mem_entry(struct hist_entry_iter *iter, struct addr_location *al
 	 */
 	sample->period = cost;
 
-	he = hists__add_entry(hists, al, iter->parent, NULL, mi, NULL,
+	he = hists__add_entry(hists, al, &iter->parent, NULL, mi, NULL,
 			      sample, true);
 	if (!he)
 		return -ENOMEM;
@@ -1057,7 +1060,7 @@ iter_add_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *a
 	sample->period = 1;
 	sample->weight = bi[i].flags.cycles ? bi[i].flags.cycles : 1;
 
-	he = hists__add_entry(hists, al, iter->parent, &bi[i], NULL, NULL,
+	he = hists__add_entry(hists, al, &iter->parent, &bi[i], NULL, NULL,
 			      sample, true);
 	if (he == NULL)
 		return -ENOMEM;
@@ -1109,7 +1112,7 @@ iter_add_single_normal_entry(struct hist_entry_iter *iter, struct addr_location
 	struct evsel *evsel = sample->evsel;
 	struct hist_entry *he;
 
-	he = hists__add_entry(evsel__hists(evsel), al, iter->parent, NULL, NULL,
+	he = hists__add_entry(evsel__hists(evsel), al, &iter->parent, NULL, NULL,
 			      NULL, sample, true);
 	if (he == NULL)
 		return -ENOMEM;
@@ -1174,7 +1177,7 @@ iter_add_single_cumulative_entry(struct hist_entry_iter *iter,
 	struct hist_entry *he;
 	int err = 0;
 
-	he = hists__add_entry(hists, al, iter->parent, NULL, NULL, NULL,
+	he = hists__add_entry(hists, al, &iter->parent, NULL, NULL, NULL,
 			      sample, true);
 	if (he == NULL)
 		return -ENOMEM;
@@ -1277,7 +1280,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 		}
 	}
 
-	he = hists__add_entry(evsel__hists(evsel), al, iter->parent, NULL, NULL,
+	he = hists__add_entry(evsel__hists(evsel), al, &iter->parent, NULL, NULL,
 			      NULL, sample, false);
 	if (he == NULL)
 		return -ENOMEM;
@@ -1340,12 +1343,14 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	int err, err2;
 	struct map *alm = NULL;
 
+	dso_symbol__exit(&iter->parent);
 	if (al)
 		alm = map__get(al->map);
 
 	err = sample__resolve_callchain(iter->sample, get_tls_callchain_cursor(), &iter->parent,
 					al, max_stack_depth);
 	if (err) {
+		dso_symbol__exit(&iter->parent);
 		map__put(alm);
 		return err;
 	}
@@ -1381,6 +1386,7 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	if (!err)
 		err = err2;
 
+	dso_symbol__exit(&iter->parent);
 	map__put(alm);
 
 	return err;
@@ -1468,6 +1474,7 @@ void hist_entry__delete(struct hist_entry *he)
 
 	thread__zput(he->thread);
 	map_symbol__exit(&he->ms);
+	dso_symbol__exit(&he->parent);
 
 	if (he->branch_info) {
 		branch_info__exit(he->branch_info);
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 0d08011aebce..4553365b3d8c 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -159,7 +159,7 @@ struct hist_entry_iter {
 
 	struct perf_sample *sample;
 	struct hist_entry *he;
-	struct symbol *parent;
+	struct dso_symbol parent;
 
 	struct mem_info *mi;
 	struct branch_info *bi;
@@ -292,7 +292,7 @@ struct hist_entry {
 	};
 	char			*srcline;
 	char			*srcfile;
-	struct symbol		*parent;
+	struct dso_symbol	parent;
 	struct branch_info	*branch_info;
 	long			time;
 	struct hists		*hists;
@@ -350,7 +350,7 @@ static inline void hist_entry__add_pair(struct hist_entry *pair,
 
 struct hist_entry *hists__add_entry(struct hists *hists,
 				    struct addr_location *al,
-				    struct symbol *parent,
+				    const struct dso_symbol *parent,
 				    struct branch_info *bi,
 				    struct mem_info *mi,
 				    struct kvm_info *ki,
@@ -360,7 +360,7 @@ struct hist_entry *hists__add_entry(struct hists *hists,
 struct hist_entry *hists__add_entry_ops(struct hists *hists,
 					struct hist_entry_ops *ops,
 					struct addr_location *al,
-					struct symbol *sym_parent,
+					const struct dso_symbol *sym_parent,
 					struct branch_info *bi,
 					struct mem_info *mi,
 					struct kvm_info *ki,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f6975d9c4568..905d275ca364 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2235,7 +2235,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 
 static int add_callchain_ip(struct thread *thread,
 			    struct callchain_cursor *cursor,
-			    struct symbol **parent,
+			    struct dso_symbol *parent,
 			    struct addr_location *root_al,
 			    u8 *cpumode,
 			    u64 ip,
@@ -2278,6 +2278,8 @@ static int add_callchain_ip(struct thread *thread,
 				 * Discard all.
 				 */
 				callchain_cursor_reset(cursor);
+				if (parent)
+					dso_symbol__exit(parent);
 				err = 1;
 				goto out;
 			}
@@ -2290,10 +2292,12 @@ static int add_callchain_ip(struct thread *thread,
 	}
 
 	if (al.sym != NULL) {
-		if (perf_hpp_list.parent && !*parent &&
-		    symbol__match_regex(al.sym, &parent_regex))
-			*parent = al.sym;
-		else if (have_ignore_callees && root_al &&
+		if (perf_hpp_list.parent && parent && !parent->sym &&
+		    symbol__match_regex(al.sym, &parent_regex)) {
+			struct dso_symbol ds = dso_symbol__from_al(&al);
+
+			dso_symbol__copy(parent, &ds);
+		} else if (have_ignore_callees && root_al &&
 		  symbol__match_regex(al.sym, &ignore_callees_regex)) {
 			/* Treat this symbol as the root,
 			   forgetting its callees. */
@@ -2417,7 +2421,7 @@ static int remove_loops(struct branch_entry *l, int nr,
 static int lbr_callchain_add_kernel_ip(struct thread *thread,
 				       struct callchain_cursor *cursor,
 				       struct perf_sample *sample,
-				       struct symbol **parent,
+				       struct dso_symbol *parent,
 				       struct addr_location *root_al,
 				       u64 branch_from,
 				       bool callee, int end,
@@ -2483,7 +2487,7 @@ static void save_lbr_cursor_node(struct thread *thread,
 static int lbr_callchain_add_lbr_ip(struct thread *thread,
 				    struct callchain_cursor *cursor,
 				    struct perf_sample *sample,
-				    struct symbol **parent,
+				    struct dso_symbol *parent,
 				    struct addr_location *root_al,
 				    u64 *branch_from,
 				    bool callee,
@@ -2751,7 +2755,7 @@ static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
 static int resolve_lbr_callchain_sample(struct thread *thread,
 					struct callchain_cursor *cursor,
 					struct perf_sample *sample,
-					struct symbol **parent,
+					struct dso_symbol *parent,
 					struct addr_location *root_al,
 					int max_stack,
 					unsigned int max_lbr,
@@ -2838,7 +2842,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 
 static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 			     struct callchain_cursor *cursor,
-			     struct symbol **parent,
+			     struct dso_symbol *parent,
 			     struct addr_location *root_al,
 			     u8 *cpumode, int ent, bool symbols)
 {
@@ -2869,7 +2873,7 @@ static u64 get_leaf_frame_caller(struct perf_sample *sample,
 static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct callchain_cursor *cursor,
 					    struct perf_sample *sample,
-					    struct symbol **parent,
+					    struct dso_symbol *parent,
 					    struct addr_location *root_al,
 					    int max_stack,
 					    bool symbols)
@@ -3101,13 +3105,16 @@ static int thread__resolve_callchain_unwind(struct thread *thread,
 int __thread__resolve_callchain(struct thread *thread,
 				struct callchain_cursor *cursor,
 				struct perf_sample *sample,
-				struct symbol **parent,
+				struct dso_symbol *parent,
 				struct addr_location *root_al,
 				int max_stack,
 				bool symbols)
 {
 	int ret = 0;
 
+	if (parent)
+		dso_symbol__exit(parent);
+
 	if (cursor == NULL)
 		return -ENOMEM;
 
@@ -3119,7 +3126,7 @@ int __thread__resolve_callchain(struct thread *thread,
 						       parent, root_al,
 						       max_stack, symbols);
 		if (ret)
-			return ret;
+			goto out;
 		ret = thread__resolve_callchain_unwind(thread, cursor,
 						       sample,
 						       max_stack, symbols);
@@ -3128,13 +3135,16 @@ int __thread__resolve_callchain(struct thread *thread,
 						       sample,
 						       max_stack, symbols);
 		if (ret)
-			return ret;
+			goto out;
 		ret = thread__resolve_callchain_sample(thread, cursor,
 						       sample,
 						       parent, root_al,
 						       max_stack, symbols);
 	}
 
+out:
+	if (ret && parent)
+		dso_symbol__exit(parent);
 	return ret;
 }
 
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 147ce343e370..80191545ee8a 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -193,11 +193,12 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 				     struct addr_location *al);
 
 struct callchain_cursor;
+struct dso_symbol;
 
 int __thread__resolve_callchain(struct thread *thread,
 				struct callchain_cursor *cursor,
 				struct perf_sample *sample,
-				struct symbol **parent,
+				struct dso_symbol *parent,
 				struct addr_location *root_al,
 				int max_stack,
 				bool symbols);
@@ -205,7 +206,7 @@ int __thread__resolve_callchain(struct thread *thread,
 static inline int thread__resolve_callchain(struct thread *thread,
 					    struct callchain_cursor *cursor,
 					    struct perf_sample *sample,
-					    struct symbol **parent,
+					    struct dso_symbol *parent,
 					    struct addr_location *root_al,
 					    int max_stack)
 {
diff --git a/tools/perf/util/map_symbol.c b/tools/perf/util/map_symbol.c
index 11bc0a7f704c..595ec8f0541d 100644
--- a/tools/perf/util/map_symbol.c
+++ b/tools/perf/util/map_symbol.c
@@ -1,9 +1,39 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "map_symbol.h"
+#include "addr_location.h"
+#include "dso.h"
 #include "maps.h"
 #include "map.h"
 #include "thread.h"
 
+void dso_symbol__exit(struct dso_symbol *ds)
+{
+	dso__zput(ds->dso);
+	ds->sym = NULL;
+}
+
+/*
+ * Initialize @dst from @src, acquiring a reference on @src->dso (without
+ * releasing any prior @dst->dso, matching map_symbol__copy()).
+ */
+void dso_symbol__copy(struct dso_symbol *dst, const struct dso_symbol *src)
+{
+	dst->dso = src ? dso__get(src->dso) : NULL;
+	dst->sym = src ? src->sym : NULL;
+}
+
+/*
+ * Construct a borrowed (non-owning) dso_symbol view from @al while @al is
+ * live. Callers that persist the pair must retain it via dso_symbol__copy().
+ */
+struct dso_symbol dso_symbol__from_al(const struct addr_location *al)
+{
+	return (struct dso_symbol){
+		.dso = (al && al->sym && al->map) ? map__dso(al->map) : NULL,
+		.sym = al ? al->sym : NULL,
+	};
+}
+
 void map_symbol__exit(struct map_symbol *ms)
 {
 	thread__zput(ms->thread);
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
index 7437e319f4a3..1781af7bd965 100644
--- a/tools/perf/util/map_symbol.h
+++ b/tools/perf/util/map_symbol.h
@@ -4,11 +4,18 @@
 
 #include <linux/types.h>
 
+struct addr_location;
+struct dso;
 struct thread;
 struct maps;
 struct map;
 struct symbol;
 
+struct dso_symbol {
+	struct dso    *dso;
+	struct symbol *sym;
+};
+
 struct map_symbol {
 	struct thread *thread;
 	struct map    *map;
@@ -24,6 +31,10 @@ struct addr_map_symbol {
 	u64	      data_page_size;
 };
 
+void dso_symbol__exit(struct dso_symbol *ds);
+void dso_symbol__copy(struct dso_symbol *dst, const struct dso_symbol *src);
+struct dso_symbol dso_symbol__from_al(const struct addr_location *al);
+
 void map_symbol__exit(struct map_symbol *ms);
 void addr_map_symbol__exit(struct addr_map_symbol *ams);
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index ac5803d5fb4e..05ea2c1ee8c9 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -139,12 +139,6 @@ int perf_session__process_events(struct perf_session *session);
 int perf_session__queue_event(struct perf_session *s, union perf_event *event,
 			      u64 timestamp, u64 file_offset, const char *file_path);
 
-int perf_session__resolve_callchain(struct perf_session *session,
-				    struct evsel *evsel,
-				    struct thread *thread,
-				    struct ip_callchain *chain,
-				    struct symbol **parent);
-
 bool perf_session__has_traces(struct perf_session *session, const char *msg);
 bool perf_session__has_switch_events(struct perf_session *session);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 58638ec9ae0e..f4c50f191141 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1010,8 +1010,8 @@ static struct sort_entry sort_srcfile = {
 static int64_t
 sort__parent_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	struct symbol *sym_l = left->parent;
-	struct symbol *sym_r = right->parent;
+	struct symbol *sym_l = left->parent.sym;
+	struct symbol *sym_r = right->parent.sym;
 
 	if (!sym_l || !sym_r)
 		return cmp_null(sym_l, sym_r);
@@ -1023,7 +1023,7 @@ static int hist_entry__parent_snprintf(struct hist_entry *he, char *bf,
 				       size_t size, unsigned int width)
 {
 	return repsep_snprintf(bf, size, "%-*.*s", width, width,
-			      he->parent ? he->parent->name : "[other]");
+			      he->parent.sym ? he->parent.sym->name : "[other]");
 }
 
 struct sort_entry sort_parent = {
-- 
2.56.0.542.g3ef89b7020-goog

