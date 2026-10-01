Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C163BD241;
	Thu,  1 Oct 2026 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838984; cv=none; b=dSEeqGqfGs1EliqQjrvguUB90rdoQVKiJjjPpvzMavKr9Dpa6pB70uJWlv4tGw072Bs4P8YrCCc3CDlMvSZlfctv3YRL/4xWewkJn3D/7tKBQSn9IPpn9gDEs6GQPU66EiWpxDxgQ2OU7lUtA+upooXl9jw6ItmsRC0Iy1x7TEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838984; c=relaxed/simple;
	bh=7616dSR0C2vuwuOm07V3UdWHY26IRi0xhf8L+Y9kvx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9ya15+NrTiImIb4uPJ8xOxpI6b3heE4lvd3ha4yOXRjbpa7lFqoFRYM6fafINxeijeQrq/d+KJ/ayLDamNNYYGTrtsAXpXW9ljEvziilEfXr7arh607tzk6qf+u2dssHFOHho3xHvNLuUSkup8QO0NGmgY1TW4gtIClnmsO09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGmiUefp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGmiUefp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977581F000FF;
	Thu,  1 Oct 2026 07:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790838976;
	bh=wXGrqQD9809RW+EIr/bRf710tUjrok9k7DNn43iscUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AGmiUefpQ6l75QZK6aeQlp9UPq1InEMepRYnLgKRKneJbssdvdgA0t6TjDBM6kQpZ
	 RvPaddId0hCVvOkKMb7AnE/Hm9Jslt4H0RSGIonOTjh2MhRHvFl5+LtyvxBvZFzfzf
	 3gqTiz6bvOdQjIX/37l2f7t5d4FeITcb5glYcxF/5WXerC4BGs/1KB8kX88zNeZfwJ
	 fsEzZDtnAKyMB1o3pKWJxNCeiSQTLmsfYniy9NGi+WQFVMnJB9BYoWukb/CLMek6pR
	 mN8rfZ6btQS8GV+5jxdc15FeCNMObU56CMgzMxynhW1d4NUrI/X19BPINawEoge6zT
	 6LszC3Cp6gx8A==
Date: Thu, 1 Oct 2026 08:16:09 +0100
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Michiel van Tol <michiel.vantol@arm.com>,
	Dev Jain <dev.jain@arm.com>, David Hildenbrand <david@kernel.org>,
	Yabin Cui <yabinc@google.com>, James Morse <james.morse@arm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf: arm_spe: Prefer large AUX mappings
Message-ID: <ar4Iuanz_vA4twGP@willie-the-truck>
References: <20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com>
 <20260810-perf_aux_trace_large_granule-v1-2-03306c9339e3@arm.com>
 <annp-BdTviQoH6vy@willie-the-truck>
 <20260930164311.GK14479@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930164311.GK14479@e132581.arm.com>

On Wed, Sep 30, 2026 at 05:43:11PM +0100, Leo Yan wrote:
> On Mon, Aug 10, 2026 at 04:10:48PM +0100, Will Deacon wrote:
> > On Mon, Aug 10, 2026 at 03:44:42PM +0100, Leo Yan wrote:
> > > Commit 18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by
> > > default") made the AUX allocator use order-0 pages by default unless a
> > > PMU explicitly asks for contiguous allocations.
> > 
> > But that commit specifically calls out SPE as benefitting from
> > non-contiguous pages:
> > 
> >   "For instance, ARM SPE and TRBE operate with virtual pages, and
> >    Coresight ETR allocates a separate buffer. For these PMUs,
> >    allocating contiguous AUX pages unnecessarily exacerbates memory
> >    fragmentation. This fragmentation can prevent their use on
> >    long-running devices."
> > 
> > so why doesn't passing PERF_PMU_CAP_AUX_PREFER_LARGE reintroduce the
> > problems that 18049c8cff9c was trying to solve?
> 
> How about adding a field to struct pmu to specify a preferred maximum
> page order for the AUX buffer? The perf core could try that order first
> and fall back to smaller orders if the allocation fails.

I'm not sure that's thr right place for it, really. The driver has no
clue about whether it makes sense to use large contiguous mappings or
not, so I'd have thought that decision should be driven from userspace
(e.g. like MADV_HUGEPAGE) because it really depends on the user's
preference and isn't a fixed property of the hardware.

> For example, the Neoverse V2 TRM documents:
> 
>   L1 Trace Buffer Extension (TRBE) TLB: 1 entry

Wow, they really pulled out the stops for that implementation. I bet
we're supposed to be grateful for that entry!

> Given the single L1 TRBE TLB entry, the TRBE driver could prefer
> PMD_ORDER (2 MiB with 4 KiB pages) to reduce TLB pressure. This reflects
> the hardware characteristic.
> 
> This could be a trade-off instead of using PERF_PMU_CAP_AUX_PREFER_LARGE,
> avoiding large contiguous allocations that could reintroduce the Android
> OOM issue. I did a quick test with this approach and the results look
> positive.

I really don't want the driver to second-guess userspace based on whatever
information it happens to have hard-coded about the specific CPU it's
running on.

Will
