Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913537BE70
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142615; cv=none; b=bm2UKc65cLkU77OggL+aMQXv0egGjPpJu1ds1C4HvzkjHKIj+FXcpckYQbGlSJnoibY5wNfPxR3JQAl4hKj2r/WshNAF/cOTfWtSt1wwj9q7KkxNeNyo4+mlOOMcexraiWu0ff5EpJ8YXRrlcOP1TsT5r/czQTvHuqVj5sBLNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142615; c=relaxed/simple;
	bh=V/R6mAPgvflUTT+Qthhf5AcqlA3Dr+gBBNIFpbbtd6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kmmJhZFjQ5wRXOpNPdYfE5UxXFJlg+DuBgfn4sXkrT0+yl4vKGXr3hc+Bac/Icl7rPESqKGnFkxT3s7EXCTaNspUADP4EGRHke4W7ZzDZaCZXhWWwJ0vVpAmLhPguRwbZ+F/SrMe6mvR1BCCUpf9Lm+S7+93adI8lVZcawoWCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIi/A3Qk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIi/A3Qk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B79C2BCB0;
	Sat, 25 Apr 2026 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142614;
	bh=V/R6mAPgvflUTT+Qthhf5AcqlA3Dr+gBBNIFpbbtd6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=vIi/A3QkdKwzUtrxtfXobJ0P9AaazedOX6YrbxAnmZlWJK4dsLac+mlwoJAF41GCe
	 SorgHMJXkx6IevBOdSkWezIZD120Xai44F8Mus7XP6g/mL6R0cwX88G/whK38pWJaE
	 9VO4NJrBXkI/9/pSimqq4794C1P5oPEWfZfAKO5ikf+NjrJRu66Tm3pSzRMDI1M1Nw
	 pC4296oYMmrEdgLF2nQRcywpFWckg2FeqlNeZ3cIsq8RF+5Pr1SUyzSDnMvr4OChOo
	 wPQcjwudcazDpyUUAPWHdSbOTXeqAEWVRb4fsYrfMjaYSPwLxNWbV5PGG4LMALp/au
	 Ybq7QgfEo+f0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/59] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-18-irogers@google.com>
References: <20260425174858.3922152-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:43:34 +0000
Message-Id: <20260425184334.B3B79C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] Dynamically allocating `pyrf_event` based on `event->header.si=
ze` while exposing fixed-offset `PyMemberDef` attributes causes a heap out-=
of-bounds read/write vulnerability and violates the Python C API.
- [High] Missing `.tp_dealloc` initialization for `pyrf_comm_event__type` a=
nd `pyrf_read_event__type` leads to memory and reference leaks.
- [High] Unsafe dereference of `map__dso()` leads to a NULL pointer derefer=
ence in `pyrf_sample_event__get_dso`, `pyrf_sample_event__get_dso_long_name=
`, and `pyrf_sample_event__get_dso_bid`.
- [Medium] Address truncation of 64-bit map boundaries on 32-bit architectu=
res in `pyrf_sample_event__get_map_start` and `pyrf_sample_event__get_map_e=
nd`.
--

commit 1daefbea296a47c601e164eb4259aa0b9834a12a
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

This commit refactors the Python perf module by adding a common evsel
field for events, moving sample specific fields to only be present in
sample events, and adding accessors for sample events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index a10c4a292756..0de3c657d023 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -172,6 +218,7 @@ static PyTypeObject pyrf_comm_event__type =3D {
>  	.tp_flags	=3D Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
>  	.tp_doc		=3D pyrf_comm_event__doc,
>  	.tp_members	=3D pyrf_comm_event__members,
> +	.tp_getset	=3D pyrf_event__getset,
>  	.tp_repr	=3D (reprfunc)pyrf_comm_event__repr,
>  };

It looks like .tp_dealloc and .tp_new are not initialized for
pyrf_comm_event__type or pyrf_read_event__type in this patch.

Since pyrf_event__new() now unconditionally calls evsel__parse_sample(),
which populates the sample and grabs an evsel reference, will this leak
memory and evsel references when the Python garbage collector cleans up
COMM and READ events?

