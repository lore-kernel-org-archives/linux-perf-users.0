Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794024855;
	b=1PAoBx6BlR4eh6WBc7OB9+JEuJK+AC0GO/Etkacz6mU0qCRzf5neEg1V3AcJIPbrcaYz
	 bcrFEudZ5+yWTGERbwp2O6dJIUpE1oLDWVJAOGn+Fw9lT1LEAdlWvJ18gaSuiqBsBlnmH
	 X5FpgN4cNq+dm98Xzim29wkrS+aIPkC7pXG5GiKLo4MRDlRkpatluBpRGzXG+NdNE4Uuc
	 c2FhaifYLavCpnmcddhKszVMJy7ilrP1nLF2D08cRHYYWcDJWB0jeY4DJl2VS9ICn2Dav
	 7yHM7qSXP84X7M0+CkLnJuxifxYZwPRHU+sDY68Zb+SO0Xk7rWtrp8k8cTUoAag0Kxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794024855;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WLv+hpNLYRANGODVLe5/LLty2djhx5PkCctCQz76zsE=;
	b=IHQ2CqOfoOkodKZjiozv65d+a5oPPA4cZIjXuX8ENUNjX4+ZugJvNJdLYu+kUjE4pWAi
	 /DLBSywFK/rUj4tgTesW3GPkhYw6BQTn6qswhWNqvF/7xiQ1BQYWpxCdu4rOg9b33eJ1l
	 i8+70Lr+aV4vntrE+faBrxduZnbV5tm/UMBJvUAt6SjMTLw5fIqqWnjIZ/VbcUd/ZIx1R
	 yq7OyybzEZxvw3UriMYntAmXezKpdDfr93sO5CGLywJxVMcN2YeDyzYdWZ4ZDVjVxPUo5
	 Pg0T90lY24L78KFZBarWInnThTPHz90UWw+WECEFN671YM3TDSY8SVmdHJb2IurUFZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFvS36In;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B5606A32C
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFvS36In
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642BA1F0089F;
	Sat,  7 Nov 2026 04:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794024854;
	bh=WLv+hpNLYRANGODVLe5/LLty2djhx5PkCctCQz76zsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KFvS36InoT2DpS4hJACLHsArAWrg/w+0V8l9kuvzxaH4+JYo1T6nbj0MizSPRaRmj
	 tHa0FayPZiQ3lFCrdWIFYaBRPBGBtvB1BRGubRt3QIKBpuHS+w16kMNd8KIIExIv+U
	 e2MtiHRz05x822b+CRXUzJMtE+0nXodor3njaxLxgE/+WXwNDFnV5OyfTV1PnTDvho
	 uZEMtohBloZdgHz7KM/whzbJBoYhhk0j746ib4GdS/R/u9Af5xJGgmceBaWveVtg+J
	 id0uueL6ZkqN7ZQoiWe0DUT8X4QhrRsoRodZ5texH+9TJ40xokw+/dy56JffuBuexU
	 WCJmNbDZMnwyg==
Message-ID: <sashiko-outbox-202562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi
 AXI PMU definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107040913.1384033-2-irogers@google.com>
References: <20261107040913.1384033-1-irogers@google.com>
 <20261107040913.1384033-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:14:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add device tree bindings for the Broadcom Raspberry Pi AXI PMU block
> found on BCM2835, BCM2711, and BCM2712 SoCs.
>=20
> The hardware exposes two MMIO register blocks: the primary monitor
> evaluates the System fabric and the secondary monitor evaluates the
> VideoCore VPU fabric.
>=20
> Co-developed-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107040913.1384=
033-1-irogers@google.com?part=3D1

