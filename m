Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB83EC83D
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899375; cv=none; b=pp6NstbEYSK3Io1uk7H1hQ+G6n686K8ujIlCJk5/DSd5bI42bSiEfSFaNUL9srdf/EVyyEK4TBpOR912EijlZz0sWS4xxJbTHQvjNxgveLjcaH9bk+hp/od1id0FjoTxuGeO2G3Wv5cM0sTXDN7D9GCnYDu8rjOCA4gxGYh14CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899375; c=relaxed/simple;
	bh=qV5JnfGxOY0hgCI8LqVreX0R4woyKMozVg5JEmygkb4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ox8gaT+76hqv6m/uXgBwLuYseddYayv+PKrV9o0ybq+Lh38vl3/hPblX8X20Xl9qa63ogu/7Q2PNK3mjah/4KxW8ZtRxQ5uaysVBw0yYITp4Wa+OhOQ/0hVNxM++m8Vh0qc9CUuDb1PcjbKeQXCCHpIhCVuSigkzaHzsrv9qliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA3ed6HP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA3ed6HP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2411C1F000FF;
	Tue, 13 Oct 2026 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899374;
	bh=lumZrorgpl/3UCfdr77PHWWS+b5lCPwxfsDhE55wSe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PA3ed6HP4NUhCwrhCE5Y00x2VKoqpjDhB5WJqmcZE2avjFiq/pZ3bv/wfvldLYO2R
	 wbACymKDFT2Wo/Pircxvzr2LyDRSfl9Tl5AXpbvO2aAoooHmHUGX2y5zGhDFbJtM6W
	 mVwDuO4oK8+8Q3RYmmgwwJVCe0EEeHl+XlvDXT0BD5Lg6b1D0IhDDfbYq0+mwy61tS
	 LIT9eSem/FLY2yXK6WFIEq9PvV757jt+cZ7K6mfn224J43HLIs+U5XujX+tVLGiA/W
	 xOShJCU3/6WWsFZV0EP6hsUgCpEIXdlAl+Urg8RdI57P9bTrsk25pu3SN7uGnXEIDM
	 WA88CPOlBw22w==
Message-ID: <sashiko-outbox-169864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/15] perf annotate-arm64: Support per-cpu variable
 access tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f278f8e0a13ec9d39dfdf601d679471dc0fbd58f.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <f278f8e0a13ec9d39dfdf601d679471dc0fbd58f.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:49:33 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

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
>   chk [58] reg2 offset=3D0 ok=3D1 kind=3D7 global addr : Good!
>   found by insn track: 0(reg5, reg2) type-offset=3D0
>   final result:  type=3D'int' size=3D0x4
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D14

