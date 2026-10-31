Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793469829;
	b=Rupibp0gtRrSUZj3ctjk9yudu3cgfjfB3lHhrsVys/fv+UWq+hQnrbKlRCTlphbUyZvY
	 px8gZ1ZWEo0Oy8QpUqNg1n47a9MxG43LU2Nmg32HxAFRfxbgGaI/xOLadepFQ+8gojvRH
	 abqcFjjuWM7iq9FXDcGbgG3JI+DujWeAqND2FM9bTydkLhmSpmBTujiK63OJVZTR1sP1D
	 0qc76u7uOr+xSA/h9sQCyf7LEHnQET8mcYt4DxPwPH89iHmYVQhpzPNTqEEtvoBJ+ahBS
	 SZAJwB1Qt24pmPbjJ2E3w7VGOuFPL5p5wOgXEWkVZLZEVtis01+ZbAD21UEVVivdnKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KsRgGWz/X3xi8qWx3igkiGXno4m33kSDjYAblwsQQBU=;
	b=NlCbXddbvw9XLyZ6gTNB5+vWO0DlLs+tN7nMRPwBttm3j4iHBL4mCoYGr8QMQRnh/Boi
	 MsWhBpFBbFxK6CCe0TtLOwKnK8zefyoeWYwPOVBnn4Q6+yf2c3eRc2dPgF+pHycGop0Uk
	 krzzXDP12kgzrXl5z/W1trxF/ldP2zH54vn4fiZ2YVheudqYterQiklx40vVNvVUQCzUj
	 g0B3TVPhVqB8mo6EQTiZIMI0jIkn06rL43G1V8546f31GIiZQ8U1mXNE/ZUfMMNkDXHpX
	 SfKA+I5jRYOGT4tsXukD8Jntx+KxEBiC0sjSCj0fPrsybLdekclNj2Uo675H7oOo/Sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ivF6hTm7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AECA606A31C
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 18:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AECA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ivF6hTm7
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso283564566b.2
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 11:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793469828; cv=none;
        d=google.com; s=arc-20260327;
        b=CanwRusecssxObDUDGSS47z13aVYcvsM+NJBwpfrKh6UsLquxt4UQVpWVmIqX+iiKQ
         V2Oj8QItVovAe8ytwLbLsIQESzUE50gOoQZ7jkXLkoUsi/knqGZtJTBfMaQKj3/01SHi
         Ba79VdCFyBOv1FuP5rKgt/kMN8gg4ZrPNFTnAUnmYMOVLBskYIlkRo96fzKEdta8DO+k
         p2OqiYC3tNSetQiAnY6W/KAx9cQfmpz+ati2sTNqZQACkL7HaU1dAClvVHBIIRZI4HwN
         nB0tlqt/VXY3JkmH6sGIwAT3jN1dH/1yuXkVpJq9kNZ5IuKQI+T1tPBw4t8+whmx+sFf
         av+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KsRgGWz/X3xi8qWx3igkiGXno4m33kSDjYAblwsQQBU=;
        fh=TrFarWvLQ6CVRLod/uM02TcAsYf/aTH5sjVhBwzN+l8=;
        b=gF/mBUxMrAMqPWFd7PUvzFrenbk3I7LWaw4WNOIAGedE2UavlzZPWuY+3bhAZnrB9g
         LOXYKXggXQNKECUlhNP7s4c7ltMBfxQOVEk3YANdLoz3kJ0h4o2PVGFxyoViQ2CHu4aI
         QhJKJW/0B7LoJDfNjkyLX+t7Rb9sf13Ji9AqjFAGOeP5tI8QbaZnjUGCQ4LMm1vJqwQ4
         yLrsVNFY6TuYDAiPdUM0Mi93TsbbXKJ2JAVH+U6DUrtfwyD1GpTY0MZwBkvMCKwNDg1j
         4ztWoh7pOJRGk485O+O6R+SDpWPwtW+e9Y8AtevlujDQtNGM7yWVHiZ2rOa+5m6wHMEi
         n9hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793469827; x=1794074627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KsRgGWz/X3xi8qWx3igkiGXno4m33kSDjYAblwsQQBU=;
        b=ivF6hTm7ojLBkCtPeDxUMFvVjjBGvjzBCp0mrKwqSbTef3NeJp+9G42b0jQGAqXEBo
         lvNaGl3EU8fPK6LLrAgVZriMtHXxBEdyK++H0m4M7FVJz0AZTcQ5VaZj8qQ8eTd74vuQ
         JfhsQi1hW04gDO/Ba/8R1a4vUAY+JnwBjiBYxrFGPQTQTD+qAg70lJ2HZr3eHQ1Ep+7v
         K2gPs0cqNqDW6afoO6p5T21W9zNtowh6KAKgHSWplBDvg7HL1ZH3n4JM7kjD5GpkKGqK
         wAnAG03X+pKLgLIGg1tUVi0pYBh8HOGo3rKrZTNbcoDJlY7RtVos3Ak5LQDF0LWllAVl
         JgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793469828; x=1794074628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KsRgGWz/X3xi8qWx3igkiGXno4m33kSDjYAblwsQQBU=;
        b=GtDFsQJnSEPpf0jr6jirpPxom2WV8VJzR4T4F7FNZ7beDJzSNx+AZVKiu5UZIIBYsX
         1TTYAxuFJU78RIytKOOk7PzWq7LsVndwpdMBrQ/diw615ISkUXJiRG0Lsw4gOyLM9J1f
         ehUJWPp3iUDUwXCxsgTiDR2nfCnLoh0ynjViXt49nkg6tLumcY+rWnjfjjYI9eomkb1Y
         ++aryyVXaSmSrWUxdHr4kDo4lZt4lxtaouS3ed+qY2DqAHnx/G2f2F7v/cg5DxbUgCUJ
         7AbsgFQvxSHCXyUUpb5Ekl9fL9TaNYSkKzr80VGJi1fvEh/E6TE99v+MZ1NTqfhAMyfN
         tO1g==
