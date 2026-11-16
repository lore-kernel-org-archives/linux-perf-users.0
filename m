Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807866;
	b=P+AJ8qU5is+GbUACtU9/HkkJQ6/Rk0JOYLeVPcGcvukAzoRuvVofKFG0P7Zdd8U6olyZ
	 1mvFABFLIkodJmZakkvJ3owVTxUR+VPPP9zVqiczTvbXcmUWrq5bWPQiZHeSDYdhxKBXB
	 GCVPf7GwDjMm25mi9HFrp5dGFewznrftikt8YQdaBO677YgRlC2/NmxSkbinZCD/zi7Hj
	 3jFw2XTjsIO2NofimteOStaqVCHQ2HSrLNxlv/NAEUSegD/S63Ld1158oezeK7gkh/w/B
	 0H6zUm4vBUq+jAbEsJJXJwitDuZsN57HI/tIL2fiqC7SrjDB+/sa/cKROJZBoyqumOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807866;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Lkw6HoGHqM+mE04aGnqpjH/dr+sQ7LZhOf7OiwoQGr8=;
	b=emKcH8FlZGlLoyMpymBxpmKK3JVAuAeKXZiqyOwWl0/NioflC2b/85aOk1FuU8zDu9sa
	 0nVdYPL2Tli1Z7qGmioNQdTU8Mui6/c4H7LoGHQzg7jLNQMI5pRcE2d57Fz/BOyVZmmT9
	 e41hD9eCMMSW0ZgSU3div2Z3HB8QluU0936BbnzoRlPnRodO896eFmzj1VDyWAY2VL39X
	 0ranUqtAI/DsgXjr48Iem4knz9fpS6lIFctbYN7Pmu+jLlDGHmiDDFHDymspOt4D2BqZ5
	 e4nmIFPlFZJ2pED4YPkaP9RKlAkHqqvgFcNuDjDHod5YJ/I0rKESEoSvGvKnroPCxFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWcD15Cn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729B606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWcD15Cn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF811F000C5;
	Mon, 16 Nov 2026 05:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794807866;
	bh=Lkw6HoGHqM+mE04aGnqpjH/dr+sQ7LZhOf7OiwoQGr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UWcD15CnouW2FYbULHsJQQ74w/2drHPjAEYYTugfPIBHwxlatTmTp7p4X1QGTJeis
	 3PsOSGmHDWj0DK//BcitKKiv+z1kGAJRraKciYxIb7EEa/CX2b1hVwnYRPRrjW17/j
	 bQRQEtsaiyalsnanhPzEkUWjaidzOg1fWkTmD433FDgOy+Ym7SAXT1JiaxQ2Ucfz8p
	 /+3++uP6wOUOxKhWHmqCWgmXwDIASyAfVfl0Zxhm7Voens72WcG69INAu8mArbcmVD
	 aUrTLwBPYK5+twsnqRWTlNtshMJxaoE7N+abEYFlDPnxwbyoI8C5Njq5QD8OT6c4Q6
	 3EUZVbmHdNmVg==
Message-ID: <sashiko-outbox-216224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 03/11] perf/hw_breakpoint: Add
 register_wide_hw_breakpoint_cpuslocked() API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <179480678718.38065.12946617307937403078.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
 <179480678718.38065.12946617307937403078.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 05:44:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add register_wide_hw_breakpoint_cpuslocked() which registers a wide
> hardware breakpoint across all online CPUs while caller holds
> cpus_read_lock(). This allows callers who need to perform additional
> setup under cpus_read_lock() without releasing it to avoid races with
> CPU hotplug and without triggering recursive lockdep warnings.
>=20
> Refactor register_wide_hw_breakpoint() as a wrapper around
> register_wide_hw_breakpoint_cpuslocked().
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179480675130.38065.=
3086970856119381693.stgit@devnote2?part=3D3

