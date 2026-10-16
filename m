Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D1547041;
	Fri, 16 Oct 2026 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109701; cv=none; b=XZV75PicJE/RhjlDmJVH29DeI3WdLAaJCEoyzqv4/rYoRm3Gs1lXh3BicI9/b6KA6npTCRxUtrIYldkZdETuuPatuNRWD3wY98BQjlT2OP/lbDrSXehuoF06Qd52MUx3CDa/2YODO6xFYFNr+P55WUYiH1NuNDq7YMoiqzMW35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109701; c=relaxed/simple;
	bh=fy69AAMcJX03lii5T+qTQCtH4QPcsQAjuMAkSFSkNyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYrWzc8oHRogZK1l19lsbYfB4HGMMDFrK9gNYHqi6AOqv/MFOG5vEPeem5QcLlTt2GRMHNGxkcR72lRk03QzSUmbBwCojlNXkPV9SSLpzxMDo2+fi3UhZlfIPXQZZI+UcAoYF0mknMgV8+27AvXt00OVIt+bLttj7ElcnnK2ojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNezQp6R; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNezQp6R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792109699; x=1823645699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fy69AAMcJX03lii5T+qTQCtH4QPcsQAjuMAkSFSkNyk=;
  b=FNezQp6ReImjtCetwkjhIWUi56y9oHyZACDOgfIvM3lTB7ReBYMb5mlx
   gvkXeOQRnUY8OY2D2dFpuUrItunl97mVdv58d+ACnS5zEz6jMeNRBxKEI
   yCKpWufAAe5NT3d9etotfO/oCZfajfQ/eKLdmSTJVtLYRHHpdunr37qED
   qhEO14ojChO7oGiuVFIg+wyxTNU8Q3j2Rsc/raSY+UhWT7u48uBKF1j46
   8BAbRr9t9XOlLo3H3zEyKzLvqe759k4FBxqJUbF2yrLJbmwXdUvDERRGK
   Ux+mQ7o98MT/Ab89Vc0KGY4u/SKMOzjTRtTeFXf1Y1kpBMmxrEdIRnk+8
   Q==;
X-CSE-ConnectionGUID: Nrfx2uuNQ2S3P7RaUrnRcg==
X-CSE-MsgGUID: wxJ5fsVuTzqBCSB5fIN9Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="790330"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="790330"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 17:14:58 -0700
X-CSE-ConnectionGUID: 4zmvJ/B9QhaY79nNg1vkfQ==
X-CSE-MsgGUID: ZzcxkFMSQuSTjokrU5rx0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1752012"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 17:14:54 -0700
Message-ID: <df6ef8c1-a283-4ef7-9c49-1265a1b96788@linux.intel.com>
Date: Fri, 16 Oct 2026 08:14:52 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf/x86/intel/lbr: Limit branch snapshots to
 valid entries
To: Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <cover.1792064123.git.sandipan.das@amd.com>
 <7f611dcd599d6d65325d8c40566a1fc35b447ea2.1792064123.git.sandipan.das@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <7f611dcd599d6d65325d8c40566a1fc35b447ea2.1792064123.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 10/15/2026 7:46 PM, Sandipan Das wrote:
> The branch snapshot callback used by bpf_get_branch_snapshot() always
> copies x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr hold
> invalid branches which end up reaching BPF programs.
>
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> intel_pmu_lbr_read() skips reading the registers so that a stale count
> is never reused.
>
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 2 +-
>  arch/x86/events/intel/lbr.c  | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0a34d674df59..5dfb9e9156e8 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
>  	intel_pmu_lbr_read();
> -	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
> +	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
>  
>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>  	intel_pmu_enable_all(0);
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 0b446d8912e4..6b070490f461 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1026,8 +1026,10 @@ void intel_pmu_lbr_read(void)
>  	 * but this simple approach seems to work for now.
>  	 */
>  	if (!cpuc->lbr_users || vlbr_exclude_host() ||
> -	    cpuc->lbr_users == cpuc->lbr_pebs_users)
> +	    cpuc->lbr_users == cpuc->lbr_pebs_users) {
> +		cpuc->lbr_stack.nr = 0;
>  		return;
> +	}
>  
>  	x86_pmu.lbr_read(cpuc);
>  
