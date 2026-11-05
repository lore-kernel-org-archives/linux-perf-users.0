Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883282;
	b=CwPFpKsiLxcmA87YD0v+qrOJx6AbnjpJXGAd+Bkz6/sJ+zu+oxcEpfFue1CQXQn+rJX4
	 c4CRoqDRFOlU8XoumIpp32b0Rj+XBkEa4qLHCiffsP4ElMSqxysdSCti6d/UjigA0OnbP
	 Yb1jxI4zSkMThTAszF/NpKFU2V1LDiij/zKVn9XFAwuPzSPlx2BwsdNxsm21S+vpPcrq0
	 xYqPn6HjpO/leXwqwahExLbAYKt/wHz7GyFrll5Y4ZA6Vcm0kFlGedgGR8qxy7A83/uXH
	 EYJ+N3tOEL9mV87BMZ2HVhOYMLExiwOz+UprNSbGWOpJG4jc+kxr6bjACa7+DtNLDoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883282;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yfp9QSevUKsYsISlJTz/xhFOMKdRCYVj2Afn39nRcRg=;
	b=kmjuOhuEr97uCFu5l3nYLfvTeUBq7/3p/McpKOMyqrVg1a4f+03GB33h3tdeBxox+qer
	 gjC71/EqzMC5rbC3tZNyDWd/vgQESGRTt9L9N86JFr1Y3lPbRwVHjXqo4clxAwt/KXM87
	 rvD2RN52VgjM2cMat9RUqjxZ7fbxHIgjh4EufRL6SMzO2tbwYCmA/m75zWZtFPMveL+0p
	 YiAtRFPc9oHhlzxL0OTCoxrnUdUYYX9EMQyNdW3U473AeI9U70N64FZeUEm45jJiHTv6G
	 fyqc7WoJPAeAovMhDQwfwT46e1FSWcQbxLj21QmvZtvTa5KYeBlshRb2S6bldQfwzwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YCoOlB4L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74991606A328
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YCoOlB4L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70711F000C1;
	Thu,  5 Nov 2026 12:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883282;
	bh=Yfp9QSevUKsYsISlJTz/xhFOMKdRCYVj2Afn39nRcRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCoOlB4LP8Hw1nPfZ3J9ngxZR+vRvg64QEt6H8U5s+/OwEPvG28DxGORqh3e1oq2B
	 pK59OplqnSnqvMAUo3Aies8SYBnQHqoffv+DRzfM0GJ6raH89NgUsEP0wRRGGFODSh
	 e8Y3N8M3hYoA6AADs7fW+jwdu+ipeQRki8gJn0gxMzNacZzyKRQ+ZCSEbTSwENurAe
	 HcubYDcn2fEyqdVxFhZKeoF7k+ksKK9NunSzWczCzlVL6dp4ucbtbOKVgYL7+G2Ye2
	 1bl5Yc2WmYlTSbj5Xn9N33dWyi87BGT/u6VAhjkVGSJTiRAZo2gA+WAb0GhbMgv7SB
	 YbyEe9G0F4cgg==
Message-ID: <sashiko-outbox-199079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/19] perf python: Expose sample instruction length
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-7-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-7-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:54:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Expose perf_sample::insn_len as a read-only insn_len attribute.
>=20
> Trace decoders supply instruction lengths on synthesized samples to
> indicate whether an instruction was executed or not during a call or
> exception. Let scripts read this value directly.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D7

