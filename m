Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507193;
	b=QdDOUV+jQTPLbhCyvJQgB2rEEhI4ESAUzjTN1/A7OmHWv0Qnx3cwrrhs0sa0GDbIbAgS
	 E9AyIwW4KAU0yL5neoYLJ4MOYFBNmJ+ArTtnwWUN1RHOaqbKJ5lsRS7l7byFxigX1hv9S
	 mRBskctUx9ncZI1cizV5fKqf2Eevf0XUljmZnQ4kFgzuUGF3RERtvtePGaVvfgFrk3Oni
	 L+uier6Tae7fvrpVYVmS7B9feRD1EYne13BNb7/tLs3/hrHyMp/vN5SkROV7wVL0F/15N
	 aDHWR2f+6zoRtkwjw+ss17gwEf44xVGbB5ohH69v/WTDFLCoTv11E2aJ/VjJSsKriSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507193;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WxvpgSuWk2f8VYUU5fbBQCf9SqLi1s8PpSuOvlHmXmk=;
	b=GwQM3oco9kiQa5OftrNoTMrMoQ3VGfI67wmF0KnCTMb37H1zXgYP67b4MnEsSw4m6JWS
	 2KP8ROgTjALFKkRDmPoM+jshkgCd4jrpgExBZ5iSQcMUSbstiKarlp5mz0qiz3wuDlo+l
	 GIofHvMXFDPGpir0AWkYG1UfT2LttZvmdGIM4T3lfq+DDzTiGfqZymoxH9kP2Irh7PvGm
	 Yz0G8pjWeSgq9+0FtOTJnOVTSnChIvpJ6IV4/Bt0iVYm3zHczBxWAoqA2OEXuPGQStEAI
	 GmaZM+1YznPB/Adm+TmiL4JVHJc2BkcRrtGBwHrA0oGG8DBYQvuBYZpkerXIlPkk6RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=At2UklH+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FECF606A31B
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=At2UklH+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F81F1F000C7;
	Tue, 20 Oct 2026 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792507193;
	bh=WxvpgSuWk2f8VYUU5fbBQCf9SqLi1s8PpSuOvlHmXmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=At2UklH+7PP8EW2z6o0zZuGXfCPzi6psqAsaMCh01Js/kgPelqx+bBdqlL1lNl3sq
	 ll8cDv2QieMSvPWYRVA8wIxm0YPulGJXzm3Z4Aaf2c0QfY8wm3jD8iL59lDIgrbnWA
	 8/x32Cy//N2mKXuiqFW5mUIU2kkk5Hqt89MdMo38cmIjC1CsJ46zbFTliSF0bQIUux
	 XWwEgURPWQ8JL0Gu37uonHbY1v9E7t6786PfJT1lxvJaqfrrcUrWntIekk9c2zQ4v/
	 4tW6E9wSrNkDaURJ+mAPP6/lXFYcMk+85QU7euReFdj7wDWASyPuhwyeMI0/OVGK5D
	 UIaDmbAjbkazw==
Message-ID: <sashiko-outbox-179176@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/15] perf annotate-arm64: Support store instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <8d778f5ed416b0d385c27c601c32c224b545bf33.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <8d778f5ed416b0d385c27c601c32c224b545bf33.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:39:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend update_insn_state_arm64() to handle standard store instructions
> (str, stur, stlr, stp). Exclusive stores (e.g., stxr, stxp) are excluded
> from this path since their operand semantics differ.
>=20
> Unlike load instructions, a store instruction writes a value into the
> memory location addressed by the destination register, without changing
> that register's type. As a result, no type transfer is needed here.
>=20
> The only thing to keep in mind is that store instructions support
> pre-index and post-index addressing modes, so adjust_reg_index_state()
> still needs to be called to handle their addressing.
>=20
> In addition, exclusive stores (stxr, stxp, stlxr, stlxp, etc.) write
> their execution status (0 or 1) into the status register, which is
> parsed into src->reg1. Invalidate this status register in
> invalidate_unhandled_insn_regs() so that stale types are not propagated.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D6

