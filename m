Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851936;
	b=i09WSvX+7oregUV5dj7ZnCns7uyAiWANlVMnBRlR/DM1BujXYgkYu6Hdp7I28GWdMb3q
	 JoO/pXzXXvqhV9a7rIkQADxZnjuEi3lA/BSFwJls0nTckhT4yyKfXTuGatew+1c/W8km8
	 BqmBV+Copwiu4mP3/KdPVdLZOdRpBO0dcfrxPG2FcLwB+LJ9HjKhaKEaD/4fXgVnSlWF3
	 CFvqAvhtVcxT5/R0IfvTt9YcIeHjtHXsLNjYV5cqpFueJhUAZkjMeLC3m8ukDu8zAVWzI
	 ueg4zUYZ2IDC+SMAFz2MsW3K14RKzK3mnD6uivA0314potDO9f+OghRTGvCaobENEEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851936;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JbjwXAFxG7phGqFYk5IDAkV8wLvlitNaxbEqAPvhcKE=;
	b=TdOYig8BiUBhla6l/VM9hDi1LccvuAoZD7xPbGYuqz8DyIueNKEWRm1oNGOPc+gBMeif
	 Su9FSv9wWmZwZLH/dpNEusFwMw2aXu8oS7V29yXc9URosEkc4V8hCNlqesrW7vAkxH9+g
	 8uzk+R7TTl9vkuIjsniQMUd78AdakEVY80Imffx517VY3OrEZxpksEIACbw9Mo9V3K9++
	 VQvOdQ5BG2p21f1QYQ21kMgNLdjI/s1Fk1WbKR93I3Ee294T9dZN7jr/OvQnYF0JqPDuf
	 SqhIIuEXvyazUWoZBJlEVCMo8khYBJUg5Sb2PbQUAfNv17KrB1vWpZZwfJvCNtNtsGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNNGJBEe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475B606A888
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNNGJBEe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774271F000CC;
	Mon, 16 Nov 2026 17:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851936;
	bh=JbjwXAFxG7phGqFYk5IDAkV8wLvlitNaxbEqAPvhcKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eNNGJBEeQSFa9vu8cHfjQRJTKgzqfg5PCoLziuC8eHPpcvBSwmbHD/84GEjLccmPj
	 FpMMvcJlwBr4jvEtUJeZBfVcMhEl09+FZb/LkuZmvoZSMdb+gvwfveuSndSmJKXDdQ
	 chSGZixDvkA3PsjpDngVrIqcFXR16oc+rc5fL4KsYCnfYJi01rVKCZm2SsUsRmJWbo
	 K6De9Bog1lmlzzpYKvO766DBb5UXXJkOUOdJJc38BADBRzc8MUrLCE7NPo+u2b/DNa
	 QOq2eoJAx9CZp9l37M4kM+IFD5Fs47w+/ugVh1CLGBcySrPmHtZmA21FpLHSzxM+WJ
	 AjDqEfiZOiA8g==
Message-ID: <sashiko-outbox-217471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] MIPS: perf: Add SB1 userspace callchain
 unwinding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <f.fainelli@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBFUkZPUk1BTkNFIEVWRU5UUyBTVUJTWVNURU0=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261116173843.911523-3-f.fainelli@gmail.com>
References: <20261116173843.911523-1-f.fainelli@gmail.com>
 <20261116173843.911523-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:58:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Restore the userspace callchain capability formerly available through
> MIPS OProfile, exposing it through perf for SB1 and SB1A. Commit
> 5f307491f3a0 ("MIPS: oprofile: Add callgraph support") introduced an
> in-kernel userspace prologue scanner, which disappeared with the removal
> of MIPS OProfile support in e258958945c6 ("arch: mips: Remove CONFIG_OPRO=
FILE
> support"). The MIPS perf userspace callchain hook remained unimplemented.
>=20
> Follow the former OProfile approach of examining instructions before the
> sampled PC to find standard MIPS stack adjustments and saved return
> addresses. Bound each scan to 128 instructions, use nofault user reads,
> validate frame data and stack progress, and stop at the perf stack limit.
> Handle o32, n32 and n64 address widths and the actual sw/sd return-address
> slot widths, rather than relying on the kernel's unsigned long size.
> Allow the sampled leaf to use the live return-address register, and permit
> repeated return PCs when the stack advances so recursion is not truncated.
> [ ... ]
> types retain their existing userspace callchain behavior. Nonstandard
> prologues, dynamic stack adjustments and signal trampolines can truncate
> chains.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116173843.9115=
23-1-f.fainelli@gmail.com?part=3D2

