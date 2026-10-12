Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5823C51D
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765562; cv=none; b=lOKkHtUhNW+p8qHaHLgOVwFrKffSA4TOvKiijlGBtxRhm+mkPyUKVWfo8HyY1J2HEdXFyi+vHaghaPHWCJk7y7Z86hP97yQh4+g+b+chhyyztKY61vbNVCEE5BWGugPLkRauiIns9rLl4YRIjkDi5f2kDiIK7ntTOGrhfXqz/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765562; c=relaxed/simple;
	bh=9Y23mIU5qvyJKO8zKInGpwOKw71ImmGBfegLaINW+QM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tBkBTc5Hy4p+f4yWpsryyZLXZ7WnPwD3eBSHQdvQn/GtA3pXap7oiyW5e8ejJsPUoZWzzRacfnIpHqkmnRDU5Geg0MpMRXHx72nJD42+Qh+h4TJBIjZ2beT1dKOeBJ2F4KBemi9z5vB29TvWVh/QgeBkOpcwpLgtNFG6OiFO+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+T28zle; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+T28zle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E05F1F0089B;
	Mon, 12 Oct 2026 00:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791765561;
	bh=wwMQwT9k0f6L77MlUasiaXnhJUVetNOzLo41fKUhAw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F+T28zleJRx5WQ5+/F0P8wBpy3a8l1Sp0d4Lc9qXOMK/n9Zi+CnNh7k6bcLGGINuy
	 FWRbsZVaqiTuk+ZaIYGTyBCUlj6RvtkdEhgosCiZ409eewWdrZbwtaQdwCDeHY0iyP
	 qsg0zUa9xxPCqnVuGrMN6z/z6g5ridQfh2OHaP7nZiZzoPw4zJRekEK7aWN92Ozek7
	 K2muFHLNKMl4e/IBlcgSnoEwn1fvs2KyOcOyL7v5b7SUDFXeBMYBw2JZ3yevM08g97
	 rCBK+9gpicTgFUUQgigeCOnK8z6OPWVpiSovs9ZsNYbp8JCVPtxFywkPjrw4GS7tU5
	 4w5j/i54Ywzjw==
Message-ID: <sashiko-outbox-167528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v3 4/5] perf ftrace: Support omitting
 execution duration in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012003016.263063-5-atomlin@atomlin.com>
References: <20261012003016.263063-1-atomlin@atomlin.com>
 <20261012003016.263063-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 00:39:20 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] perf: formatting corruption in make_blank_prefix() with verbose ena=
bled
- [Low] perf: profile subcommand silently drops records with noduration
--

commit d0f3a0ada6164d2372b897fe5b75d0f425aca5e4
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support omitting execution duration in function graph tracer

The Linux kernel's function graph tracer displays the execution duration
of completed functions by default via the funcgraph-duration trace
option. Whilst informative, in scenarios where the user is solely
interested in the call graph topology, call flow sequence, or inlined
hierarchy, the duration column can add visual clutter and widen each
trace line.

[ ... ]

> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 504007064e240..926726c5d9a88 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c

[ ... ]

> @@ -1754,6 +1780,7 @@ static int parse_graph_tracer_opts(const struct opt=
ion *opt,
>  		{ .name =3D "retaddr",		.value_ptr =3D &ftrace->graph_retaddr },
>  		{ .name =3D "nosleep-time",	.value_ptr =3D &ftrace->graph_nosleep_time=
 },
>  		{ .name =3D "noirqs",		.value_ptr =3D &ftrace->graph_noirqs },
> +		{ .name =3D "noduration",		.value_ptr =3D &ftrace->graph_noduration },

[Severity: Low]
Does adding noduration here allow it to be used with the profile subcommand?

The profile subcommand inherently requires function duration to compute
statistics. When the duration column is omitted, parse_func_duration()
sees no " us" suffix and silently drops the record:

tools/perf/builtin-ftrace.c:parse_func_duration() {
    ...
	if (strncmp(p, " us", 3)) {
		pr_debug("non-usec time found.. ignoring\n");
		return 0;
	}
    ...
}

This results in an empty output instead of rejecting the invalid option
combination. Should the option be rejected when used with profile?

>  		{ .name =3D "verbose",		.value_ptr =3D &ftrace->graph_verbose },
>  		{ .name =3D "thresh",		.value_ptr =3D &ftrace->graph_thresh },
>  		{ .name =3D "depth",		.value_ptr =3D &ftrace->graph_depth },

[ ... ]

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 8737bb52921e1..5cae01a28529f 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c

[ ... ]

> @@ -346,9 +348,14 @@ static const char *find_func_column(const struct per=
f_ftrace *ftrace,
>  			return NULL;
>  	}
> =20
> -	p =3D strchr(p + 1, '|');
> -	if (!p)
> +	if (!ftrace->graph_noduration) {
> +		p =3D strchr(p + 1, '|');
> +		if (!p)
> +			return NULL;
> +	} else if (strstr(p, " =3D> ")) {
> +		/* Context switch marker: " CPU) comm-pid =3D> comm-pid" */
>  		return NULL;
> +	}

[Severity: Low]
Will this corrupt the comm-pid column when verbose is enabled alongside
noduration?

When both verbose and noduration are enabled, find_func_column() returns
the CPU ')' or the separator after it. make_blank_prefix() uses the final
pipe_char and overwrites everything after the ')' with spaces:

tools/perf/util/ftrace.c:make_blank_prefix() {
    ...
	/* Replace duration between ')' and '|' with spaces */
	if (paren && paren < line + len) {
		char *end =3D buf + (pipe_char - line);
    ...
		for (c =3D buf + (paren - line) + 1; c < end; c++)
			*c =3D ' ';
	}
    ...
}

Since there is no duration field, does this blindly overwrite the comm-pid
column and its trailing separator?

> =20
>  	*cpu =3D (int)val;
>  	return p;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012003016.2630=
63-1-atomlin@atomlin.com?part=3D4
