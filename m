Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BAD199FD3;
	Wed, 25 Feb 2026 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772000030; cv=none; b=bULIC37CMtCt4v7lVijZYS6ZPtAKUEETjFea/zjFvbf+QQMhC4u0Wes8qz9Ipg0MM7xpyjYPaBWbQ3mgUVm+fzpx0B7MXlqoGV9I+mA48aSE5bJxN8obpEzDeqmo+hBjjv69DoR6r9ge9+CtPIt3FU81QsQWMABWRkLRwL+OMUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772000030; c=relaxed/simple;
	bh=6lNLmkrePdvo8Q+vip9KDyQsl3HNUYsRE0otpP81T1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGLJ3Tp/ZqkQxRqmQh/3gR1tMBmUZi1WCDIVOIT/9JJOWhj7FItOVHshuInDk48R07Hte4BOY5yocpE70y0bco6/dKbsD1vfZppCJVCnjPlpFWYR71bO5KcSmD+piIlxIokejCzxMGLzO0WiTk3RnVqtmsPU//zNXDknS1UWwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+wC8U8b; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+wC8U8b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772000029; x=1803536029;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6lNLmkrePdvo8Q+vip9KDyQsl3HNUYsRE0otpP81T1Q=;
  b=j+wC8U8b+kBCkFmhDaP0gAgvrcxzTGlyWi8ZizR58YRf7azj0hngllxP
   IL16s3x685jpy+b9MRknAiBRIxAjajHPaz4DQAO9Bqdm1aPgY66OHMCsU
   AYdbpWYjDkQJmlG4tbpyU5CmqNBAGyepwvHtSerGrhcOKFPsjHP/D4VT+
   xs6PrqWtangL5eMrzensYN1jBljz0wAmz2eGNu20SSdvfRwX3ed9bL5t1
   D2pNylbiOHJLWmJb94JlaQves2/84pby4c+1SQUohrBQKKfOPFe3C9Q1v
   agqdrvYN22O4TldLpdgZaISLTT1IFhO4U+sPLeHWOGC6K7ooSkXGr4AG3
   w==;
X-CSE-ConnectionGUID: Wojuhc0QQ4aNpAe3lNyHZw==
X-CSE-MsgGUID: FmGiRcyGTHm52ndYgtlnkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73004115"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73004115"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 22:13:49 -0800
X-CSE-ConnectionGUID: jha4cBhkRz+hcAE1GaOVAg==
X-CSE-MsgGUID: SuCiQJ/TRDGmCin15v3wGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="246695310"
Received: from unknown (HELO [10.238.2.129]) ([10.238.2.129])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 22:13:43 -0800
Message-ID: <b61ded40-648b-4e9f-9d6a-88b7656760f9@linux.intel.com>
Date: Wed, 25 Feb 2026 14:13:40 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 10/22] perf/x86: Enable XMM Register Sampling for
 Non-PEBS Events
To: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-11-dapeng1.mi@linux.intel.com>
 <c287e7fb-d504-46fe-b6dc-af28c3532be6@intel.com>
 <e57a249b-ce70-4f5a-86f5-cd86bc477546@linux.intel.com>
 <f48500c5-dfaf-4ca2-9f9d-3d3b1e9f2299@intel.com>
 <a8a35490-994c-498a-acab-478795c868b0@linux.intel.com>
 <e1e05b38-6a7e-4e09-8044-b71e4f6ffb86@intel.com>
 <7f88834b-4ebf-491b-9219-4c1170c15fe4@linux.intel.com>
 <5fed09bf-d20f-41b7-a280-06e4f32ba524@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <5fed09bf-d20f-41b7-a280-06e4f32ba524@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/25/2026 11:14 AM, Chang S. Bae wrote:
> On 2/24/2026 5:36 PM, Mi, Dapeng wrote:
>> E.g., there is the generic x86 event enabling function
>> x86_pmu_enable_event() 
> Again that's in the header file, which looks okay to me.
>
> Now looking at the file, core.c
>
>     get_possible_counter_mask()
>     reserve_pmc_hardware()
>     release_pmc_hardware()
>     set_ext_hw_attr()
>     precise_br_compat()
>     add_nr_metric_event()
>     collect_event()
>     ...
>
> Then all of them violate that naming convention?
>
> There is also another pattern assigning x86_pmu_xxx() to function 
> pointers in struct pmu. Certainly this xsaving function itself isn't the 
> case.

IMO, the functions mentioned above serve as auxiliary functions and are not
directly tied to the core PMU functionalities such as event enabling,
disabling, counting, and sampling... It would be fine to not add the prefix.

Currently, there are no strict naming conventions for functions in perf, so
I can't say which one must be right or better. But at least from my side, I
believe the function x86_pmu_sample_extended_regs() does more than just
wrap a xsaves instruction. It performs the complete sampling process for
extended registers, including parsing the extended register mask, executing
the xsaves instruction, and updating the perf_regs pointers based on the
data obtained from xsaves. Thus, it is not a simple auxiliary function.
Additionally, x86_pmu_sample_xregs() is already concise, and further
shortening seems unnecessary. Thanks.


>
>
>
>
