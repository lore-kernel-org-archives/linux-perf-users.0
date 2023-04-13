Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C0C77B61
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 13:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjDMNbI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjDMNat (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 09:30:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380804683
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:30:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e128-20020a253786000000b00b8f48863ae1so4488052yba.10
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681392634; x=1683984634;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5FlASAiO5Pas0vHW7aNptfPEsLffZYlOmd21jPi59uM=;
        b=dIpHMp8AFZtpRcUNWN3chw6is0TrNZj/cBdbO1q6meKVZ0kWjTKBSXXspzZkXfoT6i
         gBD5BB5+ir4aGo/DRQeFmEK6wGxXd+ntb5efmBTTmUF4y+G2XDQqWb8Pdbgaygi6ime/
         Z1VHIIuVvy/ATKa/HPKUDp5VMgrKWYHaMQv9/2bJ2O/H/dG6vqddaZqSTu7M2cZ0O9QE
         5ckCaTcMGEbBvVBdC4hledYeDIe2XZ/Fd5de/H2/uRxIt4/FTjv+1uE8HrNftBlOiWJP
         DC3fKh4YCBRBeyLDmV0OMep8TUzEatZmt3cNSP6R839eUbZ18ytGuSKPe7t9lN3PpIiC
         9NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392634; x=1683984634;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FlASAiO5Pas0vHW7aNptfPEsLffZYlOmd21jPi59uM=;
        b=SC3B8GK5p96BUOFbBGywH8O46tWF36ccBTQFVPpYSMb4OG53/ytoi4mmofeQTJ8FVr
         D5h1ay5JiajnsjaBffcsEYQHa8FOEvHjvRLyQWnMZBCnogNUOjsoJRRqjpKqFVuUz5cn
         Gb3fmYxF3kDOiJu1U+wk+fPkNe98Rvc+BHYwQsnqebcH0FvupG1dsOH5ctKtmNllHQ1H
         7vt+PmbWvEUaBVyc1WDcrfRQzTot2pzntbCzsKL0/m83+kcu1mPO/ATRYXg5cySfKvpD
         x9Hy8Oi+roR9TTGvOhL/A3ODDmbIV54xB8rxxbAWNy89/bSKH/rRlBSlaBoX9oB59TA2
         21QA==
X-Gm-Message-State: AAQBX9fPJm1jrxwmQVjlKq23PTr/bWZz2mi8o826Ac64r7C2C9uTHk2s
        Ik7pvCdVr6yWa92tdLFzikD/Ruww9YpQ
X-Google-Smtp-Source: AKy350Zwc3a9qR2pXCRQBUhwd81YOs82W2+Gj6NERELs6VqyojbyCsSx1sMjEshlSjbMbGeyQxUAnt4TEuOK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a25:d092:0:b0:b8f:67cd:fc12 with SMTP id
 h140-20020a25d092000000b00b8f67cdfc12mr105119ybg.13.1681392634495; Thu, 13
 Apr 2023 06:30:34 -0700 (PDT)
Date:   Thu, 13 Apr 2023 06:29:32 -0700
In-Reply-To: <20230413132949.3487664-1-irogers@google.com>
Message-Id: <20230413132949.3487664-5-irogers@google.com>
Mime-Version: 1.0
References: <20230413132949.3487664-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v3 04/21] perf vendor events intel: Fix uncore topics for alderlake
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
 .../x86/alderlake/uncore-interconnect.json    | 90 +++++++++++++++++++
 .../arch/x86/alderlake/uncore-other.json      | 88 ------------------
 .../x86/alderlaken/uncore-interconnect.json   | 26 ++++++
 .../arch/x86/alderlaken/uncore-other.json     | 24 -----
 4 files changed, 116 insertions(+), 112 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
new file mode 100644
index 000000000000..34fc052d00e4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
@@ -0,0 +1,90 @@
+[
+    {
+        "BriefDescription": "Number of requests allocated in Coherency Tracker.",
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
+        "BriefDescription": "Each cycle counts number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from its allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
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
+        "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC.",
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
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
index 5f3b4c6e2e39..2af92e43b28a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
@@ -1,92 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of requests allocated in Coherency Tracker.",
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
-        "BriefDescription": "Each cycle counts number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from its allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
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
-        "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC.",
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
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles.",
         "EventCode": "0xff",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
new file mode 100644
index 000000000000..4af695a5e755
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
@@ -0,0 +1,26 @@
+[
+    {
+        "BriefDescription": "Number of requests allocated in Coherency Tracker.",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from its allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
index f9e7777cd2be..2af92e43b28a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
@@ -1,28 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of requests allocated in Coherency Tracker.",
-        "EventCode": "0x84",
-        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from its allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles.",
         "EventCode": "0xff",
-- 
2.40.0.577.gac1e443424-goog

