Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E126FD8B;
	Tue, 20 May 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737423; cv=none; b=q+EQmLixsfem2F1Wu5nI6S5HWbSge8LuB/IAjO3PHTgOeVAp2T6NqayA/VCKZnVdenH58sQe5/snfEbbBj3G2MJ83EAVr2t6UKkJc8b40l+QtKYrnLaWuPSiqCFtnn+VyKVHISPWFyQkrUSZYE7PQRfqFZGtXeqg6GfVOtMaFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737423; c=relaxed/simple;
	bh=8P+PeAk1ffcVBmib8pv1vtzYDhW5m/TICvR1L6ZpuQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBNyRo9NvBEKIchSlScIZkHrqGUxpmubOmo/TfEqm6GatlurWAm9bRRy/cLTXCtEg6sEMhV2od4uCkRVTK5dhUlTIktc0Pus2yXrpOni0HN1rLaT7oE0OGo3LiYFV6mOoZa0fWT36Es7sSopPqCqIRGXBklFMeeMkfsanuY6KyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N+6TpxHP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N+6TpxHP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PrBDpKNLE2QNKUOOwZ955vTK9TBp0M7rfERlp1Wzdps=; b=N+6TpxHPLX3ANst+9I1P20wm9I
	wDOpmw4u996gp5pIZd5AJ47p2eGekUtdz2e2kt7CfabQcU0Y61Mu2I6tUbA2GwGVDdqTxk0wbBonD
	wb82P7uhOcMxhjCSA7PpDsXG37JS7AL2pTkzOD+BCPnnORRn7NZ/qMb1qOjlfurqWvzkKgaSzYi/4
	cwnQ9G3zuywnuBMuRLtwP0C2RZK464QPquc/SFpHDI/jy+Hj1oDgRB2Eb8LLYoYhTE93aho+0L1i6
	j8d6yQkoKfTmc/aR5aG0GzTJPMUKDhX6z5HmIgyKuPWBREYILp5LqX6AtPPadq+sN91O0k8tqEZNH
	o4VD8+2A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHKL2-000000039VU-2Iwu;
	Tue, 20 May 2025 10:36:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 17B3D300677; Tue, 20 May 2025 12:36:48 +0200 (CEST)
Date: Tue, 20 May 2025 12:36:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
	ananth.narayan@amd.com, sandipan.das@amd.com,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v3 4/8] perf sched stats: Add support for report
 subcommand
Message-ID: <20250520103647.GH16434@noisy.programming.kicks-ass.net>
References: <20250311120230.61774-1-swapnil.sapkal@amd.com>
 <20250311120230.61774-5-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311120230.61774-5-swapnil.sapkal@amd.com>

On Tue, Mar 11, 2025 at 12:02:26PM +0000, Swapnil Sapkal wrote:
> `perf sched stats record` captures two sets of samples. For workload
> profile, first set right before workload starts and second set after
> workload finishes. For the systemwide profile, first set at the
> beginning of profile and second set on receiving SIGINT signal.
> 
> Add `perf sched stats report` subcommand that will read both the set
> of samples, get the diff and render a final report. Final report prints
> scheduler stat at cpu granularity as well as sched domain granularity.
> 
> Example usage:
> 
>   # perf sched stats record
>   # perf sched stats report
> 

> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category idle> ");
>  #endif
> +DOMAIN_FIELD(__u32, idle_lb_count,
> +	     "load_balance() count on cpu idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, idle_lb_balanced,
> +	     "load_balance() found balanced on cpu idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, idle_lb_failed,
> +	     "load_balance() move task failed on cpu idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance,
> +	     "imbalance sum on cpu idle", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, idle_lb_gained,
> +	     "pull_task() count on cpu idle", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, idle_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v15);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD("load_balance() success count on cpu idle", "%11u",
> +		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v15);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
> +		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v15);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category busy> ");
> +#endif
> +DOMAIN_FIELD(__u32, busy_lb_count,
> +	     "load_balance() count on cpu busy", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, busy_lb_balanced,
> +	     "load_balance() found balanced on cpu busy", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, busy_lb_failed,
> +	     "load_balance() move task failed on cpu busy", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance,
> +	     "imbalance sum on cpu busy", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, busy_lb_gained,
> +	     "pull_task() count on cpu busy", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, busy_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v15);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD("load_balance() success count on cpu busy", "%11u",
> +		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v15);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
> +		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v15);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category newidle> ");
> +#endif
> +DOMAIN_FIELD(__u32, newidle_lb_count,
> +	     "load_balance() count on cpu newly idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_balanced,
> +	     "load_balance() found balanced on cpu newly idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_failed,
> +	     "load_balance() move task failed on cpu newly idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance,
> +	     "imbalance sum on cpu newly idle", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_gained,
> +	     "pull_task() count on cpu newly idle", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v15);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD("load_balance() success count on cpu newly idle", "%11u",
> +		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v15);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
> +		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v15);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category active_load_balance()> ");
> +#endif
> +DOMAIN_FIELD(__u32, alb_count,
> +	     "active_load_balance() count", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, alb_failed,
> +	     "active_load_balance() move task failed", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, alb_pushed,
> +	     "active_load_balance() successfully moved a task", "%11u", false, v15);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category sched_balance_exec()> ");
> +#endif
> +DOMAIN_FIELD(__u32, sbe_count,
> +	     "sbe_count is not used", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, sbe_balanced,
> +	     "sbe_balanced is not used", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, sbe_pushed,
> +	     "sbe_pushed is not used", "%11u", false, v15);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category sched_balance_fork()> ");
> +#endif
> +DOMAIN_FIELD(__u32, sbf_count,
> +	     "sbf_count is not used", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, sbf_balanced,
> +	     "sbf_balanced is not used", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, sbf_pushed,
> +	     "sbf_pushed is not used", "%11u", false, v15);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Wakeup Info> ");
> +#endif
> +DOMAIN_FIELD(__u32, ttwu_wake_remote,
> +	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, ttwu_move_affine,
> +	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v15);
> +DOMAIN_FIELD(__u32, ttwu_move_balance,
> +	     "try_to_wake_up() started passive balancing", "%11u", false, v15);
> +#endif /* DOMAIN_FIELD */

So I have one request for a future version of this. Could we please add
a knob to print the output using the field name instead of the fancy
pants description?

It is *MUCH* easier to grep the field name in the code than to try and
figure out wth this description is on about :-)

That is, ttwu_wake_remote is infinitely better than "try_to_wake_up()
awake a task that last ran on a diff cpu" and so on.

I realize I might be weird, but it should be simple enough to add and it
makes my life easier :-)
