Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048767;
	b=JH8QoVG7a/EsH3Uwleq0PJR7HTwvMJqvsaEUjoR6upFM4+UI5ZulIFvZvLbIRXOmM1Zt
	 qhHAkfcAyLzvrBwiO9s3ZJYDOcd0UYR/HbB3bKaUKdxtGkPe8pw4XvE0gmmfWQ33almPA
	 P+kJN67RpbV3ohx7sC22UKXP0bRzxN6LHATBOyW5iEymPzUXDhj/kPH71Um2UfD1UT3+j
	 2qtbCOXraVTEfl8MYAmvEc0hND+TkIbCaB55qBvgmpH7D3bdAgrHeHeP6HSQ71vKzhHNF
	 GjDICy2fwgGoCFljw4E8lr2OCrKWxS+85aSYgCrbVj49qW+m5jSSNwiEX+WLt26s/Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048767;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y79oFr8rmB3MR/3d6triZ3K4jDU/iJAWj31YsuLljvY=;
	b=ITQ5BhjyJc6Xu+cJLhSHFhawnCWEUPuT/Lh02t+CzLbf6Ja1fL3xi1NNEU+MUPFp08VC
	 m+4futnvaq81/Etpsaph7FQQiC5Jx7RBtubVTPXxdKcl+PT/XTrNKXRffDyfFpFsL8co6
	 eb0TCnojy5xFPLyB6whM8d9wfOGGNrklQne+VlyNxd059I/Co/Z/qX4480RpY7fIBtM/v
	 VncWMQSucQ/HFZGYcyj6P0scdBU1JqYmNfM2xCatiA82E7BO6N/j2n9OFX2xfNe3VvIlu
	 QjL9VSb0zcNcjmbZumYRXKiorJf7UQpxtme+bIuHJ5laRCG6UtpN6vppPJsiErccWcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDYeenIj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1120606A326
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDYeenIj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7621D1F008A1;
	Sat,  7 Nov 2026 10:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048766;
	bh=y79oFr8rmB3MR/3d6triZ3K4jDU/iJAWj31YsuLljvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MDYeenIjnz3SLlfxB+y7aEwsr5yzNJvESJIm3s/WNw9OLi4iybVwoP7Y+fVxP1dwC
	 MKjiEB7Z5eZ4XK3KjqYXqnPZAZnWU9tBtnv/7ObPyE4moT3i9rC0LCGVAKjhvGScpl
	 NMTswD9zox8ZQ0VVOAz8+rVSb/Fyw/TscPpasNmNKyeYYH06QiJWWsio0k4wV+W1Tc
	 gGXhlSnz9ylNkOK5EFx+FkUTDKgEWMIYhkOr05Vv56RAl9+vRQ5BzDKg7BIynV1xa/
	 rJ/TrkDNn2Cc+mqvU5ZljOT2NBcs2hZkHZqPsdEvs5pILq5wZYBcZ3Bxc4Bb37c/sj
	 AXzZYdAR1kB5Q==
Message-ID: <sashiko-outbox-202823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/15] drivers/perf: apple_m1: Use macros for
 per-implementation init functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-5-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-5-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:52:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Myria Sarvay <myrialsarvay@gmail.com>
>=20
> 6 generations of apple silicon, with at least 2 init functions for each
> lead to at least 12 init functions. Template them with macros to save
> boilterplate code.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D5

