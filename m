Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B51D6BB
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776045583; cv=none; b=AeEH2n+egZxTXyqi/8aHml7j4d/+4cKNgshCJMjpiCSFRyRtxr/hxS1kMyxDJ8b7hkpqX+R2BDbPl+PPRIv1bWigQI02S1H2gIi9EYx6FFD/XgCBa6fl+/YBP8nKA+MpRPTF0R4BtPZMUdRLGU/9xopJKaGoOYbRmh8kAPXNlNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776045583; c=relaxed/simple;
	bh=s/UxVVySFu355q3cvalL31XS0k0qRxNuKJYjqSeDOUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O3HZL3QX2XAJi1Ul4TMvEnfPNTd5W+xfJd/swtUy8qbAodSF0O3WTR09YCVlef/vkQa2MEDRF+yqKpgkBtYzHytVUJ5xqYozAmQ74bSSwh1Ou57Hwi9hCo2ozWDDx4KG3BFytZj+oPqrUvY3na2/GPSafWwfg+lLhwbcx/+0JdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7JSGuDL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7JSGuDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EEDC19424;
	Mon, 13 Apr 2026 01:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776045583;
	bh=s/UxVVySFu355q3cvalL31XS0k0qRxNuKJYjqSeDOUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=n7JSGuDLEbN+tgshMRMmWR+DN1x0PiG1BXZJP1JyyTB3V5R6sgDOtP7lfZFnJpsvu
	 Mvwy/wlHu9mO+HzpXpTfLQGVZIBDS4XK2hQCRjbW/BmWBAhjdlg41UqOwfV4bKrzMJ
	 DlvJTqF/EUWwVcdc4bvweDppG32EX26adwEsga/VG4ee2cdITTjXV1CbZ1xNO9z+Ur
	 E9/P4YcGsOXhRKCSdgHjM/yCU+of5btUkwsOwIqdpuxWyhCx4ls4TDAqqKxfY6jlsc
	 bZt7VVjnCDv8roVxUA5VZFMkxqyGYK1o4duD7auFPa+LAyosuZo+AUm8i1v/4UYbck
	 0803fBOou/93w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 31/33] perf evsel: Add bounds checking to trace
 point raw data accessors
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413012227.1089445-32-irogers@google.com>
References: <20260413012227.1089445-32-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 01:59:42 +0000
Message-Id: <20260413015943.47EEDC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Missing NULL return value handling causes segmentation faults
- [Medium] Missing byte-swapping for dynamic fields breaks cross-endian tra=
ce parsing
- [Medium] Unbounded `pr_warning` causes console flood for malformed samples
--

commit 9a07ac57ca12438c4a66f8f98edc03007b239edb
Author: Ian Rogers <irogers@google.com>

perf evsel: Add bounds checking to trace point raw data accessors

This commit introduces bounds checking for tracepoint fields to prevent out
of bounds memory accesses. It adds the out_of_bounds() helper and validates
field offsets and sizes in perf_sample__rawptr() and format_field__intval().

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index bb48568b8101a..a23bd28579b55 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3700,22 +3700,59 @@ struct tep_format_field *evsel__common_field(stru=
ct evsel *evsel, const char *na
>  	return tp_format ? tep_find_common_field(tp_format, name) : NULL;
>  }
> =20
> +static bool out_of_bounds(const struct tep_format_field *field, int offs=
et, int size, u32 raw_size)
> +{
> +	if (offset < 0) {
> +		pr_warning("Negative trace point field offset %d in %s\n",
> +			   offset, field->name);
> +		return true;
> +	}
> +	if (size < 0) {
> +		pr_warning("Negative trace point field size %d in %s\n",
> +			   size, field->name);
> +		return true;
> +	}
> +	if ((u32)offset + (u32)size > raw_size) {
> +		pr_warning("Out of bound tracepoint field (%s) offset %d size %d in %u=
\n",
> +			   field->name, offset, size, raw_size);
> +		return true;
> +	}
> +	return false;
> +}

These checks happen in the hot path of event processing. If a trace contains
millions of malformed samples, will these unbounded pr_warning() calls flood
the user's console?

Would it be safer to use pr_warning_once() or a rate-limited equivalent to
prevent severe performance degradation?

>  void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
>  {
>  	struct tep_format_field *field =3D evsel__field(sample->evsel, name);
> -	int offset;
> +	int offset, size;
> =20
>  	if (!field)
>  		return NULL;
> =20
>  	offset =3D field->offset;
> -
> +	size =3D field->size;
>  	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> -		offset =3D *(int *)(sample->raw_data + field->offset);
> -		offset &=3D 0xffff;
> -		if (tep_field_is_relative(field->flags))
> +		int dynamic_data;
> +
> +		if (out_of_bounds(field, offset, 4, sample->raw_size))
> +			return NULL;

When out_of_bounds() fails, this returns NULL. Callers of
perf_sample__strval(), which wraps perf_sample__rawptr(), expect a valid
string pointer if the field exists.

For example, in tools/perf/builtin-lock.c, functions like
report_lock_acquire_event() pass this return value directly to
lock_stat_findnew(), which then calls strdup().

Could returning NULL here turn a malformed sample into a segmentation fault?

> +
> +		dynamic_data =3D *(int *)(sample->raw_data + field->offset);
> +		offset =3D dynamic_data & 0xffff;
> +		size =3D (dynamic_data >> 16) & 0xffff;

The sample->raw_data buffer is in the target architecture's byte order. If
the trace was recorded on a machine with a different endianness, does
dynamic_data need to be byte-swapped before extracting the offset and size?

Without swapping, could valid cross-endian traces extract scrambled values
and fail the new bounds check, potentially leading to the NULL return
mentioned above?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413012227.1089=
445-1-irogers@google.com?part=3D31
