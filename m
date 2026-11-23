Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410834;
	b=DPb7vT4qEKsza/Smhi5ZCgQJdHouRq1lhUvl25X7uC5MOXNayPjhBlu7R37JZi85KWDE
	 D3502n0U16IXXzhTT7dPb97e387wC4r5JkbhWRTHHspMct8aDsJ4Zr6Y7WZW3/DVdMcLz
	 sldT/F/5IjicQ7syEL55SOF6HINDnZAKY1yOBb0NBePGH2mCv3n3PzPzEDCoyI5bNI54+
	 yQfEK3Ur9JbmKWoplIWNCgaE8S5yh3/u4xPIwJ0p8C4xybEg03Np9oPeVf1REfHtsfHPS
	 ovKW0n5R1+DQ3GZLmm6pW2xJgbg9WoCdmMn5wNN5vB6//8vAtGTyqtqkKDwtJCCuY0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410834;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9FmRMS/9pnfb+T7YZQ5j7KlUNWrSEN1X3Y3BfVWshjU=;
	b=aXiVoi1V4KEdUZYUK6z31x/o4RdbFYUMhPIc6R9oUdeY+r1ZlCors54vWKnBhRif3H+X
	 n0IYa4GU2zO11rdaAd9Kb82P7I0h+0+xYrpp4gFrZ22DFzLKzqu0sg8qUodytwckUeDLg
	 jL2A8v8xmklx4pmoBuK9CBYFgfK+GpRJh62W0soQliSeXflTsNkDEji7QaeF5xYYKWR/d
	 X0SCatNJxU/VTAYRWwQzLrhfWLt4ngscvXBiGOz2UBVoaOowoYR8USMA3DsbAG+AJTLMf
	 RkAO737pgTFp/eyATnnoGCzUSJaRT/Q8ETdHs/eUnd8cpj07DVSBMRtQyJIZb3rv8+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzDkNiUG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E7606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzDkNiUG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E311F000C6;
	Mon, 23 Nov 2026 05:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795410833;
	bh=9FmRMS/9pnfb+T7YZQ5j7KlUNWrSEN1X3Y3BfVWshjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CzDkNiUGwesnKkbVYeoERh88AvG/k5vaRINKGaGT1JMpvTm/0WJL8zpO9mKgtosD3
	 volOn4KLlYIjMKYWd4cpjKP7RKxdSGyw/6L4QOocyOLImkmTNlE9CW/Ny15WiTCK4i
	 7ltRd0nrnNEyobAju2ZKRuwTe2jxFYklHzi5pI5h7XGupRx++7f3TlC9T0s1hxvcL9
	 M8qohsaidZ3rulPXsOvy6AToSl7tXwkV9IXxjdEAtShAF8EbIZ7gu+hYz+9UtMbGLx
	 1aNVzbpyUqBHXflio4dZjQLc/fTpJ8+keazEOYQR351JyOwSwih97AiLQepq7D4VLh
	 nt8yvzuegiw5Q==
Message-ID: <sashiko-outbox-228707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Preserve the hardware index field for
 missing branch stacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thaumy Cheng" <thaumy.love@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123050706.18428-1-thaumy.love@gmail.com>
References: <20261123050706.18428-1-thaumy.love@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 05:13:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> PERF_SAMPLE_BRANCH_HW_INDEX selects a branch-stack layout containing a
> hardware index after nr, including when nr is zero. The generic fallback
> for a missing branch stack currently emits only nr, unlike the non-NULL
> stack path and the layout expected by perf's sample parser.
>=20
> Emit an unknown hardware index (-1ULL) when the field is requested and
> account for it when preparing the sample. Events without HW_INDEX and
> samples with a supplied branch stack retain their existing layout.
>=20
> This makes the fallback consistent with the ABI; no reproducer for reachi=
ng
> this fallback with HW_INDEX enabled is claimed here.
>=20
> Signed-off-by: Thaumy Cheng <thaumy.love@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123050706.1842=
8-1-thaumy.love@gmail.com?part=3D1
