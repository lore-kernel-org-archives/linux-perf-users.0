Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762607;
	b=0cdFOsAoizSycKdKKi0DHtd4vUDPMzQs2tfRaC8LtKRqN6nX/pStMKkS2hmcCB8HoigZ
	 A6d0FD3aU8sn0mQpz+nAG/D/6psB7vqI/d13zlzFzmbUCSTcsU5Qr5tR18UvQe6Op7EjB
	 nSkszA/Hkpao78srfp/t4vPccCZFPCcnRNOGfOL3sxKxDgAzrzYlLYDaUDw3DhuHoym8U
	 TTDZrsosiaAWgv8r5ztMmBZCCvLLMqoUcMmn45PXLR1km7Kf92iOu0Y/1anbfXDlthL7C
	 vFeFkBuzdSswgAgWw4q9ui8MOB3EhQZW5Rc+lrvncF2yEQV975qSKgMPiz1VLO6LJlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762607;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fh9FiKXO4Aj0LZ2i2UCDksaZbxoqlKx9osKQF/j4fqc=;
	b=xmSTKDN2Q81wk7sVFf95WgwBWh5SC9O1UCcX2DLf/2fgaT80XhvrQAms9+FDiTA2aPip
	 TtM8xH+D6/+iUflzn9zTKKtWcs6IF7+IpNYXfu5+XM9g9MKo5kax+lhJEDtLMwed4m4NL
	 lCjSr4V3HuUjqSfsrTtoqhUf1SgQ+yLpiYBLMDl03tMkZYJFRZpiordbFdiU71t2gU8fz
	 5KP9nitELP4Owj5K0ZGK2sdMBIOSC1KXLMji6Z6+3VzGzv1qSqNiVjaf6icxTs5VznH3b
	 wxhPKKf/izEz6zlsSqPa5/tWX0yHf5jXF8DNSXZdOM0MqdJ87Wtetri3HEJ8j1WRPJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMghlFLq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F258606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 03:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMghlFLq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90801F000C1;
	Wed,  4 Nov 2026 03:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793762606;
	bh=Fh9FiKXO4Aj0LZ2i2UCDksaZbxoqlKx9osKQF/j4fqc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MMghlFLqtATYFcOQG7KsHwuPwc2MZ2ek53fnPuyNPEv1MKcW60FBGl0UmXn7qvbl7
	 hCbyjd/d6hH2E713JTjbtUieWOG9i8eNTIvVqllRC0XgHGdqpOXFtBTgB+ndCajrw2
	 JQfccFgDyxP8xqEZHujTblATjNVSnUnX8IBSG28n+j4sXfP31Y1egNWlnVAOJizwT+
	 mBPR73BXk3sAFhYgB/4dKUzswL7/5QkLONf2cjYHEnTFJk0uYC3V9DP7KDqpaRS4yD
	 dMh2Kr8jIAfEOjykfoLmMpSEpjdFW9qgsf3gd50Ie3BZs/cTVEjeSKRst2YlRXQGKr
	 Siq7Xe8aNiTRg==
Message-ID: <sashiko-outbox-196597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 18/41] perf pmu: Add
 perf_pmu__for_each_name_from_config()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-19-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:23:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_pmu__name_from_config() returns the first event alias of a PMU
> whose parsed config matches, ignoring the perf_event_attr type. So a
> legacy hardware event alias can be returned for a raw config of the
> same value, only one of possibly several names is found, and the names
> of legacy events whose aliases were replaced by sysfs or json events of
> the same name can't be found.
>=20
> Add perf_pmu__for_each_name_from_config() that calls a callback for
> each event name of a PMU whose encoding has a given type and config,
> ignoring the extended PMU type of legacy encodings and, for core PMUs,
> also searching the legacy hardware and cache event tables. Make
> perf_pmu__name_from_config() return the first such name for the PMU's
> type.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D18

