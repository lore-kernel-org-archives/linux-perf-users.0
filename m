Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428459;
	b=HHvyc5BGBD1Zpuq8hOzxqKcSk4fI2BphK1lzEilK4kzEUa8Jn3SW4XcTqRwCBmw7hXB/
	 GLr3c2hK/OxGooSV+lv1HnUHAVr9XGqedRci+aFvMcEPYDPF55yK7J1bpIEq3VmY7XEvD
	 XEotpMVXvPXWTdPXgdtMw/FOuvm4V+O8XLA3RT/Nc/TB4YV2aL3hVfnh+6MtFaJnyPU51
	 WKqepad+2ag/RXnZGG43LwCe55sml/Z0htWitwNjJnsfSI8BL9FP39nPtupwKcSORLfUE
	 0BQIwbDAtMg2/V5IL+Js5eY2BA1ZSoksfywmPyE4tKdVnmc9u3oGpDEgSqbyv00f6iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=glvyku9EbAPSCrFwT+F4mEdjlKUc1Cr8eY0i5/h35hw=;
	b=Qghj0kLcl2UWXcdN15dFPM/8kuE2CVHLh0IM8KYl0NZj0qGyw+zdDN9fsh7oh+Lu+b5T
	 IA/Zuf4x82DwrpvXn6fscbyoSUCxqmy/TmLcmCkUQ8ql260Mkk6iLc2so5GGoJCMwuERQ
	 M/h8VfemoONq8araRn3S9tzYwjyNC+fGlE+qvCSIsDxd1AHFlCux1ZGeHt8vbtSeTgtfl
	 467RQCP7MKH6ZrS9MiT5DSfjB3wPl4Y/u4ToyRA4PCo3s+TZ/1Yt+weQ/05v6wukY1b6q
	 ZIbGaCbHb/ralBQPqgPe3i/07NXql2oY12XaX9UsS58wB5msvtivFUBZqJli1BXlEKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khJMhtOH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020C606A320
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khJMhtOH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EF71F000C4;
	Mon, 19 Oct 2026 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428458;
	bh=glvyku9EbAPSCrFwT+F4mEdjlKUc1Cr8eY0i5/h35hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=khJMhtOHlZpZU+FFyV2ZoJSyRbkyA1mueAOOFKbSaEE/g6Boy5ATGwrISBn/WaUVf
	 OGu6BQy+959OxXaA9zmPHI18P85W+3HlhzRTczDNf0WNP0IFjPh3DIDDqAoe54u4lS
	 khaO6e4C+qXwpAKNn8vpPJxEDEUxAJOSqbN4GFk4VWJET64BV7zWDXRczKPqhZ1BEO
	 W4qax8OUDGHjFVFAmuWZ8eyWVnZun/Vq/CeNLFmrReqBGQ4mVRcmbu02Xf/7lcon51
	 FVBfXByVVlh1BSmbI7SmjVRibG+8NcjgcTG9A34xzNPDTAEtGdcTVd1rc/L75962V8
	 s6YEiyLFI8QWg==
Message-ID: <sashiko-outbox-177933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] perf jevents: Add support for NVIDIA Tegra410 C2C
 PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019164241.403644-7-bwicaksono@nvidia.com>
References: <20261019164241.403644-1-bwicaksono@nvidia.com>
 <20261019164241.403644-7-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:47:38 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019164241.4036=
44-1-bwicaksono@nvidia.com?part=3D6

