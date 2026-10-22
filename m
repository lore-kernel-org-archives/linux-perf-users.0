Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635311;
	b=zAHdkSXMeCfmQmfp4DjLpVTTdAnlVqNZ3R/MSUDj7LMjDynHIUMTSCGfS8Dvj4BzW08u
	 aXSMeeKxT2OAIDW/bHSdCXzu+Yu2k2iqU3TKtbpefLyugaxcRnEt8kdrRPkVeMrvP3Axv
	 7RIgJSmoVxTjaFYewTCpyoeszhacM4hLDXJA/b5Xas4CfaSG5ZdPVXyZAF2TfKDWy1nTa
	 npuXqAPUzEfxN41a9E3JaH+cz1yuTwRLogHzntiCmHzD2gcRfTLc6D5MUVwhyZ+NZ1S5A
	 W3Y+ROsvGWnN8eHqOhSM8xAX4ttzSIs/UL8ulsLEbyyfq6RmixMSH5LZDFfH1LahO/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635311;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+QZSiUEYn0W4pnIl93mx13ch2e9Wbsv7HlE1Ei2zCpQ=;
	b=dDOpmqh5Z30UX05W8iffNyIW0t9vhpRn4ozZizZ8HiB2bbAPn/GLaiDlhRk8y3meY4v6
	 LBD2szfMp7A8YxI66Yi1OVTDJ/2+kp39BRjHnZCejycJDx+imHBCgeRBUuaIjYBi9Mo14
	 WNFmrBa1ZiLZk29INV4OwWotsVojr5VL0cIOeW1P1GUwWsmSL8UVFvYEXymK5KYTnY/TL
	 p+dnRCDOgZ3oYfiMdnvt/zNk4z3L7hHg3nC4FBOxmVgR9DQ7NQ0jobkH9AYP4+J78qSj5
	 LM81rtdSDRzXvQTnTK+qEzIXw/5kkmtLlOZ4zGQZA43Uoqopd9nqUuqo/Rah2KXRI4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsQAbmr6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F6606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsQAbmr6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BC41F000C1;
	Thu, 22 Oct 2026 02:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792635311;
	bh=+QZSiUEYn0W4pnIl93mx13ch2e9Wbsv7HlE1Ei2zCpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NsQAbmr6U9+ZMsV+bDg4Re/+urEgxxX/gYMHvv6ZlKDHgoo0NLYkxPCMx/afo3Xfv
	 bZou9/0IJbmmmqbP64/UuxpfRq1Asjx/a136h/QX5JTfx0XdSJFQR0TPMBNyQ+MW+o
	 d4jEcCY/YWq37HsLoLXmf1fxKNck2V3yogocFixpNrlnaxUaI0jXFc7YVMSWm5Ytbg
	 s5pENPot8Lf8N+0GGkG8KiyhLkHpIDGQCc7p5j6xGRqRrHiwpbbG8BxC5HjBg1QXPG
	 KsK4mnx/km6JK5xvEEFye35bR3zbFhTV2HXGj0ib7tvmBydzYelIIvtBzeXn12zOPs
	 ylD25l95tkYBQ==
Message-ID: <sashiko-outbox-180861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 6/9] uprobes: Don't sleep on mmap_lock with
 dup_mmap_sem held in dup_mmap()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022015712.1297331-7-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:15:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alexei Starovoitov <ast@kernel.org>
>=20
> dup_mm() takes dup_mmap_sem for reading and then dup_mmap() sleeps on
> mmap_lock of the parent. When another thread keeps that mmap_lock busy
> register_for_each_vma() waits for the reader, and every other fork() in
> the system waits for the writer. The parent doesn't have to map the file:
>=20
>   A thread 1:  mmap(MAP_POPULATE) -> mmap_read_lock(A)
>   A thread 2:  fork() -> percpu_down_read(&dup_mmap_sem),
>                mmap_write_lock_killable(A) sleeps
>   tracer:      percpu_down_write(&dup_mmap_sem) sleeps
>   others:      fork() -> percpu_down_read(&dup_mmap_sem) sleeps
>=20
> dup_mmap() needs both locks. Don't sleep on one of them while holding
> the other. Sleep on mmap_lock and trylock dup_mmap_sem. If that fails sle=
ep
> [ ... ]
>  perf_event, 4 uprobes   419 (424)   0.10 (0.44)       632   11.4
>=20
> During detach: 265-293 -> 0.19-0.37.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022015712.1297=
331-1-alexei.starovoitov@gmail.com?part=3D6

