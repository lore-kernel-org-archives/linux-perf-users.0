Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C09315D33
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778814990; cv=none; b=cdvSI/40+xiCBzwxZhgFDsrpSbNnk3MthZmgywv38zl2gIPZLC/liEbPchWi2Lv47UEAKfIUpfTrFryoJ9ecYo+EU82oFfzDkPab38hF2ktDAsBLV8GDO+6zmxjY2c0NGhPIDn620GW9xCM3c7er0VdTcrn1SG2so6TvMzeOd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778814990; c=relaxed/simple;
	bh=K5tzKAtbWqo2u2Nux/Cw/udPXQNYskrM3ZengasdXDk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ewSKWlFGy6YCU4AaJe4rykIFm8yb1Exxd47xA9E2yvKUcem0EikVxXKtYoM+3HInHbWtj+sxc3LIzqzaftEQowpMnqH02/kRProIuqNafyalFwI+9hxLfa0L4YlLYnKwdWBBt+ePaxNwe9C/Hv65LpAWxCZX7LVZys3phKx5yqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeV5cLJF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeV5cLJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52A2C2BCB0;
	Fri, 15 May 2026 03:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778814989;
	bh=K5tzKAtbWqo2u2Nux/Cw/udPXQNYskrM3ZengasdXDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JeV5cLJFnzTaSCG4edadckA0H26eZN2WNyzUr0tqRognUth7IqSyLptcdV003p24S
	 TidV+X42GbkF3kkDaF/JKMV/ev98bZCQiz4+ZKe8kkNSObpLIdVB5fAK0qRB7XkFmY
	 sFBQJkWgxSRc0ADo/BF2HX/V4QyFLRRf+7IwvoJSzk3jgkTaDNLtU9WK50pogBWclO
	 Ete8PjF/EKHpDC+NlHbpQnbL8PfJwr8KqfD/LMdTdyqatY7NItWq7ZJXcH3Vf6Gczh
	 6SV6czqf3VeJpRi+48vrG7Q2pmlEHA3pfod5rr8svLEe4Nl1gL4aGhaeTp7+Zz1q/y
	 sGNVz8tbft5Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 30/32] perf evsel: Add bounds checking to trace
 point raw data accessors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512223001.2952848-31-irogers@google.com>
References: <20260512223001.2952848-31-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 03:16:29 +0000
Message-Id: <20260515031629.A52A2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Calling `pr_warning()` on every out-of-bounds sample will flood =
the console and stall the tool.
- [Medium] The bounds check for dynamic tracepoint strings fails to verify =
null-termination, leading to out-of-bounds reads when the returned pointer =
is processed by string callers.
--

commit 4bd938d028177725d0b4b93aadebb744c23559c1
Author: Ian Rogers <irogers@google.com>

perf evsel: Add bounds checking to trace point raw data accessors

This commit adds bounds checking for tracepoint field accesses to avoid
reading past the end of the trace record. It also fixes the handling of
dynamic fields by correctly computing the size and byte-swapping data when
endianness varies.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3700,22 +3700,63 @@ struct tep_format_field *evsel__common_field(stru=
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

Could this regression cause console flooding and stall the tool?

If a perf.data file contains many corrupted or malformed trace records,
out_of_bounds() will trigger a warning for every invalid sample. Since this
is not rate-limited, processing millions of records might flood the user's
terminal and effectively hang the perf command.

Could we use pr_warning_once() or a rate-limited alternative instead?

>  void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
>  {
>  	struct tep_format_field *field =3D evsel__field(sample->evsel, name);
[ ... ]
>  	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
[ ... ]
> +		if (tep_field_is_relative(field->flags)) {
> +			/*
> +			 * Newer kernel feature: Relative offsets (__rel_loc).
> +			 * If the relative flag is set, the parsed offset is not
> +			 * absolute from the start of the record. Instead, it is
> +			 * relative to the *end* of the dynamic field descriptor
> +			 * itself.
> +			 */
>  			offset +=3D field->offset + field->size;
> +		}
>  	}
> +	if (out_of_bounds(field, offset, size, sample->raw_size))
> +		return NULL;
> =20
>  	return sample->raw_data + offset;
>  }

Could this regression cause an out-of-bounds read for callers that treat the
returned raw data as a null-terminated string?

When the raw pointer is accessed via perf_sample__strval(), callers often p=
ass
it directly to string functions like strdup(). For example:

builtin-kwork.c:work_push_inst() {
    ...
    work->name =3D strdup(perf_sample__strval(sample, "prev_comm"));
    ...
}

If a malformed record has a dynamic string whose declared length fits within
raw_size but lacks a null byte, the out_of_bounds() check will pass. The
caller's string operations would then read out-of-bounds until a null byte =
is
found in adjacent memory.

Should there be an explicit check ensuring the bounded data contains a
null terminator when the field is treated as a string?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512223001.2952=
848-1-irogers@google.com?part=3D30
