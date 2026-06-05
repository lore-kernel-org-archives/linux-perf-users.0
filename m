Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F348B383
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646581; cv=none; b=seXI3+/PNHhB+BR+QxLKiVWoL8UbuViCxFSsbIM9E850hW6K1oqhAPitDSezMn3JZX/fL4RZQScs8GO7xG84AB6P2ZFaJIyvGFjHH8/bXI1kRl0rVG3iX8tLvZxVK4V095St/c+Hc3AxsSlAldL4a1AH1hZZaLVeNmQqFuqZzyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646581; c=relaxed/simple;
	bh=t5PhGxm94rFJ4eCuxXGv67BUTWO3F/sRbCEjD7XKLkE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cVb5feDgfCd3Nmzx9cIdgL8+OoQV3FvdzkkY3b2AfB4tDoQVcXkHTLG11FRKLSk7rnlxzTJoQ3SL90YBv11TK7V0XV15ujysiPxmDseCHmYPZmcGxY5gENphUPxOvmlaJ+JcjQc8Gm6da1aMEJS/nCsAb3n1FNdQ49RqlmXBtkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3zH6vbk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3zH6vbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11D11F00899;
	Fri,  5 Jun 2026 08:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646579;
	bh=Wuy4Dgi9/omQdPmdIX/HFgdQSDPog6LkQozuL6hKOak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f3zH6vbknRYZ83LGqvLVmzmxoAOdNlIyiE935WRw5g4JQvmtfxBPQw35kzX4R8tMh
	 4/1CmrsIhAJxtpYPf/rXwzwcjgcv5dPMdtGsKOnaEee9t1H95rflxUJMNkme8b2ICi
	 Gp8Z6Nwwb1yNu92vcvKx05TV3ftLkZ9GgO329zBj/xojCodWuSA0GonaQijoAcEAvz
	 ifJ8QZedjDtUNtVD9j8ScMn8mJeFrih0lUTAZqFeLOtB5PCwLSbPp/9pm55nQ7hN/z
	 stpPxbVZmAy5FwIV7d8iVQn9E3/Otu1nFjx3mPS55XEj5J1I7PXac2i+Wg2bfFmupI
	 ggbv0+2VOJb3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 11/19] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605074003.1730715-12-irogers@google.com>
References: <20260605074003.1730715-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:02:59 +0000
Message-Id: <20260605080259.B11D11F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing null termination enforcement for PERF_RECORD_COMM events c=
ombined with tight dynamic memory allocation leads to an out-of-bounds heap=
 read.
- [High] Dynamic memory copy into statically-sized union member triggers _F=
ORTIFY_SOURCE abort for large perf events.
--

commit 988867a783dddfdaf9aaad9f7c6cf721f3891d95
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

