Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231298;
	b=FwBW7bJnguXDGmJcMX08sqlnVWD5gbw1pjYnsEJQ8vHWsDgJYchhOb+QbWKIHawYtoMl
	 NnpxX3ZzNje8o3wWzycSXUT8jlqycGvSOq9kR0cx2AON6GyfiGJ3zKv0XIRC7tVOtH1V6
	 1NjMnwo5loyVIZZ5Txp3TPF2kIiL7Eyujxmm+yfptRuXSq2sdmnQS3Cear3lqDyC/3jyq
	 ysG69gYK8GyqXrD6zqa5KP/HxQf2CY3t7IYdSLhLGGFLpRGpRm2oaYKlfU0KrjLASgZXa
	 o1okLqyfUorUxHJmKD+U2IR9Dqow/d19Arn0GNNYMEq+SXk41WQj2fwD2cEW90DUXZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231298;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t9c6sAe8GLwCwm1Ng0QHavFTvl3l27gxb6q11Oqh2DA=;
	b=kSAbad6yvkysBvwW4WREhtlQHEsloVyNIqepkIZb8vqVdNCmzTJiCjgFT0xgc4lCmRTx
	 5WsRxlBzMBLNWr+qGnfuZpuVaZRRYPa719/1LYcVM+cPmzubb3bbpcOWrNDh25CbHPPp9
	 cWRn+kxv48h9hi4tXn6hmuDdGZjF5ju9mVQGu1AWsuc0eAbzD/YXh/qJUr9u9cbvr6lC8
	 GF3owVDeiyjeWHdzPNYdxgtfekcr61/5cY0g+mhp+A7OziJcbi8GFlYlRjnm7UEKf97Ma
	 /zjgaYCDpRMqQCKLlVG7ekt2QHpszmcUSfIBW/oSqlphyWYL1x5amgrhMV7uBoXRA+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eH+8TavN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A12606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eH+8TavN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DBE1F01825;
	Wed, 28 Oct 2026 23:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793231297;
	bh=t9c6sAe8GLwCwm1Ng0QHavFTvl3l27gxb6q11Oqh2DA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eH+8TavNobbzKExZwFkaWd6nfTvei2DeC5VJYPbp4D4ydEQEWtNdY1Q8FX2NwnIBF
	 v/HFGydZ5kKZved/Uq6q5PSMoCO7WySwcJOKj1m4jbkjfnwO9gtcaGSzjay2mHKwBu
	 oDEqF6Czjyjv/cNOWgtrJECan6l4mRcGlkEuqBhYr5zi5QG3Bd7uI6qL+w5Uim4jIx
	 XVMGlJyVf7n7jR7RuVb7MBvwJiKQE9fYEYLqs7WtdE9gb5oHfqbfBG5h4lxxxUnFPA
	 NXPEuqJ4s34/kLoMHkcl+XMqEFfjoJvXnDP2mVb3dA4Lyy3p7VVzwYCHMYXTR4PTNn
	 n1RNb1Gm/uBMA==
Message-ID: <sashiko-outbox-188551@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] perf symbols: Point to the symbol name instead
 of embedding it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028-perf-symbol-memory-send-v6-3-7e90415f0101@uber.com>
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
 <20261028-perf-symbol-memory-send-v6-3-7e90415f0101@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 23:48:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> This patch changes the type of the name field in struct symbol from a
> flexible array (char name[]) to a pointer (char *name). It is a
> refactoring and does not change behavior, but it adds 8 bytes to each
> symbol allocation on 64-bit hosts.
>=20
> The next patch creates symbols whose names are read only when they are
> needed. When perf creates such a symbol, it does not know the length of
> the name, so it cannot allocate space for the name after the symbol.
> Perf also cannot allocate a larger symbol after it reads the name,
> because the rb-tree and the callers keep pointers to the symbol. With a
> pointer, perf can allocate the name separately and set the pointer later.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-perf-symbo=
l-memory-send-v6-0-7e90415f0101@uber.com?part=3D3

