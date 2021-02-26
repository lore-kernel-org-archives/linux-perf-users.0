Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB1C433E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Feb 2021 05:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A5464E60
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Feb 2021 05:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhBZFeX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Feb 2021 00:34:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229482AbhBZFeI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Feb 2021 00:34:08 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q5Wtbt042701;
        Fri, 26 Feb 2021 00:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bO1anYwVvQVltDafqeTvliRLVSy+FmejRj0vltLJCyU=;
 b=XIP8WcR1K1r+sLDDEozJzWoFA6uoLnnFvltk8unRns0VrN7S29zD35uKfO9gDo38NehN
 htRXH/aUQVk6UDup52eHt75sK6nwq1JQq0NBoHfz3okUL9jV04l1xDz4lndRTXa18hc1
 T8xhM9kLhCjdzs3sUE78BEz1Zo6YYAY89J8p3cNWfKCJIvQvFjIHYmtXAg4nmu8Eh3Bh
 sIxjyG+PV6o/40RdxQz8N8C6Lo7N2gdI01nrAWFRRz850Wk5kTAl0EjUZbBlLnjh0Dby
 PfcfJdvNggmYla2BEaTuqtRTQzer9kuxC4DbMDb4BWnr2Dbbk/2uYbxSHY8TlmJPMdF0 mw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36xtfy8ky8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 00:33:17 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11Q5XAoC007358;
        Fri, 26 Feb 2021 05:33:16 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 36tt2aq7na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 05:33:16 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11Q5XFfU17039700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 05:33:15 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 653E1AC05E;
        Fri, 26 Feb 2021 05:33:15 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85738AC05B;
        Fri, 26 Feb 2021 05:33:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.16.158])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 05:33:12 +0000 (GMT)
Subject: Re: [PATCH] [perf] powerpc: Remove unsupported metrics
To:     "Paul A. Clarke" <pc@us.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org
Cc:     mpe@ellerman.id.au, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com
References: <20210224181436.782091-1-pc@us.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <262409c9-11e2-3327-e645-604c9d300a2d@linux.ibm.com>
Date:   Fri, 26 Feb 2021 11:03:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210224181436.782091-1-pc@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_01:2021-02-24,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260042
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 2/24/21 11:44 PM, Paul A. Clarke wrote:
> Several metrics are defined based on unsupported / non-existent
> events, and silently discarded.  Remove them for good code hygiene
> and to avoid confusion.
> 

Hi Paul,
  Thanks for the patch. Changes looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
