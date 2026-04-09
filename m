Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAF3D3490
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755107; cv=none; b=j1B4d9Gj+vp7bSciHEORZLUA1OK4xcQpX/hAZ/pbcnQbfAGx/yLWVL4Xmuqh5sDPCoHEjYvuhyyXplTCNsgauLxZ0/tOnNW0aL+sX00swyPuv/7qVDG13vSfHz2VOadPuml17IlYkmJGuTeFbkDXUb/4s/7C83C6xkSCUos3wzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755107; c=relaxed/simple;
	bh=dEymuIC0J8TpxW/exhDoUQCr50KUY1LTqOdaNNtI7VY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t5gqq+oWdh9ChSEuvzz/E13yE6Wr0hJN77T4Qo6oFwDM/qk4aPQiMefUAbqbLUQ0e/AizVwYLcEaLQropCvhLEq4cuTkLSdZo2IuERiV2nqLeB8DuR6IM8Hmir4zxRDGPAYg5mHkQbykkM5luOeM+wHd3m+N9RLwOs0GOHgHgz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=es2gupO/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="es2gupO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85494C4CEF7;
	Thu,  9 Apr 2026 17:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775755106;
	bh=dEymuIC0J8TpxW/exhDoUQCr50KUY1LTqOdaNNtI7VY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=es2gupO/dQXH2J30jKnP3BYGEkuSAMVTY2RugsIAAswLavrxC5k3j7CfMCPRn4oHn
	 VD7rnMCwoafLtYKzlMv5VG3HuuuwFLIF/gGciqp6+Mq+M0rZt8pHtUiZbi4kcBxf5p
	 jlZRevLIwEBafIP9dKe5+TZSl20IW/84/L5doBKxzbDGqr5oygDbO+vl9IFmS2fCk8
	 t0CDAt70o3TZ8u/+8BhD7RLiGEP1b1kLHDp6WaFLYHqZaeh3I2DNCnzBNWPmMfBlzY
	 P18KStb32MCsndxaWi0stVquX7BlGwfLaGA7oWhqJY4cB/h93qrgZtBFi30SVwiFsd
	 Sq1T9dNtXIzhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf sched stats: Fix SIGCHLD race in
 schedstat_live()
Reply-To: sashiko@lists.linux.dev
To: "Swapnil Sapkal" <swapnil.sapkal@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260409162249.25581-3-swapnil.sapkal@amd.com>
References: <20260409162249.25581-3-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Apr 2026 17:18:25 +0000
Message-Id: <20260409171826.85494C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Unconditional use of sigsuspend() without a state flag creates a w=
indow where early signals are lost, leading to an indefinite hang.
- [High] Workload child process is orphaned if the tool is interrupted via =
SIGINT/SIGTERM.
--

commit f1c0b504081c33314d50fb6bf644c4e537e47385
Author: Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: perf sched stats: Fix SIGCHLD race in schedstat_live()

This commit attempts to fix a lost-wakeup race by blocking SIGCHLD, SIGINT,
and SIGTERM before starting the workload, and then using sigsuspend()
instead of pause() to wait for the workload to finish.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 3f448acd5046f..c716dd33a9c93 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4702,11 +4703,17 @@ static int perf_sched__schedstat_live(struct perf=
_sched *sched,
>  	if (err < 0)
>  		goto out;
> =20
> +	sigemptyset(&sig_mask);
> +	sigaddset(&sig_mask, SIGCHLD);
> +	sigaddset(&sig_mask, SIGINT);
> +	sigaddset(&sig_mask, SIGTERM);
> +	sigprocmask(SIG_BLOCK, &sig_mask, &oldmask);

Will this still hang if a signal arrives before sigprocmask() is called?

Because the registered signal handler is an empty dummy function without
a state flag, any signal arriving before sigprocmask() will be consumed
by the handler.

If a signal such as SIGINT or a premature SIGCHLD arrives during the earlier
setup phases (e.g., during /proc/schedstat parsing), the signal is
discarded and sigsuspend() will block indefinitely waiting for a signal
that has already arrived.

Should this handler set a flag (like a volatile sig_atomic_t) that is
checked after the sigprocmask(SIG_BLOCK) call but before sigsuspend()?

> +
>  	if (argc)
>  		evlist__start_workload(evlist);
> =20
> -	/* wait for signal */
> -	pause();
> +	sigsuspend(&oldmask);
> +	sigprocmask(SIG_SETMASK, &oldmask, NULL);

Does the exit path leave the child workload running if interrupted?

While not introduced by this patch, if sigsuspend() returns due to an
interruption like SIGINT, the code proceeds to the cleanup path.

This path calls evlist__delete() but does not appear to send SIGTERM or
SIGKILL to the workload child process (evlist->workload.pid), nor does it
waitpid() for the child to terminate.

Could this leave the workload executing as an orphaned process in the
background, leaking resources?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260409162249.2558=
1-1-swapnil.sapkal@amd.com?part=3D2
