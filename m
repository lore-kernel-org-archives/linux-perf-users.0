Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17036C7EE30
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 08:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjB1In0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 03:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjB1Im5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:57 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4B92C67A
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:41 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id u20so5188708pfm.7
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKs+rsPj1hm0j71DGE8gonxUEIM8JV3GuGWVFR89M0w=;
        b=ivB6Lv/xQDSKMmtQeR38o5KccivOcwIKQ0Yyj89c63Lcn2O3y8WITjotVTMqyublB9
         RCOYf8yCJC301oV0HocHKLhTzQjUXV9UJ2y6+NdWMFLzvAPqdLqoeKpdKl/P5uftWt/j
         7Hmz5aCbIofdizDrvxB2BsHgH+yxPA7XeWcHQSaV5oMw4Ts+sGTSO1sXrlryXKGPKU/n
         LhOkyC2se+nl2/jbV7YIT3ods2rX5BGcQ+G1bm+1hTZZnqU8MtQ0EdbGQkZ2U8md/FhY
         JC7WEM9IxQrr91jKFjBe4iqU8ooI97vaJbWhwxefHdjGJj3mBirUrQx2PW80+psPTy4M
         LLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKs+rsPj1hm0j71DGE8gonxUEIM8JV3GuGWVFR89M0w=;
        b=hvfR2A2QOo6kKt9VPINwLPXuBxAX//HOUJ29uevbNcPegjBZW5j/nwLPhKXnMTPKv/
         anJyXQu0Answ/aqgLiKw4e32wLq0drPD5x8jbBfYq3lAFZyJRF26VeAcyrwZV9xTseoZ
         z3V/ENTVdHjxmWz/R/NEobuJFC6Vdc6yzOzz85LIYB4IZoFHJAMJRxeG9lronvH+JKz/
         bIE/QbDAfcREj4tHTIKJ6MOP2U2Q3v0VicJbej6szDco9P8k+1XfP8/hf0ef7D3pvFs4
         DShPAqDsGx2B5hcw034RiPc/CTYfYDgdJ+xU+owqerzsK39anbaCnGjcT3ElKvUC6i1z
         lslQ==
X-Gm-Message-State: AO0yUKUV1/9Tk7lp8TabbzfchPbKqKmROL/X8kCLrFpWSKLcg/P0zAtj
        DPhhPIp1j0fJkmud5sShGQN+rQ==
X-Google-Smtp-Source: AK7set8tD3J3ir76yLcdhpbI8anvb/Ayk4GpzfJOiOATJ0V3nm7fAj/tUPl/DcX2QqnfUZw9ARBZ/A==
X-Received: by 2002:a62:8406:0:b0:5f1:468b:c88 with SMTP id k6-20020a628406000000b005f1468b0c88mr2145899pfd.27.1677573760353;
        Tue, 28 Feb 2023 00:42:40 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:39 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 09/14] perf kvm: Use histograms list to replace cached list
Date:   Tue, 28 Feb 2023 16:41:42 +0800
Message-Id: <20230228084147.106167-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228084147.106167-1-leo.yan@linaro.org>
References: <20230228084147.106167-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf kvm tool defines its own cached list which is managed with RB tree,
histograms also provide RB tree to manage data entries.  Since now we
have introduced histograms in the tool, it's not necessary to use the
self defined list and we can directly use histograms list to manage
KVM events.

This patch changes to use histograms list to track KVM events, and it
invokes the common function hists__output_resort_cb() to sort result,
this also give us flexibility to extend more sorting key words easily.

After histograms list supported, the cached list is redundant so remove
the relevant code for it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 186 +++++++++++++++++++------------------
 tools/perf/util/kvm-stat.h |   7 --
 2 files changed, 94 insertions(+), 99 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index da84f5063d4d..32dc697ff707 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -421,44 +421,37 @@ struct vcpu_event_record {
 	struct kvm_event *last_event;
 };
 
-
-static void init_kvm_event_record(struct perf_kvm_stat *kvm)
-{
-	unsigned int i;
-
-	for (i = 0; i < EVENTS_CACHE_SIZE; i++)
-		INIT_LIST_HEAD(&kvm->kvm_events_cache[i]);
-}
-
 #ifdef HAVE_TIMERFD_SUPPORT
