Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C9372EE9
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141167; cv=none; b=I39jVxcPK3cUHpA10opuViufMbD/igZhFecEV2LSGf+fO07OFM0iTXBpsspAAmGEYFspltDp7xx/2meIpkZ15KC/gKGbu8kGr+8Orw7c6VD9T+QDsbqvyEpcUKWSs6cCDhgYEQxQjrZgZMcm28AX3uOoQruNU9k2NM8+EVcT2po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141167; c=relaxed/simple;
	bh=psqje0YFf17howMe/9dwUkiovmInbPT1Co+haidoNU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FIekztsP+LirqgE4qwpiDWz1vV0CP6Ab8nUEG3MobbWYqciWoTiEXsiZ19XZuXQcv+zeALIF7XYuH/DnvhoQmH0I98PtWTNs4Lbn1DOb5YOwAyeO4zBBe5RgjYbJ5H6b3IPLc/hERzzp7xhlBmEtRryKyq8aDwqHYtHQRbP+0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbWpqE1r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbWpqE1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9601AC2BCB0;
	Sat, 25 Apr 2026 18:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141167;
	bh=psqje0YFf17howMe/9dwUkiovmInbPT1Co+haidoNU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gbWpqE1rTXZ8EfmRXgO8PAjwHlw21YjNl4uZRROl2I7PML6wSfk/FEEnuj4NPszno
	 fQBgi93gkgzrmkT21gdDCgqnFjiCXdzFxrJagFyHXBCwPRJO/iqjnPEIay5iAaeOmF
	 9D1/LPhcIyPCSb/0e3ZwPHbNBlIG1Lu4xmURgZM6CpvFoHzeXr4F+PkK8b1AIXnOwT
	 VIhl64ebE6rX22TCppmbjxbqaZky7UthPHF+D9ehHef71ooKusIyIz8N/lzp0bIOZ2
	 Dol2w1SjaZw1K+kry8djLyqYSOvY3lWRXrGF1WMON6W3NGUzAbjdKCh13o7En24LCI
	 8HqyED+mPw1OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/59] perf python: Add wrapper for perf_data file
 abstraction
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-15-irogers@google.com>
References: <20260425174858.3922152-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:19:27 +0000
Message-Id: <20260425181927.9601AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The `fd` argument in `perf.data(fd=3D...)` is silently ignored a=
nd overwritten, leading to a file descriptor leak and reading from the wron=
g source.
- [Medium] Opening a FIFO via `perf.data()` without releasing the Python GI=
L causes the Python process to hang indefinitely.
--

commit f0f569c0460c34314c3be2d7c3dfa4916ea585ce
Author: Ian Rogers <irogers@google.com>

perf python: Add wrapper for perf_data file abstraction

This commit adds a python wrapper around the perf_data struct. This wrapper
is intended to support session management within python scripts.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> +static int pyrf_data__init(struct pyrf_data *pdata, PyObject *args, PyOb=
ject *kwargs)
> +{
> +	static char *kwlist[] =3D { "path", "fd", NULL };
> +	char *path =3D NULL;
> +	int fd =3D -1;
[ ... ]
> +	if (!path)
> +		path =3D "perf.data";
[ ... ]
> +	pdata->data.mode =3D PERF_DATA_MODE_READ;
> +	pdata->data.file.fd =3D fd;
> +	if (perf_data__open(&pdata->data) < 0) {

Does perf_data__open() overwrite the user-provided fd?

If the path defaults to "perf.data", it appears perf_data__open() will open
that file from the filesystem and overwrite pdata->data.file.fd with the new
file descriptor.

Alternatively, if the path is explicitly set to "-" to trigger pipe mode,
the underlying check_pipe() function unconditionally assigns STDIN_FILENO
for read operations.

Could this sequence cause the provided fd to be leaked and completely ignor=
ed?

Also, can opening a FIFO here block the entire Python process?

perf_data__open() eventually executes a blocking open(path, O_RDONLY) system
call.=20

Since the Python Global Interpreter Lock (GIL) is not released before
this blocking I/O operation (for example, by using Py_BEGIN_ALLOW_THREADS),
will this freeze all other Python threads and prevent Python-level signal
handlers like Ctrl+C from executing if the FIFO is waiting for a writer?

> +		PyErr_Format(PyExc_IOError, "Failed to open perf data: %s",
> +			     pdata->data.path ? pdata->data.path : "perf.data");
> +		return -1;
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D14
