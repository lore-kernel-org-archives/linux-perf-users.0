Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365876;
	b=CG5mdrj1ImoumRU+zIwt3ZdtynBb3VcgcA2d/i+tazQnXHFG/KdtIviR2Pluf2kf/8Gq
	 aX8422l89LCJT1WYXu7nQnjs22BRkfKp8h4ei6sJckGXiciLNzMePsicvnJmZ8nJR5VZT
	 hgAX8y/25Wm203RmLpaOvRwN+XoeLsCK57QUnFXi8fnbfCj8hhIbZleQGJqYu5jAMQMao
	 SJ9vnAyRYPN2/Dxv1CDos4AH+S48Iab+sBvZKAYX+gdj5qve4odo7f83hgP1Aeb2oqwcr
	 ZkCXwCN4Lvfu89Lm8pNRCNzv76gpvu3epdB+3m+1W6Bx3vhRb9/XuEmF7Sxnb7qiBtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XwVViwER2NT4YgLKnp77wYa+9UuwXgsAEHyrLQ24tuQ=;
	b=0ktZq4QWida8jvjVJsaOaqdbP3QdzDJBiP6oI1StNYenuUwi8d0oXr5YKevImkhGyJjb
	 DfNVOW4Ws2C0i9I5Qpneejdmr9SJ7Q8PAbJ+up7JIcA9H1XJYDnh1t+aJ7XP5UIgYV0YR
	 iUcldZeYVH76heMYG5Xb9z/B+zA69Uqnbj89swYmWclU+0S5ObP7EPXyAOpvL8u7VV737
	 CpOw063TIv5ILh65T0ZRXbTHROI3cQmAI02bVdNyJvERW4HXT9V3c/Ot2p/OU9R2giGDp
	 uYCRy30+NLVzGt4mBRPQbQXCD7NdIYFdu0YL94Kh7Lt79nZY38Dgotf+WDTnlbb9jxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W21GOY5Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47560A382D
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W21GOY5Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659E01F00A05;
	Wed, 11 Nov 2026 02:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365876;
	bh=XwVViwER2NT4YgLKnp77wYa+9UuwXgsAEHyrLQ24tuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W21GOY5YGLmJAG0c3uznawHhjpW2mRIFzXuRRn1nhd0z3PzA1bObgmMoHL1vtyZwG
	 S7OgIBLqv/cLYKJvZjyzmQGeU44R6fMZqT1H2btQsfTwLl++UlYu1KFZbLadEvqEae
	 TdyCauCtYyk6pM8edXxARHa7vr1/gd4BJK3q6WlGIrUf54G8XrErLxJdjpsM915L/7
	 wLBaq2acYXqDyyU+zfXZjzHnXSsklzUve0pv59Q0ZSNBoi+s25TiUOLRQsfRrUmUYG
	 ipIyTl7h3Xk22YPJV8SeEBPB0O0MpvOyEWoDO0JvCow59+8ydLB89kFjYPzJnwfY4S
	 RtYQuKv8PJRww==
Message-ID: <sashiko-outbox-208137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] arm64: perf: Drop the example the userspace counter
 section points at
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111023550.1971639-1-takano32@gmail.com>
References: <20261106234551.1474417-1-takano32@gmail.com>
 <20261111023550.1971639-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:57:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] docs: arm64: perf: commit message includes v1 changelog and
  repetitive text
--

commit 4f292c888b9c6465b91000fd55cd46c1bc198a65
Author: TAKANO Mitsuhiro <takano32@gmail.com>

> arm64: perf: Drop the example the userspace counter section points at
>
> Documentation/arch/arm64/perf.rst points at
> tools/perf/arch/arm64/tests/user-events.c, in the text and in the link
> target, but the file does not exist: no file of that name is in
> tools/perf/arch/arm64/tests/, and no commit in the history leading to this
> base has added one.
>
> The section already describes how to use the libperf helpers and points at
> tools/lib/perf/tests/test-evsel.c as the example, so the sentence that
> sends the reader elsewhere is redundant. Remove it and the link target
> rather than pointing at another test, and move the instruction for running
> the example into the How-to section, next to the reference it belongs to.
>
> v1 pointed the reference at tools/perf/tests/mmap-basic.c. The review said
> that file is a confusing example and that the section above already covers
> the how-to, which is what this version does.
>
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

[Severity: Low]
This isn't a bug, but the v1 review history in the third paragraph belongs
below the --- separator line rather than in the permanent commit log, per
Documentation/process/submitting-patches.rst.

Also, the first paragraph repeats that
tools/perf/arch/arm64/tests/user-events.c is missing in three different
ways ("the file does not exist", "no file of that name is in ...", and
"no commit in the history ... has added one"), which could be trimmed for
conciseness.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111023550.1971=
639-1-takano32@gmail.com?part=3D1
