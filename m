Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD64821E098
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776920754; cv=none; b=AhS7tg5MU4CIL1cGFvvTZaYWXQJk8/VsttSW70n/Xy76gcUeI0YOpAq72RoI1DdDB1kKKmhgsieO/4zf8oCB5fT8emhwk/ClnCQfW/i3PPoqVVploQaJmWDRVFiD47+WAY79fwtNlw2WtvvtwRnjgyuSzQl7lf6fsjJYmIZi/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776920754; c=relaxed/simple;
	bh=JX3ql7BNiz2JB5HsjNhWsBllPN8fDXcoyE6yEwi4XCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DCs830NU8G0D2HWYv1VxVLBkSBXglMKFXRK3s9X0sg5jco5d4+EKbuYugvKUB2Q9yHgQUIsU/3cmdukmVkgZUIlpxxvGYJksgHhSKoUbvgWh8VYxuX2v3OBd2mh41D1vvIsJNPqHnOkle0hlFTy0gl2ZKwbnrRVG5u+/+oPc7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfbshBJJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfbshBJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F24DC2BCB2;
	Thu, 23 Apr 2026 05:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776920754;
	bh=JX3ql7BNiz2JB5HsjNhWsBllPN8fDXcoyE6yEwi4XCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tfbshBJJ/P8610U7O0u9rgYYe6itpWk4gs95r5EGwEgvs1I3ngR9FyKELLENN3Pag
	 krdDeIgjjftIov/Xtx3GTxWY0kT0JjYQg9GvWziX+p7I9dFhHvyElmZyIe751K/7cz
	 jJhTuy+5vruv+8CTSVDJg/tbyQ5pFo5FEFGb077vIttx57bYIjjGvohgquDK4gR/kc
	 hEnBID9Ht3kl9c+SmRyugSFN6T8stvf6HNr0UOHXc1xzeLyYT7LRR6CfEkhf/oEhwT
	 EBMVAA5hFxOPn7gMXSoy4ZBKpE84r+PBhQn0oTPI8QPpXZ3wa1x4tjh3zZ3cNErl4z
	 0W5rVQaCU/Sdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/58] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-16-irogers@google.com>
References: <20260423035526.1537178-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 05:05:53 +0000
Message-Id: <20260423050554.3F24DC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Critical] Processing a crafted or large perf.data file causes a heap buf=
fer overflow in `pyrf_event__new`.
- [High] Shallow copy of `struct perf_sample` leaves dangling pointers to t=
ransient `mmap` memory, leading to Use-After-Free.
- [High] Using an uninitialized `perf.session` object causes a NULL pointer=
 dereference and crashes the interpreter.
- [Medium] Python exceptions raised in the sample callback are silently cle=
ared instead of being propagated.
- [Medium] Multiple calls to `perf.session.__init__` cause memory and resou=
rce leaks.
--

commit c2c4ae372f1b1c4cf2637f0cdf94878aa4170a2c
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session

This commit adds a python wrapper for the perf session, allowing developers
to process perf.data files within python scripts. It introduces the ability
to pass a sample callback during session creation and exposes thread queryi=
ng
capabilities.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index a2cdd92e05482..9cd7cca321aa1 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2383,6 +2389,249 @@ static int pyrf_data__setup_types(void)
[ ... ]
> +static int pyrf_session_tool__sample(const struct perf_tool *tool,
> +				     union perf_event *event,
> +				     struct perf_sample *sample,
> +				     struct evsel *evsel,
> +				     struct machine *machine __maybe_unused)
> +{
> +	struct pyrf_session *psession =3D container_of(tool, struct pyrf_sessio=
n, tool);
> +	PyObject *pyevent =3D pyrf_event__new(event);

Since event->header.size can reach up to 65535 bytes for events with large
payloads, does pyrf_event__new() allocate enough space to safely handle the
copy without causing a heap buffer overflow?

> +	struct pyrf_event *pevent =3D (struct pyrf_event *)pyevent;
> +	PyObject *ret;
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	memcpy(&pevent->sample, sample, sizeof(struct perf_sample));

Does this shallow copy leave pointers like sample->raw_data pointing direct=
ly
into the memory-mapped perf.data file?

If the python script retains the event object after the event loop advances
the mmap window, could this lead to a use-after-free when dereferencing
those pointers?

> +	pevent->sample.evsel =3D evsel__get(evsel);
> +	/* Avoid shallow copy pointing to lazily allocated memory that would be=
 double freed. */
> +	pevent->sample.user_regs =3D NULL;
> +	pevent->sample.intr_regs =3D NULL;
> +	if (pevent->sample.merged_callchain)
> +		pevent->sample.callchain =3D NULL;
> +
> +	ret =3D PyObject_CallFunction(psession->sample, "O", pyevent);
> +	if (!ret) {
> +		PyErr_Print();

Does calling PyErr_Print() clear the python error indicator?

If the python callback raises an exception, will it be silently swallowed
here instead of propagating back to the user's script?

> +		Py_DECREF(pyevent);
> +		return -1;
> +	}
> +	Py_DECREF(ret);
> +	Py_DECREF(pyevent);
> +	return 0;
> +}
[ ... ]
> +static int pyrf_session__init(struct pyrf_session *psession, PyObject *a=
rgs, PyObject *kwargs)
> +{
> +	struct pyrf_data *pdata;
> +	PyObject *sample =3D NULL;
> +	static char *kwlist[] =3D { "data", "sample", NULL };
> +
> +	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|O", kwlist, &pyrf_da=
ta__type, &pdata,
> +					 &sample))
> +		return -1;
> +
> +	Py_INCREF(pdata);
> +	psession->pdata =3D pdata;
> +	perf_tool__init(&psession->tool, /*ordered_events=3D*/true);
> +	psession->tool.ordering_requires_timestamps =3D true;
[ ... ]
> +	psession->tool.text_poke        =3D perf_event__process_text_poke;
> +	psession->tool.build_id         =3D perf_event__process_build_id;
> +	psession->session =3D perf_session__new(&pdata->data, &psession->tool);

Since python permits explicit re-entrancy into an object's __init__ method,
does this code leak the previously allocated perf_session struct and other
properties if __init__ is called multiple times on the same instance?

> +	if (IS_ERR(psession->session)) {
> +		PyErr_Format(PyExc_IOError, "failed to create session: %ld",
> +			     PTR_ERR(psession->session));
[ ... ]
> +static PyObject *pyrf_session__process_events(struct pyrf_session *psess=
ion)
> +{
> +	int err =3D perf_session__process_events(psession->session);

If a python script creates a session object without calling __init__, for
example via perf.session.__new__(), could psession->session remain NULL and
cause a segmentation fault here?

> +	return PyLong_FromLong(err);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D15
