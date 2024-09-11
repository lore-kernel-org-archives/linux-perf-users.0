Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F491422D3;
	Wed, 11 Sep 2024 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041916; cv=none; b=BFG47mfJECRG2inOhTCVR8en62niQcrAFRwgva2cP2vw3/ZjEdslfT4XiPPXT6zTWrgkFV5N0gdmjNCNzHLrfBOSBgTQ5uug8zPKl0mAPYugNj0YJifEOwFj5jzp4EXbPU1HO+v/fAH+DDVnWVCcUpenwvvyaOsQ1WNxYszO+R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041916; c=relaxed/simple;
	bh=WNPhO6dkXIgPlM6PpH2jCTpJ9WyncswrGRNzMJCxs6w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=siLm9FwPHRkxHkLZoMFYvQ63XOdFm2d2+vJMGsTGbFeXrHI+I7LXjVm5z0pr1NqnNtm+OLZ6ksWzhvvU5/7douVgKXruj1lsoQU3wLeu8ehxXhAbyb4fvmm02s3ifUYzhoUFPThNVTd9Kxdf0vhayH9KyNkIa78b725JpezIK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdRUqgXu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdRUqgXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726041914; x=1757577914;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=WNPhO6dkXIgPlM6PpH2jCTpJ9WyncswrGRNzMJCxs6w=;
  b=MdRUqgXu8kC6ONVQ2deQvaRZ+cpq+XVFqDOxXRvGK3p+sP1lqJJeTezv
   W1i2XANOQhMF3OydYmQo3Fs2GvKwJ0QlQ/WaX7jv8jKaDGxYI41Kb59fm
   RpgZmYyL77ST1NFEj7iaTd/cBLSFrSAyNoYfvJ++C14VUGjc4Gsq1rMR7
   ahIGkHk2eU3LaNj2c4hYNc7T7ou+oeUY1IZP5PmBBlcYnNXlVkvkGzQDs
   gONVpesW8GlHNuvGl6UlQupWn9VCop3GekbyMiIK7/6luQ73INpen2oM1
   Jdrp0JRaTkjj7TA8wleDckmQHo8FUNPMIopANxs7pcRALARY9H4zpJnrM
   g==;
X-CSE-ConnectionGUID: Wofluwm8Tp2OHhbUQY9vkQ==
X-CSE-MsgGUID: Fti0ajDDTQ+am6R3z9oFsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="28565958"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="28565958"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:05:14 -0700
X-CSE-ConnectionGUID: 3efYDT5AQ7OEVQLwghrSwg==
X-CSE-MsgGUID: gsfkaZrMR+eNJTHPmLo3Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67790950"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:05:09 -0700
Message-ID: <3c2c5e34-2e26-4580-95dc-030504245872@intel.com>
Date: Wed, 11 Sep 2024 11:05:04 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v6 7/8] perf: disasm: prefer debugging files in build-id
 cache
To: Changbin Du <changbin.du@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hui Wang <hw.huiwang@huawei.com>
References: <20240725021549.880167-1-changbin.du@huawei.com>
 <20240725021549.880167-8-changbin.du@huawei.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240725021549.880167-8-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/24 05:15, Changbin Du wrote:
> The build-id cache might have both debugging and non-debugging files. Here
> we prefer the debugging version for annotation.

As I pointed out before, disassembling a different file
from the one that actually executed can have pitfalls.

If you want this, it needs to be optional, not the default.

But if you take the approach to remove vdso from the buildid
cache, and add back the debug version, then this patch would
not be needed for vdso.

> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/util/disasm.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 6af9fbec3a95..5f66b3632770 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1162,18 +1162,25 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  	    !dso__is_kcore(dso))
>  		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
>  
> -	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
> -	if (build_id_filename) {
> -		__symbol__join_symfs(filename, filename_size, build_id_filename);
> -		free(build_id_filename);
> -	} else {
> -		if (dso__has_build_id(dso))
> -			return ENOMEM;
> -		return fallback_filename(dso, filename, filename_size);
> -	}
> +	/* Prefer debugging file if exists, otherwise non-debugging one is used. */
> +	for (int i = 0; i < 2; i++) {
> +		build_id_filename = dso__build_id_filename(dso, NULL, 0, !i);
> +		if (build_id_filename) {
> +			__symbol__join_symfs(filename, filename_size, build_id_filename);
> +			free(build_id_filename);
> +		} else {
> +			if (dso__has_build_id(dso))
> +				return ENOMEM;
> +			return fallback_filename(dso, filename, filename_size);
> +		}
>  
> -	if (access(filename, R_OK))
> -		return fallback_filename(dso, filename, filename_size);
> +		if (!access(filename, R_OK))
> +			break;
> +		else if (i != 0) {
> +			/* nor debugging or non-debugging is found */
> +			return fallback_filename(dso, filename, filename_size);
> +		}
> +	}
>  
>  	if (dso__is_kcore(dso) || dso__is_vdso(dso))
>  		goto fallback;

