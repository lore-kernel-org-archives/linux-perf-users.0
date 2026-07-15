Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130030C366;
	Wed, 15 Jul 2026 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100436; cv=none; b=KhdbE/qzTJnn1T8/cWvHrp4Wk1aJ0aBICJEncQloYb2zDNeOhwS9zAXpD1FFC0XQ/k8Ykxwa4+pEiqteJrP9BGvUt9qmGrDEvbOFuKAor3P4GEMYIfVViyizMVdlnSEn36fYb0q+FSr18qhMnsjminZKoEMgzK2h3lDfS82wJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100436; c=relaxed/simple;
	bh=GMiPxQhSMy8OY3/2b/6v2R33Zqdua6jnfdrz6S6J/rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rY4zumOhzwLAcU1MwrQYmoVUXfE1ExrHR0RbTRkZUMDlE7sceBIuCJb2aoOZmep4QcJ6+xcMMQHcjMo9VTEO9VIXCo7U9/Tf570OtZLfv7JaQPqh3fRfFc1pNdI4ivZPqmVMo/H+7Si1tCKZ603UMsXh3Ti2sFQpmSnUGWFzS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFpKEI8N; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFpKEI8N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784100433; x=1815636433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GMiPxQhSMy8OY3/2b/6v2R33Zqdua6jnfdrz6S6J/rw=;
  b=IFpKEI8NfB7VED1klaRkZuDzGBACEEBRJYpfJXF0dVA35tUiPySs5gAX
   Ui/0ESazGmntfMZRIblL0Le4QQu8i7msylkxUFTW3RGOi9PKqGjmIwGrk
   luSZCftJIz8obvtJQhy7Dhpqm1QYOZAqbSfw78nmIYZWglaYXoDnGNICZ
   zJ7TgiQGUMXAJ/0G+BRGQpETHWwX8i5f0josddXW1VE5kAP0qNhpHe+xl
   lzRPO6vJF73cMDWzZYnxytq6Xk8qx+BkVQvYG8E0m2kN5rhmYpNjl8Wqt
   Yq0Pyvg8bZyNImTosD5o2VIgzqXyY8YrkpIGwHTZAiB8aFGBfnMfbULwK
   g==;
X-CSE-ConnectionGUID: aHFzVgPnT3emfKrLPmtAMA==
X-CSE-MsgGUID: Zm1oAgYBS4GVNtF5JWFvXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96095623"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="96095623"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:27:11 -0700
X-CSE-ConnectionGUID: 4BPwMo5eRsCY5fAcXqZ6cQ==
X-CSE-MsgGUID: 9392uglRQwipTL9T3PZSRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="253476222"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:27:09 -0700
Message-ID: <8fc9e992-ae58-4354-9b21-6c5ac02824ee@linux.intel.com>
Date: Wed, 15 Jul 2026 15:27:06 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 0/7] perf/x86: Miscellaneous PMU bug fixes and
 optimizations
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Not sure if you have bandwidth to review the patch-set? This patchset fixes
some recently found issues by Sashiko. Most of issues are error handling
related. Thanks.


On 7/13/2026 4:27 PM, Dapeng Mi wrote:
> Changes since v1:
> - Patch 3/7: Ensure cpuc->pmu is not the static pmu before calling
>   hybrid_pmu(cpuc->pmu) in intel_pmu_cpu_dead() (Sashiko).
>
> This series fixes recently found x86 core PMU bugs. Most of bugs are
> found by Sashiko in reviewing the "Support SIMD/eGPRs/SSP registers 
> sampling for perf" patch-set, e.g.,
> https://lore.kernel.org/all/20260706022123.480411F000E9@smtp.kernel.org/
> https://lore.kernel.org/all/20260706021852.DE2ED1F000E9@smtp.kernel.org/
>
> The last patch 7/7 optimizes ACR handling in match_prev_assignment() and
> mitigate the performance overhead.
>
> Tests:
> Below test cases are run on Diamonds and Novalake. No issues are found.
> - Perf stat test
>   $ perf test 119
> - Perf record tests 
>   $ perf test 155
> - Perf record LBR tests
>   $ perf test 156
>
> History:
> v1: https://lore.kernel.org/all/20260710065128.1799838-1-dapeng1.mi@linux.intel.com/
>
> Dapeng Mi (7):
>   perf/x86: Unregister PMI handler on PMU init failure
>   perf/x86: Free hybrid state on PMU init failure
>   perf/x86: Guard intel_pmu_cpu_dead() against invalid hybrid PMU casts
>   perf/x86/intel: Unwind cpuc state if PEBS buffer setup fails
>   perf/x86: Remove stale fixed counter helper and fix hybrid PMU access
>   perf/x86/intel: Fix intel_cap handling on hybrid PMUs
>   perf/x86: Optimize ACR handling in match_prev_assignment()
>
>  arch/x86/events/core.c       | 45 +++++++++++++++++++-------
>  arch/x86/events/intel/core.c | 61 ++++++++++++++++++++++++++----------
>  arch/x86/events/perf_event.h | 12 ++-----
>  3 files changed, 81 insertions(+), 37 deletions(-)
>
>
> base-commit: edda9051e267b7390c7ce24b1b71434414ad156e
