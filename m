Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773E33A9D6;
	Wed, 10 Jun 2026 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056443; cv=none; b=EuiGRI4TkA2fDeCjRc7lBvQofPToL1GoOEapVGCLncVP+V3dl9X2ZzFWfVapHWXuW3r6QxV8l8pmsD6CZt9rtKyF35avKz+c0axO4O2DIVaAvzIa9t+cYkOI+qAbBoq/vczRLyp9hVs7I5W97q4VN9d+xQmTIlFo9BxHxQE5x48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056443; c=relaxed/simple;
	bh=RP+DWHBxkgmSHhy9wallgHqbeQIUU/fLrb1tlReNW9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXSnLDK6TM3zkePRjruY7j+HVJp5JO6rYg1asTpAqyKM+SNqtP1VfreTRcOOoiAcYa2QH9Wwhdv6cuL1bWLn0a6Ngn8BDw/m7jZEP1Q69Io9xpBz2SQ7RulkUsD/SC5uzU6JmOm/mdpdWJxTT8vHZAm8wzLUlEVTAOxo8mb876k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFOlLjSP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFOlLjSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781056439; x=1812592439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RP+DWHBxkgmSHhy9wallgHqbeQIUU/fLrb1tlReNW9c=;
  b=OFOlLjSPHP54zgm1feqMjw7TxvfvpeOTbu7dVyjX3xzsDs2OPzML5HWS
   RSHL+SofeRWY74fCuvUGhDvmUEhDAOZ4rbIAoY05k18T8dPJ2cfOYSI3v
   0a6zs3l3qkRa5ZrXLzkoIPSEZoeWDO07zcbEfp5nAD5FK6g5Q63G3o5KV
   ymqIZ+bmic/0srXRyJ6NjzE9B8OqVaJQk7dUni9R2YNA/bmXXnLp0MSK+
   gqOg5bC87p0eF4HoWjdlBusLc92Wm5/baBQ7ZGNdYB5WRerb5kDqyKmxy
   IvsRMJOR2Ir+cZLeXrsRpVZdfgMbGU+pGlvX2RPtMx56CMjzlumQlcO7G
   w==;
X-CSE-ConnectionGUID: J3Ss/A1XSomYZzRoQ73TYw==
X-CSE-MsgGUID: 5PtbDEwNRZOpLx9h3F/3/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92513620"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="92513620"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 18:53:58 -0700
X-CSE-ConnectionGUID: 7R05J1wBTCiDx4wr8Sy5cg==
X-CSE-MsgGUID: 9qnRQNk0RUWZDT1Ta7ZU9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="243057592"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 18:53:55 -0700
Message-ID: <5e97f9a5-0d8d-41fb-ae8b-302698b76585@linux.intel.com>
Date: Wed, 10 Jun 2026 09:53:53 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 4/9] perf/x86/intel: Fallback to sw branch type
 decoding if no hw decoding
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-5-dapeng1.mi@linux.intel.com>
 <20260609144934.GC49951@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260609144934.GC49951@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/9/2026 10:49 PM, Peter Zijlstra wrote:
> On Tue, Jun 09, 2026 at 01:02:17PM +0800, Dapeng Mi wrote:
>> intel_pmu_lbr_filter() currently assumes Arch LBR provides hardware
>> branch-type decoding and skips software decoding on that path.
>>
>> However, Arch LBR may not always expose branch-type information. In
>> that case, treating entries as hardware-decoded can misclassify sampled
>> branches (for example, defaulting to JCC), which breaks branch-type
>> filtering results.
>>
>> Fix this by using software branch-type decoding when hardware
>> branch-type decoding is unavailable (that is, when x86_lbr_type is not
>> enabled). This keeps branch classification and filtering behavior
>> correct across Arch LBR configurations.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/lbr.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 72f2adcda7c6..d4c0ed85e1fb 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1232,6 +1232,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  		 * OTHER_BRANCH branch type still rely on software decoding.
>>  		 */
>>  		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
>> +		    static_branch_likely(&x86_lbr_type) &&
>>  		    type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
>>  			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>>  			type = arch_lbr_br_type_map[type] | to_plm;
> Now you have two static branches in concert. Best to make sure
> x86_lbr_type covers both conditions, no?

Oh, yes. Actually x86_lbr_type would be enabled only when there is
arch-LBR, so it's unnecessary to check static_cpu_has(X86_FEATURE_ARCH_LBR)
again. static_cpu_has(X86_FEATURE_ARCH_LBR) could be simply removed. Thanks.


>
