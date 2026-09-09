Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE63403ED
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970537; cv=none; b=BtD+Eowu0nR0VXAeacvjPjX0uNCKEocU9kcdPkybfk148tRSLO5WB3xmyEyjGpxmYWvlwUWYceH6u6XzuzL7xiCI98UXWJKirBh0iwzSETbeLKUCOpL596x4rLMi6VXsVl4WNSudfnaDVYEU7d/XqqKx/EeThCLv3icTZYX5KFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970537; c=relaxed/simple;
	bh=mjubv4FHuUbU7VM11247/msMYognFzMRQcojZtHvUps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h2mGQj24RyQVne7OEQxleA3Cda8NvsVAfh23LR012pALOPyUfOdIaQsoab9pWX5NY4uuzHhntEh1EPlFF9Ue1Qd/6tFpmiJ6L9DRh1NfR18YFXkgpoA6wx/4Sdyf7NoP5IuEd2XHNv8Zjwhpfi8hYhbb0bAhBEp6BMuvdDvlp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etFPhS0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etFPhS0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294031F00893;
	Wed,  9 Sep 2026 16:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970536;
	bh=GK4bxm9z+kOMB7cDILYvJuHl+YbNPGk2jgi1ZLQM5qE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=etFPhS0bn1g1J3k0Akv1EaGlTiEd+2N790HVRDsEpyfe8zFTfHybJHS1dl2YywZ8s
	 U1AwgarQXbKegiETWB3ocqoFtAnxSBM6C6M6uWxsD2IuoDfBJTZCOpphQD7K5hbQG6
	 OVaBv1pQ2be6CVjFfLmatVc/hCnlB2MYd/GiXkUxeKAbQJ+ffCrWtjwNnYFwYJ/IUv
	 TX90xfTpWCWhME/Z6Ge0NuSAu7WO5CayEGIprlVeoon8vy5ADA2lEGzNgY4W+76iUC
	 IEt+e5c2bi7SYRpuu+d6aOAaTnJyUu1ulZwqLVaL+Q4A3CRGfAm8+h1xMdLZKVoX7m
	 qV1zYgt0CWrhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/6] perf header: Support memory ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260909160218.174928-4-thomas.falcon@intel.com>
References: <20260909160218.174928-1-thomas.falcon@intel.com>
 <20260909160218.174928-4-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:15:35 +0000
Message-Id: <20260909161536.294031F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Potential memory leak of `env->memory_ranges` in `process_memory=
_ranges` when called multiple times.
--

commit 9619ae1d9d691918f8e1f649f853a92424ed440c
Author: Thomas Falcon <thomas.falcon@intel.com>

perf header: Support memory ranges

This commit introduces support for tracking and exposing memory ranges pars=
ed
from the ACPI MRRM table. It reads memory range data from sysfs and saves it
in the perf data file under the new HEADER_MEMORY_RANGES feature bit.

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

[Severity: Medium]
Could this result in a memory leak of the previous env->memory_ranges
allocation?

In pipe mode, the perf_event__process_feature() function parses feature
headers as they arrive and dispatches them to process_memory_ranges(). If
the HEADER_MEMORY_RANGES feature is encountered multiple times in a data
stream, this assigns the newly allocated array to env->memory_ranges without
freeing the previous array.

> +
> +	return 0;
> +error:
> +	zfree(&ranges);
> +	return -1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909160218.1749=
28-1-thomas.falcon@intel.com?part=3D3
