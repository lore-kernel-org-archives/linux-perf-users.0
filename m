Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABDB352022
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455028; cv=none; b=TvTEgO15L0yp9tlBtdhgSm+xxI0kxR4nBnOT9dkr8yQlu/gruzgcqIyTd+z11KvEKt0sgtaSLVdaJu5WmmzjSxk93SUvXVBjoZDsX8ykW+uZk7BZ9AADD6XXBDmbsivzJ9qDvZBSRfbA0tynzt1MqToTUp7saHVZOlvjACgESuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455028; c=relaxed/simple;
	bh=yQzFS6MSOOuBkvchnBXy+A5xzoMXgq2lRkA7LxbgTjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=op/tXeO8mbwHro4fD1LKC73E3YAAMyBXOeZxeJrw4BjHo8kYs8neUfAtiBzMGRS8MApOP4fDyCghBiyj+j28brc+xPiVCSUYdXPW02lfhJhzhYpO2Xbngmmq/UkrNaMHUZJdK5tyKV35V2eAhdW7KpTBYWJHraVfFLWUzQsUvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjblRWvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjblRWvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A8D1F000FF;
	Tue, 15 Sep 2026 06:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789455027;
	bh=Bno+muexawn5410L+DV7DKJUnVEnSG3Xm9KK12kLRxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WjblRWvDYlcJXt3qIn+pe71/ego4Z2vlFV0XESRLNHCg3InTPAXOQmfYiyMz/psez
	 +9IivDtoe2wE8g7LhfMjrbaWj2OD+XFzTG+MQH2eZoMr6Tlh8Mg/06bvQRlnU3mrm+
	 O7yIB9e/mil33XjvQvNbu2i4IblFpAZ1ziiiUYRHBT1fognpknhTDVA/YBuIMGKI1b
	 p7X7u3xDk4liNKdji2+zZobESY9/69EbMzgNusQFdAz+ujQevBOvuaZolV8vtgDT6w
	 KFPr9+qYjVvRvvkQWMrcDwrXXTSbK+bsSYGaNGlzuWs9JcDfDYwj5WRHEPZUK9xrDB
	 IVeQHgUN4z4eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] perf dwarf-aux: Add die_has_flex_array() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260915064035.1970175-2-namhyung@kernel.org>
References: <20260915064035.1970175-1-namhyung@kernel.org>
 <20260915064035.1970175-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 06:50:26 +0000
Message-Id: <20260915065027.29A8D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf dwarf-aux: incorrect offset comparison masks flex arrays af=
ter empty structs
- [Medium] perf dwarf-aux: missing DW_AT_data_bit_offset support causes mem=
ber offset collapse
- [Medium] perf dwarf-aux: top-level type resolution drops const/volatile m=
odifiers
--

commit 93f74aec3d433215197c18f94befb7b584381fa4
Author: Namhyung Kim <namhyung@kernel.org>

perf dwarf-aux: Add die_has_flex_array() helper

This commit adds the die_has_flex_array() helper to identify if a given
DWARF type is a compound type containing a flexible array at the end. It
also introduces a depth parameter to the internal recursive function to
prevent infinite recursion.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index d7160f87ac7d7..a5aefe7d1d62d 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c

[ ... ]

> +		if (tag =3D=3D DW_TAG_structure_type) {
> +			if (die_get_data_member_location(&die_mem, &loc) < 0)
> +				loc =3D 0;

[Severity: Medium]
Will this fallback to 0 corrupt the tracking of the final member if the
struct contains members using DWARF 5 DW_AT_data_bit_offset?

When die_get_data_member_location() returns < 0 for bit-offset attributes,
setting loc =3D 0 silently overrides the actual offset. This could cause the
maximum-offset calculation to fail.

> +
> +			if (!found || last_loc < loc) {
> +				memcpy(&last_mb, &die_mem, sizeof(last_mb));
> +				last_loc =3D loc;
> +			}

[Severity: Medium]
Does this strict inequality prevent the tracking variable from updating to
the true final member if multiple members share the same maximum offset?

If a struct ends with an empty struct followed by a flexible array, both
members will have the exact same byte offset. Using a strict less-than
comparison means the tracking variable won't update to the flexible array.
This could lead to false negatives when analyzing binaries built with GNU C
empty struct extensions.

> +		}
> +
> +		found =3D true;
> +	} while (dwarf_siblingof(&die_mem, &die_mem) =3D=3D 0);

[ ... ]

> +bool die_has_flex_array(Dwarf_Die *type_die)
> +{
> +	Dwarf_Die real_type;
> +
> +	if (dwarf_tag(type_die) =3D=3D DW_TAG_typedef) {
> +		if (die_get_real_type(type_die, &real_type) =3D=3D NULL)
> +			return false;
> +
> +		type_die =3D &real_type;
> +	}
> +
> +	return die_has_flex_array_recurse(type_die, 0);
> +}

[Severity: Medium]
Does this type stripping logic ignore standard qualifiers like const or
volatile?

By explicitly limiting type resolution to DW_TAG_typedef, variables
declared as const struct foo or volatile struct foo will pass a
DW_TAG_const_type or DW_TAG_volatile_type directly to
die_has_flex_array_recurse(). The recursive function will then reject it
because its tag is not a struct or union, causing flexible arrays in
qualified types to be silently ignored.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915064035.1970=
175-1-namhyung@kernel.org?part=3D1
