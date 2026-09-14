Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6A242D88
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351384; cv=none; b=juBFYRtsqH8YgMzTo/FUFkr87CCIa5xJMSW7o3oqdOOhn37hw0poHErHgowfVpsSFKTFkJN4f0GyRDYNadvEptEFcRYgjJ9noCQ1pTtEFSpieh5ZJHgyLM5lP3KU0iPKpqhJwBaN5fzu8k6r2TZT0BowmEeRCn4YhE12rygyMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351384; c=relaxed/simple;
	bh=Vv7aYDVax96xsIuCnSfJ6qffVCqvN4vy20hhSqy2lbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dIXk7hp32Dh7hngymp+dItYdDARShW7oudlnaDlq9kFzt0v/blMYB/IKJzPEoIP07YdR9DyI8JBRXZ/F9G/bmHcT2FIxuBXTISTtgjUo4gKQn6RSSbtkTM8RlP01CGxFeC3N8ixyAUy2soimTbb3I2w21BOAqVXysym+rECOZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jutIuNSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jutIuNSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAB01F000FF;
	Mon, 14 Sep 2026 02:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789351383;
	bh=WWIoDWVdtnlKZjB/EeHiXIRToKkuvw2rMux9dzibxyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jutIuNSJRn43mdeCnf5F3l264Y++dGYqgwoAjiD7LrCKTMI0abvCz/+cFdkVYg8mE
	 yuU2YneMaXJWkv4/fTbyo+wZdtnH8g4YSaNAITEL+rdmgiO7B7G1DmnFmUsZBQyuSp
	 Y4NEZMYO1p+n4Aw8UcD7yF2O07X19M9l+xg4cz3ZV1SedS9sSN7ybPf/0SMOFcQqpB
	 RJa1OZSeGkDaUQLLWntOdy3/3lpyjvVlPVGYqZAVrBpcYxefFYlAdjhK9narA8aWAC
	 v+Utquhr5aPrciFMe2DOKKMlMlUN+DOxJpOvPn+gsZ0J9iyWVRoibKNzTH0hxX7CG1
	 XDc49xJjydGJg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v11 06/10] perf regs: Support x86 SIMD registers
 sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914014049.2061519-7-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 02:03:02 +0000
Message-Id: <20260914020302.DDAB01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing `evsel__is_non_software_event()` check for SIMD register s=
ampling allows software events to request SIMD registers, causing `sys_perf=
_event_open()` to fail.
- [High] XMM registers are silently dropped from the default `-I` and `-U` =
register capture sets on modern kernels.
- [Low] Missing explicit inclusion of POSIX headers (`<unistd.h>`, `<string=
s.h>`) and inclusion of an unused non-standard header (`<sys/param.h>`).
--

commit 09156b6b89ab2ab1deab99c4296be004bb60e327
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf regs: Support x86 SIMD registers sampling

This commit adds support for the newly introduced SIMD register sampling
format on x86 platforms. It introduces helpers to retrieve SIMD register
classes and modifies the configuration logic to handle SIMD registers for
interrupt and user sampling.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index e9a0400af6dae..a62cb63ad3371 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -31,6 +31,7 @@
>  #include <sys/resource.h>
>  #include <sys/syscall.h>
>  #include <sys/types.h>
> +#include <sys/param.h>

[Severity: Low]
Does this file require <sys/param.h>? It looks like this is a non-standard
header that might be unnecessarily included here without being used, which
could cause issues on strict POSIX/musl systems.

[ ... ]

