Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5743ADBA2
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741712; cv=none; b=PteIeikzvrWxY+HE6/PwEZ9rkH6qvlwjJS490FiRIGyTW61+uWJaavgN/45EvmdkeSH/enT4hFm6moFZCi9iMbxFf+sPzif5jfPCG1r+6Q0io2yWYqJM6GOV40rI/C4GqleCUZGbHAYOQcZnPSpiAlQNSgFi7mYklk79RGaJpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741712; c=relaxed/simple;
	bh=sOMnI7A2P/kb3T4bxMUXOBvYeW2Wt/cgjqux2UGE5BA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZzWpPExhpmMROlRy5sHfp+ShAC4Wi1CPF2Gw53z9uKmgxVJsZaoDCCbSJyR6S1MqyZwHUPAHxT/xDcZwHIqKT1SXYd9POAgcE/g60EeF9irLyqGNfqoz8RAm4gT8+pbJp5sJt+Nl0yIKXe5nHI3CSkGdgzjdopnGAMorGEjOnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWTv8M7L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWTv8M7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C301F000FF;
	Fri, 18 Sep 2026 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741711;
	bh=oNzcMsg+PtiK522k91DoItWp4FtD/bR+5tqvaNQXi3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oWTv8M7L/fU/6AvZa2S1BQU2O+yNIyHFAJk/ZZ/hDG7LLjy8q+thCVKWNmEjRXcbB
	 ssXbpzE6l4NfsqBDjiXwjSZPsaPZs5g3JC3jg7BK+ZJuD5JFhQJlL+ZpkFSh4wcwrv
	 sn+yfEoMyy3oa1AiWJYsBLjghlpYgqPMTyT0DFXNnHlT0ZzHhujIjc7L+aKWQV1QZr
	 I66GJaI7FIf5BN6MgvlgrutK75rjAdMxGi6VgMWm/96ELvB6NVUDjoDV422JEfneWM
	 fb/Gg4LgBdUmDdwLA1OWFmOdMAyWrmCLAL69I6L5rZ+PnxRnGvZy1cAAmziqd8g2ea
	 beYMtEjkQXbhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/16] perf trace: Skip internal tracepoint fields in
 formatting and beauty map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-5-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:28:30 +0000
Message-Id: <20260918142831.43C301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: segfault in perf trace on OOM due to partial syscall init
--

commit 48dd6af64889b782b28660fe526345b7e8dc75bc
Author: Ian Rogers <irogers@google.com>

    perf trace: Skip internal tracepoint fields in formatting and beauty map

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f90c6bb4d8b41..2fbe1bca511cd 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
[ ... ]
> @@ -2407,24 +2414,25 @@ static int syscall__read_info(struct syscall *sc,=
 struct trace *trace)
>  		return err;
>  	}
> =20
> -	/*
> -	 * The tracepoint format contains __syscall_nr field, so it's one more
> -	 * than the actual number of syscall arguments.
> -	 */
> -	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
> -		return -ENOMEM;
> -
>  	sc->args =3D sc->tp_format->format.fields;
> +	nr_args =3D sc->tp_format->format.nr_fields;
>  	/*
>  	 * We need to check and discard the first variable '__syscall_nr'
>  	 * or 'nr' that mean the syscall number. It is needless here.
>  	 * So drop '__syscall_nr' or 'nr' field but does not exist on older ker=
nels.
> +	 *
> +	 * Do this before allocating, and size the array from what is left, so
> +	 * that a format without the field does not leave
> +	 * syscall_arg_fmt__init_array() walking one entry past the end.
>  	 */
>  	if (sc->args && (!strcmp(sc->args->name, "__syscall_nr") || !strcmp(sc-=
>args->name, "nr"))) {
>  		sc->args =3D sc->args->next;
> -		--sc->nr_args;
> +		--nr_args;
>  	}
> =20
> +	if (syscall__alloc_arg_fmts(sc, nr_args))
> +		return -ENOMEM;
> +

[Severity: Medium]
When syscall__alloc_arg_fmts() fails here (e.g. on OOM), syscall__read_info=
() returns
-ENOMEM but leaves sc->args populated. Is this partial initialization safe?

On the next occurrence of the same syscall, trace__syscall_info() sees sc->=
name is
already set (it was initialized earlier in syscall__read_info()) and succes=
sfully
returns the partially initialized struct without retrying initialization.

This struct is then passed to syscall__scnprintf_args().

[ ... ]
> @@ -2642,11 +2650,17 @@ static size_t syscall__scnprintf_args(struct sysc=
all *sc, char *bf, size_t size,
>  	if (sc->args !=3D NULL) {
>  		struct tep_format_field *field;
> =20
> -		for (field =3D sc->args; field;
> -		     field =3D field->next, ++arg.idx, bit <<=3D 1) {
> -			if (arg.mask & bit)
> +		for (field =3D sc->args; field; field =3D field->next) {
[ ... ]
>  			arg.fmt =3D &sc->arg_fmt[arg.idx];
>  			val =3D syscall_arg__val(&arg, arg.idx);
>  			/*
>  			 * Some syscall args need some mask, most don't and
>  			 * return val untouched.
>  			 */
>  			val =3D syscall_arg_fmt__mask_val(&sc->arg_fmt[arg.idx], &arg, val);

[Severity: Medium]
Because sc->args is not NULL, does this code enter the loop and dereference=
 the
unallocated sc->arg_fmt array, causing a segmentation fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D4
