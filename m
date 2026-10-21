Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603432;
	b=LC1cgB+VKMuFwhY/cU0zSuF9OOU3WfkD6c5klZ3Vq7z+SgmrBnmK6hdePd6jxdyUClfk
	 WANm6Jmzkl+8OKGgKUk8F2OCYVfLj9R1SsWS+Dmu1I/p4RL3XqwB87YAuxC2Y+krNNqq9
	 N18bHXIgB1fxgULvweip6tGf1dW4q/bq4Hx2v1jYWOXU7Wel6nLW/mdRdYTyo/Hl71Zcj
	 F8J6iSfA1EVed6URIMSUAkrrzR3jphRTbdq3MXXNcE/CglrJiVikU7MiT40d2Lfm1ewpu
	 8S/it5z2IhH5m1s277xverNnvlGe4GDilUeMNj7yg8oZ6YPtFeXUnjvOYMdGcmeaHEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603432;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BrkuvG7cEH6xfRAv978n2jeEhIPwIxNnVUJ/PHdpfkg=;
	b=joE7L2ugEiAGiRxbx1Vpk9rPPFYFFQHy0jf/Vm2jsctEqTCIs/oRULQf8ilHAnn7cmx1
	 VbzS1G1gWVHMB3+W1IJOqan08x/M9QWr9m2/77aL9vtWJ0gXY/PXu4e4RE+eMV2pBSniP
	 3xU1sK9Vu0KzXlseOnEqOVD+iNWPevbON4T3D8CX9z452qrGdgApry3zgrmIyty02/aSa
	 7URvJxPbU+2K6yVy4/6d2kYARaYHn0yTlueJhYP40IX79aw6e1jOF2O207tbtHTDg5emb
	 zmbz+ZX0bAWPIgY6tS0Omm+KUfzFeAr+loAx7l3/bDRwU+G2KBVN2IfhWi096NrArYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWJDw2HG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C43606A329
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWJDw2HG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED7C1F000C1;
	Wed, 21 Oct 2026 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603432;
	bh=BrkuvG7cEH6xfRAv978n2jeEhIPwIxNnVUJ/PHdpfkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IWJDw2HGFSIDwrPV/RTjgITAnMiDRpzTXADyTGwBObpmKUvul9hdm8aCS40oX08wL
	 87U6NV1EM0yNpAjr2CYaBwzMB0r00u6o27CFoELBbp743ajlxpqBEq0menEoNpxcX0
	 p6r+ZScIafc2arblOoEnr3iWldYJ0fNcLkCRfhzZ4BK2sNLqla4m7x7tLmoEXNVe6g
	 CvIEfAMOfY2qhWyMpyU3CKkAmEpkBTZbkBHf3zPzcaj6ivkNmajScSXMYCs8PsITJ4
	 VsesjSATKERYv5tFz4AVcrdCls5Xrf1J0scZz4WtrqCI1IAFS/fSOYE1EDdPOJ2yVK
	 iVmUjwGMUc7yA==
Message-ID: <sashiko-outbox-180521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/17] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-14-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:23:51 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D13

