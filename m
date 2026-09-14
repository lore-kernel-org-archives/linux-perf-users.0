Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03D33ADA0
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368841; cv=none; b=Kh3VmfBCzTaw6s84n5Rhxzp4gLjygtb029fjKTKlQ2ZsSxUNxXi7phasE/vDMO00Hs+YXx95sd2ZYDLtvsLvDFuuCBaFW2hTD5GFJkVBdrkqpQwslx/2Ig3GLV50Y9YYhtVoVwOhqZg74B8sHluEXN2R7so4SsuVtz0RXo+7GeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368841; c=relaxed/simple;
	bh=SlSlFLCZP9h+zUDCOY67OjS1bRzhLolqMTLHkrfkjTc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NDj4Yo4suZIFIjBeUWfkGr4z1SgMIuMU/DJM9rOqbBbRQX2aR0hq/r910gmrfr2RjYu5VApngHf2stQUxQ1wobmQyLhwhHsuE0Rj0SAOXgvVWpuBPTnQl9UldmmPi2LgnS0miHCGi4akaw/EuBRTMZmO0c51MrbaEeqOctmAzcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtDZ0r7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtDZ0r7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC5F1F000FF;
	Mon, 14 Sep 2026 06:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368840;
	bh=YaAfLWTNNipVpbSM36+5OfVxfWixWl92c8bdpiOjnKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WtDZ0r7QK5iPdj8hw8f22/fcubCSkbl2CBo8wUK4NarfJIduieOXXpPJb2WIN7XZK
	 Kqn4yNF0NqGcDutkfoFDIXTiZ97GMkXa6NE1uBfFDjVN9Zrwar1ZtXEZEbh4PQboQx
	 tfd/Yxt0J63rJcse0Eg3+Plk4i/V84FrPvcwJhPKvscHJ0mFKFNcQUZt0aiucCeEzV
	 Sx9Kmd3QsLT9Drw8XcMKlGH7Oe2bIn7bi3Gd78cYR04ZkbwkBIGB3wvSbwCY4FlFEZ
	 nXLjWXxpZ29O9IKbJgxXpJiTzZOEUwK09VHFQk8w2YU+PVuJMFjVLTZuvU92xZI+tB
	 ZoT8DuEJkAYMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf dwarf-aux: Add die_has_flex_array() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914064535.1671939-3-namhyung@kernel.org>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:53:59 +0000
Message-Id: <20260914065359.EDC5F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The local variable `last_mb` is accessed uninitialized if a struct=
 contains DWARF children but none of them are data members.
- [Low] Missing explicit inclusion of `<string.h>` for `memcpy` usage, viol=
ating the POSIX libc headers subsystem rule.
--

commit 63614557ac58c6c9c6f30f55cff70e30709d2a8b
Author: Namhyung Kim <namhyung@kernel.org>

perf dwarf-aux: Add die_has_flex_array() helper

The die_has_flex_array() returns true when the given type is a compound
type and contains an array at the end.  To prevent an infinite recursion
add a depth field to the internal function.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index d7160f87ac7d7..465824e6513eb 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
[ ... ]
> +static bool die_has_flex_array_recurse(Dwarf_Die *parent_die, int depth)
> +{
> +	Dwarf_Die die_mem, last_mb;
> +	int tag =3D dwarf_tag(parent_die);
> +
> +	if (tag !=3D DW_TAG_structure_type && tag !=3D DW_TAG_union_type)
> +		return false;
> +
> +	/* prevent infinite recursion */
> +	if (depth > MAX_FLEX_ARRAY_RECURSION)
> +		return false;
> +
> +	if (dwarf_child(parent_die, &die_mem))
> +		return false;
> +
> +	do {
> +		if (dwarf_tag(&die_mem) !=3D DW_TAG_member)
> +			continue;
> +
> +		if (tag =3D=3D DW_TAG_union_type) {
> +			if (is_flex_array_member(&die_mem))
> +				return true;
> +
> +			if (die_get_real_type(&die_mem, &last_mb) &&
> +			    die_has_flex_array_recurse(&last_mb, depth + 1))
> +				return true;
> +		}
> +
> +		if (tag =3D=3D DW_TAG_structure_type)
> +			memcpy(&last_mb, &die_mem, sizeof(last_mb));
                        ^^^^^^
[Severity: Low]
This isn't a bug, but this memcpy() call relies on implicit inclusion of
<string.h>. Should we explicitly include <string.h> at the top of the file
to ensure musl compatibility?

> +
> +	} while (dwarf_siblingof(&die_mem, &die_mem) =3D=3D 0);
> +
> +	if (tag =3D=3D DW_TAG_structure_type) {
> +		if (is_flex_array_member(&last_mb))
                    ^^^^^^^^^^^^^^^^^^^^
[Severity: High]
If a structure has DWARF children (such as DW_TAG_subprogram or
DW_TAG_typedef), but none of them are DW_TAG_member, the memcpy() above is
skipped due to the continue statement.

Will this cause is_flex_array_member() to access an uninitialized
last_mb variable?

> +			return true;
> +
> +		if (die_get_real_type(&last_mb, &die_mem))
> +			return die_has_flex_array_recurse(&die_mem, depth + 1);
> +	}
> +
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914064535.1671=
939-1-namhyung@kernel.org?part=3D2
