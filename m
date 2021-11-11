Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54109C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 00:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383986124D
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 00:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhKKAYG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhKKAYF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 19:24:05 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A57C061766
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 16:21:17 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id i3-20020a170902c94300b0014287dc7dcbso2088058pla.16
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 16:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pZLvF3swF65tr680xW3DbjQ72llrP9QOOqL3Hi+z4nU=;
        b=jVL0lIDFTtCVQFeXxj87mfzq5lUJfFZ2geo4r6mrHIYRCBOjo/TFeUNSRSXFtOP1zq
         bXZNUh4tvfIfYcclZFwaUQXolrFtBgkaggTVL6KliZGDO3wlCKILXFp578F9ENfaloBu
         A8yy3i+6mf1C8tbN3GhbnesQIi9p3uQD9pZKilu91FOYIt6HuPt8w5uFqlhC//9pDOFD
         Aa77vo9u8T3F+Uny85npqKHCAlAKkRz/KdkcXPe/GAwN4Ig3XOv+48p4z6KOt+xvm0nF
         Db68sUS9H3hamSBPanjFHUrrJYiRKBJdG9Ri+s1e4dPHhlnx9LKmPcXIuRnv12qc9hjW
         LijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pZLvF3swF65tr680xW3DbjQ72llrP9QOOqL3Hi+z4nU=;
        b=wjtJKdV1Lb6804ETu0iuMYypMqj6XuRUIYoc1uXLo6vbgZiekaZKtwQifRSJXrrGMu
         ynan3imvifih1/B19bidmYO5Ih2TuqgNCnq8UrrVgKpeNUBS16msEbIpDrsuPvHlxsst
         byZf+f4Z0ULmAsU5MtkWAoBrXsP5rqujP4JuBpUpyG/UTuasat/DoD7YZsG0T2JpTRt0
         n96OkHvxCFTm+7ylrSWA3f0/bbFrkoONBcqaoCL1dqRoF7j/BY6Gn+/qo6MFwPhf635W
         eMjJUfMp8u5sEMMFgwqkZmJInjLjW2x8Em3E2cUfnoRTv7aRJLc4PLlopb0rDrAV4gzD
         Y81g==
X-Gm-Message-State: AOAM532DRO3IaBnMgX5b8zbcAKftIkS7S/O7rVgS23vGciRMSg4A97dC
        aqoCSA/FEuTPQ2J29qnQmaTrBxIykG0Y
X-Google-Smtp-Source: ABdhPJxm/9diRAvyEa1hNlXpwWsGhG1mxh9mmcVAGqXmFxTpBQCWvc/f8ms6Vyb97YWkuLo+df77HjipYgT+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9510:b6b5:241:e409])
 (user=irogers job=sendgmr) by 2002:a17:902:e548:b0:141:f4ae:d2bd with SMTP id
 n8-20020a170902e54800b00141f4aed2bdmr3169380plf.41.1636590076959; Wed, 10 Nov
 2021 16:21:16 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:21:02 -0800
In-Reply-To: <20211111002109.194172-1-irogers@google.com>
Message-Id: <20211111002109.194172-2-irogers@google.com>
Mime-Version: 1.0
References: <20211111002109.194172-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2 1/8] perf test: Add expr test for events with hyphens
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

An example of such an event is topdown-fe-bound.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 077783223ce0..9ee2dc91c27b 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -134,6 +134,16 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT2,param=3@",
 						    (void **)&val_ptr));
 
+	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("find ids",
+			expr__find_ids("dash\\-event1 - dash\\-event2",
+				       NULL, ctx) == 0);
+	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "dash-event1",
+						    (void **)&val_ptr));
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "dash-event2",
+						    (void **)&val_ptr));
+
 	/* Only EVENT1 or EVENT2 need be measured depending on the value of smt_on. */
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
-- 
2.34.0.rc1.387.gb447b232ab-goog

