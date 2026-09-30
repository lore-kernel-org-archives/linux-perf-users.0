Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31E4F55B3
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802653; cv=none; b=dzlj/C0V6VvOvqt6Gx8iyQwdWX+vw+ouQeh74Dp1kZs+B5ltHkLPWxamyiu0Zu+3eF3OI7Qv5NYPJUpwhgHtRVCb9G/uvtO+eRlvB/dSR9PLxU1/rQRB+i/AzXkDcjEdM7f7KmPuSviMHUhpLZrRySu6Raz7Rk4AF/W6Mp3zdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802653; c=relaxed/simple;
	bh=Ivgb1rwYxUc1S0q8v7/wfPgF49/78uvwmClxnhHDwrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pXDVllNQIiluqUVwLImJVdGPoQDw3sOAywO0C4OfAyROjd7R+pcVDesp9KYbw0+Z7oIzDzTULLFAEkaWPl2TvfJWPywHn2+J3pepAQpIFwcFxCvhtKQa1uSrKjVl6ciFLNY4fgJA7vgpV2fHwAxyrb9xi/kUMWY4laD8Y8HAkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYDzn30k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYDzn30k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFDA1F000FF;
	Wed, 30 Sep 2026 21:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790802651;
	bh=5kw7o0C4xtN1bpKMyJewq9U07FFjvqe6P6x7MXOPFqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QYDzn30kGPYB8F5uRPKzDpZ9xeKwD0H2H56F2rqQ7IFtWewt3ZHb5t3vW5+98w1CX
	 +8aqBRSovJHIp7yLIozRZpO4Jpy6FQQ+EbpQKh94s43tNHhTLPWH4kt6lE9yCl5t26
	 7RRVOsxVHQOToyQ1uwAV15UVzg/Hj0P8MAc/LqM9tfwMG7DGz/gQPtsiaelauGSe3y
	 baMTbb4/KaocJHnFWqHIaWkfdbMETWnkOM7UJpIpDrsqGESGU6U9ZFp5gLnFNUIwdw
	 nAfOZ4v2OoNArVaGvzpFdrvxejFqle4YPhlqtYSuYTf7vWTeaYe82ZrgGrGY9N1JJG
	 Ts4gNtvBRFeNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf dwarf-aux: Add die_is_compound_type() to
 handle C++ class types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930210038.196928-2-yzhao62@ncsu.edu>
References: <20260930210038.196928-1-yzhao62@ncsu.edu>
 <20260930210038.196928-2-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:10:51 +0000
Message-Id: <20260930211051.8EFDA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf/dwarf-aux: stack overflow in __die_find_member_offset_cb via =
cyclic inheritance
- [Medium] perf/dwarf-aux: flex array detection fails for C++ classes
--

commit 3f3b9b56b2e28f1713af3b40ab8946d5bbc8d245
Author: Yanbo Zhao <yzhao62@ncsu.edu>

perf dwarf-aux: Add die_is_compound_type() to handle C++ class types

This commit introduces die_is_compound_type() to support C++ classes alongs=
ide
structs and unions. It also updates offset lookups to descend into base cla=
ss
subobjects using DW_TAG_inheritance entries.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 54f8b5ec74a2f..eb4b8f3475df1 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -61,6 +61,14 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
>  	return dwarf_formstring(&attr);
>  }
> =20
> +bool die_is_compound_type(Dwarf_Die *type_die)
> +{
> +	int tag =3D dwarf_tag(type_die);
> +
> +	return tag =3D=3D DW_TAG_structure_type || tag =3D=3D DW_TAG_union_type=
 ||
> +	       tag =3D=3D DW_TAG_class_type;
> +}

[Severity: Medium]
Does die_has_flex_array_recurse() also need to be updated to use this new
helper?

If we look at die_has_flex_array_recurse() in tools/perf/util/dwarf-aux.c,
it currently forces flex array detection to return false for C++ classes
because it explicitly ignores DW_TAG_class_type:

    if (tag !=3D DW_TAG_structure_type && tag !=3D DW_TAG_union_type)
        return false;
    ...
    if (tag =3D=3D DW_TAG_structure_type && found) {
        if (is_flex_array_member(&last_mb))
            return true;

Could this cause accesses to flex array members inside C++ classes to be
wrongly rejected as out-of-bounds?

[ ... ]

> @@ -2164,6 +2180,30 @@ static int __die_find_member_offset_cb(Dwarf_Die *=
die_mem, void *arg)
>  			loc =3D 0;
>  	}
> =20
> +	if (tag =3D=3D DW_TAG_inheritance) {
> +		Dwarf_Die base_die, member_die;
> +
> +		/*
> +		 * A base class subobject can be smaller than the size of the
> +		 * class type: an empty base takes no space (EBO) and a member
> +		 * of the derived class can be placed in the tail padding of
> +		 * the base.  In both cases a member of the derived class is
> +		 * at the same offset as the base, so only match the base if
> +		 * it actually has a member at the offset.
> +		 */
> +		if (offset < loc)
> +			return DIE_FIND_CB_SIBLING;
> +
> +		if (die_get_real_type(die_mem, &base_die) =3D=3D NULL)
> +			return DIE_FIND_CB_SIBLING;
> +
> +		if (die_find_child(&base_die, __die_find_member_offset_cb,
> +				   (void *)(long)(offset - loc), &member_die))
> +			return DIE_FIND_CB_END;

[Severity: High]
Does this recursive call into the DWARF child tree lack a depth limit?

Unlike __add_member_cb(), there is no recursion depth limit tracked or
enforced here. If a maliciously crafted or corrupted DWARF file contains
cyclic inheritance (e.g., A inherits from B, B inherits from A), could
this trigger unbounded mutual recursion between die_find_child() and
__die_find_member_offset_cb(), rapidly exhausting the stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210038.1969=
28-1-yzhao62@ncsu.edu?part=3D1
