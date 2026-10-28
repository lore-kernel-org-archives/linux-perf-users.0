Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211962;
	b=V0d0FYi/7rhBvSGvLOrDm0O/zLq4k+jbVFoQE23nYNX4RKOZAE18yrvydv+14Td0HrKC
	 hh7iQVaI6Qn23UQ1AeSGiLxfaCTsgVXUfsiy7kxJpHI96HX+OjOBoXZKZm8RyHM6ud9tl
	 B1mVE1p9NpmUffMJmW4ycAdSIbB5CXci9Ts3e7x41jGDSdGp/uVaPN+mbFs9AIUeuMEMJ
	 4Q+HC6D1RG22ZHUvXtcW/bOuQY5iE0+1sffpIBtf3eZVZEgBkwPLSEgVmnTJx1Gto/wFB
	 Zr1ikBeNeAG5XzEVWpOxIjxAGGLNGyiKgnas2ZNF6ZiC0gUw/FUaxgyspOrJ26pYOQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211962;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ji+DiuFukrW+5QkikFzqUaui0Ciadj39JYptLtbMEgI=;
	b=lKbzmqX57DUkziw7UKIgReQs1zCAnNIACWEDsLAxcRQosuP0wqCzvc1omz9HsWHl0t/U
	 pu6PYYm6qE3w0csgqxrM0fmLyb6bP04AOxz56FIhBsmYw/ku1pn3X3qTFPJaBgCnsOI7v
	 YTr4WJZ4rwtvHvPJCuXfwrgSqlN22XUQmWGClIOl9y9O0gca/MB9eRZD5nY0N1n65fhTs
	 1ltzxVNerJ1QtFbxCiSDAfZLAsS2q4BpJkDl54Z/Z105/KAnnFMtqfZRSLglUEc/oM5vX
	 UA+W4hyBzsBPTHjFoCU029xeVh0jBrZiConCr325fHDuAVFJJQcPnxXpL5Q+9wELYnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I82E5mw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6FF606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I82E5mw4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCC31F01825;
	Wed, 28 Oct 2026 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793211962;
	bh=Ji+DiuFukrW+5QkikFzqUaui0Ciadj39JYptLtbMEgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I82E5mw4kvQQ59Tt9Zsu342kpKnUWGf3jhD29D89o4mVRsrNMYCVS0HvtiHpg7LgL
	 OVehXbJXSuqoUv+5BYs7+/lloZfIu2bu0EjcJfZhcf2r2RcrlkaX9JA1wBwbSz2Fgq
	 UAVx+ecm1nRQSQ47lLVDgFJ3DuJ8ug8TiMbwCCGu531EpjYsWkOAO51tTSGUiGNtJY
	 pl1lVYUz5L5Todokj+NNYjumErKWIzZAROviJgLWPLNLWepw+5TzPmxwGObXVonoDU
	 4Wjaj2PHeq6C14oZf5lgt4cWGB3edCf/fC/GGwOHI8hMlDSbPHfvxxjFDFiGWW5p/4
	 l8rwo3bteR0bQ==
Message-ID: <sashiko-outbox-188281@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] alpha/perf: attach ProfileMe status as
 PERF_SAMPLE_RAW data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028-alpha-profileme-v1-4-d44b52bf2500@gmail.com>
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com>
 <20261028-alpha-profileme-v1-4-d44b52bf2500@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:26:01 +0000
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
- [Medium] alpha/perf: misaligned u64 fields and unwritten pad in alpha_pro=
fileme_sample
--

commit 6d712b2296772549d16528b224255d9e1a7bde43
Author: Matt Turner <mattst88@gmail.com>

alpha/perf: attach ProfileMe status as PERF_SAMPLE_RAW data

This commit attaches the PMPC, I_STAT, and PCTR_CTL register values to
ProfileMe samples as PERF_SAMPLE_RAW data using a versioned UAPI struct
alpha_profileme_sample.

