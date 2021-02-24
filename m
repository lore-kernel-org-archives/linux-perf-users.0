Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF0CC433E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Feb 2021 18:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C124B64EF1
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Feb 2021 18:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhBXSPj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Feb 2021 13:15:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234785AbhBXSPa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Feb 2021 13:15:30 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11OI5kum115523;
        Wed, 24 Feb 2021 13:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bvLd9znIMEdwA4Et3sUcFFgG14N43ltE7SEeelB8YXw=;
 b=qgbD6J8ZsUkdcIJA5uaAYCbNNyiqrmfa1lFscqW7B3g8CwNPik+mibYj7KBvmOrWJEDT
 NxwK4MXiGesiGYjQnUCsYycaE024Hld8lg2nX3ege6IF+QbAq/d9clVpIHPBki/OEcfY
 YmjcRcJw7dvohXMHJyBisTXZ2+MUUi9itiNHexvxd/6nuYwKSaoUcNFZEpNbPLry6+dn
 mI8SzRtMjaIw7WAhZweSmYnRuD8cUm8Dd3jq+nkVH4gJiujzRrJN0e5rph9KNeTfV4x8
 7n37ztdnWsljsFvvJNK0oxF0WO6bN4hlHWRsE1/Moc+kkipm1OAA9uUMgvlCZPfQkXV6 VQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wucr8sje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 13:14:40 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11OIC8Hg015901;
        Wed, 24 Feb 2021 18:14:37 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 36tt29rkr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:14:37 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11OIEb0O31195622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 18:14:37 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EED59124052;
        Wed, 24 Feb 2021 18:14:36 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5332124055;
        Wed, 24 Feb 2021 18:14:36 +0000 (GMT)
Received: from localhost (unknown [9.85.196.115])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 18:14:36 +0000 (GMT)
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org
Cc:     mpe@ellerman.id.au, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com
Subject: [PATCH] [perf] powerpc: Remove unsupported metrics
Date:   Wed, 24 Feb 2021 12:14:36 -0600
Message-Id: <20210224181436.782091-1-pc@us.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_08:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240140
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Several metrics are defined based on unsupported / non-existent
events, and silently discarded.  Remove them for good code hygiene
and to avoid confusion.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 .../arch/powerpc/power9/metrics.json          | 132 ------------------
 1 file changed, 132 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index f8784c608479..140402d2855f 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -1209,156 +1209,24 @@
         "MetricGroup": "instruction_stats_percent_per_ref",
         "MetricName": "inst_from_rmem_percent"
     },
-    {
-        "BriefDescription": "%L2 Modified CO Cache read Utilization (4 pclks per disp attempt)",
-        "MetricExpr": "((PM_L2_CASTOUT_MOD/2)*4)/ PM_RUN_CYC * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_co_m_rd_util"
-    },
-    {
-        "BriefDescription": "L2 dcache invalidates per run inst (per core)",
-        "MetricExpr": "(PM_L2_DC_INV / 2) / PM_RUN_INST_CMPL * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_dc_inv_rate_percent"
-    },
     {
         "BriefDescription": "Demand load misses as a % of L2 LD dispatches (per thread)",
         "MetricExpr": "PM_L1_DCACHE_RELOAD_VALID / (PM_L2_LD / 2) * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_dem_ld_disp_percent"
     },
