Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7CA1E7C23
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484642; cv=none; b=PbooOgaAq8d9u9oQ2k8C1v5guMNQYxwI5OO75nZlkvmMVJacPxn++GAkp4tvm/ktKTzBIz8HefoFIqqlsymhjcnFX9CChkhZ1b4naaN3c0v+gLylpFSYZxcThE0BdffUf1Op95w4HAuAqS5Ye0aUPErWl2z+p6P+uamDHqQc9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484642; c=relaxed/simple;
	bh=dA7D4p22lzgjP8tzKdLJo9HM4vLHqBsmro9kR5yFlkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I/RccIbgpdEl1MmhBQd3feQvIyoT7S1xsTinE1M2zzls9RFow12lY4pZTTohHxLDddE9hLL4uf3J3CeGw7GQ+KQMKwMbdozxSAwFPZv+NziyKAASSGqAPfgh8tAn78ggdZ3OEbclKD1X3Ed5iEJ2PCbGZ/9NljNdOzA0ok9YinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BANiLZoR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BANiLZoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE521F000E9;
	Mon, 15 Jun 2026 00:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781484641;
	bh=7MrrAmk/vXl9bT4+2l9flyEDauZ9tLMYiuiI33GQ8sc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BANiLZoRuEK26vfgDbt5uaJRLX+9Tt4n4dpB9OuTnZ/dzCMs53ia4rl4qBQEnDkqU
	 dPOgfY9KbIblokMkbYbcV2Y1TKG0LU6Qt+WcIX3i4pcsQu68fCNLs215UahiGY5L+w
	 iJkH3vZ/oiQfAc728aKkiteyPPQTJ8eEMzbdq8DX2MJney8xCKAP96548Pkq1s5VXh
	 nmhwqhPvLeF/etcr4S11uci4Cvu0ENNjZb1llNDIzdwC0TETJhwQUEftxXvJcJGDkG
	 3xlAfFF5svMqkw5eAH6NftnVj8WaPlrQo1iq2fJmGb1Bx6H1p4K22M+pUW8eNKJChH
	 BblwNHfLqodHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 14/20] perf python: Extend API for stat events in
 python.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615002812.2234795-15-irogers@google.com>
References: <20260615002812.2234795-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 00:50:40 +0000
Message-Id: <20260615005040.CAE521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Processing STAT events in Python bindings fails and aborts the s=
ession if `sample_id_all` is enabled.
--

commit 96aabbd3f75158c04173eac4a95a5b3fb608a17a
Author: Ian Rogers <irogers@google.com>

perf python: Extend API for stat events in python.c

This commit adds stat event information to the perf python session,
extending the API by introducing callbacks for stat events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 6717d5d2cf95d..984513501399c 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -3403,6 +3523,50 @@ static int pyrf_session_tool__sample(const struct =
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
> +	PyObject *pyevent =3D pyrf_event__new(event, evsel, psession->session, =
/*machine=3D*/NULL);

[Severity: Medium]
Will this fail to parse the event if sample_id_all is enabled?

When pyrf_session_tool__stat() passes a non-NULL evsel to pyrf_event__new(),
it unconditionally triggers evsel__parse_sample():

pyrf_event__new() {
    ...
    if (evsel) {
        err =3D evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
    ...
}

For non-sample events with evsel->core.attr.sample_id_all set,
evsel__parse_sample() will attempt to parse the sample_id fields from the e=
nd
of the event buffer:

evsel__parse_sample() {
    ...
    if (evsel->core.attr.sample_id_all) {
        if (perf_evsel__parse_id_sample(event, data))
            ...
}

Since STAT events are synthesized strictly with the size of struct
perf_record_stat and don't contain standard sample_id payloads, could this =
lead
to out-of-bounds reads or an -EFAULT error, aborting the event processing l=
oop?

> +	const char *name =3D evsel ? evsel__name(evsel) : "unknown";
> +	PyObject *ret;
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ret =3D PyObject_CallFunction(psession->stat, "Oz", pyevent, name);
> +	if (!ret) {
> +		Py_DECREF(pyevent);
> +		return -1;
> +	}
> +	Py_DECREF(ret);
> +	Py_DECREF(pyevent);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615002812.2234=
795-1-irogers@google.com?part=3D14
