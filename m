Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE50414B97E;
	Mon,  9 Dec 2024 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768180; cv=none; b=S6YEc3JzMVw31xxUDGvT7zxGHW9m3mcs+hHnY6NLWegCrdxdgVCCr2MmNL6b0r9YUBa3pGRGF+7p64faVA2yDTvFg93XrxJmUaSCMoU+jV7ReUYNrgi2apPbmJ/74JgVs9Yj8yQD3aEq/NL+hVgowg5tfyuD7Uv0vDtzHJm8nd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768180; c=relaxed/simple;
	bh=K0O/96WPO4T4KGe+mVQoUR1NGQZjCLcIyS2i3Lo9KC0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EOyxCKlHGHgBBNh4kB1v/VBubCdGGFJNGnBwGc4hjtMJS5+RLbxvpJOX6A6dc/JFPXZmLvNIkRD/GVFz3qcmCV0Ve9p7nnpYiMjd6ItSyyVApUMBv713sYU7OLak193twl+d2vXk4j2Uqo7VV0eoR+/u/IrBeesSJT4ezsb320k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWjUbAK6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWjUbAK6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733768179; x=1765304179;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=K0O/96WPO4T4KGe+mVQoUR1NGQZjCLcIyS2i3Lo9KC0=;
  b=YWjUbAK68MI7zLGQwaalLVpAYJqv+dXI3l7MlhsVTTFtdkflqvkMjK00
   ghA0LjLf4jPgOvlzb4ynZiCVPGVe7ZS+8v0kSwrTyWvo7dweHTOtACJOo
   br/sCcipymh99Ym1qm7DmlNrd9TVIa5MRjXFaSRiFPY2EYOa1zGRBETjm
   AGCIda8ABpGuzATasZWas/X0D5eyT1CdfZgYCMy+f75bdw7kcigWXZDRq
   7/c+y1qyjnJnpMGLTCK6YphmJTNUQgh8rzH8X0ngPlBOHgGCRzwyvbiL+
   Hbw0DTNoB+HQm5Q3VfJhfva0VrEr1BKKabHTAB1z394HgvVaxKpV1u+qZ
   A==;
X-CSE-ConnectionGUID: Hh3kbievQCS1QYiKoI+vEw==
X-CSE-MsgGUID: y8LPUKc7S+CFHp13mVKR/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33421345"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="33421345"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 10:16:17 -0800
X-CSE-ConnectionGUID: VGP1537gSteC0+fGqmRVhg==
X-CSE-MsgGUID: tHtSLZ99RGCbwpI1c7u/WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="118405489"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.109.112]) ([10.125.109.112])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 10:16:16 -0800
Message-ID: <86ed629f736bcad8ffcb636182442b541b2f8daa.camel@linux.intel.com>
Subject: Re: [PATCH v1] perf cpumap: Reduce cpu size from int to int16_t
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
 <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, Yicong
 Yang <yangyicong@hisilicon.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org, Leo Yan
 <leo.yan@arm.com>, Kyle Meyer <kyle.meyer@hpe.com>
