Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF94C7EE23
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 05:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjFGFCH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jun 2023 01:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjFGFCE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jun 2023 01:02:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085EE7E
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Jun 2023 22:02:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-568ab5c813eso114850677b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2023 22:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686114122; x=1688706122;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ikiqQuTZUJiABEoiUDyLUaakiCQM83ZBVgIUJ5qyiw=;
        b=n2XMZRp5Bhjmhnf1S7FOdeGul2K9HH1o1TAnJwUhWb9F6vmziwkWV6fdF2lI0p533B
         5GOT5AyErh8jVZ59k3YBHwfAxFO3fyhOCVGdHLmIaZPpzfvkdeojUsmmJJ05IHPsFCgB
         te03hoMvX1btHIiA5whK5kbe/eZ7KRGl3Dsyp/h0acEPNPi6mD7ojbjncT+eoGIRnv2W
         zag/KXcJDcGV3+24y9FiynmTW6LgZhcdShPNKO+qvHNy3TontHHuhAPeqgSWxNkntcBL
         h4ZEtkb+XNmulicM133xPFaLtmZk7/qvXW2fWFQJQhju+MseCuZB4CwCd4QyBEyHvrvH
         uwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686114122; x=1688706122;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ikiqQuTZUJiABEoiUDyLUaakiCQM83ZBVgIUJ5qyiw=;
        b=jM2PAETrThdz2BJGKKhQlTcp8vzSOsDR84r7yZVripEYjkE5K8pcgvgxdHkWeUGsnv
         MTVrw6p1Gh6T3nZ/LfP8iTxhjUvneUbCf470UXsPPYwXGmjsYK/mlyeH7/yzrRwNwWwU
         7CXC08PaCPnSBgq8EF/U6CsD+jp2Afm2Jcql8aDH7B53hgvM8sTB9VZnl4e0EBXNpTth
         BazIKyEUgH7JAVtN0hX2NQQdfmaeMwkvK45pH1ZpQMuveAA5/hxWdQSLJeV1l2Jxyhxj
         p5lW07Fz7d4eltdxtht6sArTZ4xM5OmROqmbN85fSRlGzEX7oEKpSFoHAlIG3NPK4bEV
         akkA==
X-Gm-Message-State: AC+VfDwi/bj9aJC8gkWn5otyYDqjsyqj0B6vt7U4vimkitbL/hxovSty
        ZsDeEr5mKzxFiGo2UTkVkfg2cympwS+q
X-Google-Smtp-Source: ACHHUZ491PewUGRspEK6o4fbP8WWZS2GrSxlW/3LEce2E79lrob6kU82jnQTpePQ2QSMvfvryDhahMawa3NP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:124f:b0:ba8:2e68:7715 with SMTP
 id t15-20020a056902124f00b00ba82e687715mr2405214ybu.2.1686114122502; Tue, 06
 Jun 2023 22:02:02 -0700 (PDT)
Date:   Tue,  6 Jun 2023 22:01:47 -0700
In-Reply-To: <20230607050148.3248353-1-irogers@google.com>
Message-Id: <20230607050148.3248353-3-irogers@google.com>
Mime-Version: 1.0
References: <20230607050148.3248353-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 2/2] perf top: Add exit routine for main thread
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
        Andres Freund <andres@anarazel.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add exit_process_thread that reverses init_process_thread. This avoids
leak sanitizer reporting memory leaks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 99010dfa5760..c363c04e16df 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -392,7 +392,7 @@ static void prompt_percent(int *target, const char *msg)
 
 static void perf_top__prompt_symbol(struct perf_top *top, const char *msg)
 {
-	char *buf = malloc(0), *p;
+	char *buf = NULL, *p;
 	struct hist_entry *syme = top->sym_filter_entry, *n, *found = NULL;
 	struct hists *hists = evsel__hists(top->sym_evsel);
 	struct rb_node *next;
@@ -1227,6 +1227,14 @@ static void init_process_thread(struct perf_top *top)
 	cond_init(&top->qe.cond);
 }
 
+static void exit_process_thread(struct perf_top *top)
+{
+	ordered_events__free(&top->qe.data[0]);
+	ordered_events__free(&top->qe.data[1]);
+	mutex_destroy(&top->qe.mutex);
+	cond_destroy(&top->qe.cond);
+}
+
 static int __cmd_top(struct perf_top *top)
 {
 	struct record_opts *opts = &top->record_opts;
@@ -1357,6 +1365,7 @@ static int __cmd_top(struct perf_top *top)
 	cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
 	perf_set_singlethreaded();
+	exit_process_thread(top);
 	return ret;
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

