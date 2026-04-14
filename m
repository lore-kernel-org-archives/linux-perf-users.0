Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B92D94AF
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186598; cv=none; b=ErjYdm36FTlc7WKvhLQ54N02MiF16abTOQeUio4JgsIskfIR1nrG32x+Pn/5OpD1RsWeJA0YJEu7v9UQd8AykEnfJjsU74TKAlCKhmbWxJphWNfcPo4VZfyqIxJ5plLozBFvOpmzMt/YLdxcky0agK0Uqi8RquTUpyHVzJq5lQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186598; c=relaxed/simple;
	bh=TjwOBUDhC6Jce9pqZlBNVRow0IOw7s30BCQKKh9ys6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bT7ztYHGYYY8QEc+hLwiy/8o3qds6Rjtca22lSoNzZXgIoO6NVmefA4XoAkkBB5j60Da1EXXQl5ZFDZzOiyfgBCq3L+GoSS8TvLYT7RKMDUWC/HVmMGTT1W0i8TscVd3UCO0eI/WQ0BibE/HZJ05HNkD5mHj53HHeZbWPuTQx2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJt5yNDT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJt5yNDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D49EC19425;
	Tue, 14 Apr 2026 17:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776186597;
	bh=TjwOBUDhC6Jce9pqZlBNVRow0IOw7s30BCQKKh9ys6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tJt5yNDT72UR+9rlpuv7f5ehiniUYTcqPF5f5PdBpuerv2z5scdDVzMjOV7xD+y+C
	 0/ST7vHTLjgCUIzgP2ZbbX01GEP7msDaJbPr07CCAwGM/NKyPIXQeobV8GaF/Hbd8e
	 qBP3xgLa48mdKAFdGwY4y+an3P8HB86UfsIxlo1tY9C+VqcRuwJcj4uzJIwjR9c3Tc
	 OA4sOWQqfgRLN9S28T6KHu1X8CvPXKISYB3YrXvTKemzNiOhjoEFCYlJjYc1TnmQXq
	 C83FS1uPZj4JtKDRdWKQ9I2KkpN208Gba5WH1CyPFPWQRa4XbFRdNgDN/Qw8PUArFX
	 a1FYE5yxFhuYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] perf arm_spe: Decode Arm N1 IMPDEF events
Reply-To: sashiko@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414-james-spe-impdef-decode-v3-5-63baf9c893b1@linaro.org>
References: <20260414-james-spe-impdef-decode-v3-5-63baf9c893b1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 17:09:56 +0000
Message-Id: <20260414170957.8D49EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The include directive `#include "../../arm64/include/asm/cputype.h"=
` is logically malformed and relies on incidental include path traversal.
--

commit d5ca69ee6b857cf31887dc91dcc515d11d5cc894
Author: James Clark <james.clark@linaro.org>

perf arm_spe: Decode Arm N1 IMPDEF events

This commit adds a framework to decode Arm N1 implementation-defined (IMPDE=
F)
events not covered by the common list. It also increases the buffer size
used for event string decoding to prevent truncation.

Link: https://developer.arm.com/documentation/100616/0401/Statistical-Profi=
ling-Extension/implementation-defined-features-of-SPE

> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tool=
s/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -15,6 +15,8 @@
> =20
>  #include "arm-spe-pkt-decoder.h"
> =20
> +#include "../../arm64/include/asm/cputype.h"

This isn't a bug, but is this include directive relying on incidental inclu=
de
path traversal?

The relative path ../../arm64/include/asm/cputype.h logically evaluates to
tools/perf/arm64/include/asm/cputype.h from this directory, which doesn't
exist in the source tree. It appears to compile only because the updated
Build file adds -I$(srctree)/tools/arch/arm64/include/ to the CFLAGS, causi=
ng
the preprocessor to append the relative path to the newly included director=
y.

Since the target base directory is already exposed via the -I flag, could
this be simplified to use #include <asm/cputype.h>?

> +
>  static const char * const arm_spe_packet_name[] =3D {
>  	[ARM_SPE_PAD]		=3D "PAD",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414-james-spe-=
impdef-decode-v3-0-63baf9c893b1@linaro.org?part=3D5
