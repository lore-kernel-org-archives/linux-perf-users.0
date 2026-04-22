Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E482DC77F
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776842444; cv=none; b=S5wmwDcKIbTuoPCGWOn10fDYTfoZThj3sZw47wEtwx3GknR0NGup5Fit0ILGkcTfRAlGmhJ6YtJve6UPAT6OQeLim7b0pLNvixm8G6Ui8WvjuzxTjJSu+MPuG6DX6N1jrkkKF0FcLA5NYsK2HQNOqrjD8A9zqAOGUnykmSD3MeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776842444; c=relaxed/simple;
	bh=kfe/I9yUpqeUUSy67eR3Jkmg4Pr+y4jEBX52TCtc9aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MOTEBMnwm8fPtolPbR9sNN+Iml0slZOXA9ww4+5KThXnuVVWEa/govb7d5XxqZvgwKVdz14WtV62mZDLvyJ4iAV9CAn2izI8KDV3J4ApsIbqRZHvO6aE+r40bIuXrgcoTNB0xbhI/n6aMW2ktHgOmOIDc2lqNjkF0K0pux0G4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cH9eexhF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cH9eexhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE3CC19425;
	Wed, 22 Apr 2026 07:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776842443;
	bh=kfe/I9yUpqeUUSy67eR3Jkmg4Pr+y4jEBX52TCtc9aw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cH9eexhFs9HZVgy9Da68SyhItOE/WIMbnNQnCnDjpUpt2cOBDkPZOhbnJQCA5fnQB
	 uoazOw/1Xobi81kR6Vv/Se43rKU72+huZtP0CphHQr984tWVdbVclOXOW2KbkFXMBy
	 rIbCB6N6wVMP+B0v0iYB3KxkgdqDrqhmNmm2oG0KaTBHAleMNt7TF4bhHeF4uXoLK0
	 CRdH8ggdrmHNsbca8W8ANHHY2gcoYH1Z0k30LhIu9J35VwOMkmbbOosZzNRFa7dGjl
	 yS26YwA3QhJWjtxGvy+37G3yCsimsVGPnRvwp41ryShjuq/ekGAb/w24iBQ4W/2DLt
	 aGRl3Q6F0oepQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] perf sched stats: Fix SIGCHLD vs pause() race in
 schedstat_live()
Reply-To: sashiko@lists.linux.dev
To: "Swapnil Sapkal" <swapnil.sapkal@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260422050545.129448-3-swapnil.sapkal@amd.com>
References: <20260422050545.129448-3-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 07:20:42 +0000
Message-Id: <20260422072043.7BE3CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Overwriting `done` with `0` defeats the intended fix for the lost-=
wakeup race, causing an indefinite hang.
- [High] The blocking `waitpid()` ignores `SIGTERM` and `SIGINT` because of=
 `SA_RESTART` semantics, causing the tool to hang unresponsively.
--

commit 5047a8fcd3c2b9c566153aee1d997f695b5b0543
Author: Swapnil Sapkal <swapnil.sapkal@amd.com>

perf sched stats: Fix SIGCHLD vs pause() race in schedstat_live()

This commit addresses a lost-wakeup race in perf_sched__schedstat_live()
by replacing pause() with waitpid() for workloads, and using a while (!done)
sleep loop for system-wide mode.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index cfd93bf11c2ee..36fbc20dbebd8 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4695,11 +4695,15 @@ static int perf_sched__schedstat_live(struct perf=
_sched *sched,
>  	if (err < 0)
>  		goto out;
> =20
> -	if (argc)
> -		evlist__start_workload(evlist);
> +	done =3D 0;

Could setting done =3D 0 here inadvertently overwrite the state if a signal
was received during the setup phase?

If a termination signal like SIGINT or SIGTERM is delivered during the
earlier perf_event__synthesize_schedstat() call, the signal handler
sets done =3D 1. This assignment unconditionally resets it back to 0, which
seems to bypass the intended fix and could cause the subsequent loop to
hang indefinitely.

> =20
> -	/* wait for signal */
> -	pause();
> +	if (argc) {
> +		evlist__start_workload(evlist);
> +		waitpid(evlist->workload.pid, NULL, 0);

Could this blocking waitpid() cause the tool to become unresponsive to
SIGINT or SIGTERM?

Since the tool uses signal() for handler registration, glibc provides BSD
semantics which sets the SA_RESTART flag. If a signal arrives while
waitpid() is blocked, the signal handler executes and sets done =3D 1, but
the waitpid() syscall is automatically restarted by the kernel instead of
returning EINTR.

Because the code is blocked inside waitpid() and doesn't check the done
flag, the tool might ignore termination signals and hang until the workload
completes.

Would a non-blocking wait combined with sleep prevent this issue?
For example:

while (!done) {
        if (waitpid(evlist->workload.pid, NULL, WNOHANG) !=3D 0)
                break;
        sleep(1);
}

> +	} else {
> +		while (!done)
> +			sleep(1);
> +	}
> =20
>  	if (reset) {
>  		err =3D disable_sched_schedstat();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422050545.1294=
48-1-swapnil.sapkal@amd.com?part=3D2