Date: Mon, 09 Dec 2024 10:16:15 -0800
In-Reply-To: <20241207052133.102829-1-irogers@google.com>
References: <20241207052133.102829-1-irogers@google.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBE6N6zwBCADFoM9QBP6fLqfYine5oPRtaUK2xQavcYT34CBnjTlhbvEVMTPlNNzE5v04Kagcvg5wYcGwr3gO8PcEKieftO+XrzAmR1t3PKxlMT1bsQdTOhKeziZxh23N+kmA7sO/jnu/X2AnfSBBw89VGLN5fw9DpjvU4681lTCjcMgY9KuqaC/6sMbAp8uzdlue7KEl3/D3mzsSl85S9Mk8KTLMLb01ILVisM6z4Ns/X0BajqdD0IEQ8vLdHODHuDMwV3veAfnK5G7zPYbQUsK4+te32ruooQFWd/iqRf815j6/sFXNVP/GY4EWT08UB129Kzcxgj2TEixe675Nr/hKTUVKM/NrABEBAAGJAS4EIAECABgFAk6ONYoRHQFLZXkgaXMgcmVwbGFjZWQACgkQHH3vaoxLv2UmbAgAsqa+EKk2yrDc1dEXbZBBGeCiVPXkP7iajI/FiMVZHFQpme4vpntWhg0BIKnF0OSyv0wgn3wzBWx0Zh3cve/PICIj268QvXkb0ykVcIoRnWwBeavO4dd304Mzhz5fBzJwjYx06oabgUmeGawVCEq7UfXy+PsdQdoTabsuD1jq0MbOL/4sB6CZc4V2mQbW4+Js670/sAZSMj0SQzK9CQyQdg6Wivz8GgTBjWwWsfMt4g2u0s6rtBo8NUZG/yw6fNdaoDaT/OCHuBopGmsmFXInigwOXsjyp15Yqs/de3S2Nu5NdjJUwmN1Qd1bXEc/ItvnrFB0RgoNt2gzf25aPifLabQlVGltIENoZW4gPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPokBOAQTAQIAIgUCTo3rPAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQHH3vaoxLv2XYdAf8DgRO4eIAtWZy4zLv0EZHWiJ35GYAQ5fPFWBoNURE0+vICrvLyfCKTlUTFxFxTiAWHUO7JM+uBHQSJVsE+ERmTPsiU
	O1m7SxZakGy9U2WOEiWMZMRp7HZE8vPUY5AM1OD0b38WBeUD3FPx5WRlQ0z6izF9aIHxoQhci0/WtmGLOPw3HUlCy1c4DDl6cInpy/JqUPcYlvsp+bWbdm7R5b33WW2CNVVr1eLj+1UP0Iow4jlLzNLW+jOpivLDs3G/bNC1Uu/SAzTvbaDBRRO9ToX5rlg3Zi8PmOUXWzEfO6N+L1gFCAdYEB4oSOghSbk2xCC4DRlUTlYoTJCRsjusXEy4bkBDQROjes8AQgAzuAQ5rF4/ZYaklzSXjXERiX0y1zBYmcYd2xVOKf50gh8IYv8allShkQ8mAalwIwyxTY+1k72GNCZIRVILSsuQY6fLmPUciuCk/X1y4oLNsF/Np8M9xxwYwqUibUwRdWwpSG2V0bcqjtUH1akaoY758wLONUmXrlfVonCfENd0aiP+ZLxYE1d1CRPv4KbAZ6z6seQCEQrappE4YXIC9yJUqT076DD1RhPmwNbNTTAauuwG+vX+jWsc5hUaHbKsAf/Rsw13+RA3dzWekbeIxO9qvQoQ26oqKEA31mxWhwNDnkTeo07+e2EGC2BV6s+sU1/m/lup5Bj34JLP7qYtd6EswARAQABiQEeBBgBAgAJBQJOjes8AhsMAAoJEBx972qMS79lYmQH+I4qdFm8wlkh/ZVWNJMSpfUfupuLPZ0g0hxNr3l2ZltEskVl5w+wJV+hBZ7zMmSxMYvMjJ+5aBDSZOfzhnK6+ETl4e/heDYiBLPYCtvU88cMRFb3jKcVxSfSzbBawEr7OFfCny3UtmYQ0PJmHFT6p+wlEHSyKxtyDDlLS/uPPR/llK94fOhvQlX8dir9b8r7JGuFTjtG2YbsTuapi3sFDmBhFZwYcNMt80FSIXGQjJzrsl1ZVSIwmqlF2191+F/Gr0Ld92dz1oEOjwKH1oRb/0MTsNU7udZv7L8iGKWCjHnA0dIoXKilf8EJyXGQ0wjQE3WBAdMecbvSKDRA7k
	9a75kCDQROjjboARAAtXPJWkNkK3s22BXrcK8w9L/Kzqmp4+V9Y5MkkK94Zv66lXAybnXH3UjL9ATQgo7dnaHxcVX0S9BvHkEeKqEoMwxg86Bb2tzY0yf9+E5SvTDKLi2O1+cd7F3Wba1eM4Shr90bdqLHwEXR90A6E1B7o4UMZXD5O3MI013uKN2hyBW3CAVJsYaj2s9wDH3Qqm4Xe7lnvTAGV+zPb5Oj26MjuD4GUQLOZVkaA+GX0TrUlYl+PShJDuwQwpWnFbDgyE6YmlrWVQ8ZGFF/w/TsRgJMZqqwsWccWRw0KLNUp0tPGig9ECE5vy1kLcMdctD+BhjF0ZSAEBOKyuvQQ780miweOaaTsADu5MPGkd3rv7FvKdNencd+G1BRU8GyCyRb2s6b0SJnY5mRnE3L0XfEIJoTVeSDchsLXwPLJy+Fdd2mTWQPXlnforgfKmX6BYsgHhzVsy1/zKIvIQey8RbhBp728WAckUvN47MYx9gXePW04lzrAGP2Mho+oJfCpI0myjpI9CEctvJy4rBXRgb4HkK72i2gNOlXsabZqy46dULcnrMOsyCXj6B1CJiZbYz4xb8n5LiD31SAfO5LpKQe/G4UkQOZgt+uS7C0Zfp61+0mrhKPG+zF9Km1vaYNH8LIsggitIqE05uCFi9sIgwez3oiUrFYgTkTSqMQNPdweNgVhSUAEQEAAbQ0VGltIENoZW4gKHdvcmsgcmVsYXRlZCkgPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPokCVQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQTRofI2lb24ozcpAhyiZ7WKota4SQUCYjOVvwUJF2fF1wAKCRCiZ7WKota4SeetD/4hztE+L/Z6oqIYlJJGgS9gjV7c08YH/jOsiX99yEmZC/BApyEpqCIs+RUYl12hwVUJc++sOm/p3d31iXvgddXGYxim00+DIhIu6sJ
	aDzohXRm8vuB/+M/Hulv+hTjSTLreAZ9w9eYyqffre5AlEk/hczLIsAsYRsqyYZgjfXLk5JN0L7ixsoDRQ5syZaY11zvo3LZJX9lTw0VPWlGeCxbjpoQK91CRXe9dx/xH/F/9F203ww3Ggt4VlV6ZNdl14YWGfhsiJU2rbeJ930sUDbMPJqV60aitI93LickNG8TOLG5QbN9FzrOkMyWcWW7FoXwTzxRYNcMqNVQbWjRMqUnN6PXCIvutFLjLF6FBe1jpk7ITlkS1FvA2rcDroRTU/FZRnM1k0K4GYYYPj11Zt3ZBcPoI0J3Jz6P5h6fJioqlhvZiaNhYneMmfvZAWJ0yv+2c5tp2aBmKsjmnWecqvHL5r/bXeziKRdcWyXqrEEj6OaJr3S4C0MIgGLteARvbMH+3tNTDIqFuyqdzHLKwEHuvKxHzYFyV7I5ZEQ2HGH5ZRZ2lRpVjSIlnD4L1PS6Bes+ALDrWqksbEuuk+ixFKKFyIsntIM+qsjkXseuMSIG5ADYfTla9Pc5fVpWBKX/j0MXxdQsxT6tiwE7P+osbOMwQ6Ja5Qi57hj8jBRF1znDjDZkBDQRcCwpgAQgAl12VXmQ1X9VBCMC+eTaB0EYZlzDFrW0GVmi1ii4UWLzPo0LqIMYksB23v5EHjPvLvW/su4HRqgSXgJmNwJbD4bm1olBeecIxXp6/S6VhD7jOfi4HACih6lnswXXwatzl13OrmK6i82bufaXFFIPmd7x7oz5Fuf9OQlLOnhbKXB/bBSHXRrMCzKUJKRia7XQx4gGe+AT6JxEj6YSvRT6Ik/RHpS/QpuOXcziNHhcRPD/ZfHqJSEa851yA1J3Qvx1KQK6t5I4hgp7zi3IRE0eiObycHJgT7nf/lrdAEs7wrSOqIx5/mZ5eoKlcaFXiKJ3E0Wox6bwiBQXrAQ/2yxBxVwARAQABtCVUaW0gQ2hlbiA8dGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb20+
	iQFUBBMBCAA+FiEEEsKdz9s94XWwiuG96lQbuGeTCYsFAlwLCmACGwMFCQHhM4AFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQ6lQbuGeTCYuQiQf9G2lkrkRdLjXehwCl+k5zBkn8MfUPi2ItU2QDcBit/YyaZpNlSuh8h30gihp5Dlb9BnqBVKxooeIVKSKC1HFeG0AE28TvgCgEK8qP/LXaSzGvnudek2zxWtcsomqUftUWKvoDRi1AAWrPQmviNGZ4caMd4itKWf1sxzuH1qF5+me6eFaqhbIg4k+6C5fk3oDBhg0zr0gLm5GRxK/lJtTNGpwsSwIJLtTI3zEdmNjW8bb/XKszf1ufy19maGXB3h6tA9TTHOFnktmDoWJCq9/OgQS0s2D7W7f/Pw3sKQghazRy9NqeMbRfHrLq27+Eb3Nt5PyiQuTE8JeAima7w98quQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-06 at 21:21 -0800, Ian Rogers wrote:
