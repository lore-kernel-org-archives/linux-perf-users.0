Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E9C74A44
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Mar 2023 05:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCNFeA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Mar 2023 01:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCNFdz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Mar 2023 01:33:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5295BE1B8
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 22:33:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b20-20020a253414000000b00b305140e33cso11667668yba.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 22:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678772028;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZN1Gr4cUK1R0e+uW4iffwT2ufvFXlj3aIL35F5q+UY0=;
        b=mm5VYdj8thJ51OLG4h8+yTKPSgdTUZlzGgYAlILn9MikIuGggwk630VBO2WYP3M+p2
         cuXCIIskCu6eXRV2qWJDYKy0uvxx79JNqAEeZan9A9NaAZD2p/X/x5j863AbwBGUcKxE
         /gEl1qzjzNoBB0Ftly68bS3ikNCZuFvi89cFIehB7ZnibC3a9xlF1Q4ebTs0qy3BZ4GK
         +SGEXtkgILMJCW2bMe8VhjsbKCn+yUjZ+1fNqH81rVOzCyKqWnjsiT4oSyX/VpAfVPS0
         epkZOI+fp5h3Bwioo4yW75QjAIc8LRmvujxyZ8qGc+j7T6RZ+CYUYXuKIwUcPJ8sNba+
         vKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772028;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZN1Gr4cUK1R0e+uW4iffwT2ufvFXlj3aIL35F5q+UY0=;
        b=4VMBNg79b1t8r7XP+ekmNq0ggkNDObmuWFAx54WYGOnJK2eSWgNM8VJfE9w0w/gEpK
         gJwVIkPUZ7UXjk5jaPFmCYwFRrExuPNuieBlGpBGS8F8mIWtL9aq9LLDkAUBHMs+5yK1
         /OGaYMnfdapIf/nAkFCpSYb1ORtLmIxidzh2oMCWupipajHfvnIBucAvAglRPV0RBxc1
         yc6+HUrEFmXR2s/tIM/pYcAgmYkWXKda4AvtjbX03ulE994qOkZfGZAMmDI3dgJIRArO
         msp3samKaLp4Iv3IKI72HqK2dml5NWX52mMFhbPyVK4ebsMof3yBmXQwMguOXSw1F85A
         6zkw==
X-Gm-Message-State: AO0yUKXlFx6cGmUTVPp1hrBX9qF9Of87AOuZ5yWVd+J6ADOlh+nvUZE5
        hIggo9bO5lcXGggNad/fiiioskxkRp0Z
X-Google-Smtp-Source: AK7set8cTUSSw/4Xj3xNrSv87tnEqLa6Aqu8ECjJeei5Hob+ci2JD8bGm5rtTcXr8OGeRotRSXCfk47wboyg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:adc3:d11e:dcd7:fd4e])
 (user=irogers job=sendgmr) by 2002:a05:6902:10e:b0:98e:6280:74ca with SMTP id
 o14-20020a056902010e00b0098e628074camr20485554ybh.1.1678772028608; Mon, 13
 Mar 2023 22:33:48 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:33:12 -0700
In-Reply-To: <20230314053312.3237390-1-irogers@google.com>
Message-Id: <20230314053312.3237390-4-irogers@google.com>
Mime-Version: 1.0
References: <20230314053312.3237390-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 3/3] perf vendor events intel: Update skylake events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update from v54 to v55. Addition of OFFCORE_RESPONSE,
FP_ARITH_INST_RETIRED.SCALAR, FP_ARITH_INST_RETIRED.VECTOR and
INT_MISC.CLEARS_COUNT.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv        |  2 +-
 tools/perf/pmu-events/arch/x86/skylake/cache.json |  8 ++++++++
 .../arch/x86/skylake/floating-point.json          | 15 +++++++++++++++
 .../pmu-events/arch/x86/skylake/pipeline.json     | 10 ++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 34431709f7d0..9abebe50ae0d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -24,7 +24,7 @@ GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v18,sandybridge,core
 GenuineIntel-6-(8F|CF),v1.11,sapphirerapids,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
-GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v54,skylake,core
+GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v55,skylake,core
 GenuineIntel-6-55-[01234],v1.29,skylakex,core
 GenuineIntel-6-86,v1.20,snowridgex,core
 GenuineIntel-6-8[CD],v1.10,tigerlake,core
diff --git a/tools/perf/pmu-events/arch/x86/skylake/cache.json b/tools/perf=
/pmu-events/arch/x86/skylake/cache.json
index 0080ac27b899..ce592d871949 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/cache.json
@@ -553,6 +553,14 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Offcore response can be programmed only with =
a specific pair of event select and counter MSR, and with specific event co=
des and predefine mask bit value in a dedicated MSR to specify attributes o=
f the offcore transaction",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OFFCORE_RESPONSE",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all demand code reads have any respons=
e type.",
         "EventCode": "0xB7, 0xBB",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/skylake/floating-point.json
index eb83fa537e7d..4d494a5cabbf 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
@@ -31,6 +31,14 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Counts once for most SIMD scalar computationa=
l floating-point instructions retired. Counts twice for DPP and FM(N)ADD/SU=
B instructions retired.",
+        "EventCode": "0xC7",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
+        "PublicDescription": "Counts once for most SIMD scalar computation=
al single precision and double precision floating-point instructions retire=
d; some instructions will count twice as noted below.  Each count represent=
s 1 computational operation. Applies to SIMD scalar single precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.=
  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per =
element. The DAZ and FTZ flags in the MXCSR register need to be set when us=
ing these events.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3"
+    },
     {
         "BriefDescription": "Counts once for most SIMD scalar computationa=
l double precision floating-point instructions retired. Counts twice for DP=
P and FM(N)ADD/SUB instructions retired.",
         "EventCode": "0xC7",
@@ -47,6 +55,13 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Number of any Vector retired FP arithmetic in=
structions",
+        "EventCode": "0xC7",
+        "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
+        "SampleAfterValue": "2000003",
+        "UMask": "0xfc"
+    },
     {
         "BriefDescription": "Cycles with any input/output SSE or FP assist=
",
         "CounterMask": "1",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/skylake/pipeline.json
index 2c827d806554..2dfc3af08eff 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
@@ -404,6 +404,16 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
+    {
+        "AnyThread": "1",
+        "BriefDescription": "Clears speculative count",
+        "CounterMask": "1",
+        "EventCode": "0x0D",
+        "EventName": "INT_MISC.CLEARS_COUNT",
+        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Cycles the issue-stage is waiting for front-e=
nd to fetch from resteered path following branch misprediction or machine c=
lear events.",
         "EventCode": "0x0D",
--=20
2.40.0.rc1.284.g88254d51c5-goog

