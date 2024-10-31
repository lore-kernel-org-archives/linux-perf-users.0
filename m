Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552A88C0B;
	Thu, 31 Oct 2024 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403495; cv=none; b=Jt5rhcLCZTi2Zm4BLwQvJyXvvvlukuJYzlyQf6/L9iurHrp01Ze7Fk8UtZOKZU0Ghn60g7+eWBSYoMuXUUGpe0SA4QexCbHa01fnlxjdoX/hvxMPM+be1y1CXXemXv/ERN+8HcF/VqS9yRgAOhqXxACbslkuvj85cSi1jgFytKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403495; c=relaxed/simple;
	bh=ta6NZ6x84Gb3bLteyUqB67cQQIJZONOOlEZRkGGogW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOAP9qpq8jfSOm53A5TGoPgzykiI/L5V6hBkBSDOxddc2TBrJ3+Tgi9WC8jv8ap7OmtKYpmrK8zEyLLNICtQlBVvv8SEf63w+4iUTDd2Xja+YaWxVCyHOSqtIaLTHEHHdlwWN33RqVo7FiNeYh+mYUStVe812qElwHxS6WZca/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7zFWQzr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7zFWQzr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA05C4CEC3;
	Thu, 31 Oct 2024 19:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730403495;
	bh=ta6NZ6x84Gb3bLteyUqB67cQQIJZONOOlEZRkGGogW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7zFWQzrKCcNNwemS0EzVOmfLlxXZ7uo7htC/wGDLYLIW4mnkf4XIfJrAbbxOg7Ro
	 tP4CcQRf3tRsLdvEj1C0/1QUCUH7flSLmaonOKoUOoT1LJ3859M3RTwzH/euC/QsD2
	 vHX9tDenAPz8rT19bQKZjF18IuC3LykDeVPJqcHgVO4VbxE4ct73JOeGJ1TpY5J4xi
	 ktr5IKDKHOUFE70E1Yv7E6X4s23M4Gf8PBpP8YkxHd+wIpZGC0tvwXXXo+oFfrn6j9
	 9yOSS4slOUkKXzeQzNSvDV9BPZDflFcsgSr6TxgW96m+WhpcQ4kSKvQkxN57NDIv7L
	 lCzJ2q0IsmYDA==
Date: Thu, 31 Oct 2024 16:38:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 20/21] perf python: Add __str__ and __repr__ functions
 to evsel
Message-ID: <ZyPcowY1YlRTTJN2@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-21-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:51PM -0700, Ian Rogers wrote:
> This allows evsel to be shown in the REPL like:
> ```
> Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
> Type "help", "copyright", "credits" or "license" for more information.
> >>> import sys
> >>> sys.path.insert(0, '/tmp/perf/python')
> >>> import perf
> >>> x=perf.parse_events('cycles,data_read')
> >>> print(x)
> evlist([cycles,uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/])
> >>> x[0]
> evsel(cycles)
> >>> x[1]
> evsel(uncore_imc_free_running_0/data_read/)
> >>> x[2]
> evsel(uncore_imc_free_running_1/data_read/)
> ```
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index a71bad3418da..0d71ec673aa3 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -781,6 +781,17 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
>  	return Py_None;
>  }
>  
> +static PyObject *pyrf_evsel__str(PyObject *self)
> +{
> +	struct pyrf_evsel *pevsel = (void *)self;
> +	struct evsel *evsel = &pevsel->evsel;
> +
> +	if (!evsel->pmu)
> +		return PyUnicode_FromFormat("evsel(%s)", evsel__name(evsel));
> +
> +	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel->pmu->name, evsel__name(evsel));
> +}
> +
>  static PyMethodDef pyrf_evsel__methods[] = {
>  	{
>  		.ml_name  = "open",
> @@ -802,6 +813,8 @@ static PyTypeObject pyrf_evsel__type = {
>  	.tp_doc		= pyrf_evsel__doc,
>  	.tp_methods	= pyrf_evsel__methods,
>  	.tp_init	= (initproc)pyrf_evsel__init,
> +	.tp_str         = pyrf_evsel__str,
> +	.tp_repr        = pyrf_evsel__str,
>  };
>  
>  static int pyrf_evsel__setup_types(void)
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
