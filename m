Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792F34678C
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931112; cv=none; b=FoWMcfFpufFrTPxxzBL+7nQPlZtwPrFeoqEUwrBWR80qd25TQGfoSmQiEQWlqoPitoi5gXJ7sBizlw20Iq9YqJtxBsqujsgYvhqIW01UCIyk3mJylM68zE3qdzmOS6oNyMnZQpo1BDeNMc+FLGG5mVR88CBO10sXQYr83h5VPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931112; c=relaxed/simple;
	bh=IYtxRGjLVzmjDpUndfMzgWCP+O3WeLhiIFqPgkxhOF0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XoUUrDFvlBXBu/Dubq48ialuxv9YPirT5j+YhV9B0VBP231FYffZIbIRRwyqMRdl/smwJIniSaNpn+hFejA3Tkwo0lijBapP7UzzrSDF7zv9xpnY/a59y5W99f/AkV6QouuQkIc2MgZSo5hXnc9pY83jvFvDz8uWjN07D6rHV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfeC6VQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfeC6VQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EA21F000E9;
	Wed,  1 Jul 2026 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782931110;
	bh=00e8layYW/wnrdqGaJ1Hl6GaRkjQAqM86B/TWjWFCcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mfeC6VQIUxY5XDq2i3mRgNWTrcTN1c2bDKkansM4GmghYKrO9++0RJFmmHfclCSBT
	 syDDTt060/g/EkijMgjBGCM5YbxJ0jR1wP9rOV0dcJY1QgvHRn0xCmxHIP+p5Cv2VC
	 GyLSQOm5Xn++uFioxW7wW5bSeGsdgj5iVO29RRin1uEA35wWXmBFlBTtbx5RCGC3+g
	 V9BAYo9Q2AHdM+ms5C8aGvZ+LYXPg4135xfGYRHBO3/DmPPA3DMr2g4WspE4RhGdoB
	 13oTTXCBas5/MVnhJu60OQEJUsrSEXwk/Rin2f5j2+stPiuHcWGOfYO/Y7z2TxeVnP
	 xplpeSY1sOJyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf build: Fix compiler errors with old capstone
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701182824.347941-1-namhyung@kernel.org>
References: <20260701182824.347941-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 18:38:29 +0000
Message-Id: <20260701183830.65EA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Defining CS_ARCH_RISCV as CS_ARCH_MAX causes incorrect architectur=
e selection when dynamically loading newer Capstone versions.
--

commit c55db50010b415e5aa95bfca7819cc985aa51d2f
Author: Namhyung Kim <namhyung@kernel.org>

perf build: Fix compiler errors with old capstone

This commit fixes a build error on systems with Capstone versions older than
5 by defining missing RISC-V architecture and mode constants. It uses the
major version macro to conditionally define these symbols.

> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 5ad537fea4360..dd7cd97d0a380 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
> @@ -24,6 +24,13 @@
>  #include "symbol.h"
>  #include "thread.h"
> =20
> +#if CS_VERSION_MAJOR < 5
> +#define CS_ARCH_RISCV    CS_ARCH_MAX

[Severity: High]
Does mapping CS_ARCH_RISCV to CS_ARCH_MAX cause ABI compatibility issues?

If perf is compiled against Capstone headers < 5, it will use the integer
value of CS_ARCH_MAX for CS_ARCH_RISCV. If the resulting binary is later run
on a system where libcapstone.so has been upgraded to version 5+, passing
this hardcoded value to cs_open() might silently initialize a completely
different architecture that was appended to the enum in V5 (such as WASM or
BPF).

Could this result in cs_open() succeeding but silently producing garbage
disassembly for RISC-V targets?

> +#define CS_MODE_RISCV32  1
> +#define CS_MODE_RISCV64  2
> +#define CS_MODE_RISCVC   4
> +#endif

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701182824.3479=
41-1-namhyung@kernel.org?part=3D1
