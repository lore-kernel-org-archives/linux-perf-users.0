Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950055;
	b=kPeimdjUurkF98MYYV1UNodILIRUM1KUKdkn4acsr6P9t/vMMtpajjN8rHwn6zhu5ifV
	 UDleHxE4l8wLLzdlDWp/drQC7TVqWSxlvvUOMI0m/d7h79ax/ET0X9CtASMwqU2CenUIU
	 BkanexByFW+mwbYtcYIxqsqWBp1DFaxDqExd3ygOdHP9dXBjPeK/Myu2dOz/2aYg6SOkg
	 VIeJFGaUU1K+HaA5l22WZ+CVf8h35TYYzZf0vHf4B075rmfOYFw1Fmrku1Mm6KihC3WO7
	 Nu7tzws81j4YVidYQnQVeUXktjLazxei55bPdYLpThyVPZ3JIkt/qeRmh+UqU7eD0oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950055;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=86kZUBf7AHhHApn+V/YHePerjY6XiNL0Xsk4FmCSCUA=;
	b=gz/Fgrx73Pc5SZTc1Er5notvu1FbGaeOhpxa+Srj7Te0tLRh8hBfMG8c0ZbLsSDS3qic
	 fJ8SLFwzv6SI28GLHH8vjYyjx87n6yhP7wLeLipsD+a3gsq4HlLAX/JvcRvWzlMIShYc9
	 mL5wkQWOCtumHirJJiIZmsGFHY3iGS8MiZnD+WQPF8Q7gr4Hjaskewux7TP0WyHRJCG1P
	 0mLP4vj8K8kWJAFTmOw4whPMBsBJwNMVspDGcO3bggHdSRttcDgzsZmW79ZnCtkXRtv+E
	 I45NxC5gszAKMa+TBhB5gb2VkeE7w9udNAPdEm6Ct0ZWeMMCaPufW3a39EvEGpVDsEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGBlv6h9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7BD606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGBlv6h9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C691F0089F;
	Fri,  6 Nov 2026 07:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793950055;
	bh=86kZUBf7AHhHApn+V/YHePerjY6XiNL0Xsk4FmCSCUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dGBlv6h9XnmD65PWL4RHwI1pR6BM7s8oBcOz+jDxQP1ul2c2JPyFrGHJ8Bto2QRNU
	 fZuak4U3KCVcX9YeasbvFAm+eGSa5Ll3xajdB1pYOyUZLBOoEDRpdYYKRhuFbJamAm
	 rVXvtir2RpZ69x3BAJS8chRJQhKbtj3+xZK6qRbluKo+RuJaS9V6PzOvF4ymtLGta3
	 ir8uD7IznkEhVl9SflYTgcTIM8IX/KZtm8AN1hBbEhCE5IIP0Zi7x2nUsgPqEk1qBD
	 AM8bJLXLD7ktOf3HzEHKWXGlg0cFxp4csctZWgXhrfSxknYGw5qJnnr+UVjfaO6sXF
	 Md1C15R0ltmFg==
Message-ID: <sashiko-outbox-200994@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 15/20] perf intel-tpebs: Fix race in tpebs_stop()
 and tpebs_cmd.out fd handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-16-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:27:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf intel-tpebs: race between evsel__tpebs_open() cleanup
  and tpebs_stop()
--

commit 7a1ce986169f6d07b45e9adbf7d1dd00eff88dbc
Author: Ian Rogers <irogers@google.com>

perf intel-tpebs: Fix race in tpebs_stop() and tpebs_cmd.out fd handling

This commit fixes a race on tpebs_reader_thread in tpebs_stop(), transfers
tpebs_cmd.out ownership to __sample_reader(), cleans up tpebs_cmd and
tpebs_reader_thread on error paths, and adds explicit header includes.

> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 7c0b8b15bd10e..47c939fc2058c 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
[ ... ]
> @@ -567,12 +588,15 @@ int evsel__tpebs_open(struct evsel *evsel)
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
> +		started_thread =3D true;
>  		ret =3D tpebs_send_record_cmd(EVLIST_CTL_CMD_ENABLE_TAG);
>  	}
>  out:
> @@ -586,9 +610,22 @@ int evsel__tpebs_open(struct evsel *evsel)
> =20
>  		if (started_process) {
>  			if (tpebs_cmd.pid > 0) {
> -				kill(tpebs_cmd.pid, SIGTERM);
> +				pid_t actual_pid =3D tpebs_cmd.pid;
> +
> +				tpebs_stopping =3D true;
> +				kill(actual_pid, SIGTERM);
> +				tpebs_cmd.pid =3D 0;
> +				if (started_thread) {
> +					pthread_t reader_thread =3D tpebs_reader_thread;
> +
> +					mutex_unlock(tpebs_mtx_get());
> +					pthread_join(reader_thread, NULL);
> +					mutex_lock(tpebs_mtx_get());
> +				}
> +				tpebs_cmd.pid =3D actual_pid;
>  				finish_command(&tpebs_cmd);
>  				tpebs_cmd.pid =3D 0;
> +				tpebs_stopping =3D false;
>  			}

[Severity: Medium]
Can this error path race with tpebs_stop() and call pthread_join() twice on
the same reader_thread?

tpebs_send_record_cmd() drops tpebs_mtx while writing the command and
polling ack_fd[0].  During that window a concurrent evsel__tpebs_close()
can enter tpebs_stop(), which also drops tpebs_mtx inside
tpebs_send_record_cmd() before clearing tpebs_cmd.pid:

CPU0                                  CPU1
evsel__tpebs_open()
  started_process =3D true
  started_thread =3D true
  tpebs_send_record_cmd(ENABLE)
    mutex_unlock(tpebs_mtx)
                                      evsel__tpebs_close()
                                        tpebs_stop()
                                          tpebs_stopping =3D true
                                          tpebs_send_record_cmd(STOP)
                                            mutex_unlock(tpebs_mtx)
    mutex_lock(tpebs_mtx)
  if (started_process)
    if (tpebs_cmd.pid > 0)
      reader_thread =3D tpebs_reader_thread
      tpebs_cmd.pid =3D 0
      mutex_unlock(tpebs_mtx)
      pthread_join(reader_thread)
                                            mutex_lock(tpebs_mtx)
                                          reader_thread =3D tpebs_reader_th=
read
                                          mutex_unlock(tpebs_mtx)
                                          pthread_join(reader_thread)
                                            <-- double pthread_join()

Both threads then also restore tpebs_cmd.pid =3D actual_pid and call
finish_command(&tpebs_cmd).  Even if tpebs_stop() has already cleared
tpebs_cmd.pid =3D 0 and is unlocked inside pthread_join(), the
started_process block still closes control_fd and ack_fd underneath it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D15
