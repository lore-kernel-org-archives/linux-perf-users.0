Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138688;
	b=sgxhuapa9hgwlJCWX2FSWMhCZqRueIe7xKoi7t/z0pVp9nmFd1TfGLvH53XcDgkzT0Jr
	 b7dJBXCdx4ySuaKZ9HkUY/S4PdvAXBzWgBEPLmIgQ/w/GWlaDClMaAW2dGXwPUFgffvpN
	 yMQHMA0Q/FIleRTuEUPpf/yXqhrhCLsUFvjvrGInoUiTEi6P0nPO6pwIvGtQgjnfDLYsd
	 P3TSUhhZo7pODFfQx6KPxGmLVAFlXhwHQ3KbYA5BCD40+0/vRaTT0AbQyHj/C1DqGTTrB
	 3U8LSUcSRTJMrQR1ayMGAz0kwLyuQzTWw9x3BKnIGfcUdVZsvOS4Nb3wSzudMeSQRFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138688;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3ly0zrS38P6R8b4GvItucXCSU1ErB/oHmGlKH5m+uDA=;
	b=SrT09rZFPUTIiR9bokpzaK+8sQbaH+Qmo5mcbRkPox6toDNEOKisjbTq2GW7csL5EEcT
	 8uFCO2X2q6oV36uOjx/3X5UNY4StbVWDsFR90Vd0hzAa4sIZdlwIpIfiz88yUnuBHUFe4
	 GKcLT+MWswHVjRj7YSpk6iDQ6zufW3LM5PQ8A50w2cFhHwvqlH0dXoMcMIp3LsZqEz81p
	 0O2o60uS7pDdQ3R0MC/76f8q5rIGVqSUsGn9q6Zn6TArhsqj401ZatnnzfeilFOumBh3O
	 kUPMrkBzz30puoXjoafw4Suyv/IqLVFux+DjceGoqm3XRlPpQ9v+WYw7Mu7iDFL3DXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czsNXN9b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC5606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czsNXN9b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120F01F000C4;
	Fri, 20 Nov 2026 01:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138688;
	bh=3ly0zrS38P6R8b4GvItucXCSU1ErB/oHmGlKH5m+uDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=czsNXN9bQCm337OyQgPc+SE58UhOFyLrz6SVPffl3dSRMkFGAkcw9Nr5swSP3Z4WW
	 CVygxyHCriJqA9TqxFk5FaOW4ssWm9cX/WDdMTvWkFjdJNm3+TDXGhaAJaMFYGNVCn
	 vitkOc7lmZGfSGMWjNRHUbpFhPApJAWTOCoHWZ73uCXW/E3oN+avpO76HyWq9Uw4J0
	 WgYI6AF0giBNngWM3IWAr2TvGjVbkZmjOpyRarMi4+jkuLhDxtlWcPPXlT3Ri9MWoT
	 6bbM3ejMtmmRIPGki4dPgNAJ5/0ZoIXFE2UGu3jfzIn9H5YBdXgeCzfCmn80BG+xth
	 V/dl9OLvyt0FA==
Message-ID: <sashiko-outbox-224326@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/13] perf build: Link the GTK UI with EXTRA_CFLAGS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-2-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:38:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The GTK objects are compiled with EXTRA_CFLAGS but libperf-gtk.so is
> linked with LDFLAGS only, so flags with link-time parts never reach it.
> With -fprofile-instr-generate the profiler runtime is missing at link
> time.  Pass EXTRA_CFLAGS at link time, as the dlfilter rule does.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D1

