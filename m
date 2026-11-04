Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810356;
	b=l5a3shaf4Y9ewkbKVlJMYAjAYO5XEAdO5Cxd7OBTTY/KYJQm+RAICb5G6p3p9nzmOSpp
	 /mrWEigoLfU6Vd6eb77ra8QAfJFGpB7DtUpRMpQDYxOAoUX/xG91N8BScV7GBD896hHjv
	 cYsyjtek7/geoH1i6BQFftCLA7TVPnLw6CXNt9TzKuRc4WmLP5BRGePaRS0ZkAlIw4j82
	 8m+ujFjaVcSW5+hcT03ez80bggv7pf9rFiJoulWriV2Y7uXPzX6uWQMOzlZuO/IYWHasB
	 Y+Z1uLQQvnQLSJAlKLe+hcuNC0dpDVFFDT7d84rq8uCwIWAcE3wu6A1RXXdEtjA+OnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810356;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qvc5V+8qVDvIsaDOpbxeaM0+0lgIiYwp7hzHerAyjuE=;
	b=xOURMnx89oZcwAH5Zgwe61/A3FJqGGZhfCr63pRRZMPgUS880WkgnZ4XKzurj61lGIO9
	 xQ2eXs1Z8S2Vbn56pF7n9dvH5efjgDYkB62rfJLdWLK3+27wN33gcBc7UGHji0rrVaPgq
	 jKouYku45jaLJAs9jOdihFEQJPHwRRwqDLs9aYD6zMc/9ontoes8ESJUgUv4oSq18w+HG
	 rOYKeYttux0O6A79zoAAtXqmaBke0B+LdMXuEZoSbXAg/XNf0PLekAoyh75eBlPxL5F+m
	 mvSea9q4UNFbbRI+gJ8V+SIaupCsWmWOUp3UF0FERqql+/F0lIMUjnrMeVOHfilC8jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAeh4DoM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590E606A32F
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAeh4DoM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF431F0093A;
	Wed,  4 Nov 2026 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810355;
	bh=qvc5V+8qVDvIsaDOpbxeaM0+0lgIiYwp7hzHerAyjuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aAeh4DoMJ73trhZRfux4UXMv53uYvBPeuAg7KmFv5VVZ2XhM4Wili+/7SAb2ypXLO
	 NDdUnHxGIix68kkaRgEqiwlRM2TMMiYdjtLloNPtKGC9JQe5aDB5urdwA6coEH8JNp
	 UX4qwuysvh8l0aQ7x9kd1Vfbaq4YPkhW8xSHzO8pVg6jpfJKiFAu5ADfcoQpRR1GOC
	 0Nq31ubybta63JwqmHBYerTQ51FeRjld9IrVph8YRAfSqdfdDjj7nrMxMco5JhoaEP
	 UsN6VfH9lwpPHLOoIVUf43/E/qUC6EwdMXBDT6mHTq7+lXV8P/Xxa/SdAKes664G6l
	 +6krJIQA/KB4w==
Message-ID: <sashiko-outbox-197636@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] perf jevents: Add support for NVIDIA Tegra410
 C2C PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104160716.2910873-6-bwicaksono@nvidia.com>
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
 <20261104160716.2910873-6-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:39:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 C2C PMU events.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104160716.2910=
873-1-bwicaksono@nvidia.com?part=3D5

