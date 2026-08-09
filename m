Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA13AC0C1
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260491; cv=none; b=EToK4bfyID5lyTRRn9JBm0K+T9TZG/CG21XpVXREjnYjPfo7VvCLpn8xkj9EMFAAHE5VIxSQpPbANqNW36PhogwWjNxlczkaqQvLlCc8pyICrVL1Mt3q+NU2FTcYuP0VM18v4pR4JrU642BYoVm6/fAixak8x6UNM2tlh4hJ0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260491; c=relaxed/simple;
	bh=Ldv5+wlL9LAKALrwVNJOTmwVLLq8a5G3HFUlcOjyOLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N64iyk/+xv/YtbLEl70M316EOOcp0nWEbWMxf+ybYHya6ReJXrITjdjV0gZoJ2AbJiZBoeqhREBB/EPUFljXOHNU/AEH3mrQj/D5R5HnX/Qt0c+4A4UP8jLMWk75gUSmHmz39TP8WSJ/5tSQDcocQWCI0B3js0XHZbDFfdbjUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVjYgImC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVjYgImC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B94F1F00ACF;
	Sun,  9 Aug 2026 07:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786260490;
	bh=H8VBKPTrgue76EIdjKv19AXKIXXJXPIZP8aNo1IbcxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WVjYgImC6f7yv73Tp/s8m3SzV/c6uqZCXEgX0xcHOAL6FvzxMnYNtSdDmFJPKxz7O
	 1GdLPnQblgo9QclR4FYFeUROIe1Kaq0M45bBNswxEtRlwkZnqT0UVqU51Ob+vSVOLs
	 Kgm+IHAHUpluwyGD50PvLH2XjoDlTVkoWOhVTAh/sZsO8D+bW6yrj3tEyEOgH1Vvkd
	 jMbwO2su2Z0pBDG+6UTy6zWCWsHSN0rZ6yL3nOrq2X7o+QA32Nm90PD9oVn0etrnxF
	 k6F44DJO/0Nqi6wg7hEml8+3KcBAHtDcnWPpJxPo1SGXIuBC6ZWmUz0H9Hf8BD0RPP
	 kADdaeh1yfK/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/15] perf python: Add thread and PMU uninitialized
 checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260809071455.1221514-12-irogers@google.com>
References: <20260624051535.3584977-1-irogers@google.com>
 <20260809071455.1221514-1-irogers@google.com>
 <20260809071455.1221514-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 07:28:09 +0000
Message-Id: <20260809072810.3B94F1F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `CHECK_INITIALIZED(ppmu->pmu, "pmu")` in `pyrf_p=
mu__events()` causes a Python object memory leak of `py_list` on the error =
path.
--

--- Patch [11]: [PATCH v3 11/15] perf python: Add thread and PMU uninitiali=
zed checks ---
commit a381b82bb0eb00b93be525bfa1c265b574c03a5a
Author: Ian Rogers <irogers@google.com>

perf python: Add thread and PMU uninitialized checks

This commit adds CHECK_INITIALIZED guards to thread and PMU getters to
prevent crashes when accessed before proper initialization.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index c70b151428f76..fe5afce173330 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -1730,6 +1731,8 @@ static PyObject *pyrf_pmu__events(PyObject *self)
>  	PyObject *py_list =3D PyList_New(0);
>  	int ret;
> =20
> +	CHECK_INITIALIZED(ppmu->pmu, "pmu");
> +
>  	if (!py_list)
>  		return NULL;

[Severity: Medium]
Does this code leak py_list if CHECK_INITIALIZED fails and returns early?

Since py_list is allocated with PyList_New(0) just before the initialization
check, it appears this Python object is left orphaned if the macro evaluates
to true and forces an early return.=20

Could the CHECK_INITIALIZED macro be moved to the beginning of
pyrf_pmu__events() before the PyList_New(0) allocation to avoid this leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809071455.1221=
514-1-irogers@google.com?part=3D11
