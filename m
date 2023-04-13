Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3437C77B61
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 13:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjDMNeD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjDMNdm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 09:33:42 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42AFC155
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:32:16 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s77-20020a632c50000000b0050300a8089aso6381408pgs.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681392734; x=1683984734;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZt20Z7hTMj/DUmjIhsYx65tA/VQTBMfCLcsGtkqEtU=;
        b=6jaHp56gs2RIaosbKVmgBk0trVN0i4zX6ayjEVKDnrvP5Lve7AeQTPW0q9UBGhBCLD
         rEU1pBAYziHvEsT59Xo7zrubD8gRRmx7aM9ry9SvDn9XyJ1HKcmULpaDfPquRAJH2t61
         keVKPgiT88dabu48wb87dOr0tIv9FqUQG/ZB/igJQo3y1Xd7Jg5RCUi+25en9O1zxezN
         eP1bgo4NokZ7S77+XBX0JmXnwy3IswK5Yf57QDOOdyIXblpseNTBPfwM/xzW2dNr5/Cw
         l4HCoEGZovZajuLjq/lxP3km4jGzmXyD2CPq24ZZBGUUvGlmLqvHGrpQd5kwd3466Q9b
         gMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392734; x=1683984734;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rZt20Z7hTMj/DUmjIhsYx65tA/VQTBMfCLcsGtkqEtU=;
        b=Zgq8vrIhMekNEy08Mok7UBrr9RKV1mZll6vUxlQonl8I0u8DNTsj+9iMrVYkOX2s6D
         CqIQnbw75fZ8VLMiEt0JpjldykSmVxpdKNBwDeVdcEsge90TQcgJwvdxi0QMOeLk3aO3
         xbmkafZ5c/kf/w/W2jbxiVY4o3FkQE7PHaXi4FBEkiEB1sg3L0N6371zaXoDsPsGjB51
         b9yCw0Cx6h6U/AKERg7uKuPIV822dUz//4pQVd+DBCDzxHGShLWW1KqSsvts0X/07Maw
         wg2M09Aj8nqCMwZwDNTfP5Wfd3n7cRX8aEHtIx2+F+KohNpOPybnsLz9bpm2BKfmtqQT
         cvxQ==
X-Gm-Message-State: AAQBX9fPt4hpkm5oBpnE83NP7vjebcOySwuNhvyHKpqh1+sIKQ3/kQ+s
        u5aZ8f1Ttc5VQqO4BtAtbeTFVkZap+Un
X-Google-Smtp-Source: AKy350ansSuz41r2u7arlnoYt8KAoGMsAk/8TTI+Ls3Pzt84wdR1NPvMeyhO74xCkjoQj0iSLT9ZBGKHR5WZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a17:902:d1d3:b0:1a2:4524:975f with SMTP id
 g19-20020a170902d1d300b001a24524975fmr637262plb.0.1681392734369; Thu, 13 Apr
 2023 06:32:14 -0700 (PDT)
Date:   Thu, 13 Apr 2023 06:29:44 -0700
In-Reply-To: <20230413132949.3487664-1-irogers@google.com>
Message-Id: <20230413132949.3487664-17-irogers@google.com>
Mime-Version: 1.0
References: <20230413132949.3487664-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v3 16/21] perf vendor events intel: Fix uncore topics for knightslanding
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

Remove 'uncore-other' topic classification, move to cache, io and
memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../{uncore-other.json =3D> uncore-cache.json}  | 260 ------------------
 .../arch/x86/knightslanding/uncore-io.json    | 194 +++++++++++++
 .../x86/knightslanding/uncore-memory.json     |  68 +++++
 3 files changed, 262 insertions(+), 260 deletions(-)
 rename tools/perf/pmu-events/arch/x86/knightslanding/{uncore-other.json =
=3D> uncore-cache.json} (91%)
 create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/uncore-io=
.json

diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.jso=
n b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
similarity index 91%
rename from tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
rename to tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
index fc85e0c95318..1b8dcfa5461c 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
@@ -55,74 +55,6 @@
         "UMask": "0x24",
         "Unit": "CHA"
     },
-    {
-        "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is clean with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_EDC_ACCESS.HIT_CLEAN",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "EDC_UCLK"
-    },
-    {
-        "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is dirty with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_EDC_ACCESS.HIT_DIRTY",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "EDC_UCLK"
-    },
-    {
-        "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s clean with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_EDC_ACCESS.MISS_CLEAN",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "EDC_UCLK"
-    },
-    {
-        "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s dirty with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_EDC_ACCESS.MISS_DIRTY",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "EDC_UCLK"
-    },
-    {
-        "BriefDescription": "Number of EDC Hits or Misses. Miss I",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_EDC_ACCESS.MISS_INVALID",
-        "PerPkg": "1",
-        "UMask": "0x10",
-        "Unit": "EDC_UCLK"
-    },
-    {
-        "BriefDescription": "ECLK count",
-        "EventName": "UNC_E_E_CLOCKTICKS",
-        "PerPkg": "1",
-        "Unit": "EDC_ECLK"
-    },
-    {
-        "BriefDescription": "Counts the number of read requests received b=
y the MCDRAM controller. This event is valid in all three memory modes: fla=
t, cache and hybrid. In cache and hybrid memory mode, this event counts all=
 read requests as well as streaming stores that hit or miss in the MCDRAM c=
ache.",
-        "EventCode": "0x01",
-        "EventName": "UNC_E_RPQ_INSERTS",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "EDC_ECLK"
-    },
-    {
-        "BriefDescription": "UCLK count",
-        "EventName": "UNC_E_U_CLOCKTICKS",
-        "PerPkg": "1",
-        "Unit": "EDC_UCLK"
-    },
-    {
-        "BriefDescription": "Counts the number of write requests received =
by the MCDRAM controller. This event is valid in all three memory modes: fl=
at, cache and hybrid. In cache and hybrid memory mode, this event counts al=
l streaming stores, writebacks and, read requests that miss in MCDRAM cache=
.",
-        "EventCode": "0x02",
-        "EventName": "UNC_E_WPQ_INSERTS",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "EDC_ECLK"
-    },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired For Transgress=
 0",
         "EventCode": "0x80",
