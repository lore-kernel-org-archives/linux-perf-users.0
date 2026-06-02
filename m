Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55883B3BEC
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386418; cv=none; b=mOWAkdJd+Vyz/GB1fGjqULlVp/Nn/4da2aq7qEg/88GG5FrhI/J/z7vTHWVy5ziIOWOMzlxEaFfd4c4IvRU/r/YRSBJm5DKSb4blDZXjZxQJX+cRCSF+nAH+WWh4UwZ7+EC4/8saKkbrniBJze7Sar+DqYZmVpYpJ+JppPPIB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386418; c=relaxed/simple;
	bh=orIKeLzshiqw+3j7kfb49NUWTF7fhwCmzUwdXCZM7DU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rKKnPevFcy56rEZLIBn0gckOmUSSpeQ2IBUMWH6YDfP0q3cJL+iRbIwcLEMDHkKgB4p9UZlxplhBR+wLq6X6NoS9D+/amQdA5plE1MPoAmnQdVuEf1iBklJYSnICOWJbiYRH+4A2M0XVivvBguxaNz0meUag32zJpP6wS3JPTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3tZG0+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3tZG0+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499C01F00893;
	Tue,  2 Jun 2026 07:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780386416;
	bh=YJufmRRRKoaX933obu9iqv0yqWCGO69XpW16Mge4rBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a3tZG0+RAeQwgisMc4znCpDZE+3G/o2sLZLPk6nPyAciwO3ChzyEcskR2lJ46mbbR
	 4wa/ATCeGDXtwcwg8q2QzbeN/vTELj+EMPhdCRfkvQvMSI2sMqhih9N4DmvDBN1XLU
	 AY6T0Xri77u1znFUUTZbgBYcsHLXkEM1aS9HueUATv423XRqJma2+ZM143vFMwuyWo
	 Rw7J4m5uwRnQDE0C791s0jIW6MBPknch6K7zOV3laDXg5zS3smF1MEx/5eDobhsHhn
	 Jag+TexWFXxrGU0ZQ+TkM+AKamvaGj4JznPa9dlAz4gnnURZh1JmI0b4oG/JaTeq0Y
	 MLYjh5EG7GuGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] perf tpebs: Fix concurrent stop races and PID reuse
 hazards in tpebs_stop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602073132.2653307-2-irogers@google.com>
References: <20260602073132.2653307-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 07:46:55 +0000
Message-Id: <20260602074656.499C01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Spurious `-EBUSY` failures and skipped event initialization due to=
 a lockless `tpebs_cmd.pid` check racing with temporary PID restoration.

Pre-existing issues:
- [Critical] Unsynchronized check of `tpebs_cmd.pid` allows concurrent thre=
ads to hit `assert(tpebs_cmd.pid =3D=3D 0)` and crash the process.
- [High] Unprotected `pthread_join` window allows concurrent session start,=
 leading to orphaned processes and state corruption.
- [High] Statically allocated `tpebs_cmd` struct is not re-initialized betw=
een executions, silently skipping `waitpid()` and leaking zombie processes.
- [High] Error paths in `evsel__tpebs_open()` fail to clean up file descrip=
tors, child processes, and global state, permanently breaking TPEBS functio=
nality.
--

commit 6304c5f7736398fadcc6a882cdc4bef08d2b9994
Author: Ian Rogers <irogers@google.com>

perf tpebs: Fix concurrent stop races and PID reuse hazards in tpebs_stop

This commit introduces a tpebs_stopping flag to prevent redundant stop
execution paths. It also temporarily restores cmd.pid during
finish_command() to ensure the process is reaped correctly.

> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 8b615dc94e9ea..6d642356fd9dc 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -37,6 +37,7 @@ static pthread_t tpebs_reader_thread;
>  static struct child_process tpebs_cmd;
>  static int control_fd[2], ack_fd[2];
>  static struct mutex tpebs_mtx;
> +static bool tpebs_stopping;

[Severity: High]
This is a pre-existing issue, but since tpebs_cmd is a static global, does
it need to be re-initialized between executions?

When a session finishes, finish_command() internally sets
tpebs_cmd.finished =3D 1. When a subsequent session begins,
evsel__tpebs_start_perf_record() calls start_command(&tpebs_cmd), which
does not clear the finished flag from previous executions.

