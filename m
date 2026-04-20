Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC31EB1AA
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645449; cv=none; b=amnRNPG4FYQTlrdfk2IwXi2VpsEmUYUqhUeI2MsU4ArXnvbIN4arab/r8k2nplNLa5+ZzQoey9nBVj3jKjln7GA/N401FYQKil9pMAWL3noAv2H+3pyg4EegK8g8yDBIoEHBLil+G2gMDGtQGQZqTh2q6wS8uvuTuE+xXpmWrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645449; c=relaxed/simple;
	bh=zCZ/wwNl01IEuAAY8AQGx6p/dpRZt3VmubAVdx7/AzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PriTv6Y3yUloyX0An4pMVGCTx7SD5m5/Mt/XjyWtwO5qkYzNCY7Krgrklt8XlPXQL+LM4zA3Btp6tyI78fmdghajVPYWgZAI1FBO2lgDgaxR4Xx6iix6nXOv6DO3U8jPgYgdbeV2BnSo4rgVQU7x9LxbkVt30c5L6Qvz+RW8MiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib7ck/FO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib7ck/FO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6CDC2BCAF;
	Mon, 20 Apr 2026 00:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645449;
	bh=zCZ/wwNl01IEuAAY8AQGx6p/dpRZt3VmubAVdx7/AzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ib7ck/FOzNveL+lPe9aZ65NPyGW4dcuIS5hPJUgRSO18EDKVjC1HuC29YD7BqRLNb
	 JmFlKjqEgmQ7UqCFQDXNxvkCESWSEpJT68dEUDE8euJ35648444oe+EZcbzcXi8loe
	 U3tEhYuRmBndIRKvZIQkAnw+takcuLQPPua08SNosBvjljJD3kFMwjVoyKkT98q2EM
	 BQPtlckxPj7UIA4BRKt5Gq+Y1YflmvQcSbTDZltO1qj/+fIPeZEQv4XYc9tvpXTGZ/
	 xyL3P3xzijJptp5+ygTXVZXSe6Zej78SJiYWovwGEnZK5AE1syGpTlDUmWXLXpyys+
	 BXvhCESr1hNjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 20/58] perf python: Extend API for stat events in
 python.c
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-21-irogers@google.com>
References: <20260419235911.2186050-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:37:28 +0000
Message-Id: <20260420003729.0F6CDC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] Double free and Use-After-Free in `pyrf_session__init` error p=
aths.
- [High] The 'stat' Python callback object is leaked when the perf session =
is deallocated.
- [High] Name collision in `pyrf_stat_round_event__members` silently hides =
the event header `type` attribute.
- [High] Python callback result leak and unhandled exceptions during event =
processing.
--

commit a1ff0a0bf7ea7bd5ad6fdf9b3718ad034de0115e
Author: Ian Rogers <irogers@google.com>

perf python: Extend API for stat events in python.c
   =20
This commit extends the perf python API by adding stat information to the
session, including callbacks and event definitions for stat events.

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e5f96bc695fda..1e393f354ea0b 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
[ ... ]
@@ -291,6 +291,75 @@ static PyTypeObject pyrf_lost_event__type =3D {
[ ... ]
> +static const char pyrf_stat_round_event__doc[] =3D PyDoc_STR("perf stat =
round event object.");
> +
> +static PyMemberDef pyrf_stat_round_event__members[] =3D {
> +	sample_members
> +	member_def(perf_event_header, type, T_UINT, "event type"),
> +	member_def(perf_record_stat_round, type, T_ULONGLONG, "round type"),
> +	member_def(perf_record_stat_round, time, T_ULONGLONG, "round time"),
> +	{ .name =3D NULL, },
> +};

Does this name collision silently hide the event header 'type' attribute?

The array defines two members with the identical string name 'type'. When
PyType_Ready() initializes the class dictionary, the latter definition of
'type' overwrites the former.

Will accessing event.type from Python on a stat_round event yield the 64-bit
round type instead of the expected 32-bit event header type
(PERF_RECORD_STAT_ROUND)? This might break scripts that dispatch events bas=
ed
on event.type.

[ ... ]
@@ -2960,6 +3074,39 @@ static int pyrf_session_tool__sample(const struct pe=
rf_tool *tool,
>  	return 0;
>  }
> =20
> +static int pyrf_session_tool__stat(const struct perf_tool *tool,
> +				   struct perf_session *session,
> +				   union perf_event *event)
> +{
> +	struct pyrf_session *psession =3D container_of(tool, struct pyrf_sessio=
n, tool);
> +	PyObject *pyevent =3D pyrf_event__new(event);
> +	struct evsel *evsel =3D evlist__id2evsel(session->evlist, event->stat.i=
d);
> +	const char *name =3D evsel ? evsel__name(evsel) : "unknown";
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	PyObject_CallFunction(psession->stat, "Os", pyevent, name);
> +	Py_DECREF(pyevent);
> +	return 0;
> +}

Does this leak the result of the Python callback?

PyObject_CallFunction() returns a new reference to the result, which is
currently ignored and never decremented via Py_DECREF(), causing a memory
leak for every processed event.

Furthermore, if the Python callback raises an exception,
PyObject_CallFunction() returns NULL and leaves the exception set in the
Python thread state.

Should the C code check the return value to prevent returning to the Python
interpreter with a pending exception?

[ ... ]
@@ -3016,8 +3164,13 @@ static int pyrf_session__init(struct pyrf_session *p=
session, PyObject *args, PyO
>  	} while (0)
> =20
>  	ADD_TOOL(sample);
> +	ADD_TOOL(stat);
>  	#undef ADD_TOOL

Does this leak the 'stat' callback object on session deallocation?

The ADD_TOOL macro increments the reference count of the callback argument
via Py_INCREF and stores it in psession->stat, but the destructor
pyrf_session__delete() appears to omit the corresponding
Py_XDECREF(psession->stat) call.

Also, this isn't a regression introduced by this patch, but does the error
path in pyrf_session__init() cause a double-free and use-after-free?

If symbol__init() fails, the code manually cleans up:

pyrf_session__init() {
    ...
    if (symbol__init(perf_session__env(psession->session)) < 0) {
        perf_session__delete(psession->session);
        Py_DECREF(pdata);
        return -1;
    }
    ...
}

Returning -1 from a tp_init slot causes Python to tear down the partially
initialized object by invoking tp_dealloc, which maps to
pyrf_session__delete().

Because the error handlers do not clear the dangling pointers (e.g. setting
psession->session =3D NULL), pyrf_session__delete() will unconditionally
call Py_XDECREF(psession->pdata) and perf_session__delete(psession->session)
a second time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D20
