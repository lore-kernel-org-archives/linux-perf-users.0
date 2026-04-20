Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9540DFCD
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776646010; cv=none; b=evjBRN0b3gCZ4u1LsN5q5u7CJpr8g3LXrgRMdnbNI5r1BKGn9Se4iPGjuuklTls1wjvrScUOxkNbozoL5UYv8lLQSUNoWrH6xztlYsNd7/zmn4fdqtrTkaLkaTHgwYlpbM4PsI53PFUlSxOcN751ZfSfGXdXgPZVEEfWwZqA4T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776646010; c=relaxed/simple;
	bh=+it9W6AF9OAfMaBqmOEN3QnI9m/tK6CYUYcyrCLvCBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TIYPvIl/V15+QMUDNzclinoF6vXtaRet5eEh7eBW+Ec6Q+aTanH1cpzxzMvrJ9ELWFw69Yp3W7jzGda514vdfAuVCa9SZFuVztPdFwIT0b+786m0WEHy3v+DdhiBJkmeqtrTjhFEpmMNPmG0H9KKlWcT4kNqc6KPOQsYXCwfIAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pG0YTWgK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG0YTWgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C00C2BCAF;
	Mon, 20 Apr 2026 00:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776646010;
	bh=+it9W6AF9OAfMaBqmOEN3QnI9m/tK6CYUYcyrCLvCBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pG0YTWgK0KgaOuKhM8g5cn3VsESr7rGMkvCil2TChYKC8HAF366w/d0yCYvaBJjr8
	 i15xAWenCVNtHCbZHABOe+K30zFLaD2Q7edBmHK49XpIfvusxG2ew980DIDA0T9Aqr
	 G0XkrC2S/mijLyKkDQnR5k7b5PrZPNodS9cUg1QWv8vMkGNggXQfraK5pfV4H2ATJZ
	 tz6Vol+/6UD9YgpY539OqbCBgh+fgLnJXobbBG7ENEJPkBuj/+NSiMvQjf3zwg5qpr
	 5k+o0LmUPln5QXfSSMwgciLbPJ7MGAKwHc0gcbpDS9Fx52okKRd9tsGdwH6WisIhJW
	 +SC9FTXv1mVcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 15/58] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-16-irogers@google.com>
References: <20260419235911.2186050-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:46:49 +0000
Message-Id: <20260420004650.70C00C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 7 potential issue(s):
- [High] Double-free and double-decref in `pyrf_session__init` error paths
- [High] Memory leak and unhandled exceptions in `pyrf_session_tool__sample`
- [High] NULL pointer dereference in `pyrf_thread__comm` when thread lacks =
comm events
- [High] Double free of dynamically allocated `perf_sample` fields due to s=
hallow copy
- [High] Type confusion in `pyrf_session__init` data parameter
- [Medium] Missing `.build_id` event handler prevents accurate symbol resol=
ution
- [Medium] Unhandled C-level errors in `pyrf_session__process_events`
--

commit 33b81018adbf676b6f408240aecb61b570c9487b
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session

This commit adds a python session abstraction wrapping perf's session,
allowing a tool to use perf.data files. It allows passing a sample
callback during session creation, process event iteration, and retrieving
thread and comm details.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index f0dff69f67df2..b68668c267d83 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> +static PyObject *pyrf_thread__comm(PyObject *obj)
> +{
> +	struct pyrf_thread *pthread =3D (void *)obj;
> +	struct comm *comm =3D thread__comm(pthread->thread);
> +	const char *str =3D comm__str(comm);

Can thread__comm() return NULL for threads that haven't generated comm
events? If so, will passing it to comm__str() cause a segmentation fault?
Should this check for NULL or use thread__comm_str() instead?

> +
> +	return PyUnicode_FromString(str);
> +}
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
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	memcpy(&pevent->sample, sample, sizeof(struct perf_sample));
> +	pevent->sample.evsel =3D evsel__get(evsel);

Does doing a shallow copy of the sample struct lead to a double free?
If the sample contains pointers to lazily allocated memory like user_regs,
when the Python wrapper is garbage collected, won't its destructor free the
pointers, leaving the perf core to double free them?

