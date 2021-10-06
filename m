Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E443C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 14:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0D26109F
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 14:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhJFOLj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 10:11:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29148 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231600AbhJFOLi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 10:11:38 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196E6v2B010115;
        Wed, 6 Oct 2021 10:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=my0wbojX0w8U03ExVbfDU5z+BlgQoCCxG7szX1YPeUs=;
 b=FAhM2vPkKZP0ZiFFFVfrcIm2o80/N7l6EoIzhuXqMhMK6pgFAryBFsILBEQ18QYp572s
 4GF315RTsR/zh6XZQ0FgENheF1rD7B19WN1A48KqPTtiLdnHJye5tT7SNghoaO+1SXna
 MQTWbtrVrh786z1ipuiNqGd2rfPM7NIHERJBH9MeOyqsS9u+lDOwinla0yMbj2mY+Xa0
 M+5sazpBYlyQ0ha7dF543p5n5rKTIPNIk3UixTzk3htQ0394cTgeLWUpil8Iqbf8sR/M
 nO4TGw23d7hTzq5oBJISKUpRYw7NbP5b8tFZDTPm5t0X++7Szo9zCSBY+8opGntrWlRu pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bh2ncdy0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 10:08:11 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 196E6wGe010288;
        Wed, 6 Oct 2021 10:08:10 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bh2ncdy03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 10:08:10 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 196DwitS016173;
        Wed, 6 Oct 2021 14:08:06 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3bef2abh2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 14:08:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 196E816q524924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Oct 2021 14:08:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3758A4068;
        Wed,  6 Oct 2021 14:08:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F05CA406A;
        Wed,  6 Oct 2021 14:07:54 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.124.20])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Oct 2021 14:07:53 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
Cc:     linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        yao.jin@linux.intel.com, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, kan.liang@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        paulus@samba.org, kjain@linux.ibm.com
Subject: [PATCH v3 4/4] powerpc/perf: Fix data source encodings for L2.1 and L3.1 accesses
Date:   Wed,  6 Oct 2021 19:36:54 +0530
Message-Id: <20211006140654.298352-5-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211006140654.298352-1-kjain@linux.ibm.com>
References: <20211006140654.298352-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qIsCLcOaVZxO1BvL8dwCxOcS9UuSUOoH
X-Proofpoint-ORIG-GUID: Q6nVzFIaTXb1T5LlY5Y5wXcy7pq4NzA5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_03,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060089
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix the data source encodings to represent L2.1/L3.1(another core's
L2/L3 on the same node) accesses properly for power10 and older
plaforms.

Add new macros(LEVEL/REM) which can be used to add mem_lvl_num and remote
field data inside perf_mem_data_src structure.

Result in power9 system with patch changes:

localhost:~/linux/tools/perf # ./perf mem report | grep Remote
     0.01%             1  252           Remote core, same node L3 or L3 hit  [.] 0x0000000000002dd0                producer_consumer   [.] 0x00007fff7f25eb90
anon               HitM          N/A                     No       N/A        0              0
     0.01%             1  220           Remote core, same node L3 or L3 hit  [.] 0x0000000000002dd0                producer_consumer   [.] 0x00007fff77776d90
anon               HitM          N/A                     No       N/A        0              0
     0.01%             1  220           Remote core, same node L3 or L3 hit  [.] 0x0000000000002dd0                producer_consumer   [.] 0x00007fff817d9410
anon               HitM          N/A                     No       N/A        0              0

Fixes: 79e96f8f930d ("powerpc/perf: Export memory hierarchy info to user
space")
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 arch/powerpc/perf/isa207-common.c | 26 +++++++++++++++++++++-----
 arch/powerpc/perf/isa207-common.h |  2 ++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index f92bf5f6b74f..7ea873ab2e6f 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -238,11 +238,27 @@ static inline u64 isa207_find_source(u64 idx, u32 sub_idx)
 		ret |= P(SNOOP, HIT);
 		break;
 	case 5:
-		ret = PH(LVL, REM_CCE1);
-		if ((sub_idx == 0) || (sub_idx == 2) || (sub_idx == 4))
-			ret |= P(SNOOP, HIT);
-		else if ((sub_idx == 1) || (sub_idx == 3) || (sub_idx == 5))
-			ret |= P(SNOOP, HITM);
+		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
+			ret = REM | P(HOPS, 0);
+
+			if (sub_idx == 0 || sub_idx == 4)
+				ret |= PH(LVL, L2) | LEVEL(L2) | P(SNOOP, HIT);
+			else if (sub_idx == 1 || sub_idx == 5)
+				ret |= PH(LVL, L2) | LEVEL(L2) | P(SNOOP, HITM);
+			else if (sub_idx == 2 || sub_idx == 6)
+				ret |= PH(LVL, L3) | LEVEL(L3) | P(SNOOP, HIT);
+			else if (sub_idx == 3 || sub_idx == 7)
+				ret |= PH(LVL, L3) | LEVEL(L3) | P(SNOOP, HITM);
+		} else {
+			if (sub_idx == 0)
+				ret = PH(LVL, L2) | LEVEL(L2) | REM | P(SNOOP, HIT) | P(HOPS, 0);
+			else if (sub_idx == 1)
+				ret = PH(LVL, L2) | LEVEL(L2) | REM | P(SNOOP, HITM) | P(HOPS, 0);
+			else if (sub_idx == 2 || sub_idx == 4)
+				ret = PH(LVL, L3) | LEVEL(L3) | REM | P(SNOOP, HIT) | P(HOPS, 0);
+			else if (sub_idx == 3 || sub_idx == 5)
+				ret = PH(LVL, L3) | LEVEL(L3) | REM | P(SNOOP, HITM) | P(HOPS, 0);
+		}
 		break;
 	case 6:
 		ret = PH(LVL, REM_CCE2);
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 4a2cbc3dc047..ff122603989b 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -273,6 +273,8 @@
 #define P(a, b)				PERF_MEM_S(a, b)
 #define PH(a, b)			(P(LVL, HIT) | P(a, b))
 #define PM(a, b)			(P(LVL, MISS) | P(a, b))
+#define LEVEL(x)			P(LVLNUM, x)
+#define REM				P(REMOTE, REMOTE)
 
 int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp, u64 event_config1);
 int isa207_compute_mmcr(u64 event[], int n_ev,
-- 
2.26.2

