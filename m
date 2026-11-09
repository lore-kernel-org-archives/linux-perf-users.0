Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211598;
	b=PTOP9wuDc7GYlXvlKPO7nmqEqyJfRvlFyUE27vcQzoRKTLgjPP8yag2cqab9EuQvn15W
	 zadf4AN5/yIeqw2HOgpVb0wNFvjaMGKR/stLCDBtS0lRoyXmH0ggeEsfI4XBD3PL5l2p1
	 vkWcQ4c0zkY8LOB0dZVFDGH8Z21mkaZsXuWIZ1y90hZpyUSwVjJgzyMQM3/3e+hlJgub9
	 ZYq0POPQ/CAuWlPxCxULY/+jemDvqblXmde0WqS3vWUDR35FfcFh4WSy+0JSVFY4D09Sd
	 F/vTtzWR7lxwnvwD3Lr0eTql8wTkB7GFSe5UBgpnCpUmueRNykfaBSLCjtTrnb0KzxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yerjRv150b+8r3W3RprMwbQees1lvr4LigaCZqI27u0=;
	b=UxQfl6bnpsndoFVDrRCUK3yxRJjfbTfsb8PzTjX5GCQD1f8oIFh1eoApN1BbOCtZQlh4
	 ifkh7b8vjTkr+b6dVHE1QTN3l5bxVJg7DdVqx9zn9C9jl3N8kMSnuBNcnNwbyKhgQYva1
	 qvwrjIj7ZiFvuGQVhye4eLO7VKMxAdNhXrHYZgWIFgXzTfQ8TLPQOg2IEgul4uHc/WVQR
	 2rZwi6pPXLOA/nI5bt0w9i0HH7/Kb1EwtcCGulmdYwvnl0zXVp7++kp+D34I3nbrrN55K
	 YnPgu4Z/kxmR7Y+Rf8wp1hXaZMpFZxz9z+LqBNVQdwpm9C3/MUVWwFB6lED/pJqATGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jyanvLmq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A27606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jyanvLmq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDC21F0089F;
	Mon,  9 Nov 2026 08:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794211598;
	bh=yerjRv150b+8r3W3RprMwbQees1lvr4LigaCZqI27u0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jyanvLmq1nJotTgNi5ccb1ATpzxYSMh9Gnw6ykZtfZiYPsI1JnY82mw3CuCV/bdyE
	 8UXk9loxS7kMHZvt2mjl1tCoGtcuJpJGgpLatpksIgg7hewDiC5MvFfAcg8VDgHLkt
	 tQhVjhL8Ey0Zh8i0BVa5dYoWIqx7jt3Y0Oy43lFA6TS+UYrTE7mKpowv468y5C3q99
	 v0m+xT+4YQmn7XunOYLBnWq2ZDhWS5rDV+feKrB8ql/YLcOOdh0Bb2hvwVWQznhnoH
	 pB1XjdY9b8DCZpLVLppwH5yHCqyQ6n3VOTw3nFBpqFYO7+pm6IRPf/tq/cZgyAC3Hi
	 1aQU4O3mcYfjw==
Message-ID: <sashiko-outbox-204562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi
 AXI PMU definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109080126.417161-2-irogers@google.com>
References: <20261109080126.417161-1-irogers@google.com>
 <20261109080126.417161-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 08:06:37 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109080126.4171=
61-1-irogers@google.com?part=3D1

