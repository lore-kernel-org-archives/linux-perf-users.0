Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1F1E8328;
	Mon, 28 Jul 2025 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726342; cv=none; b=erfJgxYDM4KdnVrVvntd8+dHFMbp5fQtRDBGSenaDzm9HXR8gfGyqbMh7TmsNwZxmYP0QqPV+7W+xJXiUfEatv0m22D8OebndvV5ZGEXKbBRCHfbGQjBfqdK+61yu9TPS1XSn3Iy+fdmF5VpXobwtGo9l66MSGUmjw/1aw5AVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726342; c=relaxed/simple;
	bh=GPXtLxgLQqeIpYw5RDwKxkiReN3KSzF3obIxX1uhxQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EK3MM940DYG+qnS5fK69CYUUfFwAW6SEyMYtZPYgXMwg6h6PnbBjL4PUaZm5zNbrBidUwMeGHeyf5xRHJMKbreYeeCr5MPqi3X2YRb+rHiE5TRhYTTatB6ZmPtemtJ6x/mcYTqtzOnTObSCnfmLgyEw2G4aOdgaORjoFW6MoZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDZY1xT5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDZY1xT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D3CC4CEE7;
	Mon, 28 Jul 2025 18:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753726342;
	bh=GPXtLxgLQqeIpYw5RDwKxkiReN3KSzF3obIxX1uhxQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDZY1xT5O0+AUOeaJs9m1W1k/Hmokisrp8wMgM2TdvuE6S6KWgcYGLK06Rc54DIaf
	 ZE549Ut19JH/HWn1GC9kPOcixmcUxaYtqsN1Ts5yQJ8ZkSYG+e0Xl7FMO2MnxcRJkT
	 oR+CbSXKcVaw8Y3MS9etJ/RV/oe3hzARoEkR3x++mTcArWo6myDPKSsUTVaCNAmFge
	 Xy4mNhtCW6yVZjKFLoz4+BlNjh8xLwclIMiL/slzZgcg8siULYMao2tCeVZihGH9Js
	 qnjgrzZHvATGhqnWL9WP4pIZaXcLSb1BeNb0ED5brsQvUBMoGgeCPVqwOG4aPWF43z
	 P7BlRbRb3eUnA==
Date: Mon, 28 Jul 2025 11:12:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "linux-actions@lists.infradead.org" <linux-actions@lists.infradead.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Wang, Weilin" <weilin.wang@intel.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"acme@kernel.org" <acme@kernel.org>,
	"afaerber@suse.de" <afaerber@suse.de>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 00/19] Intel TMA 5.1 metrics and event updates
Message-ID: <aIe9g7lb92XO_1_m@google.com>
References: <20250719034515.2000467-1-irogers@google.com>
 <e09bab119c9fb6b0c2b5bcd39c6f2b508445ca37.camel@intel.com>
 <aIA1YubpL7wpiC0X@google.com>
 <aIVX4RH7llNKQ4Xn@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIVX4RH7llNKQ4Xn@google.com>

On Sat, Jul 26, 2025 at 04:34:00PM -0700, Ian Rogers wrote:
> On Sat, Jul 26, 2025 at 03:34:09PM -0700, Namhyung Kim wrote:
> > On Tue, Jul 22, 2025 at 06:05:38PM -0700, Namhyung Kim wrote:
> > > On Tue, Jul 22, 2025 at 06:14:30PM +0000, Falcon, Thomas wrote:
> > > > On Fri, 2025-07-18 at 20:44 -0700, Ian Rogers wrote:
> > > > > Update events from:
> > > > > v1.31 -> v1.33 for alderlake
> > > > > v1.09 -> v1.12 for arrowlake
> > > > > v1.14 -> v1.16 for emeraldrapids
> > > > > v1.10 -> v1.12 for graniterpaids
> > > > > v1.14 -> v1.17 for lunarlake
> > > > > v1.14 -> v1.16 for meteorlake
> > > > > v1.28 -> v1.30 for sapphirerapids
> > > > > 
> > > > > Update TMA 5.0 to 5.1 removing the slots event workaround as the patch series:
> > > > > https://lore.kernel.org/lkml/20250719030517.1990983-1-irogers@google.com/
> > > > > is assumed.
> > > 
> > > So I'll merge this series after the above patchset.
> > 
> > Now I'm seeing this on my AMD machine.
> > 
> >   Found metric 'tma_info_system_cpu_utilization'                                  
> >   metric expr cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / msr@tsc\,cpu\=cpu_atom@ for tma_info_system_cpu_utilization
> >   metric expr tma_info_system_cpus_utilized / #num_cpus_online for tma_info_system_cpu_utilization
> >   metric expr cpu_core@CPU_CLK_UNHALTED.REF_TSC@ / msr@tsc\,cpu\=cpu_core@ for tma_info_system_cpus_utilized
> >   found event msr@tsc,cpu=cpu_core@                                               
> >   found event cpu_core@CPU_CLK_UNHALTED.REF_TSC@                                  
> >   Parsing metric events '{msr/tsc,cpu=cpu_core,metric-id=msr!3tsc!0cpu!2cpu_core!3/,cpu_core/CPU_CLK_UNHALTED.REF_TSC,metric-id=cpu_core!3CPU_CLK_UNHALTED.REF_TSC!3/}:W'
> >   event syntax error: '{msr/tsc,cpu=cpu_core,metric-id=msr!3tsc!0cpu!2cpu_core!..'
> >                         \___ Bad event or PMU                                     
> >                                                                                   
> >   Unable to find PMU or event on a PMU of 'msr'                                   
> >                                                                                   
> >   event syntax error: '{msr/tsc,cpu=cpu_core,metric-id=msr!3tsc!0cpu!2cpu_core!..'
> >                                     \___ not a valid PMU or CPU number            
> >                                                                                   
> >   event syntax error: '{msr/tsc,cpu=cpu_core,metric-id=msr!3tsc!0cpu!2cpu_core!..'
> >                                     \___ not a valid PMU or CPU number            
> >                                                                                   
> >   event syntax error: '{msr/tsc,cpu=cpu_core,metric-id=msr!3tsc!0cpu!2cpu_core!..'
> >                                     \___ not a valid PMU or CPU number            
> >                                                                                   
> >   event syntax error: '{msr/tsc,cpu=cpu_core,metric-id=msr!3tsc!0cpu!2cpu_core!..'
> >                                     \___ not a valid PMU or CPU number            
> >   Broken metric tma_info_system_cpu_utilization                                   
> >   ---- end(-1) ----                                                               
> >     9.3: Parsing of PMU event table metrics                            : FAILED! 
> >   
> >   parsing 'tma_info_mem_mix_memload_ratio': '1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / cpu_atom@UOPS_RETIRED.ALL@'
> >   parsing 'tma_info_serialization_%_tpause_cycles': '100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)'
> >   parsing 'tma_info_system_cpu_utilization': 'cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / msr@tsc\,cpu\=cpu_atom@'
> >   check_parse_fake failed                                                         
> >   ---- end(-1) ----                                                               
> >     9.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!

> Sorry for this. The parse state says whether fake pmus are used.
> Parse events needs updating for things like get_config_cpu so that
> failing to find a pmu is ignored with fake pmus enabled. Sorry for
> this, it is exposed in the updated metrics but the issue was caused
> by the prior series adding the support in the term.

No problem.  I've removed this series from the tree and we can fix the
issue once you're back.  Then add the metrics later.

Thanks,
Namhyung

