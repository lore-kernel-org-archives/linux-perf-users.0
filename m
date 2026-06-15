Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EED3B0AE6
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504901; cv=none; b=meDqFE0kQEGYm/28YWsI0VueRJzMt8KcQuyGV5H3v1olyHM0zfrSiuvNlXh33mYorgPb1fXi3vGA4xJDH+Yj5YHAx3cnk0VsMT5BiXeu5vbZ2fNWz69h1FdioMk1nKNdTO87O03kgZLarbyRsetZ4ZM0OxddYcVIcZxXxniolBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504901; c=relaxed/simple;
	bh=UVNvNc80OMub+NN5K5sVcLJFy8XLnOlhZjpn43y45/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PRODJEZDNXWkpKKShJnKaR9WgtfCrOnlvJUbWBtVBL7oRf8UuqHoSVF772bGyOx5ncbTmbMc4K/Jx+TGd29BiQjapGK5fjfmSQ94FhGLfrxb52NqiiqvWUBR/l8XPXDoXJfE4czocDy+oomFoSCoYkL5kSgyYzbt+YSwDLm6VA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6tzXFLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6tzXFLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7F21F000E9;
	Mon, 15 Jun 2026 06:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781504900;
	bh=xOlyBQ6JaZhhuc8tKsvUHdylIHjEbgjMQY6fpHjyK+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G6tzXFLZ4nFkUv4jl3eV/IKgIuA88KiqQ8ejJdvvCwHdTyg6+UQeGHOLNNBYzHF26
	 hs09mnrqPVJR9BoyydmoLL+q9zLqZVpUTby5mF+yFrGUm9r4gCeqIITMLlVGM9wgIf
	 eoxd6Zaa0IzUNzT0LLfXAnBFkEN7ucyKkXnGntUqm9/69IG2GbtUKWql64nfXevPKk
	 oTLNBe1ikBd4tyn4qO+NkNedpzkl4m2zGJajJauekg67CL3HCEpXhX/0ePe2yEmU+L
	 9xNr+hR4V5DyEj5T4WERYrqryrMQjvnYLyC6NhpYo7dE9xr0fxwBh3j8WwwFhhTitH
	 fErgqx+q6iFlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 09/20] perf python: Add wrapper for perf_data file
 abstraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615061631.2382079-10-irogers@google.com>
References: <20260615061631.2382079-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:28:20 +0000
Message-Id: <20260615062820.7E7F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Re-initializing a `perf.data` Python object from a directory to =
a pipe fails to clear `struct perf_data`, leaving stale fields like `is_dir=
`.
--

commit 093c2b5a2b7fe819c3de73c0ed08877cb0bbc5c2
Author: Ian Rogers <irogers@google.com>

perf python: Add wrapper for perf_data file abstraction

This commit adds a Python wrapper for the perf_data file abstraction, which
is needed to support sessions in the Python tooling.

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
> +
> +	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|si", kwlist, &path, &f=
d))
> +		return -1;
> +
> +	if (pdata->data.open)
> +		perf_data__close(&pdata->data);
> +	free((char *)pdata->data.path);
> +	pdata->data.path =3D NULL;

[Severity: Medium]
Since Python allows __init__ to be called multiple times on the same
instance, could this leave stale fields in pdata->data?

If the object was previously initialized as a directory, its is_dir flag
would be true. perf_data__close() doesn't clear this flag. If the object
is then re-initialized as a pipe (e.g., path=3D"-"), perf_data__open() will
detect the pipe and return early:

tools/perf/util/data.c:perf_data__open() {
    if (check_pipe(data)) {
        data->open =3D true;
        return 0;
    }
    ...
}

Because of this early return, the subsequent is_dir check is bypassed,
leaving the old is_dir flag as true. This results in both is_pipe and
is_dir being true simultaneously.

Will this cause subsequent C consumers like perf_session__new() to
incorrectly attempt to open the pipe path as a directory and fail with
a WARN_ON?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615061631.2382=
079-1-irogers@google.com?part=3D9
