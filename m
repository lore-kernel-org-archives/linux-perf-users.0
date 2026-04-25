Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE939185E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159420; cv=none; b=NglGOiAv2U1/cLh0wTMvRTIFi7cBwgoL4ld/iUazClI5wBqAbgWhq/PvkeI70v3OnOHJhLezjzRoTz+jZDf5/oNYJlUt23MstA0Qz9w7FbTRlAkTMLFaHVVRxCBS5qEt/s70Ugk/4rdyYNSGASTvsq033M5e0OmclJaf2WO4HT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159420; c=relaxed/simple;
	bh=itGtRQvymH3HBXXso02OIYpztkUukSGgoagUKzofgbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FNXVox3rw+u4bmxtN3Khu72VSkR7mjoChdIaDTrdyv67dO6eawu7pLc2KnUBPOdfwj6JykAgFiqShi6iUjiQktDuI/Se1AhRNcv6cCx6DJpymg/EGkptk6vAYlkajouDUwE9/FIeeusCgCqClKtghYYkadA8iqD+3goTEIc7HGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWgB+nHH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWgB+nHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF28C2BCB0;
	Sat, 25 Apr 2026 23:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159419;
	bh=itGtRQvymH3HBXXso02OIYpztkUukSGgoagUKzofgbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sWgB+nHHbIaKt6iQy6Lx0eyberJHG07+xtoXES1KIzxcJa4UDtgIQEimVfqbH3u4f
	 89jCTyRocLndpTUHoyHnQgvnX4UPbkp26rgxh28CebAxoHlNFFl/qk0wBbpubM4AmY
	 S/gMXyNhNxF9bITh4LFPq1DYdWXmrRkBUcLvWaaxoap7uBuU6UaLjldvSLcQoFXAi/
	 D45gYmpJtwSrRRoL+M2zC/O8AFYEtw7fH0a7zWGCrPcQUyM3Hu8MRY8QWIRHAJpRlx
	 d1Q1/YdmPD4T232DlE2wkUaR8OYJNEEy9jSzOYQj9gLu77Juo/vMbF9xEuyiGdBo+V
	 hIIGfgxTtWiGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 56/59] perf script: Refactor to support standalone
 scripts and remove legacy features
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-57-irogers@google.com>
References: <20260425224951.174663-57-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:23:39 +0000
Message-Id: <20260425232339.8CF28C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Unhandled `waitpid()` failure causes unintended execution of the n=
ative `perf script` data processing loop.
- [Low] Overwriting `desc->half_liner` without freeing the previous allocat=
ion causes a memory leak.
- [Low] The script `args` formatting is preserved in `list_available_script=
s` but the population logic is removed, leaving dead code.
--

commit 28566cda6894feea81082103f438305b884d5d12
Author: Ian Rogers <irogers@google.com>

perf script: Refactor to support standalone scripts and remove legacy featu=
res

This commit refactors perf script to support standalone Python scripts, rem=
oving
legacy scripting options. It updates script path resolution and adds the ab=
ility
to launch scripts directly via fork and execvp.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c

[ ... ]

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
>  	}

Is there a memory leak here if we find a better description later?

If desc->half_liner is assigned from the SPDX-License-Identifier line,
and the loop continues, finding the actual description: tag will overwrite
desc->half_liner with a new strdup() without freeing the initial allocation.

Also, since the args: parsing was removed here, should the corresponding
printing logic in list_available_scripts() be removed as well?

[ ... ]

> @@ -3695,26 +3789,24 @@ static int list_available_scripts(const struct op=
tion *opt __maybe_unused,
>  		exit(-1);
>  	}
> =20
[ ... ]
> -	fprintf(stdout, "List of available trace scripts:\n");
> +	fprintf(stdout, "List of available scripts:\n");
>  	list_for_each_entry(desc, &script_descs, node) {
>  		sprintf(first_half, "%s %s", desc->name,
>  			desc->args ? desc->args : "");

This isn't a bug, but this logic still checks and prints desc->args. Since
the parsing for it was removed above, desc->args will always be NULL.

[ ... ]

> @@ -4253,149 +4235,54 @@ int cmd_script(int argc, const char **argv)
>  	/* make sure PERF_EXEC_PATH is set for scripts */
>  	set_argv_exec_path(get_argv_exec_path());
> =20
[ ... ]
> +	if (script_name) {
> +		pid_t pid =3D fork();
>  		if (pid < 0) {
> -			perror("failed to fork");
> -			return -1;
> +			pr_err("failed to fork\n");
> +			return -errno;
>  		}
> -
> -		if (!pid) {
> +		if (pid =3D=3D 0) { /* child */
[ ... ]
> +			execvp(script_name, (char **)__argv);
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
> -
[ ... ]
>  	}
> =20
>  	if (dlfilter_file) {

If waitpid() is interrupted by a signal and returns -1 (with errno =3D=3D E=
INTR),
or fails for another reason, the condition waitpid(pid, &status, 0) =3D=3D =
pid
evaluates to false.

Since there is no else clause or return statement on the failure path,
execution will fall through the if (script_name) block and proceed to the r=
est
of cmd_script(). This could unintentionally initialize a perf session and d=
ump
perf.data to stdout instead of terminating.

Should waitpid() be wrapped in a retry loop for EINTR, and return an error =
if
it ultimately fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D56
