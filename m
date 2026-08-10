Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D138D3F8;
	Mon, 10 Aug 2026 05:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338155; cv=none; b=gvNkKrXvTdy5WvavQ2L7oUOrM3eheOlXVmnKLCHKnhqBObpVKreBkE2CVu9aWpBwQ60Xj8PJuRaxBXJ3oNPIv0VjAlmbkaAcNAbDUHYE0k9wOzjzxM2WzZBlnaahijnwo1oG0gSqASonzbd/POJw/FlUlwpzP3LPuemwUcgBiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338155; c=relaxed/simple;
	bh=ibyRR4d3DOoc37eT+mPISCWg+++t4bqXPX4LWljI/58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgNJzNYCj5eZo6R+ePqTAfTSttdzb/9ueKfEmVBbMRAWfqBOE8KQ6/16u910dZJ1jLkJH3eZR7UKEh9f1PEDfOb2T4BVzu/JgzNKffi0+RCoXQh75Z+G02Y0hvnY83vkhrfdOodkdzHXDZd6Dls7Rw9MEZYObYQIiQX504peZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsT/sLdX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsT/sLdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB6B1F000E9;
	Mon, 10 Aug 2026 05:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786338153;
	bh=HiPdiXvzch9OfSlLMBWK/qHupTt8F7XRhgVKtL19eqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TsT/sLdXJ13ib4pf5uI3cnu1QEUDZucOrXohgLpSAT5WX4+uAdX9VxCeJF6rWAgZ0
	 CgiXNO9JAukGVa8ucgUlHdImUUnHl7gU9fMhDYqm/dPZ5dNV4vMB1YFZn9a5e5Pqnc
	 +ybix6H2+DuXsb7t5NK31W/6L646NE2Ofel8krw642kuRVChKDLJwUCFV82ylCx5LZ
	 ve2yY3WyQM78SeHy+4RYUp/Pycsyj9odJRy7aNTT762tI+a2nA9WyAQ/ZgUGD5+R3z
	 TheepxIIZDwcaJLMAVMaIiRDxAjr02Of0lXWaihPA4bLUg5MNvolMuL2jh/S5wIdjG
	 FHMO1/JLtEnjg==
Date: Mon, 10 Aug 2026 14:02:30 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 11/15] perf python: Add thread and PMU uninitialized
 checks
Message-ID: <anlbZhmuJIj1Wm6E@google.com>
References: <20260624051535.3584977-1-irogers@google.com>
 <20260809071455.1221514-1-irogers@google.com>
 <20260809071455.1221514-12-irogers@google.com>
 <20260809072810.3B94F1F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809072810.3B94F1F00ACF@smtp.kernel.org>

Hello,

On Sun, Aug 09, 2026 at 07:28:09AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added `CHECK_INITIALIZED(ppmu->pmu, "pmu")` in `pyrf_pmu__events()` causes a Python object memory leak of `py_list` on the error path.
> --
> 
> --- Patch [11]: [PATCH v3 11/15] perf python: Add thread and PMU uninitialized checks ---
> commit a381b82bb0eb00b93be525bfa1c265b574c03a5a
> Author: Ian Rogers <irogers@google.com>
> 
> perf python: Add thread and PMU uninitialized checks
> 
> This commit adds CHECK_INITIALIZED guards to thread and PMU getters to
> prevent crashes when accessed before proper initialization.
> 
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index c70b151428f76..fe5afce173330 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> 
> [ ... ]
> 
> > @@ -1730,6 +1731,8 @@ static PyObject *pyrf_pmu__events(PyObject *self)
> >  	PyObject *py_list = PyList_New(0);
> >  	int ret;
> >  
> > +	CHECK_INITIALIZED(ppmu->pmu, "pmu");
> > +
> >  	if (!py_list)
> >  		return NULL;
> 
> [Severity: Medium]
> Does this code leak py_list if CHECK_INITIALIZED fails and returns early?
> 
> Since py_list is allocated with PyList_New(0) just before the initialization
> check, it appears this Python object is left orphaned if the macro evaluates
> to true and forces an early return. 
> 
> Could the CHECK_INITIALIZED macro be moved to the beginning of
> pyrf_pmu__events() before the PyList_New(0) allocation to avoid this leak?

It seems this is the only issue introduced in this series.
As it's trivial, I'll apply the following change for Ian.

Thanks,
Namhyung


diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index fe5afce1733306be..36c5f4b0d0bb15e7 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1728,11 +1728,12 @@ static int pyrf_pmu__events_cb(void *state, struct pmu_event_info *info)
 static PyObject *pyrf_pmu__events(PyObject *self)
 {
        struct pyrf_pmu *ppmu = (void *)self;
-       PyObject *py_list = PyList_New(0);
+       PyObject *py_list;
        int ret;
 
        CHECK_INITIALIZED(ppmu->pmu, "pmu");
 
+       py_list = PyList_New(0);
        if (!py_list)
                return NULL;
 

