Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020598;
	b=HQFcETreJ8bRYDQC6z4KN4fbKMnfsq4T4QFimS8vbUM1jf7eGlUAEyihLbGVxwN50eUV
	 HSP5w07oau+e88jLGOfGx4s+c1bzlChRp2oAicseKWLE0k0iAuTyye95weq5ruNmH+sod
	 lGJ7n40jbw0wnpI7+4AH6N1WGnEhp5ZmQFTWjF0udISUk0FuZX1JIrw8rEUw0zxWdtCQD
	 jZCFsgVNLNlX5MF4tZ1kLcoN8KNf+MDmzElpCbMlrdWXnKjuHlGpD8mXPKH+AFttsmykb
	 sFKUZImkx9EAxVzA7LJb6xexawdXIoo13u7HTuV5UUxNBz0KNOPBNgKmdFKDyUIJ5AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6bvCF52WVgtcmDTyMaFQJuXIFuNsWYngMBIvYVrqUjQ=;
	b=j4lEV6DEqDb6gy6SsFUMxh9NfgvsqqS2TlcI9GDcWp5riFtN2Ottl1+l220H+mSXu742
	 xzCsTql4FbKICyImKzyE8ucRi81bl+rDbKCpOcxnUuyYmig1u8Dhjxs/AynL9Bc7pCwnw
	 t3JhH4v0en2FRwgs4iD1UPJI7hVA8CB23bWMUXjkExlhze4puEt3qaraYwhBfXc0JiAWc
	 a7UbUO4e6fS/0AT9yOoT1IUWriKMb24OjY7PXeLMkWr8590pucWbFX2H9IgBqDh1io6dD
	 Ws66MsrU8HxluVQpQFOojP+EmmZgeyzMt8likr0xT7/t2jTZipi01bhk6g9AwTQ08aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTJhFRaD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025F606A336
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RTJhFRaD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662C11F000C5;
	Wed, 18 Nov 2026 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020597;
	bh=6bvCF52WVgtcmDTyMaFQJuXIFuNsWYngMBIvYVrqUjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RTJhFRaDW35zQusVfsZSL3TWRtls7BSbSf/OPKbtKQ9ORMmkhkPTcQc9wFvfJLjpT
	 aA7N1k/54NaUzF96JhyOmoqklJmdsra02p5eeFRsLnwm8lZP+CcRGY2KfZZBcNlKf7
	 DJ8Bc4r2I2k9W/E1JLbBbdh9eacTsPMo6vByLsC5qCRQx2nMqOYr6fUZGBc07lDPDl
	 5tpKKWTDRQRcFG2mrTgMS88KuUJ2/4Mfza4mVO0w0biG8gvJOvFXonSFwPtrcoH0k0
	 UDcM4mO6a30ojxzNyzrO56yoSsi5Tjp6LgAS3dmhxJevDsqeOq6FXhKMA3iMd5531Q
	 HAcJqNbh2of5Q==
Message-ID: <sashiko-outbox-221561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 32/34] perf test cs-etm: Test trace is ordered with
 context switch records
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-32-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-32-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:49:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Enable timestamps in the context switch attribution test and add an
> additional check that decoded samples are output in order with context
> switch events.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D32

