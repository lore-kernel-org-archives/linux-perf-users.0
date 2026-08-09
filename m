Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7123AB5C3
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260480; cv=none; b=UPJUjIpT6yqnup0jthI4S5Hnjzod2LiVy2kKjsI1Z9fo4OVZS4gSvNejVEN20B8HzuohOf9MMoQoUQjyaLRqbXQOf0wx9Q64mPqGCNuB9thMBnDe8RiGMIHVr3BQlyM6i/WHNUMdNVXl3RI3KkciPSQGz6LFFF8EiEjQ9uPtHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260480; c=relaxed/simple;
	bh=4tz4trkt8ZuJyaN4mV+bTCOJ2mYe/vjgePiTCRA7P+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N5L/OEucDwjmcR9W88T18owFlT97Jv/A+VafWxW3UIAQIda/K4hSrbWqPuEW5qHkr/rV193gJDqEuWaQO4Y2lcL+HUHZPwh1+nZ4fqJmV4NLnyRRtMlurKGY5tQEhxbN+WrNpIYAFOId8qMybzbG5DgPN9nP+0gkEKGvaXUPtT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOGFdBM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOGFdBM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555DE1F000E9;
	Sun,  9 Aug 2026 07:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786260479;
	bh=HZ8G18hoRw0MlTxFWCLZV2enZzQWA6c3pJFq5kLKVo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BOGFdBM1m6OR8gYL9a0lEXmoyjTXkXanmCiPZZf23vl6XSJwkmirQLpft6PPxBA2X
	 kCoehnqaVX7LiOmfj6zJvV6pYTZbxSpLytp+ka/NYLZ2396KsUn3VwgE7+gjcYWkV6
	 oDfK4Pe+FnzcvavXa1BOIxpSDIDiK7M9/c7ffEajoHpwOkEK23XA8WDbM1ElVt1QN9
	 72DZG2RnFrsV/ephp3n9fpJtLXO7TLCjgAV9SiSUpZRuMylXvhzwE8qNDr2pwJ+PxH
	 GA9SUYjiWlgEjIbJ19+VMkllCYng++aq1XWyqowNW9TGHzoYExeNQkdpbTwmYD0WwK
	 GXgYk92Qv5Ehg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/15] perf python: Fix MetricGroup return type in
 perf.pyi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260809071455.1221514-13-irogers@google.com>
References: <20260624051535.3584977-1-irogers@google.com>
 <20260809071455.1221514-1-irogers@google.com>
 <20260809071455.1221514-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 07:27:58 +0000
Message-Id: <20260809072759.555DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of PyObject references 'key' and 'value' in pyrf__metr=
ics_cb upon success.
--

--- Patch [12]: [PATCH v3 12/15] perf python: Fix MetricGroup return type i=
n perf.pyi ---
commit f9b984697afa89938af9de90c9da302a78dffa89
Author: Ian Rogers <irogers@google.com>

perf python: Fix MetricGroup return type in perf.pyi

The metrics() function can return a dictionary where the value is either
a string or a list of strings, so the type signature in the stub file
should be Union[str, List[str]].

> --- a/tools/perf/python/perf.pyi
> +++ b/tools/perf/python/perf.pyi
[ ... ]
> -def metrics() -> List[Dict[str, str]]:
> +def metrics() -> List[Dict[str, Union[str, List[str]]]]:

[Severity: High]
This isn't a bug introduced by this patch, but does the underlying C
implementation of the metrics function leak the 'key' and 'value' objects on
success?

Looking at pyrf__metrics_cb() in tools/perf/util/python.c, it appears
PyDict_SetItem is used without decrementing the reference counts afterward:

	PyObject *key =3D dict ? PyUnicode_FromString("MetricGroup") : NULL;
	PyObject *value =3D key ? pyrf__metrics_groups(pm) : NULL;

	if (!value || PyDict_SetItem(dict, key, value) !=3D 0) {
		Py_XDECREF(key);
		Py_XDECREF(value);
		Py_XDECREF(dict);
		return -ENOMEM;
	}

Since PyDict_SetItem doesn't steal references, wouldn't the caller need to
decrement the reference counts for both 'key' and 'value' after a successful
insertion? Since they are only decremented in the error path, does this
result in a memory leak every time a metric group is processed?

>      """Get a list of available metrics.
> =20
>      Returns:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809071455.1221=
514-1-irogers@google.com?part=3D12
