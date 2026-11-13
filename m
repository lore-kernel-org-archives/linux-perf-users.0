Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599704;
	b=LWemjYr3NTn5j6JLxXBrmEeSUskxrnR0y8iUtNIwgct+BfpEikJJN6YceFw+KJPRRY08
	 i85T/PTRIJKEmRfcqAapOdGTR7bV4/9fIC7ZL85WMdCB/iyLkWNRKTuoNcNa0BraiiXn0
	 eePEFqcaw2EGsTDF0H5gofk/JhY9iMaJRWxzKvnu+pPUawUL4/MyjQYrwz5yxu0ygIRFi
	 iMoC9K2c1XGt0/NcxEVKNyMOuphM3efhzXIaGM3G/qPXjeetNabN+eEDPPXcVyPF/ogoD
	 zzUk0IuJBaSXrlftlx31DbRpzS/gozVdP7fVybxkxODLwErohYiwJdXfEl2HZmqSQOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599704;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nMvySVL4awp0Cpx6K2zdffBlc3pp27BqA8hAZZUsUoM=;
	b=KDnXACVUydjpUoEoLaP3YX6yM1KFnzb8N0PogXXNsCA3IiZYiq1ZFa1NWn9Yh+REiPsM
	 71Gu8pKQUK6nTtezDwqpfKlqCR3I1UvHrLtMv+fYU7YNlxbR1BBKoYhMFccLsh3sSOxYz
	 pdQ1iefVCIZ7j0nDssKLC7yrBbxCvMOs6rp6BSYwNdf1YHkpwdog5PWFoM+5YAyr/s6TQ
	 gvUPs6SLLa8JIyzIuhpv7cF2zjt0b10nYSzpcv0FjwkLMjDzcS9amUivaijRESkYviIqS
	 6r1g7iP1s0A31kNgR027g4xb9WfUJU0b5Eef4p3o71mRP6F4+O+QS9B8xbvenTb2utQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXR9WuIw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A2606BCE8
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXR9WuIw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8829A1F000C4;
	Fri, 13 Nov 2026 19:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599704;
	bh=nMvySVL4awp0Cpx6K2zdffBlc3pp27BqA8hAZZUsUoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XXR9WuIw0UtJPXtkeYKxlcSmQ3xzWpq5Y4dLBDe8wCk5cOaiNTzfxKT7e8P/Ummw0
	 b740Uk5YlJcm6Luj+pYVMo4ZTip5WPv8pg/5KsAKE5NbBEl2mA4SrE7j+zBlT3HK/z
	 LCBLYRClMIQkfbRZ2K+gbSsOLc5T2pPxDclwbJCPKy/WL2MiOLFQ2XSN0LPyIJbXFw
	 Z8kN+55MUcRGtR4pG+500J4MTXAEhKrrtGbcJBuuFCcTPw8YVya0t8HLBqKr3kWQ3j
	 J9O5mA2rQqzwtWognpFCffVmxrwZJGou13aZTidSPMEkFRcH2T0xt+JX29gx3/2+Kq
	 v50LY2ACDsLwg==
Message-ID: <sashiko-outbox-213585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] perf build: Add MINIMAL=1 to build without
 optional features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112195427.3411746-4-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
 <20261112195427.3411746-4-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:55:04 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112195427.3411=
746-1-sashal@kernel.org?part=3D3

