Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2A1C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 04:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiEREUx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 00:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiEREUv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 00:20:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795E83123F
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:20:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m136-20020a25268e000000b0064b233e03d1so883341ybm.14
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MAjYUcMF8cvSpD3IrXmmGZ0bseIJMHTYZTi0/EOkzbY=;
        b=hv3dMBW1DzxUFqDSoqbUa/6gJniNJqbIIJNdZQcmA7P+ITyZmLb6I5NNftuPGDYfGW
         okMSyVlMbNG3+WuXeFKmZQs4JS4kvG9SmunFGg6AvF1NQVTEiLeA8wNRh+wmBTVlB3v4
         iF4940Rek9QdNEqLGRRe+xga0x1HVwIJWCmmDepx2hLrScQOcbl+Kg6jkBTPjuPMoqS5
         FZSRfzmxjAuIoRWS8Pt2+M/ImhPMQ0MLNojnqR1RHXD8bFKa9hGQ1iC2XIIKLE4OuLkE
         km7Scd7JnQ7jbphbMcPhJk+uiojuwneha8rMzg0EFkY6rGZR5rNAdC/cqDaFMglmH5rw
         anUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MAjYUcMF8cvSpD3IrXmmGZ0bseIJMHTYZTi0/EOkzbY=;
        b=taLZzu6Yg7Vmz8bbJbYpzCFwkuEKJ5PUPcId2KorcsUMCbIilqLtHqsUA3KZicdSEU
         EGjSydICgzaX+QtK4ztBJ7XR5Ny14IANLgflUEOozjaN/35lX8yRaevHK5O9iYMOspPa
         Z3IodjlSTQ0dTgVSR1N29XSHJ3LwsCt63BU1bkkUu4ptVB6dcUxVOiuIVaaxzREjRMhI
         iPbQaMCTMCqHKRj0o5GW9+mli5nBcrq74ZJ00l+YkqEW66kd1KvPDiaucPBVzakPSwtf
         6WV1DMTtiOP5LP7FeeZES/F9E3rq0B3luPzwNxNnX2DnFKWBu9TwuqzzLEJgF1VL2FRe
         2Puw==
X-Gm-Message-State: AOAM533XoovEQcKvbwGvm+fBHB81Ahni2wG0juHM+xBpHrKLHe0rEPsB
        SnS6GczgTDrwoDnqG0bf/GlYeNnGxTHE
X-Google-Smtp-Source: ABdhPJz/Y25em1LQBTduunNiZnS002a0H+EyC5tCC0TQ93KtFWaUz8g3VoSCuofQQQbf9zZEVQ5oPizqZzlx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:c7d0:0:b0:64d:a15e:7599 with SMTP id
 w199-20020a25c7d0000000b0064da15e7599mr13472934ybe.251.1652847644539; Tue, 17
 May 2022 21:20:44 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:24 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-6-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 5/8] perf test: Parse events tidy terms_test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Remove an unused variables. Make structs const. Fix checkpatch issue wrt
unsigned not being with an int.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index e71efadb24f5..7e802666d2d5 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1980,11 +1980,10 @@ static struct evlist_test test__events_pmu[] = {
 
 struct terms_test {
 	const char *str;
-	__u32 type;
 	int (*check)(struct list_head *terms);
 };
 
-static struct terms_test test__terms[] = {
+static const struct terms_test test__terms[] = {
 	[0] = {
 		.str   = "config=10,config1,config2=3,umask=1,read,r0xead",
 		.check = test__checkterms_simple,
@@ -2112,7 +2111,7 @@ static int test_events(struct evlist_test *events, unsigned cnt)
 	return ret2;
 }
 
-static int test_term(struct terms_test *t)
+static int test_term(const struct terms_test *t)
 {
 	struct list_head terms;
 	int ret;
@@ -2139,13 +2138,12 @@ static int test_term(struct terms_test *t)
 	return ret;
 }
 
-static int test_terms(struct terms_test *terms, unsigned cnt)
+static int test_terms(const struct terms_test *terms, int cnt)
 {
 	int ret = 0;
-	unsigned i;
 
-	for (i = 0; i < cnt; i++) {
-		struct terms_test *t = &terms[i];
+	for (int i = 0; i < cnt; i++) {
+		const struct terms_test *t = &terms[i];
 
 		pr_debug("running test %d '%s'\n", i, t->str);
 		ret = test_term(t);
-- 
2.36.0.550.gb090851708-goog

