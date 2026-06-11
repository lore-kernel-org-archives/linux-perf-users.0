Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D43110785
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200660; cv=none; b=Yw3QCB7ZAEicBKub05Jlsfes5LREGLVgHVRz+84ZXlqxzgl+LU175kfckypmltXfEt6oYbprdjn+C2D3cW60rxS32qC3JcgdBzdsuV32vgcBL16GylvxN31NjoMKWlotpbzz2o/NoyvQs5pV0L/+4cz45h57OkMACvGZmTcg1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200660; c=relaxed/simple;
	bh=TGDG2xodoXeL5RkDw0JKkafScQExGY+x9mFQiYXnYms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rJBLQ9bxqA4eMRIot9Oa9tI6RAfwwmxec0oVQH28XjGlGiQ+7rmYde2IXpz91iwBRWrXbQx9id2NjXgNJHXNl2ner3oyp+KxYkdbvSm5UDNxp9KVJBsB1Zhq8BXtPzHxMj690/yF4jOIQSQL+F9Yj2aN0+YVs8PEyWq2VowKxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsStmkxb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsStmkxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C631F00893;
	Thu, 11 Jun 2026 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200658;
	bh=LX/gEfYD+H+/6Sj6LyRlt0e2VGAVEBtdmsM95SuyIEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lsStmkxbT1iK+zFzKJU/9cKhN5kCd7ce8f1ILIe/8cCO7gvO0utEHn01nS6Qw3xTD
	 xM+OJlt06Q1QBjc0BWQQnEGKrXuLAGhs4k5rBJJgmubgVczPeYanjLY7J1fSPwUzSk
	 ngrV/FUrc/Be5uJo/8B1m4+jGDZygyf+xtgeHWUPjBuZT4RJhaXblzn1cE4g6HrqpM
	 GbwDtML2JG41aBl+uI/jQiloiKIDqVaxxfEjprASbpVDE42nc8H9L7TZOqB00VO1CE
	 FhE05PjqGF3OyjEloZ85NKetJK2Ou6QyE82B2jTVL7vCk9sCfEp3AcX3avD3XIpKVE
	 kGPCTGqdCbyAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 11/19] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611171756.4008769-12-irogers@google.com>
References: <20260611171756.4008769-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:57:38 +0000
Message-Id: <20260611175738.A3C631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pyrf_event__new dynamic sizing attempt fails, leading to silent ev=
ent truncation and uninitialized memory exposure.
- [Medium] Address truncation in map__start and map__end accessors on 32-bi=
t architectures.
--

commit 0b2bea919a58bcd2d7f94b25ee6584d9a64ef1ec
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

Add common evsel field for events and move sample specific fields to
only be present in sample events. Add accessors for sample
events. Ensure offsets are within the bounds of the event. Allocate
just enough memory for the copied event, don't make the maximum event
size each time.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index f060d4ead203a..7011a773e4504 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -394,6 +449,199 @@ get_tracepoint_field(struct pyrf_event *pevent, PyO=
bject *attr_name)

[ ... ]

> +static PyObject *pyrf_sample_event__get_map_start(struct pyrf_event *pev=
ent,
> +						  void *closure __maybe_unused)
> +{
> +	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
> +		Py_RETURN_NONE;
> +
> +	return PyLong_FromUnsignedLong(map__start(pevent->al.map));

[Severity: Medium]
Since map__start() returns a u64, will PyLong_FromUnsignedLong() truncate
the address on 32-bit Python builds? Should this use
PyLong_FromUnsignedLongLong() similar to
pyrf_sample_event__get_map_pgoff()?

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

[Severity: Medium]
Similarly, does PyLong_FromUnsignedLong() truncate the 64-bit map__end()
address here on 32-bit architectures?

[ ... ]

> @@ -511,33 +840,63 @@ static PyTypeObject *pyrf_event__type[] =3D {

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
> +	pevent->event.header.size =3D copy_size;

[Severity: High]
The commit message mentions allocating "just enough memory for the copied
event", but PyObject_New() always allocates the static size of
struct pyrf_event.

If an oversized event is encountered, such as a sample with a large
callchain where event->header.size > sizeof(union perf_event), will
clamping copy_size to the union size silently truncate the payload?
This truncation would cause the subsequent evsel__parse_sample() to fail.

Additionally, for smaller events, does this leave the uncopied trailing
bytes of the union in pevent->event uninitialized? This could potentially
leak heap memory if those bytes are later accessed.

> +
> +	if (event->header.type =3D=3D PERF_RECORD_MMAP) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611171756.4008=
769-1-irogers@google.com?part=3D11