>  .../arch/powerpc/power9/metrics.json          | 132 ------------------
>  1 file changed, 132 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> index f8784c608479..140402d2855f 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> @@ -1209,156 +1209,24 @@
>          "MetricGroup": "instruction_stats_percent_per_ref",
>          "MetricName": "inst_from_rmem_percent"
>      },
> -    {
> -        "BriefDescription": "%L2 Modified CO Cache read Utilization (4 pclks per disp attempt)",
> -        "MetricExpr": "((PM_L2_CASTOUT_MOD/2)*4)/ PM_RUN_CYC * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_co_m_rd_util"
> -    },
> -    {
> -        "BriefDescription": "L2 dcache invalidates per run inst (per core)",
> -        "MetricExpr": "(PM_L2_DC_INV / 2) / PM_RUN_INST_CMPL * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_dc_inv_rate_percent"
> -    },
>      {
>          "BriefDescription": "Demand load misses as a % of L2 LD dispatches (per thread)",
>          "MetricExpr": "PM_L1_DCACHE_RELOAD_VALID / (PM_L2_LD / 2) * 100",
>          "MetricGroup": "l2_stats",
>          "MetricName": "l2_dem_ld_disp_percent"
>      },
> -    {
> -        "BriefDescription": "L2 Icache invalidates per run inst (per core)",
> -        "MetricExpr": "(PM_L2_IC_INV / 2) / PM_RUN_INST_CMPL * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_ic_inv_rate_percent"
> -    },
> -    {
> -        "BriefDescription": "L2 Inst misses as a % of total L2 Inst dispatches (per thread)",
> -        "MetricExpr": "PM_L2_INST_MISS / PM_L2_INST * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_inst_miss_ratio_percent"
> -    },
> -    {
> -        "BriefDescription": "Average number of cycles between L2 Load hits",
> -        "MetricExpr": "(PM_L2_LD_HIT / PM_RUN_CYC) / 2",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_ld_hit_frequency"
> -    },
> -    {
> -        "BriefDescription": "Average number of cycles between L2 Load misses",
> -        "MetricExpr": "(PM_L2_LD_MISS / PM_RUN_CYC) / 2",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_ld_miss_frequency"
> -    },
> -    {
> -        "BriefDescription": "L2 Load misses as a % of total L2 Load dispatches (per thread)",
> -        "MetricExpr": "PM_L2_LD_MISS / PM_L2_LD * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_ld_miss_ratio_percent"
> -    },
> -    {
> -        "BriefDescription": "% L2 load disp attempts Cache read Utilization (4 pclks per disp attempt)",
> -        "MetricExpr": "((PM_L2_RCLD_DISP/2)*4)/ PM_RUN_CYC * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_ld_rd_util"
> -    },
> -    {
> -        "BriefDescription": "L2 load misses that require a cache write (4 pclks per disp attempt) % of pclks",
> -        "MetricExpr": "((( PM_L2_LD_DISP - PM_L2_LD_HIT)/2)*4)/ PM_RUN_CYC * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_ldmiss_wr_util"
> -    },
> -    {
> -        "BriefDescription": "L2 local pump prediction success",
> -        "MetricExpr": "PM_L2_LOC_GUESS_CORRECT / (PM_L2_LOC_GUESS_CORRECT + PM_L2_LOC_GUESS_WRONG) * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_local_pred_correct_percent"
> -    },
> -    {
> -        "BriefDescription": "L2 COs that were in M,Me,Mu state as a % of all L2 COs",
> -        "MetricExpr": "PM_L2_CASTOUT_MOD / (PM_L2_CASTOUT_MOD + PM_L2_CASTOUT_SHR) * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_mod_co_percent"
> -    },
> -    {
> -        "BriefDescription": "% of L2 Load RC dispatch atampts that failed because of address collisions and cclass conflicts",
> -        "MetricExpr": "(PM_L2_RCLD_DISP_FAIL_ADDR )/ PM_L2_RCLD_DISP * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_rc_ld_disp_addr_fail_percent"
> -    },
> -    {
> -        "BriefDescription": "% of L2 Load RC dispatch attempts that failed",
> -        "MetricExpr": "(PM_L2_RCLD_DISP_FAIL_ADDR + PM_L2_RCLD_DISP_FAIL_OTHER)/ PM_L2_RCLD_DISP * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_rc_ld_disp_fail_percent"
> -    },
> -    {
> -        "BriefDescription": "% of L2 Store RC dispatch atampts that failed because of address collisions and cclass conflicts",
> -        "MetricExpr": "PM_L2_RCST_DISP_FAIL_ADDR / PM_L2_RCST_DISP * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_rc_st_disp_addr_fail_percent"
> -    },
> -    {
> -        "BriefDescription": "% of L2 Store RC dispatch attempts that failed",
> -        "MetricExpr": "(PM_L2_RCST_DISP_FAIL_ADDR + PM_L2_RCST_DISP_FAIL_OTHER)/ PM_L2_RCST_DISP * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_rc_st_disp_fail_percent"
> -    },
> -    {
> -        "BriefDescription": "L2 Cache Read Utilization (per core)",
> -        "MetricExpr": "(((PM_L2_RCLD_DISP/2)*4)/ PM_RUN_CYC * 100) + (((PM_L2_RCST_DISP/2)*4)/PM_RUN_CYC * 100) + (((PM_L2_CASTOUT_MOD/2)*4)/PM_RUN_CYC * 100)",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_rd_util_percent"
> -    },
> -    {
> -        "BriefDescription": "L2 COs that were in T,Te,Si,S state as a % of all L2 COs",
> -        "MetricExpr": "PM_L2_CASTOUT_SHR / (PM_L2_CASTOUT_MOD + PM_L2_CASTOUT_SHR) * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_shr_co_percent"
> -    },
>      {
>          "BriefDescription": "L2 Store misses as a % of total L2 Store dispatches (per thread)",
>          "MetricExpr": "PM_L2_ST_MISS / PM_L2_ST * 100",
>          "MetricGroup": "l2_stats",
>          "MetricName": "l2_st_miss_ratio_percent"
>      },
> -    {
> -        "BriefDescription": "% L2 store disp attempts Cache read Utilization (4 pclks per disp attempt)",
> -        "MetricExpr": "((PM_L2_RCST_DISP/2)*4) / PM_RUN_CYC * 100",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_st_rd_util"
> -    },
>      {
>          "BriefDescription": "L2 stores that require a cache write (4 pclks per disp attempt) % of pclks",
>          "MetricExpr": "((PM_L2_ST_DISP/2)*4) / PM_RUN_CYC * 100",
>          "MetricGroup": "l2_stats",
>          "MetricName": "l2_st_wr_util"
>      },
> -    {
> -        "BriefDescription": "L2 Cache Write Utilization (per core)",
> -        "MetricExpr": "((((PM_L2_LD_DISP - PM_L2_LD_HIT)/2)*4) / PM_RUN_CYC * 100) + (((PM_L2_ST_DISP/2)*4) / PM_RUN_CYC * 100)",
> -        "MetricGroup": "l2_stats",
> -        "MetricName": "l2_wr_util_percent"
> -    },
> -    {
> -        "BriefDescription": "Average number of cycles between L3 Load hits",
> -        "MetricExpr": "(PM_L3_LD_HIT / PM_RUN_CYC) / 2",
> -        "MetricGroup": "l3_stats",
> -        "MetricName": "l3_ld_hit_frequency"
> -    },
> -    {
> -        "BriefDescription": "Average number of cycles between L3 Load misses",
> -        "MetricExpr": "(PM_L3_LD_MISS / PM_RUN_CYC) / 2",
> -        "MetricGroup": "l3_stats",
> -        "MetricName": "l3_ld_miss_frequency"
> -    },
> -    {
> -        "BriefDescription": "Average number of Write-in machines used. 1 of 8 WI machines is sampled every L3 cycle",
> -        "MetricExpr": "(PM_L3_WI_USAGE / PM_RUN_CYC) * 8",
> -        "MetricGroup": "l3_stats",
> -        "MetricName": "l3_wi_usage"
> -    },
>      {
>          "BriefDescription": "Average icache miss latency",
>          "MetricExpr": "PM_IC_DEMAND_CYC / PM_IC_DEMAND_REQ",
> 
