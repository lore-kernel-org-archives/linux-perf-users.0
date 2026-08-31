Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C639DBDB
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214379; cv=none; b=KJFfCpNzJ+YCcz5goat7ct1hIYWy6AODsGJeTZ65KuDL7+PXfCrDREoOTMKyQET/CAqpKouo3V65TgFXyTsGTa4FNAKT+mmjuGcyeQT/UKi3J+AVUxmrZjzgA5a9m8rpmlcU5iA0EMBcIASFT+DGLHqlu/d2jM43atfL0pK9pfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214379; c=relaxed/simple;
	bh=5z5ldiggagsYt+xbho3UFJeW5uQw2n2fvHSEG5SuzVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TAaLhMDbvVHgjTEU7DGiqYPyelfmth+1ChzVRe+jQveeydmLSYJBqNfEh7xSiFQ7CibbsBoJnXB5FFZWgYmUR2Lm0uhxXtANfTvyFCgnoWc6Ho9zF6g1y0h80RKETTUZlL5LvfMpwFR2d0rq7xY0aoTlOmOBIh1gGTjxQ65a80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFnOA+zm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFnOA+zm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE4D1F000E9;
	Mon, 31 Aug 2026 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214377;
	bh=alNg9mrf0izzoFa0IPGxpsYfnMX9aFAbhb0s+ByOGlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XFnOA+zmEdUXZgM9AELr6vRrdyh9jGFMcrg7TGtaY7ah6cEN7mPtMxtnM0na9PVJR
	 mKJKY49MRCZBgsdRLEX1I49Ka2ig3fzBeXV+aV/J1Z4WOZk5V6JCwcA0o6tdF6TLKB
	 V2vs1vDQ2LXVtVFgjOC7ei1cfqs78wL+Fgzu2m2hFKbvj3uczcIV1zeZz00KoEgyxs
	 D7xDi8CzFEye7zjxQDQlLQm992jHUp6njtly2sQxLyYSnM44T/mL2i01B0/MmjxbJP
	 kIBVfUhq7iSoJ6+w1+VlEz2851iLAWDKDJ1qtb25qtz7fYkdTJFvg6zR2Zm7GYnmBk
	 urGJP+qZJTaoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] perf header: Support memory ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831204613.2793526-4-thomas.falcon@intel.com>
References: <20260831204613.2793526-1-thomas.falcon@intel.com>
 <20260831204613.2793526-4-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:12:57 +0000
Message-Id: <20260831221257.9EE4D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of `env->memory_ranges` when processing multiple HEA=
DER_MEMORY_RANGES sections.
--

commit 0dcf161b1003085435ecec4dd99b1a0326a98d1b
Author: Thomas Falcon <thomas.falcon@intel.com>

perf header: Support memory ranges

This patch introduces support for parsing and storing memory ranges from
the ACPI MRRM table in perf.data files. It adds a new feature bit,
HEADER_MEMORY_RANGES, and exposes the data via the perf-report and
perf-script tools. The data is read directly from sysfs and parsed
during feature initialization.

Link: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.=
com/

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 7db7da090a1e0..83416ce395d7c 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -4202,6 +4346,64 @@ static int process_cpu_domain_info(struct feat_fd =
*ff, void *data __maybe_unused
>  	return ret;
>  }
> =20
> +static int process_memory_ranges(struct feat_fd *ff, void *data __maybe_=
unused)
> +{
> +	struct perf_env *env =3D &ff->ph->env;
> +	struct memory_range *ranges, *r;
> +	u32 nr_memory_ranges, i;
> +
> +	if (do_read_u32(ff, &nr_memory_ranges))
> +		return -1;
> +
> +	if (!nr_memory_ranges) {
> +		pr_debug("memory ranges not available\n");
> +		return 0;
> +	}
> +
[ ... ]
> +	ranges =3D calloc(nr_memory_ranges, sizeof(*ranges));
> +	if (!ranges)
> +		return -1;
> +
> +	for (i =3D 0; i < nr_memory_ranges; i++) {
> +		r =3D &ranges[i];
> +
> +		if (do_read_u64(ff, &r->base))
> +			goto error;
> +		if (do_read_u64(ff, &r->length))
> +			goto error;
> +		if (do_read_u32(ff, (u32 *) &r->node))
> +			goto error;
> +		if (__do_read(ff, &r->local_region_id, sizeof(u8)))
> +			goto error;
> +		if (__do_read(ff, &r->remote_region_id, sizeof(u8)))
> +			goto error;
> +	}
> +
> +	env->memory_ranges =3D ranges;
> +	env->nr_memory_ranges =3D nr_memory_ranges;
> +
> +	return 0;

[Severity: Medium]
In pipe mode, a perf.data stream containing multiple HEADER_MEMORY_RANGES
feature events can cause process_memory_ranges() to be executed multiple
times.

When this occurs, does this assignment leak the previously allocated
env->memory_ranges array, since the newly allocated ranges array
unconditionally overwrites it without first freeing the prior allocation?

> +error:
> +	zfree(&ranges);
> +	return -1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831204613.2793=
526-1-thomas.falcon@intel.com?part=3D3
