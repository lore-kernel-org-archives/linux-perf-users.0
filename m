Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0437AA94
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574128; cv=none; b=XtCydIO4+rQgt2nQZ9Cp1zOM3nlTOafw4h5y4ECUDo2GM9tLVrs4VW9BDWff7zEEuywotY1K3uXC8B0yPeuqdlzb7izCcz70mzxpixW2bhxBbZe/SvqZFUyhrDLJUUE9AYlE3qdwpRxGN3fCIcr4LT+eloViAvU/NDg6yPEfKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574128; c=relaxed/simple;
	bh=VmYrAz+wDrc8Celwr55Y74Gz01ej4L+u63jhRqAm15g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VfcJNdoS7qGa0DIoBFlmdJttlCNDw2uP9Z9Wax4funyV5Dy9qRb4FypopDGeuHYelAIBmwea5lvvxYwU+W0YN63sRnBRCHJ+clhico5hqIVaWnmHvacMHnRoByRkfk8r7xwYGnn00XGBJn1Ce0c5gyPNOgRiqeDyFR7KEr9+/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH6EXgDg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH6EXgDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86641F000E9;
	Tue, 16 Jun 2026 01:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574127;
	bh=eihH6WwLJiBPDNty7WgC/cuD3WLTnSjvO+hyeErXo+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TH6EXgDgfnUcoVl3kolGvSL6qQJmiHcxTJk9UuEbVeWG1DPfyMBCMKeQ+mdVirUVw
	 j3Sl7htTumV1MKDD+rUe0izSoAkLp1kOtiy7BeeidCCYu3Rxw5YzEhTcR1q8k18Qgg
	 ZdblDeMGJL8sDBe2vquzSHizxjqsgDG+CAnnuNuSf6pewE+HU48vPWdv1Ane6A4XBl
	 NVvsK+7+FZdigoHuTLsJXO/afTHnWgnig1u2oBxGuM/lSwUu0n4mDXXblV0OGMBDY9
	 vqevdj56F5WAGRx4iCNfr3cH/kYJV3O5hTbwKJfYE9nAFQPOV9lN71gQhAlfdMGYyI
	 wn6e1zK6o/xEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 10/21] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616011543.4037138-11-irogers@google.com>
References: <20260616011543.4037138-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:42:06 +0000
Message-Id: <20260616014207.A86641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Cross-endian perf.data parsing is broken for 32-bit fields (pid, t=
id, cpu) because `needs_swap` is temporarily forced to false.
--

commit d6d1f3c58a23e62a794f6e4127e3eb5d94ce2db6
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session

This commit introduces a Python wrapper for perf_session, allowing
perf.data files to be processed natively within Python scripts. It adds
support for a sample callback during event processing and exposes thread
information for querying.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 31da1283fc15e..dc71fe7e37877 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2579,6 +2587,332 @@ static int pyrf_data__setup_types(void)
>  	return PyType_Ready(&pyrf_data__type);
>  }
> =20
[ ... ]
> +static int pyrf_session_tool__sample(const struct perf_tool *tool,
> +				     union perf_event *event,
> +				     struct perf_sample *sample,
> +				     struct machine *machine __maybe_unused)
> +{
> +	struct pyrf_session *psession =3D container_of(tool, struct pyrf_sessio=
n, tool);
> +	PyObject *pyevent =3D pyrf_event__new(event);
> +	struct pyrf_event *pevent =3D (struct pyrf_event *)pyevent;
> +	PyObject *ret;
> +	bool needs_swap;
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	needs_swap =3D sample->evsel->needs_swap;
> +
> +	memcpy(&pevent->event, event, event->header.size);
> +	/* The event is already swapped, disable swapping temporarily */
> +	sample->evsel->needs_swap =3D false;
> +	if (evsel__parse_sample(sample->evsel, &pevent->event, &pevent->sample)=
 < 0) {

[Severity: High]
Does disabling needs_swap here break cross-endian parsing for 32-bit fields
like pid, tid, and cpu?

When processing a cross-endian perf.data file, the core perf framework first
swaps the entire payload as an array of 64-bit integers. Because 32-bit
fields are packed into a 64-bit slot, this generic 64-bit swap reverses both
their byte order and their relative positions.

It looks like evsel__parse_sample() relies on needs_swap being true so it
can un-swap the 64-bit value and apply bswap_32 to the individual component=
s.
By temporarily forcing it to false, the Python tool might silently read
garbage values for these fields during cross-endian analysis.

> +		sample->evsel->needs_swap =3D needs_swap;
> +		Py_DECREF(pyevent);
> +		return -1;
> +	}
> +	sample->evsel->needs_swap =3D needs_swap;
> +
> +	ret =3D PyObject_CallFunction(psession->sample, "O", pyevent);
> +	if (!ret) {
> +		Py_DECREF(pyevent);
> +		return -1;
> +	}
> +	Py_DECREF(ret);
> +	Py_DECREF(pyevent);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616011543.4037=
138-1-irogers@google.com?part=3D10
