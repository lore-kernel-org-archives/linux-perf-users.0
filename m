Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E63148B4
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303687; cv=none; b=Z4Ywcwi6CfyPcuBGIejTAq3iUjlUgiXWZWG1A/clNRgDsKfvZZ5vjc2U3KORZVDV4IgaTiJZa2+pSYrBgzrJv6UZPbtL3Fp55eo4CM8K27z37kW1rZMrjYmllwCeRRUAKNKgxjSL2gZ3UnFzSWSR9/thYYcPwtHqYEQgQnuEJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303687; c=relaxed/simple;
	bh=/+FoRuonL5EzxoQlEaV13D7kTZsKrhAdjuo3BfwG5fM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ilj+XWrcQtuLyID/jpXU2coIX58hbiVY/whdLwPJfBRiQpuz9BrLmcWNuQxjzB9bPwenSNehEBWVKB73vO09YLUi/tkpFjeJyk9kWDkoVv5l/LYcHIlJT8UJZ3/dRdMns/uGWXToMdItkc9gK8gxZE1wGnKU+DWjzWnginUtXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsNljbVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsNljbVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624C51F000E9;
	Fri, 12 Jun 2026 22:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303686;
	bh=OlJ6uFY4n98gp2y1ZCFYvnmDsBCh+mbvmyJDCG+rO+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dsNljbVa6oLAkKRHjEpVCMBYjXVIIgD4/rAlUgd/IQlo8JYOYZDQ+7qmVxqMSlW1N
	 1zlb1CeyfXQyusEsUMivyaSrmzXf7rlZvcmWfbyA5aYXs5GIJfTLcPQILgFTejzUaA
	 WWizZKkwlPmwDrxSTa//KgVuC5BEwqZR1IeUCvj1U6KpaKnHU2VLKPe0H89+TVBwyV
	 KcY05lzgOBAvIq8Hs45kF7+qkkNUKMjeLMSWwmTy25x6JayU8RuSXU4sHw3y1NX8fJ
	 Ed2EoawTtAloIopS3FiAzTHX64q4Z6C9DWSd4AMvFwZbwPOcz1ch9qGUKl6oMe6hv0
	 Xrq4xLxT3CpVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 06/19] perf evsel: Add reference count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612221211.1221305-7-irogers@google.com>
References: <20260612221211.1221305-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:34:46 +0000
Message-Id: <20260612223446.624C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] evsel references are leaked for all non-sample events read by Py=
thon because their types lack a tp_dealloc destructor.
- [Medium] Missing initialization check for the `evsel` parameter in `pyrf_=
evlist__add` leads to a NULL pointer dereference.
--

commit 764f919043503b831e7c1c76a12ab53483beeeef
Author: Ian Rogers <irogers@google.com>

perf evsel: Add reference count
   =20
As with evlist this a no-op for most of the perf tool. The reference
count is set to 1 at allocation, the put will see the 1, decrement it
and perform the delete.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 7483741c024a5..58d3f8bbfe478 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1584,13 +1815,12 @@ static PyObject *pyrf_evlist__add(struct pyrf_evl=
ist *pevlist,
>  	PyObject *pevsel;
>  	struct evsel *evsel;
> =20
> -	if (!PyArg_ParseTuple(args, "O", &pevsel))
> +	if (!PyArg_ParseTuple(args, "O!", &pyrf_evsel__type, &pevsel))
>  		return NULL;
> =20
> -	Py_INCREF(pevsel);
> -	evsel =3D &((struct pyrf_evsel *)pevsel)->evsel;
> +	evsel =3D ((struct pyrf_evsel *)pevsel)->evsel;
>  	evsel->core.idx =3D evlist->core.nr_entries;
> -	evlist__add(evlist, evsel);
> +	evlist__add(evlist, evsel__get(evsel));

[Severity: Medium]
Is an initialization check missing for the evsel parameter here?

With the change to make evsel a pointer rather than an inline structure,
if an uninitialized perf.evsel Python object is passed to pyrf_evlist__add(=
),
the extracted pointer will be NULL. Dereferencing it immediately on the next
line for core.idx will cause a crash.

I see this is fixed later in the series by commit 9f9c729b9d53=20
('perf evlist: Add reference count checking') which adds the missing
CHECK_INITIALIZED guards.

[ ... ]

> @@ -1648,7 +1878,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct py=
rf_evlist *pevlist,
>  			return Py_None;
>  		}
> =20
> -		pevent->evsel =3D evsel;
> +		pevent->evsel =3D evsel__get(evsel);
> =20
>  		perf_mmap__consume(&md->core);

[Severity: Medium]
Does this leak the evsel reference for non-sample events?

An evsel reference is acquired here for every event read from the mmap
buffer, regardless of its type. However, looking at the deallocators, only
pyrf_sample_event__delete() drops this reference using evsel__put().

Other event types (mmap, task, comm, etc.) use the standard Python object
deallocator, which will skip calling evsel__put() and permanently leak the
reference.

I see this is also fixed later in the series by commit 9d7ca1bbbd55
('perf python: Use evsel in sample in pyrf_event'), which stops leaking
the reference by removing pevent->evsel completely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612221211.1221=
305-1-irogers@google.com?part=3D6
