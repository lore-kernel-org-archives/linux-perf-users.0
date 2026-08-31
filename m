Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16158399D02
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214858; cv=none; b=GXpr60x3/RvugPeMqiM7uBXLOUcdlj70zJ+bZakEw35q859BhIoYbjLJQDqTZkb1p9S4QlvxcRBYUALIusbjTkzHw0FwrIJwKePb6dDnwT9n2k9X1OVvp3rk5qCzliVxhA4Pb7CmMFIHAO/JiJBo5tdh7fRKjfXQj3ciSVOQxyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214858; c=relaxed/simple;
	bh=eP6Bk91MJ8G22tz+mQn6onPaenDLY/5n3PXAaCkETOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TuZxAyHmKZCDjw72N2pMdcSjye1jviuhJy6YhHiLCp/zGQKwzJK28vkLRvOFgWM5hgrFVBe8a1MfTJu7DUaB2WWFhZGRU6o4peB8aZ/h9oEBnGHuf/iD1GMmxYulptev6pAzwwqo7D1PcKKC4Q3I+dYS10iVgSAQOVmL6h5kML0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFL2CX/5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFL2CX/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30D31F000E9;
	Mon, 31 Aug 2026 22:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214857;
	bh=XFNk7pPmDUbLLH4ReuYwMy56exMhxrRfMCHPc26QEBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFL2CX/5AROaVSup2QOVAUFgjspwVCq+uhbYivcCxoVahm311X7T5yCXSgjRcIz4B
	 rGuH575oWZWzlI/mm8APc7cR6dZedivQhocCJ3iiGTH8fiy3sH1ORar3d/1AfFG5j9
	 XjmIxRXxazefKTVTIonhYfhk8fNDFlv0c4nK2Np1PPj8wd38aUq+UdrI8Zza8DeNqU
	 MNlSv1P2XnPjNDdeFz9CHkpEVPU/OK1vG9XhSo4b1NUc7vsHYoHpuUtIijblcQoxPv
	 S9yIlJ0LEQIfZ3Zrn/E4GXcNm2dQFt3Yu/yCTZp8+pSX+Rv/wn01yIHwE2oO9XkB6U
	 1q9t8jbSsImKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831204613.2793526-5-thomas.falcon@intel.com>
References: <20260831204613.2793526-1-thomas.falcon@intel.com>
 <20260831204613.2793526-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:20:56 +0000
Message-Id: <20260831222056.C30D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of `output_str` on error paths in `perf_c2c__report`.
--

commit 667423b8d109e131918e4b4cfbcb77053abced1c
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: perf tools: Show memory region in perf-c2c subcommand

This patch adds a memory region field to the `perf c2c` cacheline list
view to help identify the memory region to which the cacheline belongs.
It modifies `output_str` to be dynamically allocated via `asprintf()`
when formatting the output string.

Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 715b75d42f2a8..c877b5056da08 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c

[ ... ]

> @@ -3271,9 +3325,16 @@ static int perf_c2c__report(int argc, const char *=
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
>  			     "cl_idx,"

[ ... ]

> @@ -3329,11 +3403,13 @@ static int perf_c2c__report(int argc, const char =
**argv)
> =20
>  	if (ui_quirks()) {
>  		pr_err("failed to setup UI\n");
> -		goto out_mem2node;
> +		goto out_str;
>  	}
> =20
>  	perf_c2c_display(session);
> =20
> +out_str:
> +	free(output_str);

[Severity: Medium]
Does this patch introduce a memory leak for output_str on other error paths?

This patch changes output_str to be dynamically allocated via asprintf(),
and updates the error path for ui_quirks() to jump to out_str to free it.=20

However, looking at the pre-existing code between the asprintf() calls and
ui_quirks(), there are other error paths that still jump to out_mem2node:

	err =3D c2c_hists__reinit(&c2c.hists, output_str, sort_str,
	                        perf_session__env(session));
	if (err) {
		pr_err("Failed to reinitialize hists\n");
		goto out_mem2node;
	}

	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");

	hists__collapse_resort(&c2c.hists.hists, NULL);
	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl_cb);
	err =3D hists__iterate_cb(&c2c.hists.hists, resort_cl_cb,
	                        perf_session__env(session));
	if (err)
		goto out_mem2node;

Should these error paths also be updated to jump to out_str instead of
out_mem2node to avoid leaking output_str?

>  out_mem2node:
>  	mem2node__exit(&c2c.mem2node);
>  out_session:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831204613.2793=
526-1-thomas.falcon@intel.com?part=3D4
