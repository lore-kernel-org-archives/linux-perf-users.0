Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF672C11E6
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 22:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426638; cv=none; b=OokF27m3hurX3k976J1rggc+B4jQTKD7QqM6xgmxqqD3/5SQVKCMF55rnx+OhANWdI226gZUBfMptShnwVpS/BjJXSCNqHzrl4x1EdeD+BNQHYNU58dDlPbCZI0rgMIDdjIBrjaEPHNW1coCqvHvYJbMgmFF3/tW2V0CVG65hUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426638; c=relaxed/simple;
	bh=0wiPnwZcnLvTZh/Qqm11E44znVcKyyM6JFq6/XaMbxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IqROBg9Cc8m0edXbS3OlGsEXecvVJ854Gn7G66sGZbohq81iOUzcVy4pfTrsx6m4jpWH3nUA3rKn3Ivwtv7gWqJ+BCHucjj9JFAH/AdrsVA86skol5WR+u5XRyiFe2YUyMw0nSrKBw9nHvWLFPsyH5KUq8SUMGuavtF3g4PT3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdeeytyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdeeytyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667A11F000FF;
	Mon, 14 Sep 2026 22:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789426636;
	bh=cV9Js248281Y62we1Zn71huk7fhVYvpGxXCmSwqFC14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdeeytyHDPCPWj4QfYLmeezBBwLAQTCw/rCtusR592AfK434F1hHKwjpQqYntbsGP
	 4Ghp0NMVPi0QzGyY09s/NzHZEIYBCOe8oanNBJsLJt1npBSJEIrXtWNAg27yX4EVHG
	 W+oNGgNCIMER/eRnjwIdv/CZcPvyXeCoL2x8yGOjI/GzTpHZ+F/kblrduY+ThUf6e+
	 os3hwoSZe/pJXWLL0wXz+aGxoNC/FGCM/bYLFF1E0FN77i7pSdp8ShDhcJz4hwVDxy
	 76GSU5rxwxtKbCH5Z6QxkP4HR/HFkVfDiHxZHcgHj8g6qkf3t+m/1/Sd7uY/xK0cw6
	 LQRlh7wuy/tvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914224650.52982-5-thomas.falcon@intel.com>
References: <20260914224650.52982-1-thomas.falcon@intel.com>
 <20260914224650.52982-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:57:16 +0000
Message-Id: <20260914225716.667A11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf c2c: valid memory region overwritten by N/A
- [Low] perf c2c: missing stdio.h inclusion for asprintf
--

commit d7af7398254a585e98330957faf348c7603375be
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tools: Show memory region in perf-c2c subcommand

Add memory region field to the cacheline list view to help users
identify the memory region to which the cacheline belongs. The memory
region field was included with the introduction of support for the
Off-module Response facility (OMR) in Intel's Diamond Rapids and
Nova Lake architectures.

Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 715b75d42f2a8..4272f5f22c01f 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -247,6 +248,16 @@ static void c2c_he__set_node(struct c2c_hist_entry *=
c2c_he,
>  	}
>  }
> =20
> +static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
> +				   unsigned int mem_region)
> +{
> +	if (WARN_ONCE(mem_region > PERF_MEM_REGION_MEM7,
> +		      "WARNING: invalid memory region ID\n"))
> +		return;
> +
> +	c2c_he->mem_region =3D mem_region;

[Severity: Medium]
Does this code unconditionally overwrite a previously recorded valid memory
region with a new value?

In process_sample_event(), this is called for every sample grouped into the
cacheline hist_entry:

process_sample_event()
  c2c_he__set_mem_region(c2c_he, mem_region);

If multiple samples hit the same cacheline, could an earlier sample that
provides valid OMR region data be overwritten by a later standard sample
(such as an L1 hit) lacking it? This could result in the cacheline's
memory region being incorrectly displayed as 'N/A' in the perf c2c output.

[ ... ]

> @@ -3271,9 +3353,16 @@ static int perf_c2c__report(int argc, const char *=
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
> +			     "cl_idx,"

[Severity: Low]
Does this file explicitly include <stdio.h> for asprintf?

Since musl libc enforces strict POSIX header separation and doesn't
implicitly include headers, omitting <stdio.h> here could lead to build
failures when compiling perf with a musl libc toolchain.

>  			     "dcacheline,"
> +			     "%s"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914224650.5298=
2-1-thomas.falcon@intel.com?part=3D4
