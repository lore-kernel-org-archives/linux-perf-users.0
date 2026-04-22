Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FCE3D16E5
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857506; cv=none; b=kjON2VFpeyLv7H1tt6QSijxQ5LPrPBpxwFafx1nw/9teoOmT+mEiVn4BAEF3SuJrgc7oCY4DOe0kaK9w4vsBS59uomAUP+4puCcWgAtl8HsdHEFTqXNwUGCnaNHunpsWL3yvPvfzcP3ApIBqxQKtHxRmYmNhaC6L0Xu8S8VXiYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857506; c=relaxed/simple;
	bh=76W6TTIldXNOkvw32C8zwApb+avpybttb18op9o+6zM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=frOezb5aXBU2al7XJPcLjJZ/80MW4zI6l5XBRd8kQMYNPUINcFZMBRTfGFnNmsS18nPXFMPPsw6bzIRyI+mQv9HbzRVNb9q1v2v7T7KYYTKbvB8EECQCRc1majlMJx4OkP7rcOAEvoSnOvYRbFxLmGZ3M+u8Brnz1TJPBJEPtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVSb1DrY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVSb1DrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96BAC19425;
	Wed, 22 Apr 2026 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776857505;
	bh=76W6TTIldXNOkvw32C8zwApb+avpybttb18op9o+6zM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UVSb1DrYWc5etN78V7P5IRylAfzdopgCsI5/ZkVIsXcWjVMstciXP53D5BgPTks8s
	 cSwgFfsJg5zbQHUV4yhw/oKcXvhDSG1vtJV2yPYNkzZ6Sa7D+J8PwDZaPX+KQPz3mj
	 h+53y3kPmeq5+JslLJED0Mq0DTJEYvg7qySDJirx2RHM2A2eHpvp018/GpCCCNcC3i
	 esTy45HwE4sPVvHGo2YCGQ1QoblqROgvy1mmR02YG0huvwcq8UPgsZpw+qXPcNDLno
	 RoyXdcO0/sGilktEPpDJJw6xLUTJ47bUdls9zpDaxGDCNz+vELrYYoT49l54qlqER4
	 S4yN1+lN0yOzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] perf lock contention: Fix SIGCHLD vs pause()
 race in __cmd_contention()
Reply-To: sashiko@lists.linux.dev
To: "Swapnil Sapkal" <swapnil.sapkal@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260422050545.129448-4-swapnil.sapkal@amd.com>
References: <20260422050545.129448-4-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 11:31:45 +0000
Message-Id: <20260422113145.C96BAC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Blocking `waitpid()` without checking the `done` flag prevents cle=
an teardown and ignores signals in workload mode.
- [Medium] The `done =3D 0` assignment introduces a race condition that cau=
ses early `SIGINT`/`SIGTERM` signals to be completely ignored.
--

commit 8ef94afdd78ecb3553bc6a801fe79f49d3d5680d
Author: Swapnil Sapkal <swapnil.sapkal@amd.com>

perf lock contention: Fix SIGCHLD vs pause() race in __cmd_contention()

This commit replaces the pause() call with waitpid() for workload mode
and a sleep loop for system-wide mode to fix a lost-wakeup race.

> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index e8962c985d34a..3c165d632941f 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
[ ... ]
> @@ -2124,11 +2128,16 @@ static int __cmd_contention(int argc, const char =
**argv)
> =20
>  	if (use_bpf) {
>  		lock_contention_start();
> -		if (argc)
> -			evlist__start_workload(con.evlist);
> =20
> -		/* wait for signal */
> -		pause();
> +		done =3D 0;

Is it possible for this assignment to overwrite a signal received earlier?

The signal handlers are registered before BPF loading, which can take a
noticeable amount of time:

__cmd_contention() {
    ...
    signal(SIGINT, sighandler);
    ...
    err =3D lock_contention_prepare(&con);
    ...
}

If a user sends SIGINT during BPF loading, the handler correctly sets
done =3D 1, but this assignment then erases that state. Since done is
statically zero-initialized, could this assignment be safely removed?

> +
> +		if (argc) {
> +			evlist__start_workload(con.evlist);
> +			waitpid(con.evlist->workload.pid, NULL, 0);

Will this blocking waitpid() hang if the process receives a signal?

Signal handlers registered with glibc's signal() typically have the
SA_RESTART flag set by default. If perf receives a signal like SIGTERM
during this waitpid(), the handler sets done =3D 1, but the kernel will
automatically restart the interrupted waitpid().

If the child process ignores the signal or the signal is only sent to perf,
waitpid() resumes without checking the done flag. This prevents the process
from gracefully stopping the trace and printing the results.

Should this use a polling loop with WNOHANG to allow checking the done flag?

> +		} else {
> +			while (!done)
> +				sleep(1);
> +		}
> =20
>  		lock_contention_stop();
>  		lock_contention_read(&con);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422050545.1294=
48-1-swapnil.sapkal@amd.com?part=3D3
