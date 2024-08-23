Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5731CD3D;
	Fri, 23 Aug 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425363; cv=none; b=O65rDNiijGwpZbR3SSJ7cdI4seFMG2n46+pbeVmuPIV4s9H4fiNo0NKvDC1xKh9Kt+FTscgcs8bAw6UArWGjsmucXJh531QQNv2mqZZ1sayypTIXOJmqo42sQKanuRwVPuDZb0yTaRmMEEn0GtcUFqEUMPBH3qez7H9//CpKw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425363; c=relaxed/simple;
	bh=rEyyg+xn4o9Md6QUaT9B5lyqywHCgzfMkFreOWkBSaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GicUkWMn59GYR9MsrHLWGwxn64gb4NnOS3wxSxt8cWwtJuPefOnNR91uRPA4D0induH6q/BOMdhPYhMyIOWx+SB/QUl/mjBMXS18IAC6mK2/bROEiST5C/i+pTvcC5te2AU2jb3R9/n4NOep5Z7DOuhQwwyNyT2o//g9iZ3XnI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtSTONTe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtSTONTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6192CC32786;
	Fri, 23 Aug 2024 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724425363;
	bh=rEyyg+xn4o9Md6QUaT9B5lyqywHCgzfMkFreOWkBSaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtSTONTeITfK0dOc6MCAhM9vcByK8VWvN2cCbvfjVDscvcWxc802hhSDVC2b2GZ49
	 u79Jn/w6WBiAd8cphQmdjINCjkQMNq4mFV2IfJFM6+2W18G1O7jPp9WtDzX6AR93BA
	 CTiVYWO0Qv0sJsRNxVSdOd9Jix/WSxiygG1nLALDu9yZCSNJikW1jIDJxX4B9wgKbF
	 WtXv8KAaUbIQET1ru+UwkgcgHW1coc6cmxKpD+yXQOAxJFN4TVZK5K741bnESYLsy4
	 dayDnP4H+rJ0ALRo5JZcEGFIR7QftTpFnCafbz6FA8GvGyQojuDoWjIRUQZlWX7uI1
	 bwPedPz2GhB2A==
Date: Fri, 23 Aug 2024 16:02:36 +0100
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
Message-ID: <20240823150236.GA32691@willie-the-truck>
References: <20240807155153.2714025-1-james.clark@linaro.org>
 <20240816124459.GA24323@willie-the-truck>
 <177108bc-2bdd-4914-97cc-ee09dfef75c3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177108bc-2bdd-4914-97cc-ee09dfef75c3@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Aug 16, 2024 at 02:27:19PM +0100, James Clark wrote:
> 
> 
> On 16/08/2024 1:45 pm, Will Deacon wrote:
> > On Wed, Aug 07, 2024 at 04:51:53PM +0100, James Clark wrote:
> > > For other PMUs, PERF_SAMPLE_PHYS_ADDR requires perf_allow_kernel()
> > > rather than just perfmon_capable(). Because PMSCR_EL1_PA is another form
> > > of physical address, make it consistent and use perf_allow_kernel() for
> > > SPE as well. PMSCR_EL1_PCT and PMSCR_EL1_CX also get the same change.
> > > 
> > > This improves consistency and indirectly fixes the following error
> > > message which is misleading because perf_event_paranoid is not taken
> > > into account by perfmon_capable():
> > > 
> > >    $ perf record -e arm_spe/pa_enable/
> > > 
> > >    Error:
> > >    Access to performance monitoring and observability operations is
> > >    limited. Consider adjusting /proc/sys/kernel/perf_event_paranoid
> > >    setting ...
> > > 
> > > Suggested-by: Al Grant <al.grant@arm.com>
> > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > ---
> > > Changes since v1:
> > > 
> > >    * Export perf_allow_kernel() instead of sysctl_perf_event_paranoid
> > > 
> > >   drivers/perf/arm_spe_pmu.c | 9 ++++-----
> > >   include/linux/perf_event.h | 8 +-------
> > >   kernel/events/core.c       | 9 +++++++++
> > >   3 files changed, 14 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> > > index 9100d82bfabc..3569050f9cf3 100644
> > > --- a/drivers/perf/arm_spe_pmu.c
> > > +++ b/drivers/perf/arm_spe_pmu.c
> > > @@ -41,7 +41,7 @@
> > >   /*
> > >    * Cache if the event is allowed to trace Context information.
> > > - * This allows us to perform the check, i.e, perfmon_capable(),
> > > + * This allows us to perform the check, i.e, perf_allow_kernel(),
> > >    * in the context of the event owner, once, during the event_init().
> > >    */
> > >   #define SPE_PMU_HW_FLAGS_CX			0x00001
> > > @@ -50,7 +50,7 @@ static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_C
> > >   static void set_spe_event_has_cx(struct perf_event *event)
> > >   {
> > > -	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
> > > +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && !perf_allow_kernel(&event->attr))
> > >   		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;
> > 
> > The rationale for this change in the commit message is because other
> > drivers gate PERF_SAMPLE_PHYS_ADDR on perf_allow_kernel(). However,
> > putting the PID in contextidr doesn't seem to have anything to do with
> > that...
> > 
> 
> That is true, I suppose I was thinking of two reasons to do it this way that
> I didn't really elaborate on:
> 
> #1 because context IDs and physical timestamps didn't seem to be any more
> sensitive than physical addresses, so it wouldn't make sense for them to
> have a stricter permissions model than addresses.
> 
> #2 (although this is indirect and not really related to the driver) but Perf
> will still print the misleading warning when physical timestamps are
> requested. So some other fix would eventually have to be made for that.
> 
> I'm not sure if you are objecting to the permissions change for the other
> two things, or it's just a lack of reasoning in the commit message?

I'm just objecting to the rationale in the commit message not being
applicable to some of the changes made in the code. A much better rationale
to use perf_allow_kernel() is because of its integration with the LSM hooks.

Will
