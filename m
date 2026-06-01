Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA463451A7
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295337; cv=none; b=D+CCw2eF2RtSC6mbJDC7IjKQ3CELSHBKzVHQ949VGt4+eCD/XsqCPSY2JWzflcfX/kqsSw+rMZ4ASsO0qUYWwXLEWDt/uwLva5o1f+u3V5gXbffQFXEapFGRgpOP10GXQgDRTq/Qe067+ZEtpbLVw1AX+oWouEBnfAY/eZVyyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295337; c=relaxed/simple;
	bh=BmMx/Wl4Yg1BAsO5bgFMYY2krIcn2KvNl1AWcs/EZ64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QeWBu9NShBo0ZtY4RfDtHebcNslzF1h8hKuF0UbX8l1/Ywa51CZgOkYhvHkq+HZZlL6J0Y0aaRwo4azX43Y7V9pNQELHuLm/6GggRRiD4n/FE8I/42dSOI92aK3RxxlTu0fiYiwjfOF+UXouAvIrctNDB9c+jUYYcyJboKc/bvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOU6NLZ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOU6NLZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092B01F00893;
	Mon,  1 Jun 2026 06:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780295336;
	bh=Hv3PbhlcFe0e7YKPrOV5Z98bCBDfR0ZHOPXkw9eZjvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LOU6NLZ0ZFEUxsuVfGNJmfHzhxnfYdQAmgUPHC42BlKm659hMEot/EJHqrm8Uehww
	 stkluQht7okGkDVzNZP/djeRMDt2gpN0Rqjpv/8gQ6rCV5idsK3LY1FTSSw1ukUp+T
	 1u4iGMgl9pXcwNP/wRtv6KRj/vNLatPT4Cof+HS82pMV0I7dWsL/XJlBwX12d+lfj2
	 WPklBsajosAB6I02VvSI/JD+N0PsL3KkkX075nqXtaW7r1lSR/nV829h7aaWkgj7WQ
	 ZcoPoLgV+6CkP2TNZrN/cV/2vhwKcMffa4hAJfS2MWQoCjUHLZUdBx3k+GKUYRGvpO
	 N2/hnUSoBwU0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] tools subcmd: Robust fallback and existence
 checks for process reaping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601061401.1541457-7-irogers@google.com>
References: <20260601061401.1541457-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 06:28:55 +0000
Message-Id: <20260601062856.092B01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Early returns for errors fail to set `cmd->finished =3D 1`, causin=
g catastrophic `waitpid` errors and arbitrary process reaping in downstream=
 calls.
- [Medium] The implementation contradicts the commit message by aggressivel=
y reaping processes with `waitpid()` instead of preserving zombies with `ki=
ll()`, and completely fails to fix the PID reuse vulnerability.

Pre-existing issues:
- [High] `tpebs_stop()` clears `tpebs_cmd.pid` to 0 before calling `finish_=
command()`, causing `waitpid(0)` to accidentally reap unrelated child proce=
sses.
- [High] `tpebs_send_record_cmd()` drops `tpebs_mtx` while polling, allowin=
g concurrent entry into shutdown sequences.
--

commit 69e7ae6fd81118d00c12a9bae1bdf8a2eb52f3fd
Author: Ian Rogers <irogers@google.com>
tools subcmd: Robust fallback and existence checks for process reaping

This commit modifies the check_if_command_finished() function to handle
invalid PIDs gracefully and introduces a fallback mechanism when
/proc/pid/status is inaccessible.

> Transition the procfs status fopen() fallback from active waitpid() calls
> to robust kill(pid, 0) existence and ESRCH detection logic. This allows
> zombie processes to remain until explicitly reaped by finish_command(),
> eradicating the risk of infinite loops induced by kernel PID reuse across
> unrelated system daemons.

[Severity: Medium]
Does the implementation contradict the commit message?

The commit message states we transition to kill(pid, 0) existence and ESRCH
detection logic to allow zombie processes to remain.

However, looking at check_if_command_finished(), waitpid() with WNOHANG is
used instead, which actively reaps the process.