> @@ -1672,6 +1673,16 @@ void evsel__config(struct evsel *evsel, const stru=
ct record_opts *opts,
>  		evsel__set_sample_bit(evsel, REGS_INTR);
>  	}
> =20
> +	if ((opts->sample_intr_vec_regs || opts->sample_intr_pred_regs) &&
> +	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
> +		attr->sample_simd_regs_enabled =3D !!opts->sample_simd_regs_enabled;
> +		attr->sample_simd_vec_reg_intr =3D opts->sample_intr_vec_regs;

[Severity: High]
Should this block be guarded by evsel__is_non_software_event(evsel)?

If a user runs perf record with mixed hardware and software events
(e.g., perf record -e cycles,cpu-clock --intr-regs=3DXMM0), the opts
structure is shared.

It seems this unconditionally applies SIMD sampling to software events,
which could cause sys_perf_event_open() to abort with -EINVAL.

> +		attr->sample_simd_vec_reg_qwords =3D opts->sample_vec_reg_qwords;
> +		attr->sample_simd_pred_reg_intr =3D opts->sample_intr_pred_regs;
> +		attr->sample_simd_pred_reg_qwords =3D opts->sample_pred_reg_qwords;
> +		evsel__set_sample_bit(evsel, REGS_INTR);
> +	}
> +
>  	if (opts->sample_user_regs && !evsel->no_aux_samples &&
>  	    !evsel__is_dummy_event(evsel)) {
>  		attr->sample_regs_user |=3D opts->sample_user_regs;
> @@ -1681,6 +1692,16 @@ void evsel__config(struct evsel *evsel, const stru=
ct record_opts *opts,
>  		evsel__set_sample_bit(evsel, REGS_USER);
>  	}
> =20
> +	if ((opts->sample_user_vec_regs || opts->sample_user_pred_regs) &&
> +	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
> +		attr->sample_simd_regs_enabled =3D !!opts->sample_simd_regs_enabled;
> +		attr->sample_simd_vec_reg_user =3D opts->sample_user_vec_regs;

[Severity: High]
Similar to the intr block above, this user registers block appears to be
missing the evsel__is_non_software_event() check.

This could lead to the same -EINVAL failure for mixed software events.

[ ... ]

> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse=
-regs-options.c
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
> @@ -106,6 +106,116 @@ name_to_gp_reg_mask(const char *to_match, uint64_t =
mask, int abi)
> =20
> +static bool
> +name_to_simd_reg_mask(struct record_opts *opts, const char *to_match,
> +		      uint64_t mask, bool intr, bool pred)
> +{
[ ... ]
> +		if (!strcasecmp(to_match, name)) {

[Severity: Low]
Does this file need to include <strings.h>?=20

The strcasecmp() function is mandated by POSIX to be in <strings.h>.
Without explicitly including it at the top of the file, this could break
compilation on musl-based libc systems.

[ ... ]

> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/=
util/perf-regs-arch/perf_regs_x86.c
> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> @@ -300,8 +301,14 @@ uint64_t __perf_reg_mask_x86(bool intr, int *abi)
>  	if (mask !=3D PERF_REGS_MASK) {
>  		*abi |=3D PERF_SAMPLE_REGS_ABI_SIMD;
>  	} else {
> -		mask |=3D __arch__reg_mask(sample_type, PERF_REG_EXTENDED_MASK,
> -					 false);
> +		/*
> +		 * Use the SIMD sampling interface for XMM registers
> +		 * when available.
> +		 */
> +		if (!__support_simd_sampling(intr)) {
> +			mask |=3D __arch__reg_mask(sample_type,
> +						 PERF_REG_EXTENDED_MASK, false);
> +		}
>  	}
> =20
>  	return mask;

[Severity: High]
Does this unintentionally drop XMM registers from default captures when SIMD
sampling is supported?

When a user runs perf record -I with no specific arguments, __parse_regs()
in parse-regs-options.c uses the default mask:

    /* str may be NULL in case no arg is passed to -I */
    if (!str) {
        *mode =3D mask;
        if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
            opts->sample_simd_regs_enabled =3D 1;
        return 0;
    }

Because __perf_reg_mask_x86() skips adding PERF_REG_EXTENDED_MASK to
mask when SIMD is available, and __parse_regs() doesn't dynamically
populate opts->sample_intr_vec_regs with the XMM bits when str =3D=3D NULL,
it looks like XMM registers are completely omitted from the capture.

[ ... ]

> +static bool
> +__support_simd_reg_class(uint64_t sample_type, uint16_t qwords,
> +			 uint64_t mask, bool pred)
> +{
[ ... ]
> +	fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);
> +	if (fd !=3D -1) {
> +		close(fd);

[Severity: Low]
Does this use of close() require an explicit include of <unistd.h> at the
top of perf_regs_x86.c?

Code relying on implicit header inclusions can break compilation on strict
musl-based libc systems.

> +		return true;
> +	}
> +
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914014049.2061=
519-1-dapeng1.mi@linux.intel.com?part=3D6
