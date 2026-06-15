Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165584A0C
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484383; cv=none; b=rg5Ww/T79pmt8U9jwt88MLt6eoNO9QVU6/hFAsQQwNCPODb++9qK/VEO4BXFpkmoUl2BviVU0VOBuGxZwyX+KzjSTt9EVWunaNIlTUdqSsArf7zwbPsAicuQoSEsHG7VLbo2Z4jDqsAK6UB5ZFO7dVc6nYNmDvl/xrhOk7VZoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484383; c=relaxed/simple;
	bh=eM3A5NL/t+4t5dPPhtKsmRKE8fy1n9qzIAcOXD35uF0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YZ3hA9jPz9eYmSg3fDI5rMqrqUmVY9VgkZxI8+AFjjTWptfPar02VgY/8ziINa0jW+ket93dvjLov8eV1v+XOJZZMosSTz+QnkXAV67eyWghehPO0j6ll1T9d55QlySl6krgrnJbJOHK4ZYiNrGi9oQdb5TsIAOZ/Qx8dQKvkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4QyHeC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4QyHeC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F281F000E9;
	Mon, 15 Jun 2026 00:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781484381;
	bh=7dDXfIg8sEtHRn6hWs+DXwY4xyrjuZ6V6npdOKoP254=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B4QyHeC+SBXdRd9JZ9GHZ/SctojNlvFAyEyIOjmSRdgP6Ag++WQWDq2vVku1p/9A8
	 bzC9aJ146EsLmQSytCH2RVUcTKlxaZikauEgsdqm7gGe3jMmDe40Z+X1AQZ7c2NJA+
	 Bqacx5x+lAIOZfPWkva6Du9CY6RBS6VgRjRhdj9YOFb6OFxkN6NbXMNWoGnTPxGJ32
	 FKXYCnvbK/cvtf6O3wU07QlTUc94W0dTKT0CCD3FxEfZGmzTio3KtC6RSbu14iRfDH
	 13oEhapDL0VzP6RN4PmEEUPnOGtwBsjYMmy3NB51/jR3Fpq3h8CLCVjGjX5mftyy8m
	 nMKcJgCmJzJfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 10/20] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615002812.2234795-11-irogers@google.com>
References: <20260615002812.2234795-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 00:46:21 +0000
Message-Id: <20260615004621.95F281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Temporarily disabling `needs_swap` on the `evsel` before parsing=
 the sample bypasses the reverse-swapping logic in `evsel__parse_sample`, c=
orrupting 32-bit fields (e.g., PID, TID, CPU) when processing cross-endian =
`perf.data` files.
- [Medium] Methods of the `pyrf_thread` Python type fail to verify that the=
 internal `thread` pointer is initialized, leading to a NULL pointer derefe=
rence if instantiated directly from Python.
--

commit 1d05d4bde7a03908d9bfd42f9d99101e0d598eec
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session

Sessions are necessary to be able to use perf.data files within a
tool. Add a wrapper python type that incorporates the tool. Allow a
sample callback to be passed when creating the session. Also adds=20
the ability to get the thread associated with a session and retrieve
its comm string.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 31da1283fc15e..d68f7650100b6 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> +struct pyrf_thread {
> +	PyObject_HEAD
> +
> +	struct thread *thread;
> +};
> +
[ ... ]
> +static PyObject *pyrf_thread__comm(PyObject *obj)
> +{
> +	struct pyrf_thread *pthread =3D (void *)obj;
> +	const char *str =3D thread__comm_str(pthread->thread);

[Severity: Medium]
Could this cause a NULL pointer dereference if pthread->thread is not
initialized?

Since the perf.thread type is defined with Py_TPFLAGS_BASETYPE but does not
enforce a custom tp_new allocator, users can instantiate it directly from
Python (e.g., t =3D perf.thread()). This zero-initializes the structure, le=
aving
pthread->thread as NULL and causing a crash when t.comm() is called.

Other types in this file appear to use a CHECK_INITIALIZED() macro to prote=
ct
against uninitialized access.

> +
> +	if (!str)
> +		Py_RETURN_NONE;
> +
> +	return PyUnicode_FromString(str);
> +}
[ ... ]
> +static PyTypeObject pyrf_thread__type =3D {
> +	PyVarObject_HEAD_INIT(NULL, 0)
> +	.tp_name	=3D "perf.thread",
> +	.tp_basicsize	=3D sizeof(struct pyrf_thread),
> +	.tp_dealloc	=3D (destructor)pyrf_thread__delete,
> +	.tp_flags	=3D Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
[ ... ]
> +static int pyrf_session_tool__sample(const struct perf_tool *tool,
> +				     union perf_event *event,
> +				     struct perf_sample *sample,
> +				     struct machine *machine __maybe_unused)
> +{
> +	struct pyrf_session *psession =3D container_of(tool, struct pyrf_sessio=
n, tool);
> +	PyObject *pyevent =3D pyrf_event__new(event);
> +	struct pyrf_event *pevent =3D (struct pyrf_event *)pyevent;
> +	PyObject *ret;
> +	bool needs_swap;
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	needs_swap =3D sample->evsel->needs_swap;
> +
> +	memcpy(&pevent->event, event, event->header.size);
> +	/* The event is already swapped, disable swapping temporarily */
> +	sample->evsel->needs_swap =3D false;
> +	if (evsel__parse_sample(sample->evsel, &pevent->event, &pevent->sample)=
 < 0) {

[Severity: Medium]
Does temporarily disabling needs_swap before calling evsel__parse_sample()
bypass the reverse-swapping logic?

When processing cross-endian perf.data files, perf_event__all64_swap()
pre-swaps the event payload on 64-bit boundaries, transposing pairs of
32-bit fields (like pid and tid). evsel__parse_sample() explicitly relies on
needs_swap to undo this transposition.=20

By forcing needs_swap to false here, does this bypass the recovery logic and
result in Python consumers receiving corrupted data where these 32-bit fiel=
ds
are swapped?

(Note: Later discussions upstream indicate this logic issue is eventually m=
oved
to pyrf_event__new() in commit 2346f47e5c0, but the bug originates here).

> +		sample->evsel->needs_swap =3D needs_swap;
> +		Py_DECREF(pyevent);
> +		return -1;
> +	}
> +	sample->evsel->needs_swap =3D needs_swap;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615002812.2234=
795-1-irogers@google.com?part=3D10
