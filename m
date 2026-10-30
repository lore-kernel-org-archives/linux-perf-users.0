Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393088;
	b=P15NqPdkrO6+q+SPmYIF1wCbmkyXNX3D/ocEsfeEwTCVqgA6+8N21CtOQGeNHTpmZqQL
	 VhMdFs3NxEGKIg5EcAazJ+KMgpV8N81hCRu4Mi5/UyU9gEnFXaDL9vXdB9FCdqFztoDVV
	 eWXNKBLSz8DpbRk94TEhLZEPrc6AQAesqYfsGuDsQy/uJmNhfFnjSPWI01U/mP3YhTnCL
	 ySXaO32XiTVDUsxs3Z6Dm6yJITUbO9uIRfL3sQPeuXRb5He+X8km5MtHxqwzyUPSpvrEh
	 7IKFJTmG2H0pIzjNl7BbxuuX0czKHD8qtqbYQ4tc8G86e/6O+CsTrbpTj61DdzPQ7vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393088;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9/qpgToIxfOh5LcxzOE7qzEh9PSlSfGsG1zq9qee+K8=;
	b=3WN54JGPiDaerGb9zWDdv+lglY07/H+PkKu3i3pREmJj54dsMOuaqivxQ9xYbOgCXxDv
	 HPu4AU3MB71vFTjIneCOnynF9hq+WmavXu9G+bg2DgblMwHEelHyXE1AT0kphh6dS1yuI
	 IMWfwrsLQ1iL3dUzN0drvUkqxngVrSzFQu8DJJ46BZbJfgk0rkaK5bQ4I6Q9rvCcAlP0W
	 0PpSxaJeOBpyyygr/aq1rmI3HnA2fuVUyMJeobmnwDp7d8XhmS7oIs2uMHsRATsJFthys
	 WwwFQp/C0hbWtHb3RxQIXd+oY2ro4gm2ViAUFGaYLuJYd1+E6FHmvEm2GPsVZYC8udQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Nn/aLToa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF1606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nn/aLToa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740481F00A02;
	Fri, 30 Oct 2026 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793393087;
	bh=9/qpgToIxfOh5LcxzOE7qzEh9PSlSfGsG1zq9qee+K8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nn/aLToainv37BCZVz93k1W/HewrEpRpTUNr57Sk8JN3c1NMbuSVs3OrDNQRDkrAF
	 DPFWV17Xau3RFfeB+pLoYGkssJcSFknokygV+t8XmUQrbQkk6oqOVPJLVPp8BgWUNu
	 /iZRExq7O2ay/usRVG6nPfiCvWY5mEghaabv34vPR+MOpjeT6tZMu6do1/eHujFYae
	 j7dTy9cfjVG5xBkvg11dhBvO+LxyTfs3SjWReBgFB9nHSBR8+Igcrmd2K84p27NlBc
	 rQ1kHJnnu8CNto9ioZKNMFOtOyZFVjBitukGT2fH4D71LejQrlP0RCINDwfsBhur5g
	 XjVmGOMLRUy1Q==
Message-ID: <sashiko-outbox-191491@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/3] tools build: Add Rust library build
 infrastructure and zlib-rs feature test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030202710.3863806-2-irogers@google.com>
References: <20261030202710.3863806-1-irogers@google.com>
 <20261030202710.3863806-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 20:44:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add shared Rust library build and feature detection support across tools/
> and implement the zlib-rs feature check:
>=20
> - Add tools/build/Makefile.rust with rules to resolve Rust library C
>   compiler and linker flags via %-cflags and %-libs targets.
> - Support resolving zlib-rs via LIBZ_RS_DIR, pkg-config
>   (libz-rs-sys-cdylib, zlib-rs, z_rs), or building libz_rs.a into
>   $(OUTPUT)libz_rs/ from the system Cargo registry
>   (/usr/share/cargo/registry) using offline Cargo (cargo metadata and
>   cargo build --offline).
> - Add tools/build/feature/test-zlib-rs.c verifying ZLIB_VER_SUBREVISION
>   =3D=3D 15 (0xf) and linking against inflateInit().
> - Add RUST_TARGET_FLAGS_<arch> cross-compilation triples and the
>   feature_rust_lib helper macro to tools/scripts/Makefile.include.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030202710.3863=
806-1-irogers@google.com?part=3D1

