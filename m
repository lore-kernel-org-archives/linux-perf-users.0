Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335E1B86F5;
	Fri, 16 Aug 2024 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812306; cv=none; b=kxIAoaizKN+XQu1EfnMj3ctZgbuiyUseK4dY36mQU8WreS6sXBKxIjBol+xZKexFLWRypfKFe9fCiZMlr1h48Gw+WSyYIWgAcsMuIj+ldD8Y3KRDYGReI2rDlXP7AOZdj3/7XBwY+8KF+Q5273FBE8gY9y0GUU17EiH3AHrcQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812306; c=relaxed/simple;
	bh=rtMrfjK8iEsHvD8MfwhuMO8zqNzjX/ypZgoq9vbE3yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xs/f1jgG9o1F0OFDR3Q0tl+vnZ8fSPCmrG5BWxEdrnWDkO2pfempCKHlDGD5GU/k2nlNax6zG13UDg+WS76I43kFgS2HjbH/gOf4RJEHaMOUsCJhIewKxh/qxbCe8qPoAPFqBPq/CvjiWhPmVdfQQLWNdDNMy+be43Q1AWR5RFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW+gvw8a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW+gvw8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1393C32782;
	Fri, 16 Aug 2024 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723812306;
	bh=rtMrfjK8iEsHvD8MfwhuMO8zqNzjX/ypZgoq9vbE3yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QW+gvw8aVVE6tW+fpjlsu7WK9H70UkisDnKbyNdj2xshVVYgVRQcg01mb2ah29xeM
	 DhRaJ7QgM6liVWP/9WYa6IKF6666qIqJa7/F1ChIhod1AcuImUJowETo4WVqzvg+wG
	 xD6cnOhQ/jdtZge2Vq61ZhSKxstoMWojwzd8EelQ8oJmamuel/DJxpWQtTzqjeS67b
	 gPoBy98TZMP+9I8H0UesSCxWROF2Imdr+lLrwuOKKTwAtsYyY9z/AbywaNrgwYUQ6A
	 CWBqjDeSSpJw9G3yGwgabNjmgXZnJ0KVrAWe3CZYXsQiSgmerwx2gLq29fP7ygLzLo
	 5+L2XfP+F3Ptg==
Date: Fri, 16 Aug 2024 13:45:00 +0100
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
	Al Grant <al.grant@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] drivers/perf: arm_spe: Use perf_allow_kernel() for
 permissions
Message-ID: <20240816124459.GA24323@willie-the-truck>
References: <20240807155153.2714025-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807155153.2714025-1-james.clark@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 07, 2024 at 04:51:53PM +0100, James Clark wrote:
> For other PMUs, PERF_SAMPLE_PHYS_ADDR requires perf_allow_kernel()
> rather than just perfmon_capable(). Because PMSCR_EL1_PA is another form
> of physical address, make it consistent and use perf_allow_kernel() for
> SPE as well. PMSCR_EL1_PCT and PMSCR_EL1_CX also get the same change.
> 
> This improves consistency and indirectly fixes the following error
> message which is misleading because perf_event_paranoid is not taken
> into account by perfmon_capable():
> 
>   $ perf record -e arm_spe/pa_enable/
> 
>   Error:
>   Access to performance monitoring and observability operations is
>   limited. Consider adjusting /proc/sys/kernel/perf_event_paranoid
>   setting ...
> 
> Suggested-by: Al Grant <al.grant@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Changes since v1:
> 
>   * Export perf_allow_kernel() instead of sysctl_perf_event_paranoid
> 
>  drivers/perf/arm_spe_pmu.c | 9 ++++-----
>  include/linux/perf_event.h | 8 +-------
>  kernel/events/core.c       | 9 +++++++++
>  3 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 9100d82bfabc..3569050f9cf3 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -41,7 +41,7 @@
>  
>  /*
>   * Cache if the event is allowed to trace Context information.
> - * This allows us to perform the check, i.e, perfmon_capable(),
> + * This allows us to perform the check, i.e, perf_allow_kernel(),
>   * in the context of the event owner, once, during the event_init().
>   */
>  #define SPE_PMU_HW_FLAGS_CX			0x00001
> @@ -50,7 +50,7 @@ static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_C
>  
>  static void set_spe_event_has_cx(struct perf_event *event)
>  {
> -	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
> +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && !perf_allow_kernel(&event->attr))
>  		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;

The rationale for this change in the commit message is because other
drivers gate PERF_SAMPLE_PHYS_ADDR on perf_allow_kernel(). However,
putting the PID in contextidr doesn't seem to have anything to do with
that...

>  }
>  
> @@ -745,9 +745,8 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  
>  	set_spe_event_has_cx(event);
>  	reg = arm_spe_event_to_pmscr(event);
> -	if (!perfmon_capable() &&
> -	    (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT)))
> -		return -EACCES;
> +	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))

Similarly here. What does the physical counter have to do with physical
address sampling other than sharing the word "physical"?

Will
