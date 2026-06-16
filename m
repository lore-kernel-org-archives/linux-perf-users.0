Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF93BFE5B
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576499; cv=none; b=HTr1nZUDRNFXRhdEa55UMnM6t+X/bXo1ubw44UipVFmIGRKEkGYbj3G4KF188E/1jtNhvmRyzcaaQjUFNZ1o2ABMLSNtU18ictjxEx20RR9azaFqlpruzwtHqtGUhnJPgb5zE0d/z0YnGKc0630hXZGmqeH4nAoVdtVSvZ5IpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576499; c=relaxed/simple;
	bh=V8/J0GqN5hJ2OXqsRSZLv1tlSZaOlko5BQeV87bBRRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VMmd+AVBdcw1hQqpOFTCrK1g+aUu9TPlvgekuRRnmPzv4mem2irmpD9JkWbA9aYYATaPnYI1k4E7HxDpLjeZFvg6OBBHBMkJnY5WL26NTt9utrvyTkof1s941jQdBexbrKJ827xEruGiA5oA7q+FKw7Ut03ThctRlU6MTS/9RAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgdRKSkB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgdRKSkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E121F000E9;
	Tue, 16 Jun 2026 02:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781576497;
	bh=8RRP3EXZrELpG+ejXGEs+7o0QOy/bgDtnamJCH91qwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SgdRKSkBoNTpC5iP5RBG2+6Rv0NXPbplHwhCOoj3K33ELJGEpPgVgTwV20lBfJYCd
	 6StcQo8nJNIeag+Ta7Cq3T0Yo7CwX5hfXb5UESB70wkPR5TaJn68CJOpNbHSBccC1i
	 a9usMZTlJY15rnakkBvXJ7o4vST+2nhg6MfNZVFsPEQ72FarvRd61dSdd2DLnradNv
	 /U3G5mRPI9fFvyQ0M+TR0eCLohVkr+8tV1BuXKtKZ3MG2jXE5pow6ZXvQdQFO49pcj
	 hqAAvpYdvfGePurB1GLzUwwLJeT4tVa95MXqMjDnCpExS0bEUSit+dqS4TmCRnTIOK
	 1fFUwpP0gsyww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 19/21] perf python: Add type checking for
 parse_events/parse_metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616011543.4037138-20-irogers@google.com>
References: <20260616011543.4037138-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 02:21:37 +0000
Message-Id: <20260616022137.B6E121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing type validation in `pyrf_evsel__open` allows invalid Pytho=
n objects to be blindly casted to `perf.cpu_map` or `perf.thread_map`, lead=
ing to memory corruption.
--

commit ab2b8da876dfec8d6867d13d81bf282eb7c51dcd
Author: Ian Rogers <irogers@google.com>

perf python: Add type checking for parse_events/parse_metrics

The threads and cpus parameters in parse_events and parse_metrics are
parsed with the O format specifier but blindly casted in the C extension.
This commit adds runtime PyObject_TypeCheck validations to safely raise
a TypeError if an invalid object is passed.

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

[Severity: High]
This is a pre-existing issue, but does pyrf_evsel__open() need these same
type checks?

Looking at tools/perf/util/python.c in pyrf_evsel__open(), it parses
the pcpus and pthreads objects using the |OOii format specifier, but
skips PyObject_TypeCheck:

	if (pthreads !=3D NULL && pthreads !=3D Py_None)
		threads =3D ((struct pyrf_thread_map *)pthreads)->threads;

	if (pcpus !=3D NULL && pcpus !=3D Py_None)
		cpus =3D ((struct pyrf_cpu_map *)pcpus)->cpus;

Could an invalid Python object passed to pyrf_evsel__open() lead to the
same memory corruption when these are blindly cast and dereferenced?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616011543.4037=
138-1-irogers@google.com?part=3D19
