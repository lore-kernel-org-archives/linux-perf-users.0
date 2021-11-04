Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E07C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E602B60EB4
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhKDGsN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhKDGrZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:47:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43119C061226
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:43:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s189-20020a252cc6000000b005c1f206d91eso7437832ybs.14
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bDa29u/ndiNsX8EwvAxzBRsCHsm6XVJUwsCYIKbSYNU=;
        b=IeiSouheZYR16SzpZCnr7kTmgjl/G3L1ef4UnCnaz2hsyEQJh1ffEQrLq2e291JS86
         sCLewRsA4/bjaTppf6Jhl7uuwm1Ou5F6fClQwkXUys+7NIP64vyORjrBHOq2RfzgsXiK
         sVvX1ZPBT5txYECtczP2zjNVOMHurK/NFMWXoBJzS7tBGPU4mEMfcchIWDuz0PB1axmd
         G7Clb6qHRm5wZRCmtXOvp0RypZVLYU/dAJwict8M9NLdCoJgCbC0RxgkRk5ZIddHN1GM
         pubcayEHKH4+C501/7fKBhY5fBM0B9Facf0WebWhhpr/HgpHFEMOQWzhzClk+Z65atQw
         L0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bDa29u/ndiNsX8EwvAxzBRsCHsm6XVJUwsCYIKbSYNU=;
        b=EhwzYGDPmIKpWJRqIfCbSPX7BwDQaVomUZr9Db4lJK42lU4V4Br+2Q7OPho9Zs1qxZ
         VtU98s6wbQljsdX/RA4zo/2ZESNhViTePaU36RDAPSMOnTdP8tLXhdWo+zX6h1t6iHxK
         P1Ov7z5t/syDyb3ch8pz/wx5TmmwnRyvcNdDbvgCPEsrZ4hStlLEPfKrK6ZYxECC93cj
         3ZPUzjWFD4zMeMiPrqcPj9392W87kTdVNM6zC1xdkTbXIcp6RsMVmTSV9JECt8XYrKfA
         E7ZDjGO9Xaw2604QZdDVCjPyHIpwkZtgFCgw0Mhk/ZSZrHmn82OW+8gUts1v8KEaF5xM
         tSGA==
X-Gm-Message-State: AOAM531L6hdoglJZn/on3Db9FhA2lcSOb6oW7bVQnxhhratoLdp+9OFP
        +KPyfU/ln95OlrG/rSGiKnx2jAOGFdNP
X-Google-Smtp-Source: ABdhPJzndUDGPLfkemYeioDan06akCfGJJPe/2rXbIlDxIfa4XKvX4RtvrWTGD1s98JS3x6DpkbT/I2oLYKg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:2bc1:: with SMTP id
 r184mr52349373ybr.44.1636008186470; Wed, 03 Nov 2021 23:43:06 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:42:07 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-22-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 21/22] perf test: Remove is_supported function
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

All tests now return TEST_SKIP if not supported. Removing this function
brings perf's test_suite struct more inline with kunit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 14 +-------------
 tools/perf/tests/tests.h        |  1 -
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 1d9c0e03b8db..19b1228dbd5d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -150,11 +150,6 @@ static const char *test_description(const struct test_suite *t, int subtest)
 	return t->desc;
 }
 
-static bool is_supported(const struct test_suite *t)
-{
-	return !t->is_supported || t->is_supported();
-}
-
 static test_fnptr test_function(const struct test_suite *t, int subtest)
 {
 	if (subtest <= 0)
@@ -480,12 +475,6 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 				continue;
 		}
 
-		if (!is_supported(t)) {
-			pr_debug("%2d: %-*s: Disabled\n", i, width,
-				 test_description(t, -1));
-			continue;
-		}
-
 		pr_info("%2d: %-*s:", i, width, test_description(t, -1));
 
 		if (intlist__find(skiplist, i)) {
@@ -583,8 +572,7 @@ static int perf_test__list(int argc, const char **argv)
 	for_each_test(j, k, t) {
 		int curr = i++;
 
-		if (!perf_test__matches(test_description(t, -1), curr, argc, argv) ||
-		    !is_supported(t))
+		if (!perf_test__matches(test_description(t, -1), curr, argc, argv))
 			continue;
 
 		pr_info("%2d: %s\n", i, test_description(t, -1));
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 958f94dcc94c..15051801c790 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -44,7 +44,6 @@ struct test_suite {
 		bool skip_if_fail;
 	} subtest;
 	struct test_case *test_cases;
-	bool (*is_supported)(void);
 	void *priv;
 };
 
-- 
2.33.1.1089.g2158813163f-goog

