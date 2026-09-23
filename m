Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3540DB4C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189389; cv=none; b=FwyVJEw+rIqCaLNGapaYAGvcq1YkA1wmJ25tE3H2aX8GbIfKL3Yq6i/s5X5ANn0CeZFoc/XygcupfZtXo0zYvTKw2NpHQ5nIcRvJ6OuwK96odxin811HWVLBvFuhSqYW/Cwew1lPnroQAD4FbY2N5fbsh/2mycwddwPPvwC0c/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189389; c=relaxed/simple;
	bh=7WZJhBrjZbvd9LmoVpzFu7oW3dNAAmx8RxcX7j+hWvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FryGFHOH8WUDKz1fTTc+Z3IkAu+wBbrKhSG9yY9NAaq2QrVGcK3S9bhcl/bI9BeXMNpuBG0T5enPSTc/F0SeJ4XIbldngca8n2WLizbI0tqYhJUTiEZbUzIS0E/B3KYEp8MuQpdJcsmQiHMXHehEIH5Zk8c0Menp+HggdPqZIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBNVgL9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBNVgL9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B756E1F000FF;
	Wed, 23 Sep 2026 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790189382;
	bh=FCg+Sg8Qe2pKzja8lCm0+MqnjItxVXpCikzm/S0wRn8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BBNVgL9/M0gawppuG6Ait2/ygNct7X/7ZiLt2UBaEyOLsgLUjGQiHiiUimXXo1raF
	 uhEB/Ioi4M1uQYzO+Y7WPm0UAXnwWi2mWct2Pwqpp2RKgsMdCLtTmk8c///vUedFJs
	 bvlCJPjnD28uZIxkouTT26ugYYC4zTbADAvWqXtJSTmMExHgmM9TjF6Y4AAlSVyyeL
	 j1MV/tgi7cHQQv8hLWuI2goRc+P3v8+oI73+HqNTtH9Fbh6hNHKcvtspgOpSSGHWT3
	 xEHkY9A/JxIiHhh/CCfONVmRKxznGULJ/HhIQbjH+Y8K8GPPq6RpNn1uCeyq6MeP7C
	 7HsVDTb/FBCxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 48/49] perf script: Support standalone scripts and
 remove embedded scripting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-49-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-49-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:49:42 +0000
Message-Id: <20260923184942.B756E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf script: TOCTOU race condition in signal handler allows send=
ing signals to recycled PIDs
--

commit 1ed2e4983f9ede9efdfc6d59669cdd2e466dc05b
Author: Ian Rogers <irogers@google.com>
Subject: perf script: Support standalone scripts and remove embedded script=
ing

This commit refactors perf script to launch standalone scripts directly via
fork and execvp, while removing the legacy embedded Perl and Python scripti=
ng
engines. It updates script discovery to prioritize the system python direct=
ory
and updates shell tests to use the new invocation style.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c

[ ... ]

> +static volatile sig_atomic_t script_child_pid;
> +
> +static void forward_script_sig(int sig, siginfo_t *info, void *ucontext =
__maybe_unused)
> +{
> +	/*
> +	 * Terminal-generated signals (Ctrl-C / Ctrl-\) have si_code > 0
> +	 * (SI_KERNEL) and are already delivered by the TTY driver to the
> +	 * entire foreground process group, including the child script.
> +	 * Signals sent directly to the perf process via kill(2) / sigqueue(3)
> +	 * have si_code <=3D 0 (SI_USER, SI_QUEUE, etc.) and must be forwarded
> +	 * to the child script so it can catch KeyboardInterrupt / SIGTERM
> +	 * and flush its output before exiting.
> +	 */
> +	if (script_child_pid > 0 && (sig =3D=3D SIGTERM || !info || info->si_co=
de <=3D 0))
> +		kill(script_child_pid, sig);

[Severity: Medium]
Does this signal handler risk targeting a reused PID?

The script_child_pid variable is not updated atomically with the waitpid()
call reaping the process, which creates a race window.

If the parent is preempted right after waitpid() returns but before
script_child_pid is cleared, the system could recycle the PID. This handler
might then trigger a kill() on an unrelated, newly created process.

> +}

[ ... ]

> +		} else { /* parent */
> +			int status =3D 0;
> +
> +			script_child_pid =3D pid;
> +			sigprocmask(SIG_SETMASK, &old_mask, NULL);
> +			while (waitpid(pid, &status, 0) !=3D pid) {
> +				if (errno =3D=3D EINTR)
> +					continue;
> +				pr_err("failed to wait for script '%s': %s\n",
> +				       script_name, strerror(errno));
> +				err =3D -errno;
> +				script_child_pid =3D 0;
> +				sigaction(SIGINT, &old_int, NULL);
> +				sigaction(SIGQUIT, &old_quit, NULL);
> +				sigaction(SIGTERM, &old_term, NULL);
> +				goto out;
> +			}
> +			script_child_pid =3D 0;

[Severity: Medium]
Is there a way to safely synchronize the clearing of script_child_pid with =
the
reaping of the child process?

The child process is fully reaped as soon as waitpid() successfully returns
here in cmd_script().

If the thread is suspended or preempted exactly at this point, script_child=
_pid
remains set to the old PID while the system is free to reassign that PID.

If a signal like SIGTERM arrives during this window, forward_script_sig() w=
ill
read the stale script_child_pid and send it to the new process holding that=
 PID.

> +			sigaction(SIGINT, &old_int, NULL);
> +			sigaction(SIGQUIT, &old_quit, NULL);
> +			sigaction(SIGTERM, &old_term, NULL);
> +			if (WIFEXITED(status))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D48
