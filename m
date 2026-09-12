Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5633C1B6
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Sep 2026 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192947; cv=none; b=Qz9Wy+FszncGo1PSp46EEZBtsn+50QTTnkhNrdukmF0hRIxrj5BA0rDNteV4AV4s0Sa7utkrWb49GjtDqq401fojt95oO3d0q4beqeDqpL3+VK3FA4Ug5fZB62RFe9e8Zdoqjnd+gmXIDS7yDWlQpgL27fMP2+NssHZbvzEqt7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192947; c=relaxed/simple;
	bh=uckOuxpbxfW+AeHObLsb9irUz1l3g/DJXAl2jhhQoEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tehAKbXzPINgo2f8pb6lTZRYx1gkqy2DVniFgC00O96AxTmiFTu9EMSXZuMQJWCx7OC62wzZDm3r46fOAbYIE8W6IGR4mO4qzHe6eKRtivJ5cPVemtD+Rcgq8sibc8zHbR5If6nJ6N8pKmN+Up8RCTocxIj/xD/5XsJjiynvrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiZnUkUY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiZnUkUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D271F000FF;
	Sat, 12 Sep 2026 06:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789192945;
	bh=3n8vViKdENAni/lS2R2/oi2Mkoec1/+s4GLHXoB13Vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fiZnUkUY+4s+3J79GFAyx6Ym52pOQ6vapNDV2gdTwG8dLGHi+iNy/5H39/n9D5Enu
	 ESftx9Jp7k3KASMDaNXHq7L2VzAPVRbnU1NHf83KuIFJtF8/l27A/h/hBcXlLSoU8x
	 9X89r5rraEmdzLUKW+jzY3h7wiTr2195Duf2mFhJQf6P2ugqeKAWXRqpRG1Mb0O+MG
	 ak1+xXwIlIIBJxUmun+FmfzNdM+FZ3BaW1qMOkI/VYNe+jkD4T3nNSyI0P94auL9HQ
	 YBZCcaUpa2aqol06R0HaUKHFKIOvNwvX+8ALS9ldtZOEfl2HJyppJTCbKsuW2FJOir
	 h7vSMKkJ8hSCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf annotate-date: Allow out-of-size access for
 flex-array types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260912054706.1475583-4-namhyung@kernel.org>
References: <20260912054706.1475583-1-namhyung@kernel.org>
 <20260912054706.1475583-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 06:02:24 +0000
Message-Id: <20260912060225.69D271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The patch breaks the negative bounds check for variables containing=
 flexible arrays, allowing invalid negative offsets to be falsely accepted.
- [Low] Failure to expand flexible array elements if the element type is a =
typedef.

Pre-existing issues:
- [Low] Missing explicit inclusion of <string.h> for libc string functions,=
 violating musl compatibility subsystem guidelines.
--

commit 71730adfd191d6d7dd60b7b99d73c9bc2ede7031
Author: Namhyung Kim <namhyung@kernel.org>

    perf annotate-date: Allow out-of-size access for flex-array types
   =20
    Structs that have a flex array will have accesses beyond its original
    size as the array was declared as 0 sized.  For now, it just allow any
    offset bigger than the size.  It could be refined later.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index aff60a630fd05..ad043403ced58 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -8,5 +8,5 @@
>  #include <errno.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <inttypes.h>
>  #include <linux/zalloc.h>

[Severity: Low]
This is a pre-existing issue, but is there a missing include for <string.h>
in tools/perf/util/annotate-data.c? The file uses libc string functions like
strcmp and strdup, and failing to explicitly include <string.h> violates the
subsystem guidelines for musl libc compatibility, which could lead to build
failures.

[ ... ]

> @@ -248,8 +248,15 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	else
>  		die_mem =3D member_type;
> =20
> -	if (dwarf_aggregate_size(&die_mem, &size) < 0)
> -		size =3D 0;
> +	if (dwarf_aggregate_size(&die_mem, &size) < 0) {
> +		if (dwarf_tag(&die_mem) =3D=3D DW_TAG_array_type) { /* flex-array? */
> +			__die_get_real_type(&die_mem, &die_mem);

[Severity: Low]
Will __add_member_cb() fail to resolve typedefs here? Using
__die_get_real_type instead of die_get_real_type strips const and volatile
qualifiers but stops at DW_TAG_typedef. This prevents the subsequent struct
expansion if the flexible array element type is a typedef of a struct.

> +			if (dwarf_aggregate_size(&die_mem, &size) < 0)
> +				size =3D 0;
> +		} else {
> +			size =3D 0;
> +		}
> +	}
> =20
>  	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr)) {

[ ... ]

> @@ -559,7 +567,7 @@ static enum type_match_result check_variable(struct d=
ata_loc_info *dloc,
>  		return PERF_TMR_NO_SIZE;
> =20
>  	/* Minimal sanity check */
> -	if ((unsigned)offset >=3D size)
> +	if ((unsigned)offset >=3D size && !die_has_flex_array(&sized_type))

[Severity: Low]
Does check_variable() allow invalid negative offsets to bypass the check?
Since offset is cast to unsigned, a negative offset evaluates to a large
positive number. If the type has a flexible array, the negative bounds check
is now broken and the offset will be falsely accepted.

>  		return PERF_TMR_BAD_OFFSET;
> =20
>  	return PERF_TMR_OK;

[ ... ]

> @@ -1168,7 +1176,7 @@ static enum type_match_result check_matching_type(s=
truct type_state *state,
> =20
>  		/* Get the size of the actual type */
>  		if (dwarf_aggregate_size(&sized_type, &size) < 0 ||
> -		    (unsigned)dloc->type_offset >=3D size)
> +		    ((unsigned)dloc->type_offset >=3D size && !die_has_flex_array(&siz=
ed_type)))

[Severity: Low]
Could this logic in check_matching_type() lead to negative offsets bypassing
the check as well? Similar to check_variable(), casting dloc->type_offset to
unsigned causes negative values to appear as large positive numbers, bypass=
ing
the bounds check if there is a flexible array. This flaw is repeated multip=
le
times in the pointer tracking logic.

>  			return PERF_TMR_BAD_OFFSET;
> =20
>  		return PERF_TMR_OK;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912054706.1475=
583-1-namhyung@kernel.org?part=3D3
