Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87756C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7058860EB4
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhKDGr1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhKDGp4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:56 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D531C079785
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:52 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id j6-20020a05620a288600b0045e5d85ca17so4029839qkp.16
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uhMKrCNfPxQ2Zcf5Vkl+HNKM9vie+osD+kw0v1/wntc=;
        b=fRD6pPnhXQjYDgk64XZQYo4g3gb7eA/+1u37deVGGWIAbtp9nAGrA+hajH3CUuaWu0
         Im8k2jipHGJl49zo1qi4RTg2sQMqKo//rfdgSo8etlrlmKSBhcUKI226CGUargNt3EGc
         8edyLdQwEsIPVkKkd6Jh58N9l4PhuNqhFv325rboL4zKR2mtyo/gr/R52fWAVC/DPw95
         zsrBnYhIEys7E/ZakY9PDvtQ05e5poqXQ6zVXofgqLBU7TxwAapHy+cPqfg7Y7UG0sHQ
         rOCc/z0FncROnfJ7OTke6XEcLA5+ZJsoO6+17NdJN/f57/gE6ftXsGRohfKiySWsRWKH
         HuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uhMKrCNfPxQ2Zcf5Vkl+HNKM9vie+osD+kw0v1/wntc=;
        b=Q6Drf6QkYAuudPk0suMwYSRrBAYhpyOVQYRCj+gVi9GNF5i+XrHpsEGzkpYrVdjpmM
         MWIGxNourtdg1bMN4TDE6vnzX44LtA/0keo23h0WLmdP4et60QDCZklfb9tAjsmGrDAK
         tGoL/xo+S7wdwjCq88pp6WmueaA7rTCJaNX+rpt0Hh7E2Zap2eEZgXX7J9QurK2FVHuw
         qAVVb6qt5C6C+/fdLhH2Un+YBR4ZbpKBVuIT4LBff+6FwwndvUUgjy3djLIIR8I6esSB
         QE4u1eRbaGxaouRokxn7srEA5jGOoTBxFFvr194JnQ/xbSjLX2jV4HUizOxKAMrspgGZ
         GioA==
X-Gm-Message-State: AOAM530WDtUUdwiIaiQPgFtXcZKHgLk5rZeWVwz4EaNq1yewIOJ3GvjE
        g1CzF+GtmaTNYjiFjDh1cLbLmtO6erko
X-Google-Smtp-Source: ABdhPJwaj3qyP2mK2LcR/ElV51GawChsbXR3N0ewLz5rH02YbJX34yU3SyyaJ6tuw2uTlabymcCkRIZmMtyv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a05:622a:50b:: with SMTP id
 l11mr51313937qtx.415.1636008171638; Wed, 03 Nov 2021 23:42:51 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:42:01 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-16-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 15/22] perf test: Remove now unused subtest helpers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Replaced by null terminated test case array.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 11 +----------
 tools/perf/tests/tests.h        |  3 ---
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index db76d7d10749..62e97faa90f0 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -119,9 +119,6 @@ static int num_subtests(const struct test_suite *t)
 {
 	int num;
 
-	if (t->subtest.get_nr)
-		return t->subtest.get_nr();
-
 	if (!t->test_cases)
 		return 0;
 
@@ -134,14 +131,11 @@ static int num_subtests(const struct test_suite *t)
 
 static bool has_subtests(const struct test_suite *t)
 {
-	return t->subtest.get_nr || num_subtests(t) > 1;
+	return num_subtests(t) > 1;
 }
 
 static const char *skip_reason(const struct test_suite *t, int subtest)
 {
-	if (t->subtest.skip_reason)
-		return t->subtest.skip_reason(subtest);
-
 	if (t->test_cases && subtest >= 0)
 		return t->test_cases[subtest].skip_reason;
 
@@ -153,9 +147,6 @@ static const char *test_description(const struct test_suite *t, int subtest)
 	if (t->test_cases && subtest >= 0)
 		return t->test_cases[subtest].desc;
 
-	if (t->subtest.get_desc && subtest >= 0)
-		return t->subtest.get_desc(subtest);
-
 	return t->desc;
 }
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f87129b63d92..9bf448f7429a 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -43,9 +43,6 @@ struct test_suite {
 	test_fnptr func;
 	struct {
 		bool skip_if_fail;
-		int (*get_nr)(void);
-		const char *(*get_desc)(int subtest);
-		const char *(*skip_reason)(int subtest);
 	} subtest;
 	struct test_case *test_cases;
 	bool (*is_supported)(void);
-- 
2.33.1.1089.g2158813163f-goog

