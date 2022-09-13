Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAD1C6FA89
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Sep 2022 11:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiIML4P (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Sep 2022 07:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiIML4M (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Sep 2022 07:56:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A077C5EDE4
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Sep 2022 04:56:10 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DBOMqb029625;
        Tue, 13 Sep 2022 11:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bORI8nPEzXizoModcsBXnBINqL7ln5IsD/KPSGvKL2M=;
 b=PEDK8lyQpN7cHcs3PciLMzQNDoE2zBd3TEBGEbLZ7KVTTXO5da7d7GG3Zt3RyiTe0h1/
 P2a1HxyPXFzPBreqRTbF4x5+8sHQsN/xEJg8eIIxN5cJ0JLzCME/O2+zyFSeZk22uxe7
 EaInS//WDiodAgt+iUIfcqCV1LJ8zrvrcFi/2SZesqLW+aqo6pYR3hd9G9EaXrtjZ9El
 mrSJ5Zx92hqplwL+jIeMaspwC0CPlrnJUzsYtfrPA6fl8KiXWUUIItoNSLMo0hkHkay7
 J2S+Cl0sBVrpgjtdxvyhPxPZQ1IsWwYbjDzaztmdhJQ714jyMznWcuH5+Tlpfvx505fC cQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jjry8ry9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 11:55:56 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28DBoSGs012752;
        Tue, 13 Sep 2022 11:55:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3jghujbrtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 11:55:54 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28DBtphG41943316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 11:55:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E9F1A404D;
        Tue, 13 Sep 2022 11:55:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4B9FA4040;
        Tue, 13 Sep 2022 11:55:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.78.239])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 13 Sep 2022 11:55:48 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 1/3] powerpc/perf: Fix branch_filter support for multiple filters in powerpc
Date:   Tue, 13 Sep 2022 17:25:44 +0530
Message-Id: <20220913115546.36179-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eJatpsUtX2gMkk-humXOL3Gwv1fIDStD
X-Proofpoint-GUID: eJatpsUtX2gMkk-humXOL3Gwv1fIDStD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_05,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130052
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

For PERF_SAMPLE_BRANCH_STACK sample type, different branch_sample_type
ie branch filters are supported. The branch filters are requested via
event attribute "branch_sample_type". Multiple branch filters can be
passed in event attribute.

Example:
perf record -b -o- -B --branch-filter any,ind_call true

Powerpc does not support having multiple branch filters at
sametime. In powerpc, branch filters for branch stack sampling
is set via MMCRA IFM bits [32:33]. But currently when requesting
for multiple filter types, the "perf record" command does not
report any error.

Example:
perf record -b -o- -B --branch-filter any,save_type true
perf record -b -o- -B --branch-filter any,ind_call true

The "bhrb_filter_map" function in PMU driver code does the
validity check for supported branch filters. But this check
is done for single filter. Hence "perf record" will proceed
here without reporting any error.

Fix power_pmu_event_init to return EOPNOTSUPP when multiple
branch filters are requested in the event attr.

After the fix:
perf record --branch-filter any,ind_call -- ls
Error:
cycles: PMU Hardware doesn't support sampling/overflow-interrupts.
Try 'perf stat'

Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 13919eb96931..2c2d235cb8d8 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2131,6 +2131,21 @@ static int power_pmu_event_init(struct perf_event *event)
 	if (has_branch_stack(event)) {
 		u64 bhrb_filter = -1;
 
+		/*
+		 * powerpc does not support having multiple branch filters
+		 * at sametime. Branch filters are set via MMCRA IFM[32:33]
+		 * bits for power8 and above. Return EOPNOTSUPP when multiple
+		 * branch filters are requested in the event attr.
+		 *
+		 * When opening event via perf_event_open, branch_sample_type
+		 * gets adjusted in perf_copy_attr function. Kernel will
+		 * automatically adjust the branch_sample_type based on the
+		 * event modifier settings to include PERF_SAMPLE_BRANCH_PLM_ALL.
+		 * Hence drop the check for PERF_SAMPLE_BRANCH_PLM_ALL.
+		 */
+		if (hweight64(event->attr.branch_sample_type & ~PERF_SAMPLE_BRANCH_PLM_ALL) > 1)
+			return -EOPNOTSUPP;
+
 		if (ppmu->bhrb_filter_map)
 			bhrb_filter = ppmu->bhrb_filter_map(
 					event->attr.branch_sample_type);
-- 
2.31.1

