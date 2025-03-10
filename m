Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223B11DF26A;
	Mon, 10 Mar 2025 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639612; cv=none; b=f5rhhcjpVPEosREvHbcHHn5CHwiRn3Kb9UYg3N7liJChA1CQ/bkxxQQDBCuSA+7GYC0T/BMnOxr4Iut+ZLgOkOMetfBDFd/eQzgxhvLoUJ8nxZOhXHPFp2TwVIc/gBhmqJm25/43Z8Z8M8wNU5y/sZgFTTBDIfRYnr/SalIXtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639612; c=relaxed/simple;
	bh=cJsIhoJVvRzyqowgWH6dxnFd+EBOoxMfMBT89Yz27sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZLo17WE6Sv4x5H8oOQMMoBOSTH6LzYrCSs7ZXAo8903IrlNNF4ZXFPkP/J/0QKovSJg432+4sd6S5Q9vyo5mmczYSKX4VAs1coYwzO4ObfW7Yss3Q4eux601yn4gprBtPKVHAPvkxlxhvm4nsy4UplliIY3e7cmtpGer5+iwmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETTftmPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETTftmPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD94C4CEE5;
	Mon, 10 Mar 2025 20:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639611;
	bh=cJsIhoJVvRzyqowgWH6dxnFd+EBOoxMfMBT89Yz27sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETTftmPw89g8PO3k1LI+Yglev5MUq05TiefcEQLMM/gX3hiE7IZ0p4zDXS7quQn5J
	 AXcQSq+NCsWJ5PlDydkbODd8ld9vS+WiuyAG89kvOuwQLgJn9ZcsBC12E1DZWwymHz
	 tyMN2zbZafi+iEHbelnc0JiDKvUOruk24sR3fffPLBSIQqftX5p+z7KcVNeH791Oaw
	 +JfcjWtvx1FkyRwh7+Esd0AY6Ifj9jwrO0noV0Yn9WJev8zonpom1xJ0RwCBNcdn0j
	 I8zMacHq1fbqzoQdxJBbak4sn9f8gqqML2Jt2YnyN85kYvxoLAUxXs6RpCCdgb/Axr
	 Da8C6Vb5SbS9g==
Date: Mon, 10 Mar 2025 17:46:48 -0300
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
Subject: Re: [PATCH v2 06/11] perf python: Add optional cpus and threads
 arguments to parse_events
Message-ID: <Z89PuEPRO6byJmd-@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-7-irogers@google.com>

On Fri, Feb 28, 2025 at 02:23:03PM -0800, Ian Rogers wrote:
> Used for the evlist initialization.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
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
> +
>  	parse_events_error__init(&err);
> -	evlist__init(&evlist, NULL, NULL);
> +	evlist__init(&evlist, cpus, threads);
>  	if (parse_events(&evlist, input, &err)) {
>  		parse_events_error__print(&err, input);
>  		PyErr_SetFromErrno(PyExc_OSError);
> -- 
> 2.48.1.711.g2feabab25a-goog
