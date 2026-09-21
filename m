Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF237205D;
	Mon, 21 Sep 2026 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972959; cv=none; b=gl5wfO+fcru/qwwSlcfMoCmabJh6E7MtzMI2b8U+60t9OWPCgr4UG9nge5qfZ0fNEXf30CqpCY0h8v4BJGi+8t7yGJx0IUaHoHEZcBmX6odf5RUY6H5wZ04lmtxzSfLwE5EPv/CUKfF4W74CaZzg+vcWBL+pMr2Yz+Yzr4X86mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972959; c=relaxed/simple;
	bh=miUmxWQklUiHOs7CsGOCY/6HHEzzMWEgrUBNCkciLNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tITMrf2/L8ZbKX+INBkHBK56M99pc7nkaAOMzZTQA08jffbII7NlAIF/MBOBusfsbW0LghknujueIwTC33lrsCD3U0C+42OeO5DXwNOdAfWZoWXua1id4khZrgPnDte10mcZ59K7TIvmkCxbSeDOwaZa0HzDCCGArNt+5qjIFSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3nTytDy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3nTytDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789972957; x=1821508957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=miUmxWQklUiHOs7CsGOCY/6HHEzzMWEgrUBNCkciLNw=;
  b=n3nTytDyi4+IgWhs5bW7fq8r36jdrL7owc8v5FGi2J4RQBbLiYBzNu+Y
   u0x3hmGU2AD6Z+CwGBEmeqWBFcKEQcCmQhmStf0r2FsJvXhAYiS5sKIzu
   iOwAwHaBjmyydN7uD2PLJGSRswG6dftibhK9Yia5KzcpchiSXqY3KbEDq
   C5CspLzuY6l8jsYnfMs1BmfM51vbgvF5J96dhJu4Z+xg0fuJ8VSroJxF9
   YGcitq4BIyNmH25RvCTToWJ+Wqz7zmlsUq0hCvHdGpXoARNHIXnukR2fM
   TQ3M1gYInov+xP9c0Mqk9vvSyOHkB+BuUt0rw8rfQwsslZpzhez369gox
   A==;
X-CSE-ConnectionGUID: HoVP95RkTJWgGnNBPfldCQ==
X-CSE-MsgGUID: dCX5RNCBQyCFqPRtT+XVaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="115994983"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="115994983"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 23:42:35 -0700
X-CSE-ConnectionGUID: Rfd4HpQqR8CCQPq3Ik35mg==
X-CSE-MsgGUID: trtZ2uZIRQqIOnQit5+YKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="271991207"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 23:42:31 -0700
Message-ID: <024fd251-a4ba-443f-8aff-f5b1cdb062a3@linux.intel.com>
Date: Mon, 21 Sep 2026 14:42:28 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf alsr: Add missing SIMD handling in
 aslr_tool__process_sample()
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260915091112.333308-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260915091112.333308-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kindly ping ...

@Arnaldo, @Namhyung, @Ian, not sure if you have bandwidth to review this
small patchset which fixes the Sashiko found minor issues for the "Perf
tools: Support eGPRs/SSP/SIMD registers sampling" patchset?

If possible, it's better to be queued in this cycle, then we don't need
extra backporting. Thanks.


On 9/15/2026 5:11 PM, Dapeng Mi wrote:
> Currently the SIMD register sampling is supported, but the corresponding
> handling is missed in aslr_tool__process_sample(). This can break parsing
> of the sample record.
>
> Add the missing SIMD register handling in aslr_tool__process_sample().
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>
> These two patches fix Sashiko reported defects for the patchset:
> "Perf tools: Support eGPRs/SSP/SIMD registers sampling"
> https://lore.kernel.org/all/20260914014049.2061519-1-dapeng1.mi@linux.intel.com/
>
>  tools/perf/util/aslr.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index 027695d96779..a097084201a0 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
> @@ -19,6 +19,7 @@
>  #include <internal/lib.h>  /* page_size */
>  #include <linux/compiler.h>
>  #include <linux/zalloc.h>
> +#include <linux/overflow.h>
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <unistd.h>
> @@ -992,6 +993,34 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
>  				COPY_U64();
>  		}
>  	}
> +
> +#define CHECK_SIMD() \
> +	do { \
> +		if (abi & PERF_SAMPLE_REGS_ABI_SIMD) { \
> +			u64 nr_vector, vec_qwords; \
> +			u64 nr_pred, pred_qwords; \
> +			u64 header_len, vec_len, pred_len, simd_len; \
> +			if (CHECK_BOUNDS(nr + 4, nr + 4)) { \
> +				ret = -EFAULT; \
> +				goto out_put; \
> +			} \
> +			header_len = 4;	\
> +			nr_vector = in_array[i + nr]; \
> +			vec_qwords = in_array[i + nr + 1]; \
> +			nr_pred = in_array[i + nr + 2]; \
> +			pred_qwords = in_array[i + nr + 3]; \
> +			if (check_mul_overflow(nr_vector, vec_qwords, &vec_len) || \
> +			    check_mul_overflow(nr_pred, pred_qwords, &pred_len) || \
> +			    check_add_overflow(vec_len, pred_len, &simd_len) || \
> +			    check_add_overflow(header_len, simd_len, &simd_len) || \
> +			    check_add_overflow(nr, simd_len, &nr) || \
> +			    nr > max_i - i) { \
> +				ret = -EFAULT; \
> +				goto out_put; \
> +			} \
> +		} \
> +	} while (0)
> +
>  	if (orig_sample_type & PERF_SAMPLE_REGS_USER) {
>  		u64 abi;
>  
> @@ -1007,6 +1036,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
>  				ret = -EFAULT;
>  				goto out_put;
>  			}
> +			CHECK_SIMD();
>  			i += nr;
>  		}
>  	}
> @@ -1061,6 +1091,7 @@ static int aslr_tool__process_sample(const struct perf_tool *tool,
>  				ret = -EFAULT;
>  				goto out_put;
>  			}
> +			CHECK_SIMD();
>  			i += nr;
>  		}
>  	}
>
> base-commit: 91b0782fc9e9d2f0a40b5256146e014802fdbb36
