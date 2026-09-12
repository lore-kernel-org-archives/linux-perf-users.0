Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114933F8B1
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Sep 2026 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192718; cv=none; b=p/mnXALzU48NbRi4q7QrFntVyWjAnfz9GdCZORGVSE8pTLG3QbB0/ySjTetZH+LYFZRoUHSkpSqOJKt9m2osZ7BBTWaPBYVmLK8rxxFtmmIxhReQKn3LlfAohT+87ErV0n+5jMQcFmejHwSSEqyoM3Pq9G8BIA1bzk6eUA5nx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192718; c=relaxed/simple;
	bh=znmzoqtcQOzij1FzyViIbkLqGs+QVSVGqFnSdQc6AMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WMtXdnXK+j79yIcUJY9WjZ+E+iXJVlXHLa2zudvX4Qy3rTiH7Yw6JFj016OUsNwHPmDk99ojpW7yexEl6Ba1KAYQCiKjGvS4K8yW9R0Y6Y59cpIpuPHRWghEnbDkhLyS79gkYK3CiKZU7yOa765JBEaECQ81R331twIpY+/QPl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj44+qs3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj44+qs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9741F000FF;
	Sat, 12 Sep 2026 05:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789192717;
	bh=Xsve8ePDLIfJr/KCDmi9vXwNsG84+iSaa3L+4zVF3c4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kj44+qs3vGM6hQCeAgCf72GUiRRtIQ1AwX78E3C78SgWrm9CDe/wJAOEf2MPuozgz
	 fI3zgXAyLEKycGvvUW2LYeZNQVOIkFFIZpooFJ6LvVxouRceeRlvbYSKKiBo3lKQeu
	 dNuG8gwrYVc5Bh5hlX6uuvMrvI8oS27sa8+UC1dNYwclYtqsA2LNOKQm3tin+zl3Fg
	 GD8e353ebw46kDO0s1idzI3V8eFlfWJIASWUdceFEYymukn2Q3FeGjXe00J/IkaAUw
	 BZ9UoGH5+uTkHUabBJSwmfHWhR9ERgOjOK4yS+ZT4rhDPY6Jn4Bv7TDJ7jT1SsrFbr
	 /heeSmmELOLiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf dwarf-aux: Add die_has_flex_array() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260912054706.1475583-3-namhyung@kernel.org>
References: <20260912054706.1475583-1-namhyung@kernel.org>
 <20260912054706.1475583-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 05:58:36 +0000
Message-Id: <20260912055837.3D9741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] die_has_flex_array() uses a flawed heuristic (`loc =3D=3D size`) t=
o identify flexible arrays, which falsely rejects standard C structs with t=
railing alignment padding.
- [Medium] Nested structures bypass the bounds and padding validation for f=
lexible arrays, creating inconsistent logic compared to direct array member=
s.
- [Medium] The function fails to detect flexible arrays that are embedded i=
nside a trailing anonymous union.
- [Medium] Infinite recursion in die_has_flex_array() when parsing maliciou=
sly crafted cyclic DWARF structures, leading to stack exhaustion.
--

commit 8b9b8180d24f8e4da056fe22e70f6b84446a7257
Author: Namhyung Kim <namhyung@kernel.org>

perf dwarf-aux: Add die_has_flex_array() helper

The die_has_flex_array() returns true when the given type is a struct
and contains an array at the end of the struct.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index d7160f87ac7d7..98d018798fa75 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
[ ... ]
> +bool die_has_flex_array(Dwarf_Die *parent_die)
> +{
> +	Dwarf_Die die_mem, type_die;
> +	Dwarf_Word size, loc;
> +
> +	if (dwarf_tag(parent_die) !=3D DW_TAG_structure_type)
> +		return false;

[Severity: Medium]
Does this rigid check against DW_TAG_structure_type fail to detect valid
flexible arrays embedded inside trailing anonymous unions, which are freque=
ntly
used in the kernel?

[ ... ]
> +	if (dwarf_tag(&type_die) =3D=3D DW_TAG_array_type)
> +		return die_get_data_member_location(&die_mem, &loc) =3D=3D 0 && loc =
=3D=3D size;

[Severity: High]
Does this strict loc =3D=3D size equality accurately detect flexible arrays=
 when
standard C structs contain trailing alignment padding?

When preceding members do not perfectly align with the struct's maximum
alignment, the compiler pads the total struct size. For example, if a struct
has an 8-byte long, a 4-byte int, and a trailing flexible array, its total
size is padded to 16 bytes. However, the data member location (loc) of the
flexible array is 12.

Could this cause perf annotate to falsely reject legitimate samples targeti=
ng
flexible array members in padded structs by evaluating as PERF_TMR_BAD_OFFS=
ET?

> +
> +	if (dwarf_tag(&type_die) =3D=3D DW_TAG_structure_type)
> +		return die_has_flex_array(&type_die);

[Severity: Medium]
Does this recursive call bypass bounds and padding validation for flexible
arrays nested inside structures, making the logic inconsistent compared to
direct array members?

If the last member is a nested struct with no padding, it returns true,
completely ignoring any padding that may exist between the nested struct and
the end of the parent struct.

[Severity: Medium]
Is there a risk of infinite recursion and stack exhaustion when parsing
maliciously crafted cyclic DWARF structures?

If an untrusted DWARF file defines a struct A whose last member is struct B,
and struct B's last member is struct A, this recursion could overflow the
stack since it lacks depth limits or cycle tracking.

> +
> +	return false;

[Severity: Medium]
Is this fall-through where DW_TAG_union_type is unhandled, dropping support
for flexible arrays wrapped in trailing unions?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912054706.1475=
583-1-namhyung@kernel.org?part=3D2
