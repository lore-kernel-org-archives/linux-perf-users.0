Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79976C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616BB61458
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbhKHNmz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:42:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238667AbhKHNmy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=erkQOajBbIyW6e8zayRTgXjjbssRqjN67AWHBduaGKI=;
        b=L0h3cwLcgneSVTayooKNUYGP58+81rjSnQweLGk+sIuhMfBJpLlCwvHaGXBIcxGBR2lGC6
        bxJSEf5i+pSnq68q5umYwZQZVqr64bkhK8/8Se8ZqQY8XrHk+5CiaFBehb7lyLZm4iwdqL
        /SF0LqFVPTH1asLA+lRnqM23Tz2pX0Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-EZ2RnSLgOaKoXazSwehCWg-1; Mon, 08 Nov 2021 08:40:09 -0500
X-MC-Unique: EZ2RnSLgOaKoXazSwehCWg-1
Received: by mail-wm1-f70.google.com with SMTP id y9-20020a1c7d09000000b003316e18949bso6228969wmc.5
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erkQOajBbIyW6e8zayRTgXjjbssRqjN67AWHBduaGKI=;
        b=v5NT11Dncr6OCNJazfZ8Kl3b4aWHbwfzMVysRnS4vO/xNfk7479MbJCWBlgdgYUQ+b
         TDssEeV3hiF8TEyD0+2fOWh8nKRZfBw9z7JiC1DhQW1HT6XtaKQA5r4KG7t81MkdXkSy
         oC+w8GS3y660erJYyfG838X7zKtJxVE5m9CB8BX/z4x+9wwBOP82mntj0UbPR9due08J
         BlqrA4+gZ7/ARf5KQGinJ0tzzBSWMRU7XsGSa0Dvmb0W7Ix/WDRqzzV9InwFF8D8RdyR
         8rjzxaK9H//ZiKmTPILIMER2cmEcc5b6+/OXexKvL8+dS60Y+FlkF6pRcit2ypIv24js
         1YNg==
X-Gm-Message-State: AOAM532UBrmJOJkxbzyirNXktMTRN34W+52/6+IHqAtXnwYmqljwM24Q
        RTE/BD4hE5JMforcpkZsYcOkx9pcWwcHV53jtOfktni70/SLS/Cwik3Q8lbneQVuZisMgM5iB0M
        546DIKzLzZkGw5Lq+5iXYzwXdXAWRDA==
X-Received: by 2002:a5d:4904:: with SMTP id x4mr89676566wrq.139.1636378807937;
        Mon, 08 Nov 2021 05:40:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcAKczX28Qu6eUVYRV/X7UsvdbCI0EMmRMzVe4r/hIBpvBEbO+wnEAbioCxgLdC3QA/vJGqA==
X-Received: by 2002:a5d:4904:: with SMTP id x4mr89676547wrq.139.1636378807755;
        Mon, 08 Nov 2021 05:40:07 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id d16sm12385206wmb.37.2021.11.08.05.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:40:07 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 28/59] perf tools: Add perf_evsel__add_event function
Date:   Mon,  8 Nov 2021 14:36:39 +0100
Message-Id: <20211108133710.1352822-29-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding perf_evsel__add_event function as a replacement
for __add_event and prepare it for moving to libperf.

That includes changing current parse_state_ops callbacks
to work over perf_evsel instead of evsel.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 121 +++++++++++++++++++++------------
 tools/perf/util/parse-events.h |   4 +-
 2 files changed, 78 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d98e8c4388ac..f41dd97f1623 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -60,9 +60,23 @@ static struct perf_pmu_event_symbol *perf_pmu_events_list;
  */
 static int perf_pmu_events_list_num;
 
+static struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
+{
+	struct evsel *evsel = evsel__new_idx(attr, idx);
+
+	return evsel ? &evsel->core : NULL;
+}
+
+static struct perf_evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx)
+{
+	struct evsel *evsel = evsel__newtp_idx(sys, name, idx);
+
+	return IS_ERR(evsel) ? (void*) evsel : &evsel->core;
+}
+
 static struct parse_events_ops parse_state_ops = {
-	.evsel__new    = evsel__new_idx,
-	.evsel__new_tp = evsel__newtp_idx,
+	.perf_evsel__new    = perf_evsel__new_idx,
+	.perf_evsel__new_tp = perf_evsel__newtp_idx,
 };
 
 #define __PERF_EVENT_FIELD(config, name) \
@@ -267,16 +281,16 @@ static char *get_config_name(struct list_head *head_terms)
 	return get_config_str(head_terms, PARSE_EVENTS__TERM_TYPE_NAME);
 }
 
