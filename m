Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400676;
	b=MzCqjccRg6W4txYG6EbK9uDFTNHSJfatPfrTQcsx958pujt+SwOB+mVA/Qjt6/BNckKj
	 o6f1B2mXt4sMVuRTIpaLrIn+8TI4pVj/4nGNwI8E28xdaZkOk3QBFCw4hQxUX5QHtxjxo
	 iEhFATf3jTGHpjquIQtKk5P0/EfsVG5Qz6WEnidg+IKSjNop7Uycw2KLdHOGCxLemptL7
	 /EGzAMWVLCLPSuvs9OoW92dAsPKC6gKTYct3Zruccixz2+eYK6gcQ6fqrYtj/Um4f9Hcs
	 FKWiZrXlnkCmUc+gazlSZaG+l7CiPHxl3Kgi3GmF3/le1qn94/KS2ppWjq+9mJUvDtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400676;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1vDRNs1VSyc0GL0iLYpd/agydn0dkuyzsUB+Hv/8+as=;
	b=Wmm19tP4UE6cNvd/uJX1i1iQ2keg0Uyx8E5+A50zBs7Bikz91eMWka0lO7QRQF/SLhBf
	 1FeGDKWmA2IHteTyK2dAocTEFGm55nKvoE99IiMv8fcvhSpGQm28zhVRd0O7NE4dJOGMc
	 y7RP8Vph6Fd2VqPaGYGICva/C2LdhJlx6j9KhthzM0p1T+QDe7tkqau4x9ruwEhaqbVbl
	 t8BYRK10aC+W+5f72g1PYeypXjOrNWzZmk7/7OnvnnqH/eXN86GvVXlBnhWqXzRsJ1+aK
	 xIvno2kbHnNvRi+IBV4xUhVFIU4cnvMJRug70QvH3CwD78E9aNHGXM5SJNTY1p916LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muiiWkVV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8E606A332
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muiiWkVV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8969A1F00A07;
	Wed, 11 Nov 2026 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794400675;
	bh=1vDRNs1VSyc0GL0iLYpd/agydn0dkuyzsUB+Hv/8+as=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=muiiWkVV0388ZHa1uG4h4OkePa/zcHSAXj0Fk/KnWXfe7yM/I76/hmdtACtdtSgkO
	 TGURVS81Q4sVi8uvc0EEQjUU8Tts+DysQVmlOkx7Ont6bave51GEQH3+98s24VBR1P
	 nqp3+gFVi14oT+qqqbDQxafRVT4bx3WWbabDPv9hn/qFyYmcJjFF7KV1s3lb9+evss
	 rPNiuXU/2cdYPDzTj3nsE4KJ+nJUXipnguyvbaV9PqlmrTzWX6X+QwE2TbcP4GZo2z
	 Vs1cwod4XYmT4XaWIZxETPGwOj1H73ACHX+CQ/2mcx1hy7Pw+nn85u0jj4LUXzXBvX
	 8/tryOrOV6WsQ==
Message-ID: <sashiko-outbox-208988@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: starfive: Fix potential per-CPU memory leak on
 probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <liguangshuo@mail.sdu.edu.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111-e5624093d6-perf-starfive@mail.sdu.edu.cn>
References: <20261111-e5624093d6-perf-starfive@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:37:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The per-CPU hardware events remain allocated when a later probe step
> fails, although the device-managed PMU structure is released.
>=20
> Allocate the events with devm_alloc_percpu() so failed probing releases
> them after the interrupt handlers have been removed.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: c2b24812f7bc ("perf: starfive: Add StarLink PMU support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-e5624093d6=
-perf-starfive@mail.sdu.edu.cn?part=3D1

