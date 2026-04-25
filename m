Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447803203A0
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158903; cv=none; b=kCn8/QLlXMJd2oUdQJchMO8CFppqQYaLHifWtcupvsOMflX/dhTFKlLLu5R+GLRml5Xrf7YMkMTwlwn1XvSFWEwaNTqg7GbL3i33Oebmbt+JDlXkW+ORB0NrZWo2dOpOjGtZhXDrZ2plY9Xy2Y3g+tHYS/uU7e73BxpA35A8Zd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158903; c=relaxed/simple;
	bh=QnKCOmgiAuwEHpgmwnYvn7F+BvsqpwvNSGMXl/3SxDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=scIC9TEmPBx2r3RbVZyI2Agg/wODcEqa4KlHtG1MES6M194gQFz3yFafBiWhBQlGTExKk/issPN1vNaIqoABhrha1UpVtc7VrLGEYoFeA3AVF3WZntQtdAyXFAPJ8fLDK740c1GnnyGFKtF7zA31eRQD705b4k6Qh4OCFVF/vqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMTSkdJD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMTSkdJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAC4C2BCB0;
	Sat, 25 Apr 2026 23:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158902;
	bh=QnKCOmgiAuwEHpgmwnYvn7F+BvsqpwvNSGMXl/3SxDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PMTSkdJDeqTNJoCJV4xjs/Jc2LQHsVAnv2ImGD+mfT7PHkxizfVwulu/YXofJiLPc
	 0gxC2GAOy9diHOIX8uCrFWVbd0fhdDgEFkafW0pGNFu/15svcnpk6148UnjNxT6mPf
	 Qqljq80chpsKBPcw3e19aWlRBpFQoMVa1ggoZvJH9ADbjyyPxOF27mQhNb0w46szMZ
	 WTx3ao4RCPAcHtNdsukti5RrY+JkC41687W7QtZJBhHNzDBvIntGWtAQDYF6Drrw22
	 07uIvurhZkeeZmlp19m185mKZRD5bwaNmQMAmn8Aw26K+jmV5onmTYvgG8A3LWlh6I
	 gWwLDJs51TZCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 20/59] perf python: Extend API for stat events in
 python.c
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-21-irogers@google.com>
References: <20260425224951.174663-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:15:02 +0000
Message-Id: <20260425231502.CAAC4C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Unhandled Python exception leak in `pyrf_session_tool__stat_round`=
 causes interpreter crashes.
- [High] Callback argument mismatch causes immediate `TypeError` in `STAT_R=
OUND` events.
- [Medium] Unreachable size checks for new event types in `pyrf_event__new`=
 due to restrictive bounds check.
- [Medium] Out-of-bounds read in `pyrf_session_tool__stat` before event siz=
e validation.
--

commit 33c7e886484e5f9d497ef1294d8391080e491f8c
Author: Ian Rogers <irogers@google.com>

perf python: Extend API for stat events in python.c

This commit adds stat information to the session and introduces callbacks f=
or
stat events in the perf python extension.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 5478561ca62c..17d0ee15336f 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1026,7 +1105,9 @@ static PyObject *pyrf_event__new(const union perf_e=
vent *event, struct evsel *ev
>  	if ((event->header.type < PERF_RECORD_MMAP ||
>  	     event->header.type > PERF_RECORD_SAMPLE) &&
>  	    !(event->header.type =3D=3D PERF_RECORD_SWITCH ||
> -	      event->header.type =3D=3D PERF_RECORD_SWITCH_CPU_WIDE)) {
> +	      event->header.type =3D=3D PERF_RECORD_SWITCH_CPU_WIDE ||
> +	      event->header.type =3D=3D PERF_RECORD_STAT ||
> +	      event->header.type =3D=3D PERF_RECORD_STAT_ROUND)) {
>  		PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
>  			     event->header.type);
>  		return NULL;
> @@ -1038,6 +1119,9 @@ static PyObject *pyrf_event__new(const union perf_e=
vent *event, struct evsel *ev
>  	case PERF_RECORD_MMAP:
>  		min_size =3D sizeof(struct perf_record_mmap);
>  		break;
> +	case PERF_RECORD_MMAP2:
> +		min_size =3D sizeof(struct perf_record_mmap2);
> +		break;

Are the new switch cases reachable for events like PERF_RECORD_MMAP2 and
PERF_RECORD_AUX?

The if condition at the start of the function restricts event->header.type =
to
be <=3D PERF_RECORD_SAMPLE, or one of a few explicitly allowed types like
SWITCH or STAT.

Since MMAP2 and other newly added types fall outside this whitelist, it see=
ms
they will be rejected early with a TypeError before reaching this switch
statement.

[ ... ]
> @@ -3117,6 +3326,47 @@ static int pyrf_session_tool__sample(const struct =
perf_tool *tool,
>  	return 0;
>  }
> =20
> +static int pyrf_session_tool__stat(const struct perf_tool *tool,
> +				   struct perf_session *session,
> +				   union perf_event *event)
> +{
> +	struct pyrf_session *psession =3D container_of(tool, struct pyrf_sessio=
n, tool);
> +	struct evsel *evsel =3D evlist__id2evsel(session->evlist, event->stat.i=
d);

Does reading event->stat.id here bypass size bounds checking?

This reads the event structure before passing it to pyrf_event__new(),
which performs the size validation against min_size.

If a truncated event is smaller than sizeof(struct perf_record_stat), will
this read past the end of the event buffer?

> +	PyObject *pyevent =3D pyrf_event__new(event, evsel, psession->session);
> +	const char *name =3D evsel ? evsel__name(evsel) : "unknown";
> +	PyObject *ret;
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ret =3D PyObject_CallFunction(psession->stat, "Os", pyevent, name);
> +	if (!ret) {
> +		PyErr_Print();
> +		Py_DECREF(pyevent);
> +		return -1;
> +	}
> +	Py_DECREF(ret);
> +	Py_DECREF(pyevent);
> +	return 0;
> +}
> +
> +static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
> +					 struct perf_session *session __maybe_unused,
> +					 union perf_event *event)
> +{
> +	struct pyrf_session *psession =3D container_of(tool, struct pyrf_sessio=
n, tool);
> +	PyObject *pyevent =3D pyrf_event__new(event, /*evsel=3D*/NULL, psession=
->session);
> +	PyObject *ret;
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ret =3D PyObject_CallFunction(psession->stat, "O", pyevent);

Does this mismatch in argument counts cause problems for the Python callbac=
k?

In pyrf_session__init(), the identical user-provided callback (psession->st=
at)
is assigned for both PERF_RECORD_STAT and PERF_RECORD_STAT_ROUND events.

However, pyrf_session_tool__stat() calls it with two arguments ("Os"), while
this function calls it with just one ("O").

If the user's Python callback is defined to accept two arguments, will it
raise a TypeError when a STAT_ROUND event arrives?

> +	Py_XDECREF(ret);
> +	Py_DECREF(pyevent);
> +	return 0;

If the Python callback raises an exception, PyObject_CallFunction() returns
NULL.

Since this function doesn't clear the exception (via PyErr_Clear() or
PyErr_Print()) and returns 0, does this leak an unhandled Python exception?

Returning to the C-API caller with an active exception usually causes a
SystemError in the interpreter.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D20
