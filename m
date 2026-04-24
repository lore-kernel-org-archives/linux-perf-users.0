Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E363E1224
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054126; cv=none; b=U3grbEzCqG3sNSYRKi28G4M772InJdP72HFAuU3CgKoRtHC6/Lqq6J0ltmJqErdUg1yuM0xBAwoa4vFIbCpUzAwes+qQ3FS6jBE97qYOHuZMtwQ8oQaogxTYSshe0XG2fsi8ZMoKKuWAN/Y6CBnL2incOnL7V/zCTHGy6M5VUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054126; c=relaxed/simple;
	bh=hjG6xYHZRvCBCgM7llt1OnYw7ssBV2wIqfScLyEnfPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VvpsOYtpqhUKsi9BHQRyr2LM+kUByJbxNMtJhYTrbu1HSUt8a1tWxHh3+hXqocLipXysx0ScpmvUCagQkDG7y8mQemjZYngf7hXnRWKWUmQ8KRoKMwtD4eKmvttk7D++0abc7XioiBSLWNZMMMzjk2V1ryFQGp11XXVOsm0/ff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roZPm18C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roZPm18C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6088FC19425;
	Fri, 24 Apr 2026 18:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777054126;
	bh=hjG6xYHZRvCBCgM7llt1OnYw7ssBV2wIqfScLyEnfPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=roZPm18CXsNFR4YY5D2++z/P6TOeC0Mi58GKjZzakXQFrWeUfFVtzf9H4Y0+jL+1n
	 bTtkUQ7vtVHhbcBNoABddcAHvkkUXZn1Au8RC1SwwBRS3Axsbhe4ATFLSL8eSs3mfW
	 3zBeqXQgu9iPcdUD2iY+QCwWjV+Vv4aHhyL0ZYvllXoS+jtovNwIQjRLwBsXdyCmJW
	 5l77wMVapW/yeILuUEjdUw9T8FRGCT3B6lpIX6xUwiZfU1nvmfnDJYW4uFa0w2nWtV
	 JogiRVTqDFiaQy2P0U0NGxPiwufaILvyPeVYTDB55ilF3HTHwOdW8fbGZrM4fxvMfi
	 D6dB/3gLVTPyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/58] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-16-irogers@google.com>
References: <20260424164721.2229025-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 18:08:45 +0000
Message-Id: <20260424180846.6088FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Medium] Memory leak of dynamically allocated sample data in `pyrf_sessio=
n_tool__sample`.
- [Medium] Segmentation fault in `pyrf_thread__comm` when `thread__comm_str=
` returns NULL.
- [Medium] Python C-API violation causes SystemError when an event creation=
 fails.
- [Medium] NULL pointer dereference in `pyrf_session__process` and `pyrf_se=
ssion__process_events` due to missing initialization checks.
- [Low] Memory and reference leaks in `pyrf_session__init` if called multip=
le times.
--

commit bd2d603bd2c22dec754101a17b6b19313c563182
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session

Adds a Python wrapper for perf_session to allow processing perf.data files
directly in Python scripts. This introduces new abstractions for sessions a=
nd
threads, including a callback mechanism for handling sample events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index a2cdd92e05482b..35eda69a32e164 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> +static PyObject *pyrf_thread__comm(PyObject *obj)
> +{
> +	struct pyrf_thread *pthread =3D (void *)obj;
> +	const char *str =3D thread__comm_str(pthread->thread);
> +
> +	return PyUnicode_FromString(str);
> +}

Can thread__comm_str() return a null pointer if the thread doesn't have an
associated comm string? Passing a null pointer to PyUnicode_FromString()
would crash the Python interpreter.

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

If pyrf_event__new() fails and returns a null pointer, it sets a Python
exception. By returning -ENOMEM here, the error bubbles up to
pyrf_session__process_events() which then returns a valid PyLong object.

Does returning a valid Python object while an exception is pending violate
the Python C-API and trigger a SystemError?

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

Does evsel__parse_sample() dynamically allocate memory for register dumps
into these fields? By explicitly setting these to null pointers, does this
overwrite the only references to that memory and cause a memory leak when
the Python object is later garbage collected?

> +	if (pevent->sample.merged_callchain)
> +		pevent->sample.callchain =3D NULL;
> +
> +	ret =3D PyObject_CallFunction(psession->sample, "O", pyevent);
[ ... ]
> +static PyObject *pyrf_session__process(struct pyrf_session *psession, Py=
Object *args)
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

If a script instantiates the session object via __new__ without calling
__init__, psession->session will be uninitialized. Could this result in a
null pointer dereference when accessing psession->session->machines?

> +	thread =3D machine__find_thread(machine, pid, pid);
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

Python allows __init__ to be called multiple times on the same object.
If this happens, does this leak the previously acquired references to pdata
and the old perf_session allocation?

> +	perf_tool__init(&psession->tool, /*ordered_events=3D*/true);
> +	psession->tool.ordering_requires_timestamps =3D true;
[ ... ]
> +static PyObject *pyrf_session__process_events(struct pyrf_session *psess=
ion)
> +{
> +	int err =3D perf_session__process_events(psession->session);

Could psession->session be uninitialized here if the Python object was
created without calling __init__?

> +	return PyLong_FromLong(err);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D15
