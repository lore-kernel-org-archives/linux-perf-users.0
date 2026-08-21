Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0613F4830
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787289237; cv=none; b=syZfVHIKhdQLBEaVWRy/AfdQZmIN0WWtodS69QyvIc5j0BAICA3QQXuwG4K1hKJX/VKDtnTZFfCAfdIWo8rj6xZ++iWzNSrCDJck1nNw37HoyGaF1FIkTGe2QZlHnFGyPWiyuHKpQmGJRkKn3K3N+FxdKfcD8heN20MXDgZ/u9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787289237; c=relaxed/simple;
	bh=zH15lBTD6HKqm9v8NlmgG8mjMeSlb1v/LBTJYY5OMZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pj93QrAB/M3GFKeN5T9t2NxeijRlUotO0B0vOx1H2tIcw4ZwLn8+n7UTKC1sEaFRyn5/TOWyItDNXJOOdGBv+32aSZ4v2Bi0YF25GhMyhx5p3hKkNWCYDexklR3J+tr0zbsb8LOyRWS4jUObS67Axgv3uxM8CA0XYYyLMFt9RI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enGYhV11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enGYhV11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF9D1F000E9;
	Fri, 21 Aug 2026 05:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787289236;
	bh=7AlJshfOxUKFj+HI8XuaOBEpbEW+ntYNb25FbAgMxJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=enGYhV11WIbkYybneIm9JbAuGMgo/f8Mw6p+BI+EOJiZKiU4wF+Wunt45pAbyFgIW
	 Kzlas1OTRMXVDabLTyrm3ji8XC2gCdopQy93jrclGM/WBfcbE86mlb2LGZ6V2WN0FZ
	 tSfgKSTlsvGmHuE5Ig/HjYeqL1bpbVtvIIf/fo86W68Te1u1FGPEwy7bWaz3lRnWzB
	 dCdYSzl5CQNw594b2LfGsXPF0jeG1CyXsBl7EGkFERlZOE4NH6jEqMEjXt1gUj2eJj
	 MwRxphpxPlux+lH3NbOza4uha0zH2bGw3NIp5cJ3CgqXZ4zetCBnlsyKd/lYtT8mDe
	 lzMFvLX72bLKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf dwarf-aux: Add die_is_compound_type() to
 handle C++ class types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821050207.4517-2-yzhao62@ncsu.edu>
References: <20260821050207.4517-1-yzhao62@ncsu.edu>
 <20260821050207.4517-2-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 05:13:55 +0000
Message-Id: <20260821051356.2BF9D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Empty Base Optimization (EBO) causes zero-sized base classes to =
shadow data members at the same offset.
- [Medium] Virtual inheritance uses complex location expressions that are u=
nsupported, silently defaulting to offset 0.
--

--- Patch [1]: [PATCH 1/3] perf dwarf-aux: Add die_is_compound_type() to ha=
ndle C++ class types ---
commit 9d64a45d6e2e13c946726cd0182607e969f8dd87
Author: Yanbo Zhao <yzhao62@ncsu.edu>

perf dwarf-aux: Add die_is_compound_type() to handle C++ class types

Introduce the die_is_compound_type() helper which checks for
DW_TAG_structure_type, DW_TAG_union_type, and DW_TAG_class_type, and
convert all the existing open-coded struct/union tag checks to use it.
Also accept DW_TAG_inheritance so member lookup descends into C++ base
classes.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -230,9 +230,9 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	Dwarf_Word size, loc, bit_size =3D 0;
>  	Dwarf_Attribute attr;
>  	struct strbuf sb;
> -	int tag;
> +	int tag =3D dwarf_tag(die);
> =20
> -	if (dwarf_tag(die) !=3D DW_TAG_member)
> +	if (tag !=3D DW_TAG_member && tag !=3D DW_TAG_inheritance)
>  		return DIE_FIND_CB_SIBLING;

[Severity: Medium]
Since DW_TAG_inheritance is now processed here, how does this handle virtual
inheritance? Virtual base classes often use complex DWARF location
expressions (like DW_OP_deref).

Looking at the location parsing slightly further down in __add_member_cb():

    if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr)) {
        if (dwarf_formudata(&attr, &loc) !=3D 0) {
            if (die_get_data_member_location(die, &loc) !=3D 0)
                loc =3D 0;
        }
    }

If die_get_data_member_location() fails due to an unsupported complex
expression, it silently defaults to offset 0. Will this incorrectly assign
virtual base classes an offset of 0, potentially masking actual fields at
offset 0 like the vtable pointer?

[ ... ]
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
[ ... ]
> @@ -2053,7 +2061,7 @@ static int __die_find_member_offset_cb(Dwarf_Die *d=
ie_mem, void *arg)
>  	Dwarf_Word offset =3D (long)arg;
>  	int tag =3D dwarf_tag(die_mem);
> =20
> -	if (tag !=3D DW_TAG_member)
> +	if (tag !=3D DW_TAG_member && tag !=3D DW_TAG_inheritance)
>  		return DIE_FIND_CB_SIBLING;

[Severity: Medium]
With DW_TAG_inheritance now included, does this code correctly handle the
Empty Base Optimization (EBO)?

Zero-sized base classes share the same offset as the first data member.
Further down in __die_find_member_offset_cb(), there is an exact offset
match check:

    if (offset =3D=3D loc)
        return DIE_FIND_CB_END;

Since an empty base class often appears first in DWARF before the data
member, will this unconditionally return DIE_FIND_CB_END when matching the
empty base class? This appears to stop the search and cause data type
resolution to fail for the actual data member at the same offset.

Additionally, __die_find_member_offset_cb() contains similar location parsi=
ng
to __add_member_cb() which falls back to 0 if die_get_data_member_location()
fails. Could this also cause virtual base classes to incorrectly resolve to
offset 0 here?

>  	/* Unions might not have location */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821050207.4517=
-1-yzhao62@ncsu.edu?part=3D1
