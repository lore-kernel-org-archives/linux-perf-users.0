Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2AE1FD4
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788657840; cv=none; b=WizMlxQhEzO4KYkInROFkciqANs1mYpheDDRes0lUXjFi2mtQ8ExjXrFuL4Qg9oID48b8B/OQFfE1tNkEqev09Ke6h/uv3Hhuv34/G+6OTcTQLLYj60VKIQH3wMfysl31+W40xtOH4jRTD7+dv9ZRV8CVxXdqlv2VjOWZWHjao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788657840; c=relaxed/simple;
	bh=F+5/9Fkop5An2jN/ng33tEjGOefeVdQ+RH5L+XlsN7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AgklEZ2nQKBI3oMZW1R3L6Ro9cwzvXW4kABmZ+n2mzuINy79AyIUUcXK4eZ9qL2X8cEtufQQif6/TpKMmBsKqYSS33/Pm11kcCccSdU5fdbwo/5Ny6sY3C/HS6YHWXutWilggLUhI1KXnnm1mIhBPSxPuWhOnXO1uo0Z6hHWa8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXeYeWQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXeYeWQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E5A1F00A3A;
	Sun,  6 Sep 2026 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788657839;
	bh=j12dRkiBu13AfofhPC252svsYmGcu8xKcMVk/c0DVRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iXeYeWQxnyTAgmiv0spoW3jj+nIJ0Lhz52VCXSCxHTug4WQPgMzy9UDCx7fsadmlW
	 xVrSN1njHuhVQTrAPseCihDsqH4YSq87njql4jaQL+/ya4Pim27N8FUS3C8cqVLvUr
	 7oovhlu6tPqUcqwqnxlwGQUheW3ZM+y2Puv1p7cpvM/C772wyvaA5N0svaB/Y8zUk4
	 lS3vWSkg+4Skb+YdVlWaK0tjWFDvvnERgFumd/gUU1WttuONM/HyvyXclN6rafs4hJ
	 G3zoy4lat4BTqZVfYNmN8F48YJtnpvXbJkec9EqPLjTLaSWv6PaMK4syJV401sLW/y
	 swi7VgpJ72GvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next] perf trace: Add upper bound checks for
 augmented BTF struct printing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260906011132.279321-1-atomlin@atomlin.com>
References: <20260906011132.279321-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 01:23:58 +0000
Message-Id: <20260906012359.19E5A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch adds bounds checking to `btf_struct_scnprintf` to preven=
t buffer over-reads and integer overflows from untrusted `perf.data` files,=
 but identical vulnerabilities remain unfixed in several other augmented ar=
gument formatters.
--

commit 292e31352e85e8bac1a8cec2bc218077f4783d42
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Add upper bound checks for augmented BTF struct printing

This commit adds bounds checking to btf_struct_scnprintf() when
pretty-printing augmented struct payloads. It prevents buffer over-reads and
integer overflow when parsing untrusted perf.data files.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index be19d70eba092..20fffc24507b5 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1133,12 +1133,13 @@ static size_t btf_struct_scnprintf(const struct b=
tf_type *type, struct btf *btf,
>  	LIBBPF_OPTS(btf_dump_opts, dump_opts);
>  	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
> =20
> -	if (arg =3D=3D NULL || arg->augmented.args =3D=3D NULL || arg->augmente=
d.size <=3D 0 ||
> +	if (arg =3D=3D NULL || arg->augmented.args =3D=3D NULL || arg->augmente=
d.size < (int)sizeof(*augmented_arg) ||
>  	    arg->fmt =3D=3D NULL || !arg->fmt->from_user)
>  		return 0;
> =20
>  	augmented_arg =3D arg->augmented.args;
> -	if (augmented_arg->size <=3D 0)
> +	if (augmented_arg->size <=3D 0 || augmented_arg->size > arg->augmented.=
size - (int)sizeof(*augmented_arg) ||
> +	    (size_t)augmented_arg->size < type->size)
>  		return 0;

[Severity: High]
This is a pre-existing issue, but while this change correctly adds bounds
checking to prevent buffer over-reads and integer overflows in
btf_struct_scnprintf(), identical vulnerabilities remain unfixed in several
other augmented argument formatters.

When a crafted perf.data file provides an artificially large
augmented_arg->size or a truncated payload buffer, could the following
formatters still be vulnerable to out-of-bounds reads or state corruption?

In tools/perf/builtin-trace.c:
syscall_arg__scnprintf_augmented_string():
    size_t printed =3D scnprintf(bf, size, "\"%.*s\"", augmented_arg->size,
                               augmented_arg->value);
    int consumed =3D sizeof(*augmented_arg) + augmented_arg->size;

This lacks validation that arg->augmented.size is >=3D sizeof(*augmented_ar=
g),
fails to bound augmented_arg->size against the remaining payload buffer, and
performs a pointer advance calculation that can overflow and corrupt parsing
state.

In tools/perf/builtin-trace.c:
syscall_arg__scnprintf_buf():
    for (int j =3D 0; j < augmented_arg->size; ++j) {

This unconditionally iterates up to augmented_arg->size without bounds
checking against the remaining payload buffer arg->augmented.size, leading =
to
buffer over-reads.

In tools/perf/trace/beauty/perf_event_open.c:
syscall_arg__scnprintf_augmented_perf_event_attr():
    struct perf_event_attr *attr =3D (void *)arg->augmented.args->value;

This fails to ensure arg->augmented.size is large enough to contain the
perf_event_attr struct before casting and reading from it.

In tools/perf/trace/beauty/sockaddr.c:
syscall_arg__scnprintf_augmented_sockaddr():
    struct sockaddr *sa =3D (struct sockaddr *)&arg->augmented.args->value;

This reads fields like sa->sa_family without any payload size validation,
leading to potential out-of-bounds reads.

In tools/perf/trace/beauty/timespec.c:
syscall_arg__scnprintf_augmented_timespec():
    struct timespec *ts =3D (struct timespec *)arg->augmented.args->value;

This dereferences struct fields without verifying that the payload contains=
 at
least sizeof(struct timespec) bytes.

Would it make sense to update these other formatters to include the same
bounds checking being added here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906011132.2793=
21-1-atomlin@atomlin.com?part=3D1
