Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809A84D34;
	Tue, 27 Aug 2024 05:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724736833; cv=none; b=EaIrmZag5A1tZacjUCKHDDlKj8rmMjTOxPwV5oHkix8/VM5Eij69/7PRXM8R90Cf2qHdhzWTBYsDlQVuY4/8+YcAqH5le1BYq/cE5qtkE2dOxvP6fQegrBm3CD5NKwBf+nJcBPNGlahxi+yH6B7BIEnjmTStel2q7BD9VnIg06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724736833; c=relaxed/simple;
	bh=zrPRCQFfWs0AsTqRvX8XIl+6nm9INVWGrsZG8yK8GHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFS/eJfGB4fA+InHBwixZWuiymYBe/J92d43i7i+Uj/Jy1tcqmN8cGYkgAqse3lKsDIMIZOgmsInwZWg2SvpqnjTg7QWFkn4EWqAU6/u909D0NJHusAtGmS+OgoIQAnrxgHGQSAfD6R7pDZVp/CZqRcOQJdw2+vaVq+xbeThQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p2laHNNH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p2laHNNH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1tVLo015136;
	Tue, 27 Aug 2024 05:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=L8Sjx5YSltujz
	I60JahR8FVhesLAlU00v4fqtvSMiGY=; b=p2laHNNHTI/0ykTeuNBTu5GWbb9Kk
	DrpSNih83djzsCqkomzswBwCAJDagHd/3jY4yBrorY0VZjdOdwwnFbSn3fD+uXoO
	s2i+I7lTd8Iq7uSaDTE0hTVtYscsxfpTZK89tMgqywDAo7I8OUSXmtqio/27kXBy
	1NsKHv2xYjadkrIfHYuVMI1Dx66VwHW+CdRmt6GbM6fh+//FesD9K4Eu7Flwlob/
	OsKBX16y1J7d9tAYC89JrPihXZORvp+1Bn4WEz8GLEEKssffkEonpsWB1PNBS0j5
	emUDuAgjzFCrBo6DKvSuW3NkCKfGrJmLVt4TByx8ZqBzTCZ18z1YITSaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417fvc1tsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:33:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47R5XiDA028487;
	Tue, 27 Aug 2024 05:33:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417fvc1tsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:33:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47R3XFZ9008239;
	Tue, 27 Aug 2024 05:33:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 417v2mh4xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:33:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47R5Xb9u55509362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 05:33:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E9512004B;
	Tue, 27 Aug 2024 05:33:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C580B20040;
	Tue, 27 Aug 2024 05:33:30 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.ustream.lldns.net (unknown [9.200.51.96])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Aug 2024 05:33:30 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: acme@kernel.org, irogers@google.com
Cc: namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        hbathini@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 3/3] perf vendor events: Move PM_BR_MPRED_CMPL event for power10 platform
Date: Tue, 27 Aug 2024 11:02:06 +0530
Message-ID: <20240827053206.538814-3-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240827053206.538814-1-kjain@linux.ibm.com>
References: <20240827053206.538814-1-kjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _PMNOpisS7R51y7GDlnBtpvGFuTfQJod
X-Proofpoint-GUID: l8-l_rXsSQmF8Lv2U7hQ4MJIdQl8Lwg_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408270039

Move PM_BR_MPRED_CMPL event from cache.json to frontend.json file
for power10 platform

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/pmu-events/arch/powerpc/power10/cache.json    | 5 -----
 tools/perf/pmu-events/arch/powerpc/power10/frontend.json | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power10/cache.json b/tools/perf/pmu-events/arch/powerpc/power10/cache.json
index 9814a59fce31..b7e0be09ff57 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/cache.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/cache.json
@@ -18,10 +18,5 @@
     "EventCode": "0x300F4",
     "EventName": "PM_RUN_INST_CMPL_CONC",
     "BriefDescription": "PowerPC instruction completed by this thread when all threads in the core had the run-latch set."
-  },
-  {
-    "EventCode": "0x400F6",
-    "EventName": "PM_BR_MPRED_CMPL",
-    "BriefDescription": "A mispredicted branch completed. Includes direction and target."
   }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
index 684374fe5699..b6998987ab75 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
@@ -94,6 +94,11 @@
     "EventName": "PM_DTLB_HIT_1G",
     "BriefDescription": "Data TLB hit (DERAT reload) page size 1G. Implies radix translation. When MMCR1[16]=0 this event counts only for demand misses. When MMCR1[16]=1 this event includes demand misses and prefetches."
   },
+  {
+    "EventCode": "0x400F6",
+    "EventName": "PM_BR_MPRED_CMPL",
+    "BriefDescription": "A mispredicted branch completed. Includes direction and target."
+  },
   {
     "EventCode": "0x400FC",
     "EventName": "PM_ITLB_MISS",
-- 
2.43.5

