Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941759;
	b=lUcorBY2oOZwrgq4/sbBiyzdHs4mieS2vKgmfz/y7GbkFlWuggKIUKpq6Ca2cYUjw1fb
	 qd/ex4NV632NDWwfjUIL2/+yD2BlzcfjWCK29rZ9Lq9GjMxI7EMC4FxyQEBFXeJWZY/+f
	 KespSSEV9yoV2PDBUBrIfMMU2dAjawhrjBmKQRHC7tlKfCIsnJgdEBJmWt9WDYMdlbw10
	 i3EDvCMt4ZcUx+z10cxeJZDp/P2syt4Cz6UkUA0zMKCoZYAbv9gSkdvMKwNiY5aksRW0P
	 DYg6yjzgJ71RNwTfWIgWyatf80yEOkjg0O3u0ioCY6vX4sjojxiM0wJ6pvXBB6r8IKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z4PlrjDTmw3S/GQuXGOPvbunY9Rt7LKg/niqlzB5jMo=;
	b=wVljGfDw+QMCXyjm9qc0kauMY01DpixIFUntVF5MH4jyD3kmbb6q1usrwzEPb+GcrcXj
	 a9BntiiOHJcy+iYWCeIVfUUX06k0XdROkCbrMF0bzVa8a3MK4RMWsIl0Ey3vcwYpJFT0e
	 Ttmq0anFTYBH5G+wz/Ekf3jC8PQyakw6GluMrab8qM2HYkICxU1hHjxDvTNe7jSODSsF0
	 YA3Q4OcFk1BNlejXDa/QYD73tTGi1zfsxLxyoFPSWuVP0dCp6fV9XGemZ78EvA2SVBZpz
	 TlAyWaVCpBKqasKolSGWOrnMSn/TWcS94/yraDMmjOHmaJkTkxC0UJgc0Zzu3rzkAMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqijUUw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F37C606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqijUUw4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83581F000C4;
	Tue, 17 Nov 2026 18:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941758;
	bh=Z4PlrjDTmw3S/GQuXGOPvbunY9Rt7LKg/niqlzB5jMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cqijUUw4FTinbafbY2AJ0zLTlrMwWoOGn60i4m6V44boIpty1hXexa6aFmnD6lz1z
	 02BOXKX1gtao2ABprloHxzduJR+q/qjN8/RtcgEsXNe6wRs6iI9UoUfnQjFXRVPDF6
	 BQKZMfCn3wPvwY6KQYtDLsMzxshlpVJQV6JvgtLA+rxF0wOjLDnUgpueebJSH5tagc
	 QKZl2Ck2kccji6DjfN/AKBAWZhSKAmFGf3BAYyPTbCE4w8sol4ExefTem2AzEFM/p5
	 h9B/FxbG/2UL+xu6awqPveNgumHVUmgoDBCjChFathLApzKn48MEBHxeJDk13UP5gM
	 9h1V9ppdBsMLQ==
Message-ID: <sashiko-outbox-219408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 13/23] perf dso: Expand context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-14-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:55:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate struct dsos fields with __guarded_by(&lock), annotate
> dso__data_open and fd_limit in util/dso.c with
> __guarded_by(&dso__data_open_lock), and tighten __dsos__findnew_id() and
> __dsos__addnew_id() from shared to exclusive lock requirements.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D13

