Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600055;
	b=LdtFIOBXZKmNsV+mn9DivPH8u503QLEIUMI29i7aD116JOjwx7LpIK8Nzxizet8vUbAc
	 qVezaaP2fesoUbncyJxuAOWSLXboT6ZKhWiV9TlT22V8VodIr8xzWSRhxJ70nZeEAafvX
	 gCwIN0izDJXkVJEuZu2OZkXMbu1yQFLiPbGHxzhe2wddCPslBF0XvAJi+GOpSwgcqNvGY
	 uLIC/dYTjLcZrehmcFj+eiNpM1snA8TlZrLuHgp/jI9lhO1u2/tkbG0wWNTZ217XlaiUm
	 Eves+tWthMdxx0jEL+XMjDx8N2YMJziPkWGeLr4VnLyE75yLHbnn6FAQwVSqNOCkJ/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600055;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wwBmaQ92qAcGNlOC3SfjTccqU72Gj59jRbnK6NdfSH4=;
	b=cVc49Amu8CyIXST9M4dg+hw5L4bxlHqzioHyToR5DfdhjVOWdtNR/pD2UjRRM507rKDW
	 Auow5xThF1Hviua8mS3MgELwgCxOrdScE4wF3H9TBklcmxiUgKBTiNvblQaXjUV83ePx3
	 ub5/br+hszoMFAt+exz+hG5WbrhBiffPN6Sq9TCdxTakNIWCBfJ5Y+CkFDD6zNQxaMBQ+
	 yFBIa09v5xa4F9z9m9YV8bPhP4PoWMnOHMGm7OcCRFd22SURcXngQvthvBh0QR9hwwx8I
	 xYlsi+4+NVekkOn2SSNdiQwDYZ8qdrTrTElaaUHLRYDjXUUQmvQBhcbwcADGpaRyUog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6UQ7At0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E9F606A33F
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6UQ7At0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1829F1F000C5;
	Fri, 13 Nov 2026 20:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600055;
	bh=wwBmaQ92qAcGNlOC3SfjTccqU72Gj59jRbnK6NdfSH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6UQ7At0qbwo/t9IKHyFazJcqhBxhKg6Uq4ioq5EoYf1D4JyJvzMPn6ATu4vNwlox
	 2Q2biEPVlYfbCT52iC8r78aC5TJ0Qqb3oTl0UCw7OgpUjbKYzQaBRvwuN0GWdkSzJI
	 TDrXteOWDKfEP9IKGQ1o90B71kMfKbZxkGMZST+co8YoqFbE6fe4o08/hALuKQWhgI
	 lslKU+xVJkO4YvQQev6yO8gPYOVmgt43VCMVUEeMQaG0TELL/3EgSOMhXcCjGiqlWW
	 8CGntPL33i56ekhnkFtn9CLLpMKchsU/hybWGIx7ttu7PadL7CNCo4ciLq1Wb3JxPV
	 LdPyfZ6kxtsHA==
Message-ID: <sashiko-outbox-213599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/30] perf dwarf-regs: Add e_machine__same_arch()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-18-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:00:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The 32-bit and 64-bit variants of some architectures have different ELF
> machines, such as EM_386 and EM_X86_64, while others, such as RISC-V,
> MIPS and PA-RISC, use one ELF machine for both. Code wanting to know if
> two ELF machines are the same architecture either normalized the ELF
> machine itself, as in pmu_events_map__e_machine_matches(), or compared
> the strings from perf_env__arch(). perf_env__arch() maps EM_386 and
> EM_X86_64 to "x86", but distinguishes "riscv" and "riscv64", "mips" and
> "mips64", and "parisc" and "parisc64" by whether the kernel is 64-bit,
> and computing it requires string lookups.
>=20
> Add e_machine__64bit(), giving the ELF machine of the 64-bit variant of
> an architecture, and e_machine__same_arch() next to EM_HOST. EM_ARM and
> EM_AARCH64 remain distinct architectures. Use them when matching
> pmu-events tables and in is_pmu_core_len(), which compares a perf_env's
> architecture with the host's.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D17

