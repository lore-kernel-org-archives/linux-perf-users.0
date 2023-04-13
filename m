Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322BFC77B61
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 05:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDMFNr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 01:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDMFNU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 01:13:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB3283EE
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Apr 2023 22:12:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54efad677cbso132211047b3.6
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Apr 2023 22:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681362742; x=1683954742;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6L0/on0u5NMowuDk77nSJEhKTRaml/Cx+QEJI6a3/w=;
        b=sOmxvBnsHqZ4aOr67OViykdsAPpYFBjbQmCjsK9jHyhkDvkbdyxTlPoA4iXjiYrJ2m
         UWJhzvJNQeE5LtbyD5fLgwTWUXi/gg2wJhxg3neVhtdCwcZ9DuF/EGWN8NAXWd/CPZKL
         HtPS/HYsg/7E9ULz5jnRN3Pi6xgVkt48FnbQq2GbS1+UAw1LK9RaVE2jW70wrHlvbj3d
         qFsHNUIxMUkyxjK5QsC9CefadjCmdnwUjauoBAWFsHZGvxKiYFfSNDmYUtr5Z5WQ2+xn
         P8Vt8bET5pBgMuT5b4i8CRfQZU1r3ai/0mvLtG+PC0FbvCCVFxjUHxur8MASmzcySad4
         w3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362742; x=1683954742;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g6L0/on0u5NMowuDk77nSJEhKTRaml/Cx+QEJI6a3/w=;
        b=D9ohMujHpPekSXsXBMkvxKcZhuDpjoOf95CN/SRAudKjrBDOI5Stmun2QrEcSSR2yb
         T7Z7R/mT231jLM+QzVv/Bxd/Qrc5jZ3+dr5fGAn5reZp8+X3JlxIgpTr3OTwiuTdPBhl
         glpKCaWFisrGJvCzpWLrH7AnFPynvtV+8OCj7XJB2eYXgMFYJCzAc1bKeWNslZDEaWzc
         fOQDMQH4FZ6bHmEi9eJm2DMp0fJjH+w4bFqQ9FWByKftcJ97xKyddfouT2PyQAc2NVXG
         lZKP1BQYzPPkMxEbYdb2pSMt9fTsic99sxoyQU6fdQkGnE4jFZG2tW6IccTCuUaJ0yQZ
         DfoA==
X-Gm-Message-State: AAQBX9cBMffbC3lCNzZVPIDs9th+PEUnfsY29EZuUQBpZIbZ18odiAYw
        0RFjVX7JqhB/aZyDMqRZ7/r5mf5Nx6wF
X-Google-Smtp-Source: AKy350ZcsmfcwQdwkxx01egVxEw1rNtjqoqtcIySw5Uu5mdrPGg1Jnbw3ZLdYGb2JzEZcy4ZE0a6JCaWGrpj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a25:dad2:0:b0:b8f:485d:9fcc with SMTP id
 n201-20020a25dad2000000b00b8f485d9fccmr520993ybf.4.1681362742774; Wed, 12 Apr
 2023 22:12:22 -0700 (PDT)
Date:   Wed, 12 Apr 2023 22:10:02 -0700
In-Reply-To: <20230413051011.3440849-1-irogers@google.com>
Message-Id: <20230413051011.3440849-13-irogers@google.com>
Mime-Version: 1.0
References: <20230413051011.3440849-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 12/21] perf vendor events intel: Fix uncore topics for icelake
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

Move events from 'uncore-other' topic classification to interconnect.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/icelake/uncore-interconnect.json | 74 +++++++++++++++++++
 .../arch/x86/icelake/uncore-other.json        | 72 ------------------
 2 files changed, 74 insertions(+), 72 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/uncore-interconn=
ect.json

diff --git a/tools/perf/pmu-events/arch/x86/icelake/uncore-interconnect.jso=
n b/tools/perf/pmu-events/arch/x86/icelake/uncore-interconnect.json
new file mode 100644
index 000000000000..8027590f1776
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/icelake/uncore-interconnect.json
@@ -0,0 +1,74 @@
+[
+    {
+        "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop,  etc.",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of any coherent requ=
est at memory controller that were issued by any core. This event is not su=
pported on ICL products but is supported on RKL products.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of coherent reads pe=
nding on data return from memory controller that were issued by any core. T=
his event is not supported on ICL products but is supported on RKL products=
.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches. This event is not supported on I=
CL products but is supported on RKL products.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of all outgoing vali=
d entries in ReqTrk. Such entry is defined as valid from its allocation in =
ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic. T=
his event is not supported on ICL products but is supported on RKL products=
.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches. This event is not supported on I=
CL products but is supported on RKL products.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Total number of all outgoing entries allocate=
d. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches. This event is not supported on ICL products but is=
 supported on RKL products.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/icelake/uncore-other.json
index b27d95b2c857..c6596ba09195 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/uncore-other.json
@@ -1,76 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop,  etc.",
-        "EventCode": "0x84",
-        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of any coherent requ=
est at memory controller that were issued by any core. This event is not su=
pported on ICL products but is supported on RKL products.",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of coherent reads pe=
nding on data return from memory controller that were issued by any core. T=
his event is not supported on ICL products but is supported on RKL products=
.",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches. This event is not supported on I=
CL products but is supported on RKL products.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of all outgoing vali=
d entries in ReqTrk. Such entry is defined as valid from its allocation in =
ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic. T=
his event is not supported on ICL products but is supported on RKL products=
.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches. This event is not supported on I=
CL products but is supported on RKL products.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Total number of all outgoing entries allocate=
d. Accounts for Coherent and non-coherent traffic.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches. This event is not supported on ICL products but is=
 supported on RKL products.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
     {
         "BriefDescription": "UNC_CLOCK.SOCKET",
         "EventCode": "0xff",
--=20
2.40.0.577.gac1e443424-goog