X-Forwarded-Encrypted: i=1; AKwUvBzjxSP+m8nDoS93C+V6t/bF/NRTL6P246PVGjJMz7EB4CS7ulW0sCysg4TSUMWx1CDHfYdfdsR2ypP3lSyrdsvx@vger.kernel.org
X-Gm-Message-State: AFq9FYI5r60oIwQRcI7z/RB8eQQPhydKVaUePCKPUqyP/9nAYMJK2tHp
	OLcVIleKyxRCK2p+vzb7UxJITUYkUvxwe3jTM9iQ8EoAVhELtypGFUkOpr/BGeYlaYOPG6xWYr/
	1JfS4j0QHTbf+TrWNgTstw83q1IrNCQE=
X-Gm-Gg: AYBFou1gNtrTIaiklAL1fgvETvlNswOv+aCqwPZCdf1Sjxp96KMjHcVn8/Kzw6h47CA
	jzwb0525ZV3cvdmwudxagn8YYYp2Iw78Xzl136X4TPI04V6zIE5n7MRI23VT5rDUqA7dRN6OJ5M
	ib6LdYDYZMaNumnuNlykxQmVz9qVblSzNA7Wg9jLxYwMGj6A+yTK94SttaDvCZkBxEG+7ocEhin
	4Op+ssr3z+mQ/5sW6yxaJaVKsISf556l6I/ujeQRC4rDZzVIy9wUAGL9qXFvvdVp0UQIhegQaQp
	yAAdGaB7xxfYYJCtoUXXXW2eYEXk1GYrGnqxnecQG7PsVTKajTiPoi7MFujmGob6j6fUOy/V8dQ
	Q6U6WnHAQXTMf1j902fdmg4NBiFDkHcbemu9JYT3S5M2lmXDEa2PsOyrwyOVSEuAtNzJmekmSbv
	qeh/16qTzLPtzvSQgWXv+wvZdN
X-Received: by 2002:a17:906:9f92:b0:c41:5970:2360 with SMTP id
 a640c23a62f3a-c4ca7ad1d1fmr471184866b.41.1793469827497; Sat, 31 Oct 2026
 11:03:47 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-perf-alpha-profileme-v2-0-9ce2f0b0e622@gmail.com> <20261030-perf-alpha-profileme-v2-1-9ce2f0b0e622@gmail.com>
