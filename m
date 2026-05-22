Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947FD280331
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489640; cv=none; b=le1T+iVbTyPoljulTpCpAmF6+nS5y9KP8KkAZjcO/FndaKbeA+vBt5HrCIBvZ1ePt/tH02CmtIWhVWXuSL6QKgMw1YyHb49ChL0gBuXAqZ4tU4dhSg1zJ6oDteWNbn4p3BONNw6K97hhcNKqNLdcvsVSexHDhjBTURLrV7WH6UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489640; c=relaxed/simple;
	bh=yDaw9BA1e05DzWcVt5vyLdhtWAdY5zqGBN8bIU4sTsE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P0/OLCcg9pD0jMd3mlckyxztMMc2mQJiNgtrLQ/tQS74iZ2dwnVSaobYLS8NpCMjbPxS6qTDSDI2Vrf0sScQFZ+eT4rTVBDNOnOG4/BHkiRhC+VZLuJ/9ssgUuWepS45c9ayzsFBfu9S6laszS0vozaFiLSkVJg9UItldwuFhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LySs77DC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LySs77DC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DBB1F000E9;
	Fri, 22 May 2026 22:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489639;
	bh=4kDdGCP0JDL8PDBqHlcr1xYF+wyV+D3GutPeoxX1Fpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LySs77DCfVz5LoQrSbnlaNCrtzU5hZ47fG2S9TCUMrQVuh2CemFLcGTAFDKYwvUV3
	 RuuOqO2y9D4Lskez4r+AcSJPo0+K4RkHMcvHJw6yX5yHRmY0vazHwfihmtyQYYzb2G
	 CRYiD5ikBxl/VoJia6OEePyjR2+yptJJ9a0L19LVbumDIltrrJYznQsOAECvWnowpX
	 Ns2YMCc+GwJua8ZvfHG8w9NWIry/LChI5TJBWKr3W5PJDb2FZiylyZ1hjdrDUZeyI2
	 wKNtsq47fr1rrGAolvAjaWMQLRllSl9GITSTX99a4Mx9WLaX30A1Ku+XafzLTqFz6O
	 2LucmUXpiQBdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 18/23] perf python: Extend API for stat events in
 python.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522220435.2378363-19-irogers@google.com>
References: <20260522220435.2378363-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:40:38 +0000
Message-Id: <20260522224039.21DBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The same Python callback is used for both 'stat' and 'stat_round=
' events, but is invoked with different numbers of arguments.
- [Medium] The new 'perf.stat_event' and 'perf.stat_round_event' types are =
not added to the Python module namespace.
--

commit 98e6cac4d71c905dd640dddfae6ccd27bae799e7
Author: Ian Rogers <irogers@google.com>
Date:   Fri May 22 22:04:29 2026 +0000

perf python: Extend API for stat events in python.c
   =20
This commit adds stat information to the perf python session API. It
introduces definitions for stat and stat_round event types and links them
into the perf tool callbacks.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index de7a513895728..4ee3fdbf35de4 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1034,6 +1105,12 @@ static int pyrf_event__setup_types(void)
>  	if (err < 0)
>  		goto out;
>  	err =3D PyType_Ready(&pyrf_context_switch_event__type);
> +	if (err < 0)
> +		goto out;
> +	err =3D PyType_Ready(&pyrf_stat_event__type);
> +	if (err < 0)
> +		goto out;
> +	err =3D PyType_Ready(&pyrf_stat_round_event__type);

[Severity: Medium]
Will these new event types be missing from the Python module namespace?

It looks like the types are prepared here, but they aren't exported using
PyModule_AddObject() in the module initialization function like the other
event types. This would prevent users from accessing them directly (for
instance, to check isinstance(event, perf.stat_event)).

>  	if (err < 0)
>  		goto out;
>  	err =3D PyType_Ready(&pyrf_callchain_node__type);
[ ... ]
> @@ -3294,6 +3409,50 @@ static int pyrf_session_tool__sample(const struct =
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

[Severity: Medium]
Since both PERF_RECORD_STAT and PERF_RECORD_STAT_ROUND share the same
psession->stat callback, will calling it with two arguments here ("Os")
and one argument below ("O") cause issues?

If a Python function is defined to take two arguments for stat events,
it will raise a TypeError when called with one argument for stat_round
events, which would abort the perf session event processing unless the
user implements a workaround like *args.

> +	if (!ret) {
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
> +	if (!ret) {
> +		Py_DECREF(pyevent);
> +		return -1;
> +	}
> +	Py_DECREF(ret);
> +	Py_DECREF(pyevent);
> +	return 0;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522220435.2378=
363-1-irogers@google.com?part=3D18
