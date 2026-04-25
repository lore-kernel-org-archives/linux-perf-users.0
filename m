Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A98335F16E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141156; cv=none; b=qxqriQbd8rcKnDW6hJKcdGxSSwDurrtwOFb88Mv9LMQ3XoXQLtN07U6Hyp9cm4Ik5G6PAP/y3zW9u+LvKa93oM/wMvuirQdSpy6rVNmkJ5SyVz9wxlSxoPscc0LdBtivL9LTrHmf8VSccCKIPETiSi3XedutkG2jLc7tx7aH/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141156; c=relaxed/simple;
	bh=sTqEdvuU6hErM67QN0LAlInkBc55eer6+udC0b/BnV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LHwAGxkkKt5FTfezw0HL9Md1Eoa7EQ5GsRtkuPAHfCIBkTwkAQV2nMNOx+TlUvGmKYGU5V+QiXYxICN5DU7GprtDsMeoU9vFuVmM17TlcCouEQToe1+GijadRBs96W2TTAryAEDqJwBW1gu4uWlig0Jx0WjVMV3c+U8Dh+aiMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyYAf84H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyYAf84H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D479C2BCB0;
	Sat, 25 Apr 2026 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141156;
	bh=sTqEdvuU6hErM67QN0LAlInkBc55eer6+udC0b/BnV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TyYAf84H7snysM+4HJ786gCZkm8iw1kzplbtsqBfK/fx8E/cSAUvN+2+8V37YlU7t
	 CJBKx4vuxJPnoYgDcY6DVDeS9pfzg0kbne7l7NP8iwAbWmAqrd+XcoHlzSAZagVKIq
	 L2DrHitgFeAa3+JAPjXe9R3y2DD5gVH2VaFqJxiBiszqWfH19HrGoz8E8a92F1F8Kn
	 vpz/aUPVMeeSfdVcu5umtGF+9gxdUfej9Y8s/QXkHTRV9jnhDfm2bTq6Bro/dko6cw
	 zxzNiC3bOzS9XXjs9MXxlUzkXSEaP0ZoMsnshMXcvF3ViwsbNgdNVnxxdwYO+zaFos
	 Nsi/6WTpMmhAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 20/59] perf python: Extend API for stat events in
 python.c
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-21-irogers@google.com>
References: <20260425174858.3922152-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:19:15 +0000
Message-Id: <20260425181916.2D479C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Unhandled Python exception and incompatible callback signature in =
`pyrf_session_tool__stat_round()`.
--

commit 08c1c5bd9c71b8f41c97d2c5bfb3c2a35ba3f92d
Author: Ian Rogers <irogers@google.com>

perf python: Extend API for stat events in python.c

This commit adds stat information to the session and introduces callbacks
for stat events in the Python API.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index b358852b3528..37764a287a71 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -3051,6 +3166,47 @@ static int pyrf_session_tool__sample(const struct =
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

Since both the stat and stat_round event handlers use the same user-provided
psession->stat callback, will this mismatch in arguments cause a TypeError?

The pyrf_session_tool__stat() function calls it with two arguments (the eve=
nt
and a name string), while this function only passes one argument (the event=
).

> +	Py_XDECREF(ret);

If PyObject_CallFunction() fails (for example, due to the argument mismatch
mentioned above), it will return NULL and leave an active Python exception =
in
the thread state.

Since this function doesn't check for ret =3D=3D NULL to clear the exceptio=
n or
return an error (unlike pyrf_session_tool__stat() which calls PyErr_Print()=
),
will returning 0 here leave a pending exception that could cause the Python
interpreter to crash on subsequent C-API calls?

> +	Py_DECREF(pyevent);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D20
