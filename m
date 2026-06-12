Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536CD30C606
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288868; cv=none; b=sFnz/oMeVupioQI6CeuACyuMKDhfpEYNgxbZcqwNN2fXkqGwN0bLDOa5PYI2dy4dvZcuUEtOGYbIjO0lsiwNXVtdRaKG4XYL9yN3BVnzvEfiim2ae4MJa3A1qcEUL8SPJItiNxo32le0q5p9ugKL13E9iJRuh5EaVNS25knvM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288868; c=relaxed/simple;
	bh=+6xPHEhOZRkrKe1cmaHYYr2YVJKp3kc27a/jurCHuGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LS74HPY2RIGhB3dhQpNQZUmdcEb036sSPcEb5EixEbIgJ8jLPFdz/rBi4scy1Eiw74MF5U1Wq/QZCzost8YB5GAKF79NR44PI+2IIcwanuyX7YvYs0rcf+ly7RFRsRPo+2auuAHPo+YGkb0ilf6tfdF8fGX6ws3eUgDvlHR+Iio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsVkNWkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsVkNWkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48C01F000E9;
	Fri, 12 Jun 2026 18:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781288867;
	bh=3zP5X2Z9WKCgza+VRtwzjp1pwLSSF/I0jAxIoxbuvNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZsVkNWkNFK9PWQCEnK15sArXGFUg0nW/1niVgIcnSvI/G4w3IrmwTlYUwJMSLrWCC
	 Y45qkSdk3pf1ziyrcPKShGZED0JoMHCqhbd97xC+sZN6I2WePj//SFWVnZg28uMw6w
	 CbrwWfyVV0sG/puIwDf5hWs22mR8VvyryFB2NlBdIR8x4VXExrlZQL62Cq6fWAyAnx
	 b0NqkTVs0Q7DmVEFTGaX5jMnkepQrxLe8S8sWHEhuuBFdjA4Ob44mdRi0ZPccRVDdi
	 j+OhQvDLPVF4JAhl6uULGnP2neJe9iNW8SVocz9VFNhHzjeO0eedIXajMsP/t44cri
	 uR24l30F+AVng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 16/19] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612180956.1105352-17-irogers@google.com>
References: <20260612180956.1105352-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:27:46 +0000
Message-Id: <20260612182746.D48C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit introduces a new Python C API (`perf.syscall_name` an=
d `perf.syscall_id`) to replace the `libaudit` dependency, but fails to upd=
ate the target python scripts to actually use the new API.
--

commit 8ab24f7b7bd7192d5eaf878a71de9ce880b2422d
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

This commit introduces pyrf__syscall_name and pyrf__syscall_id to the perf
python extension. These functions use syscalltbl to convert between syscall
numbers and names, intending to replace the libaudit dependency.

> Use perf's syscalltbl support to convert syscall number to name
> assuming the number is for the host machine. This avoids python
> libaudit support as tools/perf/scripts/python/syscall-counts.py
> requires.

[Severity: Medium]
Is this patch missing the corresponding updates to
tools/perf/scripts/python/syscall-counts.py or the Perf-Trace-Util library?

The commit message mentions avoiding the libaudit dependency in the script,
but the patch only introduces the C API without modifying the target script=
s.
The script itself doesn't appear to be updated to use the newly added=20
perf.syscall_name() and perf.syscall_id() functions.=20

Should the script modifications be included here to actually complete the
transition away from the audit python module?

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
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
> +
> +	name =3D syscalltbl__name(elf_machine, id);
> +	if (!name)
> +		Py_RETURN_NONE;
> +	return PyUnicode_FromString(name);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612180956.1105=
352-1-irogers@google.com?part=3D16
