Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036888;
	b=HolBifhOvrKi3a1vb9tGEEXkQnSe1wgJrBcyoE9GsdLJtY8WfV5TSLzcorwVTM1hYcQ0
	 Spzwo0pWmk5bW3YAApNJN6Vm5zWm+TelkgBfXTHfemiwRnI+R+PJ/1wYYI491a/MwKvST
	 2n/Q7AY9EWvGwHM8I0gbLF5NIfgtP254ZMqVetU7D70TTLDV9Y260/40DOlPCAbeW85rG
	 8iLUN80BxvpnE57tMmuf9gT4WsUmZO/Eo931vuZrmhaoKBCEyUrdQ7kMkyn1E03slvHkd
	 Yu3fsGvXcq0CXO2QUhoN32v2m9x9ja2/z7ybDaTpLt8yc+nBWwJtMqbrerLgKmZ42gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036888;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pw2Rm8QdBEEMd4luBgOH3I35eY9+3FXTOmFlxk8k5wA=;
	b=MEW7nQWdlgWT8PIn4uxMzeMmadrQbpefNRR87cNdcPmWJY9Z2pexn4SVASBjLgKtPQoc
	 7nTTMhEIClwtIEZ782gudMxTfFB/f8QMXFFu6XySI4EbZuWzB1FXDZYudFBNmkTN+h8EW
	 ow9SKVVmJyBDbPGcr3jbk24aqkV1ocaQ7wQstSwL6S5c0V8liFK4XMpLfZ44GfbScRHVS
	 kTGQ5D1fhfpQUCAuPAvEhVxOJtHKBw7JdwhBxzeq4ecwcR48cvLyJF9D8T0UyMD3ozmSg
	 yNdA0uoJDGw8ZeyJck0RDr1AQfFnx03MnOcgwy5wRiXd6mgbV9tDpCt8gX+OsWffchA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbXlszwc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDA1606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbXlszwc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513021F01825;
	Mon, 26 Oct 2026 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793036887;
	bh=pw2Rm8QdBEEMd4luBgOH3I35eY9+3FXTOmFlxk8k5wA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MbXlszwc0BlmoA7sHpl5ceZrw4SDh0+Sr/KLLt3YpuWWx99NzdKj9bUHx+iRI1pUo
	 jCLaaMU44/SbpyWTqjIM0CAgKatfw/eeVZeYjmj4SOrh9dgJ+1/3xo6rv0uO9FU/i7
	 XucaM1e0v0BOovE7/fY6pUqk5v6ix3qlVzpgIEsEmcuo/8cYCkAxdgklWeFya28Poq
	 7MTm5BxzPsu/HsYCqZmJ561SdlxI6xgMp3ABpi1DmCu1KFMEytFIGLzv4Ze/MZGN+j
	 S839y/lQADbYYOIyBnBGkA9KdgvmiVASin93ET7acHVZDjwpVMY/wHNphK3NO/vEYM
	 lChx/8aMLRTNA==
Message-ID: <sashiko-outbox-185589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf print_insn: Include sys/types.h for ssize_t
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBFUkZPUk1BTkNFIEVWRU5UUyBTVUJTWVNURU0=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261026174535.3157580-1-florian.fainelli@broadcom.com>
References: <20261026174535.3157580-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 17:48:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> print_insn.h declares fprintf_insn_asm() with an ssize_t return type but
> does not include the header defining that type. This causes builds where
> stdio.h does not provide ssize_t to fail when compiling util/print_insn.c:
>=20
>   util/print_insn.h:21:1: error: unknown type name 'ssize_t'
>=20
> Include sys/types.h so the header provides its own dependency for ssize_t.
>=20
> Fixes: 218c200f677d ("perf script: Consolidate capstone print functions")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026174535.3157=
580-1-florian.fainelli@broadcom.com?part=3D1

