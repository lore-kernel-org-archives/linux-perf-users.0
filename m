Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658831;
	b=eGwq2xZReGDDbpna6pD4fGGRtQD/10yfeX8YtjEHjNvUBqpA3PPPAtlZaSRByvkesbFS
	 tZM9tZgGpPWyKjWSLnuIF+YgZxKl5pV2nwY2+o9YLVVyuwpnZ7+2nTvCR88SmT9gEHXok
	 Hkn/IhNtlBOiQFs4p2jYUhDHGr9bEFqI3OvnpmmMnSTSVCSWVLG1r6wH01jTlWEIaMS5c
	 dyVFUA1oSf+MKOzdq9Sn1M5ZyCD6CeZehdpgsOVolP2q5edbNXjdATGmfXayzgvAv1s2H
	 jWNqROR9Y+GdBYFrvSKVdvd9qOiy+blS8iS8Gtov/KbeYP1Mf1v8+hZ/pS7qMHlbpPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658831;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1sa11y4Isu/lq6yJ/Gi+ZzmHn8lDU7GF42BmQC/Y1H0=;
	b=HSUGafLgRiM8GKuIAHKWhdrkGfUBgfk2YAa5q9x+RarlJ1gBxaz7Wm5ST90I+0X0kv1f
	 HHkB7A0YqiOrYvpQH4Eb+I+xARiMWc8jrf1iDDM2A31Wn8sXBcJqGZuk9E3DoVi8P2ipc
	 NFTsP5ZG5dlimiOIaD1LFU6T9dAKq5c7cMfC4Plo+GyYO2Y4Og79E5TdBb2SEC3+FqGaU
	 hFblxK4IJWFGf51iZ2Sv4ja1hvM9qNKLj2zbHO9Vjre3420M89nwliLS4beh7/inWRsBd
	 gepOr0dWvgoOpSv0R40KStlw4x4aOuVWijIsRZObrE3FLF4UGXfev1NLXetuyCIKUGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFt0TGut;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28322606A31E
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 02:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFt0TGut
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376D21F000C0;
	Thu, 26 Nov 2026 02:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658830;
	bh=1sa11y4Isu/lq6yJ/Gi+ZzmHn8lDU7GF42BmQC/Y1H0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mFt0TGutYXvc6VqbZVwbsqS7Lptn0AT1KUTDyA8xONXuLWp/Mx2AIGy1FZ35Pxfqf
	 qUjXkBuOBHTjhhy9uyrnXCXXwEW+4aJZ4PmdBU5cIIJpzbTsi5gn4F7llaXlX8v5BX
	 r/xLv2Nt2uKsW7Ppunh62xFgDXzPSTkunYxv8PFM6sPMPAsggABM2kAvfdjdnmGUjE
	 NxijZymTB1Du8Dwp2ro3XvEMSN7Ay2G6vMTNsdC9ZYS/p+iRL/MSNmSyWy9hHIoG2f
	 IzA/TC8QJ27FK/Sc2jWWC1pdA6RXeDlOaiEkrJ5MIVa163AFgS8m9ZJfTfrBwvzSXj
	 lsOKInh0Oy3YA==
Message-ID: <sashiko-outbox-234608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/19] perf: Always inline the empty perf_lopwr_cb()
 stub
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261125020603.3934222-7-sashal@kernel.org>
References: <20261125020603.3934222-1-sashal@kernel.org>
 <20261125020603.3934222-7-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 02:07:09 +0000
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
- [Low] perf: missing Fixes trailer for perf_lopwr_cb() __always_inline
  fix
--

commit 625a49957e940aaa12897a072cc5c97dba921840
Author: Sasha Levin <sashal@kernel.org>

> perf: Always inline the empty perf_lopwr_cb() stub
>
> perf_lopwr_cb() is called from the noinstr acpi_idle_do_entry(). The
> x86 implementation is __always_inline, but the empty fallback is a
> plain static inline function, which the compiler won't inline into
> noinstr code when building with code coverage instrumentation:
>
>   vmlinux.o: warning: objtool: acpi_idle_do_entry+0x4: call to perf_lopwr=
_cb() leaves .noinstr.text section
>
> Make the stub __always_inline as well.
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

[Severity: Low]
This fixes a noinstr violation on the perf_lopwr_cb() fallback stub.  Should
it include:

  Fixes: 2a606a18cd67 ("ACPI: Add perf low power callback")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125020603.3934=
222-1-sashal@kernel.org?part=3D6
