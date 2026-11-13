Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589876;
	b=LmwC4eOVcNMG/AjasVNT9V+AbfX4V4RNCj5oAEJrDdebpYD15bn6YHr8nt1i1IcNNVZU
	 NEvuL7qrIfY3uzMrSfviHgsIxUhMy7++K3tLKXpsQW/cWVZsz7B27CGnlMXiRZxskbf93
	 kS/5v67U2rtPWyfz45SJFKPW3Bb1+7MQeMa2QDixGBqpIn4gynrReb6XIIly3Zg6xqVru
	 d8PKEZw0hHD+iOIhiJrWs1DwXXe9U11PVOeczcXfawY+5gt7RkmCV2F+d1R09SvmBL2Uc
	 5GPElvUQIl/tjgsRkZP7tqDnmU/wLt/M3PFmiLVyfp3qEcEq/cFowANFlF6WZJgO7Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cSMXc3Q5cMadaOl8Ke2dDEh7hpdLyXFw9iv8Ajpx0mg=;
	b=GBIn/EjmI1aDjwosDsbZz6/dndEI3eBNlX20josquT+mX3mVwzO9kRSnSfJ9nGUHzOgT
	 8Fj5Z8G+2/qO7fv0MMax3zTDcMALhs/9XqUhf5Fd5YS6ldnAW1iv9qEUHxh8TDqRaG+tu
	 zBx7kPc3lpAF9lxkqdSgKqQ96YldoB6FJDC2WrHhZN+IyZ9ogMHhB9vC7rZAxYEjTBJJd
	 RixHw44b4sBnvMiDjfL9RnGy1vyyBN69jcPKOy37peUfHbX6Kh7dP0CgbCMSTgsioTN7x
	 JU+OYCGYwQR0it/s4s6rPvqONXGmaw+zKJQK7UTGIKabPryw9iBAIyk2AcIY9JnIXtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eetY4uFC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA55B606A334
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eetY4uFC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FB91F000C4;
	Fri, 13 Nov 2026 17:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589876;
	bh=cSMXc3Q5cMadaOl8Ke2dDEh7hpdLyXFw9iv8Ajpx0mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eetY4uFCBlvrG6Z19hGfRg1h5D9H1wsUrj2nPc2sLHiT+Ato8jP47weq5mEaacT4f
	 VZI01pi7bxLCcDLUXLOrZhB8o2VA7bVkKpe2JzLeMCeHCp4pJ9RK2hRo/OCGc6HvvW
	 WlpVTYMn9doqOpf8/TfjNjbVKjFbe0iDxXj6zK/VlZ7SgU8BuPCTRYKFir0MQEVHrj
	 M/cKOFIIG/alo4Tiduf34QOHfMyp5IZFNl7pmBTfKTT5wUL+1zIk47DmHbIM+SwM+7
	 Ndu+MiL3m0fTLLRJQHxB0BfwspZdBd1OoXkLAZ5Z9u3RreD+3i2ZBoHbA9K4Gg/MkJ
	 nGlijKacF7S5A==
Message-ID: <sashiko-outbox-213283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 18/21] perf env: Add __guarded_by and __must_hold
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-19-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:11:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __guarded_by(), __must_hold(), and __must_hold_shared() annotations
> to the bpf_progs and cgroups trees and helpers in struct perf_env.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D18