@@ -3429,197 +3361,5 @@
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_0",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_0",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_1",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_1",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_0",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_0",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_1",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_1",
-        "PerPkg": "1",
-        "UMask": "0x10",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_0",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_0",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_1",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_1",
-        "PerPkg": "1",
-        "UMask": "0x20",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_0",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_0",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_1",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_1",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_0",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_0",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_1",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_1",
-        "PerPkg": "1",
-        "UMask": "0x10",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_0",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_0",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_1",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_1",
-        "PerPkg": "1",
-        "UMask": "0x20",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_0",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.AD_0",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_1",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.AD_1",
-        "PerPkg": "1",
-        "UMask": "0x10",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_0",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_0",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_1",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_1",
-        "PerPkg": "1",
-        "UMask": "0x20",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_0",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_0",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_1",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_1",
-        "PerPkg": "1",
-        "UMask": "0x80",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_0",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.BL_0",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_1",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2P_EGRESS_INSERTS.BL_1",
-        "PerPkg": "1",
-        "UMask": "0x40",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.ALL",
-        "EventCode": "0x10",
-        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.ALL",
-        "PerPkg": "1",
-        "UMask": "0x80",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_IDI",
-        "EventCode": "0x10",
-        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_IDI",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCB",
-        "EventCode": "0x10",
-        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCB",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCS",
-        "EventCode": "0x10",
-        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCS",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "M2PCIe"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-io.json b=
/tools/perf/pmu-events/arch/x86/knightslanding/uncore-io.json
new file mode 100644
index 000000000000..898f7e425cd4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-io.json
@@ -0,0 +1,194 @@
+[
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_0",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AD_1",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AD_1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_0",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_0",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  AK_1",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.AK_1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_0",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_0",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full. Counts the numbe=
r of cycles when the M2PCIe Egress is full.  BL_1",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_FULL.BL_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_0",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AD_1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AD_1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_0",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_0",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  AK_1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.AK_1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_0",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_0",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty. Counts the =
number of cycles when the M2PCIe Egress is not empty.  BL_1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_EGRESS_CYCLES_NE.BL_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_0",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AD_0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AD_1",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AD_1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_0",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_0",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_1",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_0",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_0",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. AK_CRD_1",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.AK_CRD_1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_0",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.BL_0",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress. Counts the number of=
 number of messages inserted into the  the M2PCIe Egress queue. BL_1",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_EGRESS_INSERTS.BL_1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.ALL",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_IDI",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_IDI",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCB",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCB",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Queue Cycles Not Empty. Counts the nu=
mber of cycles when the M2PCIe Ingress is not empty.CBO_NCS",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_INGRESS_CYCLES_NE.CBO_NCS",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2PCIe"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.js=
on b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
index 47da947b1a6e..fb752974179b 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
@@ -1,4 +1,72 @@
 [
+    {
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is clean with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.HIT_CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that hit in MCDRAM cache and the data in MCDRAM is dirty with re=
spect to DDR. This event is only valid in cache and hybrid memory mode.",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.HIT_DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s clean with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.MISS_CLEAN",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Counts the number of read requests and stream=
ing stores that miss in MCDRAM cache and the data evicted from the MCDRAM i=
s dirty with respect to DDR. This event is only valid in cache and hybrid m=
emory mode.",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.MISS_DIRTY",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Number of EDC Hits or Misses. Miss I",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_EDC_ACCESS.MISS_INVALID",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "ECLK count",
+        "EventName": "UNC_E_E_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "EDC_ECLK"
+    },
+    {
+        "BriefDescription": "Counts the number of read requests received b=
y the MCDRAM controller. This event is valid in all three memory modes: fla=
t, cache and hybrid. In cache and hybrid memory mode, this event counts all=
 read requests as well as streaming stores that hit or miss in the MCDRAM c=
ache.",
+        "EventCode": "0x01",
+        "EventName": "UNC_E_RPQ_INSERTS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "EDC_ECLK"
+    },
+    {
+        "BriefDescription": "UCLK count",
+        "EventName": "UNC_E_U_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "EDC_UCLK"
+    },
+    {
+        "BriefDescription": "Counts the number of write requests received =
by the MCDRAM controller. This event is valid in all three memory modes: fl=
at, cache and hybrid. In cache and hybrid memory mode, this event counts al=
l streaming stores, writebacks and, read requests that miss in MCDRAM cache=
.",
+        "EventCode": "0x02",
+        "EventName": "UNC_E_WPQ_INSERTS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "EDC_ECLK"
+    },
     {
         "BriefDescription": "CAS All",
         "EventCode": "0x03",
--=20
2.40.0.577.gac1e443424-goog

