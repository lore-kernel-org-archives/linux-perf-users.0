Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4272F49F6
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Sep 2026 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649175; cv=none; b=Cx4oRr+4kxHpcd1hECl19FkMIQO8fQkptL9A0Y0/2Dosvnl0QNQeXsx0ImffwQKCz2g/NfsleVY2H5gq4Brqr4VjZ/YH30MvS67suO6iSeKlSNjij5eBTvIraPoz+HiGgnyjWDdcPWtzHg8EzATu8as1W0kQA3wj3Qdm1C13wiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649175; c=relaxed/simple;
	bh=H+sFj77M2MHKGMubPOwLquP8Nx1ZCK1B+jRnY9Q0eNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tO5MDjhfviHT9XnsuNWEwJvOVZChmIYU5XZuJtEXgU+oQLzGaiPBeJ76XkEiDVP+g3NgNBQule827l9iyx3OIc6yk9GZogDXs82vRFI/IUwCLXhnJGZlyFxiOmxJqmQLdZNaJixeEJgzVcu56lFA7zcEerr06ybSm1MpySV5fVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5W3mvYu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5W3mvYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41901F00A3A;
	Sat,  5 Sep 2026 22:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788649173;
	bh=HBoQYlYCugWYVOC4NQ/9qvI4aWGCPvYyi2Nozlayp50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i5W3mvYuQC4ZfqI6TEhquZwlxi00J/8bYAPx+X+496hrLWDcfDQdGF0dcOzEz+Zbr
	 mu9OX/BzpKtpH2PEFYvR1lDDDp6JffYF5Fd5SH2qltd40iIUdhgq2DP1Y4cgp/Lk9v
	 w6Y6j2dJ/ZUOcx10/3g4fpypPCHiltJJoVxNgQwNVaO3/bILP1Hol5HyM3D2WyVKob
	 ULZxi6Le58OcHCY0XcBru7ysfGrpKaCv8RiViMbxdwOKpknDWwzhz9gY9kJJbyipK0
	 e1NYdGXOcZ+l9jMv8fDT71dsIUz/CFJaPQXiiHBXRJuvE+N6pPkuSB70SZjRZc4WHa
	 7iAu5+gjTGPrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf annotate: add Alpha instruction support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260905-perf-alpha-annotate-v1-2-97380433ccb6@gmail.com>
References: <20260905-perf-alpha-annotate-v1-0-97380433ccb6@gmail.com>
 <20260905-perf-alpha-annotate-v1-2-97380433ccb6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 22:59:33 +0000
Message-Id: <20260905225933.B41901F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Teach perf annotate about the Alpha control-transfer instructions, so that
> an Alpha perf.data gets call and jump arrows and resolved call targets,
> whether it is read on Alpha or on another host.
>=20
> Add tools/perf/util/annotate-arch/annotate-alpha.c with arch__new_alpha()
> and an associate_instruction_ops() that classifies:
>=20
>   call:   bsr, plus jsr and jcr as indirect calls
>   ret:    ret
>   jump:   br, the conditional branches beq/bne/blt/ble/bgt/bge/blbc/blbs
>           and fbeq/fbne/fblt/fble/fbgt/fbge, plus jmp as an indirect jump
>   mov:    mov, fmov (objdump pseudos)
>=20
> That is every mnemonic binutils can print for the branch and JSR formats.
> jcr rather than jsr_coroutine, because both name the same MBR(0x1a,3)
> [ ... ]
> Tested on an EV7 Marvel, both natively and by annotating its perf.data on
> an x86_64 host, over bsr to a local function, jsr through the PLT and
> kernel-mode jsr; the two hosts produce identical output.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-perf-alpha=
-annotate-v1-0-97380433ccb6@gmail.com?part=3D2

