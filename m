Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365866;
	b=0cTXdKgs8kp0id/VGhkmw2RhCCHzRD44LuM4NPl3Qsx2nnJc6COhpsd1pBlblWjccLVv
	 6ibGpaVbVB8o7kwhsNEO9cgDhrwzwJqUZlDjt5fo+qosUJ16+1jkkmtHFZNJtHQ1+pFmk
	 LW85UNpx6yylk8xDE1ALPzfZ8UqRaupARlCCSFPmhAFoOGUKff7QqZ0MQSifjsHzJ682m
	 hXDNIrLICykzqOYG7UBdp90fU69KXfW6jhMmwLGKqRylcVG5q+pr3MFlCyrjd9Q1oXg6+
	 VJhWScSKbz9/VZ+uI2Ex3rl2RlIBYE69dUguy2eeYc5WdlCVDgUBtbXX2LCm+bCcCEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365866;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6BIctGYLsbsdyPobnonLNS7k4lwgvSazKSv6ZNZ8Hrg=;
	b=Zxm4xtFeOcQMe1YARnhalkzvtEQLvFVGnMXuGrrbNqSgesNCSxYb1C2ck+g0GvD2pEOH
	 EmjKnvw63DMyKwM7ZSzU8AKH2+cCtJBJ0eK60yvoWLrSbJDIWZLihuWjEFiYo4yAROqIF
	 r6lsr2jwMrVT3ECdh/ymVz8FW6nYxqx3s4cP6MrF6NztlNgvYjbezYFl+MS5GTp6vvymZ
	 BojKQaTCs9tSprfU5obCAwkv4EhyuqwBHYKFfdiMtBwM8FJ34H2yLZLcCNfrO84wI21hD
	 X1d1hsuOddDpSXGUjxOvogP155x3f8xLtTVVyWCN1qTxpCz1ZpTk9nxcl+K/aezHetg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T5Ju/05l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78260A2601
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5Ju/05l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46601F0093C;
	Wed, 11 Nov 2026 02:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365865;
	bh=6BIctGYLsbsdyPobnonLNS7k4lwgvSazKSv6ZNZ8Hrg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=T5Ju/05l0wkTfF2wcOFrf/dwu/ok2yoOzDIctCL6qI1gzcJ/vUFe14opZDcDTtita
	 2W3EnXsAr/qOQWCW2eNS0PBXZypmhjBCnEBhI8hifs1t4yjRGHlqLWG8dmi8H5/IJa
	 z4K/5uVVLb2UG6p1kU6pLoVqPmSp3dfALuBc6W7oeucCZq7MSXAxo/yjyQzjOzSAWE
	 81HY9mDMRRthXeXrIoYYIfCojZXxGHT4FFyIh4eUQxsX27nkT+zlND6hrncPq6WivM
	 8InQWH7YlIPmjZhmW1DtmvQSFuEK75ai7qQi8u8Cl1qQrO2ukaALmXyPeHqMnXKMdq
	 UlHU+J12w46dA==
Message-ID: <sashiko-outbox-208136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf parse-events: default data breakpoints to any
 size on RISC-V
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rui Qi" <qirui.001@bytedance.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111022648.71649-2-qirui.001@bytedance.com>
References: <20261111022648.71649-2-qirui.001@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:57:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf parse-events: default_data_breakpoint_len() uses unmerged
  bp_len=3D0 ABI
--

commit cd4f828c59020f263743338e4d9c3465f6fbb3f6
Author: Rui Qi <qirui.001@bytedance.com>

perf parse-events: default data breakpoints to any size on RISC-V

This commit introduces default_data_breakpoint_len() so that data
breakpoints without an explicit length default to 0 on RISC-V and
HW_BREAKPOINT_LEN_4 on other architectures, and updates the parse-events
tests accordingly.

> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index f3ba70d4f76b2..e752f41f2b369 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -598,6 +598,27 @@ size_t default_breakpoint_len(void)
>  #endif
>  }
> =20
> +/*
> + * Default length for data breakpoints when the user did not specify one.
> + *
> + * Most architectures treat the length as a byte range that is compared
> + * against the address of the access, so 4 bytes is a reasonable default
> + * that matches most accesses.  RISC-V debug triggers (Sdtrig mcontrol6)
> + * encode the width of the access in the trigger instead, and a trigger
> + * only fires when the access has exactly that width.  This holds for
> + * both RV32 and RV64.  With a fixed default, an access of a different
> + * width silently never matches, so pass 0 on RISC-V, which the kernel
> + * translates to "match any size".
> + */
> +size_t default_data_breakpoint_len(void)
> +{
> +#if defined(__riscv)
> +	return 0;
> +#else
> +	return HW_BREAKPOINT_LEN_4;
> +#endif
> +}
> +
>  static int
>  parse_breakpoint_type(const char *type, struct perf_event_attr *attr)
>  {
> @@ -658,7 +679,7 @@ int parse_events_add_breakpoint(struct parse_events_s=
tate *parse_state,
>  		if (attr.bp_type =3D=3D HW_BREAKPOINT_X)
>  			len =3D default_breakpoint_len();
>  		else
> -			len =3D HW_BREAKPOINT_LEN_4;
> +			len =3D default_data_breakpoint_len();
>  	}
> =20
>  	attr.bp_len =3D len;

[Severity: Low]
Does setting attr.bp_len to 0 in default_data_breakpoint_len() rely on an
unmerged kernel ABI for RISC-V hardware breakpoints?

Mainline arch/riscv does not yet select HAVE_HW_BREAKPOINT or provide
hw_breakpoint_arch_parse(), and include/uapi/linux/hw_breakpoint.h only
defines HW_BREAKPOINT_LEN_1 through HW_BREAKPOINT_LEN_8 to describe the
byte length of the watched address range [bp_addr, bp_addr + bp_len)
rather than the exact memory access operand width.  Baking attr.bp_len =3D 0
into tools/perf before the RISC-V kernel hw_breakpoint support and UAPI
semantics are merged upstream risks breaking default mem:<addr> watchpoints
with -EINVAL if the upstream RISC-V implementation follows the standard
HW_BREAKPOINT_LEN_* byte-range contract expected by tests such as
test__wp_modify() in tools/perf/tests/wp.c.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111022648.7164=
9-2-qirui.001@bytedance.com?part=3D1
