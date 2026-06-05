Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E1438FF2
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687833; cv=none; b=nZ/YpVe6NK20Ggjjd2uFVB8Tnt2oRkE1ph4Va1tT9pUweBrq5TIuHmAQ8PrNBKS756gQfwimAv5sKV7r6tE6JyVGegxFsjHNtwnal+eBi/ZuyR0boCQh1vLN8j7Eg24/nial2S1cfH6w1u0homSoAQEEvZHYaisRcW7VHBak0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687833; c=relaxed/simple;
	bh=Q33l82gvRt6eEQpZBkqJ7vujJZetV/Yjl/oslUITV40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z7clzrxLFOCzPcJvDav/6EL1JCsNQHDuzbYi+U66fBkZxvuE8oXztSwD4ttvYQreGUfpjYifyZvky8b1hIS3iDeYj7FvdH4tpr+1ZUyZIsuf/P7E4U3BxZnKdsqNPW/LlkUypA1TEGk+mwYAnlq4El7wONF+YjHkxQYAsY5waNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1j3nZ7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1j3nZ7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6671F00893;
	Fri,  5 Jun 2026 19:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780687830;
	bh=UOfHv0wz8DyHin7YQLHq3wuhchoqfKhbeP4AG4ERwkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V1j3nZ7X+AZd0ZTyceeB2qZDj3KT/1KsCUXt/+hj/kalzL1vGvdyglOKoUYAO6XU9
	 60WFTl6HlR0548+2ES1q5RYAYVvosDBd4sjRyDMAJ9E1bemsqQVhcEw9T5fVVZ7nKy
	 uEosaDnwQTx2jaWfZPgWWV0zMWMURXwI5gNFNEhUCbuWCXW57nr9iOVTwGLT2klgai
	 5/a2UYYbMuusU8J4mTQPVqB/RZaMYm0NBPUP/AMbf7DOVliZSbmdP5D7h0rOJhKuC5
	 GFUf4X5lmrefsWnetvfMqLtcmoUs6BCRFAd0wTUjiHQNE6GrZCwrmPSAJuD6cvvN61
	 nzjRzdOZ4qlHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 11/19] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605191500.2477026-12-irogers@google.com>
References: <20260605191500.2477026-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:30:29 +0000
Message-Id: <20260605193030.4A6671F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Truncating the event payload during copy while preserving the orig=
inal large `header.size` leads to heap out-of-bounds reads and writes.
--

commit 929f25f8c9aa5f28716697be8db6159cf17bcacf
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

This commit adds a common evsel field for events and moves sample specific
fields. It adds accessors for sample events and changes memory allocation
to only allocate enough memory for the copied event instead of the maximum
event size.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 6105ab183d7a0..acd280794f66f 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -511,33 +840,56 @@ static PyTypeObject *pyrf_event__type[] =3D {
>  	[PERF_RECORD_SWITCH_CPU_WIDE]  =3D &pyrf_context_switch_event__type,
>  };
> =20
> -static PyObject *pyrf_event__new(const union perf_event *event)
> +static PyObject *pyrf_event__new(const union perf_event *event, struct e=
vsel *evsel)
>  {
[ ... ]
> +	size_t copy_size =3D event->header.size;
> +
> +	pevent =3D PyObject_New(struct pyrf_event, pyrf_event__type[event->head=
er.type]);
> +	if (pevent =3D=3D NULL)
> +		return PyErr_NoMemory();
> +
> +	if (copy_size > sizeof(pevent->event))
> +		copy_size =3D sizeof(pevent->event);
> +
> +	/* Copy the event for memory safety and initilaize variables. */
> +	memcpy(&pevent->event, event, copy_size);
> +
> +	if (event->header.type =3D=3D PERF_RECORD_MMAP) {
> +		/* Ensure '\0' string termination. */
> +		size_t max_len =3D pevent->event.header.size -
> +				 offsetof(struct perf_record_mmap, filename);
> +
> +		pevent->event.mmap.filename[max_len - 1] =3D '\0';

[Severity: High]
In tools/perf/util/python.c:pyrf_event__new(), if event->header.size is
greater than sizeof(pevent->event), the copy is clamped but
pevent->event.header.size retains the original large value.

Could this cause an out-of-bounds heap write when calculating max_len
for the NUL byte termination?

> +	}
> +
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

[Severity: High]
Also in tools/perf/util/python.c:pyrf_event__new(), could passing
pevent->event to evsel__parse_sample() with the original large
header.size cause it to read past the end of the truncated pevent
allocation into adjacent Python heap memory?

> +	if (err < 0) {
> +		Py_DECREF(pevent);
> +		return PyErr_Format(PyExc_OSError,
> +				    "perf: can't parse sample, err=3D%d", err);
>  	}
>  	return (PyObject *)pevent;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191500.2477=
026-1-irogers@google.com?part=3D11