> +
> +	PyObject_CallFunction(psession->sample, "O", pyevent);
> +	Py_DECREF(pyevent);
> +	return 0;
> +}

Does this leak memory if the callback succeeds? The return value of
PyObject_CallFunction is ignored and never decremented.

Also, if the callback raises an exception, PyObject_CallFunction returns
NULL and sets the exception indicator. Since this returns 0 and continues
the loop, will returning to the Python interpreter with an active
exception trigger a fatal SystemError?

[ ... ]
> +static int pyrf_session__init(struct pyrf_session *psession, PyObject *a=
rgs, PyObject *kwargs)
> +{
> +	struct pyrf_data *pdata;
> +	PyObject *sample =3D NULL;
> +	static char *kwlist[] =3D { "data", "sample", NULL };
> +
> +	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O|O", kwlist, &pdata, &=
sample))
> +		return -1;

Can the O format specifier result in type confusion? If a user passes an
integer or string instead of a perf.data object, it will be cast to
struct pyrf_data, which could lead to memory corruption when
perf_session__new() accesses it.=20

Should this use O! with &pyrf_data__type instead to enforce type safety?

> +
> +	Py_INCREF(pdata);
> +	psession->pdata =3D pdata;
> +	perf_tool__init(&psession->tool, /*ordered_events=3D*/true);
> +	psession->tool.ordering_requires_timestamps =3D true;
> +
> +	#define ADD_TOOL(name)						\
> +	do {								\
> +		if (name) {						\
> +			if (!PyCallable_Check(name)) {			\
> +				PyErr_SetString(PyExc_TypeError, #name " must be callable"); \
> +				return -1;				\
> +			}						\
> +			psession->tool.name =3D pyrf_session_tool__##name; \
> +			Py_INCREF(name);				\
> +			psession->name =3D name;				\
> +		}							\
> +	} while (0)
> +
> +	ADD_TOOL(sample);
> +	#undef ADD_TOOL
> +
> +	psession->tool.comm		=3D perf_event__process_comm;
> +	psession->tool.mmap		=3D perf_event__process_mmap;
> +	psession->tool.mmap2            =3D perf_event__process_mmap2;
> +	psession->tool.namespaces       =3D perf_event__process_namespaces;
> +	psession->tool.cgroup           =3D perf_event__process_cgroup;
> +	psession->tool.exit             =3D perf_event__process_exit;
> +	psession->tool.fork             =3D perf_event__process_fork;
> +	psession->tool.ksymbol          =3D perf_event__process_ksymbol;
> +	psession->tool.text_poke        =3D perf_event__process_text_poke;

Are we missing the build_id event handler here? Without registering
perf_event__process_build_id, will the machine representation lack build
IDs for DSOs, preventing the symbol subsystem from accurately resolving
addresses?

> +	psession->session =3D perf_session__new(&pdata->data, &psession->tool);
> +	if (IS_ERR(psession->session)) {
> +		PyErr_Format(PyExc_IOError, "failed to create session: %ld",
> +			     PTR_ERR(psession->session));
> +		psession->session =3D NULL;
> +		Py_DECREF(pdata);
> +		return -1;
> +	}
> +
> +	if (symbol__init(perf_session__env(psession->session)) < 0) {
> +		perf_session__delete(psession->session);
> +		Py_DECREF(pdata);
> +		return -1;
> +	}

If symbol__init() fails, perf_session__delete() and Py_DECREF() are
called. When tp_init returns -1, Python automatically invokes the
object's tp_dealloc method.=20

Since psession->session and psession->pdata aren't set to NULL after
being freed here, will the destructor unconditionally execute the cleanup
again, leading to a double-free and a fatal interpreter crash?

> +
> +	if (perf_session__create_kernel_maps(psession->session) < 0)
> +		pr_warning("Cannot read kernel map\n");
> +
> +	return 0;
> +}
[ ... ]
> +static PyObject *pyrf_session__process_events(struct pyrf_session *psess=
ion)
> +{
> +	perf_session__process_events(psession->session);
> +	Py_INCREF(Py_None);
> +	return Py_None;
> +}

Does ignoring the return value of perf_session__process_events() mask
C-level errors? If event processing fails due to file corruption, the
negative integer error code is swallowed, leaving Python scripts unaware
of the truncation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D15
