Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A292CA8;
	Thu, 24 Jul 2025 00:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753317635; cv=none; b=rZE2DEk+Xj8O3z0g5eibrbNuktjeztMoabTLv9plrvFB7bVJEOpw+kZQNr9CtJfFvqKzUdU11EcXVyvFDoQSllLyNoMWhiRNfLe0NG+LbjdCmRxLlgXXDbCNOBZ3u5ealGb7PwTBcTkeYTyLzP8bfMB1GiSZJW5NUq9Ejdczij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753317635; c=relaxed/simple;
	bh=aI8q0rjLfVZPSA8wtYgSHYwmUfikQgdRXWAfBygWsRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekzmLalW4fD09/agT2Lb4HLGDRRGjnk4cvmApXQLM92RYQDU5Z6R839apWD+DXN2k8VuaWNPRE7HiidXYvZG+ITOazBARB40QSzQkanhRvPLOsY7V42pbjexJw5TdzOasGn/iyvZiOTvS+6UBhuWdhkvEXI4BKImwfCaXp/LaqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh0Bb3gm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh0Bb3gm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC98C4CEE7;
	Thu, 24 Jul 2025 00:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753317635;
	bh=aI8q0rjLfVZPSA8wtYgSHYwmUfikQgdRXWAfBygWsRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nh0Bb3gm+4/q/sfeCbuEJVXOLV8pMcy8oie5UfLJTrKmvAleIOYnNwgFrSo908xIw
	 /amkRatBYHkJiMYAAwVJCs1fl1O8FOb2SRBO6vN2/C5qItHbH3ujAqnwj9g0szbojT
	 iGMZJsPQ3EYIQI4kpCxn9tQF5exW5llkCrJN3AiGTRvtK22rjvfk7CBS3RTJmcmxRb
	 wlluxSrXVQ9Fippbq17uwdUzdSGH7PyQpJWGbEyHzaEHQaw5Wlf90GZhZze2NuhEx9
	 WL/uQZwYADz/6sUDh4De2P1r9gRT8mqFE3m6pOmw0/9ynHqW/Vw/OvMBwG0IxKdahJ
	 H2/gqgFZD3wBg==
Date: Wed, 23 Jul 2025 17:40:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v8 01/16] perf python: Add more exceptions on error paths
Message-ID: <aIGBAQv2Cn9qGqP1@google.com>
References: <20250723232217.516179-1-irogers@google.com>
 <20250723232217.516179-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723232217.516179-2-irogers@google.com>

On Wed, Jul 23, 2025 at 04:22:02PM -0700, Ian Rogers wrote:
> Returning NULL will cause the python interpreter to fail but not
> report an error. If none wants to be returned then Py_None needs
> returning. Set the error for the cases returning NULL so that more
> meaningful interpreter behavior is had.

Nit: I still don't get what "add more exceptions" means.  What I'm
seeing is adding more error messages.  Also returning NULL from this
function won't pass it to the interpreter as the convert checks the
return value.

But anyway, looks good to me.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/python.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 2f28f71325a8..3affde0ad15a 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -475,13 +475,19 @@ static PyObject *pyrf_event__new(const union perf_event *event)
>  	if ((event->header.type < PERF_RECORD_MMAP ||
>  	     event->header.type > PERF_RECORD_SAMPLE) &&
>  	    !(event->header.type == PERF_RECORD_SWITCH ||
> -	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE))
> +	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)) {
> +		PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
> +			     event->header.type);
>  		return NULL;
> +	}
>  
>  	// FIXME this better be dynamic or we need to parse everything
>  	// before calling perf_mmap__consume(), including tracepoint fields.
> -	if (sizeof(pevent->event) < event->header.size)
> +	if (sizeof(pevent->event) < event->header.size) {
> +		PyErr_Format(PyExc_TypeError, "Unexpected event size: %zd < %u",
> +			     sizeof(pevent->event), event->header.size);
>  		return NULL;
> +	}
>  
>  	ptype = pyrf_event__type[event->header.type];
>  	pevent = PyObject_New(struct pyrf_event, ptype);
> @@ -1199,8 +1205,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
>  		return NULL;
>  
>  	md = get_md(evlist, cpu);
> -	if (!md)
> +	if (!md) {
> +		PyErr_Format(PyExc_TypeError, "Unknown CPU '%d'", cpu);
>  		return NULL;
> +	}
>  
>  	if (perf_mmap__read_init(&md->core) < 0)
>  		goto end;
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
