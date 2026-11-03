Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672003;
	b=tDsbZQyQHzVqpiZOqNSZFq9+BepUnt8TJn1eaiDKK62783h2ydxUfoyzpTkqn0hM5/sb
	 phy4ft7bb88DNNXlP0LmMcHuCpe7L7FbWr6xXFQg7njpUITU1NluXB8ASZiqdxqffgUyA
	 kmpv7qB3vTb7aU559/t2TW/A+gGoRP05Vk0KzHTPey/uWUhO0O66+yNsOoIKLpguAc3OQ
	 NgswzR9BAfKUaOTRqtECFEvlEC1I9KXtuDKrNfARY7HMZYl+lsYsgaCyQN2i/moc6U3YX
	 owa0Fi5kmqpygbWVOeVsrmBI4zz6v/vvuy5aTRKSXRXHoEFmCr+D83nIaXbETRlAMAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672003;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nDLLHAjOuHN0srPLlLtAkeX4woUzEboEx+B4wWrYToc=;
	b=jlYeUcj/OG/TvW9tnRxbfqmlEeOCdZSQbtdKB2ubIQOlwnGrTOr56iJpbsq4NrPDRkIp
	 D+W2bFtO3LmxA16wJ4FgHGmhg7oFJeZ6LBRG43/IZGaRg/XWBZpWkg35hohbnnQWMlHMz
	 jDPlHFudNwsGsx12omnYbMbsYH3yYQqzT2G+H2deQ1HQB2xzdtxwgrnZtDeDDy+jPSjA9
	 FzQKatX601PFOpYPsONQ52T6+7Iol85T5Gd6ExaeniAYmno0XhMPLJhu6vsfd7T9+pEuO
	 6OwM7ebtjr/bAuzTSAQZIwbO2NH+UGqvPe2lObOxsLnN4M79Z+xRU9LdJ0hySIbvSSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbsgMkrj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD18606A32E
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbsgMkrj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA30C1F000C1;
	Tue,  3 Nov 2026 02:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793672003;
	bh=nDLLHAjOuHN0srPLlLtAkeX4woUzEboEx+B4wWrYToc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nbsgMkrjo0Sq7DJXRfe7Kw5DPuctpveRDzIB/Q+afeyic4MGJSQoUr6qgV8K2S8KU
	 nzu57SIYCK4sHNPAFZlISkCgTw4QIE+r3XuPzB6InvbGfqJ4nARLfhu7PZyHKuXaz8
	 uBw82G7Y4HgSCOcGWTSY3Qq8RuHJFLOujl9cvZTxeO0cOa+HVIm7cm2figA4uPf9Eb
	 /OLkHDN2mm5g1bwhSLGF+bUWfcMZtVq8+EUSPK1n/r5nEe/Gb+VU+yHJF1n/7cyGFO
	 odDhhiOvoc+Xp2pQH3RjwbZ698tI6FGCf+dRZ5uBpSf+Y82hBoHyzoPpXUS3d557wt
	 E1GWP2za73qhw==
Message-ID: <sashiko-outbox-194451@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] perf build: Add MINIMAL=1 to build without
 optional features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102021253.2545235-4-sashal@kernel.org>
References: <20261102021253.2545235-1-sashal@kernel.org>
 <20261102021253.2545235-4-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:13:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Turning off every optional feature takes a long list of NO_* variables,
> and the list has to follow features as they are added and renamed. The
> one in tests/make for make_minimal has fallen behind: it leaves
> libtraceevent, jevents, slang, AIO, LZMA, zlib, libLLVM and Rust to be
> detected, so a make_minimal build still needs libtraceevent and python.
>=20
> Add MINIMAL=3D1, which turns off every optional feature, the BPF
> skeletons, and the shellcheck, mypy and pylint runs. perf then builds,
> natively or cross, with no library beyond the C library and without
> python, pkg-config, clang or rustc, and the result does not depend on
> what is installed on the build machine.
>=20
> A MINIMAL=3D1 build also leaves out the notices that post unwind and
> python support are disabled, which it asked for, and the one about the
> pkg-config search path for cross builds, as pkg-config is not needed
> then.
>=20
> It is handled in Makefile.perf rather than Makefile.config, as
> Makefile.config is included after the pkg-config, shellcheck, mypy and
> pylint setup.
>=20
> Use it for make_minimal in tests/make.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Link: https://lore.kernel.org/r/CAP-5=3DfWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9=
q1rtZ0Vi0dng@mail.gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102021253.2545=
235-1-sashal@kernel.org?part=3D3

