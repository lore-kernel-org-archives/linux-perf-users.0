Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0FBEB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 15:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjFWPMI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjFWPLX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 11:11:23 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B77A2D7E
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:10:59 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-25eac66423dso561472a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533051; x=1690125051;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpmMqADQMWGgQwCwK+rLV+M/fmB9R42OKi4G7A8TKP0=;
        b=cTyv4QNQw/qNRq6i0Y5jnAZNAjaifK4IhbAlHvv/LNO7ugdljWn7ivYaFae1ucBXyr
         ydE9pg5VmWsTuPP7US4dywtxEQYjO6WUf6YjGUj4QgVxgy0htavegZUSytR2FJTy8/9a
         opFdCsOX9xEzD1AgcCGxAnh4yk5pW9vrmmsu1saXXYhuZH+7n3/AjtzdmYDlSVl7iZs6
         WqBUCr8mb1NeGN/Hj7Urml4kQ0Tiyq3JI95vormYSOWZ3NaspBBNEKLBkecoFgeKsKjU
         2bwZ6ALZC7PyVRqq88N5+cpAVL/ib6UG0EZkG1CqJBEnNduNMFvEHAhD33FOiOWJPaXA
         Nl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533051; x=1690125051;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PpmMqADQMWGgQwCwK+rLV+M/fmB9R42OKi4G7A8TKP0=;
        b=IY3DcltPP+EK67i3pHUv2ggBlLgRXYTOopQh/89cm2xrxLW5fjpz5VIQZe2vOArKmz
         O8Wv/jdagMMj/Pg1B+X80LY/4Opy0/z/vew5XbwgQ+fUPw/lIJkxJ1Dwu57IlBH9VSs7
         rGxwAcoE07yOI7cy/S4lpfWT1n3L5K4jfya9IpNLyIq2/vGWGUOduq367tZ5YXvgcyJR
         gylYNrYjuLk80bR7G20k2LZAzxo7DK12fQ0Zf3qNjZ+gM92FENjmogyXrivFCglUGh/2
         HwmQRSwH4FOifK+bDOv+8GEXaSeB6qPPr55jo8c4O2Un1aZ8G4Zda7v6MsevzIzQan+Y
         yZZw==
X-Gm-Message-State: AC+VfDz/nJfrsDwBeSbe1ldZPCKg0DJb6U2VoqU7xd+zHygd9mTNKO/x
        H8ovzb8QrRg56gNCyZheIg4iSidFzWXU
X-Google-Smtp-Source: ACHHUZ5X62eFvERwa+Q4pq3p2hb7vhFBLQBjOE3eWsvjoKiPTJyBEr+GISvtpyfkkmiS7v4D0N8G3sLrtXhY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a17:90a:cb06:b0:25b:f973:f944 with SMTP id
 z6-20020a17090acb0600b0025bf973f944mr2967981pjt.3.1687533051089; Fri, 23 Jun
 2023 08:10:51 -0700 (PDT)
Date:   Fri, 23 Jun 2023 08:10:11 -0700
In-Reply-To: <20230623151016.4193660-1-irogers@google.com>
Message-Id: <20230623151016.4193660-8-irogers@google.com>
Mime-Version: 1.0
References: <20230623151016.4193660-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 07/12] perf vendor events intel: Update icelake to 1.19
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
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Updates were released in:
https://github.com/intel/perfmon/commit/f3d841189f8964bc240c86301f4c8498456=
30b5b
A number of events are deprecated and event descriptions updated. Adds
events ICACHE_DATA.STALLS, ICACHE_TAG.STALLS and DECODE.LCP.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/icelake/cache.json    |  8 ++---
 .../pmu-events/arch/x86/icelake/frontend.json | 32 ++++++++++++++++---
 .../pmu-events/arch/x86/icelake/pipeline.json |  6 ++--
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelake/cache.json b/tools/perf=
/pmu-events/arch/x86/icelake/cache.json
index 79b9f02a4b63..d26c4efe35f0 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/cache.json
@@ -155,18 +155,18 @@
         "UMask": "0x21"
     },
     {
-        "BriefDescription": "All requests that miss L2 cache. This event i=
s not supported on ICL and ICX products, only supported on RKL products.",
+        "BriefDescription": "This event is deprecated.",
+        "Deprecated": "1",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
-        "PublicDescription": "Counts all requests that miss L2 cache. This=
 event is not supported on ICL and ICX products, only supported on RKL prod=
ucts.",
         "SampleAfterValue": "200003",
         "UMask": "0x3f"
     },
     {
-        "BriefDescription": "All L2 requests. This event is not supported =
on ICL and ICX products, only supported on RKL products.",
+        "BriefDescription": "This event is deprecated.",
+        "Deprecated": "1",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
-        "PublicDescription": "Counts all L2 requests. This event is not su=
pported on ICL and ICX products, only supported on RKL products.",
         "SampleAfterValue": "200003",
         "UMask": "0xff"
     },
