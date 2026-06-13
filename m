Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FA9247DE1
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781329443; cv=none; b=qQ9bt5Yc9X0LhYq4Geo16M4A+4/NDBCf0b/0cNiyF0++jKCMUfg4GSTh1yPx7L4Dzo2Nst6uyWNSxBr4Srhc16lgUuPjiFtcxlspgcX2wPCVnKApnen0RhvZTtrLlDB/JDQqVgttg2q9uISioEXDw67pPAilVbJM39WDTQ0/bYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781329443; c=relaxed/simple;
	bh=djQo0z60AWJgXJLI35B2oW6LI/wAL5lKyC47XNJeg9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gjKf8FLNLESUQAwkxU5Jo9+fGbr0tdyTOWevxdFICWdI7nYY9R12Kt+d0PoRzRRM/MeM3eWcRMh3oYC57CCDxEf+Mj0dKdYLPoM0ZR8ExwLEEkHJDfIju3n2ra8Bs5GEXca4DI83NfoyB/wO/8iUcNs//KOPD/c+GAVjazMYVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpOP4NNj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpOP4NNj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD871F000E9;
	Sat, 13 Jun 2026 05:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781329441;
	bh=Lay3u3f2Q65guJVL60tKZbvzNjvGIoRzTxEQaH1VsGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bpOP4NNjD63b5AfEC17ztIYizi++5C2MoG3CM4FoccubHjC5EesJyNqlsa8xBYETY
	 FbrjhnARSQFrTnygtIirfrCRjaK+9xA3vsADVyNJc0gLF4k/RnCtAAYUrMnnWjS3ry
	 dpzjubOpjt+gr7J4Sa9W/GV+9W+q3TDPvRzdbDRdPgc678gVqhEqJ0LY2WnO+FpTHF
	 gGswwnGNfgCbmDViYUP5aEpw6jOuJhAAnITTCRj/QfSj9+WNH1SzGMc4a/A1D7hATm
	 4ia33fRosnqMrBBoR94/1IoZW7x2i1x2mOQkYxjXwD/Zi7qN8DFTWK5TqYdmX/Ocst
	 t5xprYyEmdYOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 10/20] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613052722.1424093-11-irogers@google.com>
References: <20260613052722.1424093-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 05:44:01 +0000
Message-Id: <20260613054401.AFD871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditionally calling perf_session__create_kernel_maps() in pyrf=
_session__new() corrupts kernel maps for read mode, breaking cross-platform=
 offline analysis.
--

commit 360572426fb1f67bb17b6f83fbbbd0bc7dafc69b
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session

This patch adds a Python abstraction layer around perf's session, allowing
tools to process perf.data files via Python. It allows a sample callback
to be passed during session creation and connects up standard event
handling to better support querying the machine and symbols.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 31da1283fc15e..322ec14243af9 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> +static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, P=
yObject *kwargs)
> +{

[ ... ]

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
Will this unconditional call to perf_session__create_kernel_maps() corrupt
the kernel maps during read mode?

Inside perf_session__new(), the kernel maps are intentionally only created
for live or write sessions, skipping it for O_RDONLY offline analysis so
that the maps can be properly reconstructed from the PERF_RECORD_MMAP
events in the perf.data file.

By unconditionally calling it here in the Python wrapper, doesn't it
forcibly inject the local host machine's kernel maps and /proc/kallsyms
into the session? This appears to override the target data file's
environment and break cross-platform offline analysis (for example, when
analyzing an ARM perf.data file on an x86 host).

> +
> +	return (PyObject *)psession;
> +err_out:
> +	Py_DECREF(psession);
> +	return NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613052722.1424=
093-1-irogers@google.com?part=3D10
