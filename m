Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675125;
	b=pZEVAr+Je4Z8NOKW9Qn3Z6oZghezJ+rb0Ucl+N87ruIWzbFU7rJYzaqeLyrvBIFCJ2pf
	 Pb1dbaiSPDFYQ3updGBFs4EQnxNw5h4cOeoVQdBqHmJKmJVbYDt4lzP9O91hWi2HqU/oj
	 FALJQhbRiuFLxLwNU7BG6PIapM33xb0c6idNpP/soL0lmglvOleMBE6Xb5GaCsMUzHyni
	 r+mMs27iJ4FJbF7Zwqt4sLE4TY9p3oCs1TX+a1eMp1865eHUYVe7O16EQnNUOuKqJyvQY
	 ya005n+2uCztc5AixSw+YYQXMqmb+w0YU12v9/1rexIJvJlmS/Fm0u/EBb2lrBDLOdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675125;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WZiEJvk/1nak+HPSJPepKCv9TC/OYSS0vDFphCjsmMg=;
	b=CU3jYS5jjkNEfskEbdhUODwJTc2InmC0uaSkvtzRNOqeaBrE/yMUD8PGyQSmkTuFpYD9
	 EnBTVrRupJVslKfdbvMtMOJxeh0DtuwDLh+TawLZQSKN6tjhW9AMJ32LgDAYAPwdYy4BS
	 CpFyWOe4e24b1Jgv1LyI5YYfnH7rWTTj2NvpASDJm6/FdxJ+4cSajgAre2qOiQVjwnIqu
	 V5jHbklNlGO451CfM+uMsRZ3vaw2k48esf9dCK3j0oNgd2+tkbXF00cosMa9tZPoPCOi7
	 9JrKkIQy8S27b1g10eo3u6V2CkESbz1vatudp9bzzw2GtAN7G0kLxql7d6pdY34XosA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5NU8Rxs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A14606D80B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5NU8Rxs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E481F00A02;
	Tue,  3 Nov 2026 03:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793675125;
	bh=WZiEJvk/1nak+HPSJPepKCv9TC/OYSS0vDFphCjsmMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j5NU8RxsUXn5YwrIV9ymf21ZZlORsbAOd3NQR1aTgczVKg7do1Ep/rm3Urh99tma5
	 ASfTthDxyYazevAMbpxxhIGL3hODmNA3hUIAz848ULxMjdMu/mpJR0jEhDpIK4Hqv6
	 4qmYPd2CTHdCNcjRpNc5il3xzN6JFjOe9Q5g1+P9jvHU+W/p286SJ67LXTa+EfbhfY
	 doyvUz7QHj/cNIbpES+0dEEUYGadvBqf/7LcTnkqt6ehrbAlHi1ZMe4O4a6Pls4i7k
	 jVYEL6H//+gRGUWybW7ozVY2s9Fp4mvMDWoLLa3YzVSE4WDg9woj+Q1eCSnSxnRwYS
	 quaEPdWVUQgWA==
Message-ID: <sashiko-outbox-194490@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] alpha/perf: add sysfs format and event
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-alpha-profileme-v4-2-61e00f5e1da8@gmail.com>
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
 <20261102-alpha-profileme-v4-2-61e00f5e1da8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:05:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Alpha PMU registers with no attribute groups, so the perf tool has no
> way to learn the raw config layout, and the PMU's own events can only be
> named as raw hex numbers.
>=20
> Describe the event field in format/event and export aliases for the four
> EV67 event types. mbox-replay has no generic hardware event, and can now
> be named as cpu/mbox-replay/.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-alpha-prof=
ileme-v4-0-61e00f5e1da8@gmail.com?part=3D2

