Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500036D513
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688182; cv=none; b=OPgabIqxs5mek09QLRUCXxqpgXByPSz1m1L4i0GoFpoQzYCiGxS+JNN6HJlbNhwZCMrqniOQ5xYMOIgNPP9JlOU65V8zH6OgR5w4gw0/v942jzLi+JI7xExtLXMApY34hFoLYmQpeDO/6MZDMnbtWeibKWRRGhYw49TBSdOhWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688182; c=relaxed/simple;
	bh=YZJBIhoMzPv6WSIK4u5XQcvFU3a1ZSf1OD6hoYLjblo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LxgpGwXrMBCuEoPwZeJhGIRcVxNS9k3i335Hzx1sxzOWw6cAMvog9Zyp0FKZ7Vre718tvUA2Lshneev6Go4TxfgmBDT0zcdOYCd64GAHtmrvx7XwLYfTgnReAF9qXNCFLxeF/UKPlBQypuztbOPLBaZUrcIZzCMQNszTA5Sp4C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOX+S3oN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOX+S3oN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE7D1F00893;
	Fri,  5 Jun 2026 19:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688181;
	bh=3J9v1Mh0ziMECfdM5sfc5qQznCp7Xvc+2DT9yvgWs8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SOX+S3oNOH9yMJJK4oKs9T2XkpS5jd1SMaQs3QAlz9qbD6azRP7kONK7S8+v44Ozb
	 AwXhkrIwgkZHh0AB/XWNZNIaogZ2EpAi+AQ5pty7efF7l/pP/BkgxL4mvvDHFmkIvP
	 BtAvxQzCXEEz5nquASFLu400PJhiag5+87PfVBV2IVKPaobDdMgVN9vcDWW9uW4VVj
	 +xduUoC8EIauK1fW9DVXaLocMwKZyF4LEw/VCH0lV/FaBfzlG2ylqsgrN5I2vdOEm4
	 PJjKg25Jfq8s79sv2hKzBtpmQlFY48Ja1P+uY3TnDQ/Dqbx9KC0x8TpKNNJT8LHoBl
	 4101Du5eON3Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 13/19] perf python: Add callchain support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605191500.2477026-14-irogers@google.com>
References: <20260605191500.2477026-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:36:20 +0000
Message-Id: <20260605193621.2CE7D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Hardcoding the host machine for callchain resolution breaks analys=
is of guest VM events.

Pre-existing issues:
- [Critical] Truncating oversized `perf_event` structures leads to out-of-b=
ounds heap reads and writes.
--

commit eb725c58d220336416770572b756cd5d942572bc
Author: Ian Rogers <irogers@google.com>

perf python: Add callchain support

Implement pyrf_callchain_node and pyrf_callchain types for lazy
iteration over callchain frames. Add callchain property to
sample_event.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 074dc1d9f2259..d8296d4d17d86 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -987,9 +1140,12 @@ static PyTypeObject *pyrf_event__type[] =3D {
>  	[PERF_RECORD_SWITCH_CPU_WIDE]  =3D &pyrf_context_switch_event__type,
>  };
> =20
> -static PyObject *pyrf_event__new(const union perf_event *event, struct e=
vsel *evsel)
> +static PyObject *pyrf_event__new(const union perf_event *event, struct e=
vsel *evsel,
> +				 struct perf_session *session)
>  {
>  	struct pyrf_event *pevent;
> +	struct perf_sample *sample;
> +	struct machine *machine =3D session ? &session->machines.host : NULL;

[Severity: High]
Does hardcoding the host machine here break the analysis of guest VM events?

Since this forces the host machine context into machine__resolve(), events
originating from guest VMs might be erroneously resolved against the host
kernel's maps and symbols, breaking callchain decoding.

[ ... ]
> @@ -1035,6 +1191,7 @@ static PyObject *pyrf_event__new(const union perf_e=
vent *event, struct evsel *ev
>  	}
> =20
>  	perf_sample__init(&pevent->sample, /*all=3D*/true);
> +	pevent->callchain =3D NULL;
>  	pevent->al_resolved =3D false;
>  	addr_location__init(&pevent->al);
> =20
> @@ -1048,6 +1205,50 @@ static PyObject *pyrf_event__new(const union perf_=
event *event, struct evsel *ev
>  		return PyErr_Format(PyExc_OSError,
>  				    "perf: can't parse sample, err=3D%d", err);
>  	}

[Severity: Critical]
This is a pre-existing issue introduced earlier in this series, but when
evsel__parse_sample() parses the sample here, can it read out of bounds?

Because earlier in pyrf_event__new() the copy of the event is truncated:

    memcpy(&pevent->event, event, copy_size);

but pevent->event.header.size retains its original large size (which can
reach up to 65535 bytes). Since evsel__parse_sample() relies on the
untruncated header.size, it appears it can read trailing variable-length
arrays out-of-bounds, leaking adjacent heap memory or causing crashes.

[ ... ]
> @@ -3179,7 +3380,7 @@ static int pyrf_session_tool__sample(const struct p=
erf_tool *tool,
>  				     struct machine *machine __maybe_unused)
>  {
>  	struct pyrf_session *psession =3D container_of(tool, struct pyrf_sessio=
n, tool);
> -	PyObject *pyevent =3D pyrf_event__new(event, sample->evsel);
> +	PyObject *pyevent =3D pyrf_event__new(event, sample->evsel, psession->s=
ession);

[Severity: High]
Is it possible to pass the dynamically provided machine argument directly to
pyrf_event__new() instead of ignoring it here?

By ignoring the machine argument and passing the overarching session instea=
d,
we sever the context needed for guest VM evaluation, leading to the hardcod=
ed
host machine fallback inside pyrf_event__new().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191500.2477=
026-1-irogers@google.com?part=3D13