[ ... ]
> @@ -373,6 +428,199 @@ get_tracepoint_field(struct pyrf_event *pevent, PyO=
bject *attr_name)
>  }
>  #endif /* HAVE_LIBTRACEEVENT */
> =20
> +static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
> +{
[ ... ]
> +static PyObject *pyrf_sample_event__get_dso(struct pyrf_event *pevent,
> +					    void *closure __maybe_unused)
> +{
> +	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
> +		Py_RETURN_NONE;
> +
> +	return PyUnicode_FromString(dso__name(map__dso(pevent->al.map)));
> +}

Is it possible for map__dso(pevent->al.map) to return a NULL pointer here?

If a map doesn't have an associated DSO, passing it directly to dso__name(),
dso__long_name(), or dso__bid() could cause a segmentation fault. I notice
that pyrf_sample_event__srccode() safely checks if the DSO exists before
using it:

	if (al.map) {
		struct dso *dso =3D map__dso(al.map);

		if (dso) {
			srcfile =3D get_srcline_split(dso, ...);

Would it make sense to add a similar check to these getters?

> +
> +static PyObject *pyrf_sample_event__get_dso_long_name(struct pyrf_event =
*pevent,
> +						      void *closure __maybe_unused)
> +{
> +	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
> +		Py_RETURN_NONE;
> +
> +	return PyUnicode_FromString(dso__long_name(map__dso(pevent->al.map)));
> +}
> +
> +static PyObject *pyrf_sample_event__get_dso_bid(struct pyrf_event *peven=
t,
> +						void *closure __maybe_unused)
> +{
> +	char sbuild_id[SBUILD_ID_SIZE];
> +
> +	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
> +		Py_RETURN_NONE;
> +
> +	build_id__snprintf(dso__bid(map__dso(pevent->al.map)), sbuild_id, sizeo=
f(sbuild_id));
> +	return PyUnicode_FromString(sbuild_id);
> +}
> +
> +static PyObject *pyrf_sample_event__get_map_start(struct pyrf_event *pev=
ent,
> +						  void *closure __maybe_unused)
> +{
> +	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
> +		Py_RETURN_NONE;
> +
> +	return PyLong_FromUnsignedLong(map__start(pevent->al.map));
> +}
> +
> +static PyObject *pyrf_sample_event__get_map_end(struct pyrf_event *peven=
t,
> +						void *closure __maybe_unused)
> +{
> +	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
> +		Py_RETURN_NONE;
> +
> +	return PyLong_FromUnsignedLong(map__end(pevent->al.map));
> +}

Since map__start() and map__end() return 64-bit unsigned integers (u64)
to handle 64-bit virtual addresses via PAE, does passing them to
PyLong_FromUnsignedLong() truncate the addresses on 32-bit architectures?

Would it be safer to use PyLong_FromUnsignedLongLong() here, similar to
how map__pgoff() and the symbol boundaries are handled?

[ ... ]
> @@ -504,19 +838,30 @@ static PyObject *pyrf_event__new(const union perf_e=
vent *event)
>  		return NULL;
>  	}
> =20
> -	// FIXME this better be dynamic or we need to parse everything
> -	// before calling perf_mmap__consume(), including tracepoint fields.
> -	if (sizeof(pevent->event) < event->header.size) {
> -		PyErr_Format(PyExc_TypeError, "Unexpected event size: %zd < %u",
> -			     sizeof(pevent->event), event->header.size);
> -		return NULL;
> -	}
> -
>  	ptype =3D pyrf_event__type[event->header.type];
> -	pevent =3D PyObject_New(struct pyrf_event, ptype);
> -	if (pevent !=3D NULL) {
> -		memcpy(&pevent->event, event, event->header.size);
> -		perf_sample__init(&pevent->sample, /*all=3D*/false);
> +
> +	/* Allocate just enough memory for the size of event. */
> +	size =3D offsetof(struct pyrf_event, event) + event->header.size;
> +	pevent =3D (struct pyrf_event *)PyObject_Malloc(size);
> +	if (pevent =3D=3D NULL)
> +		return PyErr_NoMemory();
> +
> +	/* Copy the event for memory safety and initilaize variables. */
> +	PyObject_Init((PyObject *)pevent, ptype);

The code allocates a variable amount of memory based on event->header.size,
but the Python types (like pyrf_mmap_event__type) declare their size
statically with .tp_basicsize =3D sizeof(struct pyrf_event).

Is it valid in the Python C API to allocate a smaller buffer than what is
defined in .tp_basicsize?

If a malformed file provides an intentionally small header.size, could
this lead to out-of-bounds heap accesses? The PyMemberDef structures use
fixed offsets (like offsetof(struct perf_record_mmap, filename)), so if
Python scripts access these properties, they might blindly read or write
past the end of the undersized allocation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D17
