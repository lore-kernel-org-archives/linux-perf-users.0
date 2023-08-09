Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D4BEB64DD
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Aug 2023 08:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjHIIbt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 04:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjHIIbp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2023 04:31:45 -0400
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 01:31:42 PDT
Received: from out-65.mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40851B6
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Aug 2023 01:31:42 -0700 (PDT)
Date:   Wed, 9 Aug 2023 08:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691569514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yImomCKPQTRiIKKVrT+JgQNcw1+Vd7AbyPQl4wHTuks=;
        b=mFI5xz0M8wjVn59bTN51HUK3eQPqdXW7Qw4+KJiv4ABkiYig4iO0L8DrKdUsIG2OIF3CaL
        WUKXvfrgclxQ+xfgp5UQ6J+Eln/w45qy04+gZDUNVzyoWa6iJTDu3kjANDsDSTCbiPyahz
        DfurFvLnfWfyp0t9cYhvv8rZrn6VJfU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
        pbonzini@redhat.com, peterz@infradead.org, ingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-perf-users@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com
Subject: Re: [PATCH] perf/core: fix the bug in the event multiplexing
Message-ID: <ZNNNY3MlokEIj4y8@linux.dev>
References: <20230809013953.7692-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809013953.7692-1-shijie@os.amperecomputing.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Huang,

On Wed, Aug 09, 2023 at 09:39:53AM +0800, Huang Shijie wrote:
> 2.) Root cause.
> 	There is only 7 counters in my arm64 platform:
> 	  (one cycle counter) + (6 normal counters)
> 
> 	In 1.3 above, we will use 10 event counters.
> 	Since we only have 7 counters, the perf core will trigger
>        	event multiplexing in hrtimer:
> 	     merge_sched_in() -->perf_mux_hrtimer_restart() -->
> 	     perf_rotate_context().
> 
>        In the perf_rotate_context(), it does not restore some PMU registers
>        as context_switch() does.  In context_switch():
>              kvm_sched_in()  --> kvm_vcpu_pmu_restore_guest()
>              kvm_sched_out() --> kvm_vcpu_pmu_restore_host()
> 
>        So we got wrong result.

This is a rather vague description of the problem. AFAICT, the
issue here is on VHE systems we wind up getting the EL0 count
enable/disable bits backwards when entering the guest, which is
corroborated by the data you have below.

> +void arch_perf_rotate_pmu_set(void)
> +{
> +	if (is_guest())
> +		kvm_vcpu_pmu_restore_guest(NULL);
> +	else
> +		kvm_vcpu_pmu_restore_host(NULL);
> +}
> +

This sort of hook is rather nasty, and I'd strongly prefer a solution
that's confined to KVM. I don't think the !is_guest() branch is
necessary at all. Regardless of how the pmu context is changed, we need
to go through vcpu_put() before getting back out to userspace.

We can check for a running vCPU (ick) from kvm_set_pmu_events() and either
do the EL0 bit flip there or make a request on the vCPU to call
kvm_vcpu_pmu_restore_guest() immediately before reentering the guest.
I'm slightly leaning towards the latter, unless anyone has a better idea
here.

-- 
Thanks,
Oliver
