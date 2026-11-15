Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707164;
	b=B/HLBSMyu8InQJJ6tyJfxlWziYT58TbVU1/06w6m45Ns6JDVKVsuN8tN9RokqT80ZRcL
	 sDi9WYUPv0Y3TSkpdoj5LKAm9EoR7KyK16aXdYSrBFuKBY1w5/52fECCbJUJ31pcSVfyZ
	 CbA2LYRIiUY0Hguhdj18kpI4LJvN40lWAA1AvxmbxbLW5G8+r33bACw5+MDUdjAlzPYwS
	 rg8xevRmkM04R+q8HSeXEL4KKMI6WKo40SzO/r2EQY1h/WWTXgLTlopkJtkqvRikE5exf
	 k5/yZ0FaUvaO8AeGgik4k8AjbV21P53ZKEotbbLHzxltQyr/IqfILnnHbMEY3jZbwWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707164;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hHKy+ob02XX09iSBY6mviZKbWFpRNWKR2r1yJTIKEHY=;
	b=S85uP9YNJWpUxORVVh9dJ/CAg4AnU16NTe/UOaS7Dlely608TG1lVPXejtW9RhsZHxQb
	 npLADu0JaNfvt1f6xbjoVllb44+HfUAM3VFQGN+JXkfPQPzD/EkxqbmmTQv+YSgDni7Iy
	 zDRtIF4bow4U/b85/UEHJiZeikAh53Mi+82QAraCslgPS444BIZjwJUKy53iagzZfsCry
	 H+lL3NrOIk0RwMi8tAx6uKmWishMyHMDlLF776Im3OltrXOH3Pc4QbA7u+MhlzpI2R92O
	 /PyYMAkovLFxtXrNKP+Y+iil+zICk1Y6nKDmxmdBDSNNVjEvFN/lEHK9vqR8KRvHt5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnOAbnNY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A07606A329
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 01:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnOAbnNY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2721F000C4;
	Sun, 15 Nov 2026 01:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707163;
	bh=hHKy+ob02XX09iSBY6mviZKbWFpRNWKR2r1yJTIKEHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fnOAbnNYb/c4rlPDCK2mTfPkKF8seboPAtN3HSbQAPscvmdb4FT0jb+cR2+NIVNeu
	 vFpG3D1psVNZFsgkE6KORON7IpXVH3y9wDFrT2eeg2LJyzICH+BEBJjxzGd3fe3PLi
	 3yB9JkfG98LRRD2zt9rn4PnOS7G39P/lMb8YLFJI1euK1ytUr/0yTDVlM/Pb7moX4Q
	 dJvSJ6Qd/6TDG0yW1dkeowvBeV1EyHMKOwlSe3+KcjCqvhdB4hcoaVk16BmwvtpQOw
	 CRkX11d33vQMmnVI7a87dJbJg/hQnM2LSAgB4R3+JlNIJ6/g1eDxGI7GkbauKI95Qg
	 rL+vI6TNgB1Wg==
Message-ID: <sashiko-outbox-215167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/12] perf tests: Silence the libbfd probe in
 build-test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115014102.2879372-9-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
 <20261115014102.2879372-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 01:46:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> build-test evaluates the libbfd probe at parse time and the compiler's
> stderr isn't captured by $(shell ...), so without binutils-devel it
> prints "bfd.h: No such file or directory" once per tests/make
> invocation, five times per run.
>=20
> Redirect the compiler's stderr; the empty result still skips the
> nondistro tests as intended.
>=20
> Fixes: 523471c5163659c6 ("perf build: Skip nondistro build test if libbfd=
 is old")
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115014102.2879=
372-1-acme@kernel.org?part=3D8

