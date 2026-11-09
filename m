Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226554;
	b=p5kHit7SVXW8f5KSWEoRSmTMOd60igee0Wwg8kyZY4+1MnUYL1T5z+yywptpajdGMtAa
	 Q8v9LXiwHYvOWk46Qm0Pp1yS65Z3MYc6CCmSqMJp0A07c8sNTj00yVha0rzCNSLNdtCWr
	 ok2GTcJ05CTTjF2khqy8JY3f96ovqw8Wo2KbgaTbFV0mrajZX+nTDO4WEFXEYLXQ325t5
	 EYRqrbY2Oh/V5tbk2bHc+ewQ2itYfCgpz/zCYGoW0EtZ4JERFR1BQNAx6dFoFFFM//WYJ
	 NY1wIb6sICxNwuCgM/B27BzF0laxg5oI/1fg8WVZTfpve96H+/x5aQILJpB0ZMO6elw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226554;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NTGrZKlax+U/yKbBUNZfcwm2y7GmmdbzohpA3eauULc=;
	b=4N8Jezr0Mjf9i5BK/gkz2gR6sUA7y7kgNYatyq+hCDBHE47rUZ/D67+l5Sm+lfeYifSV
	 A1LaGtVRfCHCzdbIhXIpAyyxgCRR6QPWz8V8nxA3w1+fBDzkioQujGbv05NSw5DOEXkEJ
	 fF77CcPuDWKM9qicfeYNImhE1mHQztvy1rP26yy7Goy+0o2Zg7VMMQ3S8lw4nsy0nYPgw
	 AMu7ez15V3sO0o0YAFAwSXtB58Ikf3a47FEziF6hKEU23eKN35mU6+M6NiPhCmhn/Ckl0
	 c1+TLNJ+GpMO17VnjOp5qBw3XmHllW0enVNojrmV1fRxOSiTkMnyncNdr9ptpDDmNUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OL+xvUir;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8902F606A33A
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OL+xvUir
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E0A1F008A7;
	Mon,  9 Nov 2026 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794226554;
	bh=NTGrZKlax+U/yKbBUNZfcwm2y7GmmdbzohpA3eauULc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OL+xvUirmmfGK+KpNCwSyXyvWxEKEQj0bKV1icTvOjb5mWfqp5JUXj6O8TfPcnulr
	 smhtGPtVHSnEExIYDsbEt7O2J66t7Iz75uzzNXPgR3jrtco188mk71QIM+ThX94lJ6
	 B+BqDx9tlweyapFOaN4NjzWS8VvUGVURl8pRm25xIqidwtbBjskfMD4JnZkSIHVRvG
	 vZQNjLH0feTL+jh9NoyoW8qvs8iOgV39Ijrjj+1jYYfVMFBUgaYBvhqOTGOv0Jkq2Q
	 3itRBV+wE0Dk2iwh1qvw2ZyKk9QvoKhiNNAwU9nPjV9ZwAAzgV5K8Opv/tFO2FJ015
	 kVK4BQiKiNsZg==
Message-ID: <sashiko-outbox-204922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf parse-events: default data breakpoints to any size
 on RISC-V
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rui Qi" <qirui.001@bytedance.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261109120320.75053-2-qirui.001@bytedance.com>
References: <20261109120320.75053-2-qirui.001@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 12:15:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf parse-events: RISC-V bp_len=3D0 default breaks
  parse-events unit tests
- [Low] perf parse-events: default_data_breakpoint_len() uses unmerged
  bp_len=3D0 ABI
--

commit bc358ce307d173b53ca7362db7fd768d0758ca0f
Author: Rui Qi <qirui.001@bytedance.com>

perf parse-events: default data breakpoints to any size on RISC-V

This commit adds default_data_breakpoint_len() to default unspecified data
breakpoint lengths to 0 on RISC-V while keeping HW_BREAKPOINT_LEN_4 on
other architectures.

> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index f3ba70d4f76b2..b72e4b0da8a15 100644
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
> +static size_t default_data_breakpoint_len(void)
> +{
> +#if defined(__riscv)
> +	return 0;
> +#else
> +	return HW_BREAKPOINT_LEN_4;
> +#endif
> +}

[Severity: Low]
Does default_data_breakpoint_len() rely on a kernel ABI that is not yet in
mainline?

Mainline arch/riscv does not select HAVE_HW_BREAKPOINT or implement
hw_breakpoint_arch_parse(), and include/uapi/linux/hw_breakpoint.h only
defines HW_BREAKPOINT_LEN_1 through HW_BREAKPOINT_LEN_8 to describe a
watched byte range (as relied upon by test__wp_modify() in
tools/perf/tests/wp.c).  All in-tree hw_breakpoint_arch_parse()
implementations reject attr->bp_len =3D=3D 0 with -EINVAL, so baking bp_len=
 =3D 0
into tools/perf before the RISC-V kernel hw_breakpoint support and UAPI are
merged upstream risks breaking default data breakpoints if the upstream
implementation follows standard byte-range semantics.

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

[Severity: Medium]
Does this regression break the "Parse event definition strings" unit test
on RISC-V?

When commit 70b27c756f95 ("perf parse-events: Add default_breakpoint_len
helper") introduced default_breakpoint_len() for instruction breakpoints,
it exported the helper in tools/perf/util/parse-events.h and updated
test__checkevent_breakpoint_x() in tools/perf/tests/parse-events.c.  Here,
test__checkevent_breakpoint(), test__checkevent_breakpoint_r(),
test__checkevent_breakpoint_w(), and test__checkevent_breakpoint_rw() still
assert that evsel->core.attr.bp_len equals HW_BREAKPOINT_LEN_4:

tools/perf/tests/parse-events.c:test__checkevent_breakpoint() {
    ...
	TEST_ASSERT_EVSEL("wrong bp_len", HW_BREAKPOINT_LEN_4 =3D=3D evsel->core.a=
ttr.bp_len, evsel);
    ...
}

On RISC-V, parsing data breakpoints without an explicit length (such as
mem:0, mem:0:r, mem:0:w, and mem:0:rw) now sets attr.bp_len to 0, causing
all 16 un-sized data breakpoint test cases to fail.  Exporting
default_data_breakpoint_len() for those checks (while keeping the explicit
HW_BREAKPOINT_LEN_4 check for test__checkevent_breakpoint_len_rw_modifier(),
which tests mem:0/4:rw:u and delegates to test__checkevent_breakpoint_rw())
would keep the test suite passing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109120320.7505=
3-2-qirui.001@bytedance.com?part=3D1
