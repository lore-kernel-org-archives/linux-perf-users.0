Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76061C3F34;
	Mon, 10 Mar 2025 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640116; cv=none; b=eQ7WkNzj5kA12p/avDgs6dFaLz08DJvRqi3prYHC1OlWtrYdnRJNXPJHlBiQI/I/Y8qR0j1kMDOtWrtwtPOSNNWaNlpRwkxp23qxRu81ng80iyTV2ezDFTMc8Fuse0S0Zan0dGZPY3ZCg/otPwuXf6PFSVcfS0fP1vxVWnK0c88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640116; c=relaxed/simple;
	bh=g9OGnAPDouVvV5msP1LCLGfKQcrltCQ+pn5ij9tHnWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtgxQGOqyIUOCGJS3/Edz2kFsNTcF31H/BvceNmDNf0XhB3AD4lXAFTNofU5pxCy3jlHaZXVCZt8coy2aEqj121x/SCRxugbnZfks3mr6xnyKoG93z2GArfKK+nmpIokF2C/SFH3fn9BVQGIoC/hCcRLnwAUJXWuChFW11hMWxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sf9i3n/K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sf9i3n/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0426C4CEE5;
	Mon, 10 Mar 2025 20:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640116;
	bh=g9OGnAPDouVvV5msP1LCLGfKQcrltCQ+pn5ij9tHnWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sf9i3n/KtpIIzZyLd77rx3T7LG0ClYAW/X6wR9uDmZX8qk3MlPpGlCx+4t8xdDQjy
	 pFzBs5rYyc8Eg7CezTFv2f8l9diGrCOGcsMZb15B7oQsNMQYgMeWlODkfAI0AqaH9I
	 TBZnU0tliuDzy/qaItr40GdBTswOyouIoWBHUmCta8+YYfXNhg27GDgqKWNUna2AxE
	 k2Sd49uU4R/HByh9dB2IjjgzWtNnnRIxszx2lcQgf/scdbJfzbsyezLf+1oMZvK1ng
	 FJQbZW1rJ7RVg7jX053wrRTmrHr6LJ+NS+V2NNFb0BQ8++WdA7W1+T6jHJz1tYm3xj
	 g8Hb1kyhuQkOQ==
Date: Mon, 10 Mar 2025 17:55:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 08/11] perf python: Avoid duplicated code in
 get_tracepoint_field
Message-ID: <Z89RsRu3SMrSsAx5@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-9-irogers@google.com>

On Fri, Feb 28, 2025 at 02:23:05PM -0800, Ian Rogers wrote:
> The code replicates computations done in evsel__tp_format, reuse
> evsel__tp_format to simplify the python C code.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index e244cc74f16d..7f2513ffe866 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -342,23 +342,14 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
>  {
>  	const char *str = _PyUnicode_AsString(PyObject_Str(attr_name));
>  	struct evsel *evsel = pevent->evsel;
> +	struct tep_event *tp_format = evsel__tp_format(evsel);
>  	struct tep_format_field *field;
>  
> -	if (!evsel->tp_format) {
> -		struct tep_event *tp_format;
> -
> -		tp_format = trace_event__tp_format_id(evsel->core.attr.config);
> -		if (IS_ERR_OR_NULL(tp_format))
> -			return NULL;
> -
> -		evsel->tp_format = tp_format;
> -	}
> -
> -	field = tep_find_any_field(evsel->tp_format, str);
> -	if (!field)
> +	if (IS_ERR_OR_NULL(tp_format))
>  		return NULL;
>  
> -	return tracepoint_field(pevent, field);
> +	field = tep_find_any_field(tp_format, str);
> +	return field ? tracepoint_field(pevent, field) : NULL;
>  }
>  #endif /* HAVE_LIBTRACEEVENT */
>  
> -- 
> 2.48.1.711.g2feabab25a-goog
