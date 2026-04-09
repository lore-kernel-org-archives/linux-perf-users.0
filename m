Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3090237472D
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756255; cv=none; b=dv7/pzKZQJZZNmUH0lIYkcCDyMQ4wfRgnhzvsMGoF/FsUIY3RUVD+bxsL2d/uXqvYSQcwYIO6TyIUMqMuLMCHSRUryscKNAfvxDSxDNjE3FDnP3uSUFOIscZxdicXQ4Da14ULpn/7JWUcgKy0n0EHUtMb9EV/VS2FxwGmQI588U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756255; c=relaxed/simple;
	bh=fjGSQuZlCZGB6mrZvw5UmBHFsOYwj2K7j7QQnGuwhA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uapKxUGyvgofxpTYK5PKCkQquTD8atmuFhhG99sTx51C7Gj1gMTjpfsnyJqzTykLe6FtijoweAJCVGBWYgU8RHtNav+EcS3RoCuLto3ETRwf7PDqElt1+aDSDjpjZgC0ZglpJqEn0lJpKAxqylabyN11zb7hDc/a9R3Tva2CqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t++V5A6c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t++V5A6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1E5C4CEF7;
	Thu,  9 Apr 2026 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775756254;
	bh=fjGSQuZlCZGB6mrZvw5UmBHFsOYwj2K7j7QQnGuwhA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=t++V5A6cUgoJtrXyOEEzvwnxonEQ1nPC9qTlsDnPWsBtebZ/RjUWeDU0V9czzYOQn
	 YstM5JLBBJeCwJQhKiz5xvraBFLbJtmiISg7Rf3xV9sSAgcNPJDqlWpWABszAz3WAe
	 mimB1fhprcoAmJEOSey7etMPVu0ApYxfsmxjxJ/RMef5RnAyNczQIyiUBZl+L9syKK
	 XfkNnovsIg+snrwRRnrC5beQWRc5puuEDoc/MT79b6gAvsDIN7WqtowybY9ZS8czzW
	 5PmZjuAGpCAdpw/hLJKN+JmSKJDgQboo3iOd2dTFSflj75Fr5CCIYefDDjQNtZrkAD
	 uWvaWlqwmW07A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf lock contention: Fix SIGCHLD race in
 __cmd_contention()
Reply-To: sashiko@lists.linux.dev
To: "Swapnil Sapkal" <swapnil.sapkal@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260409162249.25581-4-swapnil.sapkal@amd.com>
References: <20260409162249.25581-4-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Apr 2026 17:37:33 +0000
Message-Id: <20260409173734.BC1E5C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Unconditional use of `sigsuspend()` without a state flag fails to =
fix the race condition and causes indefinite hangs.
--

commit bbcae9323bad3368550c5fd9165d487b92cd3bbd
Author: Swapnil Sapkal <swapnil.sapkal@amd.com>

perf lock contention: Fix SIGCHLD race in __cmd_contention()

This commit replaces pause() with sigsuspend() to prevent a race condition
where a short-lived workload exits and delivers SIGCHLD before the wait
begins.

> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index e8962c985d34a..2da689de134a4 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c

[ ... ]

> @@ -2123,12 +2124,25 @@ static int __cmd_contention(int argc, const char =
**argv)
>  	}
> =20
>  	if (use_bpf) {
> +		/*
> +		 * Block all handled signals after evlist__prepare_workload()
> +		 * so the forked child does not inherit a modified signal
> +		 * mask, then use sigsuspend() to atomically unblock and
> +		 * wait. This prevents a race where a short-lived workload
> +		 * exits and delivers SIGCHLD before we are ready to wait.
> +		 */
> +		sigemptyset(&sig_mask);
> +		sigaddset(&sig_mask, SIGCHLD);
> +		sigaddset(&sig_mask, SIGINT);
> +		sigaddset(&sig_mask, SIGTERM);
> +		sigprocmask(SIG_BLOCK, &sig_mask, &oldmask);
> +
>  		lock_contention_start();
>  		if (argc)
>  			evlist__start_workload(con.evlist);
> =20
> -		/* wait for signal */
> -		pause();
> +		sigsuspend(&oldmask);

If SIGINT or SIGCHLD is delivered before sigprocmask() blocks them, won't it
be consumed by sighandler without setting any checked state, causing
sigsuspend() to hang indefinitely?

The signals are registered earlier in the function, leaving a window during
evlist__prepare_workload() and lock_contention_prepare() where they are
unblocked.

Should there be a volatile sig_atomic_t flag set by sighandler that is
checked in a loop, for example:

while (!done)
        sigsuspend(&oldmask);

This would avoid missing signals that arrive before the block and ensure
sigsuspend() doesn't hang.

> +		sigprocmask(SIG_SETMASK, &oldmask, NULL);
> =20
>  		lock_contention_stop();
>  		lock_contention_read(&con);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260409162249.2558=
1-1-swapnil.sapkal@amd.com?part=3D3
