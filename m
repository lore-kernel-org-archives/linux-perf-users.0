Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828162;
	b=2lt/RY4Ivngh9edNBVWsoDkKL41s0yemOddD2XMzOAqgwpQqBQ/OW1SS5XeNqF5D9NNP
	 Rohl7a/C7Wo0ouoEhwVcFIURQaef+pKlJpqtlNldqdBPPruzviYQLJExG09dqFh4OtMaB
	 MoYtJUdGUE6YFxi8zVQ8czsahgL21U38ApOU7nT90zzqmuG8ywOn+rPb7sGsXOzYvjke/
	 ElzOra6ehPgEKyga59YBFPSi98T73n6A3I6OeiqCl0aDOsZ+tcnkJaTk0TL0gNU1YF/ZR
	 oMD4JgCGwbYd5xUMzLmChNELQneRe8De0y4urtvGRG9hDaYntemoHlX0w4Dz8MIEbrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828162;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AQkbf7qHBEpAa3A6oLeFT3Tw6R7wak1dxm4FNLuhiBs=;
	b=1Q2GvzidqsTI2VuFMl4EC3LDk3X6ccmh0KQtC0G6P9EQcIKNE1+OVhnvntqhRn79CSyS
	 q7cp0m6QUyBOz9LS0ccLPFB97jbGO1ECJp2MUSpZJ3zkwh3OgYcq96wgGJzWmq9s5vi5N
	 cHtErDTGnKCwyBIQkUXX3MGAO8h7z0cDUS8hDADVrIzif9U2p3dT2U1jYnC46AFiMlHkL
	 mOONTU27+SD7Lm7BddRuiVSRikSNYSbeu3BL9lyDFwUoGEU1/CZ2cHImaPWEPsE2FWncZ
	 3WOUq8bhkNY5/1/Fi1kCAAfV1StwROVmuyaW+pdUAZ8vljDUNjpS7eUTmX2PMTej1pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwkcLv+N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2BE606BA3A
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwkcLv+N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3FB1F00919;
	Wed,  4 Nov 2026 21:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793828161;
	bh=AQkbf7qHBEpAa3A6oLeFT3Tw6R7wak1dxm4FNLuhiBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dwkcLv+NByTTPKVMDgC/fykQuitd/r0x5HdPbhJ+KkqjqYzAG+AznlK2QKRFIqtoj
	 WeA8w4WRAxlNhYBGl2cO3Xj+BQSDr9ri8IMePsZoGDTiAnp2lRi4hB9JikAbY35Si5
	 pVbp8rk5US0LCxj/qJLmx9CjNMnRF/FRYNP6S0svldXn3giprw5fcYjN+9KefCn//5
	 DaQswk0V2qGGVFNRWsy0PjovKQgHdcN5fFNGKsd4Zd5xThGJElB5fYYGCHOYIsM4jF
	 yZ5gw4Ufh0nA64rcDfzsFe/tihhViXWc+6WeR7Huys0ylRbTj3P7+XtTe0SY0gPb+g
	 oJ75encLt8hPQ==
Message-ID: <sashiko-outbox-198122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 15/19] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-16-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:36:01 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D15