-    {
-        "BriefDescription": "L2 Icache invalidates per run inst (per core)",
-        "MetricExpr": "(PM_L2_IC_INV / 2) / PM_RUN_INST_CMPL * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_ic_inv_rate_percent"
-    },
-    {
-        "BriefDescription": "L2 Inst misses as a % of total L2 Inst dispatches (per thread)",
-        "MetricExpr": "PM_L2_INST_MISS / PM_L2_INST * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_inst_miss_ratio_percent"
-    },
-    {
-        "BriefDescription": "Average number of cycles between L2 Load hits",
-        "MetricExpr": "(PM_L2_LD_HIT / PM_RUN_CYC) / 2",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_ld_hit_frequency"
-    },
-    {
-        "BriefDescription": "Average number of cycles between L2 Load misses",
-        "MetricExpr": "(PM_L2_LD_MISS / PM_RUN_CYC) / 2",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_ld_miss_frequency"
-    },
-    {
-        "BriefDescription": "L2 Load misses as a % of total L2 Load dispatches (per thread)",
-        "MetricExpr": "PM_L2_LD_MISS / PM_L2_LD * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_ld_miss_ratio_percent"
-    },
-    {
-        "BriefDescription": "% L2 load disp attempts Cache read Utilization (4 pclks per disp attempt)",
-        "MetricExpr": "((PM_L2_RCLD_DISP/2)*4)/ PM_RUN_CYC * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_ld_rd_util"
-    },
-    {
-        "BriefDescription": "L2 load misses that require a cache write (4 pclks per disp attempt) % of pclks",
-        "MetricExpr": "((( PM_L2_LD_DISP - PM_L2_LD_HIT)/2)*4)/ PM_RUN_CYC * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_ldmiss_wr_util"
-    },
-    {
-        "BriefDescription": "L2 local pump prediction success",
-        "MetricExpr": "PM_L2_LOC_GUESS_CORRECT / (PM_L2_LOC_GUESS_CORRECT + PM_L2_LOC_GUESS_WRONG) * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_local_pred_correct_percent"
-    },
-    {
-        "BriefDescription": "L2 COs that were in M,Me,Mu state as a % of all L2 COs",
-        "MetricExpr": "PM_L2_CASTOUT_MOD / (PM_L2_CASTOUT_MOD + PM_L2_CASTOUT_SHR) * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_mod_co_percent"
-    },
-    {
-        "BriefDescription": "% of L2 Load RC dispatch atampts that failed because of address collisions and cclass conflicts",
-        "MetricExpr": "(PM_L2_RCLD_DISP_FAIL_ADDR )/ PM_L2_RCLD_DISP * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_rc_ld_disp_addr_fail_percent"
-    },
-    {
-        "BriefDescription": "% of L2 Load RC dispatch attempts that failed",
-        "MetricExpr": "(PM_L2_RCLD_DISP_FAIL_ADDR + PM_L2_RCLD_DISP_FAIL_OTHER)/ PM_L2_RCLD_DISP * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_rc_ld_disp_fail_percent"
-    },
-    {
-        "BriefDescription": "% of L2 Store RC dispatch atampts that failed because of address collisions and cclass conflicts",
-        "MetricExpr": "PM_L2_RCST_DISP_FAIL_ADDR / PM_L2_RCST_DISP * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_rc_st_disp_addr_fail_percent"
-    },
-    {
-        "BriefDescription": "% of L2 Store RC dispatch attempts that failed",
-        "MetricExpr": "(PM_L2_RCST_DISP_FAIL_ADDR + PM_L2_RCST_DISP_FAIL_OTHER)/ PM_L2_RCST_DISP * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_rc_st_disp_fail_percent"
-    },
-    {
-        "BriefDescription": "L2 Cache Read Utilization (per core)",
-        "MetricExpr": "(((PM_L2_RCLD_DISP/2)*4)/ PM_RUN_CYC * 100) + (((PM_L2_RCST_DISP/2)*4)/PM_RUN_CYC * 100) + (((PM_L2_CASTOUT_MOD/2)*4)/PM_RUN_CYC * 100)",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_rd_util_percent"
-    },
-    {
-        "BriefDescription": "L2 COs that were in T,Te,Si,S state as a % of all L2 COs",
-        "MetricExpr": "PM_L2_CASTOUT_SHR / (PM_L2_CASTOUT_MOD + PM_L2_CASTOUT_SHR) * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_shr_co_percent"
-    },
     {
         "BriefDescription": "L2 Store misses as a % of total L2 Store dispatches (per thread)",
         "MetricExpr": "PM_L2_ST_MISS / PM_L2_ST * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_st_miss_ratio_percent"
     },
-    {
-        "BriefDescription": "% L2 store disp attempts Cache read Utilization (4 pclks per disp attempt)",
-        "MetricExpr": "((PM_L2_RCST_DISP/2)*4) / PM_RUN_CYC * 100",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_st_rd_util"
-    },
     {
         "BriefDescription": "L2 stores that require a cache write (4 pclks per disp attempt) % of pclks",
         "MetricExpr": "((PM_L2_ST_DISP/2)*4) / PM_RUN_CYC * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_st_wr_util"
     },
-    {
-        "BriefDescription": "L2 Cache Write Utilization (per core)",
-        "MetricExpr": "((((PM_L2_LD_DISP - PM_L2_LD_HIT)/2)*4) / PM_RUN_CYC * 100) + (((PM_L2_ST_DISP/2)*4) / PM_RUN_CYC * 100)",
-        "MetricGroup": "l2_stats",
-        "MetricName": "l2_wr_util_percent"
-    },
-    {
-        "BriefDescription": "Average number of cycles between L3 Load hits",
-        "MetricExpr": "(PM_L3_LD_HIT / PM_RUN_CYC) / 2",
-        "MetricGroup": "l3_stats",
-        "MetricName": "l3_ld_hit_frequency"
-    },
-    {
-        "BriefDescription": "Average number of cycles between L3 Load misses",
-        "MetricExpr": "(PM_L3_LD_MISS / PM_RUN_CYC) / 2",
-        "MetricGroup": "l3_stats",
-        "MetricName": "l3_ld_miss_frequency"
-    },
-    {
-        "BriefDescription": "Average number of Write-in machines used. 1 of 8 WI machines is sampled every L3 cycle",
-        "MetricExpr": "(PM_L3_WI_USAGE / PM_RUN_CYC) * 8",
-        "MetricGroup": "l3_stats",
-        "MetricName": "l3_wi_usage"
-    },
     {
         "BriefDescription": "Average icache miss latency",
         "MetricExpr": "PM_IC_DEMAND_CYC / PM_IC_DEMAND_REQ",
-- 
2.27.0

