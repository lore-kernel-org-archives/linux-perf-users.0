Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999E4BEE5F
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Sep 2026 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192678; cv=none; b=LHKlInan1iG8Iy2ivRgTNUxGPGEwrMnYEs5jl0RwKF2q4oeynLjSn/+14O9BJxYHsYbCWLxa5oVmBe6Xead+ZE6/sO5rXCfxh4Go5TMytWbxSY+vzmbhrNCMkqPOALJIDcjK9DWpPotjQYW7MlYPAuQVMN2AVi8akG5YMCkBYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192678; c=relaxed/simple;
	bh=SKVQY8LymVLMGEY8EfqppoHWGJ0xJ/zKlxAt4OOyt+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kQxovPJrIxBs1Gw8o+CJHyjYZDrNEZQOuZUq7pf3UQBLll99anpGNwLGJwPxuznESomFXAOH3tzeHZ+70lXYzRc1cF/EGeDTTp3tHcTc4PDw0kWTz79dOkT5hiGx9fHiueKs9kNcQ3ae+qTeTpjOvM8/IKw9tbueddm1FliWFsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQXMhT49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQXMhT49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEC81F00893;
	Sat, 12 Sep 2026 05:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789192676;
	bh=8LKOCMvjr+Zy1XeLy5tVo8Z+j3ufusi5wf61jFTr4MY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PQXMhT49gKrq5mjc8XNrsmw0w6xTxePoNXh7xst/T7h6G1P/EwnJyIkiXbF6WTl2o
	 gyV010qwIHQirGiJ0U+MrEt7EVCRFmIHAgei/9xrgo8w57rSflU07BpDoytWnhYSDD
	 k2p/ag5Nt9Ds9BmiwTpB8iZH3sfLhgMC2jYTRuJYlTfrtGlKN1JWywBbXayolkkh3N
	 7mw6722gRuGCQXyWOtMRZO6dKMeZKtNO0fyc1t9fGBH/XSkD+/V0MqAdKG0NTBOOcb
	 HENN8Mx32PnfBCZSSBmlvMY+fq5oGmFzLg9TcDvxmNF1n30SGDRGtKbFlVUh8J/ox6
	 9oZWpFR9LDB5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf annotate-data: Adjust type offset for
 flex-array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260912054706.1475583-5-namhyung@kernel.org>
References: <20260912054706.1475583-1-namhyung@kernel.org>
 <20260912054706.1475583-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 05:57:56 +0000
Message-Id: <20260912055756.8BEC81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Division by zero when calculating the adjusted offset for a flexib=
le array member if the array element size is zero.
- [Medium] `find_flex_array()` fails to find the flex array member if the o=
uter struct has trailing padding.
- [Medium] Fallback struct matching fails for typedefs and unions.
- [Medium] Struct padding holes are incorrectly annotated as the last membe=
r.
--

commit 29427abf6848041f9bb5e65c33e21982de9656cd
Author: Namhyung Kim <namhyung@kernel.org>

perf annotate-data: Adjust type offset for flex-array

The flex array members are located beyond the original type size.  Also
it needs to adjust the offset in an array to find a corresponding
element using module operation.  Note that we focus on access to type and
field, so array index is not important.

Make sure to find a field name for flex arrays.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index ad043403ced58..0789a8cbea7c0 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
[ ... ]
> @@ -332,19 +332,40 @@ static void delete_members(struct annotated_member =
*member)
>  }
> =20
>  static int fill_member_name(char *buf, size_t sz, struct annotated_membe=
r *m,
> -			    int offset, bool first)
> +			    int offset, bool first, bool has_flex_array)
>  {
[ ... ]
> +	if (!found && has_flex_array) {
> +		/*
> +		 * It may have an intermediate struct that has another struct that
> +		 * contains a flex array.  In that case, the outer struct itself is
> +		 * has no array and the size is less than the offset so the above
> +		 * logic won't find the outer struct at the offset.  Let's use the
> +		 * last struct if it couldn't find a member for the flex array.
> +		 */
> +		child =3D list_last_entry(&m->children, struct annotated_member, node);

[Severity: Medium]
In fill_member_name() in tools/perf/util/annotate-data.c, if the requested
offset doesn't fall into any member's bounds (which occurs for accesses to
padding bytes between fields), found remains false. If has_flex_array is tr=
ue,
this block unconditionally assigns child to the last member and sets found =
to
true.

Will this cause random memory accesses to padding bytes to be erroneously
annotated as valid accesses to the flexible array's parent struct?

> +
> +		if (!strstr(child->type_name, "struct "))
> +			return 0;

[Severity: Medium]
In fill_member_name() in tools/perf/util/annotate-data.c, can this fallback
struct matching fail for valid nested flexible arrays declared with a typed=
ef
or a union?

If the nested intermediate member was declared using a typedef (e.g.,
typedef struct { ... } foo_t;), the DWARF type name will be foo_t, lacking
the substring "struct ". If it is a union, its type name begins with "union=
 ".
In these cases, this check fails, causing the function to incorrectly retur=
n 0
and drop the annotation.

> +
> +		found =3D true;
> +	}
[ ... ]
> +static struct annotated_member *find_flex_array(struct annotated_member =
*m, int offset)
> +{
> +	struct annotated_member *child;
> +
> +	if (list_empty(&m->children))
> +		return NULL;
> +
> +	child =3D list_last_entry(&m->children, struct annotated_member, node);
> +	if (offset =3D=3D child->offset && strstr(child->type_name, "[]"))
> +		return child;

[Severity: Medium]
In find_flex_array() in tools/perf/util/annotate-data.c, will this strict
offset equality check fail if the outer struct has trailing padding?

When get_flex_array_member() calls find_flex_array(&adt->self, adt->self.si=
ze),
the offset argument is the struct's total padded size. If the struct contai=
ns
trailing alignment padding (e.g., a previous 8-byte aligned member followed=
 by
the flex array), the struct's padded total size will be strictly greater th=
an
the actual starting offset of the flex array.

Will this cause find_flex_array() to fail the equality check and incorrectly
recurse into the flex array itself, returning NULL and bypassing the offset
adjustment logic?

> +
> +	return find_flex_array(child, offset);
> +}
[ ... ]
> @@ -1743,6 +1786,7 @@ struct annotated_data_type *find_data_type(struct d=
ata_loc_info *dloc)
[ ... ]
> +	if (result->flex_array && dloc->type_offset > result->self.size) {
> +		struct annotated_member *flex_array =3D get_flex_array_member(result);
> +		if (flex_array) {
> +			int offset =3D dloc->type_offset;
> +
> +			/* adjust offset in the flex array */
> +			offset -=3D result->self.size;
> +			offset %=3D flex_array->size;

[Severity: High]
In find_data_type() in tools/perf/util/annotate-data.c, is it possible for
this modulo operation to divide by the flexible array's element size without
validating that the size is non-zero?

The flex_array->size is determined by getting the size of the array's eleme=
nt
type. If the element type is an empty struct (a GCC extension with size 0) =
or
an incomplete type where DWARF size cannot be determined, flex_array->size
becomes 0.

Could evaluating offset %=3D 0 here directly expose the perf tool to a
divide-by-zero exception (SIGFPE) and crash?

> +			offset +=3D result->self.size;
> +
> +			dloc->type_offset =3D offset;
> +		}
> +	}
> +	return result;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912054706.1475=
583-1-namhyung@kernel.org?part=3D4
