Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07C18E02D;
	Tue,  1 Oct 2024 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804801; cv=none; b=GrzeJEfSObvPhjxxZ69lo+s+x6NDkpnUpd1HtEqHYfRW/3a1uHxiIGjcbNSlVBlsSmHbPeWYCZT5d5s5OZTq4j0YGougPWYsQxFHX3TFK8Ge3xTi0DkeTkZ8Bos1GX8uknmRznhiFKoiqZ/gxQ7doPXv0I0P+B6rXtceIbvZ2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804801; c=relaxed/simple;
	bh=T6trZJfBiEDS+ZszJkYw3ahfzsuPP5VMB/kadisx6Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZceA+6qsp3kx2j38C7rtU5FpZSEY2NzL8WcBIe1gDyDlvuQ7rpmht+X2SnWAD8d11uwY85OZeUXKSxFKlb0yRHIUw5i4dCZFJnjNPCYdkQPLjYYkHSbWY/k4LLHlCt0gRgvr/mh3KTSWwCYTOBmZzeHOSPul300w6zKajAzq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqQ39cBb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqQ39cBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727804800; x=1759340800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T6trZJfBiEDS+ZszJkYw3ahfzsuPP5VMB/kadisx6Bk=;
  b=QqQ39cBbBJhKj//d/Rp/7UpMKJn9/IAqBRfgAvzb4ffXn+ECTTXBwh/2
   6cZttupg1d6ErEZz0bWyA1/ee5XxGbrlbJn9dE99h2XflcCjvfs6/IFg2
   q8KRo4YFrEDqnKmChI+r6CfJC6bZTum+neTOlAWDgS2f/q8BU+uavoOCm
   w5E2/wmUMwWUGL7BE5Oh2RQJ9IDxbUMn9Sw2gcdZeTV/Uv4od59NpUiRd
   AAgxne5WP3g5hlZFfrX3ngZTKZjgQZOEso+i75WpHMFabYk1bFrSDO/SD
   2n8zWBOX77EPbVOvf4vBIG7rmWy7VFwsf945D4z8fP2zyTznh7xue+WmX
   w==;
X-CSE-ConnectionGUID: ClKocgptTZiIOI82sFw7LA==
X-CSE-MsgGUID: 8LQplLRDTjuVk4bFa7Y7lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="44416088"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="44416088"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:46:40 -0700
X-CSE-ConnectionGUID: HiT/HKmARS+2oeuE2QCagg==
X-CSE-MsgGUID: wXUeLJ5uTs2M8rdrXGD2Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="78492928"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:46:40 -0700
Received: from [10.212.71.24] (kliang2-mobl1.ccr.corp.intel.com [10.212.71.24])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8618420B8DDA;
	Tue,  1 Oct 2024 10:46:37 -0700 (PDT)
Message-ID: <4ce19789-eea1-4e5e-9269-13bd78d846c2@linux.intel.com>
Date: Tue, 1 Oct 2024 13:46:36 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 0/8] perf tools: Do not set attr.exclude_guest by
 default (v4)
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241001002027.1272889-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-30 8:20 p.m., Namhyung Kim wrote:
> Hello,
> 
> I found perf tools set exclude_guest bit inconsistently.  It used to
> set the bit but now the default event for perf record doesn't.  So I'm
> wondering why we want the bit in the first place.
> 
> Actually it's not good for PMUs don't support any exclusion like AMD
> IBS because it disables new features after the exclude_guest due to
> the missing feature detection logic.
> 
> v4 changes)
> 
>  * handle EOPNOTSUPP error in compatible way  (Kan)
>  * drop --exclude-guest option in perf stat
>  * not to separate exclude_hv fallback
>  * rename to exclude_GH_default  (Kan)
>  * drop the RFC from the subject
> 
> v3) https://lore.kernel.org/lkml/20240905202426.2690105-1-namhyung@kernel.org/
> 
>  * move exclude_guest fallback to the front
>  * fix precise_max handling on AMD
>  * simplify the default event for perf record
> 
> v2) https://lore.kernel.org/lkml/20240904064131.2377873-1-namhyung@kernel.org/
> 
>  * update the missing feature detection logic
>  * separate exclude_hv fallback
>  * add new fallback for exclude_guest
> 
> v1) https://lore.kernel.org/lkml/20240902014621.2002343-1-namhyung@kernel.org/
> 
> AFAIK it doesn't matter for the most cases but perf kvm.  If users
> need to set the bit, they can still use :H modifier.  For vPMU pass-
> through or Apple M1, it'd add the exclude_guest during the fallback
> logic.
> 
> Also the kernel feature detection logic should be separated from the
> exclude bit tests since it depends on the PMU implementation rather
> than the core kernel features.  So I changed it to use a software
> event for the detection and factor out some hw-specific checks.
> 
> The code is available at 'perf/exclude-v4' branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (8):
>   perf tools: Add fallback for exclude_guest
>   perf tools: Don't set attr.exclude_guest by default
>   perf tools: Simplify evsel__add_modifier()
>   perf tools: Do not set exclude_guest for precise_ip
>   perf tools: Detect missing kernel features properly
>   perf tools: Move x86__is_amd_cpu() to util/env.c
>   perf tools: Check fallback error and order
>   perf record: Just use "cycles:P" as the default event
> 

The patch set looks good to me.

Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>  tools/perf/arch/x86/util/Build              |   1 -
>  tools/perf/arch/x86/util/env.c              |  19 -
>  tools/perf/arch/x86/util/env.h              |   7 -
>  tools/perf/arch/x86/util/pmu.c              |   2 +-
>  tools/perf/builtin-kvm.c                    |   1 +
>  tools/perf/builtin-record.c                 |   4 +-
>  tools/perf/builtin-stat.c                   |  18 +-
>  tools/perf/dlfilters/dlfilter-test-api-v0.c |   2 +-
>  tools/perf/dlfilters/dlfilter-test-api-v2.c |   2 +-
>  tools/perf/tests/attr/test-record-dummy-C0  |   2 +-
>  tools/perf/tests/parse-events.c             |  30 +-
>  tools/perf/util/env.c                       |  24 ++
>  tools/perf/util/env.h                       |   4 +
>  tools/perf/util/evsel.c                     | 394 ++++++++++++++------
>  tools/perf/util/evsel.h                     |   1 -
>  tools/perf/util/parse-events.c              |   6 +-
>  tools/perf/util/util.c                      |  10 +-
>  tools/perf/util/util.h                      |   3 +
>  18 files changed, 364 insertions(+), 166 deletions(-)
>  delete mode 100644 tools/perf/arch/x86/util/env.c
>  delete mode 100644 tools/perf/arch/x86/util/env.h
> 
