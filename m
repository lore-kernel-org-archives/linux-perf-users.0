Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB839185E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159771; cv=none; b=UBV+ulP5L17u1Ta4/PoCK0G/B8vvMadGok+BXp0UjtKUt9Rp+v5jBrbZ3tQ9gFnjkZ/5F+CzHUtSXejVaMXqr8UkunHT0TJErd4NdHXK16Gfgwz3P3PZf5czxUSV/4wSz1OOC2Z/CAKPGQprOLojhyjqjmSashzObYxarL+zbB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159771; c=relaxed/simple;
	bh=rKvNDvFUxWTsQ3aIpTBLWXOhL3UiZWxaWG8qvoQ969c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DVsoP7vgIjukVhYJIJyC6hCCuOAjdPyu72H3k2Lb+79rUtnXatgyALBSby8VLCeW+sF/e5rshFTtzppYX12yE7AtlQi4LtbOU3jfXMMwUaQZ79N+I5+QIjZ9Zu/f7+JqhARJXexfp6WcmtoMuZoXBTOe5chNC2wfeuLn/nFefgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdwFvJw+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdwFvJw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778C0C2BCB0;
	Sat, 25 Apr 2026 23:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159771;
	bh=rKvNDvFUxWTsQ3aIpTBLWXOhL3UiZWxaWG8qvoQ969c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KdwFvJw+8pcKb9KK4AoTOSeZB9TAarROiXs6B0P1H/Z8v9IN7qWFWiBJIvvHH44fE
	 p/LbkdXpEol4wuW1IoqlKYulUIFAVwGKgPZjLIlIMgBjjAD5T4jGH5mViikFFfYjxg
	 3UH6PKMCv2BsaTYa8cDLGrHDLsvGKOIS2j7xz88ZhzUyizLd+trRms2efFBhaMtFDU
	 cm34Y+m9LREgW4629U/kzKU/JNIiPSsfe2sEAvEPizzwjG8XBsOxpI+NdcFWBKoBqv
	 6pybT/2jOCIlS9hFJpwvWWM73jtYwqARkXU8h6uVFtS65/iw5/b/tcMd6cVdXGHERl
	 V0eGTpmbwzBxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/59] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-16-irogers@google.com>
References: <20260425224951.174663-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:29:30 +0000
Message-Id: <20260425232931.778C0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Calling Py_XDECREF(psession->pdata) before perf_session__delete(ps=
ession->session) causes a use-after-free.
- [High] Improper Python C API exception handling causes uncatchable System=
Error or silently swallowed exceptions.
- [High] Zeroing out pevent->sample.user_regs and intr_regs causes a memory=
 leak per sample.
- [Medium] Re-initializing a perf.session object via __init__ leaks Python =
references and the internal perf_session C structure.
- [Medium] Calling methods on an uninitialized perf.session object causes a=
 NULL pointer dereference.
--

commit 9762b5f02b844066c2ef3adf7767df3f2ed547e3
Author: Ian Rogers <irogers@google.com>
Date:   Sat Apr 25 22:49:07 2026 +0000

    perf python: Add python session abstraction wrapping perf's session
   =20
    Sessions are necessary to be able to use perf.data files within a
    tool. Add a wrapper python type that incorporates the tool. Allow a
    sample callback to be passed when creating the session.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index aa63c7ffe822..1af53480661f 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2413,6 +2419,256 @@ static int pyrf_data__setup_types(void)
>  	return PyType_Ready(&pyrf_data__type);
>  }
> =20
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

If pyrf_event__new() returns NULL and sets a Python exception, returning
-ENOMEM here propagates the error back to pyrf_session__find_thread_events(=
),
which then returns PyLong_FromLong(err).

Does returning a valid PyObject while the Python exception indicator is sti=
ll
set cause the interpreter to raise an uncatchable SystemError?

> +	memcpy(&pevent->event, event, event->header.size);
> +	if (evsel__parse_sample(evsel, &pevent->event, &pevent->sample) < 0) {
> +		Py_DECREF(pyevent);
> +		return -1;
> +	}
> +	/* Avoid shallow copy pointing to lazily allocated memory that would be=
 double freed. */
> +	pevent->sample.user_regs =3D NULL;
> +	pevent->sample.intr_regs =3D NULL;

Since evsel__parse_sample() dynamically allocates memory for user_regs and
intr_regs using zalloc(), does explicitly setting these pointers to NULL
orphan the allocations?

When the Python event object is destroyed, it looks like perf_sample__exit()
will skip freeing the NULL pointers, causing a memory leak for every
processed sample containing register data.

I see this regression is fixed later in the patch series in commit
5565efd8694262de670594ae38d7f95f563e85d1 ("perf python: Refactor and
add accessors to sample event").

> +	if (pevent->sample.merged_callchain)
> +		pevent->sample.callchain =3D NULL;
> +
> +	ret =3D PyObject_CallFunction(psession->sample, "O", pyevent);
> +	if (!ret) {
> +		PyErr_Print();
> +		Py_DECREF(pyevent);
> +		return -1;
> +	}

If the user's Python callback fails, PyErr_Print() prints the traceback
and clears the exception indicator.=20

Since this returns -1, does the Python caller receive an error without any
exception being raised, silently swallowing the callback failure?

> +	Py_DECREF(ret);
> +	Py_DECREF(pyevent);
> +	return 0;
> +}
> +
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

Because perf.session is created using PyType_GenericNew(), its C structure
is initially zeroed out.=20

If a user instantiates the object directly without calling __init__, or if
__init__ fails and leaves psession->session set to NULL, does dereferencing
it here cause a NULL pointer dereference?

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

In Python, __init__ can be called multiple times on an already instantiated
object. If this happens, do psession->pdata, psession->sample, and
psession->session get overwritten without calling Py_XDECREF() or
perf_session__delete() on the old resources?

Could this permanently leak the old C session structure and its Python
references?

> +	perf_tool__init(&psession->tool, /*ordered_events=3D*/true);
[ ... ]
> +static void pyrf_session__delete(struct pyrf_session *psession)
> +{
> +	Py_XDECREF(psession->pdata);
> +	Py_XDECREF(psession->sample);
> +	perf_session__delete(psession->session);

If Py_XDECREF(psession->pdata) drops the last reference to the perf.data
object, the memory holding the embedded struct perf_data inside
struct pyrf_data is freed.

Immediately after, perf_session__delete() accesses session->data
(which points to the now-freed pdata->data) to call perf_data__close().

Could this destruction order result in a use-after-free? Should the C
session be destroyed before releasing the Python data object?

> +	Py_TYPE(psession)->tp_free((PyObject *)psession);
> +}
> +
> +static PyObject *pyrf_session__find_thread_events(struct pyrf_session *p=
session)
> +{
> +	int err =3D perf_session__process_events(psession->session);

Similar to pyrf_session__find_thread(), if psession->session is NULL,
will perf_session__process_events() crash?

> +
> +	return PyLong_FromLong(err);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D15
