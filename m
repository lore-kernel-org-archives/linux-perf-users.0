Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381E1D5CD7;
	Fri, 24 Jan 2025 03:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737690989; cv=none; b=cDqkXJGr0N1YE1o7Xv/C6iSjhKv7YIzCNaue4IagYMHN11ZAaVRctpcs4AzEou+OcdUjUvud2jav1lMAMzLLel9+Ymj6c1MWdrbQzvDaouRDkRf7WaQACBTFJoHMs8XrELWJlLVrOR3x1CQsMDn8lsDVXwQ+L3+IOYSdgjC4WIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737690989; c=relaxed/simple;
	bh=vZ16qEcR6tt5xSYGXnfxgzBAuZ0+0cPwYakmw9OEYTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QXcaUsbJSJMIWZrc00miaBVKzyCqKu0sRK8DyRQ9PHxkBXxTgvvLsMoAwcme1Tn8EaVREQUNecm1238CegJfoGYzSn11LaYoGlM7LsO9WjQpUG79QrzoG2J/QiXXbMvOFmafnwrAO1yfEfbvG1mO8+oywQfLWoLCicuh3quJ99g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id VUB00110;
        Fri, 24 Jan 2025 11:55:10 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201623.home.langchao.com (10.100.2.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 Jan 2025 11:55:10 +0800
Received: from localhost.localdomain (10.94.9.245) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 Jan 2025 11:55:09 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] perf vendor events: Fix double word in BriefDescription
Date: Fri, 24 Jan 2025 11:55:07 +0800
Message-ID: <20250124035507.52827-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201618.home.langchao.com (10.100.2.18) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2025124115510dc77c8ebae58740173779071aea7340a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Remove the repeated word "for" in BriefDescription.

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 .../graniterapids/uncore-interconnect.json    | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
index 856ee985ecd4..0f5332ad0b80 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
@@ -1016,7 +1016,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress bypasses for for AD_BNC",
+        "BriefDescription": "Egress bypasses for AD_BNC",
         "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_MDF_TxR_BYPASS.AD_BNC",
@@ -1026,7 +1026,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress bypasses for for AD_CRD",
+        "BriefDescription": "Egress bypasses for AD_CRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_MDF_TxR_BYPASS.AD_CRD",
@@ -1036,7 +1036,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress bypasses for for AK",
+        "BriefDescription": "Egress bypasses for AK",
         "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_MDF_TxR_BYPASS.AK",
@@ -1046,7 +1046,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress bypasses for for BL_BNC",
+        "BriefDescription": "Egress bypasses for BL_BNC",
         "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_MDF_TxR_BYPASS.BL_BNC",
@@ -1056,7 +1056,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress bypasses for for BL_CRD",
+        "BriefDescription": "Egress bypasses for BL_CRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_MDF_TxR_BYPASS.BL_CRD",
@@ -1066,7 +1066,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress bypasses for for IV",
+        "BriefDescription": "Egress bypasses for IV",
         "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_MDF_TxR_BYPASS.IV",
@@ -1076,7 +1076,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of egress inserts for for AD_BNC",
+        "BriefDescription": "Number of egress inserts for AD_BNC",
         "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_MDF_TxR_INSERTS.AD_BNC",
@@ -1086,7 +1086,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of egress inserts for for AD_CRD",
+        "BriefDescription": "Number of egress inserts for AD_CRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_MDF_TxR_INSERTS.AD_CRD",
@@ -1096,7 +1096,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of egress inserts for for AK",
+        "BriefDescription": "Number of egress inserts for AK",
         "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_MDF_TxR_INSERTS.AK",
@@ -1106,7 +1106,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of egress inserts for for BL_BNC",
+        "BriefDescription": "Number of egress inserts for BL_BNC",
         "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_MDF_TxR_INSERTS.BL_BNC",
@@ -1116,7 +1116,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of egress inserts for for BL_CRD",
+        "BriefDescription": "Number of egress inserts for BL_CRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_MDF_TxR_INSERTS.BL_CRD",
@@ -1126,7 +1126,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of egress inserts for for IV",
+        "BriefDescription": "Number of egress inserts for IV",
         "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_MDF_TxR_INSERTS.IV",
@@ -1136,7 +1136,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress occupancy for for AD_BNC",
+        "BriefDescription": "Egress occupancy for AD_BNC",
         "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_MDF_TxR_OCCUPANCY.AD_BNC",
@@ -1146,7 +1146,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress occupancy for for AD_CRD",
+        "BriefDescription": "Egress occupancy for AD_CRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_MDF_TxR_OCCUPANCY.AD_CRD",
@@ -1156,7 +1156,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress occupancy for for AK",
+        "BriefDescription": "Egress occupancy for AK",
         "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_MDF_TxR_OCCUPANCY.AK",
@@ -1166,7 +1166,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress occupancy for for BL_BNC",
+        "BriefDescription": "Egress occupancy for BL_BNC",
         "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_MDF_TxR_OCCUPANCY.BL_BNC",
@@ -1176,7 +1176,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress occupancy for for BL_CRD",
+        "BriefDescription": "Egress occupancy for BL_CRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_MDF_TxR_OCCUPANCY.BL_CRD",
@@ -1186,7 +1186,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress occupancy for for IV",
+        "BriefDescription": "Egress occupancy for IV",
         "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_MDF_TxR_OCCUPANCY.IV",
-- 
2.31.1

