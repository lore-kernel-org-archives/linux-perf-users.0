Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60814A4E2;
	Wed, 16 Oct 2024 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100267; cv=none; b=ETYfOq4FSPiNBclYzIxktZNPpe9TLqg8AkNmG36gIGa7RRknBPYC8J65d8v6nUeZfDFamfpbcKDykJoNxVv3onPasus27KIHwBQee25ldk7NXgzE8FtWpFad1jY+tVd7JF3lP7nFOWKMIjSMsyMlHYsvCOtRimixokTZs5VtBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100267; c=relaxed/simple;
	bh=bPem/LaYBRG3WHofkM1ry3bPYXsGByy3Spwfo1SRxbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVCOW2FewBe5vF/7qw24kKbEeHthDFrgvItB+++mhWPrkUiOQWZ1HeVbxWDHdPY4XzOrvRcXAk37QQszExQAdLcC3cKw0iIQ/7N4FdSv0Nvp3cLBqrkqaSBdAjwb26+wHq6bp3ZTaKRiRzsmxCLv+z65uPtolBTBZDps6CkGUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmkyrmWv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmkyrmWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B390EC4CEC5;
	Wed, 16 Oct 2024 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729100267;
	bh=bPem/LaYBRG3WHofkM1ry3bPYXsGByy3Spwfo1SRxbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmkyrmWvpLf4kpPqV8qo8eL/AfTd317NnNwXpPp1ffq4MtNlisEABigA2lUkICTTG
	 MVDNKmh7qoJ15i9CRK6ublwALR275AqAazOwDWZ3WWV6BLwa6/pewmqbhRbKdmfHuT
	 RSpAoEkBYmQJvQEUvgZhLDlKzfbw37qRmfv4OFcDbhPYwQ4bKZhqEPUBpRy6eZGKC0
	 3c04K/lCo/nlT6bHPXGq7BpgOeopObQfXMiyKRY9uEKvUU7QCsD0YWtzslgDa4FBSl
	 +x8zvYifFPb1WNlCvwkUGX8z8IswYDWkFhekYD3QOxwqtbYyqgSA3iz8mK6cgBj4QF
	 cg9lP3g15ElFA==
Date: Wed, 16 Oct 2024 10:37:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 2/2] perf x86/topdown: Refine helper
 arch_is_topdown_metrics()
Message-ID: <Zw_56b61Ik7UFekS@google.com>
References: <20241011110207.1032235-1-dapeng1.mi@linux.intel.com>
 <20241011110207.1032235-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011110207.1032235-2-dapeng1.mi@linux.intel.com>

Hi Ian,

On Fri, Oct 11, 2024 at 11:02:07AM +0000, Dapeng Mi wrote:
> Leverage the existed function perf_pmu__name_from_config() to check if
> an event is topdown metrics event. perf_pmu__name_from_config() goes
> through the defined formats and figures out the config of pre-defined
> topdown events.
> 
> This avoids to figure out the config of topdown pre-defined events with
> hard-coded format strings "event=" and "umask=" and provides more
> flexibility.
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Are you ok with this now?

Thanks,
Namhyung

> ---
>  tools/perf/arch/x86/util/topdown.c | 39 +++++++-----------------------
>  1 file changed, 9 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index cb2c64928bc4..f63747d0abdf 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -41,43 +41,22 @@ bool arch_is_topdown_slots(const struct evsel *evsel)
>  	return false;
>  }
>  
> -static int compare_topdown_event(void *vstate, struct pmu_event_info *info)
> -{
> -	int *config = vstate;
> -	int event = 0;
> -	int umask = 0;
> -	char *str;
> -
> -	if (!strcasestr(info->name, "topdown"))
> -		return 0;
> -
> -	str = strcasestr(info->str, "event=");
> -	if (str)
> -		sscanf(str, "event=%x", &event);
> -
> -	str = strcasestr(info->str, "umask=");
> -	if (str)
> -		sscanf(str, "umask=%x", &umask);
> -
> -	if (event == 0 && *config == (event | umask << 8))
> -		return 1;
> -
> -	return 0;
> -}
> -
>  bool arch_is_topdown_metrics(const struct evsel *evsel)
>  {
> -	struct perf_pmu *pmu = evsel__find_pmu(evsel);
>  	int config = evsel->core.attr.config;
> +	const char *name_from_config;
> +	struct perf_pmu *pmu;
>  
> -	if (!pmu || !pmu->is_core)
> +	/* All topdown events have an event code of 0. */
> +	if ((config & 0xFF) != 0)
>  		return false;
>  
> -	if (perf_pmu__for_each_event(pmu, false, &config,
> -				     compare_topdown_event))
> -		return true;
> +	pmu = evsel__find_pmu(evsel);
> +	if (!pmu || !pmu->is_core)
> +		return false;
>  
> -	return false;
> +	name_from_config = perf_pmu__name_from_config(pmu, config);
> +	return name_from_config && strcasestr(name_from_config, "topdown");
>  }
>  
>  /*
> -- 
> 2.40.1
> 