> Fewer than 32k CPUs are currently supported by perf.=C2=A0
>=20
Minor suggestions for the commit log. Perhaps it is clearer to say

Perf does not support more than 32k CPUs.

> A cpumap stores
> an int per CPU, so its size is 4 times the number of CPUs in the
> cpumap.=C2=A0
>=20
Perf cpumap currently uses a 4 byte int to index CPU, where
a 2 byte int is sufficient to cover the CPU range needed.

Otherwise

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

Tim
> We can reduce the size of the int to an int16_t, saving 2
> bytes per CPU in the map.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> This change is on top of:
> https://lore.kernel.org/lkml/20241206044035.1062032-1-irogers@google.com/
> ---
>  tools/lib/perf/include/perf/cpumap.h |  3 ++-
>  tools/perf/util/cpumap.c             | 13 ++++++++-----
>  tools/perf/util/env.c                |  2 +-
>  3 files changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/includ=
e/perf/cpumap.h
> index cbb65e55fc67..760a9aae9884 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -4,10 +4,11 @@
> =20
>  #include <perf/core.h>
>  #include <stdbool.h>
> +#include <stdint.h>
> =20
>  /** A wrapper around a CPU to avoid confusion with the perf_cpu_map's ma=
p's indices. */
>  struct perf_cpu {
> -	int cpu;
> +	int16_t cpu;
>  };
> =20
>  struct perf_cache {
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 27094211edd8..85e224d8631b 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -427,7 +427,7 @@ static void set_max_cpu_num(void)
>  {
>  	const char *mnt;
>  	char path[PATH_MAX];
> -	int ret =3D -1;
> +	int max, ret =3D -1;
> =20
>  	/* set up default */
>  	max_cpu_num.cpu =3D 4096;
> @@ -444,10 +444,12 @@ static void set_max_cpu_num(void)
>  		goto out;
>  	}
> =20
> -	ret =3D get_max_num(path, &max_cpu_num.cpu);
> +	ret =3D get_max_num(path, &max);
>  	if (ret)
>  		goto out;
> =20
> +	max_cpu_num.cpu =3D max;
> +
>  	/* get the highest present cpu number for a sparse allocation */
>  	ret =3D snprintf(path, PATH_MAX, "%s/devices/system/cpu/present", mnt);
>  	if (ret >=3D PATH_MAX) {
> @@ -455,8 +457,9 @@ static void set_max_cpu_num(void)
>  		goto out;
>  	}
> =20
> -	ret =3D get_max_num(path, &max_present_cpu_num.cpu);
> -
> +	ret =3D get_max_num(path, &max);
> +	if (!ret)
> +		max_present_cpu_num.cpu =3D max;
>  out:
>  	if (ret)
>  		pr_err("Failed to read max cpus, using default of %d\n", max_cpu_num.c=
pu);
> @@ -606,7 +609,7 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, cha=
r *buf, size_t size)
>  #define COMMA first ? "" : ","
> =20
>  	for (i =3D 0; i < perf_cpu_map__nr(map) + 1; i++) {
> -		struct perf_cpu cpu =3D { .cpu =3D INT_MAX };
> +		struct perf_cpu cpu =3D { .cpu =3D INT16_MAX };
>  		bool last =3D i =3D=3D perf_cpu_map__nr(map);
> =20
>  		if (!last)
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index e2843ca2edd9..f1d7d22e7e98 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -531,7 +531,7 @@ int perf_env__numa_node(struct perf_env *env, struct =
perf_cpu cpu)
> =20
>  		for (i =3D 0; i < env->nr_numa_nodes; i++) {
>  			nn =3D &env->numa_nodes[i];
> -			nr =3D max(nr, perf_cpu_map__max(nn->map).cpu);
> +			nr =3D max(nr, (int)perf_cpu_map__max(nn->map).cpu);
>  		}
> =20
>  		nr++;

