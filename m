Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0978D2178FE;
	Tue,  8 Oct 2024 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430079; cv=none; b=Po1UsGSq/2qgPxQjJui4I6IgOs49/9kUE78LdTH4iaz/mV+isoCwdp0gq2UpnwhBGp10bdNv5Ffr7w+vpF0dmEkqFMSMwxK0S4bquAczhSOSLi9JUe57fzFPw1l4cMfZonoEs35bqatIhYedYkV9oEr9zNS1n4ZhHy7y2XkwWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430079; c=relaxed/simple;
	bh=+qVfB+S3INz5fiqXcuLpGrRFhIFW3Zcau90fn5k/1EY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eO28H4M5upZPYLhBYLhPhwgCflX/asle838dzjTP0zVJxnz8Qokc6zoFqZG81hi/gHRuyphnSW/gxeHxTxIhdV1HgyQOyqRwRxHrjWLkh7FOl+76lYsJkvpWds469gFbnQb4tTjgxzdis6rTVxkIrnVPi/O31sV9mhg/EVOQTmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWQm2yGh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWQm2yGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430078; x=1759966078;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=+qVfB+S3INz5fiqXcuLpGrRFhIFW3Zcau90fn5k/1EY=;
  b=lWQm2yGh8nXRQ8Q56bNoAXTgF52ZMHWSfuzGbJx2dwU/GjuLg7hX7l0B
   q3OKylXjpQ+HKJhH42aF/lE7RzJfHA3cws3hYYMO0pJSgVydDJTspA59X
   x2DFMbGk3NcWXpFuA801zto3McSNZ91KNzgLUzGx4HIGERZOOc13UsvfE
   aJOqgD4HKQg4EKk8gsSiw5RpGsGLWrquIx2Dep6r0I3p/ChNwnPd2BJsD
   V0d9PXJxWBgiPyY5xh2Zto836eXhWqA72yTHR1zeyJOk7wvGd0ki2gfHE
   VG6+cQhvZIo3RORQF8CiUX+RotspLU5ZDKFE5Hgj8gMq159qa3kccxc9r
   w==;
X-CSE-ConnectionGUID: zUbdipYHTviW1+xNM+8yMw==
X-CSE-MsgGUID: ZF4P/Fe+RxaZkCIBampRnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27138938"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27138938"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:27:55 -0700
X-CSE-ConnectionGUID: gO7tB19vTNyY94WhrO/gbQ==
X-CSE-MsgGUID: LDtKNg6PSsSP5iBwrKOusA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="99378577"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.110.176]) ([10.125.110.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:27:53 -0700
Message-ID: <3fb7cc3fab054ad5b2af8a5ae5fd7dbdace774a2.camel@linux.intel.com>
Subject: Re: [PATCH v1 4/8] perf stat: Drop metric-unit if unit is NULL
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
 <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, Will
 Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, Mike Leach
 <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Yicong Yang
 <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, Thomas
 Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 08 Oct 2024 16:27:52 -0700
In-Reply-To: <20241004234120.1495209-5-irogers@google.com>
References: <20241004234120.1495209-1-irogers@google.com>
	 <20241004234120.1495209-5-irogers@google.com>
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

On Fri, 2024-10-04 at 16:41 -0700, Ian Rogers wrote:
> Avoid cases like:
> ```
> $ perf stat -a -M topdownl1 -j -I 1000
> ...
> {"interval" : 11.127757275, "counter-value" : "85715898.000000", "unit" :=
 "", "event" : "IDQ.MITE_UOPS", "event-runtime" : 988376123, "pcnt-running"=
 : 100.00, "metric-value" : "0.000000", "metric-unit" : "(null)"}
> ...
> ```
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-display.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index e392ee5efb45..9b65968e37d1 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -470,8 +470,9 @@ static void print_metric_json(struct perf_stat_config=
 *config __maybe_unused,
>  	struct outstate *os =3D ctx;
>  	FILE *out =3D os->fh;
> =20
> -	fprintf(out, "\"metric-value\" : \"%f\", ", val);
> -	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
> +	fprintf(out, "\"metric-value\" : \"%f\"", val);
> +	if (unit)
> +		fprintf(out, ", \"metric-unit\" : \"%s\"", unit);

I think if there's no metric unit, we should skip printing metric value as =
a metric
of 0 has no meaning.

Tim
>  	if (!config->metric_only)
>  		fprintf(out, "}");
>  }

