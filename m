Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE622A93D;
	Thu, 24 Apr 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518497; cv=none; b=j1rNs1I3e9CJDLKkTcrGrcrQcOITxC5H6PgggAJEvx3X6GVAasHjqZ5V229E2Hvrh6bhE/cEh2WXH3My9eRyUs6BCIIM4tHU5kT6dR7nmn4TpC0/TyfFa8jn2RmmTAOTbjksjh6iOQwYIrP6JVRdgw7y3BOWgtr6BSQuoftWek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518497; c=relaxed/simple;
	bh=WFqtPfQdkLZLt+UyMUSZ9boxe3thilAnq9y5ADpkmEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofi/yh10iiIPRJoQPSqs132o/aGev6ibHpMSMtUI3WdLthpGiLdOq7xE57GFSvujMk4JtoGmOl2IvJz89cor095s0B82W0Y5Ym9OwWm4NPG2tBrU0vEKtm1q3o7t37oYcaKZNRa8TfsRGfxAHAMhQ+v9gyA+mYmRjC4tZCol4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBmrKgvr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBmrKgvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4F4C4CEE3;
	Thu, 24 Apr 2025 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745518495;
	bh=WFqtPfQdkLZLt+UyMUSZ9boxe3thilAnq9y5ADpkmEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBmrKgvrpNziHMooTnbcC/ZhKtRWBOryAFZ2gXZxXSl4k4jpDcvLeMFZ3f9Fc1LSb
	 8X8ySzW8rvtQiozGvzmuZILtfjShKf9jxZxIsmhQuzUkn7C5IB5dldWTD68CfQMXMn
	 3P0yeSZAI3ficPu2ocTyB4VtOKOH3ryEw5Lko2pYk4/GDANO8QznCuFGDcuVN5zTWH
	 0ZO9j+f7mFuOzduTkUPtFT4a+L5P3ExHh4trRUh+D+KF6b1C9UBlIopJpHpF9oe1nb
	 6PsSqfxjP7xmlPqze2Oi/UgyFZev+IEWq0jcI3/IPAKA6qEBdbR4okbJvKdjeScGyr
	 9aJCiZMJnujnQ==
Date: Thu, 24 Apr 2025 20:14:49 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86: Fix open counting event error
Message-ID: <aAp_mQadre6-aFg8@gmail.com>
References: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
 <aApkwfEUCJcc9PXn@gmail.com>
 <e85c1a65-fa55-457f-82d9-c25f6a4deb49@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e85c1a65-fa55-457f-82d9-c25f6a4deb49@linux.intel.com>


* Liang, Kan <kan.liang@linux.intel.com> wrote:

> 
> 
> On 2025-04-24 12:20 p.m., Ingo Molnar wrote:
> > 
> > * Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> > 
> >> Perf doesn't work at perf stat for hardware events:
> >>
> >>  $perf stat -- sleep 1
> >>  Performance counter stats for 'sleep 1':
> >>              16.44 msec task-clock                       #    0.016 CPUs utilized
> >>                  2      context-switches                 #  121.691 /sec
> >>                  0      cpu-migrations                   #    0.000 /sec
> >>                 54      page-faults                      #    3.286 K/sec
> >>    <not supported>	cycles
> >>    <not supported>	instructions
> >>    <not supported>	branches
> >>    <not supported>	branch-misses
> >>
> >> The reason is that the check in x86_pmu_hw_config for sampling event is
> >> unexpectedly applied to the counting event.
> >>
> >> Fixes: 88ec7eedbbd2 ("perf/x86: Fix low freqency setting issue")
> >> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> >> ---
> >>  arch/x86/events/core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> >> index 6866cc5acb0b..3a4f031d2f44 100644
> >> --- a/arch/x86/events/core.c
> >> +++ b/arch/x86/events/core.c
> >> @@ -629,7 +629,7 @@ int x86_pmu_hw_config(struct perf_event *event)
> >>  	if (event->attr.type == event->pmu->type)
> >>  		event->hw.config |= x86_pmu_get_event_config(event);
> >>  
> >> -	if (!event->attr.freq && x86_pmu.limit_period) {
> >> +	if (is_sampling_event(event) && !event->attr.freq && x86_pmu.limit_period) {
> > 
> > Hm, so how come it works here, on an affected x86 system:
> > 
> > $ perf stat -- sleep 1
> > 
> >  Performance counter stats for 'sleep 1':
> > 
> >               0.64 msec task-clock:u                     #    0.001 CPUs utilized             
> >                  0      context-switches:u               #    0.000 /sec                      
> >                  0      cpu-migrations:u                 #    0.000 /sec                      
> >                 73      page-faults:u                    #  114.063 K/sec                     
> >            325,849      instructions:u                   #    0.56  insn per cycle            
> >                                                   #    0.88  stalled cycles per insn   
> >            580,323      cycles:u                         #    0.907 GHz                       
> >            286,348      stalled-cycles-frontend:u        #   49.34% frontend cycles idle      
> >             72,623      branches:u                       #  113.474 M/sec                     
> >              4,713      branch-misses:u                  #    6.49% of all branches           
> > 
> > 
> > ?
> 
> It doesn't affect all X86 platforms. It should only impact the platforms
> with limit_period used for the non-pebs events. For Intel platforms, it
> should only impact some older platforms, e.g., HSW, BDW and NHM.
> 
> For other platforms, the x86_pmu.limit_period is invoked. But the left
> is not updated. So it still equals to event->attr.sample_period.
> It doesn't error out.
> 
> 	if (!event->attr.freq && x86_pmu.limit_period) {
> 		s64 left = event->attr.sample_period;
> 		x86_pmu.limit_period(event, &left);
> 		if (left > event->attr.sample_period)
> 			return -EINVAL;
> 	}

Makes sense. I've added this paragraph to the changelog:

    It should only impact x86 platforms with limit_period used for non-PEBS
    events. For Intel platforms, it should only impact some older platforms,
    e.g., HSW, BDW and NHM.

Thanks,

	Ingo
