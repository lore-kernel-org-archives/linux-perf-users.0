Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65182EE801F
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Sep 2023 16:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjIHQv2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Sep 2023 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjIHQv1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Sep 2023 12:51:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40D5D199F
        for <linux-perf-users@vger.kernel.org>; Fri,  8 Sep 2023 09:51:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF1B2D75;
        Fri,  8 Sep 2023 09:52:00 -0700 (PDT)
Received: from [10.57.36.28] (unknown [10.57.36.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 074C33F67D;
        Fri,  8 Sep 2023 09:51:21 -0700 (PDT)
Message-ID: <4e9f0148-61df-240d-166e-11119a2041dd@arm.com>
Date:   Fri, 8 Sep 2023 17:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Perf metrics for ARM64 Raspberry Pi
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jumana MP <jumana.mp@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Nick Forrington <Nick.Forrington@arm.com>,
        Ryan Harkin <Ryan.Harkin@arm.com>
References: <CAP-5=fXSiO87=tyax4p6uVHRhpWtK4HGPoMCYUEDcJxd+O67zA@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fXSiO87=tyax4p6uVHRhpWtK4HGPoMCYUEDcJxd+O67zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 07/09/2023 22:08, Ian Rogers wrote:
> Hi,
> 
> we have common metrics for ARM64:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/arm64/sbsa.json?h=perf-tools-next
> 
> but they don't apply on common platforms like raspberry pi 4 as
> standard metrics still need a reference from the model metrics to the
> standard one like:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json?h=perf-tools-next#n3
> 
> In the mapfile.csv a raspberry pi matches cortex-a57-a72 which has no
> metrics. I was wondering what it would take to add these metrics?
> However, it appears the standard metrics use events that are undefined
> at least in json like stall_slot_frontend:
> ```
> $ grep -r stall_slot_frontend tools/perf/pmu-events/arch/arm64/
> tools/perf/pmu-events/arch/arm64/sbsa.json:        "MetricExpr": "100
> * (stall_slot_frontend / (#slots * cpu_cycles))",
> ```
> as they are coming from sysfs:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/drivers/perf/arm_pmuv3.c?h=perf-tools-next#n233
> and are missing on the raspberry pi:
> ```
> $ ls /sys/devices/armv8_cortex_a72/events/
> br_mis_pred        cpu_cycles    l1d_cache         l1i_cache_refill  mem_access
> br_pred            exc_return    l1d_cache_refill  l1i_tlb_refill
> memory_error
> bus_access         exc_taken     l1d_cache_wb      l2d_cache         sw_incr
> bus_cycles         inst_retired  l1d_tlb_refill    l2d_cache_refill
> ttbr_write_retired
> cid_write_retired  inst_spec     l1i_cache         l2d_cache_wb
> ```
> Looking at:
> https://documentation-service.arm.com/static/60250c7395978b529036da86?token=
> It seems some of the metrics like "operations wasted" could be had
> even on earlier revision PMUs. Are there any plans in this regard?
> 
> Thanks,
> Ian

Hi Ian,

I don't think any of the sbsa metrics would work on RPi as it doesn't
have the events needed.

There are probably lots of other generic metrics like cache miss ratios
that would work though. But unfortunately the current workflow is for
Arm to publish per-CPU metrics and events and I'd say it's unlikely that
we'd publish anything for a72 now because of its age. They're also not
as interesting as the sbsa ones as they're usually just a ratio that's
pretty easy to work out manually.

I think that leaves a few options:

#1 Just manually copy existing metrics and edit for a72 based on which
events are available, and assume that the same formulae apply

#2 Come up with a bigger set of 'common' metrics and instead of opting
into them on a per-CPU basis, just show any metric where all the
required events are available. This kind of goes against the current
workflow where we publish per-CPU metrics, and could risk showing
misleading data

#3 Arm publishes metrics for a57/a72


Personally I like #3, as that continues to use the system that we've
already defined, but there is a chance it won't happen. Maybe we could
do #1 in this case as a one off or for other older cores that never had
metrics defined?

James
