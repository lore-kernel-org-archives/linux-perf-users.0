Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FEA474262
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916926; cv=none; b=g0tN+bvnwPDH3zP8npV3QLVKzivb2iMBCh6EictA4ZdB7/06oLb17hm6htJ0tBv2mh0qotldHfa/A/qOtMfqFjONlrs1m4H7RIpPNdKB/hJ4xIWUPWRHwgk6C3Xoc5fhpw7fW6ig1/BZ7L02U4vQBCVvhI40u12MVScDUMOMj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916926; c=relaxed/simple;
	bh=E1LAFe5ivKgo7XJ71HBo7eNGvqCq3TfCbcJoVMqdug4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MGUkPuno1OyMPuVbffnYpcxvhm6qjZgw1Ob78E824DUR7nrPA8a7II6jV70u6T1B9rlrfDRh/ndIDbBsgyda7XH7+RsEJBLAz8LBOBE74NAPeCHQpnNmnIOJxEEp7P9eiskjCQ/jt+pn2N2/SoL/WrDozLHbK2ulodhg2AmtvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRzZgVqo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRzZgVqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E75D1F000FF;
	Tue, 13 Oct 2026 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791916925;
	bh=m3MVo0OghEFsYM4NayrvKPvs6uFxSLqeoaKlsEjpUmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FRzZgVqoMa99Ppfvm3Gk+8zWdKXLAuTD5KTrkMM0airzpHDocDeycraYYRakpen8v
	 b2G93TpsnMGYMiDOW4SWsVMo3HEgrM/JARbQQRBQW4mWiGKj/TNfaU23cavKNq9Vpj
	 DyjR+h66vOYN63C5x062lbSWG5xOIYzfnhnpAUeXL7A55TvFdFWfTIqKJlHS/xvNFS
	 4UIR5YC1MqzERs16UO6j4t2EgmGoA80LVVD34CamMFYMvHer7XqpbEzjYsnF5NZ3MA
	 sLTneXp0OLsrpIKyIxIt9JWBHSGuZ6VCIakGgtUoeYi0waaC0syDkndI68LFZbJgtl
	 Nct06/r08TPig==
Message-ID: <sashiko-outbox-170346@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/10] perf config, intel-tpebs, env: Add
 __guarded_by and __must_hold annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013182458.1234616-10-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:42:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: double close of tpebs_cmd.out file descriptor
--

commit 6138e7835465a4c85543c9abbf52c07f583bbb7a
Author: Ian Rogers <irogers@google.com>

perf config, intel-tpebs, env: Add __guarded_by and __must_hold annotations

Add thread safety annotations to the static parser and config state,
the TPEBS state, and the bpf_progs and cgroups trees. It also fixes some
unlocked reads and modernizes mutex initialization.

> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -331,13 +317,15 @@ static int tpebs_stop(void) __must_hold(tpebs_mtx_g=
et())
>  	/* Like tpebs_start, we should only run tpebs_end once. */
>  	if (tpebs_cmd.pid !=3D 0) {
>  		pid_t actual_pid =3D tpebs_cmd.pid;
> +		pthread_t reader_thread;
> =20
>  		tpebs_stopping =3D true;
>  		tpebs_send_record_cmd(EVLIST_CTL_CMD_STOP_TAG);
>  		tpebs_cmd.pid =3D 0;
> -		mutex_unlock(tpebs_mtx_get());
> -		pthread_join(tpebs_reader_thread, NULL);
> -		mutex_lock(tpebs_mtx_get());
> +		reader_thread =3D tpebs_reader_thread;
> +		mutex_unlock(&tpebs_mtx);
> +		pthread_join(reader_thread, NULL);
> +		mutex_lock(&tpebs_mtx);
>  		if (control_fd[0] >=3D 0) {

[Severity: High]
Could this sequence result in a double close of the tpebs_cmd.out file
descriptor?

The reader thread __sample_reader() assigns tpebs_cmd.out to data.file.fd
and passes it to perf_session__new(). When the thread finishes, it calls
perf_session__delete(), which invokes perf_data__close() and closes the
underlying file descriptor:

tools/perf/util/data.c:perf_data_file__close() {
...
	} else {
		close(file->fd);
		file->fd =3D -1;
	}
...
}

Meanwhile, after pthread_join() completes here in tpebs_stop(), the global
tpebs_cmd.out variable is still >=3D 0 because the reader thread only closed
its local struct copy without updating the global state.

This causes tpebs_stop() to explicitly call close() a second time just
below this block:

tools/perf/util/intel-tpebs.c:tpebs_stop() {
...
		if (tpebs_cmd.out >=3D 0) {
			close(tpebs_cmd.out);
			tpebs_cmd.out =3D -1;
		}
...
}

If another thread is assigned the same fd number in the window between the
first close in __sample_reader() and this second close in tpebs_stop(),
the second close could silently destroy an unrelated resource.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013182458.1234=
616-1-irogers@google.com?part=3D9
