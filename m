Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903180;
	b=0cjIPygc/XC/9M62C/xBCnTMjbMGOHmsJIddD8lV0nCouVjbhG9RjavYBABTPLOo5Ebg
	 sDjgBq+v4DCBlBRT8SeMhXncFsDpw20nnFZ4AE/oL/XJMtsr4UEUHAt2WeTk4HaEcO0vs
	 XHl93EjmQ+FiHtD85IZMRfjhKkYmrui3A0tRx96r77XV5yyA/xqX+GoYTj/rUUT5wedv1
	 YrcUSYtyixgRuxcsrsnZm3N/xNAFhVeFQsiSSR+cPW+4wzJ8qxvfkxlFB5Xk9KZ+rymVL
	 TUhH7SWguXfosB7rswRsNgleABPQ1FyH0DJbuMi3ztMpI8aCasdxw/Rc+gApQkOXwoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903180;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nh7D6vgmWcIvrmMhqdn3mE5w3+ect6lMuFk9WaTYKhQ=;
	b=RfyFgJm+A5yO4h0xTmcLEzjnvvIVIBFU3qyV4qpytasTkinddvUvhXgzZC+r9cpqlpVc
	 i9oiDyfKDrwPrpy/J02A2ObeE/05e5dTDU7pZ5BWCglRbabo8JoizeidMRQJ3ujTR6Sp5
	 Q19urfzpv5Xmo/CxQ1IWTGYHqVTCccfEXdIJXtlvnBFrkBKr8n8UBFiSQtLPIIUBq9g0a
	 4CzgfBUUgKTdzHW0B25P4bQ3fYGWAd2DDUa/p95a9L9P51D+Xcw98i4VdSMfOxp1Qntk0
	 ffPLHu598BVLBjTnhadxKvMtOUla3ObmPz/Di571QAvkDF97Vu9K7KS4qnC81NILS9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TB8f/lRu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB9606A328
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TB8f/lRu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5C11F000C1;
	Thu,  5 Nov 2026 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903179;
	bh=nh7D6vgmWcIvrmMhqdn3mE5w3+ect6lMuFk9WaTYKhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TB8f/lRugFnFE/NxVn1WKibAjgvn5AfvLjgO+3kfklq3lrxcsaMGDgCrgY6xGXcZ4
	 3+855wcbECjPQeiB0fArSXHeXeUgbmxphg/DaWO0uBxd/FnrgWNr6ECKBm/MYmZnIY
	 4875kFxsRN+sYDfY5bgZ9brwbHNKbIjx3dtqk6GXG2dUcCLF4zSGev/79WWq4vQe0s
	 DKRXQ6NqLhg52Xe9ZPsngrFUUo8zAf4vZfA5a1HVDAiZnuIC4T/on/+JSpi+jFiZt0
	 ANcSNDRANDMYbDFTXxyLlmHGvdGtKDqDM9nEktn2m/m0w95QEevgQpXmGNpB4JzKvY
	 2x7GzUR+bSmGw==
Message-ID: <sashiko-outbox-199760@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/3] perf build: Prefer zlib-rs over zlib when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105180923.3441359-3-irogers@google.com>
References: <20261105180923.3441359-1-irogers@google.com>
 <20261105180923.3441359-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:26:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Detect and prefer zlib-rs over C zlib in the perf build unless disabled
> with NO_ZLIB_RS=3D1 (or NO_ZLIB=3D1 / NO_RUST=3D1):
>=20
> - Move Rust compiler detection ahead of zlib detection in
>   tools/perf/Makefile.config and use feature_check + feature_rust_lib for
>   zlib-rs, setting both HAVE_ZLIB_SUPPORT and HAVE_ZLIB_RS_SUPPORT when
>   zlib-rs is used and falling back to C zlib (-lz) otherwise.
> - Replace -lz with $(ZLIB_LIBS) in DWARFLIBS and llvm-config
>   --system-libs so static libdw/libelf and libLLVM configurations use
>   the selected zlib implementation.
> - Build and clean libz_rs.a in $(OUTPUT)libz_rs/, pass ZLIB_CFLAGS when
>   building static libbpf, and share RUST_OUTPUT with the host bootstrap
>   bpftool build in tools/perf/bpf_skel.mak.
> - Expose 'zlib-rs' in 'perf check feature' / 'perf version --build-option=
s'
>   and document it in perf-check.txt.
> - Add zlib-rs package mappings to tools/perf/scripts/install-build-deps.sh
>   and NO_ZLIB / NO_ZLIB_RS build tests to tools/perf/tests/make.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105180923.3441=
359-1-irogers@google.com?part=3D2

