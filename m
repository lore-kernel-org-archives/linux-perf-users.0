Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793428897;
	b=lm63hsCu6ykU6gB5vEixw3xsbAfwoiCXn5p4Fy4ZiGwdNNf3tFhX03btRtlEvHIFvOgx
	 ci6zXKY+E9KWbJW63Nlur/fdRysaicnPax5WaUGKx9DpPch1vMtIq301uD2pFn9TZVROn
	 i1+fXRsh7gXRuZJBjj9KFWJxcYvp/DgnlVV/crSGJyqNJxMoeL7Jr1dXbRC5z2Xrx2we6
	 YvdhwspMnp494iHP28MYk4dw021xaZRUu0JDiajY9w6b7oQ3C3HKSwl64tcLi/IAkQusu
	 hU/wovDAw/USMfxJdfxUN1vNF+llX8OmdfRBKy+8AIvhMe/SMGNNGG1HZwmvfPhI9lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793428897;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U5Yq1i5fmwaCKYW/XU6cjUJNtZZHmBj0r6IRp6s+DTs=;
	b=M/d4Ql8I0bgm0By3Hd27i9O1KXMB1+FSlFvL9Wjcoi0yKML49r1DbtQznx1y+Lgbtupo
	 VkhKvxFKl1c5Cl1kbn4M4vFf+FJyyum+AQPo4ryqnM1qexXLKJTQYUITcnJ1K/ylp+Avk
	 j0GFIuXn+PtMRfIa2RInanwSu0tap6wiograxLuYaV7lCtPlrs25y94vbBh/Zzn8inJhR
	 G53Ik+cPZbVQd75z8nPjlfsPfcpl8fSE4g+CSb9xUvlPf0mAaSoTO2qnPXdFxVuXeSj+6
	 MXcJmwMHf9HYk8oOHdjlFzrNZ0f5ZOy2o5okBj90g1N7izfl0MoD764Zz8qCIKp9B8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxNuRe6o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E37606A31A
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxNuRe6o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2741F000C1;
	Sat, 31 Oct 2026 06:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793428896;
	bh=U5Yq1i5fmwaCKYW/XU6cjUJNtZZHmBj0r6IRp6s+DTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UxNuRe6ockBuwEJm75eXTNmUB727qHVqVz4fn2bdifSHjMg1OIu6NptpUc7NCprEe
	 8wHyEdLL0rsdhReJuxAjEZFfe3LpuaaRpUkMJ+/xBRJYBEGgw/GEBKLpccJtVQBmaP
	 w4nTCTrOYCM7gPg51N9++gPxi7fEPoYR27mWnp3cSaP3LZpNdFpc2Hjuq8UwcTINqy
	 F4137xkzDPeCsnISR3dfMLXw78Z4SOjo6dCCxzEV/eYppAZSmhER4DnzAbYAfoo3x/
	 JT988cfWYuUxDh6lbbDJQD+pBpf0sSwXD4evTw5vhjIShFP9KGJaKee4fZxPiXIn8C
	 1ckstnd0owD5g==
Message-ID: <sashiko-outbox-191785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf symbol-elf: Fix zero-size symbol end
 calculation across .symtab and .dynsym
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261031063549.1281324-3-irogers@google.com>
References: <20261031063549.1281324-1-irogers@google.com>
 <20261031063549.1281324-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 06:41:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When loading symbols from an ELF binary in dso__load_sym(),
> dso__load_sym_internal() can be invoked multiple times: first for
> .symtab (or .gnu_debugdata's .symtab) and then for .dynsym.
>=20
> Previously, dso__load_sym_internal() ran symbols__fixup_end() and
> symbols__fixup_duplicate() at the end of each individual symbol table
> load. Consequently, a zero-size symbol in .symtab had its end address
> extended to the start of the next .symtab symbol before .dynsym was
> loaded. If an exported function existed only in .dynsym (for example,
> when stripped from .symtab or when using .gnu_debugdata minidebuginfo)
> at an address between the two .symtab symbols, the zero-size .symtab
> symbol overlapped the .dynsym function and samples inside the .dynsym
> function were misattributed to the preceding zero-size symbol.
>=20
> Move symbols__fixup_end(), symbols__fixup_duplicate(), and
> maps__fixup_end() from dso__load_sym_internal() to dso__load_sym() so
> they run once after all symbol tables have been loaded into the DSO, and
> add a unit test in 'perf test symbols' verifying that a zero-size
> .symtab symbol ends at a following .dynsym-only function rather than
> overlapping it.
>=20
> Fixes: 87704345cc60 ("perf symbol-elf: Decode dynsym even if symtab exist=
s")
> Fixes: b10f74308e13 ("perf symbol: Support .gnu_debugdata for symbols")
> Suggested-by: Alireza Haghdoost <haghdoost@uber.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031063549.1281=
324-1-irogers@google.com?part=3D2

