Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D81D8DF6;
	Mon, 10 Mar 2025 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644742; cv=none; b=E508iT331Nj/7RAQGz9ejFBe7f58JyVZdcybYWrlVjl906dJGuBPstAw9Z6AtGcwpsWVnzJQT7lBDiwHGo02PAmibaSY0v3mI455oauKJ1FoxIry6MwJlL7GwuR5qxoHAcc2SkAYD9/gCLdXp/uPKdz1SVyjDrN+kz2JPTT7Ra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644742; c=relaxed/simple;
	bh=Sp1vvz4f13qsIj4sbuySADw8IHG7tvnIEy6zhtY+6us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4iRXk/eZs3GStxhtgm/DSMXqVH91D/GSYnQIR5SJdWKDKPpXR9Iw6+HhTg0Wcun5Oefmbu9zsDi4FETj4B8VeeTLBU3DekPeZ8lcclZft03CYjE8bOMcj6JA0ipuSw0PsO0C8+IaOXh37EBqtfY7nPfvkw8EKI4cUGw0akVi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vE5GF1l9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vE5GF1l9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823C7C4CEE5;
	Mon, 10 Mar 2025 22:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741644742;
	bh=Sp1vvz4f13qsIj4sbuySADw8IHG7tvnIEy6zhtY+6us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vE5GF1l91CPOP9NlgoQOxAdbnQU4p0K1zd0S8dl0kasLe5/3KnaQqwxmxGS+N3GTB
	 bDOrJih1teHesNXBNw/3wx7arwadfp83M7gJZAqdaLBWVbxJpIaZQEPTIggEW4KD2c
	 +52GEv2ummtq6zGj1yPKrSzm6BmPfMTYxty+YK1td872uuFcjVfxqTYRJr7uwb8I7n
	 h+uXQGi6KGo6VCNUkCJCt3G5VTn/coL+6RYcmIxRJG7MoUYAOYVI4stpk4NISt+gX4
	 hDXWyR05YMdWg4P0rWS5f0NAgZNCFb2XnrEmgXDOsqX9l9HCHbN/GmFOnr4kUkR26O
	 wa1iCp7/uF/jw==
Date: Mon, 10 Mar 2025 15:12:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [PATCH v2 06/11] perf python: Add optional cpus and threads
 arguments to parse_events
Message-ID: <Z89jxAMEpYea9Qom@google.com>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-7-irogers@google.com>

On Fri, Feb 28, 2025 at 02:23:03PM -0800, Ian Rogers wrote:
> Used for the evlist initialization.
> 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index b600b6379b4e..4a3015e7dc83 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1339,12 +1339,18 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
>  	struct evlist evlist = {};
>  	struct parse_events_error err;
>  	PyObject *result;
> +	PyObject *pcpus = NULL, *pthreads = NULL;
> +	struct perf_cpu_map *cpus;
> +	struct perf_thread_map *threads;
>  
> -	if (!PyArg_ParseTuple(args, "s", &input))
> +	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
>  		return NULL;
>  
> +	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
> +	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;

I wonder if it needs any type checks before accessing them.

Thanks,
Namhyung

> +
>  	parse_events_error__init(&err);
> -	evlist__init(&evlist, NULL, NULL);
> +	evlist__init(&evlist, cpus, threads);
>  	if (parse_events(&evlist, input, &err)) {
>  		parse_events_error__print(&err, input);
>  		PyErr_SetFromErrno(PyExc_OSError);
> -- 
> 2.48.1.711.g2feabab25a-goog
> 
