Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5AE433BA8
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620084; cv=none; b=FGsiGh9XVZ7Woa5iCjlcfiTDPnWVHwceqRI/Gvjqof/kPnLXBqo+1JvJ0IpmluPj+irR2x60JFqTdLMcOXtIaMu45cQIa5LRJ18sKmBNFLrBjau/TyM4x6WKs2nztU3gAj/YszpDkf986ikXQr1pi1q/uWiZy7TuQtYmc3op0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620084; c=relaxed/simple;
	bh=TWzjWaW2E5Hh//HO4MNGbImJtM3j6+UNX5a4k7ui3KE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i1rXnZMuWfuEQbVhcjVoEzHsSBG6JI3aLsopseUCQpdsy3F1ARN0eJWKmU125VyRnAuHGUd/f6wN/TKu5QjHrGM2ybwevwqXKcPC3ml8OzXLJL3tp+dtM3COEdt8ihUVGPgb1DqLl5CgAX034QlT1UQCtUHZTIFiZ5MqeBqM/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh5UvcnD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh5UvcnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467B11F000E9;
	Tue, 21 Jul 2026 07:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620079;
	bh=hra8NsYBesfHS8FKH3bLrnpB52DNcSQtwLg4f100WPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jh5UvcnDw5swfqKRqh9/phnuY6Whrog2TfOQswBxOwoI/NbyWXsLc8UOi1Hl3gfkf
	 AW6RQX4JupeSrpG54YhbDjYSp00qmYxQDNn4vA4toOY7AGVC/yC18b2yhqRE3P8fE9
	 r23g3JjwFlhSvdz+5tsybInCGmMOfbRr8E5UWV/Tg3bfKMkrOBnn5t+ooryTjTtylF
	 VJbA+raOsXbrGSGjjhASPAMCRhDj35eslHMYpuNDNIFxX+VJURXQ8FZIdb0AT+Eu58
	 mOIBrwjbwU3342A/QrKDU9AyTQ+y6LhFcEzrlUykUNxZUqz8YuyS7uHLxygSRTKjeK
	 VO8AuP1/y86fA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v10 04/10] perf headers: Sync perf_event.h/perf_regs.h
 with the kernel headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721072707.3787848-5-dapeng1.mi@linux.intel.com>
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <20260721072707.3787848-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:47:58 +0000
Message-Id: <20260721074759.467B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] evsel__parse_sample() fails to parse or skip the newly appended SI=
MD payload, corrupting subsequent sample field parsing.
- [Medium] The condition to print the new SIMD attribute fields in `perf_ev=
ent_attr__fprintf()` uses the offset of the last field instead of the first=
 field, hiding valid intermediate fields.
- [Medium] regs_dump_abi() incorrectly reports 'unknown' for all samples wi=
th SIMD registers enabled.
--

--- Patch [4]: [Patch v10 04/10] perf headers: Sync perf_event.h/perf_regs.=
h with the kernel headers ---
commit 8b5325e2c0e1de39cce1b1704639159d2e039a47
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf headers: Sync perf_event.h/perf_regs.h with the kernel headers

This commit syncs UAPI header changes supporting SIMD/eGPRs/SSP sampling
into the corresponding tools UAPI headers. It also updates the print
and swap helpers to support the newly introduced perf_event_attr fields.

> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/l=
inux/perf_event.h
> index fd10aa8d697f2..c49fc76292f79 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
[ ... ]
> @@ -314,8 +314,9 @@ enum {
>   */
>  enum perf_sample_regs_abi {
>  	PERF_SAMPLE_REGS_ABI_NONE		=3D 0,
> -	PERF_SAMPLE_REGS_ABI_32			=3D 1,
> -	PERF_SAMPLE_REGS_ABI_64			=3D 2,
> +	PERF_SAMPLE_REGS_ABI_32			=3D (1 << 0),
> +	PERF_SAMPLE_REGS_ABI_64			=3D (1 << 1),
> +	PERF_SAMPLE_REGS_ABI_SIMD		=3D (1 << 2),
>  };

[Severity: Medium]
By changing the ABI values to bitwise flags, will this break the existing
regs_dump_abi() in tools/perf/util/session.c?

When the PERF_SAMPLE_REGS_ABI_SIMD bit is set, the combined mask is at
least 4. This triggers the fallback in regs_dump_abi():

static inline const char *regs_dump_abi(struct regs_dump *d)
{
	if (d->abi > PERF_SAMPLE_REGS_ABI_64)
		return "unknown";

	return regs_abi[d->abi];
}

Should this logic be updated to handle the new bitmasks so valid SIMD
samples aren't displayed as unknown?

[ ... ]
> @@ -1020,7 +1045,15 @@ enum perf_event_type {
>  	 *      } && PERF_SAMPLE_BRANCH_STACK
>  	 *
>  	 *	{ u64			abi; # enum perf_sample_regs_abi
> -	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
> +	 *	  u64			regs[weight(mask)];
> +	 *	  struct {
> +	 *		u64 nr_vectors;		# 0 ... weight(sample_simd_vec_reg_user)
> +	 *		u64 vector_qwords;	# 0 ... sample_simd_vec_reg_qwords
> +	 *		u64 nr_pred;		# 0 ... weight(sample_simd_pred_reg_user)
> +	 *		u64 pred_qwords;	# 0 ... sample_simd_pred_reg_qwords
> +	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
> +	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +	 *	} && PERF_SAMPLE_REGS_USER

[Severity: High]
Does evsel__parse_sample() need to be updated to parse or skip this
newly appended SIMD payload?

Looking at tools/perf/util/evsel.c:__evsel__parse_sample(), it currently
only advances the array pointer by the basic register mask weight:

		if (regs->abi) {
			u64 mask =3D evsel->core.attr.sample_regs_user;

			sz =3D hweight64(mask) * sizeof(u64);
			OVERFLOW_CHECK(array, sz, max_size);
			regs->mask =3D mask;
			regs->regs =3D (u64 *)array;
			array =3D (void *)array + sz;
		}

If the array pointer isn't advanced past the new SIMD data, will the
parser misinterpret the SIMD payload as subsequent sample fields and
result in parsing errors?

[ ... ]
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/=
perf_event_attr_fprintf.c
> index cc817294ad3d6..2e8be9a357dce 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -407,8 +407,17 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_e=
vent_attr *attr,
>  	}
>  	if (attr_size >=3D offsetof(struct perf_event_attr, config4))
>  		PRINT_ATTRf(config3, p_hex);
> -	if (attr_size > offsetof(struct perf_event_attr, config4))
> +	if (attr_size >=3D offsetof(struct perf_event_attr, sample_simd_regs_en=
abled))
>  		PRINT_ATTRf(config4, p_hex);
> +	if (attr_size > offsetof(struct perf_event_attr, sample_simd_vec_reg_us=
er)) {
> +		PRINT_ATTRf(sample_simd_regs_enabled, p_unsigned);
> +		PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
> +		PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);

[Severity: Medium]
Is this conditional too restrictive for the intermediate SIMD fields?

If the tools encounter an attr_size that encompasses some of the new SIMD
fields (like sample_simd_regs_enabled) but is strictly less than the offset
of sample_simd_vec_reg_user, it evaluates to false. Will this inadvertently
skip printing those intermediate fields even though they are present in the
struct?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721072707.3787=
848-1-dapeng1.mi@linux.intel.com?part=3D4
