Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32972617
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688164; cv=none; b=HHbEam0yutxrBZBu5oP8MfpOicU3VxCuEh1gWOPDMqaXlGhApvLSBf1LZcvYdDwBcsq+pDn6DVNii4w/UYxGmoiYzPjwkl63ZKokSjr2l8gKvlmF9QS5qVk1PEExLUX2GKBDDPvoSK0Y6twEEjrSdY0CFbDz43Dr+ywE0t8dfAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688164; c=relaxed/simple;
	bh=WZacOCuCBLJ6BaiKAUbRTxVEUtKQuMWtbf9kwNjMFo0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J/CSQRlf8XB03iL5hXCfRbA+LLXdDKA4j8Qrvq3y5+cbwRxNvW/P8kWJDqnwiizH3iRfQ3LauIPqhn+88o1Fq7MPtuEMLAcBcW8Ud+9NnLl0J8g6zprM8+mAX5o5185w0bQiFVJBVmkKeMyU7ev/c5f1K+N4kcMJeh5JBOmVF3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X53Gxkac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X53Gxkac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160561F00893;
	Fri,  5 Jun 2026 19:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688163;
	bh=vqSz+T7WVt7orVP0p4bkhh8HbwdyZKKl+0kZbq2R7kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X53GxkacgBX0OYf2UFzshL3c16KPRkTRwVxTEjyV+cpsEhUJzhi+OImlrUwIQjr+w
	 3FtrVc8MTXmNytfm6Z154wFokqxQhjCdf/2L+r4iVe2bFmCVLH/zs+chFqeZ4FwYgc
	 qT3l9rMpf8ZzWXrSsxET2ZlKBHtE3BaMROUzH5KXNztdHOGyxeI2LIrFEQCW4Tbfxc
	 n0Umdi7UqZWuJoDfdzaDnanKzEonXPk0hw0D1RstF5lcF+c4vv0tlQMLIOCOfzeKXN
	 N3VqgrczGNx5KsyakZpUyNs8Z0NClvrFOjqr3dtdJRFQXsu+At8hw2T3wPxeiSPEGs
	 cvJW6jRERwQAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 16/19] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605191500.2477026-17-irogers@google.com>
References: <20260605191500.2477026-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:36:02 +0000
Message-Id: <20260605193603.160561F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete implementation and cross-platform analysis violation =
in the Python API. The patch adds `perf.syscall_name()` to avoid the `libau=
dit` dependency for `syscall-counts.py`, but fails to update `Util.py` to u=
se it. Additionally, the new API cannot be used for cross-platform trace an=
alysis because it defaults to `EM_HOST` and the Python bindings do not expo=
se the trace's `e_machine`.
--

commit 86a217d5e729a1a66f5768f14d13ddebb0e96ae8
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

This commit adds perf.syscall_name() and perf.syscall_id() to the Python
bindings, utilizing perf's syscalltbl support. This is intended to replace
the python-audit dependency previously required by syscall-counts.py.

> Use perf's syscalltbl support to convert syscall number to name
> assuming the number is for the host machine. This avoids python
> libaudit support as tools/perf/scripts/python/syscall-counts.py
> requires.

[Severity: Medium]
Does this patch update the actual python scripts to use the new API?

Looking at tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py,
it seems the syscall_name() wrapper still relies on python-audit, leaving
the libaudit dependency intact for syscall-counts.py.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index eabc71c1f9a2c..b4baf8cd79fa0 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -3938,6 +3940,40 @@ static int pyrf_session__setup_types(void)
>  	return PyType_Ready(&pyrf_session__type);
>  }
> =20
> +static PyObject *pyrf__syscall_name(PyObject *self, PyObject *args, PyOb=
ject *kwargs)
> +{
> +	const char *name;
> +	int id;
> +	int elf_machine =3D EM_HOST;
> +	static char *kwlist[] =3D { "id", "elf_machine", NULL };
> +
> +	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|$i", kwlist, &id, &el=
f_machine))
> +		return NULL;

[Severity: Medium]
Does defaulting to EM_HOST restrict cross-platform analysis?

Since python scripts currently have no way to access the e_machine value
dynamically from the trace (such as from perf_env or evsel), it appears this
will always default to the host architecture.

Will this break analysis when processing a perf.data file recorded on a
different architecture, such as analyzing an ARM trace on an x86 host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191500.2477=
026-1-irogers@google.com?part=3D16
