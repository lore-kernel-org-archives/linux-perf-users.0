Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6642D2385
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523318; cv=none; b=mrQ0nlfu7aERYNNFcspQjAnCrihnkM0M/7aY1Tpzy/TEoX6lu1+pQ4iL88uNv5H+jtG2pZZLDT774cAZlo741xaKTN9vJE0vlOd0gO5Tm848hhxLoblilSalT8jr0itqEVhRbEUo/lzyPEyW3sp8+p9SdhY68muQBDJokfGU88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523318; c=relaxed/simple;
	bh=MDWU93LifyMnaRe6M+51CRgPCUfSwWiCBWTU/Mt7Zpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uZAf02ttOOm888O2n7hh2nLwm4iLr6IXIu9QuIYH0FWoOen8iZhSSSPe6GzJKz6MTGKpSWoEuuNhK2Zg0tBNcrs6XB6skpjZKz7hI7byG05TaKt1PuiQkwaPJHi4NO85Trvu2INjC3dj+CK1VVluhKIDgPQXFXJxOqjDPrjAUtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFwXy3Ze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFwXy3Ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289581F000FF;
	Wed, 16 Sep 2026 01:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523305;
	bh=5YaJvosKZt+warx58PUK9tGLoJKEaRRyn5Yojn3oXmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CFwXy3Ze26yiPkDQNassLQoW6D94Z5ESASwv8CmkYmj8HkkcEi4jRCzWh8rrbZITc
	 k0d4XsnQYyh+bZowLCO0cA3T0qscFXI1DXLsSNMvta3H6tZc3/vz0kzYfECp4oae7Z
	 /R/OqRx3xYBMHEVwhMiWAkwSZZn9gVUGJsW0gjmaXSH+bFCI9BSRQTCx3sNyJPeq8o
	 a3TN2Mh79qYMBRlNtK+Z9x6Vgq59Kecs5s8V8dkbvthdAOqMr2TfCwpljOvEZP1bXp
	 RC6LUTGY0HN/6wmJnY9gKQxX7ZA2owvITTeu+uC6gJzLnOTkU11osFQM9XYTpDxXez
	 8KACGF/p38ZJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 24/26] perf annotate-arm64: Support 'adrp'
 instruction to track global variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f2e85e2ea4bf16a01f0f930c6f0f9f50fe8bc57b.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <f2e85e2ea4bf16a01f0f930c6f0f9f50fe8bc57b.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:48:24 +0000
Message-Id: <20260916014825.289581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Extend update_insn_state_arm64() to track global variable types
> calculated via page-relative addressing.
>=20
> On arm64, global variables are typically accessed by first calculating
> the page address using 'adrp', followed by an 'add' or 'ldr' to get the
> specific symbol address. Without tracking 'adrp', the instruction
> tracker loses the base address, making it impossible to resolve
> global symbols and their associated DWARF types.
>=20
> Introduce TSR_KIND_GLOBAL_ADDR to represent a partial global address
> state. When encountering 'adrp', store the page-aligned target address
> in the register's type state. Upon a subsequent 'add' or 'ldr'
> instruction that references a TSR_KIND_GLOBAL_ADDR register, combine
> the page address with the immediate offset.
>=20
> [ ... ]
>   chk [70] reg24 offset=3D0 ok=3D1 kind=3D7 global addr : Good!
>   final result: type=3D'struct folio*'
>=20
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D24

