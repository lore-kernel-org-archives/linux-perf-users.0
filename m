Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599706;
	b=3HYMikfoptGwb9Lh0HdV/thQO2GZdJZlzpVwKmpuyQaMmgHx5eSVd6PLRX1zgvXu9Epu
	 nE95FwelKyRsVezeKQaM/FbdlrWyYrg+aKPJx0q5LeHZLKGXBWdudKSuBjuH5zU/m4HXs
	 Z1D8OhEP5pkIushkUEd47ARZaMyW3C3bQX80MMqx5zwxyzh6aossgOO6hqczXLJr++zdq
	 7PFB6y4c7LiwJJkQVwjT8O2bBiMH+3jFtdRTMaYSNzRAwSvO0RruUNQJ3fqKW39ZC8Tgu
	 ygro7jv37Nr9GXxf3TJsWZ2CgSYfk3Jza3U6BXtnG9qf9Z2km6Dbo1yaqcAyvWqlk5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599706;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T7gc0Wz0E8bjyAVyYA2IwP343SebQXACsaGwbgJqbC4=;
	b=Nj+UWzTJ03uc3/MLZ/92NDL9JvEamnofh0M2A3ljEGzI8XX9YfWwGRALeGkRnFsXqsUb
	 KFGV2ntaIz/d/ighWpI3VohuxFQYQYnxGSs18if5J7S8nnB2LO/8pmkX0WAuzFCr5TLKQ
	 snPIct1IJARBedDoo8EfpAaq7xthxNDPbn91yg+AefV307zSGPBMLHXPuUlJex0qtdRPR
	 3awqFiNUcyNsn6VKbQKh6wUFyeIe2hl3jyhE1/XZ18dJDB29hnLLCjllQRL1xKyi/Y3An
	 Oi3zvIcC1Y6vJX93xC+AEF4WpkPv5LFuw9gHjv1iAD4BjWARnbQjj4q8n3oe/ITHBZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tp9mJY56;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60CF60A3814
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tp9mJY56
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870561F000C4;
	Fri, 13 Nov 2026 19:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599706;
	bh=T7gc0Wz0E8bjyAVyYA2IwP343SebQXACsaGwbgJqbC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tp9mJY56I2ATFRhQFFkMdguc2izV9UnGJusUox+wPu8FpHT9lH4uZj/2V4Xn0d6Kl
	 VlVf+m8ceDg+2XbMEeKtS6oRHF1mVsYBhLnkeX/MEDXgLRzOxY3RH4E5R917viYhgB
	 W0yOV2zIizqSX8RBf9geShbWQlO6yY2FoY0wrCSwuOjMpRDJbtu4MDy+K1OcPOpLCq
	 wQVBRZoZ+Ek4q3XffySK9dZ/VdrwJ6cMid+XTovRx5e0hU7CQWsr6iQAxhu5GQ0750
	 4CzKqEWMhDUtTOfgNU7f/leBE+1S0LKvAChVjxqQdpDxrZdu8ATUczlv/kZb+fy23m
	 alVgSImNoAvPg==
Message-ID: <sashiko-outbox-213587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] tools: build kernel selftests in tools_build
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112195427.3411746-6-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
 <20261112195427.3411746-6-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:55:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a "Kernel selftests" sub-menu with one entry per selftests directory
> that builds with only a C library and does not write into the source
> tree. Each is built as "make kselftest-all" builds it, with KHDR_INCLUDES
> pointing at the UAPI headers installed in the object tree, but by its own
> make, so the selected ones build in parallel. Selftests whose Makefile
> does not use KHDR_INCLUDES still build against the C library's copy of
> the UAPI headers.
>=20
> As with "make kselftest-all", a selftest that fails to build does not
> fail the build unless FORCE_TARGETS is set. kselftest_deps.sh then lists
> the libraries the selftest needs that the compiler cannot link with.
>=20
> The selftests do not track header dependencies, so a selftest is built
> again from scratch when its own directory, a header or makefile any
> selftest may share, or the kernel sources and headers it includes (the
> vDSO test includes the architecture's vDSO code) are newer than its last
> build.
>=20
> Selftests that need libraries beyond the C library, a vmlinux with BTF,
> or a sanitizer runtime are left out for now.
>=20
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112195427.3411=
746-1-sashal@kernel.org?part=3D5

