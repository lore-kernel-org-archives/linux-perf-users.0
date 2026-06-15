Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8713B19D8
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505628; cv=none; b=qBT2Xf0MiN6WawAwmp5DlFU2FSp4WfeRlEJSVX8/p0QOcveoKE81t+dxTvamIq6byqysPe1vhZMvOY8tnxa9L9SlgVV4ScZbw0zMd3IZR+xKQKX3NW9/bVW5UTHZws8QMJ5P1EIS8LSzCdGdl4G4ccWIS6+ufU/pt+Mmm/G6OVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505628; c=relaxed/simple;
	bh=ELCPR5w46NpatZySmzjvW0uOhO/+VNUcY16+pJsATg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Brvopin3BaByj21hoYMQg3+SJR6PeBm0y8rlMjO4LT1RaXx7NV+0dd+UBuoAgWBNxWTCwaOQ8tgtLzEe+Rs/iL8/KtAxAW9QHTCP2zLVEdSI7Up+WCR9He6Qf/lQr3Z98NM/+seQMGXFVL9qGAn1h2ORerCMr5p9dcPr9wCLNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbYhbT3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbYhbT3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC3B1F000E9;
	Mon, 15 Jun 2026 06:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781505627;
	bh=x2iGCzGmm+itaSXorXApX2VnqgFdcS66rkUZlPxnkQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HbYhbT3S0pO6JwhxqC1szTq20mGOK6YshbCVs0t2z4Fay2q+EW8Gw3mi56K1ugmye
	 8iIvV+/QooXcJZxegSp+xE38QrmZAOS3gJW+ayvlDTJVFkRpXk2QBl6luwxr56xcR0
	 qdx2ffzljxmereQpeN8538nFw72PZAcVWNCNgsHPnnoPf+Zh77QMM97F7AyUhVbBW8
	 EfCm8lz/YQfz+2HktRlvUYPVqPc7rLoZqBxkn2fWnzjoxL7LqNQDfXnHS29/JCBTpI
	 nE1CsxTM7pGRC6+Tm4FjtXiXRFhCWqE36gj5Iq30TVJ/6Os8RVeREzjGmirZXPhCMi
	 fPviFdqo47mtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 10/20] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615061631.2382079-11-irogers@google.com>
References: <20260615061631.2382079-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:40:26 +0000
Message-Id: <20260615064026.CDC3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Premature call to `symbol__init` uses uninitialized `perf_env` fea=
tures in pipe mode, breaking cross-platform symbol resolution.
- [High] Disabling `needs_swap` bypasses cross-endian fixups, corrupting 32=
-bit fields in `PERF_RECORD_SAMPLE`.
- [Medium] Python instantiation of `perf.thread()` leaves the underlying `t=
hread` pointer uninitialized, leading to a segmentation fault.
--

commit 306cbe1ee7a8a3f3fbac7d4cfd177c65c25ce949
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session

Sessions are necessary to be able to use perf.data files within a
tool. Add a wrapper python type that incorporates the tool. Allow a
sample callback to be passed when creating the session.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 31da1283fc15e..dc71fe7e37877 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> +static PyObject *pyrf_thread__get_pid(struct pyrf_thread *pthread, void =
*closure __maybe_unused)
> +{
> +	return PyLong_FromLong(thread__pid(pthread->thread));
> +}

[Severity: Medium]
Will this crash if a user creates a perf.thread object directly from Python?

Since pyrf_thread__type has Py_TPFLAGS_BASETYPE and no tp_new or tp_init,
Python inherits object_new, allowing direct creation which zero-initializes
pthread->thread. Without CHECK_INITIALIZED() before calling thread__pid(),
could accessing the pid property dereference a NULL pointer and cause a
segmentation fault?

[ ... ]
> +static int pyrf_session_tool__sample(const struct perf_tool *tool,
> +				     union perf_event *event,
> +				     struct perf_sample *sample,
> +				     struct machine *machine __maybe_unused)
> +{
[ ... ]
> +	memcpy(&pevent->event, event, event->header.size);
> +	/* The event is already swapped, disable swapping temporarily */
> +	sample->evsel->needs_swap =3D false;
> +	if (evsel__parse_sample(sample->evsel, &pevent->event, &pevent->sample)=
 < 0) {

[Severity: High]
Does disabling needs_swap here corrupt 32-bit fields during cross-endian
analysis?

perf_event__all64_swap() blindly swaps PERF_RECORD_SAMPLE payloads in 64-bit
chunks, which swaps the positions of adjacent 32-bit fields (like pid and t=
id).
evsel__parse_sample() relies on needs_swap =3D=3D true to undo this 64-bit =
swap
and correctly restore the 32-bit fields.

By forcing needs_swap =3D false, are we bypassing this critical fixup and
exposing corrupted PID, TID, and CPU data to Python tooling?

[ ... ]
> +static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, P=
yObject *kwargs)
> +{
[ ... ]
> +	session =3D perf_session__new(&pdata->data, &psession->tool);
> +	if (IS_ERR(session)) {
> +		PyErr_Format(PyExc_IOError, "failed to create session: %ld", PTR_ERR(s=
ession));
> +		goto err_out;
> +	}
> +	psession->session =3D session;
> +
> +	if (symbol__init(perf_session__env(session)) < 0) {

[Severity: High]
Will calling symbol__init() here break cross-platform symbol resolution in
pipe mode?

In pipe mode, perf_env is not populated by perf_session__new(); instead,
features arrive dynamically later during perf_session__process_events().

Since perf_env is empty at this point for piped streams, vmlinux_path__init=
()
falls back to the host machine's uname(). Doesn't this irreversibly configu=
re
symbol resolution for the host's architecture instead of the recorded
machine's architecture?

> +		PyErr_SetString(PyExc_OSError, "perf: symbol__init failed");
> +		goto err_out;
> +	}
> +
> +
> +
> +	return (PyObject *)psession;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615061631.2382=
079-1-irogers@google.com?part=3D10
