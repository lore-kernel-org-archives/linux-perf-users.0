Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D242320A1F;
	Tue, 13 Jan 2026 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768342407; cv=none; b=VcQf6mSifotCPHfGcYbj9HmVn2ujoMMaF4DV/NjU4mgBXW319NEtEUHB3fceuCYG8MouDNgpA6117go0koWT58G+9VzYeSnVYut9fA4afxYyyEsYBOaZVD7vjJVlEn59IhxWbTCoG3JvD9mL9mjKGaPDByT54ACtTeREIf5I+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768342407; c=relaxed/simple;
	bh=ZyRwpdeHQJLYuREFufXZqOyxnfIVStjxw0TP41ppM4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3xVDixqAlcn20yyQvRTunKs4SpqGQNGCHULax7Q7078IlO5wARW+651LruZ1enm51KG2dk+Jp1sDVzpaUaAemWXswVrqt/k5LeW18z6uvvdkPSp0gYSx3hIfhZn3LFYSMmn4tyBicWzTNvRIWhjwc3cUdywkrEIQj1v10KcKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFdkia8P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFdkia8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2F4C116C6;
	Tue, 13 Jan 2026 22:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768342406;
	bh=ZyRwpdeHQJLYuREFufXZqOyxnfIVStjxw0TP41ppM4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFdkia8Ph0P6rGiCN8k8vqU/Pt1Gxk+ATX0IxBrmZkCKk3tdZC3V80iar6hCGe5Uo
	 /dNl3ehyTQKliGbDpwFkOA5aKkqry4zBUvonxKjh+8u+RffBEbRBbOdHYVrnq/tz9y
	 Yloo/9Ky6pgHsKjFDYpxMpAgjNMlFI3X5wNqXNTv8JT7fsTyp+Xq2y0acsIVQGgrgO
	 1KTyVy+Jhtg1ecClMqvS8LUMKv4xtp5Z2cNgVntFhggnMY4Qe5tcuH5ddTixAlb1EY
	 NTCFiN+/cjtMtk2DjpgsS4Ig86qEfxRik4cNJx+78B7hFGjJmqLuxAud+VuHO5HWv4
	 zF73WI5/RiNOQ==
Date: Tue, 13 Jan 2026 19:13:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 02/14] perf evsel: Refactor
 evsel__set_config_if_unset() arguments
Message-ID: <aWbDg0kmo-isxkz2@x1>
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
 <20251222-james-perf-config-bits-v4-2-0608438186fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251222-james-perf-config-bits-v4-2-0608438186fc@linaro.org>

On Mon, Dec 22, 2025 at 03:14:27PM +0000, James Clark wrote:
> Make the evsel argument first to match the other evsel__* functions
> and remove the redundant pmu argument, which can be accessed via evsel.

I haven't checked if this is the exactly where this takes place but
should be in this series, 32-bit build is broken:

   3: almalinux:9-i386WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
    21.72 almalinux:9-i386              : FAIL gcc version 11.4.1 20231218 (Red Hat 11.4.1-3) (GCC)
     1378 |         perf_pmu__format_pack(&bits, val, vp, /*zero=*/true);
          |                               ^~~~~
          |                               |
          |                               u64 * {aka long long unsigned int *}
    In file included from util/evsel.h:14,
                     from util/evsel.c:38:
    util/pmu.h:282:43: note: expected ‘long unsigned int *’ but argument is of type ‘u64 *’ {aka ‘long long unsigned int *’}
      282 | void perf_pmu__format_pack(unsigned long *format, __u64 value, __u64 *v,
          |                            ~~~~~~~~~~~~~~~^~~~~~


What I have is in perf-tools-next/tmp.perf-tools-next BTW, I'll try and
fix this tomorrow if you don't do it first. :-)

There are some more build problems in other containers/distros, I'll be
reporting as replies to the patches that looks related

- Arnaldo
 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/arch/arm/util/cs-etm.c    | 9 +++------
>  tools/perf/arch/arm64/util/arm-spe.c | 2 +-
>  tools/perf/arch/x86/util/intel-pt.c  | 3 +--
>  tools/perf/util/evsel.h              | 4 ++--
>  tools/perf/util/pmu.c                | 6 +++---
>  5 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index ea891d12f8f4..c28208361d91 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -441,10 +441,8 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  	 * when a context switch happened.
>  	 */
>  	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> -		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> -					   "timestamp", 1);
> -		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> -					   "contextid", 1);
> +		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
> +		evsel__set_config_if_unset(cs_etm_evsel, "contextid", 1);
>  	}
>  
>  	/*
> @@ -453,8 +451,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  	 * timestamp tracing.
>  	 */
>  	if (opts->sample_time_set)
> -		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> -					   "timestamp", 1);
> +		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
>  
>  	/* Add dummy event to keep tracking */
>  	err = parse_event(evlist, "dummy:u");
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index d5ec1408d0ae..51014f8bff97 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -274,7 +274,7 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
>  	 */
>  	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>  		evsel__set_sample_bit(evsel, CPU);
> -		evsel__set_config_if_unset(evsel->pmu, evsel, "ts_enable", 1);
> +		evsel__set_config_if_unset(evsel, "ts_enable", 1);
>  	}
>  
>  	/*
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index b394ad9cc635..c131a727774f 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -664,8 +664,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  		return 0;
>  
>  	if (opts->auxtrace_sample_mode)
> -		evsel__set_config_if_unset(intel_pt_pmu, intel_pt_evsel,
> -					   "psb_period", 0);
> +		evsel__set_config_if_unset(intel_pt_evsel, "psb_period", 0);
>  
>  	err = intel_pt_validate_config(intel_pt_pmu, intel_pt_evsel);
>  	if (err)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index a08130ff2e47..2cf87bc67df7 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -575,8 +575,8 @@ void evsel__uniquify_counter(struct evsel *counter);
>  	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
>  
>  u64 evsel__bitfield_swap_branch_flags(u64 value);
> -void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
> -				const char *config_name, u64 val);
> +void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
> +				u64 val);
>  
>  bool evsel__is_offcpu_event(struct evsel *evsel);
>  
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 956ea273c2c7..e87c12946d71 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1382,8 +1382,8 @@ bool evsel__is_aux_event(const struct evsel *evsel)
>   * something to true, pass 1 for val rather than a pre shifted value.
>   */
>  #define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
> -void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
> -				const char *config_name, u64 val)
> +void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
> +				u64 val)
>  {
>  	u64 user_bits = 0, bits;
>  	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
> @@ -1391,7 +1391,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
>  	if (term)
>  		user_bits = term->val.cfg_chg;
>  
> -	bits = perf_pmu__format_bits(pmu, config_name);
> +	bits = perf_pmu__format_bits(evsel->pmu, config_name);
>  
>  	/* Do nothing if the user changed the value */
>  	if (bits & user_bits)
> 
> -- 
> 2.34.1
> 
