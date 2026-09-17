Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1230D3AAF50
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621218; cv=none; b=Tm57kxUCod1zmzzi/XvYWHDqu+eaHRzuUtXZ1SQL1I5OvzNRK6Sdo1tpJ7BN4iy+iIkQC9fYBVqzkx22zlATWnfa/g4oWMCOEh3EI/a9C17vZPCEjPaYa16vOFjWgbm2ToYqwcmmKEvKR3iAF3Pfhgt7h9aOOMORZY66PnUpnfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621218; c=relaxed/simple;
	bh=7J4YWUR9cH7y/BHYGkhwGog2P6A607pnLviWCdA5kZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P4RyGeS4J7IDQWJh0uWwtlWLvR5P5bejE5PSYp0K+OvXqbaY2KcSCwVDhAEi8XT1HeRmmnY/YFaq68qIg5LwO0a6p8lSScEcEQxmhKXR+PMrEjZXTiw2lnTOie4Xq4hHqXKJRpI5dPR9/N+HH+fKFHF+mnAll2E97DVEwlQ8BOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBArU10Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBArU10Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E031F000FF;
	Thu, 17 Sep 2026 05:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621216;
	bh=ChG6ogTFYfCeUUZSIQLYcKXBzv9Nj9m3nSNvx39xCQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XBArU10QDOdUDt6V64bnZJlcc5nV3PxFhSCWVlsL8gmyVJfVFfBW5fy0OqqDperDX
	 9lDoYd2wYh4aokhLW+frpfv+gYMkg2mB51QaNLh7Cs4USTWcRnMfW1sMdmXDTCPwU3
	 EipwWBNeWi+7ApyQIv4vIhU+ESlio1EuxhkfaRKoHlx0ZyidFdSEWz662Gs6E6FnlM
	 9CUQXAsbXcrLoAhz8e4hJN6Q3HL6UKvp7K92b5TJtmgfYWndeEOVpmcJ0d7UP68x4F
	 ocWVgSpxNprPWKejrDIT8A9nqItGfqCqY50u8ZZcRFgwKZ3aRNMlGR3Egjw3rcFaEH
	 BLjBHeUs8g+AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/11] perf llvm: missing explicit POSIX headers in
 symbol__disassemble_llvm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917045326.63601-4-irogers@google.com>
References: <20260917045326.63601-1-irogers@google.com>
 <20260917045326.63601-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:00:16 +0000
Message-Id: <20260917050016.79E031F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko reported:
>=20
>   When building the perf tool in an environment utilizing a strict C
>   library such as musl libc, compilation fails because
>   tools/perf/util/llvm.c omits explicit inclusion of <stdlib.h> and
>   <inttypes.h>.
>=20
>   The function symbol__disassemble_llvm() directly invokes free() for
>   memory deallocation and utilizes the PRIx64 macro for formatting
>   64-bit integers.  While glibc often implicitly provides these POSIX
>   definitions via other includes, relying on transitive inclusion
>   creates a brittle dependency that violates perf subsystem
>   portability guidelines. On environments that do not implicitly pull
>   in these headers, the compiler encounters undeclared identifier and
>   unknown type name errors for free() and PRIx64, preventing
>   successful builds of the perf toolchain.
>=20
> Add the header files and use git clang-format to sort.
>=20
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917045326.6360=
1-1-irogers@google.com?part=3D4

