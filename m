Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725C63A05C2
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218962; cv=none; b=KozVe5V/o46zoWAp+qz/JC3n0SRoIx0VQ7S4576TcJFTPYjGvdE4IHl6sx6qL6MkR40GkW9q28z9QEcz7w14+O6nkKFAYbVEeDMniZyTL5MDqAqVSx6uwi08Fg1Ud1hY9yMMsGzM6RcV/K7DxeA54Byu3JYsgvDA3O/O7+MnTKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218962; c=relaxed/simple;
	bh=8hLBtmG2DnJSEFUAOj95I2IkZO4gSsr9vmFySFnljkg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EfAQeCxuAzdNhM20EryRF949MVVU1qOnsiKYIHHpz9rSjkJ7qS3fxV5R/cdkPqC8EMGOlkUOZYIrI8KIaIMwh6cd896T+gA85utWq9h+jjT7mew3cDnt0niM7t3DJ2MlRMlB36mubYaAXKVc+Q9a5jSqSydfxbgsu9h80CX+Vrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3bEF030; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3bEF030"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E245D1F000E9;
	Thu, 11 Jun 2026 23:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218961;
	bh=xg5AtrwwWhFjYtUBnyZ+3l/kdueyMLPz0CAgtmJIgmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l3bEF030LipO6D7/0Milj9tPRgCqApISSt3/oJumu+okUXhf6lMXQZAgEYTrqYZN3
	 M/4/GPnfIFqN/grfKjO89PboRnsJ3lDxS8JZYnXRGvyjx/sdXyupeZHxiC+bvISxbw
	 MG4CKF67f5BAnd01LCr8T5Zsisum//9e9ej/1ML4DEDla072BxEHijKbHVh+XEt/5T
	 jQOfFoqu7o7rHjI1S+9LkNrqScn5/a4Cb0aoyt4hkn0vc6ang9nOFsdDV72vSQjiP8
	 vBpRANjuLice70WCvFpgCHKasmAOXO0Eru98AhffeZvuOEdvghiI0BeTMckjEE2KAn
	 fLPNLiwGXT2WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 10/19] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611224455.201994-11-irogers@google.com>
References: <20260611224455.201994-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 23:02:39 +0000
Message-Id: <20260611230240.E245D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pyrf_session__new unconditionally injects local host kernel maps i=
nto the session.
- [Medium] The Python session wrapper fails to register the .tracing_data c=
allback.
--

commit 113cc1b9175a9a6b15bd18f448c4759b7fe16d50
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session

This commit adds a Python wrapper type that incorporates the perf tool and
session, allowing a sample callback to be passed when creating the session.
It also adds a perf thread object for querying machine threads.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index c86b9713c076f..f060d4ead203a 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -2572,6 +2580,321 @@ static int pyrf_data__setup_types(void)
>  	return PyType_Ready(&pyrf_data__type);
>  }

[ ... ]

> +	psession->tool.text_poke        =3D perf_event__process_text_poke;
> +	psession->tool.build_id         =3D perf_event__process_build_id;
> +	psession->tool.attr		=3D perf_event__process_attr;
> +	psession->tool.feature		=3D perf_event__process_feature;
> +	psession->tool.stat		=3D perf_event__process_stat_event;

[Severity: Medium]
Is the .tracing_data callback missing from this initialization?

In pipe mode, tracepoint formats are transmitted via synthesized
PERF_RECORD_HEADER_TRACING_DATA events. Without registering
psession->tool.tracing_data to perf_event__process_tracing_data,
these events seem to be silently ignored by the default stub.

Will this prevent Python tools from dynamically decoding tracepoint
payload fields in pipe mode?

> +	session =3D perf_session__new(&pdata->data, &psession->tool);
> +	if (IS_ERR(session)) {
> +		PyErr_Format(PyExc_IOError, "failed to create session: %ld", PTR_ERR(s=
ession));
> +		goto err_out;
> +	}
> +	psession->session =3D session;
> +
> +	if (symbol__init(perf_session__env(session)) < 0) {
> +		PyErr_SetString(PyExc_OSError, "perf: symbol__init failed");
> +		goto err_out;
> +	}
> +
> +	if (perf_session__create_kernel_maps(session) < 0)
> +		pr_warning("Cannot read kernel map\n");

[Severity: High]
Does this unconditionally inject the local host's kernel maps into the sess=
ion?

perf_session__new() intentionally avoids creating kernel maps when opening a
session in O_RDONLY mode so that the maps can be properly built from the
PERF_RECORD_MMAP events contained in the perf.data file.

By calling perf_session__create_kernel_maps() here, it appears the Python
session forces the use of the local host's kernel maps.=20

Could this break cross-platform analysis if, for example, the Python script
is run on an x86 host to analyze an ARM recording?

> +
> +	return (PyObject *)psession;
> +err_out:
> +	Py_DECREF(psession);
> +	return NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611224455.2019=
94-1-irogers@google.com?part=3D10
