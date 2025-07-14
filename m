Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE025D8F0
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506035; cv=none; b=jzBjKAZyHC+8t7L8n2HvpB9HvaFIEHVvWmfOo9ihxTffdTEzUO6VYbSLv/cmB5Glyu+HGvuETOoKFQTA6fIWt9BVWOcs/38fA75LHO8o5smRxpVTBurpgmy2+KjH8uQbblgN3vZwWtXEVWUApnUyRFfK8+NkRFbbJW8KdOyP26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506035; c=relaxed/simple;
	bh=RuTTRF7OLwegrBFSoaHi4OhveSoA5z5OHfS0WesWSuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtc8q2OW/RL6mOFv5wN/oMjvbJQRZFrpW8HsAUEX7u8SVlHr4SlWGMWI6W3Je5Y7aRd/oMB5cPCBdtKOLmToTI3zcz0p2ob1tNwJzbiw0hZ4p2DcjK2Lk4ya7wd1vB3MielEZM7cFSo70Vjfhx7+iCr8pJbpLej2GAQjeAiKbuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+IenNAq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+IenNAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB0DC4CEED;
	Mon, 14 Jul 2025 15:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506034;
	bh=RuTTRF7OLwegrBFSoaHi4OhveSoA5z5OHfS0WesWSuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+IenNAqGRh3utgTHbU95cdolX0hyF8IdKHgHUb52s/JXLkdkEldqVryb0omxuXsz
	 0YL1T4sfEVKl77sBUWlejocHJFsajqM6o8YJors6H+r7GpJA+DByC4L6/LqQRkh1CQ
	 wlJZv5gAnOT0V3OsibUduvv/My1hxIOiMVpBiq1bAlRKA2Edc5W3gM/jU+1NFDc18n
	 H6Aictxnpex/XU4uXcEs+VouMVCVFTHVoNwy6AIjwAj5CJO5mbJoCMAtAbV3yY/E8W
	 0gvfxsbYsEVYTEBhq8jrtJivc6z7ZPTT1bhuFHYzZG0OdtCoJWWlravWtQU1v/tdsu
	 3eSKEk5HzSsOw==
Date: Mon, 14 Jul 2025 16:13:49 +0100
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
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
Message-ID: <aHUerfpLyAPEc9R_@willie-the-truck>
References: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
 <20250707-arm_spe_support_hitm_overhead_v1_public-v3-1-33ea82da3280@arm.com>
 <aHUBFGPck-O3vs9b@willie-the-truck>
 <20250714150921.GE1093654@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714150921.GE1093654@e132581.arm.com>

On Mon, Jul 14, 2025 at 04:09:21PM +0100, Leo Yan wrote:
> On Mon, Jul 14, 2025 at 02:07:32PM +0100, Will Deacon wrote:
> 
> [...]
> 
> > > +static u64 arm_spe_pmsevfr_res0(u16 pmsver)
> > > +{
> > > +	switch (pmsver) {
> > > +	case ID_AA64DFR0_EL1_PMSVer_IMP:
> > > +		return PMSEVFR_EL1_RES0_IMP;
> > > +	case ID_AA64DFR0_EL1_PMSVer_V1P1:
> > > +		return PMSEVFR_EL1_RES0_V1P1;
> > > +	case ID_AA64DFR0_EL1_PMSVer_V1P2:
> > > +	/* Return the highest version we support in default */
> > > +	default:
> > > +		return PMSEVFR_EL1_RES0_V1P2;
> > > +	}
> > > +}
> > 
> > Hmm. This logic was already a little shakey and so I'm not sure it's a
> > good idea to expose it directly to userspace. Maintaining RES0 masks for
> > different versions of SPE won't scale and there are already things that
> > we can't sensibly handle. For example, E[8]:
> > 
> >   | When (FEAT_SPEv1p4 is implemented or filtering on event 8 is
> >   | optionally supported) and event 8 is implemented:
> > 
> > So, stepping back, can we remove this stuff altogether? The bits are
> > RAZ/WI in the case that the even is not implement, but that means that:
> > 
> >   | Software can rely on the field reading as all 0s, and on writes being
> >   | ignored.
> > 
> > so why are we even bothering to police this?
> 
> It's fine with me to remove the validation for the event filter.
> 
> However, I have the following question in comment below.
> 
> > In other words, remove arm_spe_pmsevfr_res0() and the two checks that
> > use it in arm_spe_pmu_event_init(). If userspace tries to filter events
> > that aren't implemented, then it gets to keep the pieces.
> 
> Then the question is: what information should be exposed to userspace
> so that tools can decide which events are valid?
> 
> I would suggest to expose a new entry, "caps/version", to indicate the
> SPE version number. Tools can use this to apply the appropriate event
> validation. Please let me know if this works for you.

I thought userspace typically had midr-based json files to figure this
stuff out? The supported events aren't probe-able afaict so I don't
think the driver can help.

Will
