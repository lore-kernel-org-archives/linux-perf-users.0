Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC10358D27
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142013; cv=none; b=T7a38i7OqExgu2gNnWWvLXh7Ixxew8FSefwunElsOXgjblVI7zMuQ2jHXGD41bZytwjTpV2eTR6/+Z/D7Jo7Wop/6AHx3mWYQMxwRL+jVmuruLxEVXCS5h/1ayLKd3XaaAhw7eF5se9u8nYM16rWoFyGr2j5r4ZrNkyVLlRp58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142013; c=relaxed/simple;
	bh=qX/tNvjcIk4cr9snooVeSOzf9KLQeVRj0ySDHVf8SEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ODonwUBC60TTqCYF/7QI0o3fAd3v1Zo3+8LWeArnZtje11IynT210KNpW/oCfYomZPFr8Gg1F9sukMePT2iVpIB0vO3lOie1IudkpKWkkJxc8jVFGRcYuXiXEK7mnaVkB6CCBUIbwuSvrNzKNeHM/029WsXcseMG+FnZRps/1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRXqI8HM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRXqI8HM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D67C2BCB0;
	Sat, 25 Apr 2026 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142013;
	bh=qX/tNvjcIk4cr9snooVeSOzf9KLQeVRj0ySDHVf8SEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nRXqI8HMUaUtvv3jPVIceu4j2/NQ16BQoLLN4R8r2XkTTYlA/P3qlvnWtVJq1XtAW
	 hiZcJfsSQyynI2t7IqqOWZ7Uswp87WOHaR/G7WYlbivdPxZv0A1sM/DzStuW1pUudu
	 A+duejvcNZvn+kjREWUDyEL/a1zdrTwVSN9XtqMMfzD4gW+bJ36VeCrN6ECw4aQSjS
	 zTXbDCVtkTdPTA8ieYbr4PH+lsmxPXziNfGisUcAjoILztsq5ygJLNOTsT3qMmscJt
	 SaV6DdY08Z5wtjN/cXDjsYCJRHeZPQb8alXS7XRdSY4C/YbC7UAD9pFvGoSD5Z9sGi
	 YaJZQFTw/tyTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/59] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-16-irogers@google.com>
References: <20260425174858.3922152-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:33:32 +0000
Message-Id: <20260425183332.A6D67C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Memory leak of dynamically allocated `user_regs`, `intr_regs`, and=
 `callchain` in `pyrf_session_tool__sample`.
- [High] Segmentation fault in `pyrf_thread__comm` when `thread__comm_str` =
returns `NULL`.
- [High] Python exceptions are swallowed and trigger `SystemError` crashes.
- [High] Missing initialization checks lead to `NULL` pointer dereferences =
in `perf.session`.
- [Medium] Repeated calls to `perf.session.__init__` leak resources.
--

commit 134ca4ebb644a696fcb51b0cf4997378c8e56961
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session

This commit adds a Python wrapper around perf_session to allow using
perf.data files within a Python tool. It supports passing a sample
callback that runs during event processing and exposes thread and comm
string queries.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index a2cdd92e0548..d10359abd1ea 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -2383,6 +2389,252 @@ static int pyrf_data__setup_types(void)
>  	return PyType_Ready(&pyrf_data__type);
>  }
> =20
> +struct pyrf_thread {
> +	PyObject_HEAD
> +
> +	struct thread *thread;
> +};

[ ... ]

> +static PyObject *pyrf_thread__comm(PyObject *obj)
> +{
> +	struct pyrf_thread *pthread =3D (void *)obj;
> +	const char *str =3D thread__comm_str(pthread->thread);
> +
> +	return PyUnicode_FromString(str);
> +}

If the thread does not have a command string associated with it,
thread__comm_str() returns null. Does passing null to PyUnicode_FromString()
cause a segmentation fault?

Should this check the pointer and return Py_None instead?

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
> +	struct pyrf_event *pevent =3D (struct pyrf_event *)pyevent;
> +	PyObject *ret;
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;

If pyrf_event__new() fails, it sets a Python exception and returns null. By
returning -ENOMEM here, does the error propagate up to
pyrf_session__find_thread_events() where it returns PyLong_FromLong(err)?

Returning a valid Python object while an exception is active violates the
Python C-API contract and triggers a fatal SystemError crash.

> +
> +	memcpy(&pevent->event, event, event->header.size);
> +	if (evsel__parse_sample(evsel, &pevent->event, &pevent->sample) < 0) {
> +		Py_DECREF(pyevent);
> +		return -1;
> +	}
> +	/* Avoid shallow copy pointing to lazily allocated memory that would be=
 double freed. */
> +	pevent->sample.user_regs =3D NULL;
> +	pevent->sample.intr_regs =3D NULL;
> +	if (pevent->sample.merged_callchain)
> +		pevent->sample.callchain =3D NULL;

Since evsel__parse_sample() dynamically allocates memory for user_regs,
intr_regs, and callchain, does setting these pointers to null leak the
memory?

When the Python object is garbage collected, the cleanup function
perf_sample__exit() will be a no-op, leaking the allocations on every parsed
event with registers.

Note: This issue was fixed later in the patch series by commit "perf python:
Refactor and add accessors to sample event".

> +
> +	ret =3D PyObject_CallFunction(psession->sample, "O", pyevent);
> +	if (!ret) {
> +		PyErr_Print();
> +		Py_DECREF(pyevent);
> +		return -1;
> +	}

If the user-provided callback raises an exception, does calling PyErr_Print=
()
swallow the exception by clearing the Python error indicator?

This prevents the calling code from properly catching it.

[ ... ]

> +static PyObject *pyrf_session__find_thread(struct pyrf_session *psession=
, PyObject *args)
> +{
> +	struct machine *machine;
> +	struct thread *thread =3D NULL;
> +	PyObject *result;
> +	int pid;
> +
> +	if (!PyArg_ParseTuple(args, "i", &pid))
> +		return NULL;
> +
> +	machine =3D &psession->session->machines.host;

Python users can bypass __init__ by directly invoking
perf.session.__new__(perf.session). Since PyType_GenericNew
zero-initializes the object, psession->session remains null.

Will calling this method then blindly dereference psession->session and
cause a segmentation fault?

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

Since Python allows calling __init__ multiple times on an existing
instance, does unconditionally overwriting psession->pdata, psession->sampl=
e,
and psession->session without releasing prior allocations leak C structures
and Python reference counts?

[ ... ]

> +static PyObject *pyrf_session__find_thread_events(struct pyrf_session *p=
session)
> +{
> +	int err =3D perf_session__process_events(psession->session);
> +	return PyLong_FromLong(err);
> +}

Similar to the __init__ bypass mentioned above, if psession->session
is null, does passing it to perf_session__process_events() result in a
segmentation fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D15
