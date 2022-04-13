Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73383C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 21:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbiDMVIb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbiDMVIR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 17:08:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D591D84EE0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so2716304ybg.8
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MKyIlb14kjoDwiTLRJoibK3zmQSI+f9RAOGtdQkGAb0=;
        b=iWk8MWfFdHQTF1RiR2YiO0cAhgu+ekxQ/RJcrsUoAJ8Ehnuf78lwlXuLPJH1cl79Wr
         71ibilE8ygIOj5S/4sjzDalWyaGjSQ9fCDItNRJUH46RpNBeQXikHuNUSEWJw64lqIGv
         7C68DUU4diBt6nyVAEvRtqEz+VqebyNRfZakHJyrEVlhs3p81miawyCF6ULOs82LGV9N
         YOxSMjMFUe+bvfpdnCywUx0qQbY8rByXJYvYgK7EkvIY2uPAPvtqPk4a/mDJwJnBA8vw
         f02oEeIrXYs/+IX9wXr/2hc74Fu1vgJgZzO9VlQmQN+C3BT5SJnWbIw0ThgHn6e2FRl9
         FWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MKyIlb14kjoDwiTLRJoibK3zmQSI+f9RAOGtdQkGAb0=;
        b=HxSzfAUQHT5WNYBHq+wh/IHEWJzjHgRg4Z/NK7Xa+SVyq4wjPetDYw83K+V4hDhbDD
         4i1xdOsXywht4Gt5GJdMJb0HSYTDoCmsV74Bb+xFf0q1uaimTQ9re3fA17vzFTE5Mnav
         xJc3iwtx1UZjdyY80LkQiSTdqpRLL2P5QXu5zavyhf1RZMeR+XYk5qjpRwEQDYD2EkBi
         sVovBsBDyUMdyi5GIIaxDHVgn/3FfoEOnAHh0VCU0OyxQetTVkz0CRaESXJwiXPfCTVY
         jy0KBG1ZpVinCJZTbkArTPx285a99AF9hfGSkYAWPEUL484Jzr5Dvc8VrqSElQ93ChIQ
         yskw==
X-Gm-Message-State: AOAM532iU0yEpfVPpgkEOw1HGif3fT/x53q2RCS/fOg+bf6hmZL8RoeO
        hRNHAtlfAC04CTfv3t6SnayWu8VNt7+p
X-Google-Smtp-Source: ABdhPJxFqsuZ6qMuWLSeRtUQRg/LfuGdgV/QufIDf5GSiSd5CLkIj5yGvBrbm/lcWvEEsHtncDU2IpYzlR7h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a05:6902:13c1:b0:61d:969c:109c with SMTP
 id y1-20020a05690213c100b0061d969c109cmr675962ybu.133.1649883934046; Wed, 13
 Apr 2022 14:05:34 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:05:01 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-12-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 12/14] perf vendor events intel: Update elkhartlake event topics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Apply topic updates from:
https://github.com/intel/event-converter-for-linux-perf/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/pmu-events/arch/x86/elkhartlake/other.json | 13 +------------
 .../pmu-events/arch/x86/elkhartlake/pipeline.json   | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/other.json b/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
index de55b199ba79..8692d4847476 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
@@ -1,15 +1,4 @@
 [
-    {
-        "BriefDescription": "Counts the total number of BTCLEARS.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xe8",
-        "EventName": "BTCLEAR.ANY",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the total number of BTCLEARS which occurs when the Branch Target Buffer (BTB) predicts a taken branch.",
-        "SampleAfterValue": "200003"
-    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event BUS_LOCK.SELF_LOCKS",
         "CollectPEBSRecord": "2",
@@ -180,4 +169,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json b/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
index 31816c6543a8..c18acb422145 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
@@ -153,6 +153,17 @@
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
+    {
+        "BriefDescription": "Counts the total number of BTCLEARS.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xe8",
+        "EventName": "BTCLEAR.ANY",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of BTCLEARS which occurs when the Branch Target Buffer (BTB) predicts a taken branch.",
+        "SampleAfterValue": "200003"
+    },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
         "CollectPEBSRecord": "2",
@@ -516,4 +527,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.36.0.rc0.470.gd361397f0d-goog

