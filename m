Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A727BF7C;
	Wed, 15 Jul 2026 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098750; cv=none; b=CcE+NK3eL/U13xGH+kNg0LMOOtk31/UB4ph4HgJw4brP0iUytgyVPaQxXN/xW073yK2C0qFNUwFiT6RLEHyUjWNs5+E/n/iBAMRM7nJEVQSYOERa1Xue/OI69jHxJBibwjzWpYy0OFg5pFpClqUHCU1bw3pRkcWgj0qC+vxKhME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098750; c=relaxed/simple;
	bh=ParntBj7aJUMtgq6BK8SI1BodAJHtRSEEUSIxnA028Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=av1eo/Aa6mG8nNMC+7u1sWIxd6vTvXIeaN97RE0jpQyzgclNg1PjmRi3oY2zH8T/pRhgaV4HnqisXOv7mLoqqrIE9A61aR6zVE6tYHnjeRLPLO+Xgy9SPXYm5FEi7MOrHvLWVbzwPV8bmxDBn6KZfiI3vULQWApshNktkQGi7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5Ahm8gg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5Ahm8gg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784098749; x=1815634749;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ParntBj7aJUMtgq6BK8SI1BodAJHtRSEEUSIxnA028Q=;
  b=S5Ahm8ggk4AKz+SvUVnX0hOpWrphym8EysK2rM5akatfWMPMKg/7GbAy
   hHaEnqCSX+2Fcz6B+m5S37uuvS+6+tbW1t2312iXfKkV8Gbs2mDIGLROM
   UVNUiYR8bH4qOGJPhHZIVpF8ILR7u1rgoz7EX/g6FU6neSuSi9HVkep9m
   vYgWY6UesvIMaY9QAqr2rbpB7zqiTMwLbnk1ar8FAO0V5dLBlop9CwjKN
   BT7ceqdp7DIPVGLQho0oUnzDSdwvV6Ou6dBJGh5TTebfhcb7hLqKdkatE
   T4kuZaUKg4L1In5qlKvk36neIGzsFLrZOso3kq/0iGpzB/bAktNsTOxzh
   g==;
X-CSE-ConnectionGUID: BLvz7d9KRmWIi7tfqFqq+w==
X-CSE-MsgGUID: OGtdZeetSwu9hAv2CfFS8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95872379"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="95872379"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:59:08 -0700
X-CSE-ConnectionGUID: uTWJz6yGRR6KvgJ71P54Sw==
X-CSE-MsgGUID: nKx9I1maQbmu+UJ1GugvEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="252123549"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:59:05 -0700
Message-ID: <cc84fbf5-0a07-4049-8250-f764c852ee49@linux.intel.com>
Date: Wed, 15 Jul 2026 14:59:02 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
To: Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-2-thomas.falcon@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260714004359.179451-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 7/14/2026 8:43 AM, Thomas Falcon wrote:
> When printing memory info in perf script, the entire size of the
> buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
> size. Pass the remaining buffer size instead.
>
> This issue was detected by sashiko during an internal code review.
>
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Fixes: fdefc3750e847 ("perf mem: Print memory operation type")
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  tools/perf/util/mem-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 0b49fce251fc..4e490f9cd348 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -610,7 +610,7 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
>  	i += scnprintf(out, sz, "|OP ");
>  	i += perf_mem__op_scnprintf(out + i, sz - i, mem_info);
>  	i += scnprintf(out + i, sz - i, "|LVL ");
> -	i += perf_mem__lvl_scnprintf(out + i, sz, mem_info);
> +	i += perf_mem__lvl_scnprintf(out + i, sz - i, mem_info);
>  	i += scnprintf(out + i, sz - i, "|SNP ");
>  	i += perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
>  	i += scnprintf(out + i, sz - i, "|TLB ");
