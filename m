Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602992;
	b=ShlcIv6xpzcOpC1L6jKCZYU1ijRMgaxQoOsqoPmxJeK7L1X5dacUrlr8OhqVyHfkp5Ki
	 J1P3NnMirNzlpmDzUY3GicOZgcQN5fa2BtFmOhTNccx2Q3H31xGy5LRvlM1TUQt1f9vt4
	 kMedabWRlTdlpEte4EyotcFxqNmX1OULGz0uq6TKW1izMGHpetvmPQN6yQneuG0XMmvpp
	 xszqk9rDlhxZNhqsLmDtDCVqcZc07lwbAYUc5JkNUyhg5UcY3/ja9/0PcLtnlkcOJN43K
	 nZRVI/up0ynjZzDQgDtB1rHqdc1OQgJIMdjk6jtdpCA8YqQQdqiEGYqiPFJCpLsvXkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602992;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eUpM2CQMAvCgkIFagBo4bxB+Wj4KnSt4AzQVSw2L38A=;
	b=bPjph51fslOSBD3zDAJpkbAUmNZU9e1D5MVHnaShX9Hmpq45XYHbtw0iOo9WKI1qI2C9
	 h/NXAunvHICzfu/UoQnVNJ+d201iKK88NugBJuInLH12x3wVNcXr1bQxvxbLLMPG+67tU
	 uC2k79qSEhM/7xuVTgDkBZuzHDpylePbTrqtPX9Zhw6dvfnINMO3oYwX3NKGjV290ev1G
	 qEKGRFFUh1C5hy5tPDR6S2bEH90Catf+jsGSLhvQMbCRUx6jbLewmcyI6qPr44uxqnj+Z
	 bainLqB6Tey7dXnXwk9GvT54Vk85CI7Bndx7CHUHtfJ+++JX+EABgf8dhxx8F5X5qaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAa7hZhp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94D606A31B
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAa7hZhp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1281F000C2;
	Wed, 21 Oct 2026 17:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792602992;
	bh=eUpM2CQMAvCgkIFagBo4bxB+Wj4KnSt4AzQVSw2L38A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UAa7hZhp5qjTfj1vl7XIvvW8gsb9UNRtYZqPCYaNV3+ForZx4K1hfx0uSxAyJqXL+
	 DAdgJD20r5FW2PKbGAObjM/O+xZLffcrSwS0gCpskNtQuNe8j6C/qdAOjopFCj0LVp
	 4awMuiBgluE8qXp5f9Gcnxip+Zr43IyOdTncHjKP+ZdZwwpvTk81oNj8kQWAyx4Uqk
	 SV5Z9YUiuopO15Md1lEzQ7xxlZUm+UAPa/0cxYb6N8lFR9sQzzWa/xRR9q6yej1mnr
	 oqZAXX6i7hNkEwQYDofmq2d0r5sGd3BZ4ELjvzYe2UiKtgpvRmLNT3qyPu9mxsbp71
	 M5L6JxI4f+x1g==
Message-ID: <sashiko-outbox-180504@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/17] perf maps: Add context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-18-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:16:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __returns_ctx_lock() to maps__lock(), annotate DECLARE_RC_STRUCT(maps)
> members protected by lock with __guarded_by(&lock), and annotate
> internal maps helpers with __must_hold() and __must_hold_shared().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D17

