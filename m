Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483FA33EB1A
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489244; cv=none; b=tMF/qh3CdxjHTRBXDihn72PpWcFaHpisSdzRssWNruNLZuCnD29EHx+HhTO68Qph/Hzpt/L7U+1ElJ6CXIfk2ljE9E4L7OZi3q5ANeysXlG86BtJxUE5LY9qFzJvoG4MsZ4wDxJd9afbJrmxennzwmOIx6xombzpEATJTLr67+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489244; c=relaxed/simple;
	bh=ZfnaJQ90TdHNTs4Ja4LBFZ0rbLOCrCGYmsdbWezafUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LTlpBfOAo/cs2YecJaxpZs+/sFymw3cqVPnCsB2/DdAV1exHNCENBacPKYnrPzU8/RgcLRYxNPUcUmwNkCTCceNNzz2JymXk93Bki1Ne97s91nLE50IBSpUbn5dbNoJSjxWdxQlUOry55QAkAXk1/Zmqhsd0LPnZsomYAMfZ4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2rV1UqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2rV1UqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D803A1F000E9;
	Fri, 22 May 2026 22:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489243;
	bh=ULVC540lenYEJFAVFW72hTIEmn06EQnvqjpFdO/bbZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q2rV1UqLmxCZP4D/8yg3qrlnyQi1RnbVYGC9qZXUjGRDo8Kf+uY7hHYsXVGnj1Ovw
	 Ul/GLQoBcf2xnLWsIENiKKfNBLUlAMtpB7duWvHw+eKfR0JJn6zHqaVq/lo/EkYRtP
	 +CiPgbwmsLCtT84uAifGmxGg/NQMVyMm7cFoWhb249sgvkaP0qKeU3MxkZTY8MZGq2
	 rlsAjfp9y33YY9OHJwCon3hKNZKk8sCsuz8yf2ut6vIgVNwldwM+YItIvT1f9XSUmR
	 o6acUbxXHyybGFmRvhYGhm39i5O385snzSgQyX9n1jQVVkd0Q/ioQx2Jdroodfp+5A
	 7f1pZ7AXC/0Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/23] perf evlist: Add reference count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522220435.2378363-10-irogers@google.com>
References: <20260522220435.2378363-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:34:02 +0000
Message-Id: <20260522223402.D803A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Deleting a Python `evlist` triggers an invalid free of embedde=
d `evsel` structures, causing heap corruption.
- [Critical] The new `pyrf_evlist__item` implementation uses `evsel__clone(=
)`, introducing multiple critical flaws including Denial of Service and Use=
-After-Free.
- [Medium] Uninitialized Python C extension objects dereference `NULL` when=
 `pevlist->evlist` is accessed.

Pre-existing issues:
- [Critical] The `iostat_prepare` function drops the caller's `evlist` but =
overwrites only its local pointer with a newly allocated list, leading to a=
 Use-After-Free in the caller.
--

commit f9adb4fe9dff92225e3ea6d5e52725181ce8314e
Author: Ian Rogers <irogers@google.com>
Subject: perf evlist: Add reference count

This patch adds a reference count to the evlist structure. The reference
count is initialized to 1, and evlist__put decrements it, freeing the object
when it reaches 0. This is primarily to help the Python code operate
correctly by avoiding clones.

Assisted-by: Gemini:gemini-3.1-pro-preview

> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util=
/iostat.c
> --- a/tools/perf/arch/x86/util/iostat.c
> +++ b/tools/perf/arch/x86/util/iostat.c
> @@ -337,7 +337,7 @@ int iostat_prepare(struct evlist *evlist, struct perf=
_stat_config *config)
>  	if (evlist->core.nr_entries > 0) {
>  		pr_warning("The -e and -M options are not supported."
>  			   "All chosen events/metrics will be dropped\n");
> -		evlist__delete(evlist);
> +		evlist__put(evlist);
>  		evlist =3D evlist__new();
>  		if (!evlist)
>  			return -ENOMEM;

[Severity: Critical]
This is a pre-existing issue, but I noticed that iostat_prepare takes
evlist as a pointer by value. When it calls evlist__put and then assigns
a new evlist to the local variable, the caller's evlist pointer is left
dangling. Could this lead to a use-after-free when the caller resumes
execution?

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1284,18 +1284,27 @@ static int pyrf_evlist__init(struct pyrf_evlist *=
pevlist,
[ ... ]
>  static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
>  {
> -	evlist__exit(&pevlist->evlist);
> +	evlist__put(pevlist->evlist);
>  	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
>  }

[Severity: Critical]
Does changing evlist__exit to evlist__put here cause an invalid free?
When the reference count reaches zero, evlist__put will eventually call
evlist__purge, which triggers evsel__delete. Because the Python bindings
currently embed the evsel structure directly within pyrf_evsel, calling
free on that interior pointer might corrupt the heap.

I see that this is resolved in a later patch (commit 29ffdfbf96c8b
perf evsel: Add reference count), but thought it was worth mentioning
for the intermediate state.

[ ... ]
> @@ -1788,7 +1797,23 @@ static Py_ssize_t pyrf_evlist__length(PyObject *ob=
j)
[ ... ]
> +static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
> +{
> +	struct pyrf_evsel *pevsel =3D PyObject_New(struct pyrf_evsel, &pyrf_evs=
el__type);
> +
> +	if (!pevsel)
> +		return NULL;
> +
> +	memset(&pevsel->evsel, 0, sizeof(pevsel->evsel));
> +	evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
> +
> +	evsel__clone(&pevsel->evsel, evsel);
> +	if (evsel__is_group_leader(evsel))
> +		evsel__set_leader(&pevsel->evsel, &pevsel->evsel);
> +	return (PyObject *)pevsel;
> +}
> =20
>  static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
>  {
>  	struct pyrf_evlist *pevlist =3D (void *)obj;
>  	struct evsel *pos;
> =20
> -	if (i >=3D pevlist->evlist.core.nr_entries) {
> +	if (i >=3D pevlist->evlist->core.nr_entries) {
>  		PyErr_SetString(PyExc_IndexError, "Index out of range");
>  		return NULL;
>  	}
> =20
> -	evlist__for_each_entry(&pevlist->evlist, pos) {
> +	evlist__for_each_entry(pevlist->evlist, pos) {
>  		if (i-- =3D=3D 0)
>  			break;
>  	}
> -
> -	return Py_BuildValue("O", container_of(pos, struct pyrf_evsel, evsel));
> +	return pyrf_evsel__from_evsel(pos);
>  }

[Severity: Critical]
Is it safe to use evsel__clone here? The evsel__clone function has a
BUG_ON(orig->core.fd), meaning if the item is accessed after the evlist
has been opened, it will trigger a crash. Additionally, if the parent
evlist is freed, the shallow copy might leave dangling pointers.

I noticed this is also addressed in the later commit 29ffdfbf96c8b by
using evsel__get instead of cloning.

[ ... ]
> @@ -1854,9 +1878,19 @@ static PyTypeObject pyrf_evlist__type =3D {
>  	.tp_str         =3D pyrf_evlist__str,
>  };
> =20
> +static PyObject *pyrf_evlist__new(PyTypeObject *type, PyObject *args, Py=
Object *kwargs)
> +{
> +	struct pyrf_evlist *pevlist;
> +
> +	pevlist =3D (struct pyrf_evlist *)PyType_GenericNew(type, args, kwargs);
> +	if (pevlist)
> +		pevlist->evlist =3D NULL;
> +	return (PyObject *)pevlist;
> +}

[Severity: Medium]
Will this NULL initialization cause issues if a Python user bypasses
the init function and directly invokes the new method? In that scenario,
pevlist->evlist remains NULL, and subsequent calls to other methods like
pyrf_evlist__length or pyrf_evlist__mmap will dereference it without
checking, crashing the interpreter. Is it possible to add validation
checks in the other methods?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522220435.2378=
363-1-irogers@google.com?part=3D9
