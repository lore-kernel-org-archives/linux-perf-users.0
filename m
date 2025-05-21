Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3D264A9D;
	Wed, 21 May 2025 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833490; cv=none; b=iz0hHNS5x9pa56gmTpbcPOYkvPRnxW/wlYusbLSCpi19H3IBCQX/4fFG82lTF4YELcddz4nsFUQIkpwvaRSAcemVZ0Edo8DRFrpL2z4KplM8QUDaMFT6qMPtbZDHe3Rmhy+tuLfUNWXXcJxCSKibPDn5SCotgi5r8Tn542fS5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833490; c=relaxed/simple;
	bh=QVDTAdqMO+uiHDDTAblBjPNSYTk+rOwz6zjJhpKhzcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3tMxCrE/x/e2r/DgzMzbKaudpKgHbdkuYSEglSyDYzoQTxShl8rjaLw8sP2INuRGdjiCoJgYgZ8AH6W94ZpowyO+wo1RK/iuoQ9cHLdzi4FSIH+fgZNv2KHAG11KksyMT7Vehc5nc98OysYN6LREi6wLfcJ8/ZyrHOWidoWu4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUreG8Je; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUreG8Je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314E0C4CEE4;
	Wed, 21 May 2025 13:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747833489;
	bh=QVDTAdqMO+uiHDDTAblBjPNSYTk+rOwz6zjJhpKhzcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUreG8JeacwesjET/MPTdxKgkhhG6S4FljLoR4Oht6kzJBAL6XbfSD9vWFbyhJxaM
	 YdYqzh4YVo4Q7cT7eV6ZMfN1n+hTqeOboLrdqfUBWGnVv9+yTDJ6PsGwc88X63wi6y
	 iT/1upQ/Cg7qzGNHonQf0Jo0RAUirHCev78DLPo5kogOkl5vNWUPU/6Sjk85BVd20s
	 7RTfOlTfegSxI16oyAzBjwTD/mPIAnPHtVAO3sYAFusmCqKAaDU2pAYHxD0kBjo6eN
	 1OYfyCvmsnUkPBP7apNJt+d2ODO4bD9Q78EG/4OE1bd86qE6iBL155sKieWzY/fO0S
	 Ao0/EU3SZCL/g==
Date: Wed, 21 May 2025 10:18:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com
Subject: Re: [PATCH v3 5/7] perf python: Add evsel read method
Message-ID: <aC3SjgsOWMh07G_K@x1>
References: <20250519195148.1708988-1-irogers@google.com>
 <20250519195148.1708988-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519195148.1708988-6-irogers@google.com>

On Mon, May 19, 2025 at 12:51:42PM -0700, Ian Rogers wrote:
> From: Gautam Menghani <gautam@linux.ibm.com>
> 
> Add the evsel read method to enable python to read counter data for the
> given evsel.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> Ian modified from v2 to make the API take a CPU and thread then

I'll add this note right before your Signed-off-by, with a link to the
discussion, i.e. as:

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/linux-perf-users/20250512055748.479786-1-gautam@linux.ibm.com/
[ make the API take a CPU and thread then compute from these the appropriate indices.
Signed-off-by: Ian Rogers <irogers@google.com>

> compute from these the appropriate indices. This was discussed as the
> preferred API with Arnaldo:
> https://lore.kernel.org/linux-perf-users/20250512055748.479786-1-gautam@linux.ibm.com/
> ---
>  tools/perf/util/python.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 1cbddfe77c7c..281e706e102d 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -888,6 +888,37 @@ static PyObject *pyrf_evsel__threads(struct pyrf_evsel *pevsel)
>  	return (PyObject *)pthread_map;
>  }
>  
> +static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
> +				  PyObject *args, PyObject *kwargs)
> +{
> +	struct evsel *evsel = &pevsel->evsel;
> +	int cpu = 0, cpu_idx, thread = 0, thread_idx;
> +	struct perf_counts_values counts;
> +	struct pyrf_counts_values *count_values = PyObject_New(struct pyrf_counts_values,
> +							       &pyrf_counts_values__type);
> +
> +	if (!count_values)
> +		return NULL;
> +
> +	if (!PyArg_ParseTuple(args, "ii", &cpu, &thread))
> +		return NULL;
> +
> +	cpu_idx = perf_cpu_map__idx(evsel->core.cpus, (struct perf_cpu){.cpu = cpu});
> +	if (cpu_idx < 0) {
> +		PyErr_Format(PyExc_TypeError, "CPU %d is not part of evsel's CPUs", cpu);
> +		return NULL;
> +	}
> +	thread_idx = perf_thread_map__idx(evsel->core.threads, thread);
> +	if (cpu_idx < 0) {
> +		PyErr_Format(PyExc_TypeError, "Thread %d is not part of evsel's threads",
> +			     thread);
> +		return NULL;
> +	}
> +	perf_evsel__read(&(evsel->core), cpu_idx, thread_idx, &counts);
> +	count_values->values = counts;
> +	return (PyObject *)count_values;
> +}
> +
>  static PyObject *pyrf_evsel__str(PyObject *self)
>  {
>  	struct pyrf_evsel *pevsel = (void *)self;
> @@ -918,6 +949,12 @@ static PyMethodDef pyrf_evsel__methods[] = {
>  		.ml_flags = METH_NOARGS,
>  		.ml_doc	  = PyDoc_STR("threads the event is to be used with.")
>  	},
> +	{
> +		.ml_name  = "read",
> +		.ml_meth  = (PyCFunction)pyrf_evsel__read,
> +		.ml_flags = METH_VARARGS | METH_KEYWORDS,
> +		.ml_doc	  = PyDoc_STR("read counters")
> +	},
>  	{ .ml_name = NULL, }
>  };
>  
> -- 
> 2.49.0.1101.gccaa498523-goog
> 
