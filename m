Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68590C77B7A
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 15:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241869AbjEYP4r (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241799AbjEYP4k (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 11:56:40 -0400
Received: from out-6.mta0.migadu.com (out-6.mta0.migadu.com [91.218.175.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF94C198
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 08:56:37 -0700 (PDT)
Date:   Thu, 25 May 2023 15:56:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685030195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0TaRl4n9XMPX8xYtktTsVXIPmY5xjSbUFHkUUq8DkmI=;
        b=hVrEFsfSK9zqWSTXkIGyFhD9rIX/jc87yhI5D8VjTZ8kI0yQmUL9HlGzmsvHXABFo+d9Ps
        X6Jlw84tCpkeImBdiDkjeaNPRnNo79FI+mRcdgm1fc+kYysuFOuXhQBYQF28pRtYJ9k3nK
        DdUZt+FFlvSHbvrwhbFsjVAif+Q0yIk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Nathan Chancellor <nathan@kernel.org>, namhyung@kernel.org,
        eranian@google.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, irogers@google.com, bp@alien8.de,
        kan.liang@linux.intel.com, adrian.hunter@intel.com,
        maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, maz@kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
Message-ID: <ZG+FLdP2kkfI1m2Z@linux.dev>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-4-ravi.bangoria@amd.com>
 <20230524214133.GA2359762@dev-arch.thelio-3990X>
 <f02c78e2-34b9-4985-640a-279dae1004a9@amd.com>
 <ZG8KLbZSECiYaKFc@linux.dev>
 <20230525142031.GU83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525142031.GU83892@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 25, 2023 at 04:20:31PM +0200, Peter Zijlstra wrote:
> On Thu, May 25, 2023 at 07:11:41AM +0000, Oliver Upton wrote:
> 
> > The PMUv3 driver does pass a name, but it relies on getting back an
> > allocated pmu id as @type is -1 in the call to perf_pmu_register().
> > 
> > What actually broke is how KVM probes for a default core PMU to use for
> > a guest. kvm_pmu_probe_armpmu() creates a counter w/ PERF_TYPE_RAW and
> > reads the pmu from the returned perf_event. The linear search had the
> > effect of eventually stumbling on the correct core PMU and succeeding.
> > 
> > Perf folks: is this WAI for heterogenous systems?
> 
> TBH, I'm not sure. hetero and virt don't mix very well AFAIK and I'm not
> sure what ARM64 does here.
> 
> IIRC the only way is to hard affine things; that is, force vCPU of
> 'type' to the pCPU mask of 'type' CPUs.

We provide absolutely no illusion of consistency across implementations.
Userspace can select the PMU type, and then it is a userspace problem
affining vCPUs to the right pCPUs.

And if they get that wrong, we just bail and refuse to run the vCPU.

> If you don't do that; or let userspace 'override' that, things go
> sideways *real* fast.

Oh yeah, and I wish PMUs were the only problem with these hetero
systems...

> Mark gonna have to look at this.

Cool. I'll go ahead with the KVM cleanup regardless of the outcome.

--
Thanks,
Oliver
