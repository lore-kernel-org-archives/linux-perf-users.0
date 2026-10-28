Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231237;
	b=CjlaEYGaaOQlVb68i8hToP5Ut7qEG9VMik+Sq4wefDH1ylLVfu4iN7KBSSUUiTyxTLlY
	 CbjYkpMeeEBcDk/GigJeOYmKmtXgLK3g0JyO7DyR4FAWtgpBgSkK79/GvZEOPJGeAbovT
	 OYA+LhD8AMiOF5hb9TY0NaCyix/GjwhxkbX/cm6rCKhnyHxJ/Y+8wiGQtRwdCNvEYBpq3
	 09fH2MH+j4nbIKH/iS6xGaAcjCnLnK71iRGCjo8XgG4Dz/KmQqCKRAkruBauRJLCuwo3T
	 NKxKw4YXl2L8a5RZCaS+ipF4NxAnCtY16ox3kTGNU5kKB8YjS2/Sv+8I5Ka65fdl/hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231237;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lINbE7pTcm8Apw8jyCkLMrQDQ1LBXFF07jzPXdPTs0c=;
	b=QyzRwYq0w80Jw/e/4R9wsjC2EJ+fUKHJMySek5YE62CRSxwNy2ona8h9tw2KkVNKDyv6
	 f1X47soSQLk0pJvXtNXTE7glHbvNi8z8RQ9BH3zoBX92mJxCrf1tKbJAiwomA2YH/SIFD
	 ZiCGYcZSgEFb9yYYlg4JlIeVbHhi51VtTi4scEPtLpnjb/DFM1kyHK06RSsQYJ1hjU2x3
	 9o5KpYEJQBo3B9nwAw3Hu8KTsA9VUCdc1RJGU/5MBcCuklQKLe6P3HXPVdE4sh79rZcXA
	 heSAw8nFnxJAE0dW22hZW/8u9JTWELl0Scw2wNRrGcBs1GaKZbxkE6XtmG8zshIl7ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6TrLj2g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41966606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6TrLj2g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA5F1F01825;
	Wed, 28 Oct 2026 23:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793231236;
	bh=lINbE7pTcm8Apw8jyCkLMrQDQ1LBXFF07jzPXdPTs0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K6TrLj2g+UdbN4zpBTxaVV5FcIe92sZq9yuOorOsauSkyhZM9L415fZbGLBXaQbqv
	 0hvWHsw2PQA7EMUrAFDu4oWs53ZxMgzK/wm+m+RKt3OR6EsLQvvXna6DafgiPThNjJ
	 zkLYZVrkNpInSPiIvpj2YNfGyroEQ49jjQhieQjaxAgaHQIl4M25RcEFkLddUauEmb
	 DpjOHoWGITJkWkTWQB4Ju2QHr3IFq2KWeLxfGFQy/NIx71Nv5/n5hU6INX5PdXLWOA
	 48Edc8O+AiwGIzb2yIhAxAuYG3TaFX1fbfBku+15MiaY4XN1VeXwgA8UQ1rtl5z2cj
	 qpVoIiHOmDIOw==
Message-ID: <sashiko-outbox-188550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] perf symbols: Fix broken ELF_C_READ_MMAP
 fallback guard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028-perf-symbol-memory-send-v6-1-7e90415f0101@uber.com>
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
 <20261028-perf-symbol-memory-send-v6-1-7e90415f0101@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 23:47:16 +0000
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
> Commit 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature
> detection") replaced perf's compile-time feature test with an #ifdef on
> ELF_C_READ_MMAP. ELF_C_READ_MMAP is an Elf_Cmd enumerator rather than a
> preprocessor macro, so the condition is always false and perf silently
> uses ELF_C_READ.
>=20
> Perf already requires a sufficiently recent elfutils version that
> provides ELF_C_READ_MMAP. Use the enumerator directly instead of
> restoring a feature probe or retaining an unreachable fallback.
>=20
> Fixes: 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature detection=
")
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-perf-symbo=
l-memory-send-v6-0-7e90415f0101@uber.com?part=3D1

