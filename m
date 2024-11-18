Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188E199252;
	Mon, 18 Nov 2024 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966389; cv=none; b=HU7LeyZOf3uBOu2NEDwC0HYfwVXTaKnQVNUqMeBZSpqoiudx6NW6OVtkPsA+mWFyOo6fLSwq8CAfmEXT8YVRX6UHe83M+ZQGILMr3mvb2sue7og47MY9H8ak7hP0vSS0pwe0cO6AC7kyj4lsRgtjI9uxk6swuqe6GLnTpKer5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966389; c=relaxed/simple;
	bh=peMY/XdTMJJWJ5Pyke2fhJXs2TjS23XsZl0pD54mdkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fhtg9cS5OpOFr8GBfx9F76HAkj4Uw5oW1Y3qkA1leMEOEktIWiH7X8ahFazaI1EsraVqfwlCPsXBZ0ZV175RWLleicNQa7la8uzRJCUWVqj31RD/NsxY61h2kcmkKrvzRQf7oafgMFvE9YU04wf2RgKRbmtqMLJQ/jaAo7a7FxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km4gGBnW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km4gGBnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1C5C4CECC;
	Mon, 18 Nov 2024 21:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731966386;
	bh=peMY/XdTMJJWJ5Pyke2fhJXs2TjS23XsZl0pD54mdkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=km4gGBnWG4bpKH7oE2o487c2NzdoijSIdmnrnFZ4XNzizE4DM9mxyeCEJDxsP+4RR
	 bQsrMfesHcXXX57TNSMEzqERuB0JthWmTDYuPCaXXuqUDsuk7E9wAKCgldyjd6oLH+
	 h2hcM7haZ0qiLsZlZKFX0L9q83n+JxwX/6zYSZ/auTjslgSaTdfz5cPK/BeKUHC7LN
	 v2dzCYS46Jqhu4xmFcAc5mQacVzylYVo4Imv+WAjyIl01mvauFgfjdsfvVREX73yKy
	 vx/V4PFzf3Y2n+beDDzjtyGBhbPn/hIDgefud3JyyrHil9c/pFOLdQkEftq0d+uIlB
	 UsSo+9IQ4I0lA==
Date: Mon, 18 Nov 2024 13:46:24 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, irogers@google.com,
	mingo@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v8 06/10] perf evsel: Assemble offcpu samples
Message-ID: <Zzu1sI8E_vX26MgX@google.com>
References: <20241113002818.3578645-1-howardchu95@gmail.com>
 <20241113002818.3578645-7-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113002818.3578645-7-howardchu95@gmail.com>

On Tue, Nov 12, 2024 at 04:28:14PM -0800, Howard Chu wrote:
> Use the data in bpf-output samples, to assemble offcpu samples.

Now it requires PERF_SAMPLE_RAW for the off-cpu events.  But it's not
compatible with the earlier format.  Can you please make sure if it can
read old off-cpu data recorded before your change?  Maybe you need to
check or add new info (like in a header.misc field) to distinguish them.

Thanks,
Namhyung

> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20241108204137.2444151-7-howardchu95@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/evsel.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 8d0308f62484..654fb5196ecf 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2792,6 +2792,35 @@ static inline bool evsel__has_branch_counters(const struct evsel *evsel)
>  	return false;
>  }
>  
> +static int __set_offcpu_sample(struct perf_sample *data)
> +{
> +	u64 *array = data->raw_data;
> +	u32 max_size = data->raw_size, *p32;
> +	const void *endp = (void *)array + max_size;
> +
> +	if (array == NULL)
> +		return -EFAULT;
> +
> +	OVERFLOW_CHECK_u64(array);
> +	p32 = (void *)array++;
> +	data->pid = p32[0];
> +	data->tid = p32[1];
> +
> +	OVERFLOW_CHECK_u64(array);
> +	data->period = *array++;
> +
> +	OVERFLOW_CHECK_u64(array);
> +	data->callchain = (struct ip_callchain *)array++;
> +	OVERFLOW_CHECK(array, data->callchain->nr * sizeof(u64), max_size);
> +	data->ip = data->callchain->ips[1];
> +	array += data->callchain->nr;
> +
> +	OVERFLOW_CHECK_u64(array);
> +	data->cgroup = *array;
> +
> +	return 0;
> +}
> +
>  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  			struct perf_sample *data)
>  {
> @@ -3143,6 +3172,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		array = (void *)array + sz;
>  	}
>  
> +	if (evsel__is_offcpu_event(evsel))
> +		return __set_offcpu_sample(data);
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 
