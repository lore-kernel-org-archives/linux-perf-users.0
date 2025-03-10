Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597661DE3BA;
	Mon, 10 Mar 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640395; cv=none; b=NBjuWVPJzTJ4NgAr43KxHedBg+eRwkHeUJ4Xv/4WGQZkpGjVvdUxKgp82/0lwH4kUHIsTwIqbrtFh9m1E2+czyIa8VRdRc92TIQLcYLG4eiRSXwxiRlcvWWm86Nl1JWN5gUQ/CEJLYxfjIrQlr7rV6pZWHrzUwCI1X1D+JXCewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640395; c=relaxed/simple;
	bh=o80ThnfsDtVGMfVUzfNKedWb1hkkKsxCvl4E7v+/6GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdRMY9lkoeVpXqjJKQk+tyznjj1aTA7xAJncAEG8pVLlTkMKRyEqVYnbNrsXdav4AKLWyc0cZil1YQyRLOVdaEeSK6pfYEIXAOPTKtTPAz1f82rxoFYvbqwmYxYiqGbEFgrHpxweAx9nXvFxL74mg2QBvIlufgTZqblRgRW1KrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppNQkncO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppNQkncO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E19C4CEE5;
	Mon, 10 Mar 2025 20:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640394;
	bh=o80ThnfsDtVGMfVUzfNKedWb1hkkKsxCvl4E7v+/6GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppNQkncOdP8loMk0aTX943+admymqMyYoKTumSTfhgsIhL+JOMeN9CmEaN63xkVjR
	 dmmyTC+R7W2XTmhmCqRBhx3+kIlCmWMmOSlWLG2Z56qriw+5G5WiC+b9OvTEXCfXcV
	 gJ2w44oZYfqvO379CD1A/NZVAbvhi011iBFtBXg3snC8MgoaFWlVKfHgbH+6KLV7ex
	 rz1gzCV3QRCeC/EBWZlEYjI4CHkPCVM4YYcbZI8NOYNJiwHxkbp7xRhnXYQME4l7cV
	 mBO4OwAIcBSslMFEACJTpaZ3nWCiVn0UywR+8dx8K/xk0q+fnsQaGFM/tVdL/I11Xv
	 htcK2zoIvZTww==
Date: Mon, 10 Mar 2025 17:59:52 -0300
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
Subject: Re: [PATCH v2 10/11] perf python: Add evlist.config to set up record
 options
Message-ID: <Z89SyJNCILErEwAb@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-11-irogers@google.com>

On Fri, Feb 28, 2025 at 02:23:07PM -0800, Ian Rogers wrote:
> Add access to evlist__config that is used to configure an evlist with
> record options.

I guess nothing precludes adding support later for passing fields as an
optional dictionary, so I think its ok to have it with the name "config"
but being more of a "default_config".

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index c55c8392bc07..69ec2ad60d98 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -9,10 +9,12 @@
>  #include <event-parse.h>
>  #endif
>  #include <perf/mmap.h>
> +#include "callchain.h"
>  #include "evlist.h"
>  #include "evsel.h"
>  #include "event.h"
>  #include "print_binary.h"
> +#include "record.h"
>  #include "strbuf.h"
>  #include "thread_map.h"
>  #include "trace-event.h"
> @@ -1052,6 +1054,31 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
>  	return Py_None;
>  }
>  
> +static PyObject *pyrf_evlist__config(struct pyrf_evlist *pevlist)
> +{
> +	struct record_opts opts = {
> +		.sample_time	     = true,
> +		.mmap_pages	     = UINT_MAX,
> +		.user_freq	     = UINT_MAX,
> +		.user_interval	     = ULLONG_MAX,
> +		.freq		     = 4000,
> +		.target		     = {
> +			.uses_mmap   = true,
> +			.default_per_cpu = true,
> +		},
> +		.nr_threads_synthesize = 1,
> +		.ctl_fd              = -1,
> +		.ctl_fd_ack          = -1,
> +		.no_buffering        = true,
> +		.no_inherit          = true,
> +	};
> +	struct evlist *evlist = &pevlist->evlist;

> +	evlist__config(evlist, &opts, &callchain_param);
> +	Py_INCREF(Py_None);
> +	return Py_None;
> +}
> +
>  static PyObject *pyrf_evlist__disable(struct pyrf_evlist *pevlist)
>  {
>  	evlist__disable(&pevlist->evlist);
> @@ -1109,6 +1136,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
>  		.ml_flags = METH_VARARGS | METH_KEYWORDS,
>  		.ml_doc	  = PyDoc_STR("reads an event.")
>  	},
> +	{
> +		.ml_name  = "config",
> +		.ml_meth  = (PyCFunction)pyrf_evlist__config,
> +		.ml_flags = METH_NOARGS,
> +		.ml_doc	  = PyDoc_STR("Apply default record options to the evlist.")
> +	},
>  	{
>  		.ml_name  = "disable",
>  		.ml_meth  = (PyCFunction)pyrf_evlist__disable,
> -- 
> 2.48.1.711.g2feabab25a-goog
