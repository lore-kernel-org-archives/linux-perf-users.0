Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910652;
	b=SM9wDwN5pUV/iLdiV7S5C0Xv222LbtEpx2eKzZj2RDoRqeBriWX/fyKlx3pjKzelgeQP
	 RVTM2r3nIqo2Zq/QFMVWRuDP+ZmrbH0Jyyw6a0dfMvvRdTMMktDqGTSWTDIWQ2yiaRu8X
	 LFp1WeoREOiSarHeqNvwZDr/pvv8xallCYHy4hBWomD7hbIXKDgw9TzfoLzA5zofQNCwb
	 GgHR47wKThv2GXtE6WhyLVnzb4RkW6IayR41NoXfhMWAcEK6hRGnDYMOS/FiGCbCIEkjo
	 BXaaKnnMglI4WMA9KFK9R2589B5jaXZj/r+wA3BL3KquuLLOZz57RZI9A+arG6ESl8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910652;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fW/jxv6Eh4GnLpjXrkbgyJhRWSYHYT6laM/ZEaVr6hc=;
	b=gEWjqQJr57P1Qpxach2vbrP5+p3kiLmla/EU+7r9T+20aKWqkpNOBid5gFTE3yBw3GQY
	 HqfbKjbV3en/z/VbRdMEEgwo748yQ41ozJKnQ3xv4qh85CbNFtvK2CK29G0kvdPwEdzQm
	 eeTMJQLSf0Q+31Brm8qE4u0QUWZK1Gx/x5HfA/2GU2BcmyorCB9tWrAAc3yD8zQ+n4pKh
	 gpTAqJQTpCrYFSAC/GMLcn3Y7OUv68x8i776FaUL3d5aFbJ9qu+uWF4vRQsBDR6vB7xo0
	 CayMsgD4oKREri//4ijFagrBJOkjIVpb7w3IqGlAd5ZcHtRtKkkRYG1kRo4Ow3cX6aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+5cQGf4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B9606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+5cQGf4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E4B1F01825;
	Sun, 25 Oct 2026 06:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792910651;
	bh=fW/jxv6Eh4GnLpjXrkbgyJhRWSYHYT6laM/ZEaVr6hc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H+5cQGf4nDVLREZ4IR68P+L1XfWnlK0t5ClYX19Q1ZbiHv0Kr5ynvNhA3Y6W70oVi
	 TgkwUiCp3nsa7LQ/sZ/WQp/U9TGBRaS0m+rz1iLruJvQEygiZims7g4BIWx4BIVTGd
	 DN69oFaPcLhdK3P0WXGiGlnGlKXd0oQCO5J1dWiXkr/jxw0ELzQFutExM0USnZl4OB
	 O/vTyvBBkUKosPC6DhLDY+LK1DT8IedQH9bXIjTvXlyw/RW1f6u4wCRqyImjGwfhsr
	 QCqZNq490sedeecNF2JiCDjf987lD7ScUGbYpe10aJK71tGc4QAmNGXTxsfFuMOa9I
	 avnRFf2ackZcA==
Message-ID: <sashiko-outbox-184097@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] coresight: syscfg: Match feature capabilities
 separately from device class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <6fd94860b3c13c0ddc1a5184d5d9331edc27d9f0.1792907333.git.aaupov@fb.com>
References: <20261012230527.750567-1-aaupov@fb.com>
 <cover.1792907332.git.aaupov@fb.com>
 <6fd94860b3c13c0ddc1a5184d5d9331edc27d9f0.1792907333.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 06:44:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A feature loads on a device when the two share any match flag. That works
> for device classes, where a feature wants any one of them, but not for
> capabilities a device may or may not have: a feature that sets a class
> and a capability would still load on a device of that class without the
> capability.
>=20
> Split the match flags into CS_CFG_MATCH_CLASS_MASK for device classes and
> CS_CFG_MATCH_CAP_MASK for capabilities. A feature now loads on a device
> that shares one of its classes and has all of its capabilities. Check
> this once in cscfg_load_feat_csdev(), which both the feature and the
> device registration paths call. No capability flags are defined yet, so
> matching is unchanged.
>=20
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792907332.gi=
t.aaupov@fb.com?part=3D3

