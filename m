Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334281;
	b=N3NMHUqtr1WPFMH8OAD9X4Uo/vK+2OEy94iWuSyjUbDHPWi7+eD/zH8bgZlszYteo4f9
	 D8+tc5dZw5dxx/bTL1tYjFnd8smJnaa5vkGLZ4acDdTjasngvOOmMN63oZF8HaILXfr00
	 TPXGbN18cra1cutHaJ2Gu8UzSWBlx9EsEzCuOOMAw2558862ybFCzja4BXs1ur9du1/UI
	 8JDbw3n4hewOsVkzHpBSfdigi30L/6QR7RDrL4pC3bbnV81mUDgXTP4ujPbV7+DirZfJZ
	 Nzgh6Jyb/bVso09PED+Z67fxySCdQBbrA7G/XqGAM3PD8oGg4j21l8BighD3ztjMwpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334281;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TTpezBER6ukTQUdG14Jlo/9IWL1HS2UhzkdgTvCe/aU=;
	b=qAgNkpMi09d9Dor49JdMsE0l0rSa2HPyMp2knmwOKm4x19kwxUVi486S9c2vGSmsxUgU
	 eeQAXh7StQ8cpe4juCm6APl2HpwN60+Y2GvZV7mmDMWjE0KzkANb4XIV3AX/seuwxNcIm
	 0kDn2oi7tn0DFsKCNi5VD80JMacRAls5zoUahrlreCNE6zZwOJ3M0XYCDiK2jq1IY691C
	 U03JdtubPRF3w2DQ/cWkK85EpIzpCKe9eutO43fg2H9CPiz7Sp7iHkYDonnc8rBEilnI/
	 zAkrOCYES0/7XViDATzRC1uNJE+7dr8V6dIj1AyQ+Tjrz/aR831CfwVsuWUOPAUNueA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=km7M2eH3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48286606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=km7M2eH3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982831F000C1;
	Fri, 30 Oct 2026 04:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334280;
	bh=TTpezBER6ukTQUdG14Jlo/9IWL1HS2UhzkdgTvCe/aU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=km7M2eH3ltKMyUqvQB7U9z6yQhMa9RQz/pR7dJKtcR3iYzRGufqa69A9pdcRLgo9w
	 kYLg0l5fVj1/dcuw4ulObi81iDCuHsseJg47M0OsjhgXkvtjVBUdVxvWB+o6vcJ47R
	 HyMZRq9ZyQjos90H3f2brSfBFaMELD8Yd2cD/EYddCQgUwvzMFfNg1YnAQgPL89x3n
	 LNkWb5vn/n0zLD6QPI1dNIIWHhXrQ3V8KMJUczPQ9WMuY/Fj8iBFegCwWssVmVYTxs
	 xD+g6RsNlgRqCvJjxLUlFh88kq1SY8K/4InBHVjrnurrw2BQu2CFUp5BLVCyohsDh7
	 M5iqJNO0hzwiA==
Message-ID: <sashiko-outbox-190292@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf alpha: Decode ProfileMe raw samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf-alpha-profileme-v2-1-9ce2f0b0e622@gmail.com>
References: <20261030-perf-alpha-profileme-v2-0-9ce2f0b0e622@gmail.com>
 <20261030-perf-alpha-profileme-v2-1-9ce2f0b0e622@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:24:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf alpha: missing -Wpacked suppression breaks build on 32-bit tar=
gets
--

commit 119dd432f8c77b285bd2a318dab7adc61639a02f
Author: Matt Turner <mattst88@gmail.com>

perf alpha: Decode ProfileMe raw samples

This commit decodes Alpha ProfileMe PERF_SAMPLE_RAW payloads in perf report
-D and perf script -D, and copies the UAPI header defining struct
alpha_profileme_sample into tools/arch.

> diff --git a/tools/arch/alpha/include/uapi/asm/perf_event.h b/tools/arch/=
alpha/include/uapi/asm/perf_event.h
> new file mode 100644
> index 0000000000000..aa0eff5a917cb
> --- /dev/null
> +++ b/tools/arch/alpha/include/uapi/asm/perf_event.h
> @@ -0,0 +1,31 @@

[ ... ]

> +#define ALPHA_PROFILEME_SAMPLE_VERSION	1
> +
> +struct alpha_profileme_sample {
> +	__u32 version;
> +	__u64 pmpc __attribute__((packed));
> +	__u64 i_stat __attribute__((packed));
> +	__u64 pctr_ctl __attribute__((packed));
> +};
> +
> +#endif /* _UAPI_ASM_ALPHA_PERF_EVENT_H */

[ ... ]

> diff --git a/tools/perf/util/alpha-sample-raw.c b/tools/perf/util/alpha-s=
ample-raw.c
> new file mode 100644
> index 0000000000000..b4e336d8fc8f6
> --- /dev/null
> +++ b/tools/perf/util/alpha-sample-raw.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Alpha specific. Provide textual annotation for ProfileMe raw sample d=
ata.
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <linux/kernel.h>
> +#include <linux/perf_event.h>
> +
> +#include "../../arch/alpha/include/uapi/asm/perf_event.h"

[Severity: Low]
Will including this header without suppressing -Wpacked break the build on
32-bit architectures where the natural alignment of __u64 is 32 bits or less
(such as m68k, sh, arc, and microblaze)?

tools/perf/util/Build unconditionally compiles alpha-sample-raw.o on all
architectures with EXTRA_WARNINGS +=3D -Wpacked (in
tools/scripts/Makefile.include) and CORE_CFLAGS +=3D -Werror (in
tools/perf/Makefile.config).

In struct alpha_profileme_sample, the pmpc, i_stat, and pctr_ctl fields sit=
 at
4-byte-aligned offsets after __u32 version and carry __attribute__((packed)=
),
which lowers their alignment to 1 byte. On targets where __u64 has 4-byte or
smaller alignment, those fields are already naturally aligned at offset 4, =
so
GCC emits a -Wpacked warning ("packed attribute causes inefficient alignmen=
t"),
failing the build under -Werror.

Should the header inclusion in tools/perf/util/alpha-sample-raw.c be wrappe=
d in
diagnostic pragmas, similar to struct pai_data in
tools/perf/util/s390-sample-raw.c:

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpacked"
#pragma GCC diagnostic ignored "-Wattributes"
#include "../../arch/alpha/include/uapi/asm/perf_event.h"
#pragma GCC diagnostic pop

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf-alpha=
-profileme-v2-0-9ce2f0b0e622@gmail.com?part=3D1
