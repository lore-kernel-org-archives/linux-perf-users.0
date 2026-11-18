Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021034;
	b=KvCAmnklX0ntPPjp6Z3noGdmtUvBPq2dJbJRLfOhxXOL01M0x0ZfY+vErgBmYBdwf08K
	 V5q069+GnoE1nbfV2pgd5r2X1pqxhSluzwX+IkvKCf83kMij7Pcnimx/Cy35oNU/zTbO4
	 XmOmLzzssPDCduQRDMVwxt7y+I+4J8JoGrgEpjx5nedY2Srbl1crjNOh0+LELtZBmiAfo
	 5djMMX4wwNaIVDWBzW97QGc9x7j8RM2S0gQrAtjnfFFW5WX9eSxc6ogttKKVgbzD5IOcF
	 vOZ5KP0P6a+TV3M3aqSwMWKxVlLyuVNkSOFQQYsaghshCzCNvaGNbT3XGCKP28E77xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021034;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aRRKXVkEiltbIICAdjePzT3n2UcBtWPh5qtz/y2k8Oc=;
	b=nNVjBnC+zVvXz8dZ7CsMOw5IY3EBq3WCwNsGfUgDFeXPivL1PzkXt+U0FaLhR61Vm3CS
	 IcHZnod9QQo8K58Wzee08/Wbzj9wp29JULlrQz4cBf/xl1CCD/IkdIY8fKytmz8OEsSBf
	 J2u53lbcK8PUY1BWKMhCDZunEES6GbwW2yzDn9+AiWgfviyhnSVTMDadALCPiuYdTSe4O
	 9soMOby7fdBkZ7Kg762uK8cSTT1D3Gt7HQvFPgnXs8o6qdBLFNTcMRdA4zANx6FldmAVt
	 5UCQYBwHnAzWDJkO1OYCCeosfRlBw59gRuR4zvRneYM58jj3oYvH/n83B8QQOOR1hFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQoSthIf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E9A606A32F
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQoSthIf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C74E1F000C5;
	Wed, 18 Nov 2026 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795021034;
	bh=aRRKXVkEiltbIICAdjePzT3n2UcBtWPh5qtz/y2k8Oc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KQoSthIfqBOm+bBV2ewmlpTOxHPlGWOxZf+bd+rX2YzY2DOw9KogQzksBN0Jl9sFe
	 V23jLCWTZmWN6cNFtEFmHsbPepZWz3Ln/foNRVilWvXH+Qph0XQYugoqY4R62AJWmC
	 mZQ5lYwci7AJoqprMnB8UBo1CmtGBSSw+q1qD+a3rmp9aSOy2X8H6PQ+pMbIKq50Ea
	 6jcJB/sB3E1zMiUBBpbT9muCDtEIgSAeG/ZN0HieEXkXVBXMxhNFPmiS0WvGV5k4q3
	 pJSjrQDgIJbcBHg3PUUtpvIyV2Y+eVBS9f2KQ47cUQsN25sG1Y44k08x2tErdNyO/P
	 lQK0ZhGAqxJ5g==
Message-ID: <sashiko-outbox-221571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 33/34] perf test cs-etm: Test decoding of kernel modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-33-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-33-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:57:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> If kernel symbols are available, test that recording the kernel results
> in etm4_enable* and etm4_disable* symbols. Use these symbols because
> they will always be present when using trace.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D33

