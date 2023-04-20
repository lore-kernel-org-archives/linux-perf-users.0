Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE2AC77B7C
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Apr 2023 03:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjDTDFL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Apr 2023 23:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjDTDFH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Apr 2023 23:05:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6377D2109
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 20:04:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 188-20020a250ac5000000b00b9265c9a5e9so1161697ybk.11
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 20:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681959881; x=1684551881;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nMmc/KlbuYeMq/Z3Xredsvu1q4ZNQYJtFaYT7UwiXmA=;
        b=FQwi8DGF5e18/2wqktG7R5RkrM/urfk0paKDLmJ9RvdeQfot7NaAO/1dcAIa5u/DYi
         tcfL8aVCnJTPIIp995aIRHUmOEWmxxuMRaL9i2FKSHt2ruMmiV3GP7IBGtR8zJjJ0qCF
         CtSOzt+FXFjQoJUVBHMlVib68f052q4EMXzM8ZW2fF7Bh8CzdTzyJ/WbwjXHIv3dC47Y
         vA64uPrXaAd9sgGfuCCYTXPJt5uh5k/nxhRbhcdR2yMpL+PMI1UHG40KT54Zu/o8SjMl
         bMHj1P5gpkUBIALDXmrqEtOWQhhJqBwA7wX1DPQSx94+FLEf86DRpxK55W0sPAoLbTOV
         8aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681959881; x=1684551881;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nMmc/KlbuYeMq/Z3Xredsvu1q4ZNQYJtFaYT7UwiXmA=;
        b=Qo8FagrmZdbB8wNSysCfmyXx71O3ftgcQhpG/zlhymMBFrVhGFviojiuJUrsDQWL3S
         kHiCa5DlrRf9c1Lpyh8LRfU2DOv0gJ89NoXaXeawuYAXdVU6gx2l1YT1BVhEj881L5LN
         h1MXbY+eiKOy6afymcNcf5N8eTDVOeZ3xoXLZYyJEyKRcLn13h7FR61omXSk+5p9Sm8+
         3IopudqwqY/1iayfKwmfu2bXVMhNeXZuvyZRVpIBUw31G4ijcFuVs0T68ALD7HBCUr5U
         AUhqK9hADS134oGC5OGjuXwGm7kKDYQTFEhOl19maYeK3zVJ2H+pFsT/9GL7AHf2OA0t
         U73A==
X-Gm-Message-State: AAQBX9cVfZrdbKZyjV2VsyWx6c8RqKqXriM0Qu/WLaITRu0eE7n1DVw4
        mUmvBJnPaSGBX8vdwEnu1pmJE1bc/+xB
X-Google-Smtp-Source: AKy350acUo1MHtQmoZw6L7dvVounIhubz8LpEUlGctZIwZc8viPees4FX6R42xU8rGj//Bgnb/vz63iAmqhF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:68e2:27cc:2137:73b9])
 (user=irogers job=sendgmr) by 2002:a25:3146:0:b0:b92:25a0:90d with SMTP id
 x67-20020a253146000000b00b9225a0090dmr89846ybx.0.1681959881697; Wed, 19 Apr
 2023 20:04:41 -0700 (PDT)
Date:   Wed, 19 Apr 2023 20:04:30 -0700
Message-Id: <20230420030430.489243-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Subject: [PATCH v1] perf test: Fix maps use after put
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix a use after put reference count issue. maps is copied from leader,
but the leader is put on line 79 and then maps is used to read the
reference count below - so a use after put, with the put of maps
happening within thread__put. Fix by reversing the order of puts so
that the leader is put last.

To explain the reference count checker, I wrote this up as a little
example here:
https://perf.wiki.kernel.org/index.php/Reference_Count_Checking

Note, the bug was introduced by the committer and wasn't present in
the original reference count patch set.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/thread-maps-share.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/thread-maps-share.c b/tools/perf/tests/thread-maps-share.c
index 75ce8aedfc78..858e725318a9 100644
--- a/tools/perf/tests/thread-maps-share.c
+++ b/tools/perf/tests/thread-maps-share.c
@@ -76,16 +76,16 @@ static int test__thread_maps_share(struct test_suite *test __maybe_unused, int s
 	TEST_ASSERT_VAL("maps don't match", RC_CHK_ACCESS(other_maps) == RC_CHK_ACCESS(other_leader->maps));
 
 	/* release thread group */
-	thread__put(leader);
+	thread__put(t3);
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(maps__refcnt(maps)), 3);
 
-	thread__put(t1);
+	thread__put(t2);
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(maps__refcnt(maps)), 2);
 
-	thread__put(t2);
+	thread__put(t1);
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(maps__refcnt(maps)), 1);
 
-	thread__put(t3);
+	thread__put(leader);
 
 	/* release other group  */
 	thread__put(other_leader);
-- 
2.40.0.634.g4ca3ef3211-goog

