Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572E154DAF0
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873911; cv=none; b=HZKP73Rc268vXIUvlKC5Q+09UH02FHJCm3GkFTnN4CJdTl0+H0HexMLDU2HvBsusHXsCttjQ4mgwYoXCMK4YH4KcGVbUvEkw0HXLdyFeauMkfy1LmzWszZflTFSSyJ5gBV0PyQRrGjsYGi4fgV5xCxolG5PERd/FKxXEjXsPX98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873911; c=relaxed/simple;
	bh=qP8VdRmQM+tB4O3z1uGRkdGK3CS91QmIqoiFJ82HInU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JexA0FVjSihzaDURgUlk555AVPB0VdCC9uHlmu8tz79f6URK43iQnjumgaMdh17Xqsy0hFawN8TD7X7Lia39fef0v++VtVziYEDTjJt54UZtzM5xT4Fx0XYDfz1clDeeyj4SGxqz/LL4+zMyLUZEs00lSJFunywSE1XnlEPG0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D131F00A3E;
	Tue,  8 Sep 2026 13:24:54 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/26] perf annotate: Normalize arch__dwarf_regnum()
 error return values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <07d3cce3cb8561c07d7c77deac81eb9ab0540ccb.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <07d3cce3cb8561c07d7c77deac81eb9ab0540ccb.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:24:53 +0000
Message-Id: <20260908132454.D9D131F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The check_matching_type() function uses dloc->op->reg1 as an array=
 index without bounds checking, leading to an out-of-bounds stack access wh=
en a register cannot be parsed.
--

commit 7d09889746335253aa4ac524e693986afc798032
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate: Normalize arch__dwarf_regnum() error return values

This commit normalizes the error return values of arch__dwarf_regnum() so
that all failures consistently return -1. This ensures callers that only
check for -1 will correctly identify genuine failures.

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2492,7 +2492,7 @@ static int arch__dwarf_regnum(const struct arch *ar=
ch, const char *str)
> =20
>  	reg =3D get_dwarf_regnum(regname, arch->id.e_machine, arch->id.e_flags);
>  	free(regname);
> -	return reg;
> +	return reg < 0 ? -1 : reg;

[Severity: High]
This is a pre-existing issue, but does consistently returning -1 here make =
it
easier to trigger an out-of-bounds stack read downstream in
check_matching_type()?

When processing an instruction with a memory reference, if register parsing
fails, the register variable can remain set to -1. Because the memory
reference flag (op_loc->mem_ref) remains true, the code can still proceed to
find_data_type() and check_matching_type().

Inside check_matching_type(), this register value (-1) is used directly as
an array index without bounds checking:

tools/perf/util/annotate-data.c:check_matching_type() {
        int reg =3D dloc->op->reg1;
        ...
        pr_debug_dtp("chk [%x] reg%d offset=3D%s%#x ok=3D%d kind=3D%d ",
                     insn_offset, reg, offset_sign, abs(offset),
                     state->regs[reg].ok, state->regs[reg].kind);

        if (!state->regs[reg].ok)
        ...
}

Could this index read uninitialized memory preceding the state->regs array?
If the stack garbage is interpreted as TSR_KIND_TYPE, might it try to
dereference it as a Dwarf_Die object and cause a segmentation fault when
analyzing maliciously crafted perf.data or ELF files?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D5
