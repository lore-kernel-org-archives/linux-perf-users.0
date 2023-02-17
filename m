Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1328C05027
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Feb 2023 20:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBQUTq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBQUTp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Feb 2023 15:19:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159AD5F812
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Feb 2023 12:19:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C13BB82D1D
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Feb 2023 20:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C517C433D2;
        Fri, 17 Feb 2023 20:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676665181;
        bh=dbB6CcifEQa8Ji/ciEHNfB6bXYW8j5MS0/6hgubfde0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAtVCPSW/8iMRPPOnUI/NurcKSXtzlP/M6HiyWMQ+79cplQq08Rk3gkdl5oLSnIoa
         x3dLOL/lqqqUl7Au1JEwQqP0lWLcO1L3kpdUmnocg3DJgtlAlwFLfjrvUK2o0RDxrt
         5UBLpRI1vFpGpvwonMsd4QxzDPqETYhtkqkwjjjhgM7Lmrk8onxOfnIynQGJM+L/8i
         JD/UY/6O0Oi8IB8k8vRkb6wi4vcnJbY7UdjK3mpjOrQEfPnhV3T47ZKpRAiDG4DQi4
         qUjFGF/pBj6E9a/geHyXln+OrLaYw4EAUu6tOb+o6uLNFNDZ5ScXFMuNQFyyqFBe6C
         lR6JvPDrOuznw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9D0A040025; Fri, 17 Feb 2023 17:19:38 -0300 (-03)
Date:   Fri, 17 Feb 2023 17:19:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, mpe@ellerman.id.au,
        jolsa@kernel.org, ak@linux.intel.com, namhyung@kernel.org,
        james.clark@arm.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.ibm.com
Subject: Re: [PATCH] powerpc/perf: Add json metric events to present CPI
 stall cycles in powerpc
Message-ID: <Y+/hWuRFPZwjcIxh@kernel.org>
References: <20230216061240.18067-1-atrajeev@linux.vnet.ibm.com>
 <CAP-5=fWBb2=g82uVTkUbENThsnZyhzU+BHWVpuM7iYWDuA_TqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWBb2=g82uVTkUbENThsnZyhzU+BHWVpuM7iYWDuA_TqA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Feb 16, 2023 at 10:10:05AM -0800, Ian Rogers escreveu:
> On Wed, Feb 15, 2023 at 10:12 PM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
> >
> > Power10 Performance Monitoring Unit (PMU) provides events
> > to understand stall cycles of different pipeline stages.
> > These events along with completed instructions provides
> > useful metrics for application tuning.
> >
> > Patch implements the json changes to collect counter statistics
> > to present the high level CPI stall breakdown metrics. New metric
> > group is named as "CPI_STALL_RATIO" and this new metric group
> > presents these stall metrics:
> > - DISPATCHED_CPI ( Dispatch stall cycles per insn )
> > - ISSUE_STALL_CPI ( Issue stall cycles per insn )
> > - EXECUTION_STALL_CPI ( Execution stall cycles per insn )
> > - COMPLETION_STALL_CPI ( Completition stall cycles per insn )
> >
> > To avoid multipling of events, PM_RUN_INST_CMPL event has been
> > modified to use PMC5(performance monitoring counter5) instead
> > of PMC4. This change is needed, since completion stall event
> > is using PMC4.
> >
> > Usage example:
> >
> >  ./perf stat --metric-no-group -M CPI_STALL_RATIO <workload>
> >
> >  Performance counter stats for 'workload':
> >
> >     63,056,817,982      PM_CMPL_STALL                    #     0.28 COMPLETION_STALL_CPI
> >  1,743,988,038,896      PM_ISSUE_STALL                   #     7.73 ISSUE_STALL_CPI
> >    225,597,495,030      PM_RUN_INST_CMPL                 #     6.18 DISPATCHED_CPI
> >                                                   #    37.48 EXECUTION_STALL_CPI
> >  1,393,916,546,654      PM_DISP_STALL_CYC
> >  8,455,376,836,463      PM_EXEC_STALL
> >
> > "--metric-no-group" is used for forcing PM_RUN_INST_CMPL to be scheduled
> > in all group for more accuracy.
> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

