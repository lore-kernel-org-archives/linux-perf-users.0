Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910B0C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA6E61056
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhKDGrs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhKDGqm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:46:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1AC0797B3
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d8-20020a253608000000b005c202405f52so7510624yba.7
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c5kOW90u4xsq8H2QxSIbQc8Tz3TWyUWjUuTa0kkYcgQ=;
        b=W1LISV6K8ImfLN23kZIBLz/8oPp3a772noUSRVSCKrrGpHAy1ct1mxt7jj0ZDxSEfX
         MzP15U0SO8kxTuBMpBtS7ofoxYg/wbqeFI0e0kB//Lt2mofIpUlLxXecBJKaejSpxtDB
         W5Z0ZACdt4V/EWaF2eeX1jpdLWRXv3oqxkuRbuiSIZ2AIMQBT8sgN3n4IcYOrVEFOAkG
         p8Q4YWRyCZVLcy+7hq4NsurF9Yy2kCL6Rbcbdaxt2xTXeEJuhbagRu2ESLZQSdxzNIei
         FPjmQ/IWMuRBT3BXNV1zWqJDD1OK2soX5gG3jp/LlHug1ivtXjxNAOYgi+kxZhmlRKNf
         hwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c5kOW90u4xsq8H2QxSIbQc8Tz3TWyUWjUuTa0kkYcgQ=;
        b=dFj4tUfp1hy35VxwK3SXyfuDuauoszuh0MVpeSlyojE3ZCznVSj7YkBP0VkVikrxGb
         C3xAh7ZGZEuH+BDqEKEHRlYSUtT55daQ5V2xBdwX2qAknEqUiA4ugKDX9wTpn9AEtJuM
         5IGmc1EUg1UuBm3uJ0gYw2vccFE02TyC5hXspg5M2qhXqiUevZ80nsoOOQrk/Qk53fWC
         UKZQZPsyPPElzLwdQsJqGVvqxePEY06O0RxOuTUrPuZfIF71+6lMRWNpi5bSxCdtrSLB
         dbiq9fXf+GGo+BtQV5cwjhwjAukf1+LyFYwxIuRUWnIMeZcCSHjnxOLvtk0nhgX8dsm1
         3zfA==
X-Gm-Message-State: AOAM532ORBG1x0a/6+psb3HE89v1yCyV8lKNbdZ9dvKt2dUXyC1APbE+
        4CWZenEaj+hnbxRttRPBu8Ac0hOEJWfA
X-Google-Smtp-Source: ABdhPJzfR7lzk8qdPKBvdk/ijcyDoDO2weQwc7JLbwZob3YYP/lX0ibUYNQYdqJLaedYAoSl9tmRDCea42PP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:d386:: with SMTP id
 e128mr45990113ybf.176.1636008174311; Wed, 03 Nov 2021 23:42:54 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:42:02 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-17-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 16/22] perf test: bp tests use test case
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

Migration toward kunit style test cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/bp_account.c         | 7 ++++++-
 tools/perf/tests/bp_signal.c          | 7 ++++++-
 tools/perf/tests/bp_signal_overflow.c | 7 ++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 365120146d17..e4f7b635ffef 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -205,8 +205,13 @@ static bool test__bp_account_is_supported(void)
 #endif
 }
 
+static struct test_case bp_accounting_tests[] = {
+	TEST_CASE("Breakpoint accounting", bp_accounting),
+	{ .name = NULL, }
+};
+
 struct test_suite suite__bp_accounting = {
 	.desc = "Breakpoint accounting",
-	.func = test__bp_accounting,
+	.test_cases = bp_accounting_tests,
 	.is_supported = test__bp_account_is_supported,
 };
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 3c269f81818a..1676e3a11906 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -312,8 +312,13 @@ bool test__bp_signal_is_supported(void)
 #endif
 }
 
+static struct test_case bp_signal_tests[] = {
+	TEST_CASE("Breakpoint overflow signal handler", bp_signal),
+	{ .name = NULL, }
+};
+
 struct test_suite suite__bp_signal = {
 	.desc = "Breakpoint overflow signal handler",
-	.func = test__bp_signal,
+	.test_cases = bp_signal_tests,
 	.is_supported = test__bp_signal_is_supported,
 };
diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
index 5ac6e1393cf4..bc1f13851750 100644
--- a/tools/perf/tests/bp_signal_overflow.c
+++ b/tools/perf/tests/bp_signal_overflow.c
@@ -134,8 +134,13 @@ static int test__bp_signal_overflow(struct test_suite *test __maybe_unused, int
 	return fails ? TEST_FAIL : TEST_OK;
 }
 
+static struct test_case bp_signal_overflow_tests[] = {
+	TEST_CASE("Breakpoint overflow sampling", bp_signal_overflow),
+	{ .name = NULL, }
+};
+
 struct test_suite suite__bp_signal_overflow = {
 	.desc = "Breakpoint overflow sampling",
-	.func = test__bp_signal_overflow,
+	.test_cases = bp_signal_overflow_tests,
 	.is_supported = test__bp_signal_is_supported,
 };
-- 
2.33.1.1089.g2158813163f-goog

