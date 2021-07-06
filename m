Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5494C07E96
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 15:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84D061C25
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 15:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhGFPUE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232679AbhGFPUD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 11:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625584644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RX0HfGi27NdDKlJRAO1WQsPCZSI/gUpFkevk2UN48bA=;
        b=dYvvyaxCkFFEkEXE8ntIeCUm13UJcc67Y5ArZSmOF9Bv89b9SW7w5uqqaIlf8c55T87sGM
        ZicIdxEX3m2aTsrUZfQMAI/gBWzCeJmpW7ZOKMrslr7miycJuxmZlp4RYhgea+pPmCAQbl
        hcAJtW4zCLjZ6bioo9JzGuNOYZZI38c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-iGqEY8EoPVmv674tMgKQCw-1; Tue, 06 Jul 2021 11:17:23 -0400
X-MC-Unique: iGqEY8EoPVmv674tMgKQCw-1
Received: by mail-wr1-f72.google.com with SMTP id y5-20020adfe6c50000b02901258bf1d760so7277523wrm.14
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jul 2021 08:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RX0HfGi27NdDKlJRAO1WQsPCZSI/gUpFkevk2UN48bA=;
        b=Ec/Q/L/4M6/0L5P5sB1SZq09Z/VGJgawM+TifdqiCU2jfLkwb34EIPVZhhgHXPx/DM
         Vd+KMTDhrdWiSBUy3TEDYQPjssnSAZGr1VaA3pFgn2ooqKNmSmJoADDGTjzxd1YjIzFm
         Nk6hHuL/q2ARWsg84lqM4EMaHLQNdEFTEb6+AoTQNn6qtIglvwwX13WILSP0wwkfxBf2
         ljfeuikSpEOAt48lGmP/wvau/3SVs9pOINM+r3LuCwMa88dQk/8FFYD/WjY9Ofv+F9nU
         1Q7M4G0RlZPmo1UgD0lgJaYRkYfh+Q2NMffJZxuwXTkUt2ona7m8KX3EFD/fuhrvEA4m
         UouQ==
X-Gm-Message-State: AOAM531TcXAGRJyppsexDcPaN1uePfqQQH1nodqllk2xBvBPCFYY02TP
        eNB37K02XXdRtbYbjdDuiXzo1gwOk/NrM6UpILHZ0eyxfz03viyLaH6m4g1+3d4e0cjgTipJDIL
        rk39JdktyWRIThV2cAx/H7AQsB6l1nA==
X-Received: by 2002:a05:600c:3b86:: with SMTP id n6mr11569318wms.28.1625584642092;
        Tue, 06 Jul 2021 08:17:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPYWGkYa22RZGDYnX5IWW1OVkU8GKzuEjYuz+bFF0jQY0Vim6BjesG9rID2b11pUDnvv1/qQ==
X-Received: by 2002:a05:600c:3b86:: with SMTP id n6mr11569281wms.28.1625584641834;
        Tue, 06 Jul 2021 08:17:21 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id b15sm20546216wrr.27.2021.07.06.08.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:17:21 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/7] libperf: Move idx to perf_evsel::idx
