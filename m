Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B45BC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 03:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7223360F22
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 03:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhKLDyg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 22:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbhKLDye (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 22:54:34 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CF0C061766
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 19:51:44 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id w5-20020a654105000000b002692534afceso4297161pgp.8
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 19:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bNNquJJqGdWF2lTafVZclrpc0rb8tmpex8u7Sl7yvlA=;
        b=cwppyDF8ZnbOXr6AsYeOJE8T1uyUnLE3qI7M4g+Ja2pSnfGZeSgSgnfJMBzmmZkyy8
         rSxZ4uvtKbjPbkLEQqdZ9PumJETMz2lDi3f6HeqHFdGIIGr30Tq3zeotxtD9V7sNxxSl
         7VrpuWX7/NXYR7NiCHltwui2UqNyeU6DDuq6lgTl6zqQjwmQOUA91OBMB56S0R2kdl3U
         iERJZ0sO2WfGfracb8O2ZrDyY1pdgHTaqAZgamiqRs1AVpMLEqnkT/VFfI/PrgGkLB3P
         zbT7crTE4E8Zlbo3Cl/Fs0oXKBivxJwwJqn9NWmYEa23WWJ+eMogGZ1KG+c+Fmwu3sWN
         UrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bNNquJJqGdWF2lTafVZclrpc0rb8tmpex8u7Sl7yvlA=;
        b=CLcalhh1gqtocEs2dkMh0JnElImip1N1qV+235L+8+rkhbvOe3H02GvG4iiPOnCl09
         9e4ytezaXoWbp3FE3ECtzprmNSeX6dmxskTNe7OHPvZm5wDubZfXV5XCwG8G/JqewgBL
         BqaXnL3D4dWYVF8aE691qbC9tbjNhH/3BMjBONPiZd+cgi/25omtf1U3YY1ncsiVZ6cu
         zXM8NZVnL25wEWKff9cZ32khg+fPrhJ/sEfRzWZBGUD+3qqcswh4pjIna1pleqbUBlrV
         DzRoZZkHL4HFOeyVOoqRt7irXecY/0Lu/5/CqKX5u09eJsN7wyRE61Mql8CL9z+WJC/u
         rs0w==
X-Gm-Message-State: AOAM530mGoB7YRwQjZuI9W5fGH1W1kHyuDB5cN28ga2hutI5MgKk90kM
        LSIF4aRElk25RH/KuusJNBMYryFqqYMU
X-Google-Smtp-Source: ABdhPJx31AGu8+h3+O3oazMVdL4EeF5WOTBs0pfBf6MEZ3yKb6+ogAME72TbScBOQ5sz8OcGNjmeBIF6HZOM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5ce9:74ca:7ed9:75f2])
 (user=irogers job=sendgmr) by 2002:a05:6a00:9a2:b0:44c:b979:afe3 with SMTP id
 u34-20020a056a0009a200b0044cb979afe3mr11207128pfg.61.1636689104177; Thu, 11
 Nov 2021 19:51:44 -0800 (PST)
Date:   Thu, 11 Nov 2021 19:51:24 -0800
In-Reply-To: <20211112035124.94327-1-irogers@google.com>
Message-Id: <20211112035124.94327-3-irogers@google.com>
Mime-Version: 1.0
References: <20211112035124.94327-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH 3/3] perf symbols: Factor out annotation init/exit
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The exit function fixes a memory leak with the src field as detected by
leak sanitizer. An example of which is:

Indirect leak of 25133184 byte(s) in 207 object(s) allocated from:
    #0 0x7f199ecfe987 in __interceptor_calloc libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x55defe638224 in annotated_source__alloc_histograms util/annotate.c:803
    #2 0x55defe6397e4 in symbol__hists util/annotate.c:952
    #3 0x55defe639908 in symbol__inc_addr_samples util/annotate.c:968
    #4 0x55defe63aa29 in hist_entry__inc_addr_samples util/annotate.c:1119
    #5 0x55defe499a79 in hist_iter__report_callback tools/perf/builtin-report.c:182
    #6 0x55defe7a859d in hist_entry_iter__add util/hist.c:1236
    #7 0x55defe49aa63 in process_sample_event tools/perf/builtin-report.c:315
    #8 0x55defe731bc8 in evlist__deliver_sample util/session.c:1473
    #9 0x55defe731e38 in machines__deliver_event util/session.c:1510
    #10 0x55defe732a23 in perf_session__deliver_event util/session.c:1590
    #11 0x55defe72951e in ordered_events__deliver_event util/session.c:183
    #12 0x55defe740082 in do_flush util/ordered-events.c:244
    #13 0x55defe7407cb in __ordered_events__flush util/ordered-events.c:323
    #14 0x55defe740a61 in ordered_events__flush util/ordered-events.c:341
    #15 0x55defe73837f in __perf_session__process_events util/session.c:2390
    #16 0x55defe7385ff in perf_session__process_events util/session.c:2420
    ...

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 11 +++++++++++
 tools/perf/util/annotate.h |  3 +++
 tools/perf/util/symbol.c   |  9 ++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5d982933b3a2..01900689dc00 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1255,6 +1255,17 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool r
 	return ins__scnprintf(&dl->ins, bf, size, &dl->ops, max_ins_name);
 }
 
+void annotation__init(struct annotation *notes)
+{
+	pthread_mutex_init(&notes->lock, NULL);
+}
+
+void annotation__exit(struct annotation *notes)
+{
+	annotated_source__delete(notes->src);
+	pthread_mutex_destroy(&notes->lock);
+}
+
 static void annotation_line__add(struct annotation_line *al, struct list_head *head)
 {
 	list_add_tail(&al->node, head);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3757416bcf46..986f2bbe4870 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -299,6 +299,9 @@ struct annotation {
 	struct annotated_source *src;
 };
 
+void annotation__init(struct annotation *notes);
+void annotation__exit(struct annotation *notes);
+
 static inline int annotation__cycles_width(struct annotation *notes)
 {
 	if (notes->have_cycles && notes->options->show_minmax_cycle)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index aa1b7c12fd61..b2ed3140a1fa 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -274,7 +274,7 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 	if (symbol_conf.priv_size) {
 		if (symbol_conf.init_annotation) {
 			struct annotation *notes = (void *)sym;
-			pthread_mutex_init(&notes->lock, NULL);
+			annotation__init(notes);
 		}
 		sym = ((void *)sym) + symbol_conf.priv_size;
 	}
@@ -294,6 +294,13 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 
 void symbol__delete(struct symbol *sym)
 {
+	if (symbol_conf.priv_size) {
+		if (symbol_conf.init_annotation) {
+			struct annotation *notes = symbol__annotation(sym);
+
+			annotation__exit(notes);
+		}
+	}
 	free(((void *)sym) - symbol_conf.priv_size);
 }
 
-- 
2.34.0.rc1.387.gb447b232ab-goog

