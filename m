Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF72C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F31861506
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbhKHNlD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:41:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235425AbhKHNlC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AoK/1SAVKcy1Onx8vJ4KnRMZAfao1lxNDe8BemkzCN8=;
        b=b9DVPhtu0zYVVlyAbirSSwelppya1FZCfmiJnilihhPAruaO0PEZiGD3afTFuo6VShScdT
        7OHYiRhitLfAs1UvXd8w6DVAScZbcD7Dw9JnzezGAT+RjgdxiL0MsXDB+COlvHQum3Z5zn
        5eoHS3/y7fa71POIQlatS42XdApCtJI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-empJBMABMzao9PROD1S64g-1; Mon, 08 Nov 2021 08:38:17 -0500
X-MC-Unique: empJBMABMzao9PROD1S64g-1
Received: by mail-wm1-f70.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso10170057wmb.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AoK/1SAVKcy1Onx8vJ4KnRMZAfao1lxNDe8BemkzCN8=;
        b=B2GDlLrp/e6idFFhmvJbLuyJhsKfphNMmJrCaomMnDnOj7mU41SYE+45IHMm1CeE7x
         FIIJERcM2ekDbIIxi7Tm9nWngM4Ns3HwX+rp1pQ0WpIh6C25p9eN60vdLB5Ac0LuJlAM
         hfK3hf++tFVFaBMJMNrbRny4Zs8mNIt0VZPLWTsL8Z03WBejdRpuEBmR71uQXzipPsno
         dl2gxGfmxM29gaYiomjh9MlgbLCyyT8exDWFCXrmz7Bn0S87FbxpGoXBLMaog8B0stKC
         nsXOhVLc0UjbAgw/rRn5DYqicz/JcDL6QutVK5ZJrTqdgasQE68V2kQaq9QjGyL6L2me
         Y1Fg==
X-Gm-Message-State: AOAM533PHUccs+f6tXIYBllKP69psEt6AjjklqIAAmEq0mFjegeO9yze
        vE+p+PZxeSam4l7KeE2K5xIfZfRvkKrW0byvnIVJrlorszL6t/Ve8004/CHRkszILBBpz5XGl+9
        JV2J412ztXsuS8+IdHRkz0tH/SP1G8g==
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr52968995wma.45.1636378695875;
        Mon, 08 Nov 2021 05:38:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVpgOWsoC6cgFefY275zu2eBBpURebOBavfpuKLIHzFEv1V2sMO1h3Tk9c0wBQHHZsAC/19A==
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr52968977wma.45.1636378695715;
        Mon, 08 Nov 2021 05:38:15 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id a22sm2131661wme.19.2021.11.08.05.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:38:15 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 09/59] libperf: Move config_terms to perf_evsel
