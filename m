Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56B3BB116
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781564066; cv=none; b=YbQHsJJoEN3vHgxXsPPhzHlh1bAlyUvUl9ms/8BK0jowBubxAX7njdCS0LLI0hjicHxg7RsWJDR5pAgWQxiDy7NGDkPREWxluldfr1FiCTrybwPnP0WDod/4i4ysqdddudbYhChvNJhqSMSL4AQGb+EPfKqpTn58XTW9EB/5Aqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781564066; c=relaxed/simple;
	bh=PkQq7iD+J+FPbIPUEclcWODeBVlbWnstSLitAqu7/x4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VybVPPhRvGLknse2EyJSnvHR8efE8Fq48jvWuFgVWjSkILk+6sQXat+fzwcX+4kcvr2H8o84cszM6fQYEuJz+bWPKjnXP8GKVW+Jvk9wmSJyYQ5ENQd61qnB21x43kA5IMQGaiO2NGWWIPJJNuaV+x3fLmgCXNNg2YB4m7BdNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVN6ZyYx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVN6ZyYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECF21F000E9;
	Mon, 15 Jun 2026 22:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781564065;
	bh=fDMnAm48HaFg/P/VUU1flN9Tc4zIPS9JUBj1bv0fm6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DVN6ZyYx8KxQdmSpLlAC5hWtctTiD8PYFA0R22vPZllGeQxz/z1Gn+kToq+HtD2sW
	 XFknllCBGRRmwZlCnWNTQwCtxuvdF7gKx7TPPH/bfXSfTUCn1KSMQTVAwAUn6oCu/R
	 SGSpax97h2cUTBsfevHqlxjJTVnto4F1vkcbpGQlb3H/qW86OGRjTGeeAhK4ko98sD
	 3Mxk5RWmOs/FrYSR2BAdQh2Y/sQ9rIEI9CpgUzLU/ZpVbeJzsW24us1iFF7GfKHgLO
	 5bqxIiVGJUPlbbLgQA9U25cyI31/9VuNSw8+u9hg5lBtIBGqADKpLQyHaidbCYijPR
	 wspLSAk6jbI0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 19/21] perf python: Add type checking for
 parse_events/parse_metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223011.3873955-20-irogers@google.com>
References: <20260615223011.3873955-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 22:54:24 +0000
Message-Id: <20260615225424.DECF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing type checks for Python objects blindly cast to internal ma=
p structs in pyrf_evsel__open.
--

commit fe6a29ea73634479b123e57801dc3fa83e09bec2
Author: Ian Rogers <irogers@google.com>

perf python: Add type checking for parse_events/parse_metrics

The threads and cpus parameters in parse_events and parse_metrics
are parsed with the 'O' format specifier but blindly casted in the
C extension. If a user passes an invalid object type, this leads to
memory corruption when dereferencing the expected struct.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 4ec5a91d45c01..11e1f39c1bea9 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -3341,6 +3341,20 @@ static PyObject *pyrf__parse_events(PyObject *self=
, PyObject *args)
>  		return NULL;
>  	}
> =20
> +	if (pthreads && pthreads !=3D Py_None &&
> +	    !PyObject_TypeCheck(pthreads, &pyrf_thread_map__type)) {
> +		PyErr_SetString(PyExc_TypeError, "threads must be a perf.thread_map or=
 None");
> +		evlist__put(evlist);
> +		return NULL;
> +	}
> +
> +	if (pcpus && pcpus !=3D Py_None &&
> +	    !PyObject_TypeCheck(pcpus, &pyrf_cpu_map__type)) {
> +		PyErr_SetString(PyExc_TypeError, "cpus must be a perf.cpu_map or None"=
);
> +		evlist__put(evlist);
> +		return NULL;
> +	}
> +
>  	threads =3D (pthreads && pthreads !=3D Py_None) ?
>  			((struct pyrf_thread_map *)pthreads)->threads : NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does pyrf_evsel__open()
need these same validations?

Looking at pyrf_evsel__open() in tools/perf/util/python.c, it appears to
parse the exact same cpus and threads arguments without checking their
type before casting:

tools/perf/util/python.c:pyrf_evsel__open() {
    ...
	if (pthreads !=3D NULL && pthreads !=3D Py_None)
		threads =3D ((struct pyrf_thread_map *)pthreads)->threads;

	if (pcpus !=3D NULL && pcpus !=3D Py_None)
		cpus =3D ((struct pyrf_cpu_map *)pcpus)->cpus;
    ...
}

Could a user passing an invalid object type to evsel.open(cpus=3D...) trigg=
er
the same memory corruption when dereferencing the expected struct?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223011.3873=
955-1-irogers@google.com?part=3D19
