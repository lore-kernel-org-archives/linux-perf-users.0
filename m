Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793767029;
	b=RqfD2sifALDklytjb9FNJvCdMUofpSsPtz8J+jUaveNm47VvEODnUpL6ZfvmVS9LSLyD
	 5eA+V/hkO7iETOtuZKhR7nyIIP4XtQo5k/3WeFMUOl/JjWCCdfI2JE/lyVkmjxWDGwoS4
	 Oq38QOGpNWuJfv0PEvV0Nl3n0+YgYBISFJTbjL6PthogQj4srrN3t3lk2aLF24zQ15uBl
	 shb03ORHjvqBD0iQMLK/96+A0jgIHz+r4bF3ebUO7E+mHPKAIQklJrV3F7WTZA6m0BQmg
	 oz80Z/BfCjT5haVCkdornAXZ2eqJApdT18Drgy6EIbJTxpdai/8I7iJmD6pvP6oh3hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793767029;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vf7Jn+Cslp97WkufslNOi/5ryi2JEZ3k98N3VUSuXE4=;
	b=0vjc5jx8itVemV4VL4HAhVnstjhuskWje9MPkmlyzbFgOwif3rfZni9B9xf8GwcUHuLJ
	 EPR69zAfyCKyCDfdXaA8aJuEvi0oW534bl4Yn5qGlv5YsLXfoCN1RsGqbRR0kPthRThka
	 pzLy+Ni401ehAhAqNZeUms0G4ms0OJ0hmA06O12TwVunDxRI6e3pCZJPfBKyNSRZc9/KE
	 McRcvdgsvw/fmbT+W8hEl/DgKWwWJJB5lEP/L5Ey+YtVvK35jEsA0a9PKGXp2/rKHmnQz
	 rSGzmLlmexdKMzqjgHTwoZcBDolZVXJuMOSl3VdK4kkXNFHIdb8fEEGAP/u5FxUX0pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P66m36gN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B719606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P66m36gN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB7D1F000C1;
	Wed,  4 Nov 2026 04:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793767029;
	bh=Vf7Jn+Cslp97WkufslNOi/5ryi2JEZ3k98N3VUSuXE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P66m36gNB7Tx1uVAjIGGDo08i9cvrSl+/5kwor19QmHBc/10DRBJa+Y0HV3EV14CR
	 csdaGP8eugch+ecEwYM/IHcseF3HwoNbOH94wrImVH3PycWpHwkHqH1IcgeJs47xXB
	 JiraE5rsHpJWB+8thKfbwgJSnVwV77bpwpmgNwF6HnWP0GpwrF0nHan9Moo3dpNoi7
	 eDHfW0OhqSrpL+GCAFyk1gTJQTk1vMIHo2UU06oD0x9ImrLAPFcqUyh+lvJHj2HtaF
	 DNgN1IQQKSy438ENbrA18L6zXe92ylBtSGVwPkMzIYNC77Y+YJyc3QFiMmAfiTTNu3
	 tB2ZqmY1502gw==
Message-ID: <sashiko-outbox-196658@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] tools build: Add explicitly sequenced -lzstd to
 libbfd feature fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104043006.1199857-2-irogers@google.com>
References: <20261104043006.1199857-1-irogers@google.com>
 <20261104043006.1199857-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 04:37:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Distributions like Fedora ship a statically compiled binutils libbfd
> that depends on zstd (along with libiberty and zlib) to decompress
> sections (e.g. undefined reference to 'ZSTD_decompress').
>=20
> Commit 89d001d48ec7 ("tools build: Add zstd to the binutils library
> feature tests") added '|| $(BUILD_BFD) -lzstd' directly to
> test-libbfd.bin, test-libbfd-threadsafe.bin, and
> test-disassembler-four-args.bin. However, static libbfd requires
> '-liberty -lz -lzstd' together, and setting feature-libbfd=3D1 when extra
> libraries are needed causes callers (perf, bpftool) to link only '-lbfd
> -lopcodes' without '-lzstd'.
>=20
> Restore test-libbfd.bin to test only $(BUILD_BFD), add the
> test-libbfd-liberty-z-zstd.bin feature test and
> FEATURE_GROUP_MEMBERS-libbfd entry, and append the '-liberty -lz -lzstd'
> fallback to test-libbfd-threadsafe.bin, test-disassembler-four-args.bin,
> and test-disassembler-init-styled.bin.
>=20
> Fixes: 89d001d48ec7 ("tools build: Add zstd to the binutils library featu=
re tests")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104043006.1199=
857-1-irogers@google.com?part=3D1

