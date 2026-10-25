Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952411;
	b=HlShVQBN6g66GOZqMnjYmRqO7D2NjsitKCyJnXPa8y/5GlV4MpTYgJA/LiucPNSpUFbu
	 LWIZPsWgMTYFonBueF/YAT2/K0VBiKdOxtgesrHyAK6jzFvYASPbyxat53Zt6Y23pHem/
	 HvnH0TSFz2j/CkR92ILag6j2RyqX+hgJMdkzbAyewjTiOO5dLfGFwt53k1unAGayxNGVu
	 ZGCe+whv73GVsdVl3RhcczuM5Zco91i9AbBj1EelHOD6KXA8p12coCO7rA8uOQhI1UlnF
	 FU3jKKSBh5LnPfbRqWilQnp7292Y7thy+KZJnMQYZZntsszrSLmE7/ol2dZXffJx9tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952411;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t12/5GrCpsVTxoO3hcOOJ5SRAOl7U9n2g7jhBfEPrOE=;
	b=xUHRSsrHMXeGgZd6XeIjM2e9/6ooMoiijHuYPuBuUR0mDY/um6lD4Fuppl5SeBsHJlhE
	 Xx7giFQNrGJLVFQoFSy8T6k8Xs5LVkBPAiwnl2azzdbZgrjDIDKxzh1hHihYoavqORDZL
	 Fjs2fF37yfn+bln7UTDnChCa34/yVmDJGrVNVMgLpE6NzXNdar6Ov6L8t66w9IYtPpyHd
	 3DP0OAO10IjCQhuCJBzivL6x0ir5Im2hgvG05r4nLHh7/hZ48dMSA/KKhfKVz2v7k5Gp2
	 G3yh3kW00mHA84Jv/gXufKOcMTUaMiKri6a71xE+BM2k0+7w6A3jD4TOm+/kSeDgIsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5pbjOAw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555CC606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5pbjOAw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9131F01825;
	Sun, 25 Oct 2026 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792952410;
	bh=t12/5GrCpsVTxoO3hcOOJ5SRAOl7U9n2g7jhBfEPrOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y5pbjOAw9NEdRh1x3sft8vYRhIika6Jy5KfAwvj53hl5PGmS3rMPlcbrXjH8MEuCX
	 RwddA4w89nAHH+JS92aHXUwyqu17FRLqXDV5mBdEMvAQoUZgU3GLtCSL3I9XOXfpa5
	 Ufp+87RzAmYnW445ypyyUfJdio0/lMcpbdUNSynIEWUZc2vnNktCrt/uzUID1mHQNi
	 ASHzfDNlW7HGIekx/MHt1zMOgT4Bz+hZeKp5+Q0s8cRXL71qYUcFoQvO93KJkLiuUo
	 OIVm8dL8nQOp5r2FWp01zivZSGXZGpfM22OIpt4VDbdWtgyHN5clCr4+bd6HmxZvwz
	 hMw2akIe9jonA==
Message-ID: <sashiko-outbox-184328@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v11 08/10] perf test: Add test for
 ftrace inline and task stack tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261025181125.514372-9-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
 <20261025181125.514372-9-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:20:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add an automated unit test suite ("Ftrace inline processing") in
> tools/perf/tests/ftrace.c to validate the function graph call stack
> tracking and inlined function reconstruction implementation.
>=20
> The test suite verifies:
>=20
>     1.  DWARF inline symbol resolution
>=20
>         Uses vmlinux_path__find() to locate the kernel image, setting up
>         symbol resolution and validating activate_task inlining within
>         wake_up_new_task at offset 0x1d1.
>=20
>     2.  Inline presentation and return address filtering
>=20
>         Verifies that synthesised inlined entries and exits are
> [ ... ]
>         FTRACE_MAX_STACK capacity.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025181125.5143=
72-1-atomlin@atomlin.com?part=3D8

