Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E62309B2
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141480; cv=none; b=q8WC8IxE2X8ymI2LS3PmbknybTln5IIxt/1ssFzuXKN9Jd+rSX9/myL0Xo3C5PG/hXG9M7Z4saokfa+OV5Npv3o+tJeqlRG+RSjOA6Jrv5l1IFNBpMq+CXyJmq9n4hqlK+atAC24qV6fnOKMqILjWZSZfFpBmXspOJy/NJzkY/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141480; c=relaxed/simple;
	bh=L8+5DA/fxJop9D+3w5kIL0yMiYQ8ZiYaL3HlCdO+WMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iPWeDQEFViDSX54W9m8qbHfoKQYN0PNA+1ph1sGf7HXkE9T9ybzeAH0fTF+r1apnoCQ4irA4ubYMuODzt/7WTwAL84JYxLEKqOqx2AnXCc3ECcIjdfSgiMMH/eDas8YqbsLcLuAI6RN+dkzvc710eanh38ElPt+4PiZjzlwqdDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU6bVJUm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU6bVJUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFEBC2BCB0;
	Sat, 25 Apr 2026 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141480;
	bh=L8+5DA/fxJop9D+3w5kIL0yMiYQ8ZiYaL3HlCdO+WMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NU6bVJUm3gdOseV0URxCJWxznM0kaDf3zzfQ5ckWloH7pX1qTUmjwTM+F6Fj9Qtyp
	 jE6CDOfCQu53vuH+EPeDTa2jJgHOLjbmc/ob55vRVh1t3NNGrKD9c9gYZjSwDILHWc
	 Di7jWWKCsaRoLOPU3oiaLwP+EtrzyWQiLwTGKSBArwyi3SP84zpIOpaz6E4O40bPeP
	 PKURzoEOM+m65QkiCnnbG7DSWHNXw3yPmj9LfEAdBlmyzmZSLMxNXcHdiCKQyvok8l
	 9Wtd2wqa7DvjnDCGYKuZ3GG6oC1J75HOmSvsiNXnFHjaoyHhM8RVAihmdpeAzo7VMT
	 uKSBI8CkZRFAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 56/59] perf script: Refactor to support standalone
 scripts and remove legacy features
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-57-irogers@google.com>
References: <20260425174858.3922152-57-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:24:39 +0000
Message-Id: <20260425182440.3DFEBC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Unhandled waitpid() failure causes unintended fallthrough to event=
 processing loop.
- [Medium] Memory leak in read_script_info() when overwriting the fallback =
description.
- [Medium] Command-line filtering options for perf script are silently cons=
umed and ignored when running standalone scripts.
--

commit d39e4d4e1bcd11c4942f8ded6ea48c50e2812475
Author: Ian Rogers <irogers@google.com>

perf script: Refactor to support standalone scripts and remove legacy featu=
res
   =20
This commit removes the legacy -g/--gen-script option and updates the
-s/--script option to imply running standalone scripts directly. It adds
support for launching these scripts via fork and execvp while bypassing
the normal event processing loop.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3630,13 +3723,15 @@ static int read_script_info(struct script_desc *d=
esc, const char *filename)
>  		if (!strncmp(p, "description:", strlen("description:"))) {
>  			p +=3D strlen("description:");
>  			desc->half_liner =3D strdup(skip_spaces(p));
> -			continue;
> +			found_description =3D true;
> +			break;
>  		}
> =20
> -		if (!strncmp(p, "args:", strlen("args:"))) {
> -			p +=3D strlen("args:");
> -			desc->args =3D strdup(skip_spaces(p));
> -			continue;
> +		if (!found_description && strlen(p) > 0 &&
> +		    strncmp(p, "SPDX-License-Identifier", 23)) {
> +			desc->half_liner =3D strdup(p);
> +			found_description =3D true;
> +			// Don't break, maybe we find a better "description:" later!
>  		}

Does this leak the desc->half_liner string? If a script has a fallback line
that allocates memory here, and then a proper "description:" tag is found
later in the loop, it looks like desc->half_liner is overwritten without
freeing the original allocation.

[ ... ]

> @@ -4185,22 +4186,17 @@ int cmd_script(int argc, const char **argv)
>  	OPTS_EVSWITCH(&script.evswitch),
>  	OPT_END()
>  	};
[ ... ]
> -	argc =3D parse_options_subcommand(argc, argv, options, script_subcomman=
ds, script_usage,
> +	argc =3D parse_options_subcommand(argc, argv, options, NULL, script_usa=
ge,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);

[ ... ]

> @@ -4253,149 +4235,54 @@ int cmd_script(int argc, const char **argv)
[ ... ]
>  	if (script_name) {
>  		pid_t pid =3D fork();
>  		if (pid < 0) {
> -			perror("failed to fork");
> -			return -1;
> +			pr_err("failed to fork\n");
> +			return -errno;
>  		}
> -
> -		if (!pid) {
> +		if (pid =3D=3D 0) { /* child */
> +			__argv =3D calloc(argc + 4, sizeof(const char *));
>  			j =3D 0;
[ ... ]
> +			for (i =3D 0; i < argc; i++)
>  				__argv[j++] =3D argv[i];
>  			__argv[j++] =3D NULL;
> =20
> -			execvp("/bin/sh", (char **)__argv);
> +			execvp(script_name, (char **)__argv);

Since parse_options_subcommand() was already called earlier in this functio=
n,
are the parsed command-line options (like --cpu or --time) getting silently
discarded?

When running a standalone script, the parent process skips the perf_session
event processing loop where these options are normally applied. Because argc
and argv are already stripped of these options, the child script won't see
them either, which might lead to filtering options being ignored without
notifying the user.

> +			pr_err("failed to execute script '%s': %s\n", script_name, strerror(e=
rrno));
> +			exit(-errno);
> +		} else { /* parent */
> +			int status =3D 0;
> +
> +			if (waitpid(pid, &status, 0) =3D=3D pid) {
> +				if (WIFEXITED(status))
> +					return WEXITSTATUS(status);
> +				else
> +					return -1;
>  			}
>  		}

What happens if waitpid() is interrupted by a signal, like a terminal resize
causing an EINTR error?

If waitpid() returns -1, the condition evaluates to false and the function
continues execution instead of returning. This looks like it would
inadvertently fall through to initialize a perf_session and process or dump
the rest of the data file while the script is still running.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D56
