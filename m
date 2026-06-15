Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B31F413221
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544190; cv=none; b=bKOUpm9H5boRn94vfYpwqlxZFOKYh6SniKQ1UgUppwyiw2LiBq7A/dg6JLA3fE+k1hcd9OC5L9EX9Sgvz2AA9meYVw1t8v7fW6uzEjOgOZAehE5YxIHucHrcPxPEEVppp4qeNhnblDnizHH5t1PYtJdhktrnNGfPBTxapGrXgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544190; c=relaxed/simple;
	bh=ehTR+OD8UUb1lmI5kkhG2nPiFu+IH6axOJDGkLa6b5E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YQqiDJ4xLOjfmO8Z95xFrbmuNLuWI+rgRhEXDC73GLhxjmqM4Z9dB57532O3pxGuDDg46SWV+qX4C87ZL1CAiLyB7Mbo9kXseJsVJLMp3MTCsRCLPH4Jr+JdXqcCVFlZB+8oj2oA+EfS9e56t0EW4rfEzmkuJhK9u4ZAIt9qCkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJeo4asX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJeo4asX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9271F000E9;
	Mon, 15 Jun 2026 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781544189;
	bh=dJQK/3M7hECr8lNhbZ82q3NCTRBb5Lvpvw1/12dRVIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dJeo4asXeX+PvKFn8koY1M+ok0ERuv4xNrKVTH6tbyigxroCcStP2Wbvh7sFx5oo7
	 HLcFTrgwUyPjwYDr/SSUp7GOkFqQtzrK8ZKfsXSrvWBWBgH0KWRQo41rDd4RYiqRU0
	 kMb6j6nibOfPci22EZddeKV8osSok3L767Tp7d8oaXfgd9YhFmW+3eGWGZx3BkYKlO
	 Qlkvty+BzKrwhkk7YEx/S+9Hj7tpONZKZBwrW1cYJ+04wpcAY1eNpXqbcZc5XLQY6y
	 C0+tIANh4O1pNqeroCnaXh7bh/Cy87aXczRuf64CypsUpp6x088xL3ghQXk5SvlrmE
	 6lwNlJEwdkAvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 10/20] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615165010.2724690-11-irogers@google.com>
References: <20260615165010.2724690-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:23:08 +0000
Message-Id: <20260615172308.EB9271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing initialization checks in `perf.thread` property getters le=
ad to a NULL pointer dereference and Python interpreter crash if instantiat=
ed directly.
- [Medium] Forcing `needs_swap =3D false` in `pyrf_session_tool__sample` co=
rrupts packed 32-bit sample fields during cross-endian analysis.
- [Low] The python session initialization omits multiple standard tool call=
backs, causing several event types to be silently dropped.
--

commit 60c4793dda7c722e33b672d1663b27575f26ddbc
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session
   =20
Sessions are necessary to be able to use perf.data files within a
tool. Add a wrapper python type that incorporates the tool. Allow a
sample callback to be passed when creating the session.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 31da1283fc15e..dc71fe7e37877 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2579,6 +2587,332 @@ static int pyrf_data__setup_types(void)
>  	return PyType_Ready(&pyrf_data__type);
>  }
> =20
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
> +	const char *str;
> +
> +	CHECK_INITIALIZED(pthread->thread, "perf.thread");
> +
> +	str =3D thread__comm_str(pthread->thread);
> +
> +	if (!str)
> +		Py_RETURN_NONE;
> +
> +	return PyUnicode_FromString(str);
> +}
> +
> +static PyMethodDef pyrf_thread__methods[] =3D {
> +	{
> +		.ml_name  =3D "comm",
> +		.ml_meth  =3D (PyCFunction)pyrf_thread__comm,
> +		.ml_flags =3D METH_NOARGS,
> +		.ml_doc	  =3D PyDoc_STR("Comm(and) associated with this thread.")
> +	},
> +	{ .ml_name =3D NULL, }
> +};
> +
> +static PyObject *pyrf_thread__get_pid(struct pyrf_thread *pthread, void =
*closure __maybe_unused)
> +{
> +	return PyLong_FromLong(thread__pid(pthread->thread));
> +}

[Severity: High]
Does this code risk a NULL pointer dereference? Unlike the comm() method
above, this property getter and the subsequent ones (tid, ppid, cpu) do not
use CHECK_INITIALIZED().=20

If a user instantiates this wrapper directly in Python (e.g. t =3D perf.thr=
ead()),
the default allocator creates a zero-initialized struct, leaving t->thread =
as
NULL. Accessing these properties on such an uninitialized object passes NULL
to inline functions like thread__pid(), which will crash the Python interpr=
eter.

> +
> +static PyObject *pyrf_thread__get_tid(struct pyrf_thread *pthread, void =
*closure __maybe_unused)
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
Can this corrupt packed 32-bit sample fields during cross-endian analysis?
By forcing needs_swap to false, evsel__parse_sample() will skip the 32-bit
byte swaps entirely.=20

The payload has already had a 64-bit word byte swap performed by
perf_session__process_events(), and evsel__parse_sample() relies on needs_s=
wap
being true to undo the 64-bit swap and apply proper 32-bit swaps for fields
that share a 64-bit word (e.g., pid and tid).

> +		sample->evsel->needs_swap =3D needs_swap;
> +		Py_DECREF(pyevent);
> +		return -1;
> +	}
> +	sample->evsel->needs_swap =3D needs_swap;
> +
[ ... ]
> +static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, P=
yObject *kwargs)
> +{
[ ... ]
> +	psession->tool.comm		=3D perf_event__process_comm;
> +	psession->tool.mmap		=3D perf_event__process_mmap;
> +	psession->tool.mmap2            =3D perf_event__process_mmap2;
> +	psession->tool.namespaces       =3D perf_event__process_namespaces;
> +	psession->tool.cgroup           =3D perf_event__process_cgroup;
> +	psession->tool.exit             =3D perf_event__process_exit;
> +	psession->tool.fork             =3D perf_event__process_fork;
> +	psession->tool.ksymbol          =3D perf_event__process_ksymbol;
> +	psession->tool.text_poke        =3D perf_event__process_text_poke;
> +	psession->tool.build_id         =3D perf_event__process_build_id;
> +	psession->tool.attr		=3D perf_event__process_attr;
> +	psession->tool.feature		=3D perf_event__process_feature;
> +	psession->tool.stat		=3D perf_event__process_stat_event;
> +	session =3D perf_session__new(&pdata->data, &psession->tool);

[Severity: Low]
Does this omit several standard tool callbacks? Since perf_tool__init()
initializes the tool callbacks to stubs, omitting callbacks like .event_upd=
ate,
.tracing_data, .id_index, .thread_map, and .cpu_map causes those events to
be silently dropped.=20

Missing .event_update, for instance, leaves evsel unit, scale, and naming
configurations outdated in pipe mode.

> +	if (IS_ERR(session)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615165010.2724=
690-1-irogers@google.com?part=3D10
