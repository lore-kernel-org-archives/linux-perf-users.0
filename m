Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3060FC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 May 2022 21:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348090AbiEKVPm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 May 2022 17:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348091AbiEKVPj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 May 2022 17:15:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3BB2297CC
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 14:15:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e22-20020a25e716000000b0064b3228da96so3018038ybh.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3xLzWp+VN8d56IUKCn+oZgvctc6ILOg/P6G2GbPqdKc=;
        b=dl8LQGes7r1hH8OcBJa0NGV2VHTyVgZD+LW0/OHTklDf6ig6eWlO9YR1hC/Ma/aWjJ
         ETxvHeLFQDQlnu/Ij6BbXBZ1aWObJbq4DayI8uquB+6fPiZlAnCc8KDTAQd84VlVZ2cD
         zY/NMC1MD+ge5bv1Se+UgGS9iycBhdyhr08jLQrBZ3o4y9wnPbsY56Z0LOw7dl1kPZka
         8bQmGmUEpLWgQMTHAKG2PVITC0ykuggUqvtCiINF2uojg5kGIuGhZ6xwgvzhiTiKJJCv
         p7diB2z6koThd8IOpgJzaaBsdJds9cmsofRq6yMJFlyADgAAYEUxRObQ3Sh3rrQbFoRT
         zplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3xLzWp+VN8d56IUKCn+oZgvctc6ILOg/P6G2GbPqdKc=;
        b=q1a/n2xBbaMbZYtQy8Qpq9LXPJx7eu39CFUzO7XNX0Gj49fnQGIV/6Jr31csvhrpj6
         d7u73ardX1jz86aCaM/kXd3ZvMTVVb1domBEHIfhvyJOM2/rspQEu4TYWwaNP35luqz7
         KwlCL0c+gCpap6TuITsL3xkjZihinoBuvaW4vr9zWPtal7GRkIqM8NQlKyXzRYkc47zS
         NsorymnAEALqdjstgVWD17dWoqMXLzQBkwwD7a04DhOLOJwaED24r888+xAdrDdnX5oU
         hTAPSv971dNmuY1iTnKw//vCGD78qm5o+q8VNs9hwSrSCxGJjOpenqWnTmL+R01+ITFm
         yP0w==
X-Gm-Message-State: AOAM530+XbllyqVU5lslaLznqJUIObOs6fCcc8TmoVvgYcnZ8WKZrG6v
        4VENnvuZVWs7GR2JlAjejoiBe6Z8FXvL
X-Google-Smtp-Source: ABdhPJwGtrK4HSvNynwdwG7NP9NqdRLU2gZuHv39m5Yh12xvN9S0anWrDsxZ5okvMLU+KIEflN8rSWyRSdsF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5993:294b:7b62:54cb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1009:b0:649:70c3:319e with SMTP
 id w9-20020a056902100900b0064970c3319emr25242529ybt.388.1652303737031; Wed,
 11 May 2022 14:15:37 -0700 (PDT)
Date:   Wed, 11 May 2022 14:15:22 -0700
In-Reply-To: <20220511211526.1021908-1-irogers@google.com>
Message-Id: <20220511211526.1021908-4-irogers@google.com>
Mime-Version: 1.0
References: <20220511211526.1021908-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v2 3/7] perf vendor events: Fix Ivytown UNC_M_ACT_COUNT.RD umask
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The event had two umasks with the umask of 3 being correct.
Note: this change wasn't automatically generated as there is no CSV for
Ivytown uncore events at:
https://github.com/intel/event-converter-for-linux-perf

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
index df4b43294fa0..e8917cb59566 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
@@ -5,8 +5,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.RD",
         "PerPkg": "1",
-        "UMask": "0x1",
-        "Umask": "0x3",
+        "UMask": "0x3",
         "Unit": "iMC"
     },
     {
-- 
2.36.0.512.ge40c2bad7a-goog

