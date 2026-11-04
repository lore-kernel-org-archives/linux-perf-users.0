Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793767024;
	b=0PUNalRBMedzzmoV6TvE01yeIweWinnIvc1HN/pksA3w5ix1DijlPQtapjXOp7KanF6C
	 xFhFDJLbcroUYoXu+jO5fboVnxiVci1aTAvQarIPVlCniVhCPAU31oljLOALLmOoB39Zz
	 kZTOz2O3CnP9qC8kFX+LI5w+ctqScgPyFvOnqfrgzLCO2j60wblGYrb1s5s+TqH+Jq/CP
	 bLVeJ8jC+Eee2/JCugJzVr8BiRxSS52pggshRz0lGUWm03XgUg+tud4KgH6AMi81NSIwS
	 5k04JTCPBiXqa8yTMVGKs92eKaMS/ak3J/MY6F1+bWhgv8Iu0zTmQ5du7XXp066+x5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793767024;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eyRcPezUb5d1+mDPGCpnpV4XdpYnDFQ2BUmUOjGqXPY=;
	b=XoIgd5j8Ra8M9sDmvC7Qwf9vUCPTzkkpdosffECsfL1THUxsJ5mfgdrAPKbGKGdiykK1
	 PXLAXhY/IBJx8dnfzILr+2SdRcRt3o6NDcuXlC43kkGrTUm4VpGGTrL9gxamcvLzkW2As
	 gi6fW8/tG5pWpCfOojVgoa6lO26jlu/JM+N+ZUQDO80HBvYlRxi+Nl7kUVTtbq66cLM3a
	 cWDL9yuuc/rdQzVMRK7W4ckWi9VujTQgqovp37c5aFFjU8O1hy8G1bMfZcejK9u5zwIu/
	 To8HgxpQQT/DJPnwErb7+IyYa9JfZUpy4g4O83PL7+fIWiknXVUcnDDkeP2bAfVdBRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnCv68Qb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4333606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnCv68Qb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC341F000C1;
	Wed,  4 Nov 2026 04:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793767023;
	bh=eyRcPezUb5d1+mDPGCpnpV4XdpYnDFQ2BUmUOjGqXPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hnCv68QbOuRGqLca9YDayhN770jcctM25k58P7ZX0/UhsGSLJ3ACiAAjIbGupmLi2
	 jPM6FzyUoDCsbqP5ZEwTSSGH+ipIsiT19u3OmjiT+KvUpGm1OBJx32t0PHHKlxu0mA
	 yWBbdLTcLa7JxOr+M9EVv3Zk+yRQA2rClS3f98Q77NnTpefKWZV84BEISFFSKMfBLS
	 2aXdALScIpUm8UZ5sLgCIA8T5FMgwuiWV58+UkF+Hyjigl/KKFf7CZAXDO4pBwejRg
	 6UK0tQ3Eh6F3LXvFKir+JBLoPVM3Pbsx4+uZXoZeyj5GwT1lCeOodjjYS0LfdfyHlY
	 RecfhymW4MPAQ==
Message-ID: <sashiko-outbox-196657@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] perf build: Add explicitly sequenced -lzstd to
 libbfd feature fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104043006.1199857-3-irogers@google.com>
References: <20261104043006.1199857-1-irogers@google.com>
 <20261104043006.1199857-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 04:37:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Distributions like Fedora ship a statically compiled binutils libbfd
> that depends on zstd to decompress sections (e.g. undefined reference to
> 'ZSTD_decompress').
>=20
> Since libbfd does not reliably distribute a .pc file for pkg-config,
> perf probes manual linker flag combinations in fallback chains (-lbfd
> -ldl -liberty -lz).
>=20
> Extend the testing cascade in tools/perf/Makefile.config to check
> libbfd-liberty-z-zstd and append '-lbfd -lopcodes -liberty -lz -lzstd'
> when detected.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104043006.1199=
857-1-irogers@google.com?part=3D2

