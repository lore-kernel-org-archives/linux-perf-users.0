Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD31C3F34;
	Mon, 10 Mar 2025 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640167; cv=none; b=Po5uyIpZQYq+4fk7F+NB9HqPJxyPOanuc64htdAfR5MmKB5ZuXVihFJuCdAtL91UQX+wqOZOSFTn1sCsD7Ura1d990WxkvKTfvKc5eU0aelTcG40bqzGFlK6rOQSwL3pkOBF78klE4+INL9eMzhrrRqKyo2uMlnRDW6S0SFjAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640167; c=relaxed/simple;
	bh=zM/4FFQE8jxD5SjYUI7TLVyhkuuY7vBOsIZEho4dtAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVKWfUN4AlHpaTZShq95HgVUFr0oIW6hZFs2Rlf38d5fgQg5aUYqRL15LmYPzj3qmdVlUfOuNaMequQFLEmHDM6lwia9i4wJZ03DqosoIGdNQs/49boI+i0by/0/DCOWYS3d6Abxk+/tZXPnzBfWO2SBh5CuyVsUteeMJ+2gOiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oayASyOk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oayASyOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA3FC4CEE5;
	Mon, 10 Mar 2025 20:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640166;
	bh=zM/4FFQE8jxD5SjYUI7TLVyhkuuY7vBOsIZEho4dtAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oayASyOkXE2M8K2lPt2ug/KOSkwdmtpLe+6U7VTwYxU+274CVWPAelxKe9GJ46guN
	 L473mM37wVy+jd5ZuCDYVQ0p+OhcRAvryrK819Lvr0PMrFbVnzzSAdpQniC0WYm5wN
	 HATUk98G+MmHZoAF5hAtgYUUv6T8FXqTqMxavE+20lsk+F0VCtdczxj6jhzX7AyC8J
	 BoRdpsQZjqOd/KkmmUijHFS4K0DRySMm2aaCmYGqEM+0nAcDCXITc3CwK5oH1xC1sR
	 z8CNe5VBisO1WjJhQySdnmYb9OXq8t2kbQeDFMeap/+AoDU3fubV4gw7YuvEqldArA
	 KkRmvTSWdkvUg==
Date: Mon, 10 Mar 2025 17:56:03 -0300
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
Subject: Re: [PATCH v2 09/11] perf python: Add evlist all_cpus accessor
Message-ID: <Z89R43ObY3tQptmb@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-10-irogers@google.com>

On Fri, Feb 28, 2025 at 02:23:06PM -0800, Ian Rogers wrote:
> Add a means to get the reference counted all_cpus CPU map from an
> evlist in its python form.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 7f2513ffe866..c55c8392bc07 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -874,6 +874,16 @@ static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
>  	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
>  }
>  
> +static PyObject *pyrf_evlist__all_cpus(struct pyrf_evlist *pevlist)
> +{
> +	struct pyrf_cpu_map *pcpu_map = PyObject_New(struct pyrf_cpu_map, &pyrf_cpu_map__type);
> +
> +	if (pcpu_map)
> +		pcpu_map->cpus = perf_cpu_map__get(pevlist->evlist.core.all_cpus);
> +
> +	return (PyObject *)pcpu_map;
> +}
> +
>  static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
>  				   PyObject *args, PyObject *kwargs)
>  {
> @@ -1057,6 +1067,12 @@ static PyObject *pyrf_evlist__enable(struct pyrf_evlist *pevlist)
>  }
>  
>  static PyMethodDef pyrf_evlist__methods[] = {
> +	{
> +		.ml_name  = "all_cpus",
> +		.ml_meth  = (PyCFunction)pyrf_evlist__all_cpus,
> +		.ml_flags = METH_NOARGS,
> +		.ml_doc	  = PyDoc_STR("CPU map union of all evsel CPU maps.")
> +	},
>  	{
>  		.ml_name  = "mmap",
>  		.ml_meth  = (PyCFunction)pyrf_evlist__mmap,
> -- 
> 2.48.1.711.g2feabab25a-goog
