Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF5414A08
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194307; cv=none; b=LZHM4K36IX7Smvb042YBbNVAG6qsQRexv6KTQxtRsid5uwDbJGSb+f9O0OyshTlGVjM9NRoRI55oiV+ToTidcoQAzMtmDDMTns+ryvrf/Dsm+w5E/i0/MOiwdHsklv4LyWhHNBqXhAcnpOauHGnL6XXh0dnu1DjdBvpiP+HtgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194307; c=relaxed/simple;
	bh=D41drurEIQx/cYNWjUdYfxRqh0H799tvn7OG4rNpK/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VSuOZ3XQ932Ui++vc7vHcXBDLLCtYM6h/djP+BSjOqsf7hRf68USU3zjcdTCCyg5fYPYNQglP3toLKs+jOrpfOnZQjX20mmUXagPRE4oji9dVvDZJb3tyd/cXkMZKBzCdNRbqiZ+HXP4hmNgv2fM/ocnv/k515y/fa2Ljx/hWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vb0++ekd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vb0++ekd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8CA1F00A3A;
	Sat,  8 Aug 2026 13:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786194304;
	bh=m9EH5BkWdDBlGqKgXLHqSIbzjo+o6ZupwmPzlARApYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vb0++ekdF7j368ciJgRyGT1iz25qoTAuhw4eNOw9ZPMjwkOelRh4MAO/P+5wv99ah
	 W16Ec8vEJ1+RqtkWVA3AaBwUkX2SKsT9XjSM/+N4Ir4HjoDPZ3h4+5rR/zGbEDO5QJ
	 Sx931ebZeiZRge5xobBPqJ/GtAIujB+WUUjGJWTQqKnAUD/mdwETFGbeWZbMILRvPD
	 LMBt47FrX8OK9gDX8nl+5IEjuMmWgoY5Wp7OIXTLlyfTfB6GQUxJGCxa7fAsGcFze6
	 bLIWNH703eWnon3Yo8wyoERYoXaA39qHOiCuUoTCMZPMXIcKxkdofmwtoYSVbWPAdf
	 27NcpcKl7kYVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/23] perf annotate-arm64: Track return type after
 call instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-14-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-14-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:05:02 +0000
Message-Id: <20260808130503.AA8CA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing invalidation of DWARF lifetime tracking when a caller-sa=
ved return register is updated with a function's return type.
--

--- Patch [13]: [PATCH v4 13/23] perf annotate-arm64: Track return type aft=
er call instructions ---
commit 001dcc403f6841490dc601cf7b406aa4f0f30321
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Track return type after call instructions

This commit enables data type profiling to track function return values in
arm64 annotations by looking up the DWARF return type of called functions.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index 44daa0176e512..acff14ca01e00 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> @@ -395,6 +397,20 @@ static void update_insn_state_arm64(struct type_stat=
e *state,
>  				continue;
>  			invalidate_reg_state(reg);
>  		}
> +
> +		/* Update register with the return type (if any) */
> +		if (call_name && die_find_func_rettype(cu_die, call_name, &type_die)) {
> +			tsr =3D &state->regs[state->ret_reg];
> +			tsr->copied_from =3D -1;
> +			tsr->type =3D type_die;
> +			tsr->kind =3D TSR_KIND_TYPE;
> +			tsr->offset =3D 0;
> +			tsr->ok =3D true;

[Severity: Medium]
Does this code need to clear the existing dynamic lifetime tracking fields
(such as lifetime_active and lifetime_end) before updating the return
register?

If the return register (e.g., x0) previously held a variable with an active
DWARF lifetime that spanned across this call, failing to call
invalidate_reg_state() or manually clear those fields could leave stale
lifetime flags in the register state.

If a subsequent function call occurs before that original lifetime ends, and
it does not return a known type, the return register might skip invalidation
due to the stale lifetime flag. This could erroneously preserve the first
call's return type and corrupt the data type profiling statistics.

> +
> +			pr_debug_dtp("call [%x] return -> reg%d",
> +				     insn_offset, state->ret_reg);
> +			pr_debug_type_name(&type_die, tsr->kind);
> +		}
>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D13
