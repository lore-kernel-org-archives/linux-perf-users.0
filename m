Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941759;
	b=sp6Sze8+i27hteaKik1hHCC1G1RlQEhJi7ShOgQ9YJxa2y+bzsgj7gEzygURiQI8LQ3P
	 PxpobQEny3u5W5dqPMOdm06ooU11n1TkwYckgCDnMQUNfkkgeeROfaCajCgF8tk6t85O+
	 Kil4aOzm5hfKyg6+CFO18Ag+ohgfH9kGUapN3corB5SpsUEplGTwZ5bgT0THtCqArfn4M
	 MpvM6P01u6ZkT6Ow1UfecjkRhH8pMh45hHGoI/07jxAtLKAQLL1AzNVee5UqeWfNPYvJj
	 mWFFLSgIf4pgsOSKGsRA7cv+ENPWeCgOy19HSD3Mn3UegViY9mEI7ylpaYvX38OcrHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fWfejtDAmx5sRMzXxjUejFxFp4jM4Dx9e2T6lmugaII=;
	b=KosCOOFlAvm8iNdk/wpixNEBiaEFBf695ZmeVzgh6m0Nf87EdIHbhseKIA8dZt5ONwUW
	 W1AvWHgf8lAbijdezNcNceCOQjLVfQtUtkFB/2Fkcl1ulmClyl9hWR2FoqpdwYwNm563U
	 oq0xBEh4FQceP0PMb9brlwgEj+m9D06zVcrzWyZM8szFta5v8DJYK1vyR+GOfWYrxeogY
	 UGdDivSdlDCPricUsOP035lEC8zPlyFgWy6yL3y3P54Z/wGpCAgMG7Uo99Mg4vI4v3VEC
	 wvUCCrPsqoYtN4XMLlKMz9zPYWbMSs0PQRRadco1/ENJ2rdoeTGiTmG/g6E8arEEwnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ol+DHv9G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC42606A332
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ol+DHv9G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8821F0089F;
	Fri,  6 Nov 2026 05:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941759;
	bh=fWfejtDAmx5sRMzXxjUejFxFp4jM4Dx9e2T6lmugaII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ol+DHv9GOQcOm1np6BOvH/nW3QirDWG/5lRUD+6GGtC/2ZQBOpDWB/mPps3pga+BA
	 P/PJd7PmevU4wv2g+g1n6+SgnUsHkF/pxav6l+xzA1FsqOhFdm3Im2t2p0eI2wRotu
	 G6w2YZ3G1KlGAKwEAHmXYXkPq9TWUZuwI25bJFvuOdwMHLkzSNCA0aaAcLXRWB/7hJ
	 hTdeG2ADBzABo5aFzd//+YQ01qTGSAKI9vEkmZmuP0mdlWqYj8eQVXqUmTXobJsQOF
	 Qy2xCnrMENaCOsenytT8OYJBSFBJn94XnGTPqfqgaek8C8HvnHiJuILDUcuRK1Qf2K
	 oYWKVZtqT6/Yg==
Message-ID: <sashiko-outbox-200799@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/14] alpha/perf: report the ProfileMe window count
 as the sample weight
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-10-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-10-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:09:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> What PCTR1 counted during the ProfileMe window, the inum retire delay for
> cycles:p or the window length for instructions:p, is only available in
> the PERF_SAMPLE_RAW data.
>=20
> Report it in var1_dw of the sample weight, which the weight and
> local_weight sort keys read. It is 20 bits, so it fits. As Alpha is
> little-endian, this is also the right value for plain PERF_SAMPLE_WEIGHT,
> which is what perf record -W asks for. Samples that fall back to the
> interrupted PC get no weight, as it belongs to a different instruction.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D10

