Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622348;
	b=gMS3TKCEdkwntfkymQZWKRtYeMl8ri8osskv5DXNQ7wSiEiZ2R97KCi1w6HHajGanwHL
	 EA95vqOGH+blX7ltAhjUKGfZfPTMuYvBhFXvmOTnd0QJ6bifWVzbme0v4OjuzV9taCY+e
	 UK7U6mAfNz5E+NBCtiknWq2TqG/2xlsoaQZR5IRWdfj9Qmpwj42aWgZ5YTYEzoit6WQtN
	 QNPuZARdSSTJzHy3CgjA+d8lvN+YkK9NOggWL5J4N72MeSP2VxMMdd2rzCQZybOXe12Xj
	 CJ3FVxVGtn1B3gWJ8cE8tjdWCgMb+6T0q+3SyJYUFN7NHwT1t11rafcxw6jQ+KMASrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622348;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uJ8ql0mYfRXyPxz98THr1lvlixAT5Szm4S65nfd+C2k=;
	b=W4dY/nFM3PiI1+dq+8mNYeRDuvZJEt+qJzlfLdIuOfXTxYeoAfQvlHF/XImQaFzoK1S5
	 DGVZZy5D+tN4+iSIqna142qKRZUeMCgxYPMbERC3Dp8atckzlQjo4a6uMJ7Og9q40Qwgi
	 AHleJobObgqwy4gf39TPOg+mSEDoQxaZgGS391deGSiCvfM03pysDSHbZi86qU3dg1myR
	 XEF1TfqX/5RPXFDwqCdgx9IbkTYc/uYfgdWv3FGEfV0MM+rtEs+8SG1qCtckXPR56E9dQ
	 jDcOQsJ5qfPIRR5sR2Y8ylpApKEUv4xlqcTD4i40+zurNX8X7QgN/yu1EiQVp+7sdUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdPM+T5d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE789606A31B
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdPM+T5d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB6E1F000C2;
	Wed, 21 Oct 2026 22:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622347;
	bh=uJ8ql0mYfRXyPxz98THr1lvlixAT5Szm4S65nfd+C2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mdPM+T5dFTEG6js0Q6pgYtKxw0n/dmZA813u6b/5ojQh43bPF43vegk8yAedDbuhF
	 cRBHUjoyeLFB9a4SRMCZ3iLs+T6puncYepWmnvUtHjbveOLHLQHKOVHWkllEZ3SwTW
	 xWZ7qgoZNXDaIK5lzGEu/ziV7HWZ/0xZxlmySk80aGyAABoMSemfOkBa4y25yjn7Br
	 FHa2Im5+qo2KG2Qo/2ez4gDff5vd4IbWOtofnVfJAckCXmM4JOA4PnoTTY+TvTH0OR
	 yqdOLJ4MGOJA3NYXi55qguRg+qa/STepmWMdfjw2Ji5+wezPqF/u3jDNOU+90vZu+O
	 FieA9yM1drj9g==
Message-ID: <sashiko-outbox-180725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/12] tools headers UAPI: Sync linux/rtnetlink.h
 with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223555.28372-4-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
 <20261021223555.28372-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:39:07 +0000
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
> To pick up the changes in:
>=20
>   cc17e386f8a5 ("ipv6: add ip6_del_rt_reason()")
>=20
> That just rebuilds perf, silencing this build warning.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/uapi/linux/rtnetlink.h include/uapi/linux/rtnet=
link.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Yuyang Huang <sigefriedhyy@gmail.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223555.2837=
2-1-acme@kernel.org?part=3D3

