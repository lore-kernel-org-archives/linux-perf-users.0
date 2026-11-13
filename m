Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601586;
	b=LCGg9XrqzuWdMGSM5R0aavyPyKkm4y3+U0PAbczErZBTFRp0LnXCMzJyj2hc2l+ypRQT
	 TaAg6UfKeSN9Oq5rly8pxpiB+N3tgOKHeOqw35LkU8xyAJsb+O7XEwZqRUDqMAQQoUcrB
	 mQiFYumi43cgkHrr92v+K79I6r4Igr+jyUTEPcd6LQ9jZklMu+Cm0ADjkZ46ssdrf8ulk
	 2Vp/Vi/2NCxL165TzaCWutcP0fZHqWXTgmvswx6FApreL7pj+rF05sjniT5irQkFUlATH
	 ZAkaXbFl5MPGPFx6dCDPxGG2vhBPxQCl7lNdXSuPYQh6KdE7ID1rGRVFM1NMppd5E2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601586;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g0neXI4jkgpb+Wc0PkDYGiDlc9zIExrGZ9Z4nLnr3F0=;
	b=C4x+uHHSyHFxP/kBaV5Rv9eONMSARBFlIs1YYa+Xs1rXYpP/uRwHk98a6mW+q62K8yt4
	 13jV4AYQic7jBSankrxhCiGI/rlQyLgudFVxd0UKmUecRMEpEyOKTiM2T2oSxdgRPuv3u
	 oKmb7WE3lgqKGx6IXpxud4V5lpQMFcz5xkW5o9AU/AmfpxgKlj6K2JZbDA6kRUsYtNsPr
	 BoNmWEN5GZGGn5OnwAzO/lVxZ3fcdhKPKpUDdzDKPySNjdvrUeJkk8uLC4RPdpz4xcsKx
	 Q+KMl7n8dzcDASM9LIGmaUz47TJesS90DpjXyvpJX8BVWdQrthCdkSbsUwqvjq40/ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TimLqnVj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5E606A33F
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TimLqnVj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FC81F000C5;
	Fri, 13 Nov 2026 20:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601586;
	bh=g0neXI4jkgpb+Wc0PkDYGiDlc9zIExrGZ9Z4nLnr3F0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TimLqnVjAfTg4BKdME+mwFV2vnChGlCesLs2kQzm0j2WKMjYrbwiANoBf1c5gouvI
	 TJrkz4XWsjBX/r15y4h3D8qPqWSYpO9heqE0ZriM0TPeD4SbkrRBHAHdFRB938myqt
	 AH9oywUCH1npMBNwfIRE/SEVnF6dTmE2K3ZgoSBhiZ0a777UhbY60OeZYp8rbwsyHs
	 oAhoytZF02oHIXG3u6tm+kMJfRQGvbaIln3vnjX1wkjKtfFU/MMT5LbrG1M2FTKWO6
	 cjNKm/XJOTTkADjXLCII2EmnpVNgkcXxY5ZkpDSnSV2MyKxgnB9FBoSczZ0jlc+yuF
	 WO6rSjqxiA5Fg==
Message-ID: <sashiko-outbox-213637@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/11] perf test: Drop samples without an IP in the
 dlfilter test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113200850.2803460-11-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
 <20261113200850.2803460-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:26:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a userspace-only event
> skids into kernel mode, so that kernel register state is not exposed to
> an unprivileged event (166f10836a653dfa "perf/core: Fix kernel register
> info leak via hardware skid").
>=20
> The test dlfilter keeps those samples, and the check that nothing but
> test_loop survives then trips on their lines: the comm column reads
> "perf".  Drop them, which is what the test wants, everything except
> test_loop must be filtered out.
>=20
> Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test=
")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113200850.2803=
460-1-acme@kernel.org?part=3D10

