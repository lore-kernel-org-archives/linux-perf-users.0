Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49ECC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Apr 2022 07:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343656AbiD1IBF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Apr 2022 04:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343638AbiD1IBE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Apr 2022 04:01:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F4332046
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 00:57:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p22-20020a254216000000b0064588c45fbaso3849758yba.16
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X9bgRRWSLcAukqJ4mLELbaH/aDHNmxGpnPZkabIKhXA=;
        b=We/v/+8dcLIwYYT/FRMRibij0dpEMbg7npNYMDlYQaqsPBdaFcfC7RfC+i/suk2Ll4
         3BPpw/+ONB0nmBN6br0J1w417y0sb6Qe4n4cbsDd2LXZLoN3BrMngZOp06hbfrH51/3v
         88vz9K8SWDkCsyKvIJAT74NngWDP/TM+sXKB/0unSK5Fb4V+pH+kpTjmidbWuM6Lx4gZ
         RRzQzXzxutIaJJRQZNJiU24fyNDYSG4wNz0IIdboJfg102ctIbdNBzz4BDY0SAfAiU0b
         OHm9MR7zmNHWrjAeFCyPt57uCNqirh4dmR7CHHdIxXr9IFVosfsPK9tXrrk4bw/xz00/
         /zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X9bgRRWSLcAukqJ4mLELbaH/aDHNmxGpnPZkabIKhXA=;
        b=bwXijt8J5P8CSgSJSzrXecyefumM3wjBh9Fcfpb9YJY7H+p4haqNM0rx9RDkBZ4C3e
         nt16zffG8m9LAksCjwJm+HSUu07xYX5qfjKEgTcc/8uEkrVVaCex0xUKO4avYLhATnF1
         iQ60TfAwow+EfA7p+syGje34G1CsYBICFrx5La3Xp6TQNsG3CJmy97Z4BgmzKlcFbxBA
         gPmajiY3kKNEHJUrSl0IbURWVwnnjQExidk7tVPZ6i+mGRigfaQL6+M5kCIN/mIFKG2I
         bTZjhqTbk6JOW3RvITxMvErvFcyu1/Titz3oJxkTUvNQAABrMUaRuj1MD1QWUsEwEbOP
         HLtw==
X-Gm-Message-State: AOAM5319RFE/54/OMAgA8biiZurOv+BqoUxMcNND/5iznsxQeh228bVU
        kceWYWrDys79YO8Vkydh6zN2yIq8XTm8
X-Google-Smtp-Source: ABdhPJzVTVFyue5D3sMnp/3yibmD5pXWptPH6nsDR2KhkoCq06whrpZ93n5G8eBsCkTszVH2ew2am2kAHTI9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:33c3:c9d8:c4fd:e75c])
 (user=irogers job=sendgmr) by 2002:a25:910e:0:b0:648:bdcc:ccc with SMTP id
 v14-20020a25910e000000b00648bdcc0cccmr10426478ybl.636.1651132668890; Thu, 28
 Apr 2022 00:57:48 -0700 (PDT)
Date:   Thu, 28 Apr 2022 00:57:30 -0700
In-Reply-To: <20220428075730.797727-1-irogers@google.com>
Message-Id: <20220428075730.797727-7-irogers@google.com>
Mime-Version: 1.0
References: <20220428075730.797727-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 7/7] perf vendor events intel: Update WSM-EX events to v3
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

Events are generated for Westmere EX v3 with events from:
https://download.01.org/perfmon/WSM-EX/

Using the scripts at:
https://github.com/intel/event-converter-for-linux-perf/

This change updates descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/pmu-events/arch/x86/westmereex/cache.json | 14 +++++++-------
 .../pmu-events/arch/x86/westmereex/memory.json     |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereex/cache.json b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
index 23de93ea347a..d6243d008bfe 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
@@ -1761,7 +1761,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
@@ -1772,7 +1772,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
@@ -1783,7 +1783,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
@@ -1794,7 +1794,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
@@ -1849,7 +1849,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
@@ -1860,7 +1860,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
@@ -3222,4 +3222,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/memory.json b/tools/perf/pmu-events/arch/x86/westmereex/memory.json
index a2132858b9c1..1f8cfabe08c0 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/memory.json
@@ -294,7 +294,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
@@ -305,7 +305,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
@@ -744,4 +744,4 @@
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.36.0.464.gb9c8b46e94-goog