Date:   Tue,  6 Jul 2021 17:16:59 +0200
Message-Id: <20210706151704.73662-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706151704.73662-1-jolsa@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving evsel::idx to perf_evsel::idx, so we can move
the group interface to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/evlist.c                 |  1 +
 tools/lib/perf/evsel.c                  |  6 ++++--
 tools/lib/perf/include/internal/evsel.h |  4 +++-
 tools/perf/arch/x86/util/iostat.c       |  4 ++--
 tools/perf/builtin-diff.c               |  4 ++--
 tools/perf/builtin-report.c             |  4 ++--
 tools/perf/builtin-top.c                |  8 ++++----
 tools/perf/tests/evsel-roundtrip-name.c |  6 +++---
 tools/perf/tests/mmap-basic.c           |  8 ++++----
 tools/perf/ui/browsers/annotate.c       |  2 +-
 tools/perf/util/annotate.c              |  8 ++++----
 tools/perf/util/evlist.c                | 10 ++++------
 tools/perf/util/evsel.c                 |  3 +--
 tools/perf/util/evsel.h                 |  3 +--
 tools/perf/util/header.c                | 10 +++++-----
 tools/perf/util/metricgroup.c           | 14 +++++++-------
 tools/perf/util/parse-events.c          |  2 +-
 tools/perf/util/python.c                |  2 +-
 tools/perf/util/stream.c                |  2 +-
 19 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index a0aaf385cbb5..68b90bbf0ffb 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -66,6 +66,7 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 void perf_evlist__add(struct perf_evlist *evlist,
 		      struct perf_evsel *evsel)
 {
+	evsel->idx = evlist->nr_entries;
 	list_add_tail(&evsel->node, &evlist->entries);
 	evlist->nr_entries += 1;
 	__perf_evlist__propagate_maps(evlist, evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index bd8c2f19ef74..dccdc3456b23 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -18,10 +18,12 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 
-void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
+void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
+		      int idx)
 {
 	INIT_LIST_HEAD(&evsel->node);
 	evsel->attr = *attr;
+	evsel->idx  = idx;
 }
 
 struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
@@ -29,7 +31,7 @@ struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
 	struct perf_evsel *evsel = zalloc(sizeof(*evsel));
 
 	if (evsel != NULL)
-		perf_evsel__init(evsel, attr);
+		perf_evsel__init(evsel, attr, 0);
 
 	return evsel;
 }
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 1c067d088bc6..86f674e36f62 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -49,9 +49,11 @@ struct perf_evsel {
 	/* parse modifier helper */
 	int			 nr_members;
 	bool			 system_wide;
+	int			 idx;
 };
 
-void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr);
+void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
+		      int idx);
 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__close_fd(struct perf_evsel *evsel);
 void perf_evsel__free_fd(struct perf_evsel *evsel);
diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index d63acb782b63..eeafe97b8105 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -322,7 +322,7 @@ static int iostat_event_group(struct evlist *evl,
 	}
 
 	evlist__for_each_entry(evl, evsel) {
-		evsel->priv = list->rps[evsel->idx / metrics_count];
+		evsel->priv = list->rps[evsel->core.idx / metrics_count];
 	}
 	list->nr_entries = 0;
 err:
@@ -428,7 +428,7 @@ void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
 {
 	double iostat_value = 0;
 	u64 prev_count_val = 0;
-	const char *iostat_metric = iostat_metric_by_idx(evsel->idx);
+	const char *iostat_metric = iostat_metric_by_idx(evsel->core.idx);
 	u8 die = ((struct iio_root_port *)evsel->priv)->die;
 	struct perf_counts_values *count = perf_counts(evsel->counts, die, 0);
 
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f52b3a799e76..80450c0e8f36 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1031,12 +1031,12 @@ static int process_base_stream(struct data__file *data_base,
 			continue;
 
 		es_base = evsel_streams__entry(data_base->evlist_streams,
-					       evsel_base->idx);
+					       evsel_base->core.idx);
 		if (!es_base)
 			return -1;
 
 		es_pair = evsel_streams__entry(data_pair->evlist_streams,
-					       evsel_pair->idx);
+					       evsel_pair->core.idx);
 		if (!es_pair)
 			return -1;
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index bc5c393021dc..4014de4da33b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -332,7 +332,7 @@ static int process_read_event(struct perf_tool *tool,
 		const char *name = evsel__name(evsel);
 		int err = perf_read_values_add_value(&rep->show_threads_values,
 					   event->read.pid, event->read.tid,
-					   evsel->idx,
+					   evsel->core.idx,
 					   name,
 					   event->read.value);
 
@@ -666,7 +666,7 @@ static int report__collapse_hists(struct report *rep)
 	evlist__for_each_entry(rep->session->evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
-		if (pos->idx == 0)
+		if (pos->core.idx == 0)
 			hists->symbol_filter_str = rep->symbol_filter_str;
 
 		hists->socket_filter = rep->socket_filter;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 2d570bfe7a56..76343a418e67 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -264,9 +264,9 @@ static void perf_top__show_details(struct perf_top *top)
 
 	if (top->evlist->enabled) {
 		if (top->zero)
-			symbol__annotate_zero_histogram(symbol, top->sym_evsel->idx);
+			symbol__annotate_zero_histogram(symbol, top->sym_evsel->core.idx);
 		else
-			symbol__annotate_decay_histogram(symbol, top->sym_evsel->idx);
+			symbol__annotate_decay_histogram(symbol, top->sym_evsel->core.idx);
 	}
 	if (more != 0)
 		printf("%d lines not displayed, maybe increase display entries [e]\n", more);
@@ -530,7 +530,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 				fprintf(stderr, "\nAvailable events:");
 
 				evlist__for_each_entry(top->evlist, top->sym_evsel)
-					fprintf(stderr, "\n\t%d %s", top->sym_evsel->idx, evsel__name(top->sym_evsel));
+					fprintf(stderr, "\n\t%d %s", top->sym_evsel->core.idx, evsel__name(top->sym_evsel));
 
 				prompt_integer(&counter, "Enter details event counter");
 
@@ -541,7 +541,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 					break;
 				}
 				evlist__for_each_entry(top->evlist, top->sym_evsel)
-					if (top->sym_evsel->idx == counter)
+					if (top->sym_evsel->core.idx == counter)
 						break;
 			} else
 				top->sym_evsel = evlist__first(top->evlist);
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index b74cf80d1f10..5ebf56331904 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -44,7 +44,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 
 			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
 				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
