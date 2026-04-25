Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145A288AD
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777160034; cv=none; b=aVV7I2qu8P426demp5Jes8wWjecsHsDkyZDyRXVC0RKU82Jy9NCesrdo3XZflSHOvD04S1MBAqOIYTNAGENQDBN37sf/oyH8q2WaI28o99GUtOWUcyJLTMDmZ0O9Js8jkPO9iR3XxlzAtwjo0e1mrYlwShyLKByKtf7Ddd8mFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777160034; c=relaxed/simple;
	bh=yP7yUUDGMnUaMeat3+/V+hcOiEMZKSadHK71mbUxqGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B+02oIeVDQKl+quFwMKub/VOuwPSxUESO4rlb/KJyG1jRnxsUCrrgTq/rclPXlSzf2N+dxuaKcdUKaj7ilucGfC/Cnulxw+h27/K8hMOqz0X+drNdjqtYY72KrjgWUqL9YhsCfCUjUXHNR2/ItX6t51JBTX87oqGrG97ScF7L/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxN+v7pP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxN+v7pP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723AEC2BCB0;
	Sat, 25 Apr 2026 23:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777160033;
	bh=yP7yUUDGMnUaMeat3+/V+hcOiEMZKSadHK71mbUxqGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DxN+v7pPBHqhD2xTDx09en+EuAWQbIxRZc2/EaNPpgcdgR/J/iYw5Y5iv6T7dT/WY
	 ycjDJldGyJCtiX7HfX6IniSU8rAdtDe5CTmRKmSB0xQrDIzb+sF6fQ/Py0dmeIBvPt
	 dhqblhmDuP0T/q0r8u2aCYJMeqR+RwRyQscOX/JwVF7ZoiGHTTQnET2J/j2j1K/Xtl
	 QLh4FPXAUUtQUQq69NJkZRjB0oE1jcWOtcXLcaaYyF4Yx7GznSTG6C6K62x19TXMcu
	 A+fKK2756n+YNZZU9nFuz4XTVSuuhbYJRHUYczZNYZalcBUFPkxXjJ5EjvKJukBdLF
	 tRlhH/FopSPhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/59] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-18-irogers@google.com>
References: <20260425224951.174663-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:33:52 +0000
Message-Id: <20260425233353.723AEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Incorrect minimum size validation for mmap events breaks parsing.
- [High] Missing `.tp_dealloc` in `comm_event` and `read_event` causes `evs=
el` reference leaks.
- [High] Dereferencing a NULL `evsel` pointer in `is_tracepoint()` when acc=
essing attributes of a manually instantiated `sample_event`.
- [High] The Python extension supports PERF_RECORD_MMAP but lacks support f=
or PERF_RECORD_MMAP2, violating subsystem guidelines.
- [High] Python's `T_STRING_INPLACE` modifier reads past the dynamically al=
located object boundary if string fields lack a null terminator.
--

commit 5565efd8694262de670594ae38d7f95f563e85d1
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

Add common evsel field for events and move sample specific fields to
only be present in sample events. Add accessors for sample events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 861973144106..824cf58645e0 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -172,6 +218,7 @@ static PyTypeObject pyrf_comm_event__type =3D {
>  	.tp_flags	=3D Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
>  	.tp_doc		=3D pyrf_comm_event__doc,
>  	.tp_members	=3D pyrf_comm_event__members,
> +	.tp_getset	=3D pyrf_event__getset,
>  	.tp_repr	=3D (reprfunc)pyrf_comm_event__repr,
>  };

[ ... ]

> @@ -269,6 +322,7 @@ static PyTypeObject pyrf_read_event__type =3D {
>  	.tp_flags	=3D Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
>  	.tp_doc		=3D pyrf_read_event__doc,
>  	.tp_members	=3D pyrf_read_event__members,
> +	.tp_getset	=3D pyrf_event__getset,
>  	.tp_repr	=3D (reprfunc)pyrf_read_event__repr,
>  };

Are we missing a .tp_dealloc assignment for pyrf_comm_event__type and
pyrf_read_event__type?

Since pyrf_event__new() now calls evsel__parse_sample() for all events,
which acquires an evsel reference, does this cause an evsel memory leak when
Python garbage collects these events because perf_sample__exit() is not
called?

[ ... ]

> @@ -373,6 +428,199 @@ get_tracepoint_field(struct pyrf_event *pevent, PyO=
bject *attr_name)
>  }
>  #endif /* HAVE_LIBTRACEEVENT */
> =20

[ ... ]

> +static PyObject*
> +pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_na=
me)
> +{
> +	PyObject *obj =3D NULL;
> +
> +#ifdef HAVE_LIBTRACEEVENT
> +	if (is_tracepoint(pevent))
> +		obj =3D get_tracepoint_field(pevent, attr_name);
> +#endif
> +
> +	return obj ?: PyObject_GenericGetAttr((PyObject *) pevent, attr_name);
> +}

Can pevent->sample.evsel be NULL here if the event is manually instantiated
from Python?

If so, does is_tracepoint() dereference a NULL evsel pointer?

[ ... ]

> @@ -490,10 +821,14 @@ static PyTypeObject *pyrf_event__type[] =3D {

[ ... ]

> -static PyObject *pyrf_event__new(const union perf_event *event)
> +static PyObject *pyrf_event__new(const union perf_event *event, struct e=
vsel *evsel,
> +				 struct perf_session *session __maybe_unused)
>  {
>  	struct pyrf_event *pevent;
>  	PyTypeObject *ptype;
> +	size_t size;
> +	int err;
> +	size_t min_size =3D sizeof(struct perf_event_header);
> =20
>  	if ((event->header.type < PERF_RECORD_MMAP ||
>  	     event->header.type > PERF_RECORD_SAMPLE) &&
> @@ -504,19 +839,62 @@ static PyObject *pyrf_event__new(const union perf_e=
vent *event)
>  		return NULL;
>  	}

Does this code need to handle PERF_RECORD_MMAP2?

The perf tools guidelines state that tools handling MMAP must also handle
MMAP2, but it appears MMAP2 events would be rejected here and raise a
TypeError since they fall outside the accepted range.

[ ... ]

> +	switch (event->header.type) {
> +	case PERF_RECORD_MMAP:
> +		min_size =3D sizeof(struct perf_record_mmap);
> +		break;

[ ... ]

> +	if (event->header.size < min_size)
> +		return PyErr_Format(PyExc_ValueError, "Event size %u too small for typ=
e %u",
> +				    event->header.size, event->header.type);

Does sizeof(struct perf_record_mmap) statically include the full char
filename[PATH_MAX] array?

Since the kernel dynamically sizes mmap events to only include the actual
string length plus padding, will this check evaluate to true and
unconditionally reject valid mmap events?

[ ... ]

> +	/* Allocate just enough memory for the size of event. */
> +	size =3D offsetof(struct pyrf_event, event) + event->header.size;
> +	pevent =3D (struct pyrf_event *)PyObject_Malloc(size);

Could this exact sized allocation lead to out of bounds reads?

If a malformed event has a header size that exactly covers the text of a
string but omits the null terminator, Python's T_STRING_INPLACE handler
might use strlen() and read past the end of the allocated object into
adjacent heap memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D17
