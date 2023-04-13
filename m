Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C586AC77B6C
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 05:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDMFMT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 01:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDMFLw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 01:11:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468187D96
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Apr 2023 22:11:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54faf2e22afso31091307b3.7
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Apr 2023 22:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681362692; x=1683954692;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNQ/CBH05fbccri6AIyGxIe8z9FNl5fUM56NJ0S2EHM=;
        b=w/MvycURBry8CgDvL6Uu+hxBd0NiKBGGbMPMFso2fY6ZCAbVwjvz0vUbrT/300VJA8
         EIhQFUfPwPIcoqG3ym3WGLOChTJirBkdhWcSr5fWK6UBFDrGu/yq3eozS+2xtm2IM4Um
         Nxj0R/WlVZpkA98dYdsKULu1HH5j/3q/N3MtinAi7gnNvFlTw+4yqn0y6ZAHM25yXS64
         pu3FeBgs8QcBGmPw6O03hYh3ttEih4E5HWGVUuh4je5cAhjRw4jbnhJv9ZeCdM283jiS
         ZUdY8PMsYcttZWUqR9VhHU5tIVkUCmNYFhXukMUuPsS2j1w+flb2s3qR4KfmAMXhi+AZ
         69Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362692; x=1683954692;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CNQ/CBH05fbccri6AIyGxIe8z9FNl5fUM56NJ0S2EHM=;
        b=G1DU3b77SNR6Gi2mSPlmRN1Lfw1LcDCJEwOFdWoCH5XajnKxVhwsC7k+SRtui8ZKMu
         0igYZqh6RlAfWUcLZhgf1CyNCcEpHlQQryLR4ttDumMDSAD7iYFEQMskRZCWywNfa8y3
         HjkVDxNBWJhdw9PcNP8naToX4bA42cZ0gvl58nRicQvBTMazqdAZlobUJYvDpj0HrhwW
         ckn/BXmFegNq1s/yFTqE4HNJE3KFhdT/BrVibSoJFqhqOSpwY8hASTo+GK2YoJY8s6eC
         /8BhK7FX4zU82nrSBcCYVT0KnvGLrPD7mh6wpCpLm+7SJyumcDyI0OeUA1CdontvRPZq
         trmw==
X-Gm-Message-State: AAQBX9efHFcj/I1uV00QuelFFFTi8bR+0Tc1utQUNTEWmZMW3eljoPL0
        V8oKqjzC0r7pgF/8ZpHlq1d35xy8cSn6
X-Google-Smtp-Source: AKy350ZruQMNBp4oqYmcWI/N13Is5GEiKbyoKq1hgFehanFPRxPfYSLuu090p5T/my54ZzCLqNyOvljfzynO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a25:df94:0:b0:b8b:f5fb:5986 with SMTP id
 w142-20020a25df94000000b00b8bf5fb5986mr632349ybg.10.1681362692573; Wed, 12
 Apr 2023 22:11:32 -0700 (PDT)
Date:   Wed, 12 Apr 2023 22:09:56 -0700
In-Reply-To: <20230413051011.3440849-1-irogers@google.com>
Message-Id: <20230413051011.3440849-7-irogers@google.com>
Mime-Version: 1.0
References: <20230413051011.3440849-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 06/21] perf vendor events intel: Fix uncore topics for broadwell
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Reduce the number of 'uncore-other' topic classifications, move to
cache and interconnect.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwell/uncore-cache.json      | 30 ++++-----
 .../x86/broadwell/uncore-interconnect.json    | 61 +++++++++++++++++++
 .../arch/x86/broadwell/uncore-other.json      | 59 ------------------
 3 files changed, 76 insertions(+), 74 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore-interco=
nnect.json

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json b/t=
ools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json
index fcb15b880bad..c5cc43825cb9 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json
@@ -6,7 +6,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup any request that access cache and =
found line in E or S-state.",
         "UMask": "0x86",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in I-state",
@@ -15,7 +15,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup any request that access cache and =
found line in I-state.",
         "UMask": "0x88",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in M-state",
@@ -24,7 +24,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup any request that access cache and =
found line in M-state.",
         "UMask": "0x81",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in MESI-state",
@@ -33,7 +33,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup any request that access cache and =
found line in MESI-state.",
         "UMask": "0x8f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in E or S-state",
@@ -42,7 +42,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup read request that access cache and=
 found line in E or S-state.",
         "UMask": "0x16",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in I-state",
@@ -51,7 +51,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup read request that access cache and=
 found line in I-state.",
         "UMask": "0x18",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in M-state",
