Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19A9C38A2D
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Oct 2022 14:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiJZOKs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiJZOKs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Oct 2022 10:10:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EBD8B2D6
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Oct 2022 07:10:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-367f94b9b16so148381177b3.11
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Oct 2022 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oVCnLyxMsU2FaLl3D+PS+uuU9HLGod0PTLLsMzXQBPI=;
        b=MpZihCZI6V0d3vjHzoWFyZNUGKtaDmyQeeQjONz5yCsLwixNRtRYH8kVbw4IAj071I
         RtI5ylTTr0HmD103lHtW8GBjStpSSNk7D2IdMVsYQ4YozdkznqH/iHzaYWETb+Gb4s5A
         clqSzqiPC21fxU4gz1CciKwcJqKxXl6U66oOiuk6W/D6fsilKWyi7v/PxHeAQjRdQ0Yl
         4f194yEaUt9VdJlHvDFcDgIl2/GU9prcdlsKivsUZaYe/wLHWO3865s7Q2e79/zhVqKq
         42x/T7UNAP0Etik7BBFtJ8htlIYmUX4A55kRJXFgloxuG60P3M+tySMy5GQjuqin4mzn
         Y+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVCnLyxMsU2FaLl3D+PS+uuU9HLGod0PTLLsMzXQBPI=;
        b=6TuSC7IcTYjLB0x/xtsNmaVIj6ds9NSINz4YrAoAKiybLRUJTNUNdsnC5K39kDwnTk
         XtCRdB0euBm+LNJqt1yjpXOp/q7DiPbszmOHu9E0Eh+bFeKBFKapBf5kgRnwjWJqTf5K
         2wwRqU3JKC6uGlYX4WD/KpOcsQJ2hWLZbIoBcYrkLNXW7otQ+xVLjgUsjc9+bZ8VuC/+
         qTZU/jLmy2Zld2/wDhfBjaP5Ld1vYGt4dF+xcEm6s4DGIDOkUM3ztVADQAWh4V5MSbG3
         7e4DMtLDqwoyoCLRH6q4jAUQjUff4QqWP0VVG5IGtqsExGbMRKag7L69zAdcW5OaP8EP
         RnGQ==
X-Gm-Message-State: ACrzQf3SoR1p3wLzG9uigBctKlpq5CkEM1OAwQiu+qO/IMGQRkpsHnvO
        rg2Lusy7qPLrYaD6vo+JJZndmRCADmCCUg==
X-Google-Smtp-Source: AMsMyM5filAM/Pnh+qhZG7fTAorWRnmibQoVWzKGwKCoBdzpgJyDwpDWGy9Rm7JLRaju1rk5h1H22IP+svXzdg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:d857:0:b0:36f:c0f7:f0ec with SMTP id
 a84-20020a0dd857000000b0036fc0f7f0ecmr7838435ywe.82.1666793446446; Wed, 26
 Oct 2022 07:10:46 -0700 (PDT)
Date:   Wed, 26 Oct 2022 22:10:40 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221026141040.1609203-1-davidgow@google.com>
Subject: [PATCH] perf/hw_breakpoint: test: Skip the test if dependencies unmet
From:   David Gow <davidgow@google.com>
To:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     David Gow <davidgow@google.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Running the test currently fails on non-SMP systems, despite being
enabled by default. This means that running the test with:

 ./tools/testing/kunit/kunit.py run --arch x86_64 hw_breakpoint

results in every hw_breakpoint test failing with:

 # test_one_cpu: failed to initialize: -22
 not ok 1 - test_one_cpu

Instead, use kunit_skip(), which will mark the test as skipped, and give
a more comprehensible message:

 ok 1 - test_one_cpu # SKIP not enough cpus

This makes it more obvious that the test is not suited to the test
environment, and so wasn't run, rather than having run and failed.

Signed-off-by: David Gow <davidgow@google.com>
---
 kernel/events/hw_breakpoint_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
index 5ced822df788..c57610f52bb4 100644
--- a/kernel/events/hw_breakpoint_test.c
+++ b/kernel/events/hw_breakpoint_test.c
@@ -295,11 +295,11 @@ static int test_init(struct kunit *test)
 {
 	/* Most test cases want 2 distinct CPUs. */
 	if (num_online_cpus() < 2)
-		return -EINVAL;
+		kunit_skip(test, "not enough cpus");
 
 	/* Want the system to not use breakpoints elsewhere. */
 	if (hw_breakpoint_is_used())
-		return -EBUSY;
+		kunit_skip(test, "hw breakpoint already in use");
 
 	return 0;
 }
-- 
2.38.0.135.g90850a2211-goog

