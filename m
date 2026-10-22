Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700984;
	b=YPXqELongYXVu2yPkRxlQMtaSpqgfMnRyjuAgvZVnw2KrXq+dnL5jsij7TcFId98Ef5P
	 OfzjAox7plWVNIu5R8xGmbcrcua8mur2LKSPQEmRDcoClaryj6kCsh37+ER32rKZUHukF
	 7N4cWSmYr12tVXDxzh+6YFAW0D+0G0IqpQE8XPtsn31KlG5eXQXxEnCwvmo6BC5EvU4Gh
	 9ItE/RbxXmEJKTW5m9Lw18UZNBlB0/Qn/yzoe6icUSF6hKtFUCXzzWmJS6zOnCT9XDb12
	 /DF2ayxijgnUSNMNGe0+CgBJYd1otgs91Vzi3A6RcG6ZVM0cnGb/jjQXZN/euSmvG/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700984;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=26zBG5qNK8CuzeogzeFPOyxspDCyw7EideT+MtNXuHg=;
	b=V7aCkIfFI0nIYlQ1hdb45FJ/r30qUExwkPv+Ry16oInipsOoEAcWe8/dzQzufJZbVD3+
	 NO+idJ78149udDihBMyj6uQakZX24ILzEypk2D7xjOG1l/pcrvu8cCyUd/iORVmqpYuDu
	 BiygS1drIobL7moltD26nSYatsZ66Fbkjz6psisdXcKPwXIRx54OlI+Nizpu6RJ7PhJSX
	 zCGd2sOVfVwBJp5iKWyHk2okMHsyZuY2fQzZm7YsYAJIuD+0VFRM8GxKXCp6704P3QWI+
	 h4KasGNZGlmVMV8pJdkop4gdSsYWeBZDc56pUVxRznP9If2I8ccmIoaeVWI2LNx3dcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWPESCth;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8D606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWPESCth
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E054A1F01825;
	Thu, 22 Oct 2026 20:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700984;
	bh=26zBG5qNK8CuzeogzeFPOyxspDCyw7EideT+MtNXuHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWPESCthrqD6imW0oJc/WfiAoI7VBkwoVM3CO1dMzU6K3TOpVRkzEBblw4x5UdlNB
	 ihU3Io33gSqrXk08SLnK3P33NG5MfnRhMUbESpmnA+m3+SmEd4+GtaZ3nJtfAdT6Kz
	 b1k0gg8G8/2uQe+M5MvLNVkAegSHxATqgv83vNAGaas6yQ+Y4fR25eshqb6yrYXFzr
	 tCI9Ed558O/gGWmp3tYsBFPAz977yAIiGWDFop0WKbi46DasWs5yS38jLo2lJuF5hp
	 JBzkrn0STXNLcGn7h/ifCvXXqWfbbTVMCHM0JDiGm4TK+3VHveHKyLtBR4meSiDtiT
	 5vaLQsKB+4wmg==
Message-ID: <sashiko-outbox-182006@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/19] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-16-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:29:43 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D15

