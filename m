Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE290223DC6
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210502; cv=none; b=kAO0Sm7ry69PgSUDcZ/GyU/cDMJM43bWOANvU4/v8hYU86p2YVRMck5eABrT0aT3aclu1tFcQxvlkbsdAxcZ6oMOjvXTJAEdCZX0WAQF/WGK96YT3tZ8dkVxzSwD0pYS9ojoHHrcnHLrceS8lQtzsokS24c64QcVvAYdj7hSL68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210502; c=relaxed/simple;
	bh=wXa7rIG0cvVYnJMXJ07sQussFyr1xLlEUjw8UjYf1xg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JMlKVErQhnVgh8clFtTTXbQ+S6jKZAAdpuaRcRsrPMaAbHk1NFE13EYZjcbGrLfAGaiXa+Co1rMi8yvphkOJab8hQAYOzKVF7iyKgG8WF+T9duEE8F6BLiFuPMNPFUEf+G5BIW8NfuJlWUoVUHf9xMoZZ5JbtTLP7oVtALRZOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJYOWcsU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJYOWcsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7741F00893;
	Sun, 31 May 2026 06:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780210501;
	bh=vivpZKk8uUYrYV+yNcJJ+sshNFk7uxGkUgcfq7cEmFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJYOWcsUlZmF8610GkN0VUGPjlkFDV3gmXfxZrWX4uxVsrVn7xqaOv6P3JLVP+XOs
	 YO7CbTno00HK1v7GZ5Vm3YhKxk+vMaX+rrvwaVlLvW50Zyopt13wx0Ia/cSlTljjeH
	 ttdoVRmey7upHW1Lcci2omm37xPKwLbEVX/fpnDnTIQ0GruOQaKPIG55kByGebw/e1
	 LIadhP6iVBGYfwPKP7gbZWnaJvTtq0SA4RL44RXnLwFET0hMawyOQMLgYT1Nar6QKm
	 Lyf2pKqQ+JCOqi9ooYEzM5ID8cFCQa9LWKwA1xd2gZKwMuSk8nMKjLypKVC1FjW7tC
	 c37ZA57G8GTZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/14] perf test: Refactor parallel poll loop to
 drain all pipes simultaneously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531063736.871777-7-irogers@google.com>
References: <20260531063736.871777-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 06:55:00 +0000
Message-Id: <20260531065501.3E7741F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Race Condition / Infinite Wait from PID Reuse
- [Medium] Comment/Code Mismatch and Incorrect Fallback Logic

Pre-existing issues:
- [High] Unintended Process Reaping via waitpid(-1)
- [High] Use-After-Free in Signal Handler during Test Teardown
--

commit 85338a93349cbaff2c4d5fe37f997271e81388e1
Author: Ian Rogers <irogers@google.com>

perf test: Refactor parallel poll loop to drain all pipes simultaneously

When running tests in parallel with verbose output (-v), child processes
write to pipes. If a test produces significant output, it fills the pipe
buffer and blocks. This commit introduces finish_tests_parallel() to
poll and drain output pipes from all running children simultaneously.

> diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-comman=
d.c
> index b7510f83209a0..e1341080dbae7 100644
> --- a/tools/lib/subcmd/run-command.c
> +++ b/tools/lib/subcmd/run-command.c
> @@ -146,6 +146,10 @@ int start_command(struct child_process *cmd)
>  			close(cmd->out);
>  		if (need_err)
>  			close_pair(fderr);
> +		cmd->pid =3D -1;
> +		cmd->in =3D -1;
> +		cmd->out =3D -1;
> +		cmd->err =3D -1;

[Severity: High]
This isn't a bug introduced by this patch, but does assigning -1 to the PID
on error create an unintended process reaping hazard?

If start_command() encounters an error, it explicitly sets cmd->pid to -1.
The error propagates up to __cmd_test(), jumping to the err_out block where
it unconditionally loops over the child_tests array to clean up.

Because finish_test() does not verify if child_test->process.pid > 0 before
proceeding to check_if_command_finished() and finish_command(), this cleanup
flow ultimately executes a waitpid() call:

waitpid(cmd->pid, &status, block ? 0 : WNOHANG);

Calling waitpid() with -1 forces the kernel to wait for any child process,
which can inadvertently reap an unrelated concurrent test process and disca=
rd
its exit status.

>  		return err =3D=3D ENOENT ?
>  			-ERR_RUN_COMMAND_EXEC :
>  			-ERR_RUN_COMMAND_FORK;

[ ... ]

> @@ -241,8 +247,45 @@ int check_if_command_finished(struct child_process *=
cmd)
>  	sprintf(filename, "/proc/%u/status", cmd->pid);
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

[Severity: Medium]
Does the implementation contradict the documented intent here?

The comment explicitly states that the logic uses kill(pid, 0) as a robust
fallback. However, the subsequent code calls waitpid() instead. Using waitp=
id
actively reaps the process, whereas kill(pid, 0) would safely let the proce=
ss
remain a zombie until explicitly reaped by finish_command().

> +		if (errno =3D=3D ENOENT)
> +			return 1;
> +		waiting =3D waitpid(cmd->pid, &status, WNOHANG);

[Severity: High]
Could this waitpid() fallback introduce an infinite loop due to PID reuse?

Since check_if_command_finished() is polled repeatedly in
finish_tests_parallel(), and it does not verify if cmd->finished is already
true before querying the procfs status file, there is a risk that a previous
waitpid() call already reaped the child.

Once reaped, the OS can reuse the PID. If an unrelated system daemon is
assigned this PID before the next loop iteration, fopen() on the procfs
status file will succeed and report the active state of that unrelated
process. The test harness would then loop indefinitely waiting for the
unrelated daemon to exit.

> +		if (waiting =3D=3D cmd->pid) {
> +			int result;

[ ... ]

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 2ccb52a776ccb..9f71f11928c60 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -503,12 +509,205 @@ static void finish_test(struct child_test **child_=
tests, int running_test, int c
>  		fprintf(stderr, "%s", err_output.buf);
> =20
>  	strbuf_release(&err_output);
> +	strbuf_release(&child_test->err_output);
>  	print_test_result(t, curr_suite, curr_test_case, ret, width, /*running=
=3D*/0);
>  	if (err > 0)
>  		close(err);
>  	zfree(&child_tests[running_test]);

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk during
signal teardown when using zfree() here?

The zfree() macro generally expands to a free() operation followed by
setting the pointer to NULL. If a signal like SIGINT arrives exactly
between the memory being freed and the pointer being nulled, the signal
handler preempts the thread.

The cmd_test_sig_handler handler uses siglongjmp() to return to err_out in
__cmd_test(), which iterates over child_tests to terminate active children.
The loop will see a non-NULL pointer, dereference the freed memory to read
child_test->process.pid, and issue a kill() signal to whatever garbage
value was read. This could potentially terminate critical system processes.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531063736.8717=
77-1-irogers@google.com?part=3D6
