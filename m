Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD039B48F
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369252; cv=none; b=DVydnD9fo9S1KwUlKhOoIWRnOM32TY+DJ8WAnWRoQUkLG68DeSA9VcWM/gnLsNbiseZlf3htYia1ay7ycR8wvt02WeSJ98fA64HKLwjDeAgp7YHaqoNNk/ym3bPT4nHUWfiAdkPPHea16a13rRskdBquV3r1C4nDvAxk2MsXK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369252; c=relaxed/simple;
	bh=lX5/OA4U2IDMVP8HhPp0ljJUHU3isqA5s0wq8oXcFFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aWjEe5z7VzfWoYLcVo5hWPZ5iweuxk+ibWnPPu9dmOBsxGViK0JtLkS+3LLZM4FZji/aTAYtRFhwLG4Lx/wxCz0M0FH2HkcIB77ShPdwQJPokFTtQKQS90DHOCI/3rBcreU7UgdZLNqbQRZjlajWV/BSwh72ZfWYDw/of5+G5aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3eKypae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3eKypae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635701F0089C;
	Mon, 14 Sep 2026 07:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789369249;
	bh=HEfdZ/gEBGnL755TKdY31f6Nec94BesoTOrzCjhUKx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F3eKypaeAUGRHmUKDm3r+woZ0VgYiu7HtyZaZwui37U7B7WJ4ZvnKbLAFCJhkwPmb
	 reyA6VLDIAAPdtqKqtO4/VTEIIuXCul4RmHFxIEs7jZHsu7gY8D13jz54mpucFATgR
	 CG6wDl+SVKYAjkSL4HeS66b/pB19dcvNM+o6TjGcX/SWCbUO1PD2zV4PxEaTQVapj2
	 sxu/vupo0zO1b98yBaugv+km2m3FpU2yxnq/Fu55We+Rfrd46ycjrVpl/RPr6y+sR+
	 dgT48On9QLxH67Q4BEysmt57pLPqzZ+NCeGFZHssVfN0D5vsRZPCt2gfb+ecXQgnmJ
	 Upsxz3SBTKSnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] perf annotate-date: Allow out-of-size access for
 flex-array types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914064535.1671939-4-namhyung@kernel.org>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 07:00:48 +0000
Message-Id: <20260914070049.635701F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] check_variable and check_matching_type fail to pass the typedef-=
resolved 'sized_type' to 'check_type_offset', causing an unused variable wa=
rning and breaking flex-array detection for typedefs.
- [Medium] Uninitialized stack variable 'last_mb' is used in 'die_has_flex_=
array_recurse' if a structure contains children but no data members.
--

commit cd675d28ffa1b31e0fe343fa27c89e7794eb74ec
Author: Namhyung Kim <namhyung@kernel.org>

perf annotate-date: Allow out-of-size access for flex-array types
   =20
Structs that have a flex array will have accesses beyond its original
size as the array was declared as 0 sized.  For now, it just allow any
offset bigger than the size.  It could be refined later.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index aff60a630fd05..e8aff6a916c0a 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c

[ ... ]

> @@ -399,6 +407,7 @@ static struct annotated_data_type *dso__findnew_data_=
type(struct dso *dso,
>  	result->self.type_name =3D type_name;
>  	result->self.size =3D size;
>  	INIT_LIST_HEAD(&result->self.children);
> +	result->flex_array =3D die_has_flex_array(type_die);

[Severity: Medium]
Will this call into die_has_flex_array_recurse() trigger an uninitialized
stack variable access for empty structures?

If the structure has child DIEs but none of them are DW_TAG_member, the
last_mb variable won't be assigned in the loop, leaving it uninitialized
when evaluated:

tools/perf/util/dwarf-aux.c:die_has_flex_array_recurse() {
	Dwarf_Die die_mem, last_mb;
...
	do {
		if (dwarf_tag(&die_mem) !=3D DW_TAG_member)
			continue;
...
		if (tag =3D=3D DW_TAG_structure_type)
			memcpy(&last_mb, &die_mem, sizeof(last_mb));

	} while (dwarf_siblingof(&die_mem, &die_mem) =3D=3D 0);

	if (tag =3D=3D DW_TAG_structure_type) {
		if (is_flex_array_member(&last_mb))
			return true;
...

Should last_mb be initialized, or should we track whether it was set before
calling is_flex_array_member()?

> =20
>  	if (symbol_conf.annotate_data_member)
>  		add_member_types(result, type_die);

[ ... ]

> @@ -554,15 +580,7 @@ static enum type_match_result check_variable(struct =
data_loc_info *dloc,
>  	else
>  		sized_type =3D *type_die;
> =20
> -	/* Get the size of the actual type */
> -	if (dwarf_aggregate_size(&sized_type, &size) < 0)
> -		return PERF_TMR_NO_SIZE;
> -
> -	/* Minimal sanity check */
> -	if ((unsigned)offset >=3D size)
> -		return PERF_TMR_BAD_OFFSET;
> -
> -	return PERF_TMR_OK;
> +	return check_type_offset(type_die, offset);
>  }

[Severity: Medium]
Should this pass &sized_type instead of type_die?

Passing type_die ignores the typedef resolution performed earlier in this
function and leaves sized_type completely unused. Since check_type_offset()
now evaluates die_has_flex_array(type_die), this might break flex-array
detection for types hidden behind typedefs.

[ ... ]

> @@ -1190,12 +1202,7 @@ static enum type_match_result check_matching_type(=
struct type_state *state,
> =20
>  		dloc->type_offset =3D dloc->op->offset + state->regs[reg].offset;
> =20
> -		/* Get the size of the actual type */
> -		if (dwarf_aggregate_size(type_die, &size) < 0 ||
> -		    (unsigned)dloc->type_offset >=3D size)
> -			return PERF_TMR_BAD_OFFSET;
> -
> -		return PERF_TMR_OK;
> +		return check_type_offset(type_die, dloc->type_offset);
>  	}

[Severity: Medium]
For pointer types here, should type_die also be stripped of typedefs before
checking the type offset?

Similar to the logic used for TSR_KIND_TYPE, flex-arrays might go undetected
if they are hidden behind unresolved typedefs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914064535.1671=
939-1-namhyung@kernel.org?part=3D3
