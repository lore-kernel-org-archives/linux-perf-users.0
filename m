Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902532;
	b=XJ747bjiWFrgL+xAh5YotlTilzvXu3rDGzC3Cgh91ebTi+xqbPHjhGUjlVzThgtrgzTF
	 hejSgU7ylIX2mFZWYf7tBhB3Ab2kci5AbKt1gmDXeZ9vGp+IJjz8HIa2EHb8B3MpfhJVk
	 rjzFH2WCGCHxhMFAZSrvv0U2qP/xCUgqBqHhp7mTLmFV8WZr0LIXezcqXs8YQb96lbQ3R
	 QO6h26G0geJWttkExlsQIopYl4asR5Yam1A1dvjrzFueU47oybnL6ptve6PBZKSGX0xZe
	 +HgClcgssIeCn00oe0LDX2dupGJNRfBbCGwdiJYfZ6wuJ6XGWYbu0uk7H+cAtgO/QfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902532;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pAyk1xIszRnSdwy2jxcjV2DJgxnCyr5hIc6sj+AYapo=;
	b=CMemXQWbBsGHApWF1dnG39Huo58ziISjDAkFBaiWIJ0IT6mAcRRmmVwK6Sdc73Y0Vmln
	 3zke6nRKBqBU4heKySWKEoTlsc/GWre9nUXRWeKWmJZjWbbPOgrJQ1j4J+KxVud57WSM8
	 DVNR9HqJ7scQ8GvuDXPPGqG0iEDYXW0P3oZz34haznsgc7ayjM+yLfceBIPLI95NTjgyo
	 E2Gy1eLXSWywnSPbITbKYjhRGdSURdwAIZ0xQsF3MRJUTaZL8VGWWEel7ntPvYoP2zrRb
	 nrSQOXuaz50Q3l3ILAyN6LOB352KHxZ4rsOdUnQekIJBU2ZAKVQvkoegKHbYgsPfClw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGmS0+9h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E4606A326
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGmS0+9h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE401F0093A;
	Thu,  5 Nov 2026 18:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793902531;
	bh=pAyk1xIszRnSdwy2jxcjV2DJgxnCyr5hIc6sj+AYapo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SGmS0+9hI2Ze46OcXdSBWTya6+oCHfKEU0F9eYPpSX02QbGQMZRPXX2cvyFo3sSkK
	 jqX2PRB2NYPbZM7K3LkoaTawMMkh85MpzeAuSJOpGDIrvF7K/fio+ngk8QExVEUzA4
	 E3V+M4sRxu9GAqpTF6fhnuVLK/k7cxRdVpr+AD6C52PVG57fF5OJy24eKIIUqat47z
	 OCQTnmylSG5LwIZJyDkeN8bedZ/iu2gMBYKNz4WsmT8dRE0L046hXf4AsVp/sti69Y
	 E4TBfSVTFBHeAOvrUARA+Wk1w6w3oI7mbJEWIvT6kSdekUaBEJOX+sgVsfMNuYyh81
	 abWiZQmBqixSA==
Message-ID: <sashiko-outbox-199712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/3] bpftool: Prefer zlib-rs over zlib when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105180923.3441359-4-irogers@google.com>
References: <20261105180923.3441359-1-irogers@google.com>
 <20261105180923.3441359-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:15:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add zlib-rs and zlib to FEATURE_TESTS and FEATURE_DISPLAY in
> tools/bpf/bpftool/Makefile and use feature_rust_lib to configure
> ZLIB_CFLAGS and ZLIB_LIBS when zlib-rs is detected (unless disabled with
> NO_ZLIB_RS=3D1), falling back to -lz. Also replace -lz with $(ZLIB_LIBS)
> in static llvm-config --system-libs.
>=20
> Decompression of kernel configuration (/proc/config.gz) and compressed
> ELF/BTF sections (via libbpf, and via libelf/libbfd/libLLVM in static
> builds) processes data that benefits from a memory-safe implementation.
> Preferring zlib-rs over C zlib provides memory safety and improved
> decompression performance while keeping bpftool aligned with tools/perf
> (including sharing libz_rs.a when building bootstrap bpftool for perf
> BPF skeletons).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105180923.3441=
359-1-irogers@google.com?part=3D3

