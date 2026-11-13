Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606981;
	b=Aq2OH2oru4ZUicGO02nHjHfJrHH4I6hvhx7QlNF4dd2uKcYZod1l0wuSKb6SvMUgA9Vq
	 va9ViruBWVAxCPnTHEpVA8OHhdLuMuN5oCIILcfIENIbjR14eszn7Z/UzroLX8OXKlahb
	 4k5EUwN/F/7rVyk8z1+rpGis7Ey3AHL+d2JCcj8RHdJieMh/lC0nM/g+lqVPN5rxHfmuP
	 +vCeshZpSSjgwgjBbUgJskIl1QsqY5KiFgN9Uyr5SswPC78WhJDlXObCKMo7+VVS93fvw
	 0ZuyRjq71yf260rE9tAv2ntLj3nGpsa6ArwpT1R4r09H/PJfZsEOxvrHDGiJ3PvZKOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606981;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E3xsirfVFzS3oSzZ6rL106woKX30doxbj50lBQEHC5U=;
	b=zPHsrRNzJaOwVkPswnbXYSVIRznt2TcBuLlko9rAmIFoTnX9VqkJHeDgjezPlcXLC/AY
	 oBKsI7Re26+VGhSI6jH2xlR+rqP1h/+ZkDIPvfrAov7sNm+GEZX8hKkYsgDdVyl9SMGW5
	 8lyyBviHH20EhqxQEfTRkxlPgMRujs3AgPZQZThdcnlEh8wnezqa7nolZqNFFvOVUe/Ha
	 3qUU7vc2tU87wkbSUa35nNxeKxTmDolrY6IavpWNuixvjVoksTjMykPMUFG6C5RlYx5es
	 k5Rjjay4wLWSAiAzIIOmsSQdPDMmxHXadf/ZZ3h4E6rwOF0Gb67k3xaLp+cLyMMdbMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiBx2uxU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C47606A335
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiBx2uxU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4FD1F000C4;
	Fri, 13 Nov 2026 21:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606980;
	bh=E3xsirfVFzS3oSzZ6rL106woKX30doxbj50lBQEHC5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aiBx2uxUTvyfxPcTlKwG1ONc+Aq7SLliyCMsXpeNDP3DVTQZlKw2ch6mk5REFnOSB
	 Ru90Wa6MUkcwDjbewUdR1/4Tp+B1v2x99X5PFeEKW7xMo6IfEeBjt380JSStW0cmpY
	 U+fPlDfcd6kXFFgPNzJxwdA/ES+QKCBpszf2BsoMFH0yzHEtubTivRSS2ZUSOaFHom
	 HMrxC8uy/sEB95iEs1HbYgu0yxI5cwRgfRbQUv5duthClr92OouIqwnJY4S9FM98qf
	 /0nHR//NLqMAqCH6TvbTiLtc0lYnSCrWItqOLudBQkF1EddLzCfLOP3XcOMccT6u4x
	 jauzp5FLXN+jQ==
Message-ID: <sashiko-outbox-213748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/26] perf fncache: Use generic hashmap for fncache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-10-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:56:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert fncache in tools/perf/util/fncache.c to
> DECLARE_HASHMAP(fncache_map, char *, bool) and use the type-checked
> hashmap__* wrappers, eliminating the manual long temporary conversion on
> bool lookups.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D9

