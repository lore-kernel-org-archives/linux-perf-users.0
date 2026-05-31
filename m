Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44582DB785
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216397; cv=none; b=VDpjz4U+op73JWzw1I+ooT7FrgAiZgZ8sSu5nCvGn1LUZ0AQSTmACUmIX99yimif5ERvbc1rNmfgEpJchW5gPoZgBQHt0tq/xTq/4Mfwk4eGylFguzcfDTLN+I+fm+O6w5aKN4KKW61Vn+9vW7QODKanItIsKpZCEBD+jNfTMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216397; c=relaxed/simple;
	bh=rn23LUDsL6q/ikUJFPtl1ThBuP/DgfkFQMLT1ra/Mh0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MUCx/JP4m4uHs1WiVy2/d46zvrVCXyw8tUSv2ZkQMG3Of9XuPq3fcb8VWA6De3ROsuJ89cK0uzalkNOt9VX4JZP3gOsJyHfaWwZzHQE6h2Bh8KYC5o8lhoAZRsirlunLgWBS/+pIdy7Mo5+m3/t5nzv6MLs+Tt+4CNu6tNDN4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IahsBVxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IahsBVxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421541F00893;
	Sun, 31 May 2026 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780216396;
	bh=KuUhKBsYzodzdgRZEiWLRnmVNrtJMSpWj1MfqjM0r/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IahsBVxmXAAao1uI33kaCPMEOYsClqyl6f46wF+JB/yHCFmg1p8a5Sz20e0SG8pL6
	 HNj8wQph9YYTWkmZho1YTDZUVrRpSO0TKCraiayDJcOhL230ZEcaUS+c5VK4eoHWVE
	 zg7ajmtVRat+WQFtGhWrB24jimuOy1JACb6MzYYCj1EHPCUvD0Yk6oA5AQc0zTihJD
	 z+ZFnOsobyIlTUBELGtkCkoZa7A+zAAZR9VCBy8z6aQMLqrASlk0/OxDdIibs1VGEk
	 bkuA0aLfVGgASkCTqTXumqNcEb8JtN6F0DFvb6qhCtg/SGlD2rJar6hB9UWbGSvAJp
	 wNG8fbigBY/7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/15] tools subcmd: Robust fallback and existence
 checks for process reaping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531082235.940833-7-irogers@google.com>
References: <20260531082235.940833-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 08:33:15 +0000
Message-Id: <20260531083316.421541F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The `kill(pid, 0)` fallback causes infinite loops with zombies a=
nd contains mathematically dead code.
- [Medium] TOCTOU race condition in `kill(pid, 0)` fallback enabling PID re=
use bugs.
- [Low] Undeclared variables `waiting` and `status` cause a build failure.
- [Low] Unused variables and unconditional `sprintf()` on non-Linux platfor=
ms.
--

commit eb3a93e2d845551ba621cb38b0af3a1f2bb00750
Author: Ian Rogers <irogers@google.com>

tools subcmd: Robust fallback and existence checks for process reaping

This commit updates process checking to handle negative PIDs and transitions
the procfs status fallback logic. It replaces active waitpid() calls with a
kill(pid, 0) check to detect if a process is still running or has exited.

> diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-comman=
d.c
> --- a/tools/lib/subcmd/run-command.c
> +++ b/tools/lib/subcmd/run-command.c
> @@ -229,20 +229,64 @@ static int wait_or_whine(struct child_process *cmd,=
 bool block)
> =20
>  int check_if_command_finished(struct child_process *cmd)
>  {
> -#ifdef __linux__
>  	char filename[6 + MAX_STRLEN_TYPE(typeof(cmd->pid)) + 7 + 1];
>  	char status_line[256];
>  	FILE *status_file;
> =20
> +	if (cmd->finished)
> +		return 1;
> +	if (cmd->pid <=3D 0)
> +		return 1;
> +
>  	/*
>  	 * Check by reading /proc/<pid>/status as calling waitpid causes
>  	 * stdout/stderr to be closed and data lost.
>  	 */
>  	sprintf(filename, "/proc/%u/status", cmd->pid);
> +#ifdef __linux__

[Severity: Low]
Does this cause unused variable warnings and execute unnecessary formatting=
 on
non-Linux platforms? By moving the #ifdef __linux__ guard below the variable
declarations and the sprintf() call, it looks like status_line, status_file,
and filename will trigger warnings and execute useless code on non-Linux
builds.

>  	status_file =3D fopen(filename, "r");
>  	if (status_file =3D=3D NULL) {
> -		/* Open failed assume finish_command was called. */
> -		return true;
> +		/*
> +		 * fopen() can fail with ENOENT if the process has been reaped.
> +		 * It can also fail with EMFILE/ENFILE if RLIMIT_NOFILE is reached,
> +		 * or with EINTR/ENOMEM. Use kill(pid, 0) as a robust fallback
> +		 * to distinguish between active processes and dead ones without
> +		 * consuming file descriptors.
> +		 */
> +		if (errno =3D=3D ENOENT)
> +			return 1;
> +		if (kill(cmd->pid, 0) < 0 && errno =3D=3D ESRCH) {

[Severity: Medium]
Will this loop infinitely if the process is a zombie? The kill() call
returns 0 for zombie processes, which would bypass this ESRCH check and ret=
urn
0 at the bottom of the block, potentially tricking callers into polling
forever.

Additionally, if errno =3D=3D ESRCH is true, doesn't that mean the original
process is already fully reaped? If so, the waitpid() call in the block bel=
ow
seems like dead code that will only ever fail with ECHILD.

[Severity: Medium]
Could this sequence also introduce a time-of-check to time-of-use race?
If kill() returns ESRCH, the PID is free. If another concurrent thread forks
a new child and reuses this PID right before the waitpid() call, could we
accidentally reap the unrelated child process?

> +			waiting =3D waitpid(cmd->pid, &status, WNOHANG);

[Severity: Low]
Are the waiting and status variables declared anywhere in this function?
It looks like this might cause a compilation failure due to undeclared
identifiers.

> +			if (waiting =3D=3D cmd->pid) {
> +				int result;
> +				int code;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531082235.9408=
33-1-irogers@google.com?part=3D6
