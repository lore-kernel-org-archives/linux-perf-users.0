Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414039EF35
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369267; cv=none; b=ONOzhFhdoN90Hdw6QydE2rMEW8F96b3YdJb+FVrWKXetmBdXV8Q0sm6niNc2P8qfXomgdJ0N88aXasY+Ng6O6+4QIsQDkRE0Ow8Un4rPU3yJl8Qb6urZsTz1bMTFmWYuUBLNq0/LXUQgKnHtDH0HT65agDA9igX0eCH5Iv84+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369267; c=relaxed/simple;
	bh=Afnz6K0vBWab2dGpoY1R1pcaWjJEEQo1cIQ2DQVsiF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u2oy2rQIa03kVFxW8sBr7Q/2iAb6Wy9m876mjfw/Z/+y3os8E4o9ORcT6h6GDyB5pOxFo9csySWKxeTnyXZOgMX5P0PX4aq7GogUCIW06ARpEy0Ua9BEe7cDEoSnCLLrPfGG9kiZxvF0Sf3yLv1Y6jQuvSg0x87Kdjlq0gXAsrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzQG7Shz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzQG7Shz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209DC1F0089A;
	Mon, 14 Sep 2026 07:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789369265;
	bh=JjNXpMa9nIHVwjQ3CB3pzBXh/7FyFVZXm6NvzBLIoT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BzQG7ShzrLWwNPhT+T7Hdkspy8ppZTb73tOQxIdAuGonEVfuyiNTsPg6zNNAqfaSi
	 N5AzbK8JoyXQgOt/ZoQtQR1WSQ44lD9E//BwdQRn5qeb/8657Eer1vVCRPjIQIDkJO
	 dY06HN9o3snRSBJsADMo+VUK9J63cmkDabWs2njMv6+IybC7iMzKpcaULBXnZaNRQ9
	 2sxpJjLksDNwyyj8qUt5OxVdsa6Kpr0xmetari3gCQ+MxAPrA+la6PMQhkVk/2wAtV
	 WwuEhw5EoXzxARmV2bcy/5BpfHn6scs+z7feUBnDkuzwUiWQfvCQKGiwNOJPm6v+9S
	 9X0E2hyeLQndQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf annotate-data: Adjust type offset for
 flex-array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914064535.1671939-5-namhyung@kernel.org>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 07:01:04 +0000
Message-Id: <20260914070105.209DC1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Off-by-one error and tail padding overlap in flex-array offset a=
djustment causes accesses to be silently dropped and incorrectly attributed.
- [Medium] Calling `strstr()` on `child->type_name` without checking for NU=
LL causes a segmentation fault if memory allocation failed during type name=
 extraction.
- [Medium] The newly added `strstr(child->type_name, "[]")` call reads unin=
itialized heap memory, leading to out-of-bounds reads and potential crashes=
 when analyzing malformed or unknown DWARF entries.
--

commit 546415e2740f53443f133b3600542636f3d84f31
Author: Namhyung Kim <namhyung@kernel.org>
perf annotate-data: Adjust type offset for flex-array

This commit adjusts the type offset for flexible array members that are loc=
ated
beyond the original type size. It ensures a field name is found for flex ar=
rays
by adjusting the offset in an array to find a corresponding element.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index e8aff6a916c0a..a66b72feb6e2f 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c

[ ... ]

> @@ -355,15 +376,37 @@ static int fill_member_name(char *buf, size_t sz, s=
truct annotated_member *m,
>  			len =3D 0;
>  		}
> =20
> -		return fill_member_name(buf + len, sz - len, child, offset, first) + l=
en;
> +		return fill_member_name(buf + len, sz - len, child, offset, first,
> +					has_flex_array) + len;
>  	}
> +
>  	return 0;
>  }
> =20
>  int annotated_data_type__get_member_name(struct annotated_data_type *adt,
>  					 char *buf, size_t sz, int member_offset)
>  {
> -	return fill_member_name(buf, sz, &adt->self, member_offset, /*first=3D*=
/true);
> +	return fill_member_name(buf, sz, &adt->self, member_offset, /*first=3D*=
/true,
> +				adt->flex_array);
> +}
> +
> +static struct annotated_member *find_flex_array(struct annotated_member =
*m)
> +{
> +	struct annotated_member *child;
> +
> +	if (list_empty(&m->children))
> +		return NULL;
> +
> +	child =3D list_last_entry(&m->children, struct annotated_member, node);
> +	if (strstr(child->type_name, "[]"))

[Severity: Medium]
Could this call to strstr() safely handle scenarios where child->type_name =
is
NULL or uninitialized?

During DWARF parsing, for instance in __add_member_cb(), if die_get_typenam=
e()
fails due to a malformed DWARF entry or memory exhaustion, strbuf_detach()
might return an uninitialized heap buffer or NULL. If that happens, does th=
is
scan risk triggering a segmentation fault or an out-of-bounds read when loo=
king
for the "[]" string?

> +		return child;
> +
> +	return find_flex_array(child);
> +}

[ ... ]

> @@ -1740,6 +1783,7 @@ struct annotated_data_type *find_data_type(struct d=
ata_loc_info *dloc)
>  {
>  	struct dso *dso =3D map__dso(dloc->ms->map);
>  	Dwarf_Die type_die;
> +	struct annotated_data_type *result;
> =20
>  	/*
>  	 * The type offset is the same as instruction offset by default.
> @@ -1752,7 +1796,25 @@ struct annotated_data_type *find_data_type(struct =
data_loc_info *dloc)
>  	if (find_data_type_die(dloc, &type_die) < 0)
>  		return NULL;
> =20
> -	return dso__findnew_data_type(dso, &type_die);
> +	result =3D dso__findnew_data_type(dso, &type_die);
> +	if (result =3D=3D NULL)
> +		return NULL;
> +
> +	if (result->flex_array && dloc->type_offset > result->self.size) {

[Severity: Medium]
Will this boundary check correctly catch accesses that fall exactly on the
boundary or within the struct's tail padding?

If an event samples a flexible array element whose offset is greater than=20
flex_array->offset but less than or equal to result->self.size (the total
padded size of the struct), it appears this condition evaluates to false.
Could this cause the offset adjustment to be skipped, causing valid sample
counts to be silently dropped during data presentation?

> +		struct annotated_member *flex_array =3D get_flex_array_member(result);
> +
> +		if (flex_array && flex_array->size > 0) {
> +			int offset =3D dloc->type_offset;
> +
> +			/* adjust offset in the flex array */
> +			offset -=3D flex_array->offset;
> +			offset %=3D flex_array->size;
> +			offset +=3D flex_array->offset;
> +
> +			dloc->type_offset =3D offset;
> +		}
> +	}
> +	return result;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914064535.1671=
939-1-namhyung@kernel.org?part=3D4
