Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B71DF24F;
	Thu, 17 Oct 2024 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729206160; cv=none; b=N/inLh1EhISI3yL055GVvlNOKUG9rxRGXgUH9AMiGLXRugaiZ8dbeqeT5DCF0HHi81U2ZAzq0rfdf2waSXjahr1qhQbBzvKLMCQCY7D+csLnHLyBkc6VET/MRFUj2c1B8XCWF26mp0UHbiMPZ503cZumhBzLzQdtM1OQ5KxiJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729206160; c=relaxed/simple;
	bh=G3hv8f0Fk1I8y0L9Jd8CYk+LkoYaX3jhd16SGoHT/og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnyA9fC9CgnuF96KOzO75B+T5pyBL8BYGrjLJ2Ya5LIKVsSpuUXio40Dme33UyhN53uyP7l3kdZbR446OlhGxPuoaPjmBXo7g6jLY/IDd5b5Cv9SS93GXnnAj4UsOCp9pVc/F5aLFHdrKJcwyi+dL5Az1v4O57+nQ1G9RzAA8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9auFBIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9auFBIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891CEC4CEC3;
	Thu, 17 Oct 2024 23:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729206160;
	bh=G3hv8f0Fk1I8y0L9Jd8CYk+LkoYaX3jhd16SGoHT/og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9auFBIcw1zFMiOk8FwogYF+Lbb332T8ppMN8SmskzA50ajMFL/h5nlzUV8/sXzm9
	 aMHETnc4Yv8h+osbmK/vegKPSTRjnSZ4H25EE+s9COiQOZ1VHXICy3zMBAeV00pAEq
	 iDbYa8c4uFLTM0ReysxTpZF3poRme/CwjuseWGAgc3WlpTWQyWk+V9N1PHedilaXxK
	 mmW4ZAQ0nzz0yepkLzpePxwl9JAqyu+heZk/e0RGpSb1tsVUdH3OAn5MrU/nMfEDa2
	 Nn64+UHuLR8yiN6lcF2FhikOnUQW/VcCPD2BYzk5XHucyofbb8GtEOUiwnnmtSEpyS
	 DxmetgMsT6SHA==
Date: Thu, 17 Oct 2024 16:02:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] libperf: evlist: Fix --cpu argument on hybrid
 platform
Message-ID: <ZxGXjX_JiTED24wN@google.com>
References: <20241015145416.583690-1-james.clark@linaro.org>
 <20241015145416.583690-2-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015145416.583690-2-james.clark@linaro.org>

On Tue, Oct 15, 2024 at 03:54:15PM +0100, James Clark wrote:
> Since the linked fixes: commit, specifying a CPU on hybrid platforms
> results in an error because Perf tries to open an extended type event
> on "any" CPU which isn't valid. Extended type events can only be opened
> on CPUs that match the type.
> 
> Before (working):
> 
>   $ perf record --cpu 1 -- true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]
> 
> After (not working):
> 
>   $ perf record -C 1 -- true
>   WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cycles:P'
>   Error:
>   The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles:P/).
>   /bin/dmesg | grep -i perf may provide additional information.
> 
> (Ignore the warning message, that's expected and not particularly
> relevant to this issue).
> 
> This is because perf_cpu_map__intersect() of the user specified CPU (1)
> and one of the PMU's CPUs (16-27) correctly results in an empty (NULL)
> CPU map. However for the purposes of opening an event, libperf converts
> empty CPU maps into an any CPU (-1) which the kernel rejects.
> 
> Fix it by deleting evsels with empty CPU maps in the specific case where
> user requested CPU maps are evaluated.

I think there's a discussion about making default events skippable and
hide them in the output unless all of them fail.

Thanks,
Namhyung

> 
> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/lib/perf/evlist.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index c6d67fc9e57e..8fae9a157a91 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -47,6 +47,13 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>  		 */
>  		perf_cpu_map__put(evsel->cpus);
>  		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->own_cpus);
> +
> +		/*
> +		 * Empty cpu lists would eventually get opened as "any" so remove
> +		 * genuinely empty ones before they're opened in the wrong place.
> +		 */
> +		if (perf_cpu_map__is_empty(evsel->cpus))
> +			perf_evlist__remove(evlist, evsel);
>  	} else if (!evsel->own_cpus || evlist->has_user_cpus ||
>  		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
>  		/*
> @@ -80,11 +87,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>  
>  static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
>  {
> -	struct perf_evsel *evsel;
> +	struct perf_evsel *evsel, *n;
>  
>  	evlist->needs_map_propagation = true;
>  
> -	perf_evlist__for_each_evsel(evlist, evsel)
> +	list_for_each_entry_safe(evsel, n, &evlist->entries, node)
>  		__perf_evlist__propagate_maps(evlist, evsel);
>  }
>  
> -- 
> 2.34.1
> 
