Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B785C48BE5
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Jun 2021 18:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E8116140F
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Jun 2021 18:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhFQSoj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Jun 2021 14:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhFQSoi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Jun 2021 14:44:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60663C061574
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jun 2021 11:42:29 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y5-20020a37af050000b02903a9c3f8b89fso2873833qke.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jun 2021 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZlXcWG52LpPBNrp8iFYVpN63n0II1sNMyDIazVtXK6g=;
        b=WqCCDit+fwpG7RHerB83fx97SNuOWrBI92BhNuoDyIQiJqzVSqTV3pt0kQ07mP3Rwz
         NtGndorgHcF1qcgrnbzf/QK1bKl9karIOVU/Zpy1FCTNSiBk6gbbCdkmzGi07JpQVMHO
         xR0Lwf6XbXHCWulBVj1WCmH05CoTvHL8gNdpBya6SByiF6jAr4Omvo/G5rYeUBENj7Pz
         ifageJWCezrnSGf1aQbUhaIiWhfJRkqG74iYxj5RMBTzgg0oAMkONhYU1ZrK+7XMUokT
         91x2i3fCwAnPnu7rHCH8ypV3QPfvtOfntuzcsFg83jcg5PgGPocbCq1XakU6Tm6tUskA
         eszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZlXcWG52LpPBNrp8iFYVpN63n0II1sNMyDIazVtXK6g=;
        b=mdIdvlBwruhD1jarG+m1ANKaynHY9rQ9jHeSDnG5USeWcAvknr+Jpjv3NqElS+tvNG
         wlwuLwg0MPbPCmb5/7fEHcxjhQqe/iXvyEdmKzkY0OY8WVOVzc1yiGuM9DZoLUcoSGoV
         B7G1nY8KYx/DG++JYG4fdRvt1Mi/+RspP0tq5kWtCVHWjF41ccyrpog/Jv64sSNiGpaw
         8McdlYcCnBdx217cmJnmkycyjpjTjLdO/lkT5a0rzPSNBM0c/pkBPp4jame/FBUgn0nZ
         58OwMIe00GwRIyQJGIrkEIm6ET9++tH06xVwAiFEldJt6MX32aNGuWdTbjmQbU4NCEwo
         5C7w==
X-Gm-Message-State: AOAM531wCFqjaiL2hlp3b3odtL+pWvo0GuqgKRclAm3/ONya8wTLKHKq
        Azp43A7lmq5DRmCs9Bcv/GQmR41Dr/6J
X-Google-Smtp-Source: ABdhPJwew74OmEVaWxaFf7DCKZvVPSy8SzWjiBZiMsqU3WWiBEam74KB2f3Je5RJeGnqbDXadOITpsveRIHJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef90:beff:e92f:7ce0])
 (user=irogers job=sendgmr) by 2002:a25:ca45:: with SMTP id
 a66mr7969252ybg.10.1623955348375; Thu, 17 Jun 2021 11:42:28 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:42:13 -0700
Message-Id: <20210617184216.2075588-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 1/4] perf test: Fix non-bash issue with stat bpf counters
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

$(( .. )) is a bash feature but the test's interpreter is !/bin/sh,
switch the code to use expr.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 22eb31e48ca7..2f9948b3d943 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -11,9 +11,9 @@ compare_number()
        second_num=$2
 
        # upper bound is first_num * 110%
-       upper=$(( $first_num + $first_num / 10 ))
+       upper=$(expr $first_num + $first_num / 10 )
        # lower bound is first_num * 90%
-       lower=$(( $first_num - $first_num / 10 ))
+       lower=$(expr $first_num - $first_num / 10 )
 
        if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
                echo "The difference between $first_num and $second_num are greater than 10%."
-- 
2.32.0.288.g62a8d224e6-goog

