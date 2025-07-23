Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A7227586;
	Wed, 23 Jul 2025 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294381; cv=none; b=RrDUPUlxNs7X737FQcz5vne0Eoqg1uHFVWA3Sgqj+efCngOfx86T6jZTZ2q+fBtaxBPLQ0Zh0o+5CuysvcpnU1aAhLUuC4NKms+Q7b/Cs+1GeExDIIuDLAusE+87n+L3yXysCkBlVD9esqzoKoGCiiQ1b1BjDl2YoOeGSf4SzVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294381; c=relaxed/simple;
	bh=tLCKVZt19DaYe1dqxAbztjqS4Ys5y4Da+9uuXIAVUvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9GdWgK0r7wmskaS+XMd2oAQCEnQ7awSyirQ3SUlSE6amFXMgF5cZlZZEJzhnzykaMZSCTGHPP4y+nE5kShpFRtZya1IXFOvcXia068QY8cE0ZYOpTS5H7em0dzj6CL2FyRYjd+/bN+rusS1fW+yBXidL2JYepsIDJo4Pu0/CL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYoO+01I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYoO+01I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3716C4AF09;
	Wed, 23 Jul 2025 18:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753294381;
	bh=tLCKVZt19DaYe1dqxAbztjqS4Ys5y4Da+9uuXIAVUvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYoO+01IAlBpfUVh0YGQ/C0hznze+1pjglrSW4NkHEbqQygx64ma1lmp/+78ZnkXH
	 QoA/lyW56IskUulUxLPEEGdKxOXEyzvSWzym4osQpUj4boKYVOtuWW1TcIqHCO5GRk
	 v2pbiz8Rva2NEhcobQ6iMgfI1svOdP+SLHk6bsGTyX7FAxzF/7ShGT5kY2hp8Ql/Vz
	 Grnl6iA75A6PfwdHjTkvr4ESEZUjItHO1aVW395G0ll+8lAbnVBp4LYmhblUOGuMeS
	 fKo3NLJbj98c23b0KiU4FPzHe7gPhkE+AgpEYsqEfObtL+w9srsDFp1ULYuWIM0ouN
	 c176Gpf01G1pg==
Date: Wed, 23 Jul 2025 11:12:59 -0700
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
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 01/16] perf python: Add more exceptions on error paths
Message-ID: <aIEmK1Ekly_HUJvV@google.com>
References: <20250714164405.111477-1-irogers@google.com>
 <20250714164405.111477-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714164405.111477-2-irogers@google.com>

On Mon, Jul 14, 2025 at 09:43:49AM -0700, Ian Rogers wrote:
> Returning NULL will cause the python interpreter to fail but not
> report an error. If none wants to be returned then Py_None needs
> returning. Set the error for the cases returning NULL so that more
> meaningful interpreter behavior is had.

It looks like you are adding error messages for the failure cases, not
adding new exceptions, right?  IIUC returning NULL in pyrf_event__new()
ends up having PyErr_NoMemory().  Then now it has different messages?

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

Maybe "Unexpected event size" instead?

Thanks,
Namhyung


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
