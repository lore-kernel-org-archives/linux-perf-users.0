Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D91D5226B8
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898617; cv=none; b=ppHfxUosvtxlqKABEB2iHKYx2vOnRrRtENRvUhBWPfqD8Po3VElS9SLKRYbYjAinGD4314cXkfq28GhVr9IqwSzJK2TNsgr8pUBnnf3kXzDZirbp7bfolIVA7gkUk6KzprZg14+MaYs9xnbmNHuxFmJusAEMGzUbwhdQIjrDVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898617; c=relaxed/simple;
	bh=BU9uriJTI60J/U/KiJ/jkLEK3N4Mv/ufryHdf09NUEU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ed0pPYTZwr5PS6/wlFo8H/77YPrOBBfVWtPheATeVNi+cbwF7QUTpEzqEVcyt6xr+V3rPBIshJ66zxexbKZerTULbf33xW+mB4DG/gcROhyDd2GeGQQ7s+Fzt6T6Q9YckYhyxNBne6AsARZmq2dwBNJM1RnwMu9DY0R37TwOZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFAxrTOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFAxrTOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05221F00893;
	Tue, 13 Oct 2026 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898616;
	bh=8dUj6OmMreL+NxiuXPaWi5PIoTyIvhfg4MzwVZJITds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gFAxrTOLTNRxmIcOKnq3GpulrwAb38LqolLDMS7gsoPA5FNmCix2DPaEwuxgniDFz
	 9dA5sfkvc71fy+QbAAX2IhxkDSFz7V1TXcYIFOXkdB65CG7ga1KC20fxBvbVsF7cAL
	 esTBewb/me3ERZLXWJLXbP7CITrALxPqyNjsQAUihEiynUGvw6kaz6xsjnI151ZQRX
	 uc/aD3pg51Kr2X7glDfBv+HPXcQeWU/yey+pLpYFrESwOFvEZAmqpCJxGsNuHzBjj0
	 szdQGnhrcplekei3PGF7uUExf2cj8uaZ/+MA+GuJ0dmE7ez7MtKg4Ym87ppt32ySsW
	 8JqvSsPr0bG5g==
Message-ID: <sashiko-outbox-169829@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/15] perf annotate-arm64: Support store instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <eb44bbf4b74555bc43f3659f4733faff403debbf.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <eb44bbf4b74555bc43f3659f4733faff403debbf.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:36:55 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf annotate-arm64: Stale type tracking on status register in e=
xclusive stores
--

commit e02fcbc321646663dec228cbae05f99e569cc5a5
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support store instruction tracking

Extend update_insn_state_arm64() to handle standard store instructions
(str, stur, stlr, stp). Exclusive stores (e.g., stxr, stxp) are omitted
as they exhibit different operand semantics. The patch also updates
pre-index and post-index addressing modes for the destination register.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index fb48bf95b32ff..54d9928b536fd 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -661,6 +661,20 @@ static void update_load_insn_state(struct type_state=
 *state,
>  	adjust_reg_index_state(state, dloc, dl, src);
>  }
> =20
> +/*
> + * Match standard store variants (str, stur, stlr, stp) that follow
> + * straightforward store semantics: source registers on the left (read-o=
nly)
> + * and memory target on the right. Excludes exclusive stores (stxr, stxp=
, etc.)
> + * which have status/result register side effects.
> + */
> +static bool is_standard_store_insn(const char *name)
> +{
> +	return !strncmp(name, "str", 3)  ||  /* str, strb, strh */
> +	       !strncmp(name, "stur", 4) ||  /* stur, sturb, sturh */
> +	       !strncmp(name, "stlr", 4) ||  /* stlr, stlrb, stlrh */
> +	       !strncmp(name, "stp", 3);     /* stp */
> +}

[Severity: Medium]
Will this result in stale type tracking for the status registers modified
by exclusive store instructions?

Since exclusive stores like stxr are excluded here, they fall through and
are ignored.  However, because arm64__insn_is_target_on_right("stxr")
places the memory operand in dst (so dst->mem_ref is true), the generic
invalidation block in update_insn_state_arm64() is also completely bypassed:

	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
	    !is_standard_load_insn(dl->ins.name)) {
		...

For an instruction like "stxr w0, x1, [x2]", the CPU modifies the status
register (w0, parsed into src->reg1). Since it skips both standard store
processing and the generic invalidation block, does the tracker leave the
status register's type state unaltered and allow stale types to propagate?

[ ... ]

> @@ -742,6 +756,17 @@ static void update_insn_state_arm64(struct type_stat=
e *state,
>  	/* Memory to register transfers */
>  	if (is_standard_load_insn(dl->ins.name))
>  		update_load_insn_state(state, dloc, dl, src, dst);
> +	/* Register to memory transfers */
> +	else if (is_standard_store_insn(dl->ins.name)) {
> +		/*
> +		 * Ignore transfers since it'd set a value in a struct
> +		 * and won't change the type.
> +		 *
> +		 * Needs to update the pre-index and post-index addressing
> +		 * modes for the destination register.
> +		 */
> +		adjust_reg_index_state(state, dloc, dl, dst);
> +	}
>  }
>  #endif
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D6
