Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A261FDE31;
	Tue,  2 Dec 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764679364; cv=none; b=nfxrKZ/Jf/oO9+4+T9NHUkzAZ7wJcPJD+MnimTUQqeXWguoqnGntK9569YsIpyPmm5iAxerd4Dn6YT8Ro9+oV25dPMXZKBDX/fReCafNReMESQu0cKuqGQThbwHx3kQapMS3QM+qtguVU/+JmIY84eCrD99Ioa8zfZwCn9ozmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764679364; c=relaxed/simple;
	bh=UMC5iVOXoU+YoIk8eK6c+C1FSCwcMUhzSVxr6lk5N00=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYNYun/wYP65iCUUh93gMp9FxlHhm7jyvTPtKzk66i/75+0l/LuLZWH7r5EhOoXnx/nECP3KkV1phyOrhM6JQy++ysPQhahiPAaEq4f18p36TklO9arBIp++qwY72mEr02/elmCKuDLHXlknhPQsr6rKKxN8TbPOES15iWErMB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CE67153B;
	Tue,  2 Dec 2025 04:42:35 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 065FF3F73B;
	Tue,  2 Dec 2025 04:42:41 -0800 (PST)
Date: Tue, 2 Dec 2025 12:42:40 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/7] perf arm-spe: Don't hard code config attribute
Message-ID: <20251202124240.GA724103@e132581.arm.com>
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-7-22ecbbf8007c@linaro.org>
 <20251202122835.GY724103@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202122835.GY724103@e132581.arm.com>

On Tue, Dec 02, 2025 at 12:28:35PM +0000, Coresight ML wrote:
> On Mon, Dec 01, 2025 at 04:41:10PM +0000, Coresight ML wrote:
> > Use the config attribute that's published by the driver instead of
> > hard coding "attr.config".
> > 
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> >  tools/perf/arch/arm64/util/arm-spe.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> > index d5ec1408d0ae..6c3dc97fde30 100644
> > --- a/tools/perf/arch/arm64/util/arm-spe.c
> > +++ b/tools/perf/arch/arm64/util/arm-spe.c
> > @@ -256,7 +256,7 @@ static __u64 arm_spe_pmu__sample_period(const struct perf_pmu *arm_spe_pmu)
> >  
> >  static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
> >  {
> > -	u64 bit;
> > +	u64 pa_enable_bit;
> >  
> >  	evsel->core.attr.freq = 0;
> >  	evsel->core.attr.sample_period = arm_spe_pmu__sample_period(evsel->pmu);
> > @@ -288,9 +288,10 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
> >  	 * inform that the resulting output's SPE samples contain physical addresses
> >  	 * where applicable.
> >  	 */
> > -	bit = perf_pmu__format_bits(evsel->pmu, "pa_enable");
> > -	if (evsel->core.attr.config & bit)
> > -		evsel__set_sample_bit(evsel, PHYS_ADDR);
> > +
> > +	if (!evsel__get_config_val(evsel->pmu, evsel, "pa_enable", &pa_enable_bit))
> > +		if (pa_enable_bit)
> > +			evsel__set_sample_bit(evsel, PHYS_ADDR);
> 
> Hmm... I am a bit concerned for the evsel__get_config_val() usage
> throughout the series.
> 
> evsel__get_config_val() returns a whole config value rather than the
> bit field specified by the format name.  If other bits (but not the
> "pa_enable" bit) are set in the same config set, would it wrongly set
> the PHYS_ADDR sample bit?

I saw you used FIELD_GET() to read specific bit field in
evsel__get_config_val().  This is not concerned anymore.

Sorry for noise.

> Seems to me, for reading specific format, perf_pmu__format_bits() is
> more suitable than evsel__get_config_val().

For me, this comment is still valid, given perf_pmu__format_bits()
will always exist.

Thanks,
Leo
