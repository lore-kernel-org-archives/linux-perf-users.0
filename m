Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F82765ED;
	Mon, 14 Sep 2026 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789346634; cv=none; b=CI+I+OeyLzgKatOs305jZCCXVQdovwPAZdft2gDB4cnFrAqCQ610/hdxN4I/t+PTnQY3hib6tqUwFZSyiRwbl0ZdhcimU4J1FiXUbnKnVE8a6DKHyd+PE82zaeNqX+Zdj6FUQlPWQbf+0hsNwr4l8H2wVxnnK5hyAXYvfoEHT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789346634; c=relaxed/simple;
	bh=aOppxkQjbj66SzuZa8DA79a5pGiE+52DHXubBbTwEA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4P26Gv0L6T56qRBWZ14js4/7yqBMS+Cf2TnJb59LNDfOneiPoVpJAwA52yc2ISw7X9zm5EVXHEQAGS9h4pCX6q34BACS99Lu8wBNAFR61uTahYDeuMqNpePylR6gOrAcY/h6Eradm4feSP4no5OM+hSW32jV9SKAZviysDV4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny5Nx2hp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny5Nx2hp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC83F1F000FF;
	Mon, 14 Sep 2026 00:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789346632;
	bh=hMdrZnl7GMSNqS8s9XDzRYe1n93DJ8JeY1FfH2sUYRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ny5Nx2hpwEQFzoUf2Yx3a1OYBQ7vXr1S7uqOp0I78em9aQfG2Yfr71o44ye+qLxDI
	 6ymtTrtTv13PFjW9paLTmA9rnLH6Z0WahQqLGDvORg3hAEStsUK1zCkufTHXoJG1tY
	 5gur5NYhIpubZ8gd+9I3/USCbCMjHxh4bVIpkx/bbgWUxNdb0AE/mHAejnjAF2+s+D
	 dYtBSJIU4V88iGstmsyx4+T0g7VfJOnBsaVc9A4IbyR6jU3vQI9C0m7kdHZZg7RUzi
	 GMUvBG23wbTUtsQaHtLh2GPu55UREKESFXgVlknKKdRSaKas1Vq+B5gtLClktEbpig
	 pc0j6V2gZsT1w==
Date: Sun, 13 Sep 2026 21:43:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf jevents: Add mesh bandwidth saturation for CWF,
 EMR, GRR, SNR, SPR, SRF
Message-ID: <aqdDRJ7kD_fyR2OI@x2>
References: <20260909220445.2117921-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909220445.2117921-1-irogers@google.com>

On Wed, Sep 09, 2026 at 03:04:45PM -0700, Ian Rogers wrote:
> Extend the mesh bandwidth saturation's list of events to include
> events from clearwaterforest, emeraldrapids, grandridge,
> graniterapids, sapphirerapids and sierraforest. This makes the
> lpm_mem_sat metric available for those CPU models.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/intel_metrics.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index bc2b920d3a0d..9780bf978a41 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -1099,7 +1099,8 @@ def UncoreMemSat() -> Optional[Metric]:
>      try:
>          clocks = Event("UNC_CHA_CLOCKTICKS", "UNC_C_CLOCKTICKS")
>          sat = Event("UNC_CHA_DISTRESS_ASSERTED.VERT", "UNC_CHA_FAST_ASSERTED.VERT",
> -                    "UNC_C_FAST_ASSERTED")
> +                    "UNC_C_FAST_ASSERTED", "UNC_CHA_DISTRESS_ASSERTED.DPT_ANY",
> +                    "UNC_CHA_DISTRESS_ASSERTED.DPT_NONLOCAL")
>      except:
>          return None
>  
> -- 
> 2.55.0.1003.g10538fe699-goog
