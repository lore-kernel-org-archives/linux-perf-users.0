Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633413;
	b=SRgGv31lzNoplWFjq0iMtACh053CZW/ikU37aH/Y2TEIdINBy/nigYjU/l6EfpPe/PRb
	 EKU9KTIsvoqInkqxnTDTmWDkFvfhrxET5kD/PMu9CUXJKmszgXF1d62nQxPFv1R6Qd0FQ
	 fYnhO924VhLjsAvqLH7QPbSrTPanS36W7T/GADG9jf20t7SVXEo9aZz7mK/gEUh/Ho+7y
	 51yJh3d/KsVU9waxuh5FL448q2WFcopTG8kW3PMDMfqMP3SirQaQ4s5WptO2AwDdz9Zoh
	 UHBHV/MPRDt97oJZKsLA9F68hoaC6ZwuZntQ+95DoLgnjSWz0l3Br1iyaRdFzobDn4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633413;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o2Y2PaTIQsrCuOTyQqqfoj07/A3kBcw1Kx6L2BZpChc=;
	b=AFSoQuK8/r1/CAYOEvOfb/EspP7qspTvHUvoF0KTa4QiKBEcilOpa5QPebgaUJf3/5kD
	 1616tCWlqp3XWtPFlCO0IbNChO4YveaT2chp5S3h8J5qD9s1Py/8lrfa6SUfYrwTo2xDB
	 TpY4/+667ba9XAPz/CUAigj/WrA/JPdXUty0dI9tqztA4k8FgNSJFrVZZ5g1KQ7GAOFOO
	 aX8ZA4M59yM5eU1YrEcsb09Ugctos6DZQ3HQh9y4YgWT1nWqfZlJdSJjs1mKp5/cPYUXY
	 9uKT/0Ft9k4TAhMhfkSV+Bdw2hPbgXsI8XG5B3JojBoKVU3HXqCg/CnZBp+VAaBtiig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgDhBEmA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B26606A323
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgDhBEmA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5831F000C4;
	Sat, 14 Nov 2026 05:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633412;
	bh=o2Y2PaTIQsrCuOTyQqqfoj07/A3kBcw1Kx6L2BZpChc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XgDhBEmAK5T6TiHph+TBpgwEnvOSXS8vLutFpUT45vLgBam43RIFA/PnYowQFK6BQ
	 B2gKQGQgB54X4nJLBdoEPAefSNzfjqjLrhf+DcCYvNqjLAuUbOpLeNkUZT/no6AfHl
	 Z3TjEAuX4uOlbBhkoNXuMbD2tkqIfkU1qlC/B8wQiN/l6KGQ2NrBd9ef/UpH+awu9A
	 rXcS4EYK7MZmjRF49stM7y3Mxr7DnoJUzFlEaBysC68U9ZbJKiiW8A3k6KCJAydmYV
	 fMv6xyZdOzHAwQRq1/q8/4nbvaiFuFRVuHLwB6LvYCUwTGNs6hGwbJBP+mIhkCTpmY
	 TBl8tclnUQq6g==
Message-ID: <sashiko-outbox-214164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] perf symbols: Point to the symbol name instead
 of embedding it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113-perf-symbol-memory-send-v7-2-d992eced9f9c@uber.com>
References: <20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com>
 <20261113-perf-symbol-memory-send-v7-2-d992eced9f9c@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 05:16:52 +0000
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
> This patch changes the name field of struct symbol from a flexible
> array (char name[]) to a pointer (char *name). It does not change
> behavior, but each symbol allocation grows by 8 bytes on 64-bit hosts.
>=20
> The next patch creates symbols whose names are read only when needed.
> perf does not know the length of such a name when it creates the symbol,
> so it cannot allocate the name after the symbol. It cannot reallocate
> the symbol later either, because the rb-tree and the callers hold
> pointers to it. With a pointer, the name is allocated separately and set
> when it is read.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-perf-symbo=
l-memory-send-v7-0-d992eced9f9c@uber.com?part=3D2

