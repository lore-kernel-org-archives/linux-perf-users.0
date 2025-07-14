Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A5A23D280
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505769; cv=none; b=H+4/c+g69S1A0W3YUioql0narKojz8S1kk3V5K+f59WhxJCHvGUZrNHYhxReOZVqRjYpfe+eAoUL2No+cm6LlTh5BytrDZcS3xTAD0M+fp1mXfY/g7XnfT69Hb70vDLxKnPCp206uCn1hHEh2TIxPOUI5qgqL0MlSS7n3V8rp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505769; c=relaxed/simple;
	bh=9IPI47ARytVLzFCC9emga0tUeIfntYWcjkTLFYHEFtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+n24ehztXb750mRsXPNyXUYgqTqT6jpAgU8acGOmes7wMrpbkrg26jb1c4jINtTrkAF8WP9fiyeadoeL4p0+Y/L/n0vCtGlar4Tw2SWQnyHnn4QNorN14ijcs6JIUxpLxLMO46xEI51E0C3D2hE/9RGKQKGOdEH+acRJypskmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB2831BC0;
	Mon, 14 Jul 2025 08:09:14 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B0CB3F66E;
	Mon, 14 Jul 2025 08:09:23 -0700 (PDT)
Date: Mon, 14 Jul 2025 16:09:21 +0100
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	German Gomez <german.gomez@arm.com>,
	Ali Saidi <alisaidi@amazon.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 01/14] drivers/perf: arm_spe: Expose event filter
Message-ID: <20250714150921.GE1093654@e132581.arm.com>
References: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
 <20250707-arm_spe_support_hitm_overhead_v1_public-v3-1-33ea82da3280@arm.com>
 <aHUBFGPck-O3vs9b@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHUBFGPck-O3vs9b@willie-the-truck>

Hi Will,

On Mon, Jul 14, 2025 at 02:07:32PM +0100, Will Deacon wrote:

[...]

> > +static u64 arm_spe_pmsevfr_res0(u16 pmsver)
> > +{
> > +	switch (pmsver) {
> > +	case ID_AA64DFR0_EL1_PMSVer_IMP:
> > +		return PMSEVFR_EL1_RES0_IMP;
> > +	case ID_AA64DFR0_EL1_PMSVer_V1P1:
> > +		return PMSEVFR_EL1_RES0_V1P1;
> > +	case ID_AA64DFR0_EL1_PMSVer_V1P2:
> > +	/* Return the highest version we support in default */
> > +	default:
> > +		return PMSEVFR_EL1_RES0_V1P2;
> > +	}
> > +}
> 
> Hmm. This logic was already a little shakey and so I'm not sure it's a
> good idea to expose it directly to userspace. Maintaining RES0 masks for
> different versions of SPE won't scale and there are already things that
> we can't sensibly handle. For example, E[8]:
> 
>   | When (FEAT_SPEv1p4 is implemented or filtering on event 8 is
>   | optionally supported) and event 8 is implemented:
> 
> So, stepping back, can we remove this stuff altogether? The bits are
> RAZ/WI in the case that the even is not implement, but that means that:
> 
>   | Software can rely on the field reading as all 0s, and on writes being
>   | ignored.
> 
> so why are we even bothering to police this?

It's fine with me to remove the validation for the event filter.

However, I have the following question in comment below.

> In other words, remove arm_spe_pmsevfr_res0() and the two checks that
> use it in arm_spe_pmu_event_init(). If userspace tries to filter events
> that aren't implemented, then it gets to keep the pieces.

Then the question is: what information should be exposed to userspace
so that tools can decide which events are valid?

I would suggest to expose a new entry, "caps/version", to indicate the
SPE version number. Tools can use this to apply the appropriate event
validation. Please let me know if this works for you.

Thanks,
Leo
