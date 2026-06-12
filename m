Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05CB34BA50
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303617; cv=none; b=Rkwk/pngtsgZsZ4QpA4wpXjGWkvJdAnGnWAfEXfPfLfZORm1k2loq5KlmSo8RSk4bvQtl9M2iUseSNK9dYBFTCr8Y+fo1d6GJ4PCFfv36lFfiDlx7PBfvJByhsKo6HQyaE/OeCWo/+gotLEd+1Efu/LgAXM82q0fWFKah2/B/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303617; c=relaxed/simple;
	bh=1o+i+gPAXIMB7II6fC4IS//cTtSg28nfKRcd2YB/iTU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IR0gCVXx6c/n5pKUB5AG/xOoGVT3zEkusWG8eli42djftHvM5UJnXROGS8EJ1fTjQEB0TMEt65dE5TdPq9C8HS6u3/iRatdg4Z+UwZeTMU5XdmUmB31eZJ48BSJqAT20cvlKz/pGEZ7R5uHqxXlLkG2af4cf/nOj3wHHCfjGFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+ZwCYY2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+ZwCYY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F64B1F000E9;
	Fri, 12 Jun 2026 22:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303616;
	bh=O/P9PuXWf0aobfQd/2moa8PNr3NS61xqd7vEJMmpVp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l+ZwCYY2JRYL5TpBtBZDDWlPGZkJCxv/tVt5FT2f4nICQSiAlF+iP0tq8RizDyuHz
	 /ZQfoCpvywqcgvJiuRVGdGeXgdkamQMn4edJA6a/aogNGShSPj4cBCUU1LZyG1tE8U
	 0hhqXT6P5o4+uE07OKMWvvxMVwn9/HmHnel2JBSIlIwwDuxeh7NLyyO9PoAkPQu9jb
	 xebxLHS2dvRZCiuaCS8csbnf1+DPBqgKAZwuNqlcIkINwpJUFJf6HB4t64dmr/80uY
	 f9ThuFpBJT4VBVGZ7DaU7y+zeDtR6l9tQzaHbFQrelRPmsX8T5s93VHFeg28mZFqbl
	 E0RURHDLSDXgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 11/19] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612221211.1221305-12-irogers@google.com>
References: <20260612221211.1221305-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:33:35 +0000
Message-Id: <20260612223336.1F64B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Silent truncation and data corruption for events larger than `size=
of(union perf_event)`.
--

commit ea78ca85a68b855961249f4ca0aca0cfc6198207
Author: Ian Rogers <irogers@google.com>
Subject: perf python: Refactor and add accessors to sample event

This commit refactors event sample handling by moving sample-specific
fields to sample events, adding accessors, and attempting to allocate just
enough memory for the copied event. It also adds bounds checking for
event offsets.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -840,51 +840,51 @@
> -	// FIXME this better be dynamic or we need to parse everything
> -	// before calling perf_mmap__consume(), including tracepoint fields.
> -	if (sizeof(pevent->event) < event->header.size) {
> -		PyErr_Format(PyExc_TypeError, "Unexpected event size: %zd < %u",
> -			     sizeof(pevent->event), event->header.size);
> -		return NULL;
> +	if (perf_event__too_small(event, &min_size)) {
> +		return PyErr_Format(PyExc_ValueError, "Event size %u too small for typ=
e %u",
> +				    event->header.size, event->header.type);
>  	}
> =20
> -	ptype =3D pyrf_event__type[event->header.type];
> -	pevent =3D PyObject_New(struct pyrf_event, ptype);
> -	if (pevent !=3D NULL) {
> -		memcpy(&pevent->event, event, event->header.size);
> -		perf_sample__init(&pevent->sample, /*all=3D*/false);
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
> +	/* Copy the event for memory safety and initialize variables. */
> +	memcpy(&pevent->event, event, copy_size);
> +	pevent->event.header.size =3D copy_size;

[Severity: High]
Does this silent truncation cause data corruption for events larger than
sizeof(union perf_event)?

The previous code safely raised a TypeError for oversized events. By silent=
ly
limiting copy_size and overwriting pevent->event.header.size, it appears
evsel__parse_sample() might read garbage data.

When evsel__parse_sample() processes the event, it reads backwards from the
end of the buffer using the altered event->header.size to locate appended
sample IDs. Because the size was truncated, these offsets will point into t=
he
middle of the payload instead of the end of the event.

Could this return garbage metadata or trigger an OVERFLOW_CHECK error (-EFA=
ULT)
for large PERF_RECORD_SAMPLE events that have extensive callchains or stack
dumps?

Additionally, the commit message states "Allocate just enough memory for the
copied event", but PyObject_New() appears to use the statically sized
sizeof(struct pyrf_event) based on the type array. Is the memory actually
being dynamically sized here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612221211.1221=
305-1-irogers@google.com?part=3D11
