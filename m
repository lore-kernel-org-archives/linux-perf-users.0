Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED0C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Jun 2021 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6B2613E1
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Jun 2021 18:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhFQSor (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Jun 2021 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbhFQSop (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Jun 2021 14:44:45 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DFFC06175F
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jun 2021 11:42:34 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id r190-20020a375dc70000b02903acea04c19fso2858742qkb.8
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jun 2021 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P2HhH8guhta86S5605kqN5Fpf4VPJ3qSwUq040gmRik=;
        b=RnWQmXgJd+ZC16mQntBSthlxeSP5ca9Ii4s+Yhqyatut7+iaz9MqeF+t2ipQxypPwj
         wHNg1IIfJUC/s69tD3+GRzAEtY21jdDJTBi/HG4C4Ey3c1zSHdb0ZJjzeL88Gs8GZboY
         QDx8rO81Ic2V+Bql6lvvtpqXPZ2GzZsZ5tiyPu05NDejj5P8dBzcOTTAq918VWdV8XpG
         sjkwP5F1atnfmddHdtQ82gedkNMTCnQQMA32vPRmsEPfJmVONsb3Tnno+BPuyu+DeljG
         hiiz/9TJdzR4fpMhOfk75uA6oppsI4MQy8PCf0yzeM7hoq8RfXzehYUuOE/mMzgLAzU5
         l/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P2HhH8guhta86S5605kqN5Fpf4VPJ3qSwUq040gmRik=;
        b=jTgTcs09jRj5Q6WoO/k3r0UcuYEeSnT+O29hELySU23TLqY66LysKwsTN24sT3F+D2
         9+moacmlY/U3My1plJsX9t4eNKYDTRgRwkqVS+npoH6PREPK15ACXcReBY7DOlEE2LE0
         tf3u4BCno9cF+Ai6hoxqOU5f7bJ5XxbpV+e48q7AZLDEWnr2nZN03/47JciDr2YMV72B
         O2Oi5xy6oOXmoh+qwvch4u12PlDG/m5y/O1N3RyKeuhRuAhMThJyroDeBBWujBgWz62o
         icPunlr2iJB/7psGfIME5JQO5fOnKEhEjaw7EccvgzoWpExbyFazHuKPWOZOG+Qe14d0
         OgwQ==
X-Gm-Message-State: AOAM5301dtQnP9imzEQlO3hEfTEcJtPP+rygYGTJP1ECfZWT7A/LlvuL
        kbCF5XDwA4ScJOAH7tonhc2/hOVHAmth
X-Google-Smtp-Source: ABdhPJzpOiTvkOQp/eLCOVbVooNjGST6jvV4yRj+qNFTjDSTcCx78tUUwFs1zh4lcm2s9a1yti7ljdeVtC/I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef90:beff:e92f:7ce0])
 (user=irogers job=sendgmr) by 2002:a25:be44:: with SMTP id
 d4mr8061096ybm.497.1623955353529; Thu, 17 Jun 2021 11:42:33 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:42:15 -0700
In-Reply-To: <20210617184216.2075588-1-irogers@google.com>
Message-Id: <20210617184216.2075588-3-irogers@google.com>
Mime-Version: 1.0
References: <20210617184216.2075588-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 3/4] perf test: Add verbose skip output for bpf counters
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

Provide additional context for when the stat bpf counters test skips.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 2f9948b3d943..81d61b6e1208 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -22,7 +22,13 @@ compare_number()
 }
 
 # skip if --bpf-counters is not supported
-perf stat --bpf-counters true > /dev/null 2>&1 || exit 2
+if ! perf stat --bpf-counters true > /dev/null 2>&1; then
+	if [ "$1" == "-v" ]; then
+		echo "Skipping: --bpf-counters not supported"
+		perf --no-pager stat --bpf-counters true || true
+	fi
+	exit 2
+fi
 
 base_cycles=$(perf stat --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
 bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
-- 
2.32.0.288.g62a8d224e6-goog

