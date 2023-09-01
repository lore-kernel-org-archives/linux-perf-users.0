Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6260CA0FFA
	for <linux-perf-users@archiver.kernel.org>; Fri,  1 Sep 2023 23:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349714AbjIAXkI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 1 Sep 2023 19:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351119AbjIAXkG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Sep 2023 19:40:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A8918C
        for <linux-perf-users@vger.kernel.org>; Fri,  1 Sep 2023 16:40:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7ea08906b3so629979276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Sep 2023 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693611602; x=1694216402; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C63LVzjWcO3ndeq3MzPqAiYpz2niIb7tc9p39BJtXA8=;
        b=XdK4WHvzZp8jFngZbtqSZEyN4jObptHN6VJGzVb+MZ0tITK9f2GcHjVwv2q3efgAyX
         Mza9vXVSr/lzuyfD71zk7O0CTjCoN9dgwD7dGqGC4KCYBjmwTRskQn9PDTi8zYacaYuJ
         ponRj+Uaz/13wRNn9SQ5Bo9Fnc9dHq/uH9uTKqFbkOElWVON/LyfJxQu3PN92n7lX/7I
         marUnhbwWVhcl10EO7l6Gi2shkmhkPJ3sZl7j8IN6t7ewcgri7poGVdmY3xcvcGfJBPY
         63U+QEQImaZgUD4G9clvymFG6U3dBeJcXO/0YPJicblBf9Rw7Q92GVjnyS/RXoS2hLFN
         MclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611602; x=1694216402;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C63LVzjWcO3ndeq3MzPqAiYpz2niIb7tc9p39BJtXA8=;
        b=dM2fBqB9b7xoG4gYI+iAVZFxmoNr5QP5JY7NCy8kEtPyI+aDxjF/OZMR64/720vvvp
         Wi1axOBwRqDohAQhiziOqbynyVmYsrgvH+43RXTneED/Q4fIqImrMmxAsYn2EaPBeGZr
         NAkd6j6UYH/g8/lU+zGfqsH92WIpvXqOSdAqa2MsdtB//sd1JpuM1vLSIGPyWJWUxlve
         YO+uUg4aZX1k0ML9kkhIKPVCM3RZGf4uaX9LsdABfZa3HlWop+3vtmM6HfE4desOJ8uY
         wqfkL7kKjDp5JAaWVSE9mkeDuDmNBZE4HKiuS6N6QJ7w2fivuY42pjoE1gNKWvtOAzyU
         wbOQ==
X-Gm-Message-State: AOJu0YyWbYje3C3ytFJOkLEY/67CdWKNe/Ew3u2lYcOxngHxC17G9eaz
        MOOXtVnwsPP/QhjhZlOtAwU485ESbf5t
X-Google-Smtp-Source: AGHT+IEyHLDuphPT30DQMKZHhdOPGSECuXA4i3XXyQtARv5DAwk13yZSs/Jb5JOIlf6bYlei49bg4zhdw1En
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:51bc:d985:dbbd:10b])
 (user=irogers job=sendgmr) by 2002:a25:dc82:0:b0:d74:6bcc:7b22 with SMTP id
 y124-20020a25dc82000000b00d746bcc7b22mr99667ybe.6.1693611602279; Fri, 01 Sep
 2023 16:40:02 -0700 (PDT)
Date:   Fri,  1 Sep 2023 16:39:46 -0700
In-Reply-To: <20230901233949.2930562-1-irogers@google.com>
Message-Id: <20230901233949.2930562-3-irogers@google.com>
Mime-Version: 1.0
References: <20230901233949.2930562-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 3/6] perf parse-events: Tidy up str parameter
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
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a const and rename str to event_name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 13 +++++++------
 tools/perf/util/parse-events.h |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e9e3623f3fed..283c559a35b4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1482,7 +1482,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 }
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       char *str, struct list_head *head,
+			       const char *event_name, struct list_head *head,
 			       struct list_head **listp, void *loc_)
 {
 	struct parse_events_term *term;
@@ -1502,7 +1502,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 		INIT_LIST_HEAD(head);
 	}
-	config = strdup(str);
+
+	config = strdup(event_name);
 	if (!config)
 		goto out_err;
 
@@ -1528,7 +1529,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
 
-		if (!perf_pmu__have_event(pmu, str))
+		if (!perf_pmu__have_event(pmu, event_name))
 			continue;
 
 		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
@@ -1539,7 +1540,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 			strbuf_init(&sb, /*hint=*/ 0);
 			parse_events_term__to_strbuf(orig_head, &sb);
-			pr_debug("%s -> %s/%s/\n", str, pmu->name, sb.buf);
+			pr_debug("%s -> %s/%s/\n", event_name, pmu->name, sb.buf);
 			strbuf_release(&sb);
 			ok++;
 		}
@@ -1547,13 +1548,13 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	}
 
 	if (parse_state->fake_pmu) {
-		if (!parse_events_add_pmu(parse_state, list, str, head,
+		if (!parse_events_add_pmu(parse_state, list, event_name, head,
 					  /*auto_merge_stats=*/true, loc)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
 			parse_events_term__to_strbuf(head, &sb);
-			pr_debug("%s -> %s/%s/\n", str, "fake_pmu", sb.buf);
+			pr_debug("%s -> %s/%s/\n", event_name, "fake_pmu", sb.buf);
 			strbuf_release(&sb);
 			ok++;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 594e5d2dc67f..36a67ef7b35a 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -217,7 +217,7 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 				      struct perf_pmu *pmu);
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       char *str,
+			       const char *event_name,
 			       struct list_head *head_config,
 			       struct list_head **listp, void *loc);
 
-- 
2.42.0.283.g2d96d420d3-goog

