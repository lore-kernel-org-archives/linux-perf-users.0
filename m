Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F3D438038
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790807; cv=none; b=Ieh7XzBVQhlo1vnJn4+Eg1USNNSV0MKzoZ7qcyJg5BPHi6jaDRZQ+YgTlCioX0u+RqVwAD8fUskPDjWnSCrnK8vWw47LFi6Ap2SEOPNwCPCgCu7xJC7ZIkFOiMLFOvyLY1h9F087nppXN/o3bdO1iBqBOGFAUWoaA/+EaNoN1Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790807; c=relaxed/simple;
	bh=HJwh9NiEoVtGp579+2aPj1xwHgd9IpNApP9Igv0GDvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nCSvX/b9JvQnzVY8hm3uRpkBpvh+7jL2syVPtgSNxVnlBJ8JfrPQ4hGXvEKILPoWznRIYY0GX+1YUKjdzLWLrKbhhlGYBiyy1uMSEpyNY5zndRSOgJtuJ6xBl0B+sckZ/AQyQpW5OE2ie54UGdwBKoouNXs2yU79A85CqCN+zGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhcgBvAi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhcgBvAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557AB1F000E9;
	Mon,  3 Aug 2026 21:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790805;
	bh=YeCtjKfw/275S0KvJJUtifck0AHX3UEiU9inZdHZG6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FhcgBvAiJsZKen7HtQaXA8JRozKn2HGJcB9+08BwK2XMsQJya9hETpW7wGXHzWjzp
	 mR8DOI6Ucjzntdewti5LCpJRHq8Sq/2MMfFHIwOTibPxGK8eqffC8PNnFVW4dT6G0b
	 4wguHZ4oITfXAY6B2Xy5MGAFOZt0yx53ej5k31H3ENe/+oQoadTLZQtZVf3WlrMrvo
	 lovxYGSImqcsaL1UiI9FTxCfmVID1y+3ANkP6vNLoc8cPSQEkdX+zs4PIHWbJO41qY
	 rtDmXzX819NrmztcFno6SyvJykJdKVtlpTJTkIz4HQd65bYu9II3zP3oEHOHK+Vk7u
	 caYIW56OfGGfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] perf header: Support memory ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803204540.100348-4-thomas.falcon@intel.com>
References: <20260803204540.100348-1-thomas.falcon@intel.com>
 <20260803204540.100348-4-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 21:00:04 +0000
Message-Id: <20260803210005.557AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The bounds check for `local_region_id` and `remote_region_id` inco=
rrectly rejects the valid value of 255 (UINT8_MAX).
- [Medium] Missing explicit inclusion of `<fcntl.h>` for `open()`, `openat(=
)`, `O_RDONLY`, and `O_DIRECTORY`, causing musl build failures.
- [Medium] Repeated parsing of HEADER_MEMORY_RANGES sections leaks previous=
ly allocated memory.
--

--- Patch [3]: [PATCH v3 3/6] perf header: Support memory ranges ---
commit 0b006df2ed3ab47f9865f5a75df7ab210c86b2a2
Author: Thomas Falcon <thomas.falcon@intel.com>

perf header: Support memory ranges

This commit adds support for parsing memory range data from the ACPI MRRM
table exposed via sysfs. It saves this data in the perf data file header
under a new feature bit, HEADER_MEMORY_RANGES, and adds support for
displaying it.

Link: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.=
com/

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 091d8f7f6bd2c..a9dedbe390243 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -1891,6 +1892,132 @@ static int write_cpu_domain_info(struct feat_fd *=
ff,
>  	return ret;
>  }
> =20
> +static int memory_range__read(struct memory_range *range, const char *pa=
th)
> +{
> +	char buf[32];
> +	ssize_t n;
> +	int dfd, fd, tmp, ret =3D -1;
> +
> +	dfd =3D open(path, O_RDONLY | O_DIRECTORY);

[Severity: Medium]
Since this function uses open(), openat(), O_RDONLY, and O_DIRECTORY, should
<fcntl.h> be explicitly included at the top of the file to prevent build
failures on musl libc?

> +	if (dfd < 0)
> +		return -1;
> +
> +#define _R(name, dst, conv)			\
> +	fd =3D openat(dfd, name, O_RDONLY);	\
[ ... ]
> +	_R("local_region_id", tmp, strtol);
> +	if (tmp < 0 || tmp >=3D UINT8_MAX)
> +		goto out;
> +	range->local_region_id =3D tmp;
> +	_R("remote_region_id", tmp, strtol);
> +	if (tmp < 0 || tmp >=3D UINT8_MAX)
> +		goto out;

[Severity: High]
Does this bounds check incorrectly reject the valid value of 255?=20

UINT8_MAX evaluates to 255, so using >=3D will cause the function to reject
255 and jump to the error path. However, the example output in the commit
message shows remote_region_id =3D 255, which suggests 255 is an expected a=
nd
valid value.

> +	range->remote_region_id =3D tmp;
> +#undef _R
> +
> +	ret =3D 0;
> +out:
> +	close(dfd);
> +	return ret;
> +}
[ ... ]
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
[ ... ]
> +	env->memory_ranges =3D ranges;
> +	env->nr_memory_ranges =3D nr_memory_ranges;
> +
> +	return 0;

[Severity: Medium]
If a perf.data file contains multiple HEADER_MEMORY_RANGES sections, could=
=20
this leak the previously allocated memory?=20

This assignment blindly overwrites env->memory_ranges with the newly alloca=
ted
ranges array without first checking for or freeing any existing allocation.

> +error:
> +	zfree(&ranges);
> +	return -1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803204540.1003=
48-1-thomas.falcon@intel.com?part=3D3
