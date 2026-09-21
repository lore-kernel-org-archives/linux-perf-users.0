Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395822D8376
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970182; cv=none; b=bQpYXglAaeBVTX3nx5Gppz4QU2d175+xe88uvAChf3FDBKxXgeuBxqdSho8jzp65Qao/azD9889SmO3iiRWuHqUakIKxRGI6kNq+BKAfXj4A0rP8Bm2EebBYz9GQiFHS7DUyhP7j7YUPlE+tELaartJwgh7sDxecu3KFt3ttSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970182; c=relaxed/simple;
	bh=NVKSdCCWCYG7qlzMRJD+XCVP+J8fbOuTKsy5I+6CMdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RyELxDv5acDf+WnTPd+Bv5KyscBAMxBLeXzau/+emoNzaHsZ6CyqDsAtfz077qNugG0kxMcMhEoX5WtnCsdIuf3CabkcCQlIHn303vBVS0HKE8axolvpue400N2jQPBe5Qh7TwVCV8r3JCoK/6/CW0uPrZFDXZxCGKGYI6pf2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgWHxHY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgWHxHY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9357C1F000FF;
	Mon, 21 Sep 2026 05:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789970180;
	bh=S77Op4kdl0s8Tojh7WiuZiVy2lPZHJeQW85smWik1Es=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OgWHxHY79trZWKYIgm0EAsq03QvGHl4ZlHOya2sIhR+M0v0oUPtl7NSOO9YkHMzsd
	 nO/W2YDUlaVRsjgp87Fg3LFoyKKaEMucqIH1bm0TeRKFa/LBe4oudu05kjjQlJ1bm8
	 nzPrVfuX6l4saM1csYs1xn1rFZ7xbrKLb3gnxljt5edfNfvwHn6lDi5Pxti4tydKoa
	 WSPVMbhCY6plSSR/RHVvfvw2JxYC5Yrq5lYowI2PQHLc7eb937kWZ/H/qh+s98tNwT
	 wn8orcxSxCd9xlbWQYTSPW1ztn74CJSUG5YdbvNc4rm2TCIsWdNywI7UuZ2rUw08/I
	 ITVVTy3LVDxpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 48/49] perf script: Support standalone scripts and
 remove embedded scripting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <040f6a4baad961b0733b62fcbbc69fed1a081667.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <040f6a4baad961b0733b62fcbbc69fed1a081667.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:56:20 +0000
Message-Id: <20260921055620.9357C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf script: parent process fails to ignore SIGINT during cmd_sc=
ript() waitpid
- [Low] perf script: legacy out-of-tree Python scripts silently exit with s=
uccess
--

commit c8ca0ff8a669e06dee2142297270bd19fbc8f680
Author: Ian Rogers <irogers@google.com>

    perf script: Support standalone scripts and remove embedded scripting
   =20
    Refactor 'perf script' to launch standalone scripts directly via fork()
    and execvp() and remove the legacy embedded Perl and Python scripting
    engines.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 0174489d1c0fd..c9e1b5ac5c8f2 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -4345,149 +4325,107 @@ int cmd_script(int argc, const char **argv)

[ ... ]

> +			if (symbol_conf.vmlinux_name)
> +				setenv("PERF_SYMBOL_VMLINUX", symbol_conf.vmlinux_name, 1);
> +			if (symbol_conf.kallsyms_name)
> +				setenv("PERF_SYMBOL_KALLSYMS", symbol_conf.kallsyms_name, 1);
> +			if (symbol_conf.symfs && symbol_conf.symfs[0])
> +				setenv("PERF_SYMBOL_SYMFS", symbol_conf.symfs, 1);
> =20
> -			execvp("/bin/sh", (char **)__argv);
> -			free(__argv);
> -			exit(-1);
> -		}
> -
> -		dup2(live_pipe[0], 0);
> -		close(live_pipe[1]);
> +			if (is_python)
> +				execvp("python3", (char **)__argv);

[Severity: Low]
Does this code silently ignore legacy out-of-tree Python scripts?

When a user executes perf script -s legacy_script.py, this directly invokes
execvp("python3", ...). Since legacy scripts often only contain callback
definitions (e.g., def process_event...) without an active execution
block, the Python interpreter will just parse them and exit successfully
with a return code of 0, doing nothing.

Will this UX regression cause confusion, making it difficult for users to
realize their scripts are no longer supported?

> +			else
> +				execvp(script_name, (char **)__argv);
> +			{
> +				int err_code =3D errno;
> =20
> -		__argv =3D calloc(argc + 4, sizeof(const char *));
> -		if (!__argv) {
> -			pr_err("malloc failed\n");
> -			err =3D -ENOMEM;
> -			goto out;
> -		}
> +				pr_err("failed to execute script '%s': %s\n",
> +				       script_name, strerror(err_code));
> +				_exit(err_code);
> +			}
> +		} else { /* parent */
> +			int status =3D 0;
> +
> +			while (waitpid(pid, &status, 0) !=3D pid) {
> +				if (errno =3D=3D EINTR)
> +					continue;
> +				pr_err("failed to wait for script '%s': %s\n",
> +				script_name, strerror(errno));

[Severity: Medium]
Can this wait loop result in interleaved terminal output and a messy state =
when
terminating a script?

If a user runs a standalone script using perf script -s script.py and then
presses Ctrl-C to interrupt it, the parent process is inside this waitpid()
loop without having configured its own signal handlers to ignore SIGINT or
SIGQUIT.

Because perf script does not use the standard POSIX system() semantics
(ignoring SIGINT/SIGQUIT in the parent while waiting), the parent process
will die immediately via SIG_DFL. It fails to wait for the child script to
finish cleaning up or printing its KeyboardInterrupt traceback, causing the
shell prompt to return immediately while the child continues writing to the
terminal.

> +				err =3D -errno;
>  				goto out;
>  			}
> -		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D48
