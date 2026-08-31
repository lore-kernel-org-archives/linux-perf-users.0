Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E323BCD05
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216261; cv=none; b=kX2SgkupFy98Sh9hGXl4MetP9TTUWF57OMxVnh5eTttc3tqw3Vto8ymC8VrKc6kCPhtg0DbwO/0ra3bhbGikCwNrGrwIEFlqnmrf/0ahbqy/Hm45r6zf8/MWijiSZO7PX0Ttkz8RQ8bbPB9XCt0ifzWG2Y+7+PTjOE/dvYV4eu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216261; c=relaxed/simple;
	bh=t7GInPVmDaBrBvKeUQ1i4ztcrwfRZKG+OcszZ4A6/jk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T0S+gOj475l1L17uAES0v+sx4RUKkPloJ/f286BekVFJqcoDV7QLvHtQh8aaZrz7+DlgCX3+Cl+mJBkM2JDsWizfyULOphck3hmSiBIxJaHNwjYHC+OtKK/yS5IuSwyMoyIiW6xjcOtrNfoHWXxc1xoqe582Fb1h8GcJ521TxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0FqW9Dk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0FqW9Dk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1CD1F00A3E;
	Mon, 31 Aug 2026 22:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788216260;
	bh=6bHvGlIUTgXNTEaWSb8EyYl7Kb9lHuFsGl/onHHWYeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P0FqW9Dkj/1xEPwDZgsjpqFkVDYOijWuCTJJynNdXcwYQmCMDRNFOhC50AardzUq6
	 X8tHV9l4xKw9u9Qx8BRgRhKcwpl/jtafOi9XifcgQ9AA91bwWbXS75zTom9KwHdS+x
	 WqD+PrTVTO3qW2Z6F/oicxJ6P+ui4JJXIexYhaywS40eOJaUHo7Vwl1NNUMfCQLseU
	 sM8taOKRUyn2btGj36QbMaorfX4bb8uEay3XVlGJCf5zGYQY6fvJv879jFyPcGuJhc
	 /LEKiajtbo185OPVUiLCn7brsqCBGmFF7lptxyfUhzSpmVJGAMPwlfFoULflmk0KzR
	 kjJqyM1wgIDAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] perf c2c: print memory region data with stdio
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831204613.2793526-7-thomas.falcon@intel.com>
References: <20260831204613.2793526-1-thomas.falcon@intel.com>
 <20260831204613.2793526-7-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:44:19 +0000
Message-Id: <20260831224420.6D1CD1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The dynamically allocated string `output_str` is leaked on inter=
mediate error paths.
- [Low] The new function `print_memory_ranges_info` relies on standard I/O =
structures and functions (`FILE`, `fprintf`) but fails to explicitly includ=
e `<stdio.h>`, violating musl compatibility guidelines.
--

commit 56f9a74e597ecb10ca78e8a87ceec53476ce6327
Author: Thomas Falcon <thomas.falcon@intel.com>

perf c2c: print memory region data with stdio output

This commit adds memory range printing to the perf c2c subcommand. It outpu=
ts
memory range data only in stdio mode currently, printing nothing if ranges =
are
unsupported or not present.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 715b75d42f2a8..da669136e5452 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c

[ ... ]

> @@ -2530,6 +2580,34 @@ static void print_c2c_info(FILE *out, struct perf_=
session *session)
>  	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
>  }
> =20
> +
> +static void print_memory_ranges_info(FILE *out, struct perf_session *ses=
sion)
> +{
> +	struct perf_env *env =3D perf_session__env(session);
> +	int nr_ranges =3D 0;
> +
> +	if (!perf_header__has_feat(&session->header, HEADER_MEMORY_RANGES))
> +		return;
> +	nr_ranges =3D env->nr_memory_ranges;
> +	if (nr_ranges =3D=3D 0) {
> +		pr_debug("No memory ranges found, skipping\n");
> +		return;
> +	}
> +
> +	fprintf(out, "\n");

[Severity: Low]
Does this new function miss the required standard I/O header inclusion?=20

The print_memory_ranges_info() function directly relies on FILE and fprintf=
(),
but the file does not explicitly include <stdio.h>. Can this omission cause=
 a
build failure under musl?

> +	fprintf(out, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D\n");
> +	fprintf(out, "                  Memory Ranges                  \n");
> +	fprintf(out, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D\n");

[ ... ]

> @@ -3271,9 +3355,16 @@ static int perf_c2c__report(int argc, const char *=
*argv)
>  		goto out_mem2node;
>  	}
> =20
> -	if (c2c.display !=3D DISPLAY_SNP_PEER)
> -		output_str =3D "cl_idx,"
> +	c2c.show_mem_region =3D perf_header__has_feat(&session->header,
> +						HEADER_MEMORY_RANGES);
> +	if (c2c.show_mem_region)
> +		dim_dcacheline.header.line[0].span =3D 3;
> +
> +	if (c2c.display !=3D DISPLAY_SNP_PEER) {
> +		if (asprintf(&output_str,
>  			     "dcacheline,"
> +			     "%s"
>  			     "dcacheline_node,"

[ ... ]

> @@ -3329,11 +3433,13 @@ static int perf_c2c__report(int argc, const char =
**argv)
> =20
>  	if (ui_quirks()) {
>  		pr_err("failed to setup UI\n");
> -		goto out_mem2node;
> +		goto out_str;
>  	}

[Severity: Medium]
Does this code leak the newly allocated output_str on intermediate error pa=
ths?

The string output_str is now dynamically allocated using asprintf(), but so=
me
error paths in perf_c2c__report() still jump to out_mem2node instead of
out_str, bypassing the newly added free(output_str) cleanup.

For example, when c2c_hists__reinit() fails:

	err =3D c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session__=
env(session));
	if (err) {
		pr_err("Failed to reinitialize hists\n");
		goto out_mem2node;
	}

And similarly when hists__iterate_cb() fails:

	err =3D hists__iterate_cb(&c2c.hists.hists, resort_cl_cb, perf_session__en=
v(session));
	if (err)
		goto out_mem2node;

Should these jumps be updated to out_str to prevent the memory leak?

> =20
>  	perf_c2c_display(session);
> =20
> +out_str:
> +	free(output_str);
>  out_mem2node:
>  	mem2node__exit(&c2c.mem2node);
>  out_session:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831204613.2793=
526-1-thomas.falcon@intel.com?part=3D6