Additionally, since the fopen("/proc/<pid>/status") check is retained as the
primary path, if an unrelated daemon reuses the PID, fopen will succeed, re=
ad
its running state, and return 0 indefinitely. Does this mean the infinite l=
oop
vulnerability the commit message claims to eradicate is still present?

> diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-comman=
d.c
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

[Severity: High]
Does returning early here without setting cmd->finished =3D 1 cause issues =
later?

If check_if_command_finished() returns 1 but cmd->finished is still 0, a
subsequent call to finish_command() will eventually call wait_or_whine(),
which executes a blocking waitpid(cmd->pid, ...).

If cmd->pid is -1 due to a fork failure, executing waitpid(-1, ...) instruc=
ts
the kernel to blindly wait for any child process, potentially reaping paral=
lel
tests and causing state corruption.

> +
> +#ifdef __linux__
>  	/*
>  	 * Check by reading /proc/<pid>/status as calling waitpid causes
>  	 * stdout/stderr to be closed and data lost.
> @@ -241,8 +248,48 @@ int check_if_command_finished(struct child_process *=
cmd)
>  	sprintf(filename, "/proc/%u/status", cmd->pid);
>  	status_file =3D fopen(filename, "r");
>  	if (status_file =3D=3D NULL) {
> -		/* Open failed assume finish_command was called. */
> -		return true;
> +		int status;
> +		pid_t waiting;
> +
> +		/*
> +		 * fopen() can fail with ENOENT if the process has been reaped.
> +		 * It can also fail with EMFILE/ENFILE if RLIMIT_NOFILE is reached.
> +		 * In those cases, use waitpid(..., WNOHANG) to robustly check
> +		 * and reap the process if it has exited.
> +		 */
> +		if (errno =3D=3D ENOENT)
> +			return 1;

[Severity: High]
Are we also missing cmd->finished =3D 1 here?

> +
> +		waiting =3D waitpid(cmd->pid, &status, WNOHANG);

[Severity: Medium]
This is the waitpid() call mentioned earlier that seems to contradict the
commit message's claim of using kill().

> +		if (waiting =3D=3D cmd->pid) {
> +			int result;
> +			int code;
> +
> +			cmd->finished =3D 1;

[ ... ]

> +			cmd->finish_result =3D result;
> +			return 1;
> +		}
> +		if (waiting < 0 && (errno =3D=3D ECHILD || errno =3D=3D ESRCH))
> +			return 1;

[Severity: Medium]
Can waitpid() actually return ESRCH?

[Severity: High]
Are we missing cmd->finished =3D 1 here as well, similar to the other early
returns?

While reviewing these changes, I noticed a couple of related issues in the
subsystem:

tools/perf/util/intel-tpebs.c:tpebs_stop() {
        ...
        tpebs_cmd.pid =3D 0;
        mutex_unlock(tpebs_mtx_get());
        pthread_join(tpebs_reader_thread, NULL);
        mutex_lock(tpebs_mtx_get());
        close(control_fd[0]);
        ...
        ret =3D finish_command(&tpebs_cmd);
        ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does setting tpebs_cmd.pid t=
o 0
before calling finish_command() cause waitpid(0) to execute?

Passing PID 0 to waitpid() instructs the kernel to wait for any child proce=
ss
in the current process group. Could this intercept and reap unrelated
background child processes spawned by the perf tool, permanently losing the=
ir
exit statuses?

tools/perf/util/intel-tpebs.c:tpebs_send_record_cmd() {
        ...
        mutex_unlock(tpebs_mtx_get());

        /* Send perf record command.*/
        len =3D strlen(msg);
        ret =3D write(control_fd[1], msg, len);
        ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does dropping tpebs_mtx while
polling in tpebs_send_record_cmd() break mutual exclusion?

If tpebs_stop() is called concurrently, it invokes
tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG), dropping the lock during the
shutdown sequence. Does this allow another thread to enter tpebs_stop()
simultaneously, leading to undefined behavior like double pthread_join(),
double close(), or double calls to finish_command()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601061401.1541=
457-1-irogers@google.com?part=3D6
