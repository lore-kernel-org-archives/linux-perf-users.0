Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81818EA2;
	Tue, 27 Aug 2024 05:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724736804; cv=none; b=uXAU27HFZQzk5irf5g+o2i36EFU2wFl8bLhp9V4mPASdBK9tEtAtSFJycD6haLrDKqFit5bWAJwYggsnfbDW9MZaYISwLpNXK46NZPKGuJKgdFbDR2RxAqrw1JGRovIBVH+zZyofXrQvZZWlWsf5N2qb8q2HUzNPL0aWDEgM/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724736804; c=relaxed/simple;
	bh=9LlFNy6giIeCDqRdug2wer6zx110fONwUh1Wa+nQ/G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pCaThZHoKd0k3grdrsP/IqU4YCML8I5rjhLE94xXhzmMKpcW+eMNLfumEPKnGCn+dyTtrTw2zeLst9U8YbWgggh0G/bFk5wfS3br/X2rN7DudTl/Dd3HWrbZd4NIvweuJkbM8+tk5oAbLB9vhl+ZTsvA/byzvK6HsUYAFefz//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eV9LhhMY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eV9LhhMY"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1tKOm014300;
	Tue, 27 Aug 2024 05:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=2oM5tNMaqV9tNItNwpMb48saOy
	4fHdOqQvszVOZpA+I=; b=eV9LhhMYJEjB83J3KJLdNdy93DiHV4LyZmwdywH5I3
	gWdW/jn/UXVEN/dslQVNSSGf/ebrIEpuOhfKnldMU2glNAKGNLXS0rMOaNNT+Yqm
	JD2WNkSYeNN+MX+KQRJ88NBfoJ/Ys5lXaBrKeOOFxSZIIoQFER5QVLIR9oHqbj4Y
	myu7919ml9slXmX9qhr+K/wlBdApPHMXKRQXvdcilhdTETSOMmr47oc2/ZbUBpqE
	CDb4gZMsLnefHU5bL4d/k/peOUP1ecQ54BkSbOZzYJR1w0I7tYN6Ng5HzG+sjoFS
	TNKrzHJ0W0l2peSHJ8lr++BAvjvjPvG0eShh/V7C72SQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417h66hwwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:33:16 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47R5UjX2020962;
	Tue, 27 Aug 2024 05:33:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417h66hww9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:33:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47R2keAq003161;
	Tue, 27 Aug 2024 05:33:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417tupsbdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:33:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47R5X7BY56361378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 05:33:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE6BE2004B;
	Tue, 27 Aug 2024 05:33:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BCEF20040;
	Tue, 27 Aug 2024 05:33:02 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.ustream.lldns.net (unknown [9.200.51.96])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Aug 2024 05:33:01 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: acme@kernel.org, irogers@google.com
Cc: namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        hbathini@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 1/3] perf vendor events power10: Update JSON/events
Date: Tue, 27 Aug 2024 11:02:04 +0530
Message-ID: <20240827053206.538814-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x2kWkoMjCuWyL5D5xWTb2ll3ih95xh45
X-Proofpoint-ORIG-GUID: w8N5UCKotcyEbtZli9t8G7EJu4BUBD3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270039

Update JSON/events for power10 platform with additional events.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/powerpc/power10/datasource.json      | 25 +++++++++++++++++++
 .../arch/powerpc/power10/frontend.json        | 10 ++++++++
 .../pmu-events/arch/powerpc/power10/pmc.json  |  5 ++++
 3 files changed, 40 insertions(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
index 0eeaaf1a95b8..283284745d9c 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/datasource.json
@@ -14,6 +14,31 @@
     "EventName": "PM_DATA_FROM_MEMORY",
     "BriefDescription": "The processor's data cache was reloaded from local, remote, or distant memory due to a demand miss."
   },
+  {
+    "EventCode": "0x0000004080",
+    "EventName": "PM_INST_FROM_L1",
+    "BriefDescription": "An instruction fetch hit in the L1. Each fetch group contains 8 instructions. The same line can hit 4 times if 32 sequential instructions are fetched."
+  },
+  {
+    "EventCode": "0x000000026080",
+    "EventName": "PM_L2_LD_MISS",
+    "BriefDescription": "All successful D-Side Load dispatches for this thread that missed in the L2. Since the event happens in a 2:1 clock domain and is time-sliced across all 4 threads, the event count should be multiplied by 2."
+  },
+  {
+    "EventCode": "0x000000026880",
+    "EventName": "PM_L2_ST_MISS",
+    "BriefDescription": "All successful D-Side Store dispatches for this thread that missed in the L2. Since the event happens in a 2:1 clock domain and is time-sliced across all 4 threads, the event count should be multiplied by 2."
+  },
+  {
+    "EventCode": "0x010000046880",
+    "EventName": "PM_L2_ST_HIT",
+    "BriefDescription": "All successful D-side store dispatches for this thread that were L2 hits. Since the event happens in a 2:1 clock domain and is time-sliced across all 4 threads, the event count should be multiplied by 2."
+  },
+  {
+    "EventCode": "0x000000036880",
+    "EventName": "PM_L2_INST_MISS",
+    "BriefDescription": "All successful instruction (demand and prefetch) dispatches for this thread that missed in the L2. Since the event happens in a 2:1 clock domain and is time-sliced across all 4 threads, the event count should be multiplied by 2."
+  },
   {
     "EventCode": "0x000300000000C040",
     "EventName": "PM_INST_FROM_L2",
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
index 53660c279286..456971f60814 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
@@ -93,5 +93,15 @@
     "EventCode": "0x400FC",
     "EventName": "PM_ITLB_MISS",
     "BriefDescription": "Instruction TLB reload (after a miss), all page sizes. Includes only demand misses."
+  },
+  {
+    "EventCode": "0x00000040B8",
+    "EventName": "PM_PRED_BR_TKN_COND_DIR",
+    "BriefDescription": "A conditional branch finished with correctly predicted direction. Resolved taken."
+  },
+  {
+    "EventCode": "0x00000048B8",
+    "EventName": "PM_PRED_BR_NTKN_COND_DIR",
+    "BriefDescription": "A conditional branch finished with correctly predicted direction. Resolved not taken."
   }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
index 0e0253d0e757..04732698d9b2 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
@@ -104,6 +104,11 @@
     "EventName": "PM_RUN_CYC",
     "BriefDescription": "Processor cycles gated by the run latch."
   },
+  {
+    "EventCode": "0x200F8",
+    "EventName": "PM_EXT_INT",
+    "BriefDescription": "Cycles an external interrupt was active."
+  },
   {
     "EventCode": "0x30010",
     "EventName": "PM_PMC2_OVERFLOW",
-- 
2.43.5

