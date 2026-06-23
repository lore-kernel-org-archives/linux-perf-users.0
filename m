Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F893C4162
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782253080; cv=none; b=XAsV6QDk9jMJOffq6WiWhHlVpxjURlhzjVeD8pLpX423vnQLNvYCHmfKliSVV+8vXg9PKcIYI3wMX4DpeqDYmHnF8UvpsKyN20yFOeuiRS7/7L4B0hxq/m2T46UuqfL3fv5A9oQ+vEhSPvt5UlQSiBD3ZReJqVk66p35K/Z5Slg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782253080; c=relaxed/simple;
	bh=ar8BCDLGWC6XEW9y7KXlKMUmkb/fVgMnaAB6f6nvtgU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xa3aDDXxx5Jq98lLLQzvTHIA6je3By6EQAD9lNer8PBJeSbky7sjI3Om9+VZLDJJP0gjikKuRP7tgTtcNzcEBk82BV+xUeH3tKEgDfV7nUggAnlPmDWntxEXfgbN6K3P9anBscJx4NfUkgWzz8OnaQkHA1ly/m8hD3mTvXLy4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGGik3gB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGGik3gB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F281F000E9;
	Tue, 23 Jun 2026 22:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782253079;
	bh=RlZbhqQHIxlHGT+B/vIgHmmaINWXFV54U3+mJ0iO63U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGGik3gBQekn+d7Iqgu+WWvm27uNDL/UropWILA66PUN7EtkszqfHKL6znPHB7EuQ
	 1xeJY4QrK4acowtLGs2qejNDxJt/1yepsIcalaT4Ou99SouVv9wnPeSlIlKswPPcNx
	 v40QPqX1gT1Mnh0iPY6SPHRu0TJ4OJDgLMImzNY9HbgOACOPHc0bAus4bIjm+JHBzw
	 Zc1/0s/kQw8uIv5E9RjMX8VnXQ2cKg0xjyJFnBgjSdHUKe1nj3Wc5Wwfhws8cjGYVV
	 m9xnv4VzUz1JIzjLRVErqEJ5dsCVe8RS/lykMb6bVqxh7n7TGmd2aCmMjee5VHzbn1
	 +vIJor6mvBRJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/13] perf python: Validate CPU and thread maps in
 pyrf_evsel__open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623053515.2677888-10-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260623053515.2677888-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:17:58 +0000
Message-Id: <20260623221759.20F281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The explicit `Py_TYPE()` checks added to `pyrf_evsel__open` brea=
k Python subclassing for `perf.thread_map` and `perf.cpu_map` objects.
--

commit 909b91c5a1d04af18afad351b78395740e856d0b
Author: Ian Rogers <irogers@google.com>

perf python: Validate CPU and thread maps in pyrf_evsel__open

This commit adds explicit Py_TYPE checks to ensure the cpu and thread map
arguments passed to pyrf_evsel__open are of the correct types.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index f9398bc30a80b..62f404c40d8dc 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2096,11 +2096,21 @@ static PyObject *pyrf_evsel__open(struct pyrf_evs=
el *pevsel,
>  					 &pcpus, &pthreads, &group, &inherit))
>  		return NULL;
> =20
> -	if (pthreads !=3D NULL && pthreads !=3D Py_None)
> +	if (pthreads !=3D NULL && pthreads !=3D Py_None) {
> +		if (Py_TYPE(pthreads) !=3D &pyrf_thread_map__type) {

[Severity: Medium]
Will this strict equality check break valid Python subclasses of thread_map?

Because pyrf_thread_map__type sets Py_TPFLAGS_BASETYPE, Python scripts are
permitted to subclass it, but Py_TYPE() will point to the subclass type and
fail this exact-type check.

Should this use PyObject_TypeCheck() instead to safely support subclassing?

> +			PyErr_SetString(PyExc_TypeError, "threads must be a thread_map");
> +			return NULL;
> +		}
>  		threads =3D ((struct pyrf_thread_map *)pthreads)->threads;
> +	}
> =20
> -	if (pcpus !=3D NULL && pcpus !=3D Py_None)
> +	if (pcpus !=3D NULL && pcpus !=3D Py_None) {
> +		if (Py_TYPE(pcpus) !=3D &pyrf_cpu_map__type) {

[Severity: Medium]
Similarly, does this strict equality block valid Python subclasses of cpu_m=
ap?

> +			PyErr_SetString(PyExc_TypeError, "cpus must be a cpu_map");
> +			return NULL;
> +		}
>  		cpus =3D ((struct pyrf_cpu_map *)pcpus)->cpus;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623053515.2677=
888-1-irogers@google.com?part=3D9
