Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603113;
	b=D/OM5dCYTlgF5Mmyzn5BxP5i8l2gqdsaxuMfwPAl5PpeZ/Qa906oEN7xwaWNb3dsPtHs
	 5r8k6sUTmVM5Ob34qtUMYoSR8njYzcpWlX9HimlpyvXug8GgP2e37YrvKVZ3MM19+jjXR
	 M2j3IvTDh7oYbER7VyS5Vza9OXL6MDAY0JPOUJ1YjHqWtNlWiz8LsDEbTMN9zCgpEArm3
	 tPUoIRUshcOW56bFnuMrb9/Wc9ytXtpR68net4gEl0UNJzmqOoyR9kRst1Iqjsg+nNMFG
	 Rxnm42MIcFXRqWEhpEGblINa31WpkUr9v9/9yyibeGyJi/cTKBDctUU7yjTJCmQyAcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603113;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OwGzx8sOenSdTu6zc4B0FEsrMFT2BjArVrLupqyRL0I=;
	b=ROzkzWbZo95JGbRwH5h1rGBnFcfmf7OJNBYVjlQoVhRyjmuxrriuHm7I6vMq7PStLNvl
	 +Tbi/QNux1n5lIIKFQAmUnEBiO0cCkugDRzZUoCz3dSyTcXwFIv0FPt/SA2u18WtXjqQH
	 oUP/np5hzs7uMQyxCHw2LiOs3RYbghPv7V1TC6o0zHBpUn//ZKZVQVQntR28nn/33Q7M5
	 /Gxw8A3nUqfGt8HOLfYeR8dNEkOb0X2DQLHqpy1hK27MKzTL72j6Tt1FRJ+2SfMTwH9/L
	 1SkrULydxbAEqGVECXeVeRJn3KwlQGH7gfhC5amMENxumrvxOynWBBXdpFLmLBWdzYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQax3TxN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826D606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQax3TxN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF431F000C2;
	Wed, 21 Oct 2026 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603112;
	bh=OwGzx8sOenSdTu6zc4B0FEsrMFT2BjArVrLupqyRL0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RQax3TxNFepe8pF4zEISNFtP3BB39sE4Qrnypc+7wqnCau5k3JltllPlWZdqCuhJ7
	 PJo2WCuyJbxNeirtDb7LaVfNQANO4qWodMcLUSBT33EoixuYVSjQYL8Bng7T43Gn1n
	 hCcZhFdxLmvx1r/Po7aLymBMBw1Lgw/M21KwKYHd+STMBJAGMPLFPeH5tZf33bqIFp
	 ZIsoZovsrFDMTkUS8ohCGPG5NHzYkUL4fchvy8wrh5LHdXzwR2Cxj2BEM1Yk3W6X72
	 MS2fUNDm0APNd6RM3vxYRvKGl2hML0Qd5o9k4LvoLBahG7wqA5HzrN/yDiVtu5y0BU
	 HhfmWHSnIqGMA==
Message-ID: <sashiko-outbox-180510@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/17] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-4-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:18:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace the no-op stub tools/include/linux/compiler-context-analysis.h
> with the full kernel implementation from
> include/linux/compiler-context-analysis.h and add it to
> tools/perf/check-headers.sh so future changes are tracked.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D3

