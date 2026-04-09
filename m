Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6E3B637C
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753463; cv=none; b=Dm2L/Jgv2I9SZcwO2qu3DulW1uXrSGf0deK+tSrBjP3dp+9476r2qIpcxw95KEa+t9Ed+HhW+ZwYJEWLj5GdTnaFuGu7zt9Q68XvtvVgDSo+3cT3Zvwgs584WbkVMmlLcemdGYwoJtgN2bkhOozf/WsS3pRvikPCJXZvkdvXHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753463; c=relaxed/simple;
	bh=uh6rWoTlG6mh2F31IUi5DWr8BohnIv1XNp8/h9oP3gs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DXKaeVf9Lqx2sDKGX0wP7eNDRvu6zh6loiDCkeCZ3jHvt422y+dyw2o3YA5hG75AxTagYOrCRIlnZdDOeRlUrim7VCtI/HkDhWwwCtETCBWVGQQHASjoUx99Xo8sVhK14dtiNH0I6qMTyIiK0Z/bthXkoHg/U5XNTIKiRrXFtDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOZ14YNS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOZ14YNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A44C4CEF7;
	Thu,  9 Apr 2026 16:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775753463;
	bh=uh6rWoTlG6mh2F31IUi5DWr8BohnIv1XNp8/h9oP3gs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tOZ14YNSZBppJQfu8XCtebxbAsSacj0xfOSz+Ks3tFY1fPsubDK/NXlHh8vfKT5kl
	 2jjmdU7clKyhbXn7DDDTyw/HFanTtudFJWjPpuS7Ru+rldEbhodslos/L505YQCeyK
	 w3JygPim29N3hHbOsPcup274qwf0Kz+avtcjW513e48+zHP4g/oc6z80EEjAwl0fkO
	 Z3FsREpfFnqoZ/7iS8qgOnIFPwocSAgr0MAFtBq85NBHVQW7oWr4DLXDM8LgQIOPpZ
	 wTRLXWNh50eHN9LfhaCc2rp3V3EspfTsjm7gTQ0OvBiAazzBrb4jIemqgp15oHoiGV
	 96e9bh7X7VYCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf sched stats: Fix SIGCHLD race in
 schedstat_record()
Reply-To: sashiko@lists.linux.dev
To: "Swapnil Sapkal" <swapnil.sapkal@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260409162249.25581-2-swapnil.sapkal@amd.com>
References: <20260409162249.25581-2-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Apr 2026 16:51:02 +0000
Message-Id: <20260409165102.E8A44C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The patch leaves a race window where early signals (like SIGINT)=
 are lost, causing sigsuspend() to hang indefinitely.
--

commit 82e42f3b8c8062e3b83019c07f66b6e7199c4104
Author: Swapnil Sapkal <swapnil.sapkal@amd.com>

perf sched stats: Fix SIGCHLD race in schedstat_record()

This commit attempts to fix a SIGCHLD race in perf sched stats record by
replacing pause() with sigsuspend(). It blocks SIGCHLD, SIGINT, and SIGTERM
before starting the workload to ensure no signal is lost if the child exits
quickly.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

[ ... ]

> @@ -3899,11 +3900,25 @@ static int perf_sched__schedstat_record(struct pe=
rf_sched *sched,
>  	if (err < 0)
>  		goto out;
> =20
> +	/*
> +	 * Block all handled signals so that a short-lived workload exiting
> +	 * (SIGCHLD) or an early Ctrl+C (SIGINT/SIGTERM) during the remaining
> +	 * setup cannot be delivered before we are ready to wait. sigsuspend()
> +	 * below will atomically unblock them. This is done after
> +	 * evlist__prepare_workload() so the forked child does not inherit a
> +	 * modified signal mask.
> +	 */
> +	sigemptyset(&sig_mask);
> +	sigaddset(&sig_mask, SIGCHLD);
> +	sigaddset(&sig_mask, SIGINT);
> +	sigaddset(&sig_mask, SIGTERM);
> +	sigprocmask(SIG_BLOCK, &sig_mask, &oldmask);

Does this leave a race window where early signals like SIGINT can be lost,
causing sigsuspend() to hang indefinitely?

If a signal like SIGINT or SIGTERM is delivered before this sigprocmask()
call, the existing sighandler will consume it without setting any state flag
that gets checked here.

>  	if (argc)
>  		evlist__start_workload(evlist);
> =20
> -	/* wait for signal */
> -	pause();
> +	sigsuspend(&oldmask);

When execution subsequently reaches sigsuspend(), wouldn't it block
indefinitely waiting for an event that was already processed?

To robustly resolve the TOCTOU race without leaking a modified signal mask
to the child, should the signal handler set a volatile sig_atomic_t flag,
and sigsuspend() be called conditionally based on that flag?

> +	sigprocmask(SIG_SETMASK, &oldmask, NULL);
> =20
>  	if (reset) {
>  		err =3D disable_sched_schedstat();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260409162249.2558=
1-1-swapnil.sapkal@amd.com?part=3D1
