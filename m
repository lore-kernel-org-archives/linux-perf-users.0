Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231743;
	b=uHdUtSXZulL+6ugVRjfDrDN9lgmrCUIz2mBZ1mjyLFFDD7KiOq16Wd6IzkQ5wEFQ/kt8
	 XbCmLt7U4wIIzhe77uX3zN2CICUdF5pDobnkH6imou8bleDWloDjWxzxbd30JM42F5zmU
	 JPqDmHoZwO/7gQZJhcFLe16TpvgSY5mouuT5MvtX/TZOLlllUaomxlcBu8HvGNkMt+56D
	 YMU/15VUnMOv11CdgZCMkdCmAGC5M1ccJ2dV6xptXV4N2stq7sl+zKJpQFlvmNVCmBoOP
	 tHHqel/k0FDKdJrgY8mnxW7/MbsSurlPSYL7v3ALw3o4SD/7NtvltJs3hBtHIDPUMRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231743;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ImS8flFFshO47RLWhHSF8codwYF0uBelCjzJBsA5utw=;
	b=rcU5TlEWhwkCAICMtl1fl59iokXq5HJkpj7GZnI4pijHz78keYit4uaN3BSRzXq6BwYp
	 ViWCbMemdKagljGEWRueFjY12kDA1VmuwYSP+8YtieHEdOcPGZ/CiNTKlLtV05o7k10RR
	 dWu6O5RxboIisMZeM4539K2K5OohOYgh6dJ4gfozVIfb2kdR1jgaJRDcoCPKPnao+OkHn
	 pUdbJygLpMcqn4vL1h1m8trzTqgQbhbP0K49PyNHd3XiLZPMJSoDHtPsu3PcU5lgUCn0N
	 I7D8CcbeMsVdUs0pM/u25OuVGflFrSOf4ue0SVHCUtK97fTN61+KXkSHL/sAetIomLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gxW/Puwa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FB606A682
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 03:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxW/Puwa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F551F000C0;
	Sat, 21 Nov 2026 03:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231743;
	bh=ImS8flFFshO47RLWhHSF8codwYF0uBelCjzJBsA5utw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gxW/PuwambI/obEOZJ0+nQxWBtdoNzQABB9fJ1Gm4oZhbENNT7Tqudyfro4i8pk01
	 bfdABO8ZyKTkazsHe6G0y99grs2xSpmlHMpQH70If323yRi1gzG0mlVNhFBym+OEu2
	 rlLY6gvEl0T6DN9/W8mf6fxsKoI+d8FFSAvUntop7L0hmAXuXQOnUihuAvLeigPKJl
	 fm+SnM3JVwBxJYSdXuj9M7/WZDZ92XN5JWQR4vbUQJ0EzcC9EH8SjG69dqrpxex9kt
	 o+SLz+Ss5xUeohvVOr08qA2tjA+8cRTe8gtPCcdAi8tEk1tGs7kgYGnZhSWD6yMCxu
	 SuxsDuMzDIlFg==
Message-ID: <sashiko-outbox-226583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/16] perf tests: Exercise the x86 operand parser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261121032052.1392234-8-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
 <20261121032052.1392234-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:29:02 +0000
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
- [Medium] perf tests: check_movabs() fails when built without
  HAVE_LIBDW_SUPPORT
--

commit 74653224cba4e46d55b956a2e180f6f29cb4d93b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests: Exercise the x86 operand parser

This commit adds a unit test for the x86 operand parser covering absolute
addressing, immediate operands, direct branch targets, and movabs
instructions.

> diff --git a/tools/perf/tests/annotate-ops.c b/tools/perf/tests/annotate-=
ops.c
> new file mode 100644
> index 0000000000000..1c73433fbac67
> --- /dev/null
> +++ b/tools/perf/tests/annotate-ops.c
[ ... ]
> +static int check_movabs(const struct arch *arch, const char *name, const=
 char *ops)
> +{
> +	struct disasm_line dl =3D { .ins =3D { .name =3D name } };
> +	struct annotated_insn_loc loc;
> +	int ret =3D TEST_FAIL;
> +
> +	dl.ops.raw =3D strdup(ops);
> +	if (dl.ops.raw =3D=3D NULL)
> +		return TEST_FAIL;
> +
> +	dl.ins.ops =3D ins__find(arch, name, &dl);
> +	if (dl.ins.ops !=3D &mov_ops || dl.ins.ops->parse(arch, &dl.ops, NULL, =
&dl) < 0) {
> +		pr_debug("'%s %s': not parsed as a mov\n", name, ops);
> +		goto out;
> +	}
> +
> +	if (annotate_get_insn_location(arch, &dl, &loc) =3D=3D 0 &&
> +	    !loc.ops[INSN_OP_SOURCE].mem_ref && loc.ops[INSN_OP_SOURCE].imm &&
> +	    loc.ops[INSN_OP_TARGET].reg1 !=3D -1)
> +		ret =3D TEST_OK;
> +	else
> +		pr_debug("'%s %s': not an immediate to a register\n", name, ops);

[Severity: Medium]
Will check_movabs() fail when perf is built without HAVE_LIBDW_SUPPORT
(for example with NO_LIBDW=3D1)?

extract_op_location_x86() resolves %r15 via arch__dwarf_regnum() ->
get_dwarf_regnum(), which is a stub returning -1 in
tools/perf/util/include/dwarf-regs.h when HAVE_LIBDW_SUPPORT is not
defined, leaving loc.ops[INSN_OP_TARGET].reg1 at -1 while the test suite is
built and registered unconditionally.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121032052.1392=
234-1-acme@kernel.org?part=3D7
