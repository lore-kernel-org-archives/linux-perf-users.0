Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430284;
	b=xfP6tnCzPGKaYlcphzAQ+ICpUmaeWEFTJf898oS439awcnNwWCQMMhFpZNCFe2Ydqc4E
	 mBzcPT0aX4eQwn+c6hriHbai/SwrJYPbdK1r8ITqNgRRXXG7zlRYCLZQb3hdSt2vSg/l3
	 egc3eJmxfoKyQQsGGl5oZiwKi5pCtOTPlabDsL9wC7n4QgiBIm2PCC2zP8ohBwOUCDMu0
	 1wya9TsLva5RmJPLWGV7omsQgOuvjYqdP9yhoxhfjTspDvHxTsAAQ8BPiBU8cpn1iY1Hd
	 9wX6gGeiXzJmNBZhdZtDP4EiYO5cRuNgXWsv6bSX4gdPAp0En2u4QxlAzcGQJibqG3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430284;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c9RztIF5vJvDoEXa1VXw1DX+dA76WCBA8QBCqFLpDfg=;
	b=hyJWmszpKwbrZ9mM8VEtb85zzrEZpe3b8HMUr5m/YcbRTvS5d+rXLZ/I3WITSURqaSwi
	 YpTrKgrJT5gOlS6pZhhHvjIdIzC2dy8+wG9uT5Wh4Dx9ImZzB4iT01sQyf8YGwtJ1P8oi
	 uEA8avU8YJKyQR4z7tsqn/0ekfGW+DXZrxiy6Zp570GBwWqAiU1CkdYQK83dl5hzii/Ny
	 OKL0flncQJnCEHMg4TCFJsNT+oF1PXiomGB3sdjIDBAVHDsAZ3ydOHmsNpk08FTrQswD4
	 hHW4k6+BxQq0LmMSCIexOhMSLtNRBB/t1hpeQNKbUVL4MMZ5GYRX1e5YDaNwzu0dgTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3a3wNHt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457B606A326
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3a3wNHt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB68F1F00A05;
	Wed, 11 Nov 2026 20:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794430284;
	bh=c9RztIF5vJvDoEXa1VXw1DX+dA76WCBA8QBCqFLpDfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L3a3wNHtxwWhV6RMmZ61mmQ3jNYCbeTR3P11SPMQA5KW7h9h5pVNtHGpE81ljw6x4
	 HmljEcAPsrPMROdaYBWU1tNVYsjahMjliIf4vNkYTw9g5DZWdedS8lm9B5rpI8w0T5
	 lzVSuz5sJjPB9TWSdOqTj5XP+I8w0Gj9PBGldz7NbChRRCbcygRul63W2w8mr6d1ad
	 UKibxphz2VKhBQ4JkOjg2B0e4bXmjtBb644+Gi38LS77ka5j0I3xc+8/IVZ9TtroDu
	 xVKQpiCWmkkcHzQMDJ69MHHPog2GLzkdTyvggl/6xZ9CV9kBqi21Bx+he3n6AB/7te
	 33gDMDwK6tt7w==
Message-ID: <sashiko-outbox-209682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 16/20] perf intel-tpebs: Use DEFINE_MUTEX for
 tpebs_mtx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-17-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:51:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace tpebs_mtx_get() and its pthread_once() initialization helper
> tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
> control_fd and ack_fd.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D16

