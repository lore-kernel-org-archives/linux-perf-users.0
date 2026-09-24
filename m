Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D08539791;
	Thu, 24 Sep 2026 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271965; cv=none; b=LlJ5sppIf5668bD0TfSTHZHEnVQHSGtY7/b5evbErncqMVCE8sVTOpBN3sP1touZByD753tJGy8z9s2VydOQoxk9acpp//NTAK2jxTlzWD4nDiD00AsvQj9klbY8fMjZ1kKhhMRe+47nfR+hv/P9slBb+tzyHCkPf91laFTLT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271965; c=relaxed/simple;
	bh=WYABCL+q6aYd4nAlYY0XKpRwyab0R5PbT8+RpvktcUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFhCHap10CfKLgYw61+nWFsaWUsAA/FPZJnNm6LYVWLhIgQqeO4/hqSXjFJP9TdRFRXxQN6BwR9g4nSSPq5mPUFqlIVPeVHV3G2WVCaGWhSQlsZtnAOc0xqmE7C5AiKjQWcwpZvhmQRO0N/UnKA7rbutuuN9yi+4dYtWmuhO5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTXLZU0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTXLZU0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D8D1F000FF;
	Thu, 24 Sep 2026 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271963;
	bh=VU/4+bNgYxoNojK72r5HMIi3UIXmX6rTGhPHdgNeaGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gTXLZU0Ce1ckcdpnP1s/xssaEzJWOvxqmy7G2d2EBQs/4jmi02fMrwxsUJV0u4m0p
	 A3nOhgZhJdWbjVk80Cug+ekbEZkdfQ0pI/7WxxG3YUJLpB6OQ9zKb8AHu94usqRMCN
	 alwjpHdJNRX7aLYrpVtAmCY1Amj6w6Tsb7ZdZmwvsgBk0eRzY+mwPkPBnlSyUXG9U3
	 BuIg+elf0nXmLsHtASmRlg6BG7ZYm0sM+1UinpgoyuLx0ic+OVNXeokCZdr1gULZic
	 ZNWqj64koX11b3VfZlxW0GHAJRnKYxp+kZaIcWCK4rvKtNwTtQWWShHXkDn3llfSyf
	 IKxczvebNdD3A==
Date: Thu, 24 Sep 2026 19:46:01 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 7/7] perf mem record: Use the IBS swfilt filter when
 available
Message-ID: <arVh2aJ0UsbxnJib@x2>
References: <20260922122623.1029132-1-acme@kernel.org>
 <20260922122623.1029132-8-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922122623.1029132-8-acme@kernel.org>

On Tue, Sep 22, 2026 at 02:26:23PM +0200, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> IBS events with exclude_{user,kernel} bits, as used for per-thread
> recording when kernel samples are not allowed, are rejected by the
> kernel on hardware without the privilege filter, so per-thread 'perf mem
> record' fails on AMD:

<SNIP>
 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Ravi Bangoria <ravi.bangoria@amd.com>

Ravi, is it ok now?

- Arnaldo

> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/arch/x86/util/mem-events.c      | 24 ++++++++++++++++++++++
>  tools/perf/arch/x86/util/mem-events.h      |  2 ++
>  tools/perf/arch/x86/util/pmu.c             | 10 +++++++--
>  tools/perf/tests/shell/test_data_symbol.sh |  6 ++++--
>  tools/perf/util/mem-events.c               | 11 ++++++----
>  5 files changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> index b38f519020ff8c6f..2052750cd707c7e5 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -21,14 +21,38 @@ struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX] = {
>  	E(NULL,			NULL,				NULL,		false,	0),
>  };
>  
> +/*
> + * IBS events with exclude_{user,kernel} bits set, as used by perf to
> + * record per-thread when kernel samples are not allowed, are rejected
> + * by the kernel on hardware without the privilege filter unless the
> + * swfilt software filter is used, so there are extra sets of tables
> + * with the swfilt term in the event names, selected in
> + * perf_pmu__arch_init() when the PMU exposes the term.  The term is not
> + * conditional on the event already having exclude bits: perf record
> + * adds those bits itself when the first open fails with EACCES on an
> + * unprivileged setup, after the name was built, and that retry only
> + * succeeds with the term in it.
> + */
>  struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
>  	E(NULL,		NULL,		NULL,	false,	0),
>  	E(NULL,		NULL,		NULL,	false,	0),
>  	E("mem-ldst",	"%s//",		NULL,	false,	0),
>  };
>  
> +struct perf_mem_event perf_mem_events_amd_swfilt[PERF_MEM_EVENTS__MAX] = {
> +	E(NULL,		NULL,		NULL,	false,	0),
> +	E(NULL,		NULL,		NULL,	false,	0),
> +	E("mem-ldst",	"%s/swfilt=1/",	NULL,	false,	0),
> +};
> +
>  struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX] = {
>  	E(NULL,		NULL,		NULL,	false,	0),
>  	E(NULL,		NULL,		NULL,	false,	0),
>  	E("mem-ldst",	"%s/ldlat=%u/",	NULL,	true,	0),
>  };
> +
> +struct perf_mem_event perf_mem_events_amd_ldlat_swfilt[PERF_MEM_EVENTS__MAX] = {
> +	E(NULL,		NULL,			NULL,	false,	0),
> +	E(NULL,		NULL,			NULL,	false,	0),
> +	E("mem-ldst",	"%s/ldlat=%u,swfilt=1/",	NULL,	true,	0),
> +};
> diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/util/mem-events.h
> index 11e09a256f5bb084..f707de38037017c1 100644
> --- a/tools/perf/arch/x86/util/mem-events.h
> +++ b/tools/perf/arch/x86/util/mem-events.h
> @@ -6,6 +6,8 @@ extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX];
>  extern struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX];
>  
>  extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
> +extern struct perf_mem_event perf_mem_events_amd_swfilt[PERF_MEM_EVENTS__MAX];
>  extern struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX];
> +extern struct perf_mem_event perf_mem_events_amd_ldlat_swfilt[PERF_MEM_EVENTS__MAX];
>  
>  #endif /* _X86_MEM_EVENTS_H */
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 2c24ef3140da5e9b..fd4491fda117e51a 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -333,6 +333,7 @@ static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha
>  void perf_pmu__arch_init(struct perf_pmu *pmu)
>  {
>  	struct perf_pmu_caps *ldlat_cap;
> +	bool swfilt_format;
>  
>  	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
>  		pmu->auxtrace = true;
> @@ -348,7 +349,10 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>  		if (strcmp(pmu->name, "ibs_op"))
>  			return;
>  
> -		pmu->mem_events = perf_mem_events_amd;
> +		swfilt_format = perf_pmu__has_format(pmu, "swfilt");
> +		pmu->mem_events = swfilt_format ?
> +				  perf_mem_events_amd_swfilt :
> +				  perf_mem_events_amd;
>  
>  		if (!perf_pmu__caps_parse(pmu))
>  			return;
> @@ -358,7 +362,9 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>  			return;
>  
>  		perf_mem_events__loads_ldlat = 0;
> -		pmu->mem_events = perf_mem_events_amd_ldlat;
> +		pmu->mem_events = swfilt_format ?
> +				  perf_mem_events_amd_ldlat_swfilt :
> +				  perf_mem_events_amd_ldlat;
>  	} else {
>  		if (pmu->is_core) {
>  			if (perf_pmu__have_event(pmu, "mem-loads-aux"))
> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
> index d61b5659a46d9a77..52c837fddb639595 100755
> --- a/tools/perf/tests/shell/test_data_symbol.sh
> +++ b/tools/perf/tests/shell/test_data_symbol.sh
> @@ -65,15 +65,17 @@ if (($is_amd >= 1)); then
>  	# --ldlat on AMD:
>  	# o Zen4 and earlier uarch does not support ldlat
>  	# o Even on supported platforms, it's disabled (--ldlat=0) by default.
> +	# o Kernels with the swfilt term add it even when ldlat is not
> +	#   supported, so only check ldlat when the term is present.
>  	ldlat=${BASH_REMATCH[1]}
> -	if [[ -n $ldlat ]]; then
> +	if [[ $ldlat == *ldlat=* ]]; then
>  		if ! [[ "$ldlat" =~ ldlat=0 ]]; then
>  			echo "ERROR: ldlat not initialized to 0?"
>  			exit 1
>  		fi
>  
>  		mem_events="$(perf mem record -v --ldlat=150 -e list 2>&1)"
> -		if ! [[ "$mem_events" =~ ^mem-ldst.*ibs_op/ldlat=150/.*available ]]; then
> +		if ! [[ "$mem_events" =~ ^mem-ldst.*ibs_op/ldlat=150[,/].*available ]]; then
>  			echo "ERROR: --ldlat not honored?"
>  			exit 1
>  		fi
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 0b49fce251fcc184..0b07011939d7d7c3 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -82,6 +82,7 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
>  					     char *buf, size_t buf_size)
>  {
>  	struct perf_mem_event *e;
> +	const char *name;
>  
>  	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
>  		return NULL;
> @@ -90,24 +91,26 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
>  	if (!e || !e->name)
>  		return NULL;
>  
> +	name = e->name;
> +
>  	if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE) {
>  		if (e->ldlat) {
>  			if (!e->aux_event) {
>  				/* ARM and Most of Intel */
>  				scnprintf(buf, buf_size,
> -					  e->name, pmu->name,
> +					  name, pmu->name,
>  					  perf_mem_events__loads_ldlat);
>  			} else {
>  				/* Intel with mem-loads-aux event */
>  				scnprintf(buf, buf_size,
> -					  e->name, pmu->name, pmu->name,
> +					  name, pmu->name, pmu->name,
>  					  perf_mem_events__loads_ldlat);
>  			}
>  		} else {
>  			if (!e->aux_event) {
>  				/* AMD and POWER */
>  				scnprintf(buf, buf_size,
> -					  e->name, pmu->name);
> +					  name, pmu->name);
>  			} else {
>  				return NULL;
>  			}
> @@ -117,7 +120,7 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
>  
>  	if (i == PERF_MEM_EVENTS__STORE) {
>  		scnprintf(buf, buf_size,
> -			  e->name, pmu->name);
> +			  name, pmu->name);
>  		return buf;
>  	}
>  
> -- 
> 2.55.0
> 
