Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505755;
	b=2IaiZnzNYqHZMBth9uimowiGrSVZfrC5WUkv2EIv3L8hrM2CZF1+sVrdGxCDvSe9VZiG
	 VQFpp99t3X9R2fgdL/upF3Emqt+/5WBOwfzxJ+2peMZYVXDKy3rD18vnSGxfeK08CtHKZ
	 HU/1GA//uMJPc9t9LaIbvkpeQantU54JmbAKf6jKYVt8nEwJcv78f2cm9UMEOMjOY9K+e
	 PFwTaavjmpcF5CYCvMrQ1qrA4sjWjTRx7yjHz8gspy49nQZ89xpOQSNYiRPY+BJK3ktHK
	 bEEedEl+oh2bDg8FrBIsFVd64Qc1wZ3/xSZ4KTk99jwaJazLOXIPIOWt2g746XkEQBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505755;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AXGrT2csGCJY+xFyZwykdz30lkzVlePuWjk3t1s3O2Q=;
	b=kqllASBST4o0v9WSW3WOUIxH4ustyM802ZVYW8O77lw+QE8aDiOAB+1gna530gU09WN9
	 VnLAR0oFA3SxtdA6ESOEO3JQEamKyeURWBaQf33y13K2f9mUaGIDeoCQic+t5oLPJuU+r
	 NLI4DJ+bycSjS7nNaUkcArIFHJNYl5uloJxQl2ckT+ioIQ0XCV0aVdSGONHBC0oBhWKWv
	 45nSYNEZXOm/baNjt+4fefh+fyz68XzplcvgbPAeT64Q+6GmiL9gwGAep+GVSj71Mw+cp
	 oNHiyCO220mlp2igasSixktK1fzeXQRnNklCd/cU+ClDwkaHbuAjsViQDzSkgYvGOxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlAdZzJb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72DA606C207
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlAdZzJb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278C81F000C5;
	Tue, 20 Oct 2026 14:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505754;
	bh=AXGrT2csGCJY+xFyZwykdz30lkzVlePuWjk3t1s3O2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AlAdZzJb7h4fwMEtM1ea3FUTDZXnidmIKmmASAzHr0trhEWgpOVj7GJwpE3Zn4U7T
	 ixoekmaCQi1Rl/6UVyiJEC9C6uX28+W7NJaDOWW1qj3CAt1Py7awbfSHeY9yOOj20F
	 8sLGk0faF6o91rQdCehfzVdOXI1nPPbjZBfYHVS+yh0Ad4ACq4aM6jLAyg+fcgEA0z
	 x/CAYjDFwQf2//IxCrg4gwsk9thv0bXFxObcHtJTyD4ejk5EKB0bOHiedK/yadM2o4
	 fB7ETKoEP4OUxMkPkfIMbVmzt/qoAyik02EhmaLLLoK4hBkH498ITo1tid2Y1LYYEi
	 XfIXRC7US1bPg==
Message-ID: <sashiko-outbox-179104@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/15] perf annotate-arm64: Track return type after
 call instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <62622766adb2db49d32e51136c8a78050b133617.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <62622766adb2db49d32e51136c8a78050b133617.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:15:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Enable data type profiling to track function return values in arm64
> annotations by looking up the DWARF return type of called functions.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D4