-static void clear_events_cache_stats(struct list_head *kvm_events_cache)
+static void clear_events_cache_stats(void)
 {
-	struct list_head *head;
+	struct rb_root_cached *root;
+	struct rb_node *nd;
 	struct kvm_event *event;
-	unsigned int i;
-	int j;
-
-	for (i = 0; i < EVENTS_CACHE_SIZE; i++) {
-		head = &kvm_events_cache[i];
-		list_for_each_entry(event, head, hash_entry) {
-			/* reset stats for event */
-			event->total.time = 0;
-			init_stats(&event->total.stats);
-
-			for (j = 0; j < event->max_vcpu; ++j) {
-				event->vcpu[j].time = 0;
-				init_stats(&event->vcpu[j].stats);
-			}
+	int i;
+
+	if (hists__has(&kvm_hists.hists, need_collapse))
+		root = &kvm_hists.hists.entries_collapsed;
+	else
+		root = kvm_hists.hists.entries_in;
+
+	for (nd = rb_first_cached(root); nd; nd = rb_next(nd)) {
+		struct hist_entry *he;
+
+		he = rb_entry(nd, struct hist_entry, rb_node_in);
+		event = container_of(he, struct kvm_event, he);
+
+		/* reset stats for event */
+		event->total.time = 0;
+		init_stats(&event->total.stats);
+
+		for (i = 0; i < event->max_vcpu; ++i) {
+			event->vcpu[i].time = 0;
+			init_stats(&event->vcpu[i].stats);
 		}
 	}
 }
 #endif
 
-static int kvm_events_hash_fn(u64 key)
-{
-	return key & (EVENTS_CACHE_SIZE - 1);
-}
-
 static bool kvm_event_expand(struct kvm_event *event, int vcpu_id)
 {
 	int old_max_vcpu = event->max_vcpu;
@@ -484,21 +477,51 @@ static bool kvm_event_expand(struct kvm_event *event, int vcpu_id)
 	return true;
 }
 
+static void *kvm_he_zalloc(size_t size)
+{
+	struct kvm_event *kvm_ev;
+
+	kvm_ev = zalloc(size + sizeof(*kvm_ev));
+	if (!kvm_ev)
+		return NULL;
+
+	return &kvm_ev->he;
+}
+
+static void kvm_he_free(void *he)
+{
+	struct kvm_event *kvm_ev;
+
+	kvm_ev = container_of(he, struct kvm_event, he);
+	free(kvm_ev);
+}
+
+static struct hist_entry_ops kvm_ev_entry_ops = {
+	.new	= kvm_he_zalloc,
+	.free	= kvm_he_free,
+};
+
 static struct kvm_event *kvm_alloc_init_event(struct perf_kvm_stat *kvm,
 					      struct event_key *key,
-					      struct perf_sample *sample __maybe_unused)
+					      struct perf_sample *sample)
 {
 	struct kvm_event *event;
+	struct hist_entry *he;
 
-	event = zalloc(sizeof(*event));
-	if (!event) {
-		pr_err("Not enough memory\n");
+	he = hists__add_entry_ops(&kvm_hists.hists, &kvm_ev_entry_ops,
+				  &kvm->al, NULL, NULL, NULL, sample, true);
+	if (he == NULL) {
+		pr_err("Failed to allocate hist entry\n");
 		return NULL;
 	}
 
+	hists__inc_nr_samples(&kvm_hists.hists, 0);
+
+	event = container_of(he, struct kvm_event, he);
 	event->perf_kvm = kvm;
 	event->key = *key;
 	init_stats(&event->total.stats);
+
 	return event;
 }
 
@@ -507,22 +530,26 @@ static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
 					       struct perf_sample *sample)
 {
 	struct kvm_event *event;
-	struct list_head *head;
+	struct rb_root_cached *root;
+	struct rb_node *nd;
 
 	BUG_ON(key->key == INVALID_KEY);
 
-	head = &kvm->kvm_events_cache[kvm_events_hash_fn(key->key)];
-	list_for_each_entry(event, head, hash_entry) {
+	if (hists__has(&kvm_hists.hists, need_collapse))
+		root = &kvm_hists.hists.entries_collapsed;
+	else
+		root = kvm_hists.hists.entries_in;
+
+	for (nd = rb_first_cached(root); nd; nd = rb_next(nd)) {
+		struct hist_entry *he = rb_entry(nd, struct hist_entry,
+						 rb_node_in);
+
+		event = container_of(he, struct kvm_event, he);
 		if (event->key.key == key->key && event->key.info == key->info)
 			return event;
 	}
 
-	event = kvm_alloc_init_event(kvm, key, sample);
-	if (!event)
-		return NULL;
-
-	list_add(&event->hash_entry, head);
-	return event;
+	return kvm_alloc_init_event(kvm, key, sample);
 }
 
 static bool handle_begin_event(struct perf_kvm_stat *kvm,
@@ -754,58 +781,29 @@ static bool select_key(struct perf_kvm_stat *kvm)
 	return false;
 }
 
-static void insert_to_result(struct rb_root *result, struct kvm_event *event,
-			     key_cmp_fun bigger, int vcpu)
-{
-	struct rb_node **rb = &result->rb_node;
-	struct rb_node *parent = NULL;
-	struct kvm_event *p;
-
-	while (*rb) {
-		p = container_of(*rb, struct kvm_event, rb);
-		parent = *rb;
-
-		if (bigger(event, p, vcpu) > 0)
-			rb = &(*rb)->rb_left;
-		else
-			rb = &(*rb)->rb_right;
-	}
-
-	rb_link_node(&event->rb, parent, rb);
-	rb_insert_color(&event->rb, result);
-}
-
 static bool event_is_valid(struct kvm_event *event, int vcpu)
 {
 	return !!get_event_count(event, vcpu);
 }
 
-static void sort_result(struct perf_kvm_stat *kvm)
+static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
-	unsigned int i;
-	int vcpu = kvm->trace_vcpu;
 	struct kvm_event *event;
+	struct perf_kvm_stat *perf_kvm;
 
-	for (i = 0; i < EVENTS_CACHE_SIZE; i++) {
-		list_for_each_entry(event, &kvm->kvm_events_cache[i], hash_entry) {
-			if (event_is_valid(event, vcpu)) {
-				insert_to_result(&kvm->result, event,
-						 kvm->compare, vcpu);
-			}
-		}
-	}
+	event = container_of(he, struct kvm_event, he);
+	perf_kvm = event->perf_kvm;
+	if (!event_is_valid(event, perf_kvm->trace_vcpu))
+		he->filtered = 1;
+	else
+		he->filtered = 0;
+	return 0;
 }
 
-/* returns left most element of result, and erase it */
-static struct kvm_event *pop_from_result(struct rb_root *result)
+static void sort_result(void)
 {
-	struct rb_node *node = rb_first(result);
-
-	if (!node)
-		return NULL;
-
-	rb_erase(node, result);
-	return container_of(node, struct kvm_event, rb);
+	hists__collapse_resort(&kvm_hists.hists, NULL);
+	hists__output_resort_cb(&kvm_hists.hists, NULL, filter_cb);
 }
 
 static void print_vcpu_info(struct perf_kvm_stat *kvm)
@@ -848,6 +846,7 @@ static void print_result(struct perf_kvm_stat *kvm)
 	char decode[decode_str_len];
 	struct kvm_event *event;
 	int vcpu = kvm->trace_vcpu;
+	struct rb_node *nd;
 
 	if (kvm->live) {
 		puts(CONSOLE_CLEAR);
@@ -866,9 +865,15 @@ static void print_result(struct perf_kvm_stat *kvm)
 	pr_info("%16s ", "Avg time");
 	pr_info("\n\n");
 
-	while ((event = pop_from_result(&kvm->result))) {
+	for (nd = rb_first_cached(&kvm_hists.hists.entries); nd; nd = rb_next(nd)) {
+		struct hist_entry *he;
 		u64 ecount, etime, max, min;
 
+		he = rb_entry(nd, struct hist_entry, rb_node);
+		if (he->filtered)
+			continue;
+
+		event = container_of(he, struct kvm_event, he);
 		ecount = get_event_count(event, vcpu);
 		etime = get_event_time(event, vcpu);
 		max = get_event_max(event, vcpu);
@@ -1142,11 +1147,11 @@ static int perf_kvm__handle_timerfd(struct perf_kvm_stat *kvm)
 		pr_debug("Missed timer beats: %" PRIu64 "\n", c-1);
 
 	/* update display */
-	sort_result(kvm);
+	sort_result();
 	print_result(kvm);
 
 	/* reset counts */
-	clear_events_cache_stats(kvm->kvm_events_cache);
+	clear_events_cache_stats();
 	kvm->total_count = 0;
 	kvm->total_time = 0;
 	kvm->lost_events = 0;
@@ -1202,8 +1207,6 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 	}
 
 	set_term_quiet_input(&save);
-	init_kvm_event_record(kvm);
-
 	kvm_hists__init(kvm);
 
 	signal(SIGINT, sig_handler);
@@ -1250,7 +1253,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 	evlist__disable(kvm->evlist);
 
 	if (err == 0) {
-		sort_result(kvm);
+		sort_result();
 		print_result(kvm);
 	}
 
@@ -1398,7 +1401,6 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	if (!register_kvm_events_ops(kvm))
 		goto exit;
 
-	init_kvm_event_record(kvm);
 	setup_pager();
 
 	kvm_hists__init(kvm);
@@ -1407,7 +1409,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	if (ret)
 		goto exit;
 
-	sort_result(kvm);
+	sort_result();
 	print_result(kvm);
 
 exit:
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index ca5796959f66..c38d320c7cbe 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -30,7 +30,6 @@ struct perf_kvm_stat;
 
 struct kvm_event {
 	struct list_head hash_entry;
-	struct rb_node rb;
 
 	struct perf_kvm_stat *perf_kvm;
 	struct event_key key;
@@ -75,9 +74,6 @@ struct exit_reasons_table {
 	const char *reason;
 };
 
-#define EVENTS_BITS		12
-#define EVENTS_CACHE_SIZE	(1UL << EVENTS_BITS)
-
 struct perf_kvm_stat {
 	struct perf_tool    tool;
 	struct record_opts  opts;
@@ -97,7 +93,6 @@ struct perf_kvm_stat {
 
 	struct kvm_events_ops *events_ops;
 	key_cmp_fun compare;
-	struct list_head kvm_events_cache[EVENTS_CACHE_SIZE];
 
 	u64 total_time;
 	u64 total_count;
@@ -106,8 +101,6 @@ struct perf_kvm_stat {
 
 	struct intlist *pid_list;
 
-	struct rb_root result;
-
 	int timerfd;
 	unsigned int display_time;
 	bool live;
-- 
2.34.1

