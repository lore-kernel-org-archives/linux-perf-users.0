Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BB4C2270
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331875; cv=none; b=gINIrvqBdXCzK8gRt404EIg3JG4tkPT2Sp3hVlcDdVo59kjbpt4cxc5NGKbHa4dEQHGX82bKQzJnh3DHzCYQbX1ZOS1sPsvDNtaFnGEhwcnwCadGnrnl56OQNlqY1tZ84ZXf0mtMnKZz6QbiYFTUlTqpuR7AYUWGlsfWTXoMNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331875; c=relaxed/simple;
	bh=UkErHVQBNyPYwvnvk4nvM8RnG6rAa28MT0je6L5aj5E=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rpPYglq8fXoYpYsOh8wX3lH+Dtjni80LqqUy0OYrIFxq3cmmEIpO7A2cQ5NBBpuA/w1JxV7HBx7OO5DxuNkrOCiKv7Qq46em5QV9AQfwAb8n54ew5zWmlyROKfeA1AW3BDXzZxfvW1az6Tq1cbL540av6UGoe4bWmAFDUOv/kJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGuCcE/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGuCcE/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55AD1F000C4;
	Sun, 18 Oct 2026 13:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792331873;
	bh=UkErHVQBNyPYwvnvk4nvM8RnG6rAa28MT0je6L5aj5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EGuCcE/AaMvbmOZkc9FEMyZ57WURqWq4YVrbXvU3k70huK3KKIP1eaa2D/bvDQvcH
	 iYZEX3dC8Vfyy7cuTZ2QJJaB4n3Q/JV4eDZ+Pn9OMVFXSbFVkRzB1ygeBTXrjzp3ko
	 4wfXbDUQYMJhKTa0QaKs4YkV8HoD/XoDD9UkDIkHM1E9ylrIzOFcOgFZikpb4DSgnd
	 1CAkiVOxgHqGjp5oqZrDxcOgscOQnUOIK7u8ZyVkLN5OI4+cPvVduM1uYosY9IEqx4
	 PoAiMteJMTuij924M58uQnyEP7OAAN0e87VKRfxMCg592D0g7BEO1iCRpyBgiVaNDp
	 buXk2E0+NDU1w==
Message-ID: <sashiko-outbox-176171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf build: Add MINIMAL=1 to build without optional
 features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018135321.3986899-1-sashal@kernel.org>
References: <20261018135321.3986899-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:57:53 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

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
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018135321.3986=
899-1-sashal@kernel.org?part=3D1

