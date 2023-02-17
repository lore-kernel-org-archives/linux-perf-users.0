Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E360BC636D6
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Feb 2023 20:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBQUW7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBQUW6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Feb 2023 15:22:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491BA12BF5
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Feb 2023 12:22:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A395A61FE7
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Feb 2023 20:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D971CC433D2;
        Fri, 17 Feb 2023 20:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676665376;
        bh=Xo11NmtvSdfZXdPABXXpW3Tbfo1JIumpBRzv3e++6I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8rAzFXJH8MsH5WBh7nNjCYbuacc6d90ansNAbGs7y3oRCNEU+hPWp46w8UF49yfF
         +5BVaEJNy/zBFsufpdLxt+unvr2IDIkz88JQvmJ3ZYYeySGPlhDkXivKUswuBQEbF4
         FBfkQQHD8UaHYHcCQvhRxD6Ui47Oz1qDkoVv4QsgkJQwTBoFlJpwQy9wgQu4bzsVz1
         4/Zq/pvjJ1/Le0JH3wlPnhmU7WpvbOvvvaSxe37Rc//scZ9mubsXLYg/sPz5Ru+bub
         aP909reAvlV41MWxSgc12y6B99WZbJN3yHSt4TOpENemxzdYM0DDBqh/lLpLaDZ2ou
         V6DIuNxEPV1Hw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6FA8A40025; Fri, 17 Feb 2023 17:22:53 -0300 (-03)
Date:   Fri, 17 Feb 2023 17:22:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        rnsastry@linux.ibm.com, disgoel@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com
Subject: Re: [PATCH v2] tools/perf/tests: Change true workload to sleep
 workload in all metric test for system wide check
Message-ID: <Y+/iHQy9cWOP0ZtN@kernel.org>
References: <20230215093827.124921-1-kjain@linux.ibm.com>
 <CAP-5=fWZxs432h_Vohe0WXaCATiUrTugpMzbYpKMseJpuj0h-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWZxs432h_Vohe0WXaCATiUrTugpMzbYpKMseJpuj0h-g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Feb 15, 2023 at 08:08:20AM -0800, Ian Rogers escreveu:
> On Wed, Feb 15, 2023 at 1:38 AM Kajol Jain <kjain@linux.ibm.com> wrote:
> >
> > Testcase stat_all_metrics.sh fails in powerpc:
> >
> > 98: perf all metrics test : FAILED!
> >
> > Logs with verbose:
> >
> > [command]# ./perf test 98 -vv
> >  98: perf all metrics test                                           :
> >  --- start ---
> > test child forked, pid 13262
> > Testing BRU_STALL_CPI
> > Testing COMPLETION_STALL_CPI
> >  ----
> > Testing TOTAL_LOCAL_NODE_PUMPS_P23
> > Metric 'TOTAL_LOCAL_NODE_PUMPS_P23' not printed in:
> > Error:
> > Invalid event (hv_24x7/PM_PB_LNS_PUMP23,chip=3/) in per-thread mode, enable system wide with '-a'.
> > Testing TOTAL_LOCAL_NODE_PUMPS_RETRIES_P01
> > Metric 'TOTAL_LOCAL_NODE_PUMPS_RETRIES_P01' not printed in:
> > Error:
> > Invalid event (hv_24x7/PM_PB_RTY_LNS_PUMP01,chip=3/) in per-thread mode, enable system wide with '-a'.
> >  ----
> >
> > Based on above logs, we could see some of the hv-24x7 metric events fails,
> > and logs suggest to run the metric event with -a option.
> > This change happened after the commit a4b8cfcabb1d ("perf stat: Delay metric
> > parsing"), which delayed the metric parsing phase and now before metric parsing
> > phase perf tool identifies, whether target is system-wide or not. With this
> > change, perf_event_open will fails with workload monitoring for uncore events
> > as expected.
> >
> > The perf all metric test case fails as some of the hv-24x7 metric events
> > may need bigger workload with system wide monitoring to get the data.
> > Fix this issue by changing current system wide check from true workload to
> > sleep 0.01 workload.
> >
> > Result with the patch changes in powerpc:
> >
> > 98: perf all metrics test : Ok
> >
> > Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Tested-by: Disha Goel <disgoel@linux.ibm.com>
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> 
> Tested-by: Ian Rogers <irogers@google.com>
> 
> The mention of a4b8cfcabb1d  can be moved to a Fixes tag so that this
> is backported.

Done, thanks, applied.

- Arnaldo
