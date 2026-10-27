Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103077;
	b=ZtsCCc898x1RG/p2WUWXzG2W0/2kmWIjLVoCS5FhGvc/TkjknjfkW+7oXe61M3GkS+0r
	 TFGQ3OKcaiixraeJ1F+CkQJQUWv31CE4BYDXUzfrk74Y37AABbyKwDrS10r/ZEvpJLIFl
	 vzYA0FE9m6IXyMfLUToNTRHsOIOf+w9dOewGyVI0EWg2Ox3ld9BiDPA/yOCDsnQKXEf8O
	 AnlX/SGIENpEioPCCL9CcoZd22LFsZIvKavFSsgbBtvnLHfWhZD0hKvTpWQqywi2AB+sQ
	 Sxo/FYxkpRxeWNsGco/9S5+y0SHUuSfgKt/4d42+Dogx6gTmt+D0gFx3goJXwpb8AxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103077;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n4zOcp9VYFdf7e09I2QmW+A1bLbXWp90D+js/+OrhG8=;
	b=LDc80Hsk1qLlVH8cCSszVeJLPbLvqpkvrXOgujcawtp9qhmdSwQ4j0pot0pahCcULDLR
	 YtIJDmaGX1gI+Zs8fAAJNVath4CmL5Km/nX2udffgiZAvkW94PoLZQzrBnGzxVuqu/r7k
	 2FzWI5PXtzOL2Qrwpv5ZyqL9zN2zE35YaPuPpknpZ9+Ur2Y7UR0Zu1mt4A27O4pFwXnzp
	 cpcqO9npty/UlpXCUHYpOjRaXixXtA1sHj+lMA5t5gvb9C5IkO1uHI8fwqUU+PQ/EDnZV
	 XG9SkzqcD9X83L3UgA1RMGW2+tKStidw0ytolovpT0YRnXMUPns9ejY8rIEU4kFTsSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dkvH0G5z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E2606A320
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dkvH0G5z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9171F01825;
	Tue, 27 Oct 2026 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103077;
	bh=n4zOcp9VYFdf7e09I2QmW+A1bLbXWp90D+js/+OrhG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dkvH0G5z1ojCcxsrKCcahAZqM+MBPeNQyXYgBfn5jFsUv+OJuOeHxMsuAwVTr/9Hy
	 NNfIWU+ISWIbMKLK7VDpVz7RgloyOu5xwwkftctlhGcdiJAeA5Im8XeP0q32TSbJWT
	 BXa0HZdb5oJ+i2bQNkiwJFgGOfUnFVkNjwOSD+Uh0PVVxQGKzZlDmJ5MHw7t0HxC09
	 BRvLF4Chr18F8/GOSPrIcN5K9GMoAycLimWg9yXTmrADgcDU+gAxdmKL8eGhbpo2tP
	 z0OSoeGgrWIlmKkUA9+zjgZXyilqE+mVLsuNAlaHF/PctoC88MoZvX73hctU/9L7cN
	 k50wqAIxQlQvw==
Message-ID: <sashiko-outbox-186516@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf machine: Fix NULL deref in
 thread__resolve_callchain_sample()
Reply-To: sashiko-reviews@lists.linux.dev
To: lv.yating@zte.com.cn
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <202610271154.69RBsOlq045164@mse-fl2.zte.com.cn>
References: <202610271154.69RBsOlq045164@mse-fl2.zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:11:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: lvyating <lv.yating@zte.com.cn>
>=20
> When recording with -j stack, resolve_lbr_callchain_sample() can
> dereference a NULL 'chain' pointer while resolving the branch
> stack.
>=20
> $ perf record -j stack -e branches:u uname
> perf: Segmentation fault
>=20
> Fix it by checking 'chain' for NULL before dereferencing it.
>=20
> Fixes: 29be60c93d2d ("perf build-id: Mark DSO in sample callchains")
> Signed-off-by: lvyating <lv.yating@zte.com.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/202610271154.69RBsO=
lq045164@mse-fl2.zte.com.cn?part=3D1

