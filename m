Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446302;
	b=I2dOK+PNT4yTppOjB+jcUczIqu+2ASFgGzRBTGGTHHftzubVstTyf0D4/Utyn/zlDT9B
	 ap6wEC3qEhb7t2woDkYdykVURt1sjFkf/DBkx535ispX/pXr2i5uyBCV/ucA6l/4dZgeI
	 /9s4wQh4iFdVR49UhhU2X+Hn2rDpm9NCKYa2W+UQ8YfgwD6FnUZUe/PoltDKBfpSvlNZm
	 09PWNGrrV3V63LH/w054aD75CC5pAhSD21feaNDAz8ZZw+yCzhApLNPR9YrbQrFrKjgck
	 IMxJ/XIS/XYaXwJl12wUBJOib0lsLVi7w/dBXGoB/tll9vpWxbWaOt5SLgI0JinYSTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446302;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SRnv8MJIUuNavF7OudGEkjKFbakY+t6YKdBW0VPIMf0=;
	b=I47uGPVCI296+heNyHYIhucAXy81C2KbJRVGN788IdBX4AuDs+1SS9Q2G5RdzwkLnaWu
	 iPehCoPD2meA7MZL7wHuxt77abFJmCHnXYfWW5L+O0vkeUUMyn7qq0C4nv6Pu3ubu7mG7
	 KXb2+vRR/zjL9seEL2hOhww6UN1SfFH4tWvGp6H3iuwOuIwr+R7iO3NK7OOfqZLcwG9x4
	 Iul1ts19vtGHBhIUHoEPQrpK0gTJCYWdkNaUsVW/MQpIaEtZDU1WNrEBnLUy8QDUe9qeh
	 HQaAskUSnWVOBwT0ebWK54yA2YYBX/jXCutyaUbFNDvXRSlbYuRO5Ies1DXul8qswHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDgUhaC6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698B606A335
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDgUhaC6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043221F00A10;
	Thu, 12 Nov 2026 01:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446302;
	bh=SRnv8MJIUuNavF7OudGEkjKFbakY+t6YKdBW0VPIMf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gDgUhaC66P209/CQIryUR3bQqxHKZOlBy80XOFlhihviz0TAShCi2CQIqDV5dAfES
	 2fBjYxEeX8j9uuN/ud0REidPuSNGdhGZ7fVLmOVFrXkCtAEV3I8H74mblA6OvO9HLS
	 P7NUaDVzIqfj60H4KCmdo8accPPgii0rVqM6bFchF/6JYq8yso+9B5YUTLBx3U+9kJ
	 n5OROQeQpOM8sO1A3KAQ7g8ZpPArS7e8lOR0D8Z0F8HM5ZwExnJIB/uwOHvKrprSeu
	 ArwfeLjyryn3/it/5kcdPFSxYD1E30cKY3jZn9t7I15ML75QQGW8/Wf2DKzT20lsjU
	 hC1tGmPn+vo2g==
Message-ID: <sashiko-outbox-210057@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] tools build: Fix version-ge3 and version-lt3 for
 <3-part versions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112011514.4032822-2-irogers@google.com>
References: <20261022204627.1813821-1-irogers@google.com>
 <20261112011514.4032822-1-irogers@google.com>
 <20261112011514.4032822-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:18:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> version-ge3 and version-lt3 concatenate their two arguments as
> "$(1).$(2)" and parse fields $1..$6 with awk -F'.'. When $(1) is empty
> or has fewer than three dot-separated components (for example GCC's
> 1- or 2-part -dumpversion output), fields $4..$6 shift across the
> boundary between $(1) and $(2). In particular, calling version-lt3 with
> an empty $(1) against "14.0.0" evaluates 0 < 0 and returns 0 (false).
>=20
> Pass $(1) and $(2) as separate awk variables and split each into its own
> array so missing components default to 0 without shifting fields across
> arguments.
>=20
> Fixes: a9b451509565 ("tools build: Add 3-component logical version compar=
ators")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112011514.4032=
822-1-irogers@google.com?part=3D1

