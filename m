Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A631C433E0
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C9B64E90
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhCCFCi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 00:02:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350736AbhCBMrB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 Mar 2021 07:47:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B39364EF0;
        Tue,  2 Mar 2021 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614689090;
        bh=Be5qQnnIDv7yAqmKdUzi98yJnhUHRrfI+svTaXcnv0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5HR/nV4EkXKgouqx23BsS689V71yeiLSSewrxBUnUdEQ7s+P+xkX51jv68IHs8u+
         hti0Jb8yK18qJ5cx6BaOYUQumdRxEEelbMXkxuq17cX9PApqZQXxnod6fRpHCQ4ywm
         EwZ4jeBPnlby8rCJiazZvbImP8yMhNsBtExi5DArcp3YwcgYjGpcG3DpQgn1KlbTQU
         0uidHCt0l7hDDyaNb55V6w6VqM4vLAttInkmW7CT+QY3KUdsbDKozgNr3oFrLax2UP
         rU2nWGPzePENVSpMMhueGZGatpSLyct0if6vegkQ/j6p9h+8AyTUgaQ5haUqa4ai8F
         m9E5u6JefSbJQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F298B40CD9; Tue,  2 Mar 2021 09:44:47 -0300 (-03)
Date:   Tue, 2 Mar 2021 09:44:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     "Paul A. Clarke" <pc@us.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com
Subject: Re: [PATCH] [perf] powerpc: Remove unsupported metrics
Message-ID: <YD4zP98AxJ2Enf0Y@kernel.org>
References: <20210224181436.782091-1-pc@us.ibm.com>
 <262409c9-11e2-3327-e645-604c9d300a2d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <262409c9-11e2-3327-e645-604c9d300a2d@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Feb 26, 2021 at 11:03:11AM +0530, kajoljain escreveu:
> 
> 
> On 2/24/21 11:44 PM, Paul A. Clarke wrote:
> > Several metrics are defined based on unsupported / non-existent
> > events, and silently discarded.  Remove them for good code hygiene
> > and to avoid confusion.
> > 
> 
> Hi Paul,
>   Thanks for the patch. Changes looks good to me.
> 
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks, applied to perf/core.