-				if (evsel->idx != idx)
+				if (evsel->core.idx != idx)
 					continue;
 
 				++idx;
@@ -84,9 +84,9 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names,
 
 	err = 0;
 	evlist__for_each_entry(evlist, evsel) {
-		if (strcmp(evsel__name(evsel), names[evsel->idx / distance])) {
+		if (strcmp(evsel__name(evsel), names[evsel->core.idx / distance])) {
 			--err;
-			pr_debug("%s != %s\n", evsel__name(evsel), names[evsel->idx / distance]);
+			pr_debug("%s != %s\n", evsel__name(evsel), names[evsel->core.idx / distance]);
 		}
 	}
 
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 73ae8f7aa066..d38757db2dc2 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -139,7 +139,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 				 " doesn't map to an evsel\n", sample.id);
 			goto out_delete_evlist;
 		}
-		nr_events[evsel->idx]++;
+		nr_events[evsel->core.idx]++;
 		perf_mmap__consume(&md->core);
 	}
 	perf_mmap__read_done(&md->core);
@@ -147,10 +147,10 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 out_init:
 	err = 0;
 	evlist__for_each_entry(evlist, evsel) {
-		if (nr_events[evsel->idx] != expected_nr_events[evsel->idx]) {
+		if (nr_events[evsel->core.idx] != expected_nr_events[evsel->core.idx]) {
 			pr_debug("expected %d %s events, got %d\n",
-				 expected_nr_events[evsel->idx],
-				 evsel__name(evsel), nr_events[evsel->idx]);
+				 expected_nr_events[evsel->core.idx],
+				 evsel__name(evsel), nr_events[evsel->core.idx]);
 			err = -1;
 			goto out_delete_evlist;
 		}
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index f5509a958e38..cd2ef8f3b474 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -749,7 +749,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				hbt->timer(hbt->arg);
 
 			if (delay_secs != 0) {
-				symbol__annotate_decay_histogram(sym, evsel->idx);
+				symbol__annotate_decay_histogram(sym, evsel->core.idx);
 				hists__scnprintf_title(hists, title, sizeof(title));
 				annotate_browser__show(&browser->b, title, help);
 			}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index abe1499a9164..aa04a3655236 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -961,7 +961,7 @@ static int symbol__inc_addr_samples(struct map_symbol *ms,
 	if (sym == NULL)
 		return 0;
 	src = symbol__hists(sym, evsel->evlist->core.nr_entries);
-	return src ? __symbol__inc_addr_samples(ms, src, evsel->idx, addr, sample) : 0;
+	return src ? __symbol__inc_addr_samples(ms, src, evsel->core.idx, addr, sample) : 0;
 }
 
 static int symbol__account_cycles(u64 addr, u64 start,
@@ -2159,7 +2159,7 @@ static void annotation__calc_percent(struct annotation *notes,
 
 			BUG_ON(i >= al->data_nr);
 
-			sym_hist = annotation__histogram(notes, evsel->idx);
+			sym_hist = annotation__histogram(notes, evsel->core.idx);
 			data = &al->data[i++];
 
 			calc_percent(sym_hist, hists, data, al->offset, end);
@@ -2340,7 +2340,7 @@ static void print_summary(struct rb_root *root, const char *filename)
 static void symbol__annotate_hits(struct symbol *sym, struct evsel *evsel)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	struct sym_hist *h = annotation__histogram(notes, evsel->idx);
+	struct sym_hist *h = annotation__histogram(notes, evsel->core.idx);
 	u64 len = symbol__size(sym), offset;
 
 	for (offset = 0; offset < len; ++offset)
@@ -2373,7 +2373,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
 	const char *d_filename;
 	const char *evsel_name = evsel__name(evsel);
 	struct annotation *notes = symbol__annotation(sym);
-	struct sym_hist *h = annotation__histogram(notes, evsel->idx);
+	struct sym_hist *h = annotation__histogram(notes, evsel->core.idx);
 	struct annotation_line *pos, *queue = NULL;
 	u64 start = map__rip_2objdump(map, sym->start);
 	int printed = 2, queue_len = 0, addr_fmt_width;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6ba9664089bd..6563ce3b9541 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -165,11 +165,9 @@ void evlist__delete(struct evlist *evlist)
 
 void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
-	entry->evlist = evlist;
-	entry->idx = evlist->core.nr_entries;
-	entry->tracking = !entry->idx;
-
 	perf_evlist__add(&evlist->core, &entry->core);
+	entry->evlist = evlist;
+	entry->tracking = !entry->core.idx;
 
 	if (evlist->core.nr_entries == 1)
 		evlist__set_id_pos(evlist);
@@ -232,7 +230,7 @@ void __evlist__set_leader(struct list_head *list)
 	leader = list_entry(list->next, struct evsel, core.node);
 	evsel = list_entry(list->prev, struct evsel, core.node);
 
-	leader->core.nr_members = evsel->idx - leader->idx + 1;
+	leader->core.nr_members = evsel->core.idx - leader->core.idx + 1;
 
 	__evlist__for_each_entry(list, evsel) {
 		evsel->leader = leader;
@@ -2137,7 +2135,7 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->idx == idx)
+		if (evsel->core.idx == idx)
 			return evsel;
 	}
 	return NULL;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b1c930eca40f..cce16814dc2c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -239,8 +239,7 @@ bool evsel__is_function_event(struct evsel *evsel)
 void evsel__init(struct evsel *evsel,
 		 struct perf_event_attr *attr, int idx)
 {
-	perf_evsel__init(&evsel->core, attr);
-	evsel->idx	   = idx;
+	perf_evsel__init(&evsel->core, attr, idx);
 	evsel->tracking	   = !idx;
 	evsel->leader	   = evsel;
 	evsel->unit	   = "";
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index bdad52a06438..09c290bce3cc 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -49,7 +49,6 @@ struct evsel {
 	struct perf_evsel	core;
 	struct evlist		*evlist;
 	off_t			id_offset;
-	int			idx;
 	int			id_pos;
 	int			is_pos;
 	unsigned int		sample_size;
@@ -406,7 +405,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 
 static inline int evsel__group_idx(struct evsel *evsel)
 {
-	return evsel->idx - evsel->leader->idx;
+	return evsel->core.idx - evsel->leader->core.idx;
 }
 
 /* Iterates group WITHOUT the leader. */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 0158d2945bab..9c8efb1898a0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -789,7 +789,7 @@ static int write_group_desc(struct feat_fd *ff,
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel__is_group_leader(evsel) && evsel->core.nr_members > 1) {
 			const char *name = evsel->group_name ?: "{anon_group}";
-			u32 leader_idx = evsel->idx;
+			u32 leader_idx = evsel->core.idx;
 			u32 nr_members = evsel->core.nr_members;
 
 			ret = do_write_string(ff, name);
@@ -1844,7 +1844,7 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		msz = sz;
 
 	for (i = 0, evsel = events; i < nre; evsel++, i++) {
-		evsel->idx = i;
+		evsel->core.idx = i;
 
 		/*
 		 * must read entire on-file attr struct to
@@ -2379,7 +2379,7 @@ static struct evsel *evlist__find_by_index(struct evlist *evlist, int idx)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->idx == idx)
+		if (evsel->core.idx == idx)
 			return evsel;
 	}
 
@@ -2393,7 +2393,7 @@ static void evlist__set_event_name(struct evlist *evlist, struct evsel *event)
 	if (!event->name)
 		return;
 
-	evsel = evlist__find_by_index(evlist, event->idx);
+	evsel = evlist__find_by_index(evlist, event->core.idx);
 	if (!evsel)
 		return;
 
@@ -2739,7 +2739,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 
 	i = nr = 0;
 	evlist__for_each_entry(session->evlist, evsel) {
-		if (evsel->idx == (int) desc[i].leader_idx) {
+		if (evsel->core.idx == (int) desc[i].leader_idx) {
 			evsel->leader = evsel;
 			/* {anon_group} is a dummy name */
 			if (strcmp(desc[i].name, "{anon_group}")) {
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index d3cf2dee36c8..d956d9cf73f7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -219,7 +219,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		if (has_constraint && ev->weak_group)
 			continue;
 		/* Ignore event if already used and merging is disabled. */
-		if (metric_no_merge && test_bit(ev->idx, evlist_used))
+		if (metric_no_merge && test_bit(ev->core.idx, evlist_used))
 			continue;
 		if (!has_constraint && ev->leader != current_leader) {
 			/*
@@ -269,7 +269,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 	for (i = 0; i < idnum; i++) {
 		ev = metric_events[i];
 		/* Don't free the used events. */
-		set_bit(ev->idx, evlist_used);
+		set_bit(ev->core.idx, evlist_used);
 		/*
 		 * The metric leader points to the identically named event in
 		 * metric_events.
@@ -291,7 +291,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			    evsel_same_pmu_or_none(ev->leader, metric_events[i]->leader))
 				break;
 			if (!strcmp(metric_events[i]->name, ev->name)) {
-				set_bit(ev->idx, evlist_used);
+				set_bit(ev->core.idx, evlist_used);
 				ev->metric_leader = metric_events[i];
 			}
 		}
@@ -391,7 +391,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 	}
 
 	evlist__for_each_entry_safe(perf_evlist, tmp, evsel) {
-		if (!test_bit(evsel->idx, evlist_used)) {
+		if (!test_bit(evsel->core.idx, evlist_used)) {
 			evlist__remove(perf_evlist, evsel);
 			evsel__delete(evsel);
 		}
@@ -1312,7 +1312,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 		nd = rblist__entry(old_metric_events, i);
 		old_me = container_of(nd, struct metric_event, nd);
 
-		evsel = evlist__find_evsel(evlist, old_me->evsel->idx);
+		evsel = evlist__find_evsel(evlist, old_me->evsel->core.idx);
 		if (!evsel)
 			return -EINVAL;
 		new_me = metricgroup__lookup(new_metric_events, evsel, true);
@@ -1320,7 +1320,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 			return -ENOMEM;
 
 		pr_debug("copying metric event for cgroup '%s': %s (idx=%d)\n",
-			 cgrp ? cgrp->name : "root", evsel->name, evsel->idx);
+			 cgrp ? cgrp->name : "root", evsel->name, evsel->core.idx);
 
 		list_for_each_entry(old_expr, &old_me->head, nd) {
 			new_expr = malloc(sizeof(*new_expr));
@@ -1363,7 +1363,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 			/* copy evsel in the same position */
 			for (idx = 0; idx < nr; idx++) {
 				evsel = old_expr->metric_events[idx];
-				evsel = evlist__find_evsel(evlist, evsel->idx);
+				evsel = evlist__find_evsel(evlist, evsel->core.idx);
 				if (evsel == NULL) {
 					free(new_expr->metric_events);
 					free(new_expr->metric_refs);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 84108c17f48d..e936c7c02d14 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1740,7 +1740,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 
 	leader = list_first_entry(list, struct evsel, core.node);
 	evsel = list_last_entry(list, struct evsel, core.node);
-	total_members = evsel->idx - leader->idx + 1;
+	total_members = evsel->core.idx - leader->core.idx + 1;
 
 	leaders = calloc(total_members, sizeof(uintptr_t));
 	if (WARN_ON(!leaders))
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 412f8e79e409..8feef3a05af7 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1032,7 +1032,7 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
 
 	Py_INCREF(pevsel);
 	evsel = &((struct pyrf_evsel *)pevsel)->evsel;
-	evsel->idx = evlist->core.nr_entries;
+	evsel->core.idx = evlist->core.nr_entries;
 	evlist__add(evlist, evsel);
 
 	return Py_BuildValue("i", evlist->core.nr_entries);
diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
index 4bd5e5a00aa5..545e44981a27 100644
--- a/tools/perf/util/stream.c
+++ b/tools/perf/util/stream.c
@@ -139,7 +139,7 @@ static int evlist__init_callchain_streams(struct evlist *evlist,
 
 		hists__output_resort(hists, NULL);
 		init_hot_callchain(hists, &es[i]);
-		es[i].evsel_idx = pos->idx;
+		es[i].evsel_idx = pos->core.idx;
 		i++;
 	}
 
-- 
2.31.1