> diff --git a/arch/alpha/include/uapi/asm/perf_event.h b/arch/alpha/includ=
e/uapi/asm/perf_event.h
> new file mode 100644
> index 0000000000000..0cb7d6f3cb154
> --- /dev/null
> +++ b/arch/alpha/include/uapi/asm/perf_event.h
> @@ -0,0 +1,27 @@
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
> + * PCTR_CTL registers when the ProfileMe window closed. i_stat holds only
> + * bits 40:30 and pctr_ctl only bits 47:0. See the EV67/EV68 Hardware
> + * Reference Manuals for the field layout.
> + *
> + * Fields may be added to the end in later versions.
> + */
> +#define ALPHA_PROFILEME_SAMPLE_VERSION	1
> +
> +struct alpha_profileme_sample {
> +	__u32 version;
> +	__u32 reserved;
> +	__u64 pmpc;
> +	__u64 i_stat;
> +	__u64 pctr_ctl;
> +};

[ ... ]

> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index 24c96feda9424..06c9afeb7c05e 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c

[ ... ]

> @@ -955,6 +958,20 @@ static void alpha_perf_event_profileme(struct perf_e=
vent *event,
> =20
>  	perf_sample_data_init(&data, 0, hwc->last_period);
> =20
> +	pm.version =3D ALPHA_PROFILEME_SAMPLE_VERSION;
> +	pm.reserved =3D 0;
> +	pm.pmpc =3D pmpc;
> +	pm.i_stat =3D i_stat;
> +	/* PALcode sign-extends bit 47 of PCTR_CTL. */
> +	pm.pctr_ctl =3D pctr_ctl & GENMASK(47, 0);
> +	raw =3D (struct perf_raw_record) {
> +		.frag =3D {
> +			.size =3D sizeof(pm),
> +			.data =3D &pm,
> +		},
> +	};
> +	perf_sample_save_raw_data(&data, event, &raw);

[Severity: Medium]
Does including the __u32 reserved field in struct alpha_profileme_sample
misalign pmpc, i_stat, and pctr_ctl in the perf ring buffer and leave 4 byt=
es
of trailing padding unwritten?

In a PERF_RECORD_SAMPLE record, all fields preceding PERF_SAMPLE_RAW are
multiples of sizeof(u64). When perf_output_sample() writes the
PERF_SAMPLE_RAW section, it begins on an 8-byte boundary by outputting the
4-byte u32 raw->size field, which places the start of the raw payload at a 4
(mod 8) byte offset in the ring buffer.

Because struct alpha_profileme_sample has both __u32 version and __u32
reserved before __u64 pmpc, its total size is 32 bytes and pmpc is at offset
8 within the struct. Placed after the 4-byte raw->size field in the sample
record, pmpc, i_stat, and pctr_ctl land at 4 (mod 8) offsets rather than
8-byte aligned offsets, triggering unaligned 64-bit load traps on Alpha when
dereferenced in place and breaking 64-bit byte-swapping in
evsel__parse_sample().

In addition, when alpha_perf_event_profileme() passes sizeof(pm) (32 bytes)=
 to
perf_sample_save_raw_data():

include/linux/perf_event.h:perf_sample_save_raw_data() {
	...
	size =3D round_up(sum + sizeof(u32), sizeof(u64));
	raw->size =3D size - sizeof(u32);
	frag->pad =3D raw->size - sum;
	...
}

round_up(32 + 4, 8) evaluates to 40, which sets raw->size to 36 and
frag->pad to 4. When perf_element overflows into
alpha_perf_event_profileme() -> perf_event_overflow() ->
__perf_event_overflow() -> perf_output_sample():

kernel/events/core.c:perf_output_sample() {
	...
			if (frag->pad)
				__output_skip(handle, NULL, frag->pad);
	...
}

__output_skip() advances the ring buffer position by 4 bytes without writing
to the buffer, leaving 4 trailing bytes of the 36-byte raw payload unwritten
(exposing stale ring buffer data after wrap-around).

Would it make sense to drop __u32 reserved from struct alpha_profileme_samp=
le
so that the struct is 28 bytes (4 mod 8), keeping pmpc, i_stat, and pctr_ctl
8-byte aligned in the sample record with raw->size =3D=3D 28 and frag->pad =
=3D=3D 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-alpha-prof=
ileme-v1-0-d44b52bf2500@gmail.com?part=3D4