- Arnaldo

 
> Thanks,
> Kajol Jain
> 
> > Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > ---
> >  .../arch/powerpc/power9/metrics.json          | 132 ------------------
> >  1 file changed, 132 deletions(-)
> > 
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > index f8784c608479..140402d2855f 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > @@ -1209,156 +1209,24 @@
> >          "MetricGroup": "instruction_stats_percent_per_ref",
> >          "MetricName": "inst_from_rmem_percent"
> >      },
> > -    {
> > -        "BriefDescription": "%L2 Modified CO Cache read Utilization (4 pclks per disp attempt)",
> > -        "MetricExpr": "((PM_L2_CASTOUT_MOD/2)*4)/ PM_RUN_CYC * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_co_m_rd_util"
> > -    },
> > -    {
> > -        "BriefDescription": "L2 dcache invalidates per run inst (per core)",
> > -        "MetricExpr": "(PM_L2_DC_INV / 2) / PM_RUN_INST_CMPL * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_dc_inv_rate_percent"
> > -    },
> >      {
> >          "BriefDescription": "Demand load misses as a % of L2 LD dispatches (per thread)",
> >          "MetricExpr": "PM_L1_DCACHE_RELOAD_VALID / (PM_L2_LD / 2) * 100",
> >          "MetricGroup": "l2_stats",
> >          "MetricName": "l2_dem_ld_disp_percent"
> >      },
> > -    {
> > -        "BriefDescription": "L2 Icache invalidates per run inst (per core)",
> > -        "MetricExpr": "(PM_L2_IC_INV / 2) / PM_RUN_INST_CMPL * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_ic_inv_rate_percent"
> > -    },
> > -    {
> > -        "BriefDescription": "L2 Inst misses as a % of total L2 Inst dispatches (per thread)",
> > -        "MetricExpr": "PM_L2_INST_MISS / PM_L2_INST * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_inst_miss_ratio_percent"
> > -    },
> > -    {
> > -        "BriefDescription": "Average number of cycles between L2 Load hits",
> > -        "MetricExpr": "(PM_L2_LD_HIT / PM_RUN_CYC) / 2",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_ld_hit_frequency"
> > -    },
> > -    {
> > -        "BriefDescription": "Average number of cycles between L2 Load misses",
> > -        "MetricExpr": "(PM_L2_LD_MISS / PM_RUN_CYC) / 2",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_ld_miss_frequency"
> > -    },
> > -    {
> > -        "BriefDescription": "L2 Load misses as a % of total L2 Load dispatches (per thread)",
> > -        "MetricExpr": "PM_L2_LD_MISS / PM_L2_LD * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_ld_miss_ratio_percent"
> > -    },
> > -    {
> > -        "BriefDescription": "% L2 load disp attempts Cache read Utilization (4 pclks per disp attempt)",
> > -        "MetricExpr": "((PM_L2_RCLD_DISP/2)*4)/ PM_RUN_CYC * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_ld_rd_util"
> > -    },
> > -    {
> > -        "BriefDescription": "L2 load misses that require a cache write (4 pclks per disp attempt) % of pclks",
> > -        "MetricExpr": "((( PM_L2_LD_DISP - PM_L2_LD_HIT)/2)*4)/ PM_RUN_CYC * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_ldmiss_wr_util"
> > -    },
> > -    {
> > -        "BriefDescription": "L2 local pump prediction success",
> > -        "MetricExpr": "PM_L2_LOC_GUESS_CORRECT / (PM_L2_LOC_GUESS_CORRECT + PM_L2_LOC_GUESS_WRONG) * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_local_pred_correct_percent"
> > -    },
> > -    {
> > -        "BriefDescription": "L2 COs that were in M,Me,Mu state as a % of all L2 COs",
> > -        "MetricExpr": "PM_L2_CASTOUT_MOD / (PM_L2_CASTOUT_MOD + PM_L2_CASTOUT_SHR) * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_mod_co_percent"
> > -    },
> > -    {
> > -        "BriefDescription": "% of L2 Load RC dispatch atampts that failed because of address collisions and cclass conflicts",
> > -        "MetricExpr": "(PM_L2_RCLD_DISP_FAIL_ADDR )/ PM_L2_RCLD_DISP * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_rc_ld_disp_addr_fail_percent"
> > -    },
> > -    {
> > -        "BriefDescription": "% of L2 Load RC dispatch attempts that failed",
> > -        "MetricExpr": "(PM_L2_RCLD_DISP_FAIL_ADDR + PM_L2_RCLD_DISP_FAIL_OTHER)/ PM_L2_RCLD_DISP * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_rc_ld_disp_fail_percent"
> > -    },
> > -    {
> > -        "BriefDescription": "% of L2 Store RC dispatch atampts that failed because of address collisions and cclass conflicts",
> > -        "MetricExpr": "PM_L2_RCST_DISP_FAIL_ADDR / PM_L2_RCST_DISP * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_rc_st_disp_addr_fail_percent"
> > -    },
> > -    {
> > -        "BriefDescription": "% of L2 Store RC dispatch attempts that failed",
> > -        "MetricExpr": "(PM_L2_RCST_DISP_FAIL_ADDR + PM_L2_RCST_DISP_FAIL_OTHER)/ PM_L2_RCST_DISP * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_rc_st_disp_fail_percent"
> > -    },
> > -    {
> > -        "BriefDescription": "L2 Cache Read Utilization (per core)",
> > -        "MetricExpr": "(((PM_L2_RCLD_DISP/2)*4)/ PM_RUN_CYC * 100) + (((PM_L2_RCST_DISP/2)*4)/PM_RUN_CYC * 100) + (((PM_L2_CASTOUT_MOD/2)*4)/PM_RUN_CYC * 100)",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_rd_util_percent"
> > -    },
> > -    {
> > -        "BriefDescription": "L2 COs that were in T,Te,Si,S state as a % of all L2 COs",
> > -        "MetricExpr": "PM_L2_CASTOUT_SHR / (PM_L2_CASTOUT_MOD + PM_L2_CASTOUT_SHR) * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_shr_co_percent"
> > -    },
> >      {
> >          "BriefDescription": "L2 Store misses as a % of total L2 Store dispatches (per thread)",
> >          "MetricExpr": "PM_L2_ST_MISS / PM_L2_ST * 100",
> >          "MetricGroup": "l2_stats",
> >          "MetricName": "l2_st_miss_ratio_percent"
> >      },
> > -    {
> > -        "BriefDescription": "% L2 store disp attempts Cache read Utilization (4 pclks per disp attempt)",
> > -        "MetricExpr": "((PM_L2_RCST_DISP/2)*4) / PM_RUN_CYC * 100",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_st_rd_util"
> > -    },
> >      {
> >          "BriefDescription": "L2 stores that require a cache write (4 pclks per disp attempt) % of pclks",
> >          "MetricExpr": "((PM_L2_ST_DISP/2)*4) / PM_RUN_CYC * 100",
> >          "MetricGroup": "l2_stats",
> >          "MetricName": "l2_st_wr_util"
> >      },
> > -    {
> > -        "BriefDescription": "L2 Cache Write Utilization (per core)",
> > -        "MetricExpr": "((((PM_L2_LD_DISP - PM_L2_LD_HIT)/2)*4) / PM_RUN_CYC * 100) + (((PM_L2_ST_DISP/2)*4) / PM_RUN_CYC * 100)",
> > -        "MetricGroup": "l2_stats",
> > -        "MetricName": "l2_wr_util_percent"
> > -    },
> > -    {
> > -        "BriefDescription": "Average number of cycles between L3 Load hits",
> > -        "MetricExpr": "(PM_L3_LD_HIT / PM_RUN_CYC) / 2",
> > -        "MetricGroup": "l3_stats",
> > -        "MetricName": "l3_ld_hit_frequency"
> > -    },
> > -    {
> > -        "BriefDescription": "Average number of cycles between L3 Load misses",
> > -        "MetricExpr": "(PM_L3_LD_MISS / PM_RUN_CYC) / 2",
> > -        "MetricGroup": "l3_stats",
> > -        "MetricName": "l3_ld_miss_frequency"
> > -    },
> > -    {
> > -        "BriefDescription": "Average number of Write-in machines used. 1 of 8 WI machines is sampled every L3 cycle",
> > -        "MetricExpr": "(PM_L3_WI_USAGE / PM_RUN_CYC) * 8",
> > -        "MetricGroup": "l3_stats",
> > -        "MetricName": "l3_wi_usage"
> > -    },
> >      {
> >          "BriefDescription": "Average icache miss latency",
> >          "MetricExpr": "PM_IC_DEMAND_CYC / PM_IC_DEMAND_REQ",
> > 

-- 

- Arnaldo
