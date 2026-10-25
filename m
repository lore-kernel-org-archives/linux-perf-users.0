Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792945915;
	b=p573U1vfppxOs1jbx1gEG5dWV0nU7nBBdu7eUbmIv2GEwsOvF24C3f0SZQOhzz23c04J
	 Le48OfvXDBA8E/NLQnIFx/A0P+nODoR5GCzl8bz7QQNfQavQqX4rPTQChbh0urjH12YGV
	 YeXgDUA4+LgrwjXGG306jMouTLoa9MXdH6+RnlgxtSfgxqEbchLHHHzCBhoYcbbJ2tRcG
	 yCEQBxNkwbG484lf/+OmQWvS0sR7tHNEGn75Lf8F1A+LIJKbneZNAqHsaRe+Zcqecmp8O
	 jNSsmInT0eG5zyIpf/snr4o3dBcReVdjL6ZuNkc6b8qzTBboQT60OcwoKNKXaXg1/hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792945915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C7hNe7rBKCu9uUEO/jwfySCAYA0VtDvIcRvVM2g0mW8=;
	b=HDpy1A9qY/UiuTuR4dt+d0G0Qh5/H/35haM1XqGn/ehJA6JneIoSZ0BaloBwKJGvxuf2
	 lMTm5d6ts/X9/zG+p8AI4ZVi33Hx+btyo5CtlCOt/XaxYMn59o+n2GFTr/bvhcJ28FDo/
	 YPh2HTR53ihAj9rVnI43VXqty/I+aCFp0HUY6HFkk5n6V8hg1W4nHUTM+fKammPjgvWW4
	 iq+pwnryUvjwo/tpl4r8e0300LOuNfeipgPeP7urH9DK6iNc96L0bW4kNMOdMANg8PmyM
	 vwhiLKoh4lPfRX6g8cwxqoRQ+jpsN+Ea0sD0bJSBxSi3e9zKsgiv8Q+ALJJFcf0lVmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVmvqT6M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599EB606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVmvqT6M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D401F01825;
	Sun, 25 Oct 2026 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792945914;
	bh=C7hNe7rBKCu9uUEO/jwfySCAYA0VtDvIcRvVM2g0mW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CVmvqT6M9T9Yc6V2AOjJK0k4CzmV40vUgiiAOylMcv0LjUTXCo/haqBvCx6KUOMLQ
	 prooVAUlQ50rGIwVVvpHp6DF2SRUy73P3cYGRtJz6OZg9QCHFgtm9xy9HgKUAwcO98
	 X+PPzvNxgg5fq1zYAFUCzHfQ2rLjc84aMSpCramH3AtIXcGqvwgayRKhyOuHX8Q9Fs
	 afsjVLZiRbIA+YMZPDQ72nSS0r+BZN4ewVmRrcTNgGJ194vCsL5Mxs9i45m0+FgXW5
	 4ICFbffNWbJKRQs9rLDaJKuZyqfbLqRZEZmruvjo5DnP0pNldp1YZymr3e8YVKItm8
	 Jb0qJ3yPXmrog==
Message-ID: <sashiko-outbox-184274@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Revert "perf/aux: Allocate non-contiguous AUX pages by
 default"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261025-perf_revert_prefer_large_alloc-v1-1-5fb431bbd624@arm.com>
References: <20261025-perf_revert_prefer_large_alloc-v1-1-5fb431bbd624@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 16:31:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> This reverts commit 18049c8cff9cc89daadc4df6975f7d9069638926.
>=20
> The original commit claimed that contiguous AUX pages unnecessarily
> exacerbate fragmentation for SPE, TRBE and ETR. This is not generally
> valid: larger allocations can keep pages with the same lifetime
> together, while order-0 allocations can scatter them across large
> blocks and prevent free pages from coalescing [1]. The follow-up
> discussion [2] has not established how forcing order-0 allocations
> addresses the reported problem.
>=20
> TRBE and SPE write to virtually addressed buffers. The TRBE L1 TLB
> has one entry on Neoverse V2 [3] and two on Neoverse V3 [4]. Small
> mappings increase translation pressure, and TTW stalls can contribute
> to FIFO overflow and trace loss on TRBE.
>=20
> [ ... ]
> [3] https://documentation-service.arm.com/static/633fe1ec4c59b30b517730b8=
#page=3D52
> [4] https://documentation-service.arm.com/static/67361bd2c7fc0d1f211da382=
#page=3D54
> [5] https://lore.kernel.org/linux-mm/20260715120813.3609949-1-jiangwen6@x=
iaomi.com/
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-perf_rever=
t_prefer_large_alloc-v1-1-5fb431bbd624@arm.com?part=3D1

