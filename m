Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1BB48FF7F
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577116; cv=none; b=qDHA+Z3jqMRp6vmagQ8Hpm0YcRZkZDpcu5a2Qt6g7l3tePjxyixM2uPbdNmLuFUemY7/BVNNiBhJFwFS+emBeV9hrHmoFjWzDF8p16/SLo3CHWqw1eXXnimvVde8V0kgsMRfZ4zUali/oeZIrJ+PDzcNEpWt0791bzy8R0V+2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577116; c=relaxed/simple;
	bh=iMHj/d7VjzyuREFnFTZqIxPV3u2M7aFBIWcEm3PpEYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J0IacizFdIEtrpS3vaXjOUvtTBg0zHSBs020AiF9L2Q0bTMP4OA4q06xJANjqgp9fS+29mH4xOPcjkdqB3jmFpl+i556rUPf5+4aQe+CVixY5egDAQSCC8vEiG5qOJvGTGfl8HaGO+dUPpxvHmqVPhWZzoGU7NvnIrroeIhxbjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYGBw9hs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYGBw9hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5981F00893;
	Wed, 16 Sep 2026 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577103;
	bh=OtwCaUZ/EFvDb/JYYL7b4gZgAaYtiKd+c3tsedxUs6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YYGBw9hsiq/M1M02ZiFVOQnCIms4nv0MOO1xj/Hms2fC1x21qIYB+ocLiSeu4/TX3
	 EfhJrNZYmo2uGSGmc+7pGJsvsPWSK3dFEEksn3PAPaUDRjIE/4i5oT3ab5a1dcgNYt
	 ap51UQY8kQb1pnbepiS8NoNi26HXr9Xpgkhg8jWkmP7aJZck3aISElJBYY1WvV5RKH
	 sN3fWQ9vbKkAIJEA38gECHSU4a0G1uD9/34ocRSC5BnBYb1harhn1NrqrXPBCCtK8q
	 6DAPgoqV9dc9lr3ifGpjEEh3GelHAKl4EEmZJvhirTFfEkv8HZJTiGrJGdcvnJdnG7
	 cvuf1DogRX69w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/6] perf header: Support memory ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916163127.318885-4-thomas.falcon@intel.com>
References: <20260916163127.318885-1-thomas.falcon@intel.com>
 <20260916163127.318885-4-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:45:03 +0000
Message-Id: <20260916164503.8E5981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: memory leak of env->memory_ranges when parsing malformed d=
ata
--

commit 1ab84913c01dd8ba27d90b19de21357887b69fea
Author: Thomas Falcon <thomas.falcon@intel.com>

perf header: Support memory ranges

This commit introduces support for tracking different types of memory
ranges, such as persistent or CXL-attached memory. It parses ACPI MRRM
data exposed via sysfs and saves it in the perf.data file header under
a new feature bit.

Link: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.=
com/

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index ec2935c0ed04e..38f2da9de5f0d 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -4227,6 +4372,65 @@ static int process_cpu_domain_info(struct feat_fd =
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
If a malformed perf.data file or pipe stream contains multiple
HEADER_MEMORY_RANGES sections, process_memory_ranges() in
tools/perf/util/header.c could be executed multiple times.

Can this assignment cause a memory leak by overwriting env->memory_ranges
without freeing the previously allocated array?

Could this leak be exploited to cause a Denial of Service (OOM) in the
userspace perf tool when processing untrusted pipe streams?

> +
> +	return 0;
> +error:
> +	zfree(&ranges);
> +	return -1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916163127.3188=
85-1-thomas.falcon@intel.com?part=3D3
