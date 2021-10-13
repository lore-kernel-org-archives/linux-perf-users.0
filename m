Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AE8C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5C9610C9
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbhJMRut (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbhJMRu0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:50:26 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28B6C061788
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:47:12 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y8-20020a05620a09c800b0045f77ea0f98so2442759qky.23
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xteZMpZdkPkQ7I7Ombo00Pf+flGo+AinDwwB1uosPNQ=;
        b=VDCU+mVLaUNE2BviVcFOaL/SUFeBqp/jgWZ+hRr8hWon19Vg93Np4//HtbEp0Y6Pca
         vGEk56qLeG3QCjOr8q3jgqihrbv6WMSwaY8AZWbTReplVbcVv+aQpBKhJ6KG+86Stow5
         66OtIBgWlguJr8qTFA+OTpWyo4PCKFbzrnrYkH1alEhrYhVSKl7Q8tCBVDsBA4SpHgnl
         kh1funwC7Q56ki6wyf45jZ/GJTv1qyawv5VUzpD1mgY08LafGN8f+7MFhmjpV2FoIj4v
         iI9MeMB0s19XT4jwmj9dhse8pRjY3Wrd+osVEYYaPzW2LshI1+igx3bs4w4uv823VUEe
         W7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xteZMpZdkPkQ7I7Ombo00Pf+flGo+AinDwwB1uosPNQ=;
        b=GKBzjzgNI83m4BIsv7Pp8ku2sT+auHdEIXXdp8hnv/zEn+pHynRdpHq8wOGQkpJ+S3
         Lae9PrWYqq8aWIn4atQk5GWW41tVdbn2XI19PzTAGSiIpSzNb/9dX9Y7KCQFHAfJpZ1G
         skhJuguEbNjPUdP4hgOG1dhhfbmsWbwyUw7GQ8KUl7nhm6Qexr+XuwzwVSMzk0Js3Hx5
         Ens3U1trJsbIxUPEtNaA16B7+jTuKopNdctuMwMV0Qm/Y4H9V2KCyNvDJifRWaPnO37B
         OO9ZYbAA4NwSnxycftXur+/IjN7EScMAZ0XR5bA9brTFthEZSvbhmXpBDHlF2hE1Jpyg
         X9wA==
X-Gm-Message-State: AOAM533zUWvjA47lGbbpWX4c0fiwPEzJIly+8b27cuUfsWWPYMjOhTh9
        Tl9nOMGZdLgRyQP0O7DjhJ6aeF4thQCw
X-Google-Smtp-Source: ABdhPJygyjSno8v6AOSiQqo4BGL++Bxd06BmFoAtjd6Bo9wO5UbMr+M8YZUh1sMam+G9PXkZHgng2WpinWhe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:ac8:5f54:: with SMTP id
 y20mr836208qta.324.1634147232095; Wed, 13 Oct 2021 10:47:12 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:46:03 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-22-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 21/22] perf test: Remove is_supported function
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
        David Gow <davidgow@google.com>
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
index 966948cacba3..086641f60015 100644
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
2.33.0.882.g93a45727a2-goog

