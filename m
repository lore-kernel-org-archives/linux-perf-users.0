Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C458B6D8
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172725; cv=none; b=RbkT+a5jpsddcjqhPF5A7Bbedxa4Uv6QJaEn0Glp4UI3Q2BTq9+VGdCdvw9lIZSU6sCpo7+lKiS1JStdgDhZUoP0V1uMbCHy+1lOBa5Y7pxlrGPfiXJw+fCJ/b3pGwqNlzLjqSGqZrh5L4+fkQRCEwG5B482yLJllR32ribHDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172725; c=relaxed/simple;
	bh=HqYq5XkJ8Hh/5ni8iQr6DV5GJgFDJJvXwkHXeWMKaYU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QYoxI9BlaBOEKO9WVY59MNvZ+cOz2IqjC5CfCepiFL5p3Xdda3BaHOmHiiF0vCsoGKGo+pnC0qAvc1iEkOaknfQ5AFlpmfGcx6eLgOz2IUe1sFu+VK8orbInQPqSdjdZ1nLwfJaS/5QHhG5F10WU0ZJuRhPM81HFJzECuCt/c3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0ngb7rD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0ngb7rD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E4E1F000C4;
	Fri, 16 Oct 2026 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172721;
	bh=x/9E3fSDkl8COIV4NTVmX3NsMdRImrd4d28gm6f7Pqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n0ngb7rDPMOIHtPxd7hwNZ9LcKv6RdIgd/Y//ULnHlZPciYYIXegQ7C8aPNx2QG1Q
	 tbd4jacJi+r9/JhCJK3JQzK914AcMJx0Q/yaC+TTGzmwJjmb/nCfdhMBC+TYPUM0Ba
	 H2Lk2lR0vWupTkV2xXC1L0ozORHeF89MmzLR8qYXnMkBQ+DE+AdImumqgzNiecUrhP
	 Iu86vKLsDaSIUW7TNeUKd4DrPT/RH3VnA8znTc7bjGGiryigMl3OGGLwtPEtJapw2B
	 NKstq4Y9B+mnJPwbiQCHaGVwP2TI47PJIJYrpTLWutYx+jp0CwLE0ltMqOyVZR6Tgs
	 fQsglz+FBZwTQ==
Message-ID: <sashiko-outbox-174744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/17] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-14-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:45:20 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf: Samples dropped during teardown due to premature tpebs_cmd.p=
id clearance
- [Medium] perf: thread leak on tpebs_send_record_cmd error path
--

commit 12668ca70c2a83aae9686820143aafd887a3a879
Author: Ian Rogers <irogers@google.com>

perf intel-tpebs: Fix race in tpebs_stop() and tpebs_cmd.out fd handling

This commit fixes a race by releasing tpebs_mtx before calling
pthread_join() in tpebs_stop(). It also transfers ownership of the
tpebs_cmd.out file descriptor to the sample reader thread to prevent
a double-close.

> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 7c0b8b15bd10e..b81831f5e5a42 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
[ ... ]
> @@ -331,12 +339,14 @@ static int tpebs_stop(void) __must_hold(tpebs_mtx_g=
et())
>  	/* Like tpebs_start, we should only run tpebs_end once. */
>  	if (tpebs_cmd.pid !=3D 0) {
>  		pid_t actual_pid =3D tpebs_cmd.pid;
> +		pthread_t reader_thread;
> =20
>  		tpebs_stopping =3D true;
>  		tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG);
>  		tpebs_cmd.pid =3D 0;
> +		reader_thread =3D tpebs_reader_thread;
>  		mutex_unlock(tpebs_mtx_get());
> -		pthread_join(tpebs_reader_thread, NULL);
> +		pthread_join(reader_thread, NULL);

[Severity: High]
Does clearing tpebs_cmd.pid before waiting for the reader thread to finish
cause valid samples to be silently dropped?

When tpebs_stop() clears the PID and releases tpebs_mtx, the reader thread
can run concurrently and drain the pipe. Because process_sample_event()
acquires the mutex and checks if tpebs_cmd.pid is 0, it may erroneously
assume the record has entirely terminated:

tools/perf/util/intel-tpebs.c:process_sample_event() {
    ...
	mutex_lock(tpebs_mtx_get());
	if (tpebs_cmd.pid =3D=3D 0) {
		/* Record has terminated. */
		mutex_unlock(tpebs_mtx_get());
		return 0;
	}
    ...
}

Should tpebs_cmd.pid remain set until after the reader thread is joined so
flushed samples are fully processed?

>  		mutex_lock(tpebs_mtx_get());
>  		if (control_fd[0] >=3D 0) {
[ ... ]
> @@ -567,12 +577,14 @@ int evsel__tpebs_open(struct evsel *evsel)
>  			goto out;
> =20
>  		if (pthread_create(&tpebs_reader_thread, /*attr=3D*/NULL, __sample_rea=
der,
> -				   /*arg=3D*/NULL)) {
> +				   (void *)(intptr_t)tpebs_cmd.out)) {
>  			kill(tpebs_cmd.pid, SIGTERM);
>  			pr_err("Could not create thread to process sample data.\n");
>  			ret =3D -1;
>  			goto out;
>  		}
> +		/* __sample_reader now owns and closes the output fd. */
> +		tpebs_cmd.out =3D -1;
>  		ret =3D tpebs_send_record_cmd(EVLIST_CTL_CMD_ENABLE_TAG);
>  	}
>  out:

[Severity: Medium]
If tpebs_send_record_cmd() fails, execution jumps to the "out:" error clean=
up
block without joining the newly created thread.

In the error path, tpebs_cmd.pid is cleared:

tools/perf/util/intel-tpebs.c:evsel__tpebs_open() {
    ...
		if (started_process) {
			if (tpebs_cmd.pid > 0) {
				kill(tpebs_cmd.pid, SIGTERM);
				finish_command(&tpebs_cmd);
				tpebs_cmd.pid =3D 0;
			}
    ...
}

Since the error cleanup fails to join tpebs_reader_thread, and sets
tpebs_cmd.pid to 0 (which prevents tpebs_stop() from ever joining it later),
does this leak the thread resources?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D13
