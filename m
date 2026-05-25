Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143131EEE6
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779676201; cv=none; b=tq7zpP7LxByeKTqPqClUWSiDTDSl58KNTMpKmTodxUIYv5Y3vdbhvf+I+8+O8We5zMhommU6k3vDaA769GYi5Vu9mLXfiq3h4fvQCCGOVTpIl6/FvxlKORtymFWsjS+U4wt9fivoydPPA2C7MgZl40NwzbkvmdAqRDXz8zArPt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779676201; c=relaxed/simple;
	bh=GuiLE2s3JxVR7Jn0TKyCt/IY3mHCtzO1A9d0U6JrMfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J+bW7RXlPWZsQ1BCXLqZxbGePprpSGVRoZsH73ouNkVdK+zhE2U8bVpIriSOR9+bAyC8l1iZ+UZGmDLaxmzlwcraeuY+YZszqmCq0YsNUybB5MJIODXIkr089YLR94EMxAqgv5ZxOkdAzppeRSxN/Xa75P3q9gB6SWwt8DgQVGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEeRA8IN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEeRA8IN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6321E1F000E9;
	Mon, 25 May 2026 02:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779676199;
	bh=XnLzgvmfHzBzTtpYlyzg+Spkb4koSmY8U7VTi52DIQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aEeRA8INOirD8JP1Ht7SjMRxk3TcsqxeYbZp4Mnsqn0lzXfVOz1nNHT8ciVaxIEhy
	 XQT00R+rVDf5yE4/fe0Ag74niDmI1AngO+L1BHXtre1wHLcH/miOxAq/CVWHFN+UMw
	 gNy5RhtBBZ2+7xvCXOdvIQ//uLEWMByC8NP9yXDMz/MMvsQtHGHNoD9xZvNYWz9HxM
	 TlT1CDJJx66S4H1hsSpueIkHmziUfYmm2umqg11PfKnvTGOL9I4R5W3Gx+lrlDcxw3
	 AaqIpIDDKh3yvbf1TLdmCAtkcKIY0jWWU6FETqbq616yVrCNE6OI9i07J6dvt/CpGf
	 fACG8n4SOxjxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/29] perf header: Validate bitmap size before
 allocating in do_read_bitmap()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-23-acme@kernel.org>
References: <20260525010550.1100375-23-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 02:29:58 +0000
Message-Id: <20260525022959.6321E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The comment describing the per-node data layout does not accurately=
 reflect the actual fields parsed by the code.
--

commit d907ff7c8f16b6254548f1529a40af97b741421f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Validate bitmap size before allocating in do_read_bitmap()

This commit adds bounds checking and size validation to do_read_bitmap()
to prevent out-of-bounds allocations and reads. It also changes the
allocation to u64 units to avoid truncation on 32-bit architectures, and
fixes related memory leaks and bounds checks in process_mem_topology().

Closes: https://lore.kernel.org/linux-perf-users/20260414224622.2AE69C19425=
@smtp.kernel.org/
Closes: https://lore.kernel.org/linux-perf-users/20260410223242.DD76FC19421=
@smtp.kernel.org/

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 37d7c9849e0e9..66929c5557b21 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -3497,7 +3520,8 @@ static int process_mem_topology(struct feat_fd *ff,
>  		return -1;
>  	}
> =20
> -	if (ff->size < 3 * sizeof(u64) + nr * 2 * sizeof(u64)) {
> +	/* Per node: version(u64) + bitmap_size(u64) + bitmap data (>=3D 1 u64)=
 */

[Severity: Low]
This isn't a bug, but does this comment accurately reflect the actual fields
parsed by the code?

It appears the first per-node field is actually the node ID, not the versio=
n,
and this comment omits one of the two size fields written per node. It also
assumes the bitmap data is always >=3D 1 u64 (when it could be 0). While the
calculation nr * 3 * sizeof(u64) correctly accounts for the 3 metadata u64
fields (node ID, size, and the second size from do_read_bitmap()), the text
describing the layout seems slightly incorrect.

> +	if (ff->size < 3 * sizeof(u64) + nr * 3 * sizeof(u64)) {
>  		pr_err("Invalid HEADER_MEM_TOPOLOGY: section too small (%zu) for %llu =
nodes\n",
>  		       ff->size, (unsigned long long)nr);
>  		return -1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D22
