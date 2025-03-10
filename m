Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BEC1DED4B;
	Mon, 10 Mar 2025 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639511; cv=none; b=GrUvwOduZIZhbzV+TAIk4q1Gbhd4BVojpe5DpaGkIKw2P6z4nqLZpAYW5hVgEC3g/E/F+ihvHzOGSFRgPJMLLPoROnk333bH+l3w22riiJbSCY2O84nXGcRB+7pu319GjfgY4q18Wssm+qnWG0T1wjVe29vRY2kfGadnWnJFkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639511; c=relaxed/simple;
	bh=/B3WnIg2ObndH8I8HK2V/K97zlTEF7wowyD035iWB7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISMx6AB7fkSFlww7hNIwmd/YKDGuvUFRi8voCpEh6RM+mWvqI67V9KsImjM+5U3NiOBnLefDjVBP6BcnfkDY+a6EPaF8LqKsW47JR6xU38jq1g5Kb9POnGqoXyX2pRKMPExHJTnonNTFFMdYsJn1mvd44Rfn/BkURscx6wI+V+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S50Xd0Vx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S50Xd0Vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414D0C4CEE5;
	Mon, 10 Mar 2025 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639510;
	bh=/B3WnIg2ObndH8I8HK2V/K97zlTEF7wowyD035iWB7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S50Xd0Vxco9XfElxmqnvyU+dj4QkEcblV+Xrm/oYmKG+KE9gji1K9CywJdCtkL+VL
	 86CuPS0c/+FDjBWcfEB2wd1F+5JuSgjRrqLTIsei7a1XwqI0x43wFfKZ41upVLoceg
	 R+PRDNBcCWq4Dk4pWUPMkJvKUm8Vrwq8yqWzOGlVifazGASDTflgsnDYJ2aACHRppy
	 0Bekmr0SO7WHm1R1dKGM1q4KuCOZtk0k5FSQ/pamLrAVuQA7YXl/bADfx1m8BttzJ6
	 WJwClYS4IdtAPSyrZiRKmGP8vJWvjKt8lb5NdUdct0oUkvQXkyJxrYOSWniJQ0l6gi
	 pDAg7F1DMGKTA==
Date: Mon, 10 Mar 2025 17:45:08 -0300
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
Subject: Re: [PATCH v2 04/11] perf python: Add evlist enable and disable
 methods
Message-ID: <Z89PVJMBUyfA9jdu@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-5-irogers@google.com>

On Fri, Feb 28, 2025 at 02:23:01PM -0800, Ian Rogers wrote:
> By default the evsels from parse_events will be disabled. Add access
> to the evlist functions so they can be enabled/disabled.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index e2b9032c1311..0cf81cfcfafb 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1028,6 +1028,20 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
>  	return Py_None;
>  }
>  
> +static PyObject *pyrf_evlist__disable(struct pyrf_evlist *pevlist)
> +{
> +	evlist__disable(&pevlist->evlist);
> +	Py_INCREF(Py_None);
> +	return Py_None;
> +}
> +
> +static PyObject *pyrf_evlist__enable(struct pyrf_evlist *pevlist)
> +{
> +	evlist__enable(&pevlist->evlist);
> +	Py_INCREF(Py_None);
> +	return Py_None;
> +}
> +
>  static PyMethodDef pyrf_evlist__methods[] = {
>  	{
>  		.ml_name  = "mmap",
> @@ -1065,6 +1079,18 @@ static PyMethodDef pyrf_evlist__methods[] = {
>  		.ml_flags = METH_VARARGS | METH_KEYWORDS,
>  		.ml_doc	  = PyDoc_STR("reads an event.")
>  	},
> +	{
> +		.ml_name  = "disable",
> +		.ml_meth  = (PyCFunction)pyrf_evlist__disable,
> +		.ml_flags = METH_NOARGS,
> +		.ml_doc	  = PyDoc_STR("Disable the evsels in the evlist.")
> +	},
> +	{
> +		.ml_name  = "enable",
> +		.ml_meth  = (PyCFunction)pyrf_evlist__enable,
> +		.ml_flags = METH_NOARGS,
> +		.ml_doc	  = PyDoc_STR("Enable the evsels in the evlist.")
> +	},
>  	{ .ml_name = NULL, }
>  };
>  
> -- 
> 2.48.1.711.g2feabab25a-goog
