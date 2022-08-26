Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE150ECAAA3
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 16:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbiHZQrO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344762AbiHZQq0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 12:46:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9D843E4C
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:45:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33e1114437fso33230157b3.19
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=taa3AgrUGklZBinkwVt0bQeh1ht8ynjIrx3kuUJRxJw=;
        b=RCSICxAMM6hk3ItMYtco0m9Sf6jGuFwmDEqz3qYYgbJ5Y6hKFjHIWnsaPtK2ZlXWFf
         GPwzXBHgxMvQkOEwxAPDe7t3hFITeGDkOPPmm/iJPxvDVVe1NwUHVvBMg9dJYHkgzuHJ
         gRuZAGzuxm5KQuJgcZ3b0xNoLUy2rDHQ/o767HC22XYfGYRdLMrgNzreWhw88pdnW/sh
         0mhfBarjKntwWqB7xZMoDTvvX7J9uPYAe2mIL+9O7YcLs/JHel+EtttxKzxYoLskXfcZ
         bBpcjMu4Bb/kLPmMIXlYgVvpsYlYdc8It4TMkF27UNF0Tc7IGyTfDZSkXy3KvaZQze2+
         xvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=taa3AgrUGklZBinkwVt0bQeh1ht8ynjIrx3kuUJRxJw=;
        b=K75Lbay56vty6+EYo6FiCM2u525r/2f88yDt+yFogG9IZLr4P1EoWAs46rew22Gtab
         vVXeafDQeS1ObhDLi5ZllsF1JVHpuIcrOTqRRQfIj52jA4BMNHjMWWPGqJoUU9B6gr5z
         JK3khF06l88iW4jANnHlPeC2aSWsdn87T9gZrLSnbNR/wxb8CuA4b8jo4MnjMiz6Fwzz
         eUohULDNlDow1K22AUJLlMTLqBl91TUkoNZv8T8MWGNpqDzT+2bEiXduITlscZ5nTnOl
         Jrwyink1CPqXcB1Jh2tsmd6iVuezwmSfuxYdXtJnZIIsoCBhJOIgrHTCtwM1AQ7cVXfa
         wMsg==
X-Gm-Message-State: ACgBeo24YPWi70UMydHTS9BrkT1/u5HwRUWKi6vx/ENd1UnQY9kIS+eQ
        Ndd31eJJ8s6tDDxAmwm5kLuEb/fEUroV
X-Google-Smtp-Source: AA6agR7ev6SqhADqDt5uLWdJHobeI3O4tugxHnBnZzIqU9aNAwe8a818CmiT0W42Jhsf3qgC2JcEr6Zr1uz9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a05:6902:549:b0:696:42fd:60aa with SMTP id
 z9-20020a056902054900b0069642fd60aamr464473ybs.575.1661532335547; Fri, 26 Aug
 2022 09:45:35 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:41 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-18-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 17/18] perf top: Fixes for thread safety analysis
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add annotations to describe lock behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5af3347eedc1..e89208b4ad4b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -196,6 +196,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 					struct hist_entry *he,
 					struct perf_sample *sample,
 					struct evsel *evsel, u64 ip)
+	EXCLUSIVE_LOCKS_REQUIRED(he->hists->lock)
 {
 	struct annotation *notes;
 	struct symbol *sym = he->ms.sym;
@@ -724,13 +725,13 @@ static void *display_thread(void *arg)
 static int hist_iter__top_callback(struct hist_entry_iter *iter,
 				   struct addr_location *al, bool single,
 				   void *arg)
+	EXCLUSIVE_LOCKS_REQUIRED(iter->he->hists->lock)
 {
 	struct perf_top *top = arg;
-	struct hist_entry *he = iter->he;
 	struct evsel *evsel = iter->evsel;
 
 	if (perf_hpp_list.sym && single)
-		perf_top__record_precise_ip(top, he, iter->sample, evsel, al->addr);
+		perf_top__record_precise_ip(top, iter->he, iter->sample, evsel, al->addr);
 
 	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
 		     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY),
-- 
2.37.2.672.g94769d06f0-goog

