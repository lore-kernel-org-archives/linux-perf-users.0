Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186591;
	b=OaoGPrvVk8SalzzWPYSWtl58SacfYI0qCBegDIPbAEOGImGusaWElffv8xVXdIUJ5cWb
	 /2AKnJg6Jg/bahdXnBsMqLUPuxtIqmbOFlgxibcs2Su/OoqmMakxbNxBynDttRahxalmV
	 EFCPQ6+EovVKwwvM3u5fsfZ7Ib5M81DzozhMAwPGvoFbMgqKyeJXIYbu4P9vcYt+elqUp
	 D9BF9s60YVj18hgLR06mmrj6tJM7nDPtRU4PDnFVzmmY1X3suVjg0twAMKdj95lP234QR
	 LeWQpnnsvkMKuZTGT61tKKFAIKTWMK7UjAVnY3OqYNJsS67MGiv5j75Fvk9mqCMU4YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186591;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nSZl96CyMVG8PDQXuv9f1FOzYBjwMDLvwnGdtQlCGl0=;
	b=Iw+MOlE9GTdRBxNCbyDNBRmnl22r3vPn5cpTw6tIKYuEi2rfdWrVVEwgC2/7N4U4l9pL
	 s6BEAW1rWkIY+7GGQHGjPS640bW9iYCFseNE0q3tuetVOBI/5eYnCCcB0bUXVqsJsP9Om
	 raL47fsbH3CB1U03Trzmgp4EUxvg8snoVd/yq/SQIh3BoeWE2M78Cd8EUn6OBQrYBi7W0
	 bFktFSmKfwcQTIAWpD1o/37CaokGI7RKrPzzd0Cv1Hw5CxrU59G+tlhDHaop0a7qV0bld
	 GVhjdnh7DRIllO1+aS5rrd0XGA4YJJ+vETinHfynQYx4JbKdp3l5hEN/BXA5w5r76ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WV/29Wjn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F6606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WV/29Wjn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACC21F0089F;
	Mon,  9 Nov 2026 01:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794186590;
	bh=nSZl96CyMVG8PDQXuv9f1FOzYBjwMDLvwnGdtQlCGl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WV/29WjnWHnOODkdvF1z/xJz+V7t8GEETARHVETjN0bHAPtfZCa61XuKMhcPX5eL+
	 bNZMdWSkBw+1BniZVFrH/nqB9td/oxToXnvyjg3OKZT0HQf5thNE+j+AzG08bedHAn
	 3lAS25dXzw7gdYhv6YwjW7MIcmmgd0r+bxSi6clloTHeLRx76JGqhl7XxxbCjMWpJI
	 QQqApe/K+dnwbKdmoU8bNBdywoxNGYy7VW272fxr9DrAOBAQhECtPln8zuXI0kPVVd
	 M8roTXFViJjss5Mx+KnuVQVeEG62tQ2ukVULCfkabH5XOplYo38aKzgyhD0HBTT93p
	 lXbvxT1TO8WPA==
Message-ID: <sashiko-outbox-204282@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 5/5] perf c2c: Rename "Region" column to "Range" for
 consistency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109004402.1403713-6-dapeng1.mi@linux.intel.com>
References: <20261109004402.1403713-1-dapeng1.mi@linux.intel.com>
 <20261109004402.1403713-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:09:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf c2c: Range column header conflates region IDs with MRRM
  range indices
--

commit 359275a3e2aec93ecd4fbf0366bae0325d3a6862
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf c2c: Rename "Region" column to "Range" for consistency

This commit renames the header of dim_dcacheline_mem_region and
dim_offset_mem_region from "Region" to "Range" and reduces their column
width from 6 to 5.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index a2dcc65d6b3ce..94fca3e4fc0a0 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -1395,11 +1395,11 @@ static struct c2c_dimension dim_dcacheline_node =
=3D {
>  };
> =20
>  static struct c2c_dimension dim_dcacheline_mem_region =3D {
> -	.header		=3D HEADER_LOW("Region"),
> +	.header		=3D HEADER_LOW("Range"),
>  	.name		=3D "dcacheline_mem_region",
>  	.cmp		=3D empty_cmp,
>  	.entry		=3D dcacheline_node_mem_region,
> -	.width		=3D 6,
> +	.width		=3D 5,
>  };
> =20
>  static struct c2c_dimension dim_dcacheline_count =3D {
> @@ -1429,11 +1429,11 @@ static struct c2c_dimension dim_offset_node =3D {
>  };
> =20
>  static struct c2c_dimension dim_offset_mem_region =3D {
> -	.header		=3D HEADER_LOW("Region"),
> +	.header		=3D HEADER_LOW("Range"),
>  	.name		=3D "offset_mem_region",
>  	.cmp		=3D empty_cmp,
>  	.entry		=3D dcacheline_node_mem_region,
> -	.width		=3D 6,
> +	.width		=3D 5,
>  };

[Severity: Low]
Does renaming this column to "Range" conflate hardware memory region IDs
with the range indices printed in the Memory Ranges table?

set_mem_region_str() formats the sampled PERF_MEM_REGION_MEM0..MEM7 bits as
numeric region IDs (0..7), whereas print_memory_ranges_info() prints each
ACPI MRRM entry with both a Range index and region IDs:

tools/perf/builtin-c2c.c:print_memory_ranges_info() {
    ...
		fprintf(out, "Range %d: [0x%016" PRIx64 "-0x%016" PRIx64 "] Node %d, loca=
l region id %u, remote region id %u\n",
			i, r->base, r->base + r->length - 1, r->node,
			r->local_region_id, r->remote_region_id);
    ...
}

When multiple physical address ranges map to the same region ID (for
example, Range 0 and Range 1 on local region id 0, and Range 2 on local
region id 1), labeling the region ID column "Range" causes a reported value
of 1 to look like Range 1 rather than region id 1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109004402.1403=
713-1-dapeng1.mi@linux.intel.com?part=3D5
