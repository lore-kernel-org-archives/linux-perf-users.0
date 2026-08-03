Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904FD33438F
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790638; cv=none; b=AvMyfLo5Sz5APaxg1iA9ye7xkhACc7qKPaYSd0W2ay0omKfDjtmrCJH6srNsBNZ98IhKippIt4hsy4szd7Hp7uKI23Yigr6DvRZBT37BpquMCvX7y7qN560b5norLxH3/TYe4YA2Wf0hdA+iCSnoQiQdhyevij2RdfF3WUwsZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790638; c=relaxed/simple;
	bh=e3xGAQXx4eJP64rY+nOESE2gXlrWEt+LBAkjWS3sfKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M2lHuUeOvY3d3sUHsAV8R90VE9CgP/kxP0LhUqUGC1ahJWmD86/VTujtHDE/6UmTLtm8ldhtwHFwG6j0pnG5MIiJVixUGb2ijjzLctcoOlpiSIFnW3CA+vaO5cKtkdeGrL8mP1d4nzGwokA+IqIGhzV0WFvq/ipLxxg7k2JvXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmizVRKv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmizVRKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567A71F000E9;
	Mon,  3 Aug 2026 20:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790637;
	bh=GPW/b5EgZVYQccsIo4xOPMzyja0hnDLoA7qnTDAL2g0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WmizVRKv4xht1RdL9RDd1IDMN1NuRRY+hO+JhyKXxg9efS4jvJIwlyHU4bQVXH1hk
	 FoaUhiCRow9n1D3yZDqSwYsI08VnHO0flz/GS7sshKXDDaXNc3A5A98ERTL8k3gVzD
	 UCJQmv1pmlcH2UZzKi6/ngSbGWF26vQkwkKp/Deb1P5epwDNHhqCI387JHIk7UA/we
	 UIQi5CXvUWTgX4mQR6wYSrztLetnY0o9IE1Y6uLYCS/BDIuRx9Va9XYIbZPpaTIUfV
	 Lrd89ymjrYMH4IdhdK2/lLpG50XlgzoAFXIDng1BaB7RdpFetIVO0/ZTVFbEnKYABZ
	 7OLvDlu/9zQWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803204540.100348-5-thomas.falcon@intel.com>
References: <20260803204540.100348-1-thomas.falcon@intel.com>
 <20260803204540.100348-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 20:57:16 +0000
Message-Id: <20260803205717.567A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unconditional header span and width changes break the perf c2c U=
I layout for older or unsupported perf.data files.
- [Medium] perf_c2c__report incorrectly returns 0 (success) when asprintf m=
emory allocation fails.
--

--- Patch [4]: [PATCH v3 4/6] perf tools: Show memory region in perf-c2c su=
bcommand ---
commit a204da119426634f593eeb8162efcca17a1e1e85
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tools: Show memory region in perf-c2c subcommand

This commit adds a memory region field to the cacheline list view in the
perf c2c subcommand output. It parses the memory region from memory info
and dynamically adds the column if the HEADER_MEMORY_RANGES feature is
present in the perf.data file.

Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c9584dbedf77a..6954a48c60e46 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -1425,7 +1466,7 @@ cl_idx_empty_entry(struct perf_hpp_fmt *fmt, struct=
 perf_hpp *hpp,
>  	}
> =20
>  static struct c2c_dimension dim_dcacheline =3D {
> -	.header		=3D HEADER_SPAN("--- Cacheline ----", "Address", 2),
> +	.header		=3D HEADER_SPAN("--- Cacheline ----", "Address", 3),

[Severity: Medium]
Will this unconditional header span break the UI layout when the memory reg=
ion
column is excluded?

Because has_mem_regions conditionally adds the column, if the perf.data file
lacks the HEADER_MEMORY_RANGES feature, this static span of 3 might swallow
the headers of subsequent columns.

>  	.name		=3D "dcacheline",
>  	.cmp		=3D dcacheline_cmp,
>  	.entry		=3D dcacheline_entry,

[ ... ]

> @@ -2898,8 +2948,9 @@ static int ui_quirks(void)
>  	/* Fix the zero line for dcacheline column. */
>  	buf =3D fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
>  				dim_dcacheline.width +
> +				dim_dcacheline_mem_region.width +
>  				dim_dcacheline_node.width +
> -				dim_dcacheline_count.width + 4);
> +				dim_dcacheline_count.width + 6);

[Severity: Medium]
Could this width calculation also cause visual artifacts when the memory
region column is absent?

Similar to the header span, the zero-line text width unconditionally includ=
es
the new column's width and spacing, which could pad the zero line excessive=
ly
when the column is not rendered.

>  	if (!buf)
>  		return -ENOMEM;

[ ... ]

> @@ -3370,50 +3370,50 @@ static int perf_c2c__report(int argc, const char =
**argv)
> =20
>  	has_mem_regions =3D perf_header__has_feat(&session->header,
>  						HEADER_MEMORY_RANGES);
> =20
>  	if (c2c.display !=3D DISPLAY_SNP_PEER) {
>  		ret =3D asprintf(&output_str,
>  			       "cl_idx,"
>  			       "dcacheline,"

[ ... ]

>  			       has_mem_regions ? "dcacheline_mem_region," : "");
>  		if (ret < 0)
>  			goto out_mem2node;

[Severity: Medium]
Does this error path accidentally return success when asprintf() fails?

The original code sets err =3D 0 at the beginning of perf_c2c__report(),
and this goto statement jumps to cleanup without setting err =3D ret or sim=
ilar,
so the function will return 0 even though memory allocation failed.

>  	} else {
>  		ret =3D asprintf(&output_str,
>  			       "cl_idx,"
>  			       "dcacheline,"

[ ... ]

>  			       has_mem_regions ? "dcacheline_mem_region," : "");
>  		if (ret < 0)
>  			goto out_mem2node;

[Severity: Medium]
Does this alternative display layout's error path also accidentally return
success when asprintf() fails?

Similar to the previous block, err is not updated before jumping to cleanup.

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803204540.1003=
48-1-thomas.falcon@intel.com?part=3D4
