Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C491A6824
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780273167; cv=none; b=GILZr+vUfguicYNBTVFXnKoFPMOAOivdUYgzt2jf5FqxC8q3zJndC1mFy7Fk95nVLvh0Z0F+hheuXGF3N4Ncxl7wyToXFrVY3zQX41TYxPoEp1HMMyIv4nCtn58tP6s/XYnbzMlr5sXsrZQFXDR4hD6hIavF3/KMPkQQtDxDzq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780273167; c=relaxed/simple;
	bh=qdRB68vwvtSaOWjqK1BDg+ZedCnxKrrbjWr9zkKCWfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SNwqf62gbT6ABS0TsKDgKprARzyK7f9DwrfoyMO7RazS/xOntwGYEANaBVuoRtCSteQvS07WoPT88s2OXjh8i3VIzhRNOS1L18cXjpkmbnawibkHGjf/CUi3Gn/r/cBmEjubLZOVglrqP5IBxZWIHuoa1oatl5ETA68R2d8oF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il1b/M4h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il1b/M4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38BC1F00893;
	Mon,  1 Jun 2026 00:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780273165;
	bh=xg8VsHbJmX6vEYGk9OPkZYdsMg1EKbCElKoejFkBxPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Il1b/M4hCHfQBro90nXtyBE8nmYeYWcnDZcCjXo8L/4ILUPALP37HM9YxPJoF4vJx
	 t36HoH1kxuAq7M23IavGN+Sb7UK+5q8iEM+LN9nqEBoZCmvWQkJS0MX4s+ylF1nBza
	 osDZD4/OU543NOuRXp2mlzUwtiBcdKyGIj+QJlttyxiVA4YR6Lkc24h0Iv0/2KuCDf
	 LsFmCfSGd2CA3vxKBl1U6v2Fj8X/iCM9udvzBoWn4kXYDfmGkAo++nFSfOz8/GsScx
	 4U/VqFDcPdSMMcfiDgvXQ0N8VgYvTHLMaYaTOTtgSmteBktRllL+u+bgbtP7lixRO0
	 GQ1AbiMa2Xxrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] tools subcmd: Robust fallback and existence
 checks for process reaping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601000548.1195604-7-irogers@google.com>
References: <20260601000548.1195604-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 00:19:24 +0000
Message-Id: <20260601001924.F38BC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix / Process Reaping Hazard via waitpid(-1)
- [High] Unprotected State Modification / Process Reaping Hazard via waitpi=
d(0)
- [High] Uninitialized Thread Join in tpebs_stop
--

commit ad7337e84b07b34e2ac82cda4a7854446ce56d42
Author: Ian Rogers <irogers@google.com>

tools subcmd: Robust fallback and existence checks for process reaping

This commit updates check_if_command_finished() to handle cases where
PID is 0 or -1. It also adds a waitpid fallback when fopen fails due to
file descriptor limits.

> diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-comman=
d.c
> index b7510f83209a0..5ae7b9fa4daba 100644
> --- a/tools/lib/subcmd/run-command.c
> +++ b/tools/lib/subcmd/run-command.c
> @@ -233,7 +233,14 @@ int check_if_command_finished(struct child_process *=
cmd)
>  	char filename[6 + MAX_STRLEN_TYPE(typeof(cmd->pid)) + 7 + 1];
>  	char status_line[256];
>  	FILE *status_file;
> +#endif
> +
> +	if (cmd->finished)
> +		return 1;
> +	if (cmd->pid <=3D 0)
> +		return 1;
> =20

[Severity: High]
This isn't a bug introduced by this patch, but by returning early without
setting cmd->finished =3D 1, does this code still leave the internal state
unchanged?

When error-handling paths like the err_out cleanup loop in __cmd_test()
invoke finish_command() on child structures with pid =3D=3D -1:

tools/perf/tests/builtin-test.c:finish_test() {
    ...
    ret =3D finish_command(&child_test->process);
    ...
}

This calls wait_or_whine(), which sees cmd->finished is still 0 and
proceeds to execute waitpid(-1, ...):

tools/lib/subcmd/run-command.c:wait_or_whine() {
    ...
    pid_t waiting =3D waitpid(cmd->pid, &status, block ? 0 : WNOHANG);
    ...
}

Could this execute a wildcard wait for any child process, potentially
stealing the exit status of concurrent parallel tests?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the lack of validation for
non-positive PIDs also expose a hazard in tpebs_stop()?

In tpebs_stop(), the code zeroes tpebs_cmd.pid before calling
finish_command():

tools/perf/util/intel-tpebs.c:tpebs_stop() {
    ...
    tpebs_cmd.pid =3D 0;
    ...
    ret =3D finish_command(&tpebs_cmd);
    ...
}

Since cmd->finished is not checked or set to true before finish_command()
is called, wait_or_whine() will execute waitpid(0, ...):

tools/lib/subcmd/run-command.c:wait_or_whine() {
    ...
    pid_t waiting =3D waitpid(cmd->pid, &status, block ? 0 : WNOHANG);
    ...
}

Will this wildcard wait instruct the kernel to reap any child process in
the current process group, inadvertently consuming the exit statuses of
unrelated child tasks?

[Severity: High]
This is a pre-existing issue, but does leaving tpebs_cmd.pid as -1 lead
to an uninitialized thread join?

In evsel__tpebs_open(), if evsel__tpebs_start_perf_record() fails:

tools/perf/util/intel-tpebs.c:evsel__tpebs_open() {
    ...
    ret =3D evsel__tpebs_start_perf_record(evsel);
    if (ret)
        goto out;
    ...
}

This leaves tpebs_cmd.pid as -1 and aborts before initializing the thread.
Later, when evsel__tpebs_close() calls tpebs_stop(), the condition
if (tpebs_cmd.pid !=3D 0) evaluates to true.

The code then erroneously calls pthread_join() on the uninitialized thread:

tools/perf/util/intel-tpebs.c:tpebs_stop() {
    ...
    pthread_join(tpebs_reader_thread, NULL);
    ...
}

Since tpebs_reader_thread is an uninitialized static variable, can passing
it to pthread_join() cause undefined behavior or a segmentation fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601000548.1195=
604-1-irogers@google.com?part=3D6