When the second session stops, finish_command() will see finished =3D=3D 1
and skip waitpid() entirely, leaving subsequent perf record processes as
zombies.

[Severity: Critical]
This isn't a bug introduced by this patch, but the unsynchronized check of
tpebs_cmd.pid in evsel__tpebs_open() allows concurrent threads to bypass
validation:

int evsel__tpebs_open(...) {
	if (tpebs_cmd.pid !=3D 0) {

If two threads call this concurrently while no session is running, both
bypass the check. They serialize on tpebs_mtx in evsel__tpebs_prepare(),
and both will observe !list_empty(&tpebs_results).

Thread 1 successfully spawns the process and sets tpebs_cmd.pid. Once
Thread 1 releases the lock, Thread 2 acquires it and calls
evsel__tpebs_start_perf_record(), where it hits:

	assert(tpebs_cmd.pid =3D=3D 0);

Can this cause the entire process to crash when the assertion fails?

[Severity: High]
This is a pre-existing issue, but the error path in evsel__tpebs_open()
fails to fully clean up state when pthread_create() fails:

	if (pthread_create(&tpebs_reader_thread, NULL,
			   __sample_reader, NULL)) {
		kill(tpebs_cmd.pid, SIGTERM);
		close(tpebs_cmd.out);
		pr_err("Could not create thread to process sample data.\n");
		ret =3D -1;
		goto out;
	}

This path does not close the control_fd and ack_fd pipes, and it does not
reap the killed child with finish_command(). It also leaves tpebs_cmd.pid
persistently non-zero.

Would this permanently break TPEBS functionality for the process lifetime
by causing future calls to locklessly observe a non-zero PID and return
-EBUSY?

[ ... ]

> @@ -321,8 +322,14 @@ static int tpebs_stop(void) EXCLUSIVE_LOCKS_REQUIRED=
(tpebs_mtx_get())
>  {
>  	int ret =3D 0;
> =20
> +	if (tpebs_stopping)
> +		return 0;
> +
>  	/* Like tpebs_start, we should only run tpebs_end once. */
>  	if (tpebs_cmd.pid !=3D 0) {
> +		pid_t actual_pid =3D tpebs_cmd.pid;
> +
> +		tpebs_stopping =3D true;
>  		tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG);
>  		tpebs_cmd.pid =3D 0;
>  		mutex_unlock(tpebs_mtx_get());
>  		pthread_join(tpebs_reader_thread, NULL);

[Severity: High]
This is a pre-existing issue, but dropping the mutex while tpebs_cmd.pid is
zero allows a concurrent call to evsel__tpebs_open() to spawn a brand new
TPEBS session during the pthread_join() window.

When this thread reacquires the lock, it will blindly close the file
descriptors of the new session and clobber the new session's PID by restori=
ng
the old actual_pid. Does this leave the newly spawned process permanently
untracked and its reader thread leaked?

>  		mutex_lock(tpebs_mtx_get());
>  		close(control_fd[0]);
>  		close(control_fd[1]);
>  		close(ack_fd[0]);
>  		close(ack_fd[1]);
>  		close(tpebs_cmd.out);
> +		tpebs_cmd.pid =3D actual_pid;
>  		ret =3D finish_command(&tpebs_cmd);
>  		tpebs_cmd.pid =3D 0;

[Severity: High]
Does temporarily restoring tpebs_cmd.pid to a non-zero value here create a
race condition with evsel__tpebs_open()?

Since evsel__tpebs_open() performs a lockless check of tpebs_cmd.pid:

int evsel__tpebs_open(...) {
	if (tpebs_cmd.pid !=3D 0) {
		struct tpebs_retire_lat *t;

A concurrent thread could observe the restored non-zero PID, assume a sessi=
on
is actively running, and incorrectly return -EBUSY because it skipped the
initialization sequence.

> +		tpebs_stopping =3D false;
>  		if (ret =3D=3D -ERR_RUN_COMMAND_WAITPID_SIGNAL)
>  			ret =3D 0;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602073132.2653=
307-2-irogers@google.com?part=3D1
