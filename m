Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509868;
	b=W+vsePADpg77ZXWlYV5VJAOeNbIqHOKm+H8xh1LMwMI5f6uoYK6XTFiXeFDNsPqA3nQK
	 D2muIKEO5T0avvlRhG1QP28Ee+49rCkdHUO7kAZynRqWwd7R5xjT3/X3UX4JdkJReLloo
	 ebgWcTS4Baz8+mU2ueU0mr2t8tXspGepCSlhU4LJZbh/jb4BUB3K6/IcvY1izKPgrq4mY
	 /RmlE625reg1j1m6hRMGdH50kpcqjgAaL+AoDRWxIZ8vHz2fwCIUs0kU3XdY922MCAzbA
	 Ec77li8GWsbMdmAdPELWc9NQE3k4sMvquxFwhefq7xCzDoLUF6WvzCCj1qHVogR9/Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509868;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r6gSs9wzzO5u+qhn3UXNLhvcIscMNWpO6IIuva7G7h0=;
	b=mNBHOO+WXxvZJc9phJfw3ME6uZW29pHd+DX0Q7ofP4G85IrRjyq0XFPSnFbLxBkoX/cx
	 8HTSHP4DL104Y3b12awdlrh0Hm6XrWHAtemi1dVcBi3AMvNFVsOsMAz6JBs2OekV7dBxj
	 BMyBmnUwMA8c25ZxoLXUE0w8bHbP7OQUcx0kafzxa9dsRAFgpoaHA/7Z+eWH3SgrtFC0/
	 HIJP0njif3syCAwLpo8nt27Pin4qS7cO0S/YKIyTeP37fsH0r+unevWbbWheV+uPBEpbV
	 /GKyR+wXLThDekX2uO1MsTOLWcBozGhbh+rY4d7mUn+sPZVZxXj9HRijdrmtdpIQWpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsgQko4R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE2B606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsgQko4R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110B21F000C4;
	Tue, 20 Oct 2026 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792509868;
	bh=r6gSs9wzzO5u+qhn3UXNLhvcIscMNWpO6IIuva7G7h0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JsgQko4RXFdjBz5MZCyu+DR4D5+wg+T7mwQvLEQ1fskLiAvdUHTLQAYz8Khy8dojv
	 DD47BMI0PxDSlk7JJ991NCiSMRTBkYOfdhm+adWkx+TrJ12lYAYHd2q6BR1a2QkKnt
	 TOG0IOnX4FNfzVn3VoBrL73Xx9d0MxFsRYgydeek1roklEe6tSUPnQ5nYWr6z3Q/r4
	 7C3phyBGss+kPMmSXDC7KanxodKrr1OuIKL5lQsXyPvCna4Nlykc8cD7aEFewsWe2G
	 Sx2CyLY5j7caFgSDBhTfZlx9hjwn0I91+3fTDx7I5WNhTCMH+yqWYHvaEtfk4oaa3B
	 cxBTjq638tKzA==
Message-ID: <sashiko-outbox-179240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/15] perf annotate-arm64: Support per-cpu variable
 access tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <7ba30d22a8bd97b53b1536d1b3d7895290e7b72c.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <7ba30d22a8bd97b53b1536d1b3d7895290e7b72c.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:24:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend update_insn_state_arm64() to handle per-cpu variable addressing.
>=20
> On arm64, per-cpu variables are accessed by adding a per-cpu offset
> (typically from the '__per_cpu_offset' array) to the address of a global
> variable or a structure field with '__percpu' modifier (e.g.,
> 's32 __percpu *counters' in struct percpu_counter). This results in
> instruction patterns like:
>=20
>   ldr   x0, [x6, x5]   // Pattern A: direct load per-cpu instance
>   add   x0, x6, x5     // Pattern B: compute per-cpu address
>=20
> where x6 holds the per-cpu offset retrieved from:
>=20
>   adrp  x4, <page>
>   add   x4, x4, #offset          // x4 =3D &__per_cpu_offset
> [ ... ]
>   found by insn track: 0(reg5, reg2) type-offset=3D0
>   final result:  type=3D'int' size=3D0x4
>=20
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D14

