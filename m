Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E61684BE
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776835793; cv=none; b=DMZCa8hnNOst3iGl+zmB1dQqlLcTgUoW3GN9T5P1X5GcO7hiLdnTHvrwIDswGPaOwMmoc+P8UDhXe6MoXmJwwQtcmPYkAjaLSTlL/rBAEKN42sZ3rEmIz0CftpXz5tw0D2Zskb5qw6AuW8iFqzdmfgBPJhrlKk2IT4r+HqASazI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776835793; c=relaxed/simple;
	bh=j5am5AbKZx3pj8Siz7YBkP96Tg1Fkq3JWAVGBinZIkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UzNywH5+ok3TjwCY9yLiJRrxiIi3jsxtszr7yISLkHPY+vUbGmG/7hwP8DYXGFvimJiL5n1YHXAmMP/SaCoDKbKdxZMnaubKX5lsLHlgUsFESDu+JC1yr+5yPHSSoKfquf2539UayaGwLFPtN4kaaBji5k8ubNqT2LX92os/l0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRdcd6kV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRdcd6kV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29209C19425;
	Wed, 22 Apr 2026 05:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776835793;
	bh=j5am5AbKZx3pj8Siz7YBkP96Tg1Fkq3JWAVGBinZIkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qRdcd6kVgD4f8KrrKvykxkvZehWWJc06OAfccEDCZZ7lOvFAjimgQlo8Txg3ePSa9
	 3fd2e/clz02rgXwxM/aIAI+22GqOaRULK8153ODeTDtzhGURoSmVgcVFOJvnFRdUXA
	 bxCycZAK1od9XxcRydlYTso2pBdglDNjTRv7dA+P2vCZaGV8qZZKpGQtlFsSKTTrEM
	 wAuJHFtKWt/GoU3mVpuvuqSoJZqHleuPb9Zrrs2FKoxTkrMGFRCPnym8yJX+oqUGoW
	 nI/oB2Oj2oPSAacjqIdaBWifPJtHfSkzkZkF1iQ6cexb0J09v+AVG+VSTqrGvq/2g7
	 7PwYYRGhKhFsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] perf sched stats: Fix SIGCHLD vs pause() race in
 schedstat_record()
Reply-To: sashiko@lists.linux.dev
To: "Swapnil Sapkal" <swapnil.sapkal@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260422050545.129448-2-swapnil.sapkal@amd.com>
References: <20260422050545.129448-2-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 05:29:52 +0000
Message-Id: <20260422052953.29209C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Blocking waitpid() ignores the cancellation flag, causing a hang o=
r premature exit.
- [Medium] Unconditional `done =3D 0;` assignment discards termination sign=
als received during initialization.
--

commit 1c95f818d983ad8f7f5ed28e4a0036553b2d2758
Author: Swapnil Sapkal <swapnil.sapkal@amd.com>

perf sched stats: Fix SIGCHLD vs pause() race in schedstat_record()

This commit replaces pause() with waitpid() or a sleep() loop to fix an
indefinite hang if SIGCHLD is delivered before the process enters pause().
It also introduces a sig_atomic_t flag set by the signal handler.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 3f509cfdd58c4..cfd93bf11c2ee 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
[ ... ]
> @@ -3899,11 +3903,15 @@ static int perf_sched__schedstat_record(struct pe=
rf_sched *sched,
>  	if (err < 0)
>  		goto out;
> =20
> -	if (argc)
> -		evlist__start_workload(evlist);
> +	done =3D 0;

Is it possible that this unconditional assignment discards termination sign=
als
received during initialization?

Since the signal handlers are registered at the beginning of the function,
if a user sends SIGINT during the setup phase, the handler will set done to=
 1.
This assignment would then erase the early cancellation request, requiring =
the
user to send the signal again.

> =20
> -	/* wait for signal */
> -	pause();
> +	if (argc) {
> +		evlist__start_workload(evlist);
> +		waitpid(evlist->workload.pid, NULL, 0);

Could this blocking waitpid() cause the tool to ignore the cancellation fla=
g?

Because perf is compiled with _GNU_SOURCE, glibc's signal() uses the
SA_RESTART flag by default. This causes waitpid() to automatically restart
after the signal handler returns.

If the profiled workload ignores or delays handling SIGINT, waitpid() will
continue to block indefinitely and ignore the done flag.

Conversely, if SA_RESTART were disabled, waitpid() would return -1 (EINTR).
Since the return value is not checked, the program would exit prematurely
and leave the workload orphaned in the background.

Would it be safer to use waitpid() with WNOHANG inside a loop that checks
the done flag?

> +	} else {
> +		while (!done)
> +			sleep(1);
> +	}
> =20
>  	if (reset) {
>  		err =3D disable_sched_schedstat();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422050545.1294=
48-1-swapnil.sapkal@amd.com?part=3D1
