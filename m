Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0344F565
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933757; cv=none; b=TPWdKC7myhggJi7D7zekxWTewEd9k5/5d6OSN9AvBQ6G/A4d7g7RZNIxx1wNumC3ET2sCln2bd/1wtU2l+rJXCAKmHbsnHSmPcPwlAB4w6Z7yokx2eKfR/Ub3+ZPDuhbmaX2b1G4wETAYRxBIJLS82L3X1+ikGXcJA45neVOO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933757; c=relaxed/simple;
	bh=UEGWUKksUpGeFiOY70Wg0WeZSPQyEf4hI9y9TBW//3g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aUK8IiCl4OftLAgf8xtjukjdQNRW9Jc/27sKbHULpwXC/7KdGS38/zx+LOz41rzhH9txPjo5y1V12RMuZha+Z1azFHoMkrEqNolonXqyuxkL5n/3d7NM+9M5ZtbYfnNWbXB43pu7B1je6cGz/RbDuSbNOcUxRw08XlIRKaM3W68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NALsaevc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NALsaevc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE0E1F000FF;
	Tue, 13 Oct 2026 23:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791933756;
	bh=UEGWUKksUpGeFiOY70Wg0WeZSPQyEf4hI9y9TBW//3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NALsaevcAT4xgKTE8t13igVYIBylAW2dlLYk04V3i9DR02z3c18ZRXXSRPOc2u9Qg
	 /7k1Mur1Evejwt7P9DvNLYEticejAqsVvt5J7RQJPWZpG6HlZCPjOl/xZJ8O9bUeQ4
	 Y3xgrP7sLpYseWsjGCVej/yp/m7d3j9XXXNjr/ebmdso4ACQ2yTJTkQl1Pgc19tXcp
	 nIKaU9IKQvD0woTC9hBJHCn0x4Mgr9xcycaOOe22c3/Y68KKautbBzKpJN4+fxlk0l
	 UQKxhsDF1iRi4KFFsXFvkre0TKQBloiS5BFiKQmcuaXlYqUL1CpzBtukByfJIPkslc
	 UtdJP6QZlemeA==
Message-ID: <sashiko-outbox-170633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf build: Support building BPF skeletons with
 bpf-gcc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013231430.2163505-2-irogers@google.com>
References: <20261013221643.1815686-1-irogers@google.com>
 <20261013231430.2163505-1-irogers@google.com>
 <20261013231430.2163505-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 23:22:35 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Support building perf BPF skeletons with bpf-gcc (>=3D 14.0.0) in addition
> to clang (>=3D 12.0.1), similar to tools/testing/selftests/bpf/Makefile.
>=20
> When building perf with GCC (CC_NO_CLANG=3D1), prefer bpf-gcc and fall
> back to clang if bpf-gcc is unavailable or too old. When building with
> Clang/LLVM (CC_NO_CLANG=3D0), prefer clang and fall back to bpf-gcc.
> Explicit command-line overrides via BPF_GCC=3D... or CLANG=3D... are
> respected, and setting BPF_GCC=3D or CLANG=3D to empty disables that
> compiler.
>=20
> In bpf_skel.mak, pass the bpf-gcc flags (-mcpu=3Dv3, -fno-ident,
> -DBPF_NO_PRESERVE_ACCESS_INDEX, -Wno-attributes,
> -D__TARGET_ARCH_$(SRCARCH), and target endianness) and query system
> include paths from $(CC).
>=20
> Also update version-ge3 and version-lt3 in tools/scripts/utilities.mak
> to split the two version arguments separately in awk so empty or
> fewer-than-3-component version strings do not shift fields across
> arguments.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013231430.2163=
505-1-irogers@google.com?part=3D1

