Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C5349CC6
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297704; cv=none; b=uhhTgCbQwAFG6zjnnB6FdNlPAbH/fN89aZLUQ+J3tPQewKqErxRTOaR+L3W46DA6AQJL2Dg0WucHJEnFGoOJnTHflKaU/oHHUDTZChfKcmg7ulrL2CxdYZiEALpHPLo2QYgwd+J2Khqkz4fXMscVpjKIuAaZvVynW8DcRcJg5TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297704; c=relaxed/simple;
	bh=ETAijtjRKgtW8sIMaLnXpJ8bnFxihrC0lHdSyzwekCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oM2aKYf5V0sTvkjMH/UIbGDA69YUp5OZncHWTOcHPuPwp1QLuQtCLHTdnCuI6M78Mdo41OQhPFnuNNiDsQvPN/9rw/Q249Rq7RgdDcWK3KlE+mQOSZfd+b62hjmdt1/OummMXCcYD6ZXc2aT50NwBpjkrzld406s7x6vFWCzJyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iK9Uasgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iK9Uasgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809301F00893;
	Mon,  1 Jun 2026 07:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780297703;
	bh=rJMaXngmBFybMz1+W4aExNLZg7qrddJ8zMae+Dk2iwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iK9UasgwyBZ0Y0EJr3/Nlo42TTvBiaajuBRHQmUUaDEEYYzfOJO1pjYaio/7/hpwv
	 rz+vuplD+UvzFwF9TwlSCp4od2A3wNjzx99NoYSjX8NBRhtThpA4JRQ08s0Wooj+aT
	 9tiveXTcXxmVkHmbi0YNsuBzL1DbrGBmWl3VKyA4QNncLx2tsDyo4sf4EgBEDLJLlx
	 XckcF1pBEw/mh8Po9og/9R3EohX+So8TPevOEbv3mXM18KYjo4T/BWRzX2/PN1B5FL
	 0psxT2SZi2LnFhy6Cs8mtD8b0hYKumAnLqkhLU4T5H6keLCL4OyU33OZZlv9MgldMQ
	 SM3vlu+ZN6ZkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/18] perf capstone: Determine architecture from
 e_machine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601065407.1597927-5-irogers@google.com>
References: <20260601065407.1597927-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 07:08:23 +0000
Message-Id: <20260601070823.809301F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] RISC-V Capstone initialization omits the CS_MODE_RISCVC flag, br=
eaking disassembly of compressed instructions.
--

commit 18a82eb3adc97143851fdd5ceee9d79bbd3d188d
Author: Ian Rogers <irogers@google.com>

perf capstone: Determine architecture from e_machine

This patch updates Capstone initialization to use the ELF e_machine header
for architecture detection instead of relying on less precise architecture
strings. It also adds new e_machine translations for MIPS and RISC-V.

> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 25cf6e15ec272..065b5d4d448a3 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
[ ... ]
> @@ -137,37 +142,70 @@ static enum cs_err perf_cs_close(csh *handle)
[ ... ]
> +static bool e_machine_to_capstone(uint16_t e_machine, bool is64, bool is=
_big_endian,
> +				  enum cs_arch *arch, enum cs_mode *mode)
> +{
> +	*mode =3D is_big_endian ? CS_MODE_BIG_ENDIAN : CS_MODE_LITTLE_ENDIAN;
> +
> +	switch (e_machine) {
[ ... ]
> +	case EM_RISCV:
> +		*arch =3D CS_ARCH_RISCV;
> +		*mode |=3D is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32;

[Severity: Medium]
Does this initialization need the CS_MODE_RISCVC flag included in the mode
bitmask to decode RISC-V 16-bit compressed instructions?

Since almost all RISC-V Linux code uses the C extension (RV64GC), omitting
this flag could cause Capstone to encounter invalid opcodes on the first
compressed instruction.

Would this abort disassembly prematurely and force a fallback to objdump?

> +		return true;
> +	default:
> +		return false;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601065407.1597=
927-1-irogers@google.com?part=3D4