This commit refactors the Python perf event integration by adding common
evsel fields for events and specific accessors for sample events. It also
adjusts memory allocation to allocate just enough memory for the copied
event, rather than always allocating the maximum event size.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index b3454ae971c48..f7ab6f6faaf72 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
>  struct pyrf_event {
>  	PyObject_HEAD
> +	/** @sample: The parsed sample from the event. */
>  	struct perf_sample sample;
> -	union perf_event   event;
> +	/** @al: The address location from machine__resolve, lazily computed. */
> +	struct addr_location al;
> +	/** @al_resolved: True when machine__resolve been called. */
> +	bool al_resolved;
> +	/** @event: The underlying perf_event that may be in a file or ring buf=
fer. */
> +	union perf_event event;
>  };
[ ... ]
> -static PyObject *pyrf_event__new(const union perf_event *event)
> +static PyObject *pyrf_event__new(const union perf_event *event, struct e=
vsel *evsel,
> +				 struct perf_session *session __maybe_unused)
>  {
>  	struct pyrf_event *pevent;
> -	PyTypeObject *ptype;
> +	size_t size;
> +	int err;
> +	size_t min_size =3D sizeof(struct perf_event_header);
> =20
> -	if ((event->header.type < PERF_RECORD_MMAP ||
> -	     event->header.type > PERF_RECORD_SAMPLE) &&
> -	    !(event->header.type =3D=3D PERF_RECORD_SWITCH ||
> -	      event->header.type =3D=3D PERF_RECORD_SWITCH_CPU_WIDE)) {
> -		PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
> +	if (event->header.type >=3D ARRAY_SIZE(pyrf_event__type) ||
> +	    pyrf_event__type[event->header.type] =3D=3D NULL) {
> +		return PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
>  			     event->header.type);
> -		return NULL;
>  	}
> =20
> -	// FIXME this better be dynamic or we need to parse everything
> -	// before calling perf_mmap__consume(), including tracepoint fields.
> -	if (sizeof(pevent->event) < event->header.size) {
> -		PyErr_Format(PyExc_TypeError, "Unexpected event size: %zd < %u",
> -			     sizeof(pevent->event), event->header.size);
> -		return NULL;
[ ... ]
> +	/* Allocate just enough memory for the size of event. */
> +	size =3D offsetof(struct pyrf_event, event) + event->header.size;
> +	pevent =3D (struct pyrf_event *)PyObject_Malloc(size);
> +	if (pevent =3D=3D NULL)
> +		return PyErr_NoMemory();
> +
> +	/* Copy the event for memory safety and initilaize variables. */
> +	PyObject_Init((PyObject *)pevent, pyrf_event__type[event->header.type]);
> +	memcpy(&pevent->event, event, event->header.size);

[Severity: High]
Does copying dynamically sized events into a fixed-size union member trigge=
r a
_FORTIFY_SOURCE abort?

Since the previous upper bounds check (sizeof(pevent->event) < event->heade=
r.size)
was removed, event->header.size can now safely exceed the size of the union.
However, because pevent->event remains strictly typed as a fixed-size
union perf_event rather than a flexible array member, compilers building wi=
th
-D_FORTIFY_SOURCE=3D2 will evaluate the maximum allowed destination size as
sizeof(union perf_event).

When memcpy executes for large events, will the fortified memcpy fail this
bounds check and abort the process?

> +
> +	if (event->header.type =3D=3D PERF_RECORD_MMAP) {
> +		/* Ensure '\0' string termination. */
> +		size_t max_len =3D pevent->event.header.size - offsetof(struct perf_re=
cord_mmap, filename);
> +
> +		pevent->event.mmap.filename[max_len - 1] =3D '\0';
>  	}

[Severity: High]
Is a similar string termination safeguard needed for PERF_RECORD_COMM event=
s?

The patch updates memory allocation to exactly fit the record's length, lea=
ving
no safety margin or uninitialized buffer space. For PERF_RECORD_COMM events,
the comm field is exported to Python using T_STRING_INPLACE, which relies
on strlen() to parse the string length.

If a malicious or malformed perf.data file provides a comm string lacking a
null terminator, will strlen() read past the end of the tight heap allocati=
on,
resulting in an out-of-bounds read?

> =20
> -	ptype =3D pyrf_event__type[event->header.type];
> -	pevent =3D PyObject_New(struct pyrf_event, ptype);
> -	if (pevent !=3D NULL) {
> -		memcpy(&pevent->event, event, event->header.size);
> -		perf_sample__init(&pevent->sample, /*all=3D*/false);
> +	perf_sample__init(&pevent->sample, /*all=3D*/true);
> +	pevent->al_resolved =3D false;
> +	addr_location__init(&pevent->al);
> +
> +	if (!evsel)
> +		return (PyObject *)pevent;
> +
> +	/* Parse the sample again so that pointers are within the copied event.=
 */
> +	err =3D evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
> +	if (err < 0) {
> +		Py_DECREF(pevent);
> +		return PyErr_Format(PyExc_OSError,
> +				    "perf: can't parse sample, err=3D%d", err);
>  	}
>  	return (PyObject *)pevent;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605074003.1730=
715-1-irogers@google.com?part=3D11
