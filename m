Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFCCEB64DD
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 18:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjF0SLW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjF0SLC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 14:11:02 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C888410D8
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 11:11:00 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8038ae861so21044555ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889460; x=1690481460;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfqyfRtg18gIZYkUXiTLmJqcy7MrupNBHNFvvJ3kwbY=;
        b=0ZNygZs0lxf0VyG73tckJsHVw7kP/SiU1E3oTcUzSBFVSNbe0qcaje//HklLs4DBAv
         bRlIxrCYS8HxjMwI+SGjytdqdQ/QBHLfBYlqaAkEAYer2O5LOgs4Tr0UJon2xK/Uzme7
         e+ADreOzvJIN4sFkoyd4nH9frV3OdOU9Hq0rgj20XvX7XjI/DcuVX5Al594O5NA7lNtA
         Wtx8+ekbGPX1rkNE+/nCEZteMkfBdRVlNqaGL8JkYTnTlKAnB/L4qEgA5Gan4qusZAXD
         y/Qi14vNIN4a/fdNBPGAwBpzAOF9bVpeJD38HmqcJOM5uroSA1umnUocB+V1sosp2l7/
         uO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889460; x=1690481460;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfqyfRtg18gIZYkUXiTLmJqcy7MrupNBHNFvvJ3kwbY=;
        b=JFO/7jlPK+3ZlSS3Sfpfb3lx4hMApYZgeb6+SjMYVCYPugf2dMML0CNJ7+frTP6Vep
         1zoIVNVnwrmNXDGQhemHGQLTfnt6m9NnSqlqXjYyKkT2ON8L5RQSJ76P+tuU3O1UBaBy
         ShsTPJeG9l9mTVuYZl68nNC+wcB6Mfz7NgiCe/oXG/1b/jEuT/iwMeX4WJhRuU2ra7Ya
         roYTA9wyjK2jZzgS/Rtpe1CrH99ZSzKkY/Wklu5VjnHa+RO6+ppetoNr6ign/O5fjBgo
         Nj3Mn7UdgCJMpAjiMuph7aYMF4DsYjYKHW/jCqsT32HDYAqK0ayekkjYV/+/DkTZ9NMB
         Li8A==
X-Gm-Message-State: AC+VfDzf0fOi4GJIFOkIAJF4C22ZVKjJOQxQ9xfr+JBTAORViVAJv0cY
        FyqkjnMPlkE+9q7EuJ63+KTxvLOLHlQT
X-Google-Smtp-Source: ACHHUZ7f/DZwBsOCfaKozzhuBabOZxdqedJthtmzlDuzqKTXaM4W3f/+OpkcEMQAn7wCTu48wJRB73JUxIhA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a17:90b:ed6:b0:263:3437:a0b0 with SMTP id
 gz22-20020a17090b0ed600b002633437a0b0mr93374pjb.3.1687889460324; Tue, 27 Jun
 2023 11:11:00 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:25 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-9-irogers@google.com>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 08/13] perf parse-events: Move instances of YYABORT to YYNOMEM
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Migration to improve error reporting as YYABORT cases should carry
event parsing errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 58 +++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d22866b97b76..eaf43bd8fe3f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -390,7 +390,8 @@ value_sym '/' event_config '/'
 	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_add_numeric(_parse_state, list, type, config, $3, wildcard);
 	parse_events_terms__delete($3);
 	if (err) {
@@ -408,7 +409,8 @@ value_sym sep_slash_slash_dc
 	bool wildcard = (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE);
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config,
 					  /*head_config=*/NULL, wildcard));
 	$$ = list;
@@ -419,7 +421,8 @@ PE_VALUE_SYM_TOOL sep_slash_slash_dc
 	struct list_head *list;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	ABORT_ON(parse_events_add_tool(_parse_state, list, $1));
 	$$ = list;
 }
@@ -432,7 +435,9 @@ PE_LEGACY_CACHE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
+
 	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2);
 
 	parse_events_terms__delete($2);
