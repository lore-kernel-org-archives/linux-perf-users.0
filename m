Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261009;
	b=dxsXrdNJXLBpN+SPOJ8cQUB5GtjlBPkZF+TsT0snaqY9JQtfPHRlIoRHms0nHGFH8o1r
	 EVF16D33C2vDtmQ7QkWS2pg1ioK7MdOvmOHRucJ1QQHprliQOVcecwR1Kirob+nj83nC0
	 mjcXLK/rPpYRgGM+ZCcIlRild2hQ20rROXGhRt5BblWLybJ+KXjc77uEJTjuDKd0eZmh4
	 9jjMniE5/7VcBK4DDnrVtrQSgNs9MAJn8f/nZSnxcPH4FLQHGd31n6L/t2/dmlYmFyUkM
	 2bsZnnCaABxpNl7/FFW0EauzrBKiSBEg20qmm6D4YbD68Hdn4Wt/521eqbWTnK/+JjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+wDty3X7yMgyvdGjWdKK8Pzh4+D2GmthmoA3oQIkh9g=;
	b=WuFTlWX3K8fAOilU1jeL5nD4Dt8ZJtc2GW78/narePm8wCoIAjlRn17O4Kq0d+xBB9W3
	 WHFvpC1fTjuiH02EWrdPTuTADlwVNJ8dqiS2/pV6Cx1KQXPcEpaoqRLktAiLJ60oqrSKh
	 Lnrsus8P/pIl+10uArtWuNhEOPnK/2flNGZs9rBDmOBuanVNyUmkMFBA3XJ2R79gBQ2ik
	 RDOnMKJS081z3dmkXxjhzpwXIzS3dRkcy2dkcRP2uHXTe9UgARc/LXd8A8xQRx1QxXxMM
	 V/g5tkturVpqj8PzFh7qxb0VTE7xul2+DeWirKIHJcB+Fpbs21Ld+/ZhpVp0jZpyJHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWWUH3EF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B419606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWWUH3EF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E99C1F0089F;
	Mon,  9 Nov 2026 21:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794261008;
	bh=+wDty3X7yMgyvdGjWdKK8Pzh4+D2GmthmoA3oQIkh9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HWWUH3EFyz8MU+iEcjbCSLr+3Ai2aeQvmU0/bMJ9dcvcoV/GqsIDqh9Po+3LDRzNS
	 c8JccZCRrIthnI2/bcLbax0pn0DNXoctpKfc2DIUe44pPm6/rconJ81qaRKiOpp8S+
	 9E/WrgeHA42fHzkkbA+qdlZYZKtNXkghnCnMVWAZZsPeieJLT1dTmfDyaoWvJfBqE1
	 pZcFTlVoNlKi/Y+zT8jfS5pcmC5cbajfRTPxAPJFBrCKQFk2Db987XsbY2NNZUxCyA
	 KwBueABGL+qT6jR7qfKWn3hhd0X0Ts1UwFPK+DbI5Riw5OhP7bfln8f5F6rn/opooS
	 wNBBB4rKnOLhw==
Message-ID: <sashiko-outbox-205695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 15/20] perf intel-tpebs: Fix race in tpebs_stop()
 and tpebs_cmd.out fd handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-16-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:50:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf intel-tpebs: control pipe command coalescing deadlock in
  tpebs_stop()
- [Low] perf intel-tpebs: race in process_sample_event() during
  tpebs_stop()
--

commit e2203763a4bf43ed152a64f29917746045712cad
Author: Ian Rogers <irogers@google.com>

perf intel-tpebs: Fix race in tpebs_stop() and tpebs_cmd.out fd handling

This commit serializes control command writes with teardown, transfers
ownership of tpebs_cmd.out to __sample_reader(), and guards
evsel__tpebs_open() against a concurrent tpebs_stop().

> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 7c0b8b15bd10e..4b7464cfa0eb3 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c

[ ... ]

