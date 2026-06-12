Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2837B3F2
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303209; cv=none; b=AulJaO+OG1N8jGQTxvMl5XXhaaI/XJpiuAlj6h0Nav3xSF8ZsG6f96kEV748ZcCifMHW5IupqWZvIaB1sTfN7ZXwZZto40BxXWwUnwsurAeVjnabtf9nVE8KnYCPrlbrzrK9KhshF7ZWkrElVL1zt5XI0K7jhSzcuh8aBSpY8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303209; c=relaxed/simple;
	bh=/5jMNXQvDTW+vijvJY7jG2lNdbgY3RmaGOgRZ0F3Ixw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pi0UKZGSzw730/oR4bHYA278JicuHsaOmQRPbgqn8PnyhH80Oj1fmG1ep1EWpOD4mH9rgBJjq0URAjfL8kB68abHPJrN/YDK+6vZqp8OgfxD5NM5rHCeH3vGuQbTqrPpRlVdAPYBkbUw46B0ufJUMcHh5M9s3NTVyFznKVKM770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6u+eF8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6u+eF8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911081F000E9;
	Fri, 12 Jun 2026 22:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303208;
	bh=LJ1/j8oOPZMKaec1hQXVZHWxLMT2oNRNp3Wd7Xy03jI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E6u+eF8lnBLKNbyAiCo4oN+7m8HsK+ZNJLpyrfRJU5pVbEMND4TCpCXe9amx5TD7J
	 cOoacCoMVs7VYZvs7te+F0wbSaBRg40yqa7GTYf7/Bx2q3tqBZcVi3rT8HObNrdKG8
	 5++a0FODcDsxj5xMp4w82DRhoOhbfl8LEOu1vOvPdKqxyIuF315uZnIYvR6mE8IQbd
	 cvWYqWsn2fUpHDKdAfhS7hIWMaRshAYJyjn0FYvK9ovlEgKquxLy0sjlwUZw/FqOze
	 DNgLR7TodnX97N8cnzlVIiB2DHZHwLV1xWNvcEWuwWsGd/cz0BfgZO6MUQsBD2XjAl
	 eDqG8vB2qyr2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 12/19] perf python: Add mmap2 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612221211.1221305-13-irogers@google.com>
References: <20260612221211.1221305-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:26:47 +0000
Message-Id: <20260612222648.911081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `filename` field in `mmap2_event` is not guaranteed to be NUL-=
terminated, leading to a potential heap out-of-bounds read when accessed or=
 formatted in Python.
--

commit a4ead9e80a925079e6ee879a3bdb58dc505d685b
Author: Ian Rogers <irogers@google.com>
Subject: perf python: Add mmap2 event

If mmap is handled so should mmap2 events. Add support as a distinct
python event type.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index decdbf9e93afa..bc9a3c6643c50 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> +static PyMemberDef pyrf_mmap2_event__members[] =3D {
> +	sample_members
> +	member_def(perf_event_header, type, T_UINT, "event type"),
> +	member_def(perf_event_header, misc, T_USHORT, "event misc"),
> +	member_def(perf_record_mmap2, pid, T_UINT, "event pid"),
> +	member_def(perf_record_mmap2, tid, T_UINT, "event tid"),
> +	member_def(perf_record_mmap2, start, T_ULONGLONG, "start of the map"),
> +	member_def(perf_record_mmap2, len, T_ULONGLONG, "map length"),
> +	member_def(perf_record_mmap2, pgoff, T_ULONGLONG, "page offset"),
> +	member_def(perf_record_mmap2, prot, T_UINT, "protection"),
> +	member_def(perf_record_mmap2, flags, T_UINT, "flags"),
> +	member_def(perf_record_mmap2, filename, T_STRING_INPLACE, "backing stor=
e"),
> +	{ .name =3D NULL, },
> +};
> +
> +static PyObject *pyrf_mmap2_event__repr(const struct pyrf_event *pevent)
> +{
> +	PyObject *ret;
> +	char *s;
> +
> +	if (asprintf(&s, "{ type: mmap2, pid: %u, tid: %u, start: %#" PRI_lx64 =
", "
> +			 "length: %#" PRI_lx64 ", offset: %#" PRI_lx64 ", "
> +			 "flags: %#x, prot: %#x, filename: %s }",
> +		     pevent->event.mmap2.pid, pevent->event.mmap2.tid,
> +		     pevent->event.mmap2.start, pevent->event.mmap2.len,
> +		     pevent->event.mmap2.pgoff, pevent->event.mmap2.flags,
> +		     pevent->event.mmap2.prot, pevent->event.mmap2.filename) < 0)

[Severity: High]
Can this result in a heap out-of-bounds read if the filename lacks a NUL
terminator?

Because struct perf_record_mmap2 effectively defines the maximum size of
union perf_event, a crafted mmap2 event can completely fill the union with
non-NUL characters.

If the input event size equals or exceeds sizeof(union perf_event), the
memset() zero-padding logic in pyrf_event__new() is bypassed.

Exposing the potentially non-NUL-terminated filename to Python user space
via T_STRING_INPLACE in pyrf_mmap2_event__members (which internally uses
strlen()), or formatting it with %s in asprintf() here, could read past the
end of the struct pyrf_event heap allocation.

Should there be explicit bounds checking or guaranteed NUL-termination for
filename before it is formatted or accessed by Python?

> +		return PyErr_NoMemory();
> +
> +	ret =3D PyUnicode_FromString(s);
> +	free(s);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612221211.1221=
305-1-irogers@google.com?part=3D12
