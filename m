Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94522C77B79
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 13:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjDMNfE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjDMNet (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 09:34:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A43BB46D
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:32:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54be7584b28so269890257b3.16
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681392776; x=1683984776;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/wMb40ntUrrtEKX0pWRjZNO+TlYXtCqLFbV8EoKRtw=;
        b=meip9PgF8IZZiyBu0FD+9kxzuz+MDvUH1o6CpbJdGOCKvpJkqZ6hazSJCGAZywHUXO
         cbKAvLshlEY9FLdMtiuDArcXE1BtKENOWZvyGwNnNUkgr7Dwk61YSK182wTOTmV9/+kV
         kHGoUcCEnZHcVJ+Ej+drWqn5jADYtFWQVmpr5a5KRMEd9YvccXFW3g3pdy9WlL0qa7w6
         /Gf5ieDyAkhcsNf7sAfik3l6iIgIF43wZSv5HNsfDN6gIQVIbNmzHiHb0RI1og0Iro0o
         HLrS6isrgN6o9hsqrwfOoPDFgRNHeIu8DAH9PQXfKTtfcgRyJLcSpeT0o7FHTHkX1dEX
         LKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392776; x=1683984776;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/wMb40ntUrrtEKX0pWRjZNO+TlYXtCqLFbV8EoKRtw=;
        b=TnUKIGC5Bq2+BCvtIouHnEv5Mb+j/RqvoOYOdzTuKMK1z4n7Z3Y34mFwOYuPJL8pWF
         WFoNGTiooZMU4xm/MLL/YfQ+pHgFPgpb5dVbUuiFCdFkDgTTOcggxUVMNNm5t+LVbKg8
         aH+qSKqnF+Wj1g3eDZHyFgK6UouFMdmVUb05x79NdNUnykizmA5GNJbWDsGpPOYe+9YV
         o84LArspZ1HZjPL5czWxCI/4KGbudKMtk59j87kKjCMS2nqYI2inBuWFT+ckfL40o+gD
         PHzg7KZdn1SAPsTfcPfGhjJiW3oLEfIW7C1qtMi7sExvEeJqNnvCSHEBvxryvfu02zFS
         S71Q==
X-Gm-Message-State: AAQBX9eoDKDXSFY/5Ifoqq8bfhVQUeMz+pmXmFvXhdASXqoc2kqa+1PN
        KPoF41Jbype5cO7GikvWy7ZMoQf0yv4+
X-Google-Smtp-Source: AKy350Z6mxMLtzGWnCheL4tm7o3Tk9j27ZFOMJO97LE6vtyxY2iB37ARs4wdyNNy/55Qwi8LbH59Zvu3E7Vd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a25:ca44:0:b0:b8e:7771:f424 with SMTP id
 a65-20020a25ca44000000b00b8e7771f424mr1461457ybg.0.1681392775967; Thu, 13 Apr
 2023 06:32:55 -0700 (PDT)
Date:   Thu, 13 Apr 2023 06:29:49 -0700
In-Reply-To: <20230413132949.3487664-1-irogers@google.com>
Message-Id: <20230413132949.3487664-22-irogers@google.com>
Mime-Version: 1.0
References: <20230413132949.3487664-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v3 21/21] perf vendor events intel: Fix uncore topics for tigerlake
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
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move events from 'uncore-other' topic classification to interconnect.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../x86/tigerlake/uncore-interconnect.json    | 90 +++++++++++++++++++
 .../arch/x86/tigerlake/uncore-other.json      | 88 ------------------
 2 files changed, 90 insertions(+), 88 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json

diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json
new file mode 100644
index 000000000000..eed1b90a2779
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-interconnect.json
@@ -0,0 +1,90 @@
+[
+    {
+        "BriefDescription": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of any coherent request at memory controller that were issued by any core.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of coherent reads pending on data return from memory controller that were issued by any core.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_DAT_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_DAT_OCCUPANCY.ALL",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_OCCUPANCY.RD]",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_REQUESTS.RD]",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from it's allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_OCCUPANCY.DRD]",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "UNC_ARB_TRK_REQUESTS.ALL",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_REQUEST.DRD]",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
index 6e43aaf64e28..c6596ba09195 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
@@ -1,92 +1,4 @@
 [
-    {
-        "BriefDescription": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-        "EventCode": "0x84",
-        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of any coherent request at memory controller that were issued by any core.",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of coherent reads pending on data return from memory controller that were issued by any core.",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_REQ_TRK_REQUEST.DRD",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_DAT_REQUESTS.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_DAT_OCCUPANCY.ALL",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_OCCUPANCY.RD]",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_REQUESTS.RD]",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from it's allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_OCCUPANCY.DRD]",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "UNC_ARB_TRK_REQUESTS.ALL",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_REQUEST.DRD]",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
     {
         "BriefDescription": "UNC_CLOCK.SOCKET",
         "EventCode": "0xff",
-- 
2.40.0.577.gac1e443424-goog

