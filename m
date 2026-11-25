Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630586;
	b=F/hvC8AVTnYktW8DsUFvmHvvBJhWlRYFpTNkhKw/SoUXRqZigBM4pU12ORgjqgfDA9AN
	 bqt4SK+WElYIyHxbZ6OHiQKQ1cPaIlBkSRbj1B28KwP/PcCgSEUx954Av/sXIMLMJMlBf
	 W5fr0Qb9INFJrqjaMdht6PSPGAKzYX/4VRVdax7l+BFX13TENXeOSUE7TZt5GFJRDl0yr
	 wcat1T3845+9vfNrl8xpey7CFndKqCDwN2o9BtcKL4oR5bOPGXwhz1OTA/8Wm9mxHH8h0
	 5pqHSVFXl1mxAm2kYgPIFKMJOaXwjsRSmxoIfNkxQwRsQGTi5aDcpVGaOhdf2AYt+dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630586;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AF7ldFYpcoL0CmuiW26qd7sTCbMfcaiviPbK44orlfM=;
	b=LqCEkqWvn1QM9p1ZC+OSBoTGkVx4rFcLBQ16GrIngcKGTyPkTGFgRuamzEKOAKRs3dp8
	 ADn5I8LmM1gJUaUgTsqZjNKJKac3LgwIwTrTEU7AUL1Zf/FqGFmkx9tXRa+hES5IAnaO4
	 BLvpF6lsAeQaeX6gBpc2dAr4ZcPJ7+IYbQjvDPMkWRD26Y/RfhzZsaLCRU/d7JKIHiwfj
	 heynAa20ukdeefHJAuu82b+t1Zo0ZSrkzRo/FFFsetE8GWw3AakNVatKch9IvPhhFxSXg
	 IBj8m+XHC1u+rEuYtUzSnFmcwxzMbBV2mO8OxebhSB0zIH6XPtDT6XVfINx18/nNZGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cw3Ar2Si;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85F606A681
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cw3Ar2Si
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581071F000C6;
	Wed, 25 Nov 2026 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630586;
	bh=AF7ldFYpcoL0CmuiW26qd7sTCbMfcaiviPbK44orlfM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cw3Ar2SiNnjLqp0zl6xK7NMVaanGuUShzDrAnTQoEpk4eSF83o5ljcuWNu+26zTL6
	 nnqI0PMaXnRKm9z1fL7AF/kFPkGX8ueeIWjZbfgRJXeJZVVSlpli37hOOhTDPN7PdQ
	 ndvoibDNlZbmQuuZViKlVWXtwqkWBw1F6rA/MARJTKxPuOwqOSN/C26nSPXvMxx+Fl
	 tB0f/JpAF/7pE3ogzKxs7iEF/yOMxC/GCJZHEQ7pN8lAW9DACrDzFI36HqoEetBFrx
	 CRqahXSG3kxRRnDnVUu2RNcsUuy5HeSCnlzajy5ot2oZ6hxJC8Ravx4Xy/2n3cX46V
	 qeQUWZEI3In4A==
Message-ID: <sashiko-outbox-233945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf tools: Sync the x86 cpufeatures header
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261125180912.2388197-1-takano32@gmail.com>
References: <20261125180912.2388197-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:16:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125180912.2388=
197-1-takano32@gmail.com