diff --git a/tools/perf/pmu-events/arch/x86/icelake/frontend.json b/tools/p=
erf/pmu-events/arch/x86/icelake/frontend.json
index 3e3d2b002170..2b539a08d2bf 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/frontend.json
@@ -7,6 +7,14 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction. [This event is alias to ILD_STALL.LCP]",
+        "EventCode": "0x87",
+        "EventName": "DECODE.LCP",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk. [This event is=
 alias to ILD_STALL.LCP]",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE transition=
s count.",
         "CounterMask": "1",
@@ -213,10 +221,10 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss.",
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss. [This event is alias to ICACHE_DATA.STALLS]",
         "EventCode": "0x80",
         "EventName": "ICACHE_16B.IFDATA_STALL",
-        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The legacy decode pipeline works =
at a 16 Byte granularity.",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The legacy decode pipeline works =
at a 16 Byte granularity. [This event is alias to ICACHE_DATA.STALLS]",
         "SampleAfterValue": "500009",
         "UMask": "0x4"
     },
@@ -237,10 +245,26 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss.",
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss. [This event is alias to ICACHE_TAG.STALLS]",
         "EventCode": "0x83",
         "EventName": "ICACHE_64B.IFTAG_STALL",
-        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss. [This event is alias to ICACHE_TAG.ST=
ALLS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss. [This event is alias to ICACHE_16B.IFDATA_STALL]"=
,
+        "EventCode": "0x80",
+        "EventName": "ICACHE_DATA.STALLS",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The legacy decode pipeline works =
at a 16 Byte granularity. [This event is alias to ICACHE_16B.IFDATA_STALL]"=
,
+        "SampleAfterValue": "500009",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss. [This event is alias to ICACHE_64B.IFTAG_STAL=
L]",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss. [This event is alias to ICACHE_64B.IF=
TAG_STALL]",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
diff --git a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/icelake/pipeline.json
index 154fee4b60fb..375b78044f14 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
@@ -318,10 +318,10 @@
         "UMask": "0x40"
     },
     {
-        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
+        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction. [This event is alias to DECODE.LCP]",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk. [This event is=
 alias to DECODE.LCP]",
         "SampleAfterValue": "500009",
         "UMask": "0x1"
     },
@@ -556,7 +556,7 @@
         "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
-        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by branch mispredictions. This event estimates number=
 of operations that were issued but not retired from the specualtive path a=
s well as the out-of-order engine recovery past a branch misprediction.",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by branch mispredictions. This event estimates number=
 of operations that were issued but not retired from the speculative path a=
s well as the out-of-order engine recovery past a branch misprediction.",
         "SampleAfterValue": "10000003",
         "UMask": "0x8"
     },
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index eccc7ef98870..d63c9df8f65d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-B6,v1.00,grandridge,core
 GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v33,haswell,core
 GenuineIntel-6-3F,v27,haswellx,core
-GenuineIntel-6-7[DE],v1.18,icelake,core
+GenuineIntel-6-7[DE],v1.19,icelake,core
 GenuineIntel-6-6[AC],v1.20,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v23,ivytown,core
--=20
2.41.0.162.gfafddb0af9-goog

