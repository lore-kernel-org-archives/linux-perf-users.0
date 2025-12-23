Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7DB42048;
	Tue, 23 Dec 2025 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766469503; cv=none; b=geotuEgAqCjGmIka2y3A684uJv5jNqj39XWEMx1jhmbrsr8h9U6fnpA6GKcX1gZLlBAV+TnNihF/TjVAq+SmWIAJCaz/KKXE4gbhSGPsfueX8ZUb0pxJev3lYbNxeacXg1kYgTeNuZHXnP5zKB/ENreu9ms898E59CLUOtvCQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766469503; c=relaxed/simple;
	bh=FT6HD752+iZ+0ionk3EidtqeWqU9B7ZGsI0uNBQumWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2lEtNvMBKTyFQIcxWrElkSi4ZF0oP0Fuoxx17tpfWZusZb7Gw4BeElXIkPCvnVsKwWqTI1DB0lzzDuVLeBDHpAH3QwtOcES62TTF87YKmESO0GE1m0RxaB5mSy16qSDs+lLpE6laczsPeEgehE8T2s2VWn34eNluz9Sl40AGDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5OpJc+C; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5OpJc+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766469502; x=1798005502;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FT6HD752+iZ+0ionk3EidtqeWqU9B7ZGsI0uNBQumWk=;
  b=d5OpJc+C5dXldRIGKhIy9xxT8/nREakhV/PaFyV8OjlV9B9t/nrNPgpz
   Bj2nEqfahJsgtoKp+WKiToxLkaP0Hf5+vO7tVZwnR+YZFWLMoTd862zCH
   CgswJLSiouiKfyuleEvfEvGXGCUbCQ8VK8Ug2ADGXREPy0Bx3E1eSZqJU
   yDTw/ZeYwfQhBnjyuBmJLIc/EJCOSdMCcfWRvUQQlhOGE3C8KV0SzHB0f
   AD2WdZrFkRW471Ed/F3ann1iki9i/BTJeaveZnV5YIkuApjnxeUrkr24K
   v5u+tqtVeWvWFMEfhdFggskVtlZmJ4ganLNm3ZevqO0XesatXMcxalI/Z
   A==;
X-CSE-ConnectionGUID: DEHEtGIoSSCQu2oiLH1eiQ==
X-CSE-MsgGUID: pzc0gEzzTpSEB1ndI1ekWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="78634545"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="78634545"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 21:58:22 -0800
X-CSE-ConnectionGUID: a86dWVTiRGKOekCRCOC3wg==
X-CSE-MsgGUID: Qkp8VPMoTUW9NYUCqjb90g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="200612176"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 21:58:17 -0800
Message-ID: <65e75e07-974a-4bc6-8299-d19e040508cd@linux.intel.com>
Date: Tue, 23 Dec 2025 13:58:15 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] perf pmu: Relax uncore wildcard matching to allow
 numeric suffix
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251212210007.13986-1-zide.chen@intel.com>
 <20251212210007.13986-8-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251212210007.13986-8-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/13/2025 5:00 AM, Zide Chen wrote:
> Diamond Rapids introduces two types of PCIe related uncore PMUs:
> "uncore_pcie4_*" and "uncore_pcie6_*".
>
> To ensure that generic PCIe events (e.g., UNC_PCIE_CLOCKTICKS) can match
> and collect events from both PMU types, slightly relax the wildcard
> matching logic in perf_pmu__match_wildcard().
>
> This change allows a wildcard such as "pcie" to match PMU names that
> include a numeric suffix, such as "pcie4_*" and "pcie6_*".
>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  tools/perf/util/pmu.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 3d1f975e8db9..00cb72615621 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -905,6 +905,7 @@ static bool perf_pmu__match_wildcard(const char *pmu_name, const char *tok)
>  {
>  	const char *p, *suffix;
>  	bool has_hex = false;
> +	bool has_underscore = false;
>  	size_t tok_len = strlen(tok);
>  
>  	/* Check start of pmu_name for equality. */
> @@ -915,13 +916,14 @@ static bool perf_pmu__match_wildcard(const char *pmu_name, const char *tok)
>  	if (*p == 0)
>  		return true;
>  
> -	if (*p == '_') {
> -		++p;
> -		++suffix;
> -	}
> -
> -	/* Ensure we end in a number */
> +	/* Ensure we end in a number or a mix of number and "_". */
>  	while (1) {
> +		if (!has_underscore && (*p == '_')) {
> +			has_underscore = true;
> +			++p;
> +			++suffix;
> +		}
> +

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>  		if (!isxdigit(*p))
>  			return false;
>  		if (!has_hex)
