Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50B8634F;
	Tue, 22 Apr 2025 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362256; cv=none; b=S/ZpiEDKI9ETWNw7OrR+D+viR7+OEGv9hnyF6BvdwYryfQQ8SKa8jqyGjkjAtbr20vkIsiUcMKsnWq/aRvJ6qXo2Jt2gZ/NT2nBHPVV9mg9WQR6gxOQ+2WvTSQ6NH2unP5oCD76Ni+edVsYcTcYUlWowdE4G9j/pWgcMySvhxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362256; c=relaxed/simple;
	bh=qic8WDJnyOQBWYfyXO7/q90sRjGRhIGgxtQ3jdqmKoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsN5Rvhn9DiYfojHq7xEYtQmX8ONxr9dVoBASQNL/jMN74iiSnMQp/IhyfZHhxEyKBnCtehPEhUbtsJRulDSdncXQRIF5u/IH12sHaOxHzdvrzgmAFdSYMaV6ICl3M8P/EM/O7s/XeoqUlbAfZHkw9HqTZSrNMDPEEAWa+X0XOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gst9f3o0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gst9f3o0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745362255; x=1776898255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qic8WDJnyOQBWYfyXO7/q90sRjGRhIGgxtQ3jdqmKoI=;
  b=gst9f3o0e7JLwVHy+suQ6sVMjrWWR9qLbDanT7Yaa33kxnyfjV/OQx7p
   TdvfrQ4Uvthl6z2Vy+FUKM79gTYjF/XIfQe9jm1CygFyQMJQYwcUIXBAQ
   CAP7qJuTbU011dDLb6C6twFLaL189PMozPMDIO7E/6xB6bJyfjIN0q5Ed
   FEEbllr+Eijlhhb+K8Y2+Sb48VwGzQ5gQXshfzXKoshpmp33CpOcjxMKH
   lrOqwshZ6/k0LYTAln7mhapfzdVByiuKg7r1zdF0JWAUS93gkOCAdjbbU
   IZ2JrV0dYFRcWzOLtAa/FKAm4sIdSKQRGwwt2u9UvfSRuB8eQr/xr0lSs
   w==;
X-CSE-ConnectionGUID: ltSHvNIJQ26d2PxBQAWWtw==
X-CSE-MsgGUID: eRcrbDC8TcuVdE3KwSPiRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46816880"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="46816880"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 15:50:54 -0700
X-CSE-ConnectionGUID: n7TL10sURoCXgOxgB+IyBA==
X-CSE-MsgGUID: WhMNARUHSzqW4R8DxoGfLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="137006997"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 15:50:54 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0C69220B5736;
	Tue, 22 Apr 2025 15:50:51 -0700 (PDT)
Message-ID: <34bcfac9-86df-42d8-adef-9ccedc3a322a@linux.intel.com>
Date: Tue, 22 Apr 2025 18:50:50 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 12/22] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-13-dapeng1.mi@linux.intel.com>
 <20250415135323.GC4031@noisy.programming.kicks-ass.net>
 <607b1f13-1d5d-4ea7-b0ab-f4c7f4fa319b@linux.intel.com>
 <20250416153226.GC17910@noisy.programming.kicks-ass.net>
 <e0b25b3e-aec0-4c43-9ab2-907186b56c71@linux.intel.com>
 <20250416195610.GC38216@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250416195610.GC38216@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-16 3:56 p.m., Peter Zijlstra wrote:
> On Wed, Apr 16, 2025 at 03:45:24PM -0400, Liang, Kan wrote:
> 
>> I see. I think we can check the constraint table and update the overlap
>> bit accordingly. Similar to what we did in the
>> intel_pmu_check_event_constraints() for the fixed counters.
>>
>> I'm thinking something as below (Just a POC, not tested.)
> 
> I'll try and digest in more detail tomorrow, but having overlap it *not*
> a good thing. Which is why I've always asked to make sure this
> doesn't happen :/
>

I've checked all the existing event_constraints[] tables and features,
e.g., auto counter reload.
On the Lion Cove core, the MEM_TRANS_RETIRED.LOAD_LATENCY_GT event has a
constraint mask of 0x3fc. The counter mask for the auto counter reload
feature is 0xfc. On the Golden Cove, the
MEM_TRANS_RETIRED.LOAD_LATENCY_GT event has a constraint mask of 0xfe.

Other constraints (except the one with weight 1) are 0x3, 0xf, 0xff, and
0x3ff.

But I don't think it can trigger the issue which mentioned in the commit
bc1738f6ee83 ("perf, x86: Fix event scheduler for constraints with
overlapping counters"). Because the scheduler always start from 0. The
non-overlapping bits are always scheduled first.
For example, 0xf and 0x3fc. The events with 0xf (has low weights) must
be scheduled first, which occupy the non-overlapping counter 0 and
counter 1. There is no scheduling problem for the events with 0x3fc then.

I think we are good for the static constraints of the existing platforms.

> At the very least we should WARN if we find the dynamic constraint gets
> us there.
> 
So the problem is only with the dynamic constraint.

It looks like only checking the weight and subset is not enough. (It may
trigger false positive for the 0xf and 0x3fc case.)
I think the last bit of the mask should be taken into account as well.

WEIGHT(A) <= WEIGHT(B) &&
A | B != B &&
LAST_BIT(A) > LAST_BIT(B)

Thanks,Kan