-static struct evsel *
-__add_event(struct parse_events_state *parse_state,
-	    struct list_head *list,
-	    struct perf_event_attr *attr,
-	    bool init_attr,
-	    const char *name, const char *metric_id, struct perf_pmu *pmu,
-	    struct list_head *config_terms, bool auto_merge_stats,
-	    const char *cpu_list)
+static struct perf_evsel *
+perf_evsel__add_event(struct parse_events_state *parse_state,
+		      struct list_head *list,
+		      struct perf_event_attr *attr,
+		      bool init_attr,
+		      const char *name, const char *metric_id, struct perf_pmu *pmu,
+		      struct list_head *config_terms, bool auto_merge_stats,
+		      const char *cpu_list)
 {
-	struct evsel *evsel;
+	struct perf_evsel *evsel;
 	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
 			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
 	int *idx = &parse_state->idx;
@@ -287,41 +301,58 @@ __add_event(struct parse_events_state *parse_state,
 	if (init_attr)
 		event_attr_init(attr);
 
-	evsel = parse_state->ops->evsel__new(attr, *idx);
+	evsel = parse_state->ops->perf_evsel__new(attr, *idx);
 	if (!evsel) {
 		perf_cpu_map__put(cpus);
 		return NULL;
 	}
 
 	(*idx)++;
-	evsel->core.cpus = cpus;
-	evsel->core.own_cpus = perf_cpu_map__get(cpus);
-	evsel->core.system_wide = pmu ? pmu->is_uncore : false;
-	evsel->core.auto_merge_stats = auto_merge_stats;
+	evsel->cpus = cpus;
+	evsel->own_cpus = perf_cpu_map__get(cpus);
+	evsel->system_wide = pmu ? pmu->is_uncore : false;
+	evsel->auto_merge_stats = auto_merge_stats;
 
 	if (name)
-		evsel->core.name = strdup(name);
+		evsel->name = strdup(name);
 
 	if (metric_id)
-		evsel->core.metric_id = strdup(metric_id);
+		evsel->metric_id = strdup(metric_id);
 
 	if (config_terms)
-		list_splice_init(config_terms, &evsel->core.config_terms);
+		list_splice_init(config_terms, &evsel->config_terms);
 
 	if (list)
-		list_add_tail(&evsel->core.node, list);
+		list_add_tail(&evsel->node, list);
 
 	return evsel;
 }
 
+static struct evsel *
+evsel__add_event(struct parse_events_state *parse_state,
+		 struct list_head *list,
+		 struct perf_event_attr *attr,
+		 bool init_attr,
+		 const char *name, const char *metric_id, struct perf_pmu *pmu,
+		 struct list_head *config_terms, bool auto_merge_stats,
+		 const char *cpu_list)
+{
+	struct perf_evsel *evsel;
+
+	evsel = perf_evsel__add_event(parse_state, list, attr, init_attr,
+				      name, metric_id, pmu, config_terms,
+				      auto_merge_stats, cpu_list);
+	return container_of(evsel, struct evsel, core);
+}
+
 struct evsel *parse_events__add_event(struct parse_events_state *parse_state,
 				      struct perf_event_attr *attr,
 				      const char *name, const char *metric_id,
 				      struct perf_pmu *pmu)
 {
-	return __add_event(parse_state, /*list=*/NULL, attr, /*init_attr=*/false, name,
-			   metric_id, pmu, /*config_terms=*/NULL,
-			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL);
+	return evsel__add_event(parse_state, /*list=*/NULL, attr, /*init_attr=*/false, name,
+				metric_id, pmu, /*config_terms=*/NULL,
+				/*auto_merge_stats=*/false, /*cpu_list=*/NULL);
 }
 
 static int add_event(struct parse_events_state *parse_state,
@@ -329,9 +360,9 @@ static int add_event(struct parse_events_state *parse_state,
 		     struct perf_event_attr *attr, const char *name,
 		     const char *metric_id, struct list_head *config_terms)
 {
-	return __add_event(parse_state, list, attr, /*init_attr*/true, name, metric_id,
-			   /*pmu=*/NULL, config_terms,
-			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL) ? 0 : -ENOMEM;
+	return evsel__add_event(parse_state, list, attr, /*init_attr*/true, name, metric_id,
+				/*pmu=*/NULL, config_terms,
+				/*auto_merge_stats=*/false, /*cpu_list=*/NULL) ? 0 : -ENOMEM;
 }
 
 static int add_event_tool(struct parse_events_state *parse_state,
@@ -344,10 +375,10 @@ static int add_event_tool(struct parse_events_state *parse_state,
 		.config = PERF_COUNT_SW_DUMMY,
 	};
 
-	evsel = __add_event(parse_state, list, &attr, /*init_attr=*/true, /*name=*/NULL,
-			    /*metric_id=*/NULL, /*pmu=*/NULL,
-			    /*config_terms=*/NULL, /*auto_merge_stats=*/false,
-			    /*cpu_list=*/"0");
+	evsel = evsel__add_event(parse_state, list, &attr, /*init_attr=*/true, /*name=*/NULL,
+				 /*metric_id=*/NULL, /*pmu=*/NULL,
+				 /*config_terms=*/NULL, /*auto_merge_stats=*/false,
+				 /*cpu_list=*/"0");
 	if (!evsel)
 		return -ENOMEM;
 	evsel->core.tool_event = tool_event;
@@ -513,7 +544,7 @@ static int add_tracepoint(struct parse_events_state *parse_state,
 			  struct list_head *head_config)
 {
 	int *idx = &parse_state->idx;
-	struct evsel *evsel = parse_state->ops->evsel__new_tp(sys_name, evt_name, (*idx)++);
+	struct perf_evsel *evsel = parse_state->ops->perf_evsel__new_tp(sys_name, evt_name, (*idx)++);
 
 	if (IS_ERR(evsel)) {
 		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name);
@@ -525,10 +556,10 @@ static int add_tracepoint(struct parse_events_state *parse_state,
 
 		if (get_config_terms(head_config, &config_terms))
 			return -ENOMEM;
-		list_splice(&config_terms, &evsel->core.config_terms);
+		list_splice(&config_terms, &evsel->config_terms);
 	}
 
-	list_add_tail(&evsel->core.node, list);
+	list_add_tail(&evsel->node, list);
 	return 0;
 }
 
@@ -1484,11 +1515,11 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	if (!head_config) {
 		attr.type = pmu->type;
-		evsel = __add_event(parse_state, list, &attr,
-				    /*init_attr=*/true, /*name=*/NULL,
-				    /*metric_id=*/NULL, pmu,
-				    /*config_terms=*/NULL, auto_merge_stats,
-				    /*cpu_list=*/NULL);
+		evsel = evsel__add_event(parse_state, list, &attr,
+					 /*init_attr=*/true, /*name=*/NULL,
+					 /*metric_id=*/NULL, pmu,
+					 /*config_terms=*/NULL, auto_merge_stats,
+					 /*cpu_list=*/NULL);
 		if (evsel) {
 			evsel->pmu_name = name ? strdup(name) : NULL;
 			evsel->use_uncore_alias = use_uncore_alias;
@@ -1541,10 +1572,10 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -EINVAL;
 	}
 
-	evsel = __add_event(parse_state, list, &attr, /*init_attr=*/true,
-			    get_config_name(head_config),
-			    get_config_metric_id(head_config), pmu,
-			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
+	evsel = evsel__add_event(parse_state, list, &attr, /*init_attr=*/true,
+				 get_config_name(head_config),
+				 get_config_metric_id(head_config), pmu,
+				 &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
 	if (!evsel)
 		return -ENOMEM;
 
@@ -3107,7 +3138,7 @@ struct evsel *parse_events__add_event_hybrid(struct parse_events_state *parse_st
 					     struct perf_pmu *pmu,
 					     struct list_head *config_terms)
 {
-	return __add_event(parse_state, list, attr, /*init_attr=*/true, name, metric_id,
-			   pmu, config_terms, /*auto_merge_stats=*/false,
-			   /*cpu_list=*/NULL);
+	return evsel__add_event(parse_state, list, attr, /*init_attr=*/true, name, metric_id,
+				pmu, config_terms, /*auto_merge_stats=*/false,
+				/*cpu_list=*/NULL);
 }
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5e30977bdb07..34ee456629b0 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -72,8 +72,8 @@ struct parse_events_error {
 };
 
 struct parse_events_ops {
-	struct evsel* (*evsel__new)(struct perf_event_attr *attr, int idx);
-	struct evsel* (*evsel__new_tp)(const char *sys, const char *name, int idx);
+	struct perf_evsel* (*perf_evsel__new)(struct perf_event_attr *attr, int idx);
+	struct perf_evsel* (*perf_evsel__new_tp)(const char *sys, const char *name, int idx);
 };
 
 struct parse_events_state {
-- 
2.31.1

