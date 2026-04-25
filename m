Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0735F16E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141188; cv=none; b=ZksNe6GVUWNaYXvI6eIBD7m0jhkaZAmL3A0ZUC+D0gP2yPAlnpqgNggprCLC1pPENWYFFN6Ynjw7FFYlOY/sz0966DJOad98KYZsEmQ2aWIweAcilAekwQ/4+ln5/aHQoeLXTRsv3E69VgmA101jYr9D+NhY4vrFcwuSOBC5IYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141188; c=relaxed/simple;
	bh=9TwVIQQ1K/ILX31lrQZqSwVEfw9kt51hw1hQjm1juUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cuj7ED4Nl2NH5aSz4o+JD8DUYegFsbF0e15zmEzqPVG0O5vwJlcLbimhZTYYL+Xhi6wYi17zyKjMOG+WF9XWu7BjtI0XGoDEq9SHuW+ZpB4kEx1cA6O3EhCqSZrTakXRnXXm1dCO7fGZnyb7MDLlBbXGuq9DQ4yiQ/Sy7yEqMGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTBz3+Ty; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTBz3+Ty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C43FC2BCB3;
	Sat, 25 Apr 2026 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141188;
	bh=9TwVIQQ1K/ILX31lrQZqSwVEfw9kt51hw1hQjm1juUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mTBz3+Ty2iAJFxawr3+Ght4ExT/N4GKkF2YsgfI3INID8sTAIx1qnrm8RuORcESID
	 F/vWS56s3jbRJ9+He5d240TYMrnC9cOxs5NOzke0Hvty1+nf71M/+2kuMLcj1t6YRl
	 kZUaI41xYTWRNTeaEUHFhA7SEAjTFdCMIhKpQgfZ1HzFA/C+fxjApAGu6U6Wn2XtoS
	 xYm3BvPnGl9LHFTUd2X4zPrvFUotC+oSDJHGW8l2yGvY23INn6lR+mvZCqj5O7bBX1
	 nd7MzW+3iQQxw3Uk3df5WArZ1KbJnI5AxgFS1G0REXYRabtaPv8TZe9VdLhqRaMPJ1
	 7v2wg5I3JE6Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/59] perf evsel: Add reference count
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-12-irogers@google.com>
References: <20260425174858.3922152-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:19:47 +0000
Message-Id: <20260425181948.6C43FC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] An unbalanced `evsel__put()` on a borrowed reference in `evlist__d=
eliver_deferred_callchain` leads to a Use-After-Free.
- [Medium] The python bindings for `pyrf_evsel` are vulnerable to NULL poin=
ter dereferences via property setters and methods when operating on uniniti=
alized objects.
- [Medium] The Python `pevsel` object is permanently leaked in `pyrf_evlist=
__add` because `Py_INCREF` is used without a corresponding `Py_DECREF`.
--

commit d6eb43f99f56ffae4384c4511200f73c5097a9ab
Author: Ian Rogers <irogers@google.com>

perf evsel: Add reference count

This commit adds reference counting to evsel to resolve issues with the
python code cloning evsels. It initializes the count to 1 at allocation
and updates the Python bindings to use getset functions and reference
counting instead of cloning.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> +static int pyrf_evsel__set_attr_config(PyObject *self, PyObject *val, vo=
id */*closure*/)
> +{
> +	struct pyrf_evsel *pevsel =3D (void *)self;
> +
> +	pevsel->evsel->core.attr.config =3D PyLong_AsUnsignedLongLong(val);
> +	return PyErr_Occurred() ? -1 : 0;
> +}

Does this code allow a NULL pointer dereference if the python object is
instantiated without calling __init__?

While tp_getattro was added to check for initialization during attribute
reads, it seems tp_setattro is not overridden.

When setting an attribute, the setter is called directly and blindly
dereferences pevsel->evsel, which would be NULL and crash the interpreter.
The same issue appears to exist in pyrf_evlist__add below.

[ ... ]
> @@ -1566,9 +1728,9 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlis=
t *pevlist,
>  		return NULL;
> =20
>  	Py_INCREF(pevsel);
> -	evsel =3D &((struct pyrf_evsel *)pevsel)->evsel;
> +	evsel =3D ((struct pyrf_evsel *)pevsel)->evsel;
>  	evsel->core.idx =3D evlist->core.nr_entries;
> -	evlist__add(evlist, evsel);
> +	evlist__add(evlist, evsel__get(evsel));
> =20
>  	return Py_BuildValue("i", evlist->core.nr_entries);
>  }

Does this code leak the Python pevsel object?

The patch changes the C evsel to be reference counted, and evsel__get takes
a reference for the evlist.

However, Py_INCREF is still used here without a corresponding Py_DECREF
because pevlist does not track it internally, leading to a memory leak every
time evlist.add is called.

Additionally, as mentioned above, if pevsel was created without __init__,
evsel would be NULL here, leading to a crash when dereferencing
evsel->core.idx.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1373,6 +1373,7 @@ static int evlist__deliver_deferred_callchain(struc=
t evlist *evlist,
>  		sample->evsel =3D evlist__id2evsel(evlist, sample->id);
>  		ret =3D tool->callchain_deferred(tool, event, sample,
>  					       sample->evsel, machine);
> +		evsel__put(sample->evsel);
>  		sample->evsel =3D saved_evsel;
>  		return ret;
>  	}

Can this cause a use-after-free?

evlist__id2evsel returns a borrowed reference from the evlist without
incrementing the refcount. Calling evsel__put here drops a reference it nev=
er
acquired, which might prematurely free the evsel while it remains in the
evlist.

Note that I see this was addressed in a later commit 7675a76ec470 ("perf
evlist: Add reference count checking") which adds the missing evsel__get.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D11