> @@ -262,20 +291,20 @@ static int tpebs_send_record_cmd(const char *msg) _=
_must_hold(tpebs_mtx_get())
> =20
>  	/* Send perf record command.*/
>  	len =3D strlen(msg);
> -	ret =3D write(control_fd[1], msg, len);
> +	ret =3D write(ctrl_fd, msg, len);
>  	if (ret !=3D len) {
>  		pr_err("perf record control write control message '%s' failed\n", msg);
>  		ret =3D -EPIPE;
>  		goto out;
>  	}
> =20
> -	if (!strcmp(msg, EVLIST_CTL_CMD_STOP_TAG)) {
> +	if (is_stop) {
>  		ret =3D 0;
>  		goto out;
>  	}
> =20
>  	/* Wait for an ack. */
> -	pollfd.fd =3D ack_fd[0];
> +	pollfd.fd =3D resp_fd;
> =20
>  	/*
>  	 * We need this poll to ensure the ack_fd PIPE will not hang
> @@ -284,7 +313,17 @@ static int tpebs_send_record_cmd(const char *msg) __=
must_hold(tpebs_mtx_get())
>  	 */
>  again:
>  	if (!poll(&pollfd, 1, 500)) {
> -		if (check_if_command_finished(&tpebs_cmd)) {
> +		bool stopping, finished;
> +
> +		mutex_lock(tpebs_mtx_get());
> +		stopping =3D tpebs_stopping;
> +		finished =3D !stopping && check_if_command_finished(&tpebs_cmd);
> +		mutex_unlock(tpebs_mtx_get());
> +		if (stopping) {
> +			ret =3D -EBUSY;
> +			goto out;
> +		}

[Severity: Medium]
Can aborting the poll() wait on tpebs_stopping coalesce the in-flight
command with EVLIST_CTL_CMD_STOP_TAG in control_fd and hang tpebs_stop()
in pthread_join()?

tpebs_send_record_cmd() writes msg without a trailing newline or NUL
delimiter:

Thread 1                          Thread 2
evsel__tpebs_open()
  tpebs_send_record_cmd("enable")
    write(ctrl_fd, "enable", 6)
    poll(&pollfd, 1, 500)
                                  evsel__tpebs_close()
                                    tpebs_stop()
                                      tpebs_stopping =3D true
                                      tpebs_gen++
                                      tpebs_send_record_cmd("stop")
                                        cond_wait(&tpebs_cmd_cond, ...)
    /* poll() times out */
    stopping =3D=3D true -> goto out
    tpebs_cmd_in_flight =3D false
    cond_broadcast(&tpebs_cmd_cond)
  /* tpebs_gen !=3D open_gen, skips SIGTERM */
                                        write(ctrl_fd, "stop", 4)
                                      pthread_join(reader_thread, NULL)
                                        <-- hangs forever

When perf record reads from the control pipe, evlist__ctlfd_recv() reads
all available bytes until '\n', '\0', or EAGAIN into a single command
buffer:

tools/perf/util/evlist.c:evlist__ctlfd_recv() {
	do {
		err =3D read(evlist__ctl_fd_fd(evlist), &c, 1);
		if (err > 0) {
			if (c =3D=3D '\n' || c =3D=3D '\0')
				break;
			cmd_data[bytes_read++] =3D c;
    ...
}

If perf record has not consumed "enable" (or "ping") before "stop" is
written, it reads "enablestop" (or "pingstop") as one command and drops
the stop request.  Because evsel__tpebs_open() skips kill(..., SIGTERM)
once tpebs_gen has changed and tpebs_stop() waits in pthread_join()
before closing the pipes or killing the child, perf record never exits
and pthread_join() blocks forever.

[ ... ]

> @@ -331,12 +382,21 @@ static int tpebs_stop(void) __must_hold(tpebs_mtx_g=
et())
>  	/* Like tpebs_start, we should only run tpebs_end once. */
>  	if (tpebs_cmd.pid !=3D 0) {
>  		pid_t actual_pid =3D tpebs_cmd.pid;
> +		pthread_t reader_thread;
> =20
>  		tpebs_stopping =3D true;
> +		tpebs_gen++;
> +		cond_broadcast(&tpebs_cmd_cond);
>  		tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG);
> +		/*
> +		 * tpebs_results is empty when stopping; clear pid so
> +		 * process_sample_event() ignores any late samples while
> +		 * draining the pipe.
> +		 */
>  		tpebs_cmd.pid =3D 0;

[Severity: Low]
Can process_sample_event() still see a non-zero tpebs_cmd.pid and return
-EINVAL while tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG) drops
tpebs_mtx?

evsel__tpebs_close() empties tpebs_results before calling tpebs_stop(),
and tpebs_send_record_cmd() releases tpebs_mtx in cond_wait() and around
write().  Because tpebs_cmd.pid is only cleared after
tpebs_send_record_cmd() returns and process_sample_event() does not check
tpebs_stopping:

tools/perf/util/intel-tpebs.c:process_sample_event() {
	mutex_lock(tpebs_mtx_get());
	if (tpebs_cmd.pid =3D=3D 0) {
		/* Record has terminated. */
		mutex_unlock(tpebs_mtx_get());
		return 0;
	}
	t =3D tpebs_retire_lat__find(sample->evsel);
	if (!t) {
		mutex_unlock(tpebs_mtx_get());
		return -EINVAL;
	}
    ...
}

Any sample processed by tpebs_reader_thread during that window fails the
lookup in the empty tpebs_results list and returns -EINVAL, causing
__perf_session__process_pipe_events() to log an error and abort draining
the pipe early.  Checking tpebs_stopping in process_sample_event() would
avoid this race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D15