@@ -451,7 +456,9 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
+
 	err = parse_events_add_breakpoint(_parse_state, list,
 					  $2, $6, $4, $7);
 	parse_events_terms__delete($7);
@@ -469,7 +476,9 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
+
 	err = parse_events_add_breakpoint(_parse_state, list,
 					  $2, NULL, $4, $5);
 	parse_events_terms__delete($5);
@@ -486,7 +495,9 @@ PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
+
 	err = parse_events_add_breakpoint(_parse_state, list,
 					  $2, $4, 0, $5);
 	parse_events_terms__delete($5);
@@ -504,7 +515,8 @@ PE_PREFIX_MEM PE_VALUE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_add_breakpoint(_parse_state, list,
 					  $2, NULL, 0, $3);
 	parse_events_terms__delete($3);
@@ -524,7 +536,8 @@ tracepoint_name opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	if (error)
 		error->idx = @1.first_column;
 
@@ -556,7 +569,8 @@ PE_VALUE ':' PE_VALUE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_add_numeric(_parse_state, list, (u32)$1, $3, $4,
 				       /*wildcard=*/false);
 	parse_events_terms__delete($4);
@@ -575,7 +589,8 @@ PE_RAW opt_event_config
 	u64 num;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	errno = 0;
 	num = strtoull($1 + 1, NULL, 16);
 	ABORT_ON(errno);
@@ -598,7 +613,8 @@ PE_BPF_OBJECT opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_load_bpf(parse_state, list, $1, false, $2);
 	parse_events_terms__delete($2);
 	free($1);
@@ -615,7 +631,8 @@ PE_BPF_SOURCE opt_event_config
 	int err;
 
 	list = alloc_list();
-	ABORT_ON(!list);
+	if (!list)
+		YYNOMEM;
 	err = parse_events_load_bpf(_parse_state, list, $1, true, $2);
 	parse_events_terms__delete($2);
 	if (err) {
@@ -680,7 +697,8 @@ event_term
 	struct list_head *head = malloc(sizeof(*head));
 	struct parse_events_term *term = $1;
 
-	ABORT_ON(!head);
+	if (!head)
+		YYNOMEM;
 	INIT_LIST_HEAD(head);
 	list_add_tail(&term->list, head);
 	$$ = head;
@@ -857,7 +875,8 @@ PE_DRV_CFG_TERM
 	struct parse_events_term *term;
 	char *config = strdup($1);
 
-	ABORT_ON(!config);
+	if (!config)
+		YYNOMEM;
 	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
 					config, $1, &@1, NULL)) {
 		free($1);
@@ -888,7 +907,8 @@ array_terms ',' array_term
 	new_array.ranges = realloc($1.ranges,
 				sizeof(new_array.ranges[0]) *
 				new_array.nr_ranges);
-	ABORT_ON(!new_array.ranges);
+	if (!new_array.ranges)
+		YYNOMEM;
 	memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
 	       $3.nr_ranges * sizeof(new_array.ranges[0]));
 	free($3.ranges);
@@ -904,7 +924,8 @@ PE_VALUE
 
 	array.nr_ranges = 1;
 	array.ranges = malloc(sizeof(array.ranges[0]));
-	ABORT_ON(!array.ranges);
+	if (!array.ranges)
+		YYNOMEM;
 	array.ranges[0].start = $1;
 	array.ranges[0].length = 1;
 	$$ = array;
@@ -917,7 +938,8 @@ PE_VALUE PE_ARRAY_RANGE PE_VALUE
 	ABORT_ON($3 < $1);
 	array.nr_ranges = 1;
 	array.ranges = malloc(sizeof(array.ranges[0]));
-	ABORT_ON(!array.ranges);
+	if (!array.ranges)
+		YYNOMEM;
 	array.ranges[0].start = $1;
 	array.ranges[0].length = $3 - $1 + 1;
 	$$ = array;
-- 
2.41.0.162.gfafddb0af9-goog

