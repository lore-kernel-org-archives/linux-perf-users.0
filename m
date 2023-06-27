Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DB7EB64DC
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 04:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjF0Efm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 00:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjF0Ef3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 00:35:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C8B171A
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 21:35:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bfe702f99b8so5429785276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 21:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840527; x=1690432527;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pylB9mwmAKl3TUVj6l4nL/JaxRJCwOWbixQnNb1VbG4=;
        b=nE40fnnx3qIWki2nYoA1/v+G94eRqvQnMCSdQVEcoIAqwcEqwdH5xGRvoHMULswyJf
         hhKw9DtpPkkz8cb54YlMMwGZgQ8O12QZhSxRQ5mvhMtNxGcTapD1UlIbIKPgEPWELXX3
         C5iwOLn3MqPpb4wj/NtGS00FbCmi9fArMLRxr5XvmkOrIRIfseXua16fYYLG8sVa6+pv
         C4w+3TfaroczYIfF8GVov0g4BHnB0pL3rFgPayuOz1LU4ZKTyEwMypxfoCQU65zCV9yl
         QYRQfwHZewdzPshBiNrkAkTu1pDGQJ4M7zb+pCqqXiXUB3rh4hqdWm9maUqJDjphnREL
         jgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840527; x=1690432527;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pylB9mwmAKl3TUVj6l4nL/JaxRJCwOWbixQnNb1VbG4=;
        b=I7KfVbj0I+eW8HK9ffTIbnRz+0E9SKGfk0l1uBQfFiq0OAmgZU41dneeU0jrNQZAHj
         SIn3g9udukWFItjdwSrhluGXSflpDAVkroocvwsedpzvBx3st2ZBTVMWGVutBmA0EBPe
         u+gMxYr8pVNGLKy1EO/FM27ibg6tHgmU0TnTcO7Ht9NLvC/qsP2DqFP5BgwoN8JwtVwK
         cKYxojq2u7tyg69wRqEGG2c/HY2Q5Ka1/hX7OjmP7bt28UjRj4F3fijhknN5YGnjLohR
         H5qnlEdl6p01GeTHeLh33VSgWekaNVGXV7WWHLcO7g4s1zvJeWB+8UDLAiktzOKhZ1bR
         E1xg==
X-Gm-Message-State: AC+VfDyBkqKWrt9u2B6F+NFvdZzLW2VJFT1uJNQrepT9e3uycUJEiwrE
        WBj4PrUs2MJFXQDvv5ukLRZDVtZbnVhZ
X-Google-Smtp-Source: ACHHUZ5Gu3B+VYc3wNgtTeuuaO+/RDP6QeL6/VJYxih1YVprHtkiMZEOVqkUu5UNnJWhXb+9Y1cwSlJTY8bA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a25:74c9:0:b0:ba8:4ff5:3217 with SMTP id
 p192-20020a2574c9000000b00ba84ff53217mr6843137ybc.3.1687840526866; Mon, 26
 Jun 2023 21:35:26 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:34:49 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-5-irogers@google.com>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 04/13] perf parse-events: Add more comments to parse_events_state
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

Improve documentation of struct parse_events_state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b0eb95f93e9c..b37e5ee193a8 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -121,17 +121,25 @@ struct parse_events_error {
 };
 
 struct parse_events_state {
+	/* The list parsed events are placed on. */
 	struct list_head	   list;
+	/* The updated index used by entries as they are added. */
 	int			   idx;
+	/* Error information. */
 	struct parse_events_error *error;
+	/* Used by BPF event creation. */
 	struct evlist		  *evlist;
+	/* Holds returned terms for term parsing. */
 	struct list_head	  *terms;
+	/* Start token. */
 	int			   stoken;
+	/* Special fake PMU marker for testing. */
 	struct perf_pmu		  *fake_pmu;
 	/* If non-null, when wildcard matching only match the given PMU. */
 	const char		  *pmu_filter;
 	/* Should PE_LEGACY_NAME tokens be generated for config terms? */
 	bool			   match_legacy_cache_terms;
+	/* Were multiple PMUs scanned to find events? */
 	bool			   wild_card_pmus;
 };
 
-- 
2.41.0.162.gfafddb0af9-goog

