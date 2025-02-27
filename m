Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF321D599;
	Thu, 27 Feb 2025 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639910; cv=none; b=Z3NDmNUUOvrhe9nQl8iOMZPWvjiaPyhC+IjA83t7nRnJWTvcWH8vtZG4+S0O331Yo84Sw4sao+o8Q785GmeP67bkbHTCJ68kEePxN7XeJujNXWtfCxKiUgHag7HiqC5IGcjhzrvz4mbIuweYnY7by1lwWhWD9PbIfP3SgPi43+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639910; c=relaxed/simple;
	bh=x/fvxQXO3R9Lw7VjrELLy8bNhalAiL/Wcmz0kXpRovk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4Q9E9LBwL3cnq3vG+LorzJgzmU+yW13G6VYzpuQr9eb8r3Mc9rAZtdzKmOVa0Ep3zkfDp1Yx20U9WupW8Nu/oTSctVyohB88DEeWhnERVsNOkLRsHpOCWsNPFJQ3kmw7xDJGTl8UbqRiGbHp2238QoiN2Hqr76R0JiYJZeeBVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2PzNv+d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2PzNv+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F85C4CEDD;
	Thu, 27 Feb 2025 07:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740639910;
	bh=x/fvxQXO3R9Lw7VjrELLy8bNhalAiL/Wcmz0kXpRovk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e2PzNv+dc6QwbxX8E6WheaomB4CsP0CeHFi4lakvzTeBNCR/P+kXc3Cem3UbuKLre
	 UH7wLyRQXSUdHtVFcsMhTfoh+yGj2dzVQTFjxiNtXlnsFYhHwYriqTGUZU64+7yFHz
	 6bDAjOBkCOohHApVotttaw7RDGOqw1voJ2vcC3Yw5HuqYQRhfp95nUlEYInBNxkcrQ
	 hmMjejl1ddEiXrKARMGSmylunvW62NTE09VE6sXfot003UXxI+beJCPgA85Mv9q5Pk
	 GIL0VbE5KZatmtCrrfPdeA/xS6mPeXXloWVBM/rZRM2fcsm6DhKW+BAJ1WRorbIj9z
	 F+AWRGr7klqlQ==
Date: Wed, 26 Feb 2025 23:05:08 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Report error if set frequency
Message-ID: <Z8AOpLW6RSUU09Ns@google.com>
References: <20250205183009.224182-1-leo.yan@arm.com>
 <20250217082008.GA8144@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217082008.GA8144@e132581.arm.com>

Hello,

On Mon, Feb 17, 2025 at 08:20:08AM +0000, Leo Yan wrote:
> On Wed, Feb 05, 2025 at 06:30:09PM +0000, Leo Yan wrote:
> > When users set the parameter '-F' to specify frequency for Arm SPE, the
> > tool reports error:
> > 
> >   perf record -F 1000 -e arm_spe_0// -- sleep 1
> >   Error:
> >   Invalid event (arm_spe_0//) in per-thread mode, enable system wide with '-a'.
> > 
> > The output logs are confused and it does not give the correct reminding.
> > Arm SPE does not support frequency setting given it adopts a statistical
> > based approach.
> > 
> > Alternatively, Arm SPE supports setting period.  This commit adds a
> > for frequency setting.  It reports error and reminds users to set period
> > instead.
> > 
> > After:
> > 
> >   perf record -F 100 -e arm_spe_0// -- sleep 1
> >   Arm SPE: Frequency is not supported. Check manual 'man perf-record' on how to set period.
> > 
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> Gentle ping.

Sorry for the late reply.

Isn't it just -c <period> to set period for Arm SPE?  If so, it'd be
better to say that explicitly.

Thanks,
Namhyung

> 
> > ---
> >  tools/perf/arch/arm64/util/arm-spe.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> > index 4301181b8e45..baef0812dc19 100644
> > --- a/tools/perf/arch/arm64/util/arm-spe.c
> > +++ b/tools/perf/arch/arm64/util/arm-spe.c
> > @@ -40,6 +40,19 @@ struct arm_spe_recording {
> >  	bool			*wrapped;
> >  };
> >  
> > +/* Iterate config list to detect if the "freq" parameter is set */
> > +static bool arm_spe_is_set_freq(struct evsel *evsel)
> > +{
> > +	struct evsel_config_term *term;
> > +
> > +	list_for_each_entry(term, &evsel->config_terms, list) {
> > +		if (term->type == EVSEL__CONFIG_TERM_FREQ)
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  /*
> >   * arm_spe_find_cpus() returns a new cpu map, and the caller should invoke
> >   * perf_cpu_map__put() to release the map after use.
> > @@ -389,6 +402,13 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
> >  				return -EINVAL;
> >  			}
> >  			opts->full_auxtrace = true;
> > +
> > +			if (opts->user_freq != UINT_MAX ||
> > +			    arm_spe_is_set_freq(evsel)) {
> > +				pr_err("Arm SPE: Frequency is not supported. "
> > +				       "Check manual 'man perf-record' on how to set period.\n");
> > +				return -EINVAL;
> > +			}
> >  		}
> >  	}
> >  
> > -- 
> > 2.34.1
> > 