Date:   Mon,  8 Nov 2021 14:36:20 +0100
Message-Id: <20211108133710.1352822-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving config_terms to perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/evsel.h |  1 +
 tools/perf/builtin-top.c                |  2 +-
 tools/perf/util/evsel.c                 | 10 +++++-----
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/parse-events.c          |  6 +++---
 tools/perf/util/record.c                |  2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index be30dc1ed9a7..ef5a85de7ba9 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -60,6 +60,7 @@ struct perf_evsel {
         struct {
                 char			*name;
 		bool			auto_merge_stats;
+		struct list_head	config_terms;
 	};
 };
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 020c4f110c10..c307d3015cfa 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -951,7 +951,7 @@ static int perf_top__overwrite_check(struct perf_top *top)
 
 	evlist__for_each_entry(evlist, evsel) {
 		set = -1;
-		config_terms = &evsel->config_terms;
+		config_terms = &evsel->core.config_terms;
 		list_for_each_entry(term, config_terms, list) {
 			if (term->type == EVSEL__CONFIG_TERM_OVERWRITE)
 				set = term->val.overwrite ? 1 : 0;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 10ba2f91d5a2..bc5a213b3955 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -247,7 +247,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->evlist	   = NULL;
 	evsel->bpf_obj	   = NULL;
 	evsel->bpf_fd	   = -1;
-	INIT_LIST_HEAD(&evsel->config_terms);
+	INIT_LIST_HEAD(&evsel->core.config_terms);
 	INIT_LIST_HEAD(&evsel->bpf_counter_list);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size = __evsel__sample_size(attr->sample_type);
@@ -357,7 +357,7 @@ int copy_config_terms(struct list_head *dst, struct list_head *src)
 
 static int evsel__copy_config_terms(struct evsel *dst, struct evsel *src)
 {
-	return copy_config_terms(&dst->config_terms, &src->config_terms);
+	return copy_config_terms(&dst->core.config_terms, &src->core.config_terms);
 }
 
 /**
@@ -917,7 +917,7 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 				      struct record_opts *opts, bool track)
 {
 	struct evsel_config_term *term;
-	struct list_head *config_terms = &evsel->config_terms;
+	struct list_head *config_terms = &evsel->core.config_terms;
 	struct perf_event_attr *attr = &evsel->core.attr;
 	/* callgraph default */
 	struct callchain_param param = {
@@ -1050,7 +1050,7 @@ struct evsel_config_term *__evsel__get_config_term(struct evsel *evsel, enum evs
 {
 	struct evsel_config_term *term, *found_term = NULL;
 
-	list_for_each_entry(term, &evsel->config_terms, list) {
+	list_for_each_entry(term, &evsel->core.config_terms, list) {
 		if (term->type == type)
 			found_term = term;
 	}
@@ -1420,7 +1420,7 @@ void free_config_terms(struct list_head *config_terms)
 
 static void evsel__free_config_terms(struct evsel *evsel)
 {
-	free_config_terms(&evsel->config_terms);
+	free_config_terms(&evsel->core.config_terms);
 }
 
 void evsel__exit(struct evsel *evsel)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ead2c3f3ea05..b703e78ace23 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -84,7 +84,6 @@ struct evsel {
 		bool			use_config_name;
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
-		struct list_head	config_terms;
 	};
 
 	/*
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 09fbb128df63..c08b7fa8dae4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -393,7 +393,7 @@ __add_event(struct list_head *list, int *idx,
 		evsel->metric_id = strdup(metric_id);
 
 	if (config_terms)
-		list_splice_init(config_terms, &evsel->config_terms);
+		list_splice_init(config_terms, &evsel->core.config_terms);
 
 	if (list)
 		list_add_tail(&evsel->core.node, list);
@@ -607,7 +607,7 @@ static int add_tracepoint(struct list_head *list, int *idx,
 
 		if (get_config_terms(head_config, &config_terms))
 			return -ENOMEM;
-		list_splice(&config_terms, &evsel->config_terms);
+		list_splice(&config_terms, &evsel->core.config_terms);
 	}
 
 	list_add_tail(&evsel->core.node, list);
@@ -1658,7 +1658,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	evsel->pmu_name = name ? strdup(name) : NULL;
 	evsel->use_uncore_alias = use_uncore_alias;
-	evsel->percore = config_term_percore(&evsel->config_terms);
+	evsel->percore = config_term_percore(&evsel->core.config_terms);
 
 	if (parse_state->fake_pmu)
 		return 0;
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index bff669b615ee..83e3a8cce9ba 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -41,7 +41,7 @@ static struct evsel *evsel__read_sampler(struct evsel *evsel, struct evlist *evl
 static u64 evsel__config_term_mask(struct evsel *evsel)
 {
 	struct evsel_config_term *term;
-	struct list_head *config_terms = &evsel->config_terms;
+	struct list_head *config_terms = &evsel->core.config_terms;
 	u64 term_types = 0;
 
 	list_for_each_entry(term, config_terms, list) {
-- 
2.31.1

