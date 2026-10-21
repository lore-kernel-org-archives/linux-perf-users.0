Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623935;
	b=ANLd0PL6nYjjnayv8MXJcm3ySg7W9YRap1M97YuBG+aOKrh/MPXVZxatR3g7yLB50VF8
	 oCo9qkTuveU9bfFCdRutxRcrQZp9CUR/mpo7dKQHAMA+0Pb1n00lmVS5BRUpb7B29mL4t
	 S68Di8dcNscN1Mg7d38KW8cj2R9d4lZxuuuOhqTvRKzS1LGRmdUQbXG001W3TcF93ExYS
	 dBW+nPAwWUmkaRrp6SBViQoimw2j76gARXJgLPYY2Rf3V9xV9TQm9O0UuLEIPqkP8C7c8
	 nwV9Y2+0bDO+FEeM740NgmM+n3BswLPSTs8TX+zCUMoZN4cHQ7sf6rTmi8+zU1ZKlvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623935;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IrJfN/Zj/V3kVpXUWyjwdBSz8gY0VMqfiCM9KHu7OJA=;
	b=wpIQHbihWpDIp36u+E+CfEADeU0uT6Gw/q3EtR7O6ZsWPEvHScdNLx2dPc6EEeStf4AQ
	 ZXiL9jOT4pr+1536DuH7c26KPWt61ftA9q4d2YumthskV74/mmwaXdfNoc9ST+zfn80Df
	 Ntp+eDTW/GfZjctSefMzvwJG868ZcnQRrjxRNRZmBY6z38XaRGPELcA3NHoxm8l9yU6RL
	 6nKEeGOatdWDKNt71tHn9Q4TKm3WUurwzk6tTD+ys07mGFcLSZXnQUrsMj3ggYDVRiYZ7
	 BIvFjUeaTo0BdCG8i9n3j5oMcGqEhakb6/kSwEILkxbiO/usXopH0DxrdkkOOwlsRGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjB5UVs8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03416606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjB5UVs8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6681F000C1;
	Wed, 21 Oct 2026 23:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623934;
	bh=IrJfN/Zj/V3kVpXUWyjwdBSz8gY0VMqfiCM9KHu7OJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjB5UVs8NBtrOox3E8hYPdLwzpkWrVjHVujW6lXzLZbw9UhHAdOw+wz6qJ3oyoR15
	 nCPSdOjsaPX3W+vaTqyVuWdyMLPRRclm/3G7SVxVfV4Ok0GiTV1HQJ4dJr/pg8XofE
	 xNy8mlhOnDpZtHr9E1RdyVX7haYRez1JUHat3sAKL3swkqB8f0MjxgnQ/aKJjb9krL
	 xZ9MN1HMr6Dy9hC3l+4JJhxVrVJc8PRiXxdRj4GkJnvCne6U26VCzWcvMbQP5Js1Yw
	 6ZOtG+U8C/MWH8wAeE4md7WnR/cDDsNbzW6ZpYH3mr6mZCrm1Sjm8yU/SaoPBKfX7K
	 64wZqbH8/CAfQ==
Message-ID: <sashiko-outbox-180763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/17] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-14-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 23:05:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In tpebs_stop(), read tpebs_reader_thread into a local variable before
> releasing tpebs_mtx to call pthread_join().
>=20
> Transfer ownership of tpebs_cmd.out to __sample_reader() by passing it as
> the thread argument and setting tpebs_cmd.out =3D -1 in
> evsel__tpebs_open() so tpebs_stop() does not double-close the fd closed
> by perf_session__delete(). Also reset tpebs_cmd.pid =3D 0 and tpebs_cmd.o=
ut =3D -1 and return early if
> start_command() fails in evsel__tpebs_start_perf_record(), as
> start_command() closes the pipe internally and may leave cmd->pid =3D -1
> on error, and join tpebs_reader_thread on error in evsel__tpebs_open()
> if it was already started.
>=20
> Include <pthread.h>, <signal.h>, <stdint.h>, <stdlib.h>, <string.h>, and
> <unistd.h> explicitly.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D13