In-Reply-To: <20261030-perf-alpha-profileme-v2-1-9ce2f0b0e622@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 31 Oct 2026 19:03:36 +0100
X-Gm-Features: AclHuK-2odKuRuZw0XWsQTnkwcBT5erymxjVl5ceNWr0gjZ23ZPZzqRmnILbas0
Message-ID: <CA+=Fv5RrvppOmw8ra41A0SzTpX_sNs9dWEL15r-Di8TeQ3_ECQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf alpha: Decode ProfileMe raw samples
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, Oct 30, 2026 at 5:09=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> The Alpha cpu PMU attaches struct alpha_profileme_sample to each
> ProfileMe sample as PERF_SAMPLE_RAW data: the profiled instruction's
> PMPC along with the I_STAT and PCTR_CTL status that says what happened
> to it.
>
> Decode it in perf report -D and perf script -D the way AMD IBS raw data
> is decoded, naming the trap from TRAP_TYPE when TRP is set and from the
> PALcode entry offset in PMPC for redirect traps, which TRAP_TYPE does
> not report. The payload is copied out of the sample and converted from
> little endian, so that it decodes on strict-alignment and big-endian
> hosts too.
>
> Copy the uapi header that defines the struct into tools/arch and add it
> to check-headers.sh.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  tools/arch/alpha/include/uapi/asm/perf_event.h |  31 ++++++
>  tools/perf/check-headers.sh                    |   1 +
>  tools/perf/util/Build                          |   1 +
>  tools/perf/util/alpha-sample-raw.c             | 145 +++++++++++++++++++=
++++++
>  tools/perf/util/sample-raw.c                   |   2 +
>  tools/perf/util/sample-raw.h                   |   2 +
>  6 files changed, 182 insertions(+)
>
> diff --git a/tools/arch/alpha/include/uapi/asm/perf_event.h b/tools/arch/=
alpha/include/uapi/asm/perf_event.h
> new file mode 100644
> index 000000000000..aa0eff5a917c
> --- /dev/null
> +++ b/tools/arch/alpha/include/uapi/asm/perf_event.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_ASM_ALPHA_PERF_EVENT_H
> +#define _UAPI_ASM_ALPHA_PERF_EVENT_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * PERF_SAMPLE_RAW payload of a ProfileMe sample from the cpu PMU.
> + *
> + * pmpc, i_stat and pctr_ctl are the values of the PMPC, I_STAT and
> + * PCTR_CTL registers when the ProfileMe window closed. i_stat holds onl=
y
> + * bits 40:30 and pctr_ctl only bits 47:0. See the EV67/EV68 Hardware
> + * Reference Manuals for the field layout.
> + *
> + * In the sample record the payload follows the 32-bit PERF_SAMPLE_RAW
> + * size, so it starts 4 bytes past an 8-byte boundary. The 64-bit fields
> + * are packed after the 32-bit version so that they are 8-byte aligned i=
n
> + * the record and no padding follows the payload.
> + *
> + * Fields may be added to the end in later versions.
> + */
> +#define ALPHA_PROFILEME_SAMPLE_VERSION 1
> +
> +struct alpha_profileme_sample {
> +       __u32 version;
> +       __u64 pmpc __attribute__((packed));
> +       __u64 i_stat __attribute__((packed));
> +       __u64 pctr_ctl __attribute__((packed));
> +};
> +
> +#endif /* _UAPI_ASM_ALPHA_PERF_EVENT_H */
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 531c0e0e84df..de66bb148754 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -36,6 +36,7 @@ declare -a FILES=3D(
>    "arch/x86/include/asm/msr-index.h"
>    "arch/x86/lib/x86-opcode-map.txt"
>    "arch/x86/tools/gen-insn-attr-x86.awk"
> +  "arch/alpha/include/uapi/asm/perf_event.h"
>    "arch/arm/include/uapi/asm/perf_regs.h"
>    "arch/arm64/include/uapi/asm/perf_regs.h"
>    "arch/loongarch/include/uapi/asm/perf_regs.h"
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 2c1f880c4c47..2ab63bbe4a05 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -77,6 +77,7 @@ perf-util-y +=3D sample.o
>  perf-util-y +=3D sample-raw.o
>  perf-util-y +=3D s390-sample-raw.o
>  perf-util-y +=3D amd-sample-raw.o
> +perf-util-y +=3D alpha-sample-raw.o
>  perf-util-y +=3D ordered-events.o
>  perf-util-y +=3D namespaces.o
>  perf-util-y +=3D comm.o
> diff --git a/tools/perf/util/alpha-sample-raw.c b/tools/perf/util/alpha-s=
ample-raw.c
> new file mode 100644
> index 000000000000..b4e336d8fc8f
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
> +
> +#include "evlist.h"
> +#include "evsel.h"
> +#include "sample-raThe v2 decoder passed the unaligned-payload test unde=
r Alpha QEMU
with SIGBUS enabled for unaligned accesses. On my ES40 it also
decoded recordings from all four ProfileMe modes, with the expected
selectors in each case.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>The v2 decoder passed
the unaligned-payload test under Alpha QEMU
with SIGBUS enabled for unaligned accesses. On my ES40 it also
decoded recordings from all four ProfileMe modes, with the expected
selectors in each case.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>w.h"
> +#include "util/sample.h"
> +
> +/* I_STAT */
> +#define I_STAT_OVR(x)          (((x) >> 30) & 0x7)
> +#define I_STAT_ICM(x)          (((x) >> 33) & 0x1)
> +#define I_STAT_TRAP_TYPE(x)    (((x) >> 34) & 0xf)
> +#define I_STAT_LSO(x)          (((x) >> 38) & 0x1)
> +#define I_STAT_TRP(x)          (((x) >> 39) & 0x1)
> +#define I_STAT_MIS(x)          (((x) >> 40) & 0x1)
> +
> +/* PCTR_CTL */
> +#define PCTR_CTL_TAK(x)                ((x) & 0x1)
> +#define PCTR_CTL_VAL(x)                (((x) >> 1) & 0x1)
> +#define PCTR_CTL_SL1(x)                (((x) >> 2) & 0x3)
> +#define PCTR_CTL_SL0(x)                (((x) >> 4) & 0x1)
> +#define PCTR_CTL_PCTR1(x)      (((x) >> 6) & 0xfffff)
> +#define PCTR_CTL_KILLED(x)     (((x) >> 26) & 0x1)
> +#define PCTR_CTL_STALLED(x)    (((x) >> 27) & 0x1)
> +#define PCTR_CTL_PCTR0(x)      (((x) >> 28) & 0xfffff)
> +
> +/* PMPC */
> +#define PMPC_PAL(x)            ((x) & 0x1)
> +#define PMPC_PAL_OFFSET(x)     ((x) & 0x7fff)
> +
> +static const char * const trap_type_names[16] =3D {
> +       [0]  =3D "replay",
> +       [2]  =3D "DTB double miss (3 level)",
> +       [3]  =3D "DTB double miss (4 level)",
> +       [4]  =3D "FP disabled",
> +       [5]  =3D "unaligned",
> +       [6]  =3D "DTB single miss",
> +       [7]  =3D "Dstream fault",
> +       [8]  =3D "OPCDEC",
> +       [10] =3D "machine check",
> +       [12] =3D "arithmetic",
> +       [14] =3D "MT_FPCR",
> +       [15] =3D "reset",
> +};
> +
> +/* What PCTR1 counts during the window, by SL1. */
> +static const char * const pctr1_names[4] =3D {
> +       "cycles",
> +       "retire delay",
> +       "bcache misses",
> +       "mbox replays",
> +};
> +
> +static const char *trap_name(__u64 i_stat, __u64 pmpc)
> +{
> +       const char *name;
> +
> +       /* Redirect traps leave TRAP_TYPE alone and are named by PMPC. */
> +       if (PMPC_PAL(pmpc)) {
> +               switch (PMPC_PAL_OFFSET(pmpc)) {
> +               case 0x481:
> +                       return "Istream access violation";
> +               case 0x581:
> +                       return "ITB miss";
> +               case 0x681:
> +                       return "interrupt";
> +               default:
> +                       break;
> +               }
> +       }
> +       if (!I_STAT_TRP(i_stat) || I_STAT_MIS(i_stat))
> +               return "none";
> +       name =3D trap_type_names[I_STAT_TRAP_TYPE(i_stat)];
> +       return name ? name : "other (see PMPC)";
> +}
> +
> +/*
> + * Copy the payload out of the sample, since nothing guarantees its
> + * alignment in the buffer, and convert it from the little-endian byte
> + * order it was recoThe v2 decoder passed the unaligned-payload test und=
er Alpha QEMU
with SIGBUS enabled for unaligned accesses. On my ES40 it also
decoded recordings from all four ProfileMe modes, with the expected
selectors in each case.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>rded in.
> + */
> +static bool is_profileme_sample(struct evlist *evlist, union perf_event =
*event,
> +                               struct perf_sample *sample,
> +                               struct alpha_profileme_sample *pm)
> +{
> +       struct evsel *evsel;
> +
> +       if (sample->raw_size < sizeof(*pm))
> +               return false;
> +
> +       evsel =3D evlist__event2evsel(evlist, event);
> +       if (!evsel)
> +               return false;
> +       if (evsel->core.attr.type !=3D PERF_TYPE_HARDWARE &&
> +           evsel->core.attr.type !=3D PERF_TYPE_RAW)
> +               return false;
> +
> +       memcpy(pm, sample->raw_data, sizeof(*pm));
> +       pm->version =3D le32_to_cpu(pm->version);
> +       pm->pmpc =3D le64_to_cpu(pm->pmpc);
> +       pm->i_stat =3D le64_to_cpu(pm->i_stat);
> +       pm->pctr_ctl =3D le64_to_cpu(pm->pctr_ctl);
> +
> +       return pm->version >=3D ALPHA_PROFILEME_SAMPLE_VERSION;
> +}
> +
> +void evlist__alpha_sample_raw(struct evlist *evlist, union perf_event *e=
vent,
> +                             struct perf_sample *sample)
> +{
> +       struct alpha_profileme_sample pm;
> +       unsigned long long i_stat, ctl, pmpc;
> +
> +       if (event->header.type !=3D PERF_RECORD_SAMPLE ||
> +           !is_profileme_sample(evlist, event, sample, &pm))
> +               return;
> +
> +       i_stat =3D pm.i_stat;
> +       ctl =3D pm.pctr_ctl;
> +       pmpc =3D pm.pmpc;
> +
> +       printf("ProfileMe PMPC:\t%016llx %s trap %s%s\n",
> +              pmpc, PMPC_PAL(pmpc) ? "PAL" : (pmpc >> 63 ? "kernel" : "u=
ser"),
> +              trap_name(i_stat, pmpc),
> +              I_STAT_TRP(i_stat) && I_STAT_MIS(i_stat) ? " mispredicted"=
 : "");
> +       printf("ProfileMe I_STAT:\t%016llx TRP %d MIS %d LSO %d TrapType =
%d ICM %d OVR %d\n",
> +              i_stat, (int)I_STAT_TRP(i_stat), (int)I_STAT_MIS(i_stat),
> +              (int)I_STAT_LSO(i_stat), (int)I_STAT_TRAP_TYPE(i_stat),
> +              (int)I_STAT_ICM(i_stat), (int)I_STAT_OVR(i_stat));
> +       printf("ProfileMe PCTR_CTL:\t%016llx VAL %d TAK %d Stalled %d Kil=
led %d",
> +              ctl, (int)PCTR_CTL_VAL(ctl), (int)PCTR_CTL_TAK(ctl),
> +              (int)PCTR_CTL_STALLED(ctl), (int)PCTR_CTL_KILLED(ctl));
> +       printf(" SL0 %d SL1 %d PCTR0 %d PCTR1 %d (%s)\n",
> +              (int)PCTR_CTL_SL0(ctl), (int)PCTR_CTL_SL1(ctl),
> +              (int)PCTR_CTL_PCTR0(ctl), (int)PCTR_CTL_PCTR1(ctl),
> +              pctr1_names[PCTR_CTL_SL1(ctl)]);
> +}
> diff --git a/tools/perf/util/sample-raw.c b/tools/perf/util/sample-raw.c
> index f5ae9f468983..f765429a481d 100644
> --- a/tools/perf/util/sample-raw.c
> +++ b/tools/perf/util/sample-raw.c
> @@ -19,6 +19,8 @@ void evlist__init_trace_event_sample_raw(struct evlist =
*evlist, struct perf_env
>
>         if (e_machine =3D=3D EM_S390) {
>                 evlist__set_trace_event_sample_raw(evlist, evlist__s390_s=
ample_raw);
> +       } else if (e_machine =3D=3D EM_ALPHA) {
> +               evlist__set_trace_event_sample_raw(evlist, evlist__alpha_=
sample_raw);
>         } else if (e_machine =3D=3D EM_X86_64 || e_machine =3D=3D EM_386)=
 {
>                 const char *cpuid =3D perf_env__cpuid(env);
>
> diff --git a/tools/perf/util/sample-raw.h b/tools/perf/util/sample-raw.h
> index c8d38c841c8c..8df0bd3d02aa 100644
> --- a/tools/perf/util/sample-raw.h
> +++ b/tools/perf/util/sample-raw.h
> @@ -14,6 +14,8 @@ void evlist__s390_sample_raw(struct evlist *evlist, uni=
on perf_event *event,
>  bool evlist__has_amd_ibs(struct evlist *evlist);
>  void evlist__amd_sample_raw(struct evlist *evlist, union perf_event *eve=
nt,
>                             struct perf_sample *sample);
> +void evlist__alpha_sample_raw(struct evlist *evlist, union perf_event *e=
vent,
> +                             struct perf_sample *sample);
>  void evlist__init_trace_event_sample_raw(struct evlist *evlist, struct p=
erf_env *env);
>
>  #endif /* __SAMPLE_RAW_H */
>
> --
> 2.55.0
>
>

The v2 decoder passed the unaligned-payload test under Alpha QEMU
with SIGBUS enabled for unaligned accesses. On my ES40 it also
decoded recordings from all four ProfileMe modes, with the expected
selectors in each case.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
