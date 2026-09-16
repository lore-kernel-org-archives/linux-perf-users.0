Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14519BC8
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789540369; cv=none; b=PmPLHER/mP18T1CdDuuImXRMziNNSrIpjDMjioOSynEkMKMDjo6ap2Xpe5imA/m8h4bEQZPdj9PCz+dftNo9ipbOCAwKGgvcFPfP1GADGLEAXfv3lMxH4TBvd027TbH9QVxb1UEdIbc+CV0jB+NgQslGvuNcxKA0O9jafWM2CqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789540369; c=relaxed/simple;
	bh=pqLrQqJm9Q/Ib2Uc04mjlnwZpVR6bMozjQIkogXkvtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QPjtTEUur5yygsJbLc7oC1kklhDYqhImQ+GawME4mKlfqHhdfDS0d2FVrfEAewfblXYCf4ZCf30WoKaoIbbFzVklzcqrs/GG/9+l/daLV5SrT0uwsy4aenstETytAkADDQQDKZYlQrfq8wu/yxHtgRWLoThu1txSskPRqqO+7aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvCBWSxa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvCBWSxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314371F00899;
	Wed, 16 Sep 2026 06:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789540367;
	bh=YQmRzb3sGD/kF50lBCnrvMJcmrKz5HYfdjkVYt28FRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cvCBWSxaCLTpEvbA9/8aSs8WlKbRmSgWhwpX0meYaQ3SwiZtQR700TP24rKAspazM
	 W6ZQ2siZYW+vsIHNLH9MQgwhY/lbYbuML4AMxyMN5yf9iB26ikUll6zi0GTVYXR2mI
	 GEHByh/r10CVdMGYqlNUHKfZdMMMFAayc1/eUhs/5atxub9LJxDpPdI97QxtVHqS4I
	 sOjjg/ldl1sl0OVvkWB1ddlnvtq6MQ/wq7Luk9VA/uNejuXjUIzBq8nlkn30oRF17F
	 d33yA/FFHDib4Q5VNsu5mFPFxB8qPI1KRTKcH+BssYHMMkBNh2APmbdc1B3SqW2a8z
	 2YgtZx0fpF7Ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] perf annotate-data: Adjust type offset for
 flex-array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916061926.2224222-4-namhyung@kernel.org>
References: <20260916061926.2224222-1-namhyung@kernel.org>
 <20260916061926.2224222-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:32:46 +0000
Message-Id: <20260916063247.314371F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf: annotate-data: incorrect offset bounds check misses struct=
 padding
- [Medium] perf: annotate-data: incorrect union flexible array resolution u=
sing list_last_entry
- [Medium] perf: annotate-data: indiscriminate has_flex_array propagation m=
isattributes padding
--

commit feff704b9862ca9e496a807f9009e99fda07cdc6
Author: Namhyung Kim <namhyung@kernel.org>

perf annotate-data: Adjust type offset for flex-array

This patch adjusts the type offset for flex-array members in perf's data
annotation. It ensures that accesses beyond the original type size are mapp=
ed
to the correct elements using modulo operations. It also ensures field names
for flex arrays are correctly found.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 1ee2b74f99205..d4410d720e126 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c

[ ... ]

> @@ -333,19 +338,40 @@ static void delete_members(struct annotated_member =
*member)
>  }
> =20
>  static int fill_member_name(char *buf, size_t sz, struct annotated_membe=
r *m,
> -			    int offset, bool first)
> +			    int offset, bool first, bool has_flex_array)
>  {
>  	struct annotated_member *child;
> +	bool found =3D false;
> +	int len;
> =20
>  	if (list_empty(&m->children))
>  		return 0;
> =20
>  	list_for_each_entry(child, &m->children, node) {
> -		int len;
> -
>  		if (offset < child->offset || offset >=3D child->offset + child->size)
>  			continue;
> =20
> +		found =3D true;
> +		break;
> +	}
> +
> +	if (!found && has_flex_array) {
> +		/*
> +		 * It may have an intermediate struct that has another struct that
> +		 * contains a flex array.  In that case, the outer struct itself is
> +		 * has no array and the size is less than the offset so the above
> +		 * logic won't find the outer struct at the offset.  Let's use the
> +		 * last struct if it couldn't find a member for the flex array.
> +		 */
> +		child =3D list_last_entry(&m->children, struct annotated_member, node);
> +
> +		if (offset < child->offset)
> +			return 0;

[Severity: Medium]
Does blindly selecting the last child work for unions where the flexible ar=
ray
is not the last member in DWARF order?

It appears list_last_entry() will pick the last DWARF entry, which could
break flexible array annotation for unions if the compiler places the flexi=
ble
array member before other elements.

> +
> +		found =3D true;
> +	}
> +
> +	if (found) {
>  		/* It can have anonymous struct/union members */
>  		if (child->var_name) {
>  			len =3D scnprintf(buf, sz, "%s%s",
> @@ -355,15 +381,37 @@ static int fill_member_name(char *buf, size_t sz, s=
truct annotated_member *m,
>  			len =3D 0;
>  		}
> =20
> -		return fill_member_name(buf + len, sz - len, child, offset, first) + l=
en;
> +		return fill_member_name(buf + len, sz - len, child, offset, first,
> +					has_flex_array) + len;

[Severity: Medium]
Does propagating has_flex_array unconditionally into all recursive calls ca=
use
out-of-bounds logic to activate for unrelated sub-structs?

If an offset lands in the trailing padding of an intermediate sub-struct, it
seems the fallback logic might incorrectly attribute it to the last member =
of
that sub-struct instead of resolving as no member.

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
> +		return child;

[Severity: Medium]
Similar to fill_member_name(), can this fail for unions where the flexible =
array
is not the last member in DWARF order?

> +
> +	return find_flex_array(child);
> +}
> +
> +static struct annotated_member *get_flex_array_member(struct annotated_d=
ata_type *adt)
> +{
> +	return find_flex_array(&adt->self);
>  }

[ ... ]

> @@ -1740,6 +1788,7 @@ struct annotated_data_type *find_data_type(struct d=
ata_loc_info *dloc)
>  {
>  	struct dso *dso =3D map__dso(dloc->ms->map);
>  	Dwarf_Die type_die;
> +	struct annotated_data_type *result;
> =20
>  	/*
>  	 * The type offset is the same as instruction offset by default.
> @@ -1752,7 +1801,25 @@ struct annotated_data_type *find_data_type(struct =
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
Does this condition correctly handle flexible arrays if the elements start
within the struct's trailing padding or exactly at the struct's size bounda=
ry?

If dloc->type_offset is less than or equal to result->self.size, but lands =
in
the padding, it seems the modulo-adjustment will be skipped. This could cau=
se
the fallback logic to incorrectly recurse into the last field of the element
type, which might yield wrong struct field names in the output.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061926.2224=
222-1-namhyung@kernel.org?part=3D3
