Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4A43B3C9
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455195; cv=none; b=QljaBSqTAIirGAeFOMdcGj+y6wkoWw+k2aqMIAxJbltiv5OSiLsa45l8CmeOgJjfQq19QADbS4kiqYJfBVWYh1eQhqyXjOphzsTdMqh5JehTwCko2kgOX/B64e7ykPSt++7PWAT+bOxeqaAIkdbuADBO+HziIEEh7hOYEnAwlVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455195; c=relaxed/simple;
	bh=YJOyqdzXavt/cIRXowy5DLklVxZyr0k6Vr+0v2+ez8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A+xFDGVRT6lyMLytcE2NuFgLNNUQ7v5nrW2UKlT71gzv64gZ85+7wkw1QxWHq2GUHomzwVluF7whCMzYyRfiS5G4kPDwOAPMbe7ZcQN9TFqOk3LAPiJ67LQ7lH443pTPBX2IetqUC0mGg4+F4MTSBKYaww51mmBat1UwPJPCaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlZ+5mHq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlZ+5mHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA271F000FF;
	Tue, 15 Sep 2026 06:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789455194;
	bh=eby9xK0utAXazD/Aw+ZgT2pfZnj42UDYDqYmrUtPlcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YlZ+5mHqp2ZVKgWSvothI7c2KX3xEHGAWJFAPCpwTZVXGpfOoDcZP5zx1kqWJqtii
	 ZSc2+Yllro1OsFsqUHPzjkK9NM3/oWD/G1vFRNSU03LLu3GWk29pMDut3pQyi/U6VC
	 qEz2q9DyNtqduf3XpBM1+ySBaM29kRCmqiqu/UbDcXvsGgCAIYB8Ed63TBHGdPxrYp
	 RfxfMumU+Fj3+IG0DbdQdM3mdSgy62KbwGgLpqOhSmdLb2AfJDQLaNKINfXfCB/j6e
	 gbrx1BKtWi83/ePqmlTkoVaGoFwpP6B1zXwgmTV3g+G0H7apKm4BPlGttHZk8N23nu
	 RJyTPS2rjNYDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] perf annotate-data: Adjust type offset for
 flex-array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260915064035.1970175-4-namhyung@kernel.org>
References: <20260915064035.1970175-1-namhyung@kernel.org>
 <20260915064035.1970175-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 06:53:13 +0000
Message-Id: <20260915065313.ECA271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf: flex-array offset adjustment skips elements in tail padding
- [Medium] perf: zero-length flex-arrays bypass element size extraction
- [Medium] perf: null pointer dereference in find_flex_array() on alloc fai=
lure
--

commit f8d5c159e83503d5c3d85f5f3c22dec6b4f25c06
Author: Namhyung Kim <namhyung@kernel.org>

perf annotate-data: Adjust type offset for flex-array

This commit adjusts the type offset for flexible array members in perf's
data annotation. It ensures that the offset is properly adjusted to find
the corresponding element using modulo operations and updates the member
name resolution to correctly identify flex arrays.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 1ee2b74f99205..1c19b807c4f21 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -241,7 +241,8 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  		return DIE_FIND_CB_END;
> =20
>  	strbuf_init(&sb, 32);
> -	die_get_typename(die, &sb);
> +	if (die_get_typename(die, &sb) < 0)
> +		strbuf_add(&sb, "(unknown type)", 14);
> =20
>  	__die_get_real_type(die, &member_type);
>  	if (dwarf_tag(&member_type) =3D=3D DW_TAG_typedef)

[Severity: Medium]
Does this code safely handle zero-length flexible arrays during element size
extraction?

Just below this change in __add_member_cb(), the logic assumes failures
for flexible arrays:

	if (dwarf_aggregate_size(&die_mem, &size) < 0) {
		if (dwarf_tag(&die_mem) =3D=3D DW_TAG_array_type) {
			die_get_real_type(&die_mem, &die_mem);
			...

Since dwarf_aggregate_size() returns 0 for zero-length arrays, the < 0
condition is skipped. This disables offset adjustment for all GNU zero-leng=
th
arrays (e.g., [0]), which results in incorrect field annotations.

[ ... ]
> @@ -355,15 +377,37 @@ static int fill_member_name(char *buf, size_t sz, s=
truct annotated_member *m,
[ ... ]
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
Could child->type_name be NULL here?

If strbuf_init() or strbuf_add() fails due to memory pressure during type
string construction, strbuf_detach() returns NULL. Passing an unchecked NULL
pointer to strstr() in find_flex_array() could cause a segmentation fault in
the perf tool.

> +		return child;
> +
> +	return find_flex_array(child);
> +}
[ ... ]
> @@ -1740,6 +1784,7 @@ struct annotated_data_type *find_data_type(struct d=
ata_loc_info *dloc)
[ ... ]
> -	return dso__findnew_data_type(dso, &type_die);
> +	result =3D dso__findnew_data_type(dso, &type_die);
> +	if (result =3D=3D NULL)
> +		return NULL;
> +
> +	if (result->flex_array && dloc->type_offset > result->self.size) {

[Severity: Medium]
Does this condition skip elements located in the tail padding of the struct?

By checking that dloc->type_offset > result->self.size, the offset adjustme=
nt
is skipped if the flexible array element being accessed has an offset less
than or equal to the total padded size of the parent struct.=20

The unadjusted offset fails to match children in fill_member_name(),
erroneously falling back to the last member during offline perf data analys=
is.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915064035.1970=
175-1-namhyung@kernel.org?part=3D3
