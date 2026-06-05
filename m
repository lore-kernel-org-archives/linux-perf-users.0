Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678483D3301
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646312; cv=none; b=B6rU4uKeuHjZHDjkHOe303jXlpyduT0E93Qps8a289+C4h5hQB7+b6mjluQ3YipzGSGG48mWhlvxpPwpziiwm2151pke/LBeoii1L7yVYuwYH1KdxrSOPdkrAQiZ62XCSpYFD0/djKAdnORyPQlMutZMXAt7+VPVRgh6JLZIECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646312; c=relaxed/simple;
	bh=ilFr+QSNOHPcvRXcB7ls8c14Zh7tChR5FY8CF38mP1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i6XlErxqH9PtCY3GQCJsfzqd7luePi7TUntCKaiSFc7eGtii2/oTdmJUTFtj6Xj+i78gEroqmLCn4+qfCA/xakVg9QJoU9CBHbRsQWXWDxFB9+aH44LXByIJ6JWOAFJ12nfOC28Llj2CEluWdaHm27y+WtnZdqTWrfWKjiwjlO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL5uZMsX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL5uZMsX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C0B1F00893;
	Fri,  5 Jun 2026 07:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646311;
	bh=dg7GMOpA+Erweu2pbLe2dukza0KMI90nWOziha6x2Bs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bL5uZMsXmH/txdHWelubBMBBDCfzlvQeI6YBDsac5teqrPklTk451EOS+Q8ppy0yQ
	 OcvkFVbc6duOGdbFuEY4EpLMQ3cEoZcmQtNVNXowUeYtcVb1K7PnlpZbPiOf9fLIYf
	 7YkU9hQgfOYS6dkZ3i0CJD6Jbg1fhYg3vs+7s+BOja4fPwbVLnkYA8kUcbBEvXK4ES
	 RsKBjaxVym2j6cezF4V9MLH2HuFoeV9zDFimXJmNzNQADxlGC5VUUavMyRX/Y4LoCe
	 7v5Ts3xDQv6rccaZvUsaFfkYT8uQeXI1GasJA7i69x0QCwhqsVzOWK4JyPEAd/2q0h
	 OUcm2NhGcv/YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/19] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605074003.1730715-11-irogers@google.com>
References: <20260605074003.1730715-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 07:58:30 +0000
Message-Id: <20260605075830.E3C0B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The pyrf_session wrapper fails to register the `.attr` and `.featu=
re` callbacks in `perf_tool`, silently dropping these events and breaking e=
vent processing in pipe mode.
--

commit fa89d52ee147ebcf23e53127275a3667c97e2358
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session

This commit adds a wrapper Python type for perf's session, incorporating the
tool and allowing a sample callback to be passed when creating the session.
When process_events is run, this callback will be executed for sample event=
s.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 4c09a22d35217..b3454ae971c48 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2570,6 +2576,313 @@ static int pyrf_data__setup_types(void)
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
> +	session =3D perf_session__new(&pdata->data, &psession->tool);

[Severity: High]
Are we missing callbacks for attribute and feature events here?

If the .attr and .feature callbacks in struct perf_tool are not registered
here, incoming events will be silently ignored. In pipe mode, dropping
perf_event_header_attr events prevents the creation of evlists and evsels,
which breaks event processing entirely.

Missing .feature callbacks would similarly prevent the population of perf_e=
nv.
Could we add the appropriate attr and feature callbacks here to properly
support pipe mode streams?

> +	if (IS_ERR(session)) {
> +		PyErr_Format(PyExc_IOError, "failed to create session: %ld", PTR_ERR(s=
ession));
> +		goto err_out;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605074003.1730=
715-1-irogers@google.com?part=3D10
