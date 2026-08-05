Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ADB137923
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946073; cv=none; b=NCCi2Z+iIdtd9M4+DF1b2kUez16+79xalyhL4Bt1QsUgJ4wcQGAgaCFSDbbuQMLQiM5kgx8Txc47rQljyOFV+YPO98yYU2M8WnWF6MbW0digRKfYlXQIBZBjeQ4Xmdjn983q4aNdno3mEJDoAXnY7MZcSXXkrahMI18S8259K1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946073; c=relaxed/simple;
	bh=TsrotPeu9TPMrgBzQzZkUBN3ra/zsyYi7pj2jNeKVIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M70KcuYt2csmFimo2PHOLVe41qU3d2uBGrAO8witjCZtHr7mKgpUmuFEOHwnaFkzoMDcZtNQxdcH29V0kLIiTjWHys6tSLzvvof9A35DHMWHOLmVq2t/Fv0aMeS8jgQNJKeElMO8yZZcRvTJm/gsdifWXAWpZ6EMo2VKR7Fj31s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVWICB0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVWICB0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BDA1F000E9;
	Wed,  5 Aug 2026 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946068;
	bh=GIi7ceRF8CD16vkoF+dPpr4+M8EaIycbMTLnejohXpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DVWICB0N4DNhMZrxUo4XLyndyAbSt5mYnhr6o1iKNdT8d2SEAwplC7tTYobqa7MZa
	 azGgV5RzJankqQcVIwr+J4hVYTItXvcDNS3DQ/IaWU/wa0WYBAc439bdCgxavNQGUR
	 mf/grrLEg+RHnyxaBS2WGIFvDzeY8JfcYiZEBPuVFDsz/eCpDKOttzwDq5i9gn0PFL
	 C+H0KCvMSpbqy+dU2kJcW+RBiXHDKloU70Mu682HqG/NStqIUxP9b1poMfV1Z4u3Ju
	 DWKlJoV3uv5PugziyUAzMRKvvVeyCXwZa7Stox5Us1T/PVOCqXDG2SBdo4WXS+CRiL
	 aUOGeuBo+Fwcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/11] perf/cxl: Fix the counter overflow delta fixup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805155501.1294472-4-dave.jiang@intel.com>
References: <20260805155501.1294472-1-dave.jiang@intel.com>
 <20260805155501.1294472-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:07:47 +0000
Message-Id: <20260805160748.44BDA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated `counter_width` from the CXL PMU capability register c=
auses undefined behavior in `GENMASK_ULL`.
--

--- Patch [3]: [PATCH v4 03/11] perf/cxl: Fix the counter overflow delta fi=
xup ---
commit 6424601c16fd758ca929ead4bf2082b98255eee8
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Fix the counter overflow delta fixup

This commit fixes the counter overflow delta fixup by conditioning the fixup
on new_cnt >=3D prev_cnt instead of relying on the overflow status alone. It
also uses mask + 1 for the period to avoid undefined behavior with a 64-bit
counter width shift.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

> @@ -697,12 +697,16 @@ static void __cxl_pmu_read(struct perf_event *event=
, bool overflow)
>  	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) !=3D prev=
_cnt);
> =20
>  	/*
> -	 * If we know an overflow occur then take that into account.
> -	 * Note counter is not reset as that would lose events
> +	 * The mask discards the bit that says the counter wrapped, so a delta =
of
> +	 * one whole period reads back as 0 - the same as no events at all. Only
> +	 * the overflow status separates them, and new_cnt >=3D prev_cnt is that
> +	 * case, so add the period back. mask + 1 is 2^counter_width, which com=
es
> +	 * out as 0 for a 64-bit counter and avoids an undefined 1 << 64.
>  	 */
> -	delta =3D (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0=
);
> -	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
> -		delta +=3D (1UL << info->counter_width);
> +	mask =3D GENMASK_ULL(info->counter_width - 1, 0);

[Severity: High]
This isn't a bug introduced by this patch, but could this macro expansion
result in undefined behavior if the hardware provides an invalid counter
width?

The counter_width is extracted directly from a hardware capability register
during initialization:

drivers/perf/cxl_pmu.c:cxl_pmu_parse_caps() {
    ...
    info->counter_width =3D FIELD_GET(CXL_PMU_CAP_COUNTER_WIDTH_MSK, val);
    ...
}

If a faulty or malicious CXL device provides a counter_width of 0 or greater
than 64, the GENMASK_ULL() macro here in __cxl_pmu_read() will evaluate with
a negative or out-of-bounds shift amount. Since GENMASK_ULL(h, l) produces
undefined behavior when h < l or h >=3D 64, this could trigger a kernel spl=
at
under UBSAN and potentially lead to a panic.

Should we validate the capability register bounds when parsing it to protect
against untrusted MMIO input?

> +	delta =3D (new_cnt - prev_cnt) & mask;
> +	if (overflow && new_cnt >=3D prev_cnt)
> +		delta +=3D mask + 1;
> =20
>  	local64_add(delta, &event->count);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805155501.1294=
472-1-dave.jiang@intel.com?part=3D3
