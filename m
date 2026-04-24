Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30053344025
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051024; cv=none; b=XdNJ8gPx8ePf5b8Ze8xBlbZuabmZGddAHiMI+AzI9e7OcUp+tVS7G6kMmSfXOkPb2+XrSEAu6bZCaYiQiLAPdw2NvHrb4a5DAPCyUVUJJ1Y6WNOjKfpUOpWsSiXZpCjzqS+Ti7OPRkB4mAqMQen9WgR7eloTwNO88bIz4Y0/12w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051024; c=relaxed/simple;
	bh=HLS2nzO3AqMPwgNHEAMA02zB/o8jSZ5cjdqimbKAiWw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ij+eZ/WGXgJgZo/W9ALE+N4Rv6g1lPWEP0VCyQfSy+iTr4rNWQX5BI1J8uxl9sgj6foj4eMli91Phrk9xh+HeK2EFHV+6mMHShNAD19rHxkQSTqTqbS6lusNwBJzYeoBTysgY7AjlPjZUjQIzHUr1g5wjxfrnunzpHsFpAAj0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH1bUfHD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH1bUfHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A0CC2BCB2;
	Fri, 24 Apr 2026 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051023;
	bh=HLS2nzO3AqMPwgNHEAMA02zB/o8jSZ5cjdqimbKAiWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CH1bUfHD0MVVkWbpl5nKfoXaavhlWWDhhSgPV/0QP90PIv5KPm616Dkfd2FOrOKXw
	 GY+5wbZMs7rJzLtFqu2dSYeIeDpxvBFfpMap9ga/IYsP3u2c8jtZClR06+INCTIRvG
	 d69EyNpPdf2cRHO8WUHjjrYpwJrwDj7PWFhhT7iJLe98HwLT2GYzunoDDmDh8XIS8u
	 mw877Flp1xL05fdi8iKvARgBRkWqLeuH4lcJ4Rls2bgcO0rAuDQfE1IV7uc8IIbkNn
	 0+9WG7ajtlYN9FNqXwwohmmy+i4/6idYLjljuM3CIdjOEXlv3S8Sf2ylAG86H2SoYo
	 A4HZacmwC0oMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 20/58] perf python: Extend API for stat events in
 python.c
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-21-irogers@google.com>
References: <20260424164721.2229025-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:17:03 +0000
Message-Id: <20260424171703.B1A0CC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] The `stat_round_type` field has an incorrect memory offset, le=
ading to memory corruption.
- [High] The `pyrf_session_tool__stat_round` function leaks memory and fail=
s to handle Python exceptions.
- [High] A single Python callback is overloaded for `stat` and `stat_round`=
 events with incompatible argument signatures.
- [High] Exposing `sample_members` for stat events without initialization l=
eaks garbage memory data to Python.
--

commit fdd2ccb8d95335f5dbcb00dd40bf892c370291b7
Author: Ian Rogers <irogers@google.com>

perf python: Extend API for stat events in python.c

Add stat information to the session. Add call backs for stat events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index dc10d8a42d9247..c4f0e01b64f364 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -299,6 +299,76 @@ static PyTypeObject pyrf_lost_event__type =3D {

[ ... ]

> +static PyMemberDef pyrf_stat_event__members[] =3D {
> +	sample_members

Do the sample_members macros expose uninitialized memory here? Unlike
sample events where evsel__parse_sample() initializes the pevent->sample
structure, stat events are created with PyObject_New() which does not
zero-initialize the memory.

If a Python script accesses any sample_* attribute on a stat event, could
this read uninitialized C heap memory?

> +	member_def(perf_event_header, type, T_UINT, "event type"),
> +	member_def(perf_record_stat, id, T_ULONGLONG, "event id"),

[ ... ]

> +static PyMemberDef pyrf_stat_round_event__members[] =3D {
> +	sample_members
> +	member_def(perf_event_header, type, T_UINT, "event type"),
> +	{ .name =3D "stat_round_type", .type =3D T_ULONGLONG,
> +	  .offset =3D offsetof(struct perf_record_stat_round, type), .doc =3D "=
round type" },

Does this offset calculation corrupt the Python object header?

The member_def macro correctly calculates offsets from the base of the
allocated Python object by adding offsetof(struct pyrf_event, event).

By omitting the base offset for struct pyrf_event, reading or writing
stat_round_type in Python might write directly into the PyObject_HEAD field=
s.

> +	member_def(perf_record_stat_round, time, T_ULONGLONG, "round time"),
> +	{ .name =3D NULL, },
> +};

[ ... ]

> +static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
> +					 struct perf_session *session __maybe_unused,
> +					 union perf_event *event)
> +{
> +	struct pyrf_session *psession =3D container_of(tool, struct pyrf_sessio=
n, tool);
> +	PyObject *pyevent =3D pyrf_event__new(event);
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	PyObject_CallFunction(psession->stat, "O", pyevent);

Since psession->stat is used here with one argument ("O"), but
pyrf_session_tool__stat calls it with two arguments ("Os"), will this cause
a TypeError in Python when a single callback function is registered for
both events?

Also, should the return value of PyObject_CallFunction() be checked and
decremented?

It returns a new reference on success which seems to leak since Py_DECREF()
is not called.

Additionally, if the Python callback raises an exception, the function
returns NULL. Without a check and a call to PyErr_Print(), the Python
interpreter might remain in an error state.

> +	Py_DECREF(pyevent);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D20
