Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC3315D5D
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789800409; cv=none; b=kzvXNnTB33xpC2AzGGnwJUhiDD8FKc96H1L2ZlPSwJMtYG6F63V1gOiOOBq6fzQgsMDgmSdJ5DaUJ3GIFxZUhRcRS81x9DNZr77fFPHwY9OwZQwHc9avJIL260UORcJ2F0g8jm79n1Dr23Yu0LHkLzH2uga/yYwu4E2AOxIoNHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789800409; c=relaxed/simple;
	bh=x9WlfOK/kCYKJIPEMuC/4AgoTcY7mWaMUNBkNDe0QdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZgvRhlE9DtWRR36bZmDPcGr0jN0sYWv/G4wu/mS5DxnipJ1Ah7pG+Klym3Gok3CZPVDPubCEbmjWG8mvSvxZ9dhotKv5F8xfBaqT3C0A5w/rwcPtYsqeJlFI1VtfTF4DqZ7hPa5ZlCtiMiRnMWzQ0p59AmOhB+P2N3WtoNRes2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZUof53w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZUof53w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05051F000FF;
	Sat, 19 Sep 2026 06:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789800408;
	bh=12oCuFUTEuV5BeE/1Jj6PXutQZg5QIEl0CyFzZtqj5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZUof53wp1LYnJSPdZvrVsRR6z5Ln1VLowUm/5/V0Pg06VbVAVImM/PJqMfF9V0Y/
	 kkCHpJh/iAiQ+fsrGn9CQabtNrSNrAfd8G/Bay06lwr4+lm23wep/PkHKbh1xx79vv
	 7hmTxEMCDM62OcsIaR7TxowU4vsFw//8godoD5JndLCApcNY0KIcBUhD9L6BL5OnsI
	 vI4MkvenNkquGduKYtUfJarlwQeyMP26Y7vJNxekm/3yWoWN38UnK8Yor7/xXsUPqX
	 ytvgFIYucEI64KFSb+6dLlsHbGWFXRe7jZNXDvnP8uIkNLnbm2TwUFdlWy0/VErlKN
	 7fsfPME1Mkbuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] perf annotate-data: Adjust type offset for
 flex-array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919063745.48444-5-namhyung@kernel.org>
References: <20260919063745.48444-1-namhyung@kernel.org>
 <20260919063745.48444-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 06:46:47 +0000
Message-Id: <20260919064647.C05051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf annotate-data: incorrect flex array adjustment skips elemen=
ts in struct padding
--

commit b87f5c6310512e6a55305050539cf57984efb087
Author: Namhyung Kim <namhyung@kernel.org>

perf annotate-data: Adjust type offset for flex-array

The flex array members are located beyond the original type size.  Also
it needs to adjust the offset in an array to find a corresponding
element using module operation.  Note that we focus on access to type and
field, so array index is not important.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 5dd6c6ec2d424..e9b58a3d587be 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c

[ ... ]

> @@ -1741,6 +1816,7 @@ struct annotated_data_type *find_data_type(struct d=
ata_loc_info *dloc)
>  {
>  	struct dso *dso =3D map__dso(dloc->ms->map);
>  	Dwarf_Die type_die;
> +	struct annotated_data_type *result;
> =20
>  	/*
>  	 * The type offset is the same as instruction offset by default.
> @@ -1753,7 +1829,25 @@ struct annotated_data_type *find_data_type(struct =
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
Since result->self.size (derived from DWARF's DW_AT_byte_size) includes
trailing padding for alignment, won't this check skip flex array elements
that fall within the struct's padded size boundary?

For example, if a struct has an 8-byte aligned member and a trailing flex
array of 2-byte structs, the struct size includes up to 6 bytes of trailing
padding. Accesses to indices 1 through 3 would remain `<=3D result->self.si=
ze`
and erroneously skip this modulo adjustment.

Does this cause fill_member_name() to fail matching the unadjusted offset
against the first element's nested fields, truncating the resolved name to
just the outer array name instead of the specific inner field?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919063745.4844=
4-1-namhyung@kernel.org?part=3D4
