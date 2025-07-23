Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03BC1E98EF;
	Wed, 23 Jul 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289297; cv=none; b=hLQWJxG0q2BbohiG8UlRCj3F0Whr2DLRl+22PWENFJDMMz6tyM4DCifp5w7mVoIFIgPeqrhoTf8eCxOErcIK6anotG5zCy8AKnVzZtgB0W7yto4L+cW741Sbxi+Y+eyZj+Pu2WMeI08cumz00bAe1MS6PmyYYG7b6s0Hydm/6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289297; c=relaxed/simple;
	bh=6og1F5AXpjRocJyy+4WO22U+A8y5olui5xNNaMBN3jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCSQEDWtfHc9twc23k6eqdAXHHrKfN2JcQisVgRQZlaThek1UV0aJCYPddxUtPfCZ24ZHbmgqFw/E6JjH8956z7feGa8cRIN0Q6tPs5vAt0ldqLlOGA5EVWJoF4t+Lizu0JgRNwpJaO8a3i1gMZ2/1/woNCX1ubOHQCRuNCnE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv3RqxoD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv3RqxoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84FAC4CEE7;
	Wed, 23 Jul 2025 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753289297;
	bh=6og1F5AXpjRocJyy+4WO22U+A8y5olui5xNNaMBN3jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jv3RqxoDsGqWravBXS4M5h4cnWzMjdiPcvHj6GkAWXDte6hT/Kaqk0fRjVVhp7VUK
	 yQHA/QsffrObTaoKQFvd4S7raIjCK38ZOtouGtWVWe4waChA554szHq0Qr87O8+QDG
	 2Wocksxp2tABLQV7VV4gvXuFnh0avKUIzB+Awe9UQ9Hn067UKU5Gv6gH6L0Y+6xb8j
	 RpZAzEESGBVF85r7JBivbQsZo2DmECyaVEXUySPTCV13HV36l8cwWNuEwpLlV7tEiB
	 s0AbBC0Hx8HCjiz1YohGr/HehFySrLrfMm/BTgHg5dFAgzs3ALDi6X3fHFQsTNMxsE
	 f4Mf0i3dA/wGw==
Date: Wed, 23 Jul 2025 13:48:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
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
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 01/16] perf python: Add more exceptions on error paths
Message-ID: <aIESTp8h0sIaD0PZ@x1>
References: <20250714164405.111477-1-irogers@google.com>
 <20250714164405.111477-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714164405.111477-2-irogers@google.com>

On Mon, Jul 14, 2025 at 09:43:49AM -0700, Ian Rogers wrote:
> Returning NULL will cause the python interpreter to fail but not
> report an error. If none wants to be returned then Py_None needs
> returning. Set the error for the cases returning NULL so that more
> meaningful interpreter behavior is had.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 2f28f71325a8..02544387f39d 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -475,13 +475,19 @@ static PyObject *pyrf_event__new(const union perf_event *event)
>  	if ((event->header.type < PERF_RECORD_MMAP ||
>  	     event->header.type > PERF_RECORD_SAMPLE) &&
>  	    !(event->header.type == PERF_RECORD_SWITCH ||
> -	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE))
> +	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)){

Nit, missing space before {

> +		PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
> +			     event->header.type);
>  		return NULL;
> +	}
>  
>  	// FIXME this better be dynamic or we need to parse everything
>  	// before calling perf_mmap__consume(), including tracepoint fields.
> -	if (sizeof(pevent->event) < event->header.size)
> +	if (sizeof(pevent->event) < event->header.size) {
> +		PyErr_Format(PyExc_TypeError, "Unexpected event version: %zd < %u",
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
