Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772449;
	b=vp3G6GxwUidaZXvMk2BG+7j/fqjv0FLEzen+8EZ7h0w4mUcUrG5TizmVN1fXo1vTpGp2
	 3prLh2BQ8wM1POm89hg4JVeiovmrusRmYw5QjIzrVgl708SdBRiacz105KicCvRtxvL6u
	 LMm4ezwZLGW1Jhx/NKtiV9yy4jgmXv2yO6v8qiYrVFfMDo7C+aoaNO2VfusXV+roz1cG4
	 nUHK5r/pquNTAaPu77HEmR+o01OZzkKPXUrqq4T1k8OrbJfkimiXzSIu/mhdNOaM0nyKJ
	 fsELhmIfEc6LX/DMdge4y9DrmOiwjsDSWjEd120IZxWWzDMUVrwH3sl69kzdX1gE0Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772449;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ixzsJEqZSaCdgkbAVN4kx81kYSraCcQkkJfMdCEcfCQ=;
	b=o5h1WkL20wfSP52tIh9GgHNJ853IKmf8leFHRtg71q0V8Qn+V3NNZZAdNXVwrZVDjxSY
	 ylVmkZh+p3DdiY1h1KUfLWxjJdo+JO+HH/ssRZF2i5s0eZMABHY57pq+BaWXvuST3Rsjv
	 UXokQ2FukZrUZ8vtWM7r1AWVktxencAvT97B+ZQUfrMEahrZl6nKyj+eYM5i221JpMZn0
	 8C+hL+ztsJ0m5Gq2kVSnL7U7ysfg00XNOaUg3kYHHQrE0eCo96x0p8+Z0GVSRU2NEJ1jH
	 tVPKpYy/UQ3rcZuMWeHOyXX9WgTQMvCBbgr1ehjtqRA28lr5nqrJt2H89FE+3YSL1wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oKh6KG/x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F0606A31C;
	Fri, 27 Nov 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKh6KG/x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA931F0089A;
	Fri, 27 Nov 2026 09:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795772448;
	bh=ixzsJEqZSaCdgkbAVN4kx81kYSraCcQkkJfMdCEcfCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oKh6KG/xNE+B30AOC6zPSBhJza3a036ajg9Rw/7HVi8sI7SKmIBI1XIPrjC5h6rae
	 POYLlmLNEb/3LEmRIGMyq8XEGxxGPZrOn85nuXrMuQRwcvq777ve/GDU+disB7pns3
	 b8s7Dpnk75GdSpAGIAqjccKZyreblsc0i+6YQHc49YeTlwcA2vo9HuPOReDQzQuot/
	 uKyvVFZPlTCfUZSYmtNQQDoloeI86kejZ0kWMfgla2/YZ1No0UkgkNq5paIH/QKxEq
	 HfGh/gzYA1X8yUEOk6E4rDycXzo5+A/nrsMTG/e2yuCqO3d+2xuhv7TOC4gnvprVFT
	 Q71sr5902XEnQ==
Date: Fri, 27 Nov 2026 10:40:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Gregg Leventhal <gleventhal@janestreet.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Barnett <mark.barnett@arm.com>, linux-kernel@vger.kernel.org,
	Jay Hilton <jahilton@janestreet.com>,
	Andrew Delgadillo <adelgadillo@janestreet.com>,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: [PATCH] perf/core: Use the elapsed period for frequency-mode
 period adjustment
Message-ID: <awlQGVla7eMls7V5@gmail.com>
References: <CAFN_u7G94CC_RGL1La66jX+jRKHSJdAB5PKkTRSWrUvqhM48oQ@mail.gmail.com>
 <20261117152351.1294050-1-gleventhal@janestreet.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117152351.1294050-1-gleventhal@janestreet.com>


* Gregg Leventhal <gleventhal@janestreet.com> wrote:

> From: Jay Hilton <jahilton@janestreet.com>
> 
> In frequency mode, __perf_event_account_interrupt() estimates the event
> rate from hwc->last_period and the time since the previous overflow,
> and passes it to perf_adjust_period().
> 
> The PMU drivers re-arm the counter before they call
> perf_event_overflow(), and re-arming sets hwc->last_period to the
> period of the next interval. The estimator therefore divides the next
> period by the time the previous one took. While the period ramps up
> from its initial value, each period is much larger than the previous
> one, so the rate is overestimated by that ratio and the period
> overshoots its target.
> 
> On an AMD EPYC 9655P running v7.3, sampling user-mode cycles at 11 Hz,
> the period jumped from 21.9M to 2.3G cycles, 5.6x the target, and the
> next sample arrived after 544 ms instead of 91 ms. When the overshoot
> exceeds 8x, the next tick's perf_adjust_period() resets period_left,
> and the cycles counted before the reset are not attributed to any
> sample (145M in that run). Intel and AMD IBS show the same overshoot.
> On Intel, intel_pmu_freq_start_period() hides it for the default
> hardware events, but not for raw events.
> 
> Since commit 1734d98fbcce ("perf/arch: Record sample last_period before
> updating on the x86 and PowerPC platforms"), the PMU drivers record the
> elapsed period in data->period before re-arming. Pass that to the
> estimator instead of hwc->last_period. perf_event_account_interrupt(),
> which has no sample data, keeps using hwc->last_period.

Thank you - I've applied this fix to tip:perf/urgent for a v7.4 merge,
with a Cc: stable tag.

> The Intel PEBS error path runs before re-arming and
> is fine. We haven't measured the IBS discard case; if it's worth
> fixing, those callers could pass the elapsed period too, in a
> follow-up.

Yeah, I think it's worth fixing, even if the effect is minor.

Note that I merged your post-commit description with the commit
message, both are interesting & relevant.

Thanks,

	Ingo