@@ -60,7 +60,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup read request that access cache and=
 found line in M-state.",
         "UMask": "0x11",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup read request that access cache and =
found line in any MESI-state",
@@ -69,7 +69,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup read request that access cache and=
 found line in any MESI-state.",
         "UMask": "0x1f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in E or S-state",
@@ -78,7 +78,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup write request that access cache an=
d found line in E or S-state.",
         "UMask": "0x26",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in M-state",
@@ -87,7 +87,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup write request that access cache an=
d found line in M-state.",
         "UMask": "0x21",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "L3 Lookup write request that access cache and=
 found line in MESI-state",
@@ -96,7 +96,7 @@
         "PerPkg": "1",
         "PublicDescription": "L3 Lookup write request that access cache an=
d found line in MESI-state.",
         "UMask": "0x2f",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which hits a modified line in some proces=
sor core.",
@@ -104,7 +104,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_XCORE",
         "PerPkg": "1",
         "UMask": "0x48",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which hits a non-modified line in some pr=
ocessor core.",
@@ -112,7 +112,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_XCORE",
         "PerPkg": "1",
         "UMask": "0x44",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop resulted from L3 Eviction =
which misses in some processor core.",
@@ -120,7 +120,7 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
         "PerPkg": "1",
         "UMask": "0x81",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     },
     {
         "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which misses in some processor core.",
@@ -128,6 +128,6 @@
         "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE",
         "PerPkg": "1",
         "UMask": "0x41",
-        "Unit": "CBO"
+        "Unit": "CBOX"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/uncore-interconnect.j=
son b/tools/perf/pmu-events/arch/x86/broadwell/uncore-interconnect.json
new file mode 100644
index 000000000000..64af685274a2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/broadwell/uncore-interconnect.json
@@ -0,0 +1,61 @@
+[
+    {
+        "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop, Core aperture, etc.",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of all Core outgoing=
 valid entries. Such entry is defined as valid from its allocation till fir=
st of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-cohe=
rent traffic.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Cycles with at least one request outstanding =
is waiting for data return from memory controller. Account for coherent and=
 non-coherent requests initiated by IA Cores, Processor Graphics Unit, or L=
LC.;",
+        "CounterMask": "1",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries that are in DirectData mode. Such entry is defined as vali=
d when it is allocated till data sent to Core (first chunk, IDI0). Applicab=
le for IA Cores' requests in normal case.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.DRD_DIRECT",
+        "PerPkg": "1",
+        "PublicDescription": "Each cycle count number of valid coherent Da=
ta Read entries that are in DirectData mode. Such entry is defined as valid=
 when it is allocated till data sent to Core (first chunk, IDI0). Applicabl=
e for IA Cores' requests in normal case.",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Total number of Core outgoing entries allocat=
ed. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of Core coherent Data Read entries all=
ocated in DirectData mode",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.DRD_DIRECT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Core coherent Data Read entries al=
located in DirectData mode.",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of Writes allocated - any write transa=
ctions: full/partials writes and evictions.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "ARB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
index 368a958a18a0..58be90d7cc93 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
@@ -1,63 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop, Core aperture, etc.",
-        "EventCode": "0x84",
-        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of all Core outgoing=
 valid entries. Such entry is defined as valid from its allocation till fir=
st of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-cohe=
rent traffic.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Cycles with at least one request outstanding =
is waiting for data return from memory controller. Account for coherent and=
 non-coherent requests initiated by IA Cores, Processor Graphics Unit, or L=
LC.;",
-        "CounterMask": "1",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries that are in DirectData mode. Such entry is defined as vali=
d when it is allocated till data sent to Core (first chunk, IDI0). Applicab=
le for IA Cores' requests in normal case.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.DRD_DIRECT",
-        "PerPkg": "1",
-        "PublicDescription": "Each cycle count number of valid coherent Da=
ta Read entries that are in DirectData mode. Such entry is defined as valid=
 when it is allocated till data sent to Core (first chunk, IDI0). Applicabl=
e for IA Cores' requests in normal case.",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Total number of Core outgoing entries allocat=
ed. Accounts for Coherent and non-coherent traffic.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of Core coherent Data Read entries all=
ocated in DirectData mode",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.DRD_DIRECT",
-        "PerPkg": "1",
-        "PublicDescription": "Number of Core coherent Data Read entries al=
located in DirectData mode.",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of Writes allocated - any write transa=
ctions: full/partials writes and evictions.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
-        "PerPkg": "1",
-        "UMask": "0x20",
-        "Unit": "ARB"
-    },
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les",
         "EventCode": "0xff",
--=20
2.40.0.577.gac1e443424-goog

