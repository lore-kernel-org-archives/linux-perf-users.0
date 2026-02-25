Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0718B0A;
	Wed, 25 Feb 2026 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983373; cv=none; b=PqTVjqjdIRlfh1h7sn6ZU2OPtHJbpUjK8364S1N/ZtWSC2ykc/5vr1SEy7Xkxyw/2s7RAwx43xrKgawm8sQdFeXGcudW3dIqJv5JV2OBS8sVTU84EM4Ehp9VndahXO5gWIImclvqRI7OzeVaT5ZTOe+Y/Z5CZaGE3Q1kRVrvWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983373; c=relaxed/simple;
	bh=zAxmeooDtILAAAcCO1049WTmnrjerCDfIOrM4c2AbSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEnVEwQk++ldYEkHV2py4Cf0jr9WeabQ6Ieyb3Rsm+DNfspsTWjW+HYoczIILnBmRW1PYUmbJgtijgan9wKSHnxFvxkA4okEbwupGHmgHuE5Jt9wef9RKl43iyUwlMz4YYw/W/G8qtcXmwtjqMSHXoPmGkTqPt+MPq0xZtsGW+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJtzCkQy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJtzCkQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771983372; x=1803519372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zAxmeooDtILAAAcCO1049WTmnrjerCDfIOrM4c2AbSg=;
  b=cJtzCkQyWeb2DA7aaKGDykUyJT7+c41HTuAJbNYWycgoO7r4MPSSrkTm
   w44FDLLvk+SVrmNEugRe7vzjCl2pYxA+oQG1GrJkzD8M+j/OE1T9PzX3W
   Q/OG0Q5vTeuBhIwNqFLwtOmq2/etD7nNVvknTBYpz5UROZAzMR7RkW7Ta
   O1qvHriGk0Tk4qPoMcDiMW+wgHusadH5a8zlLEiiqnHqkOvh/BP3AQOCQ
   FYylwKiVBDFm5e9szJsMMTFvv7Y31ikT/rwPGR1mIPUDNZm5YlLkY1wwh
   pSMVwLBOllogaedPmLC3ELBIpzkLb7rX9F9Y7v7q7pcQOTD7mc0oHjMbx
   Q==;
X-CSE-ConnectionGUID: aifM7X6ERq6+4dCeKLYBiw==
X-CSE-MsgGUID: CTplKv6iTZy2ySFQuC49yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="76622050"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="76622050"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 17:36:11 -0800
X-CSE-ConnectionGUID: 0jaWxL3MS5yOi7bXV0t9KQ==
X-CSE-MsgGUID: thX0U+gKSsWtpBnR0S19/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="215963689"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 17:36:05 -0800
Message-ID: <7f88834b-4ebf-491b-9219-4c1170c15fe4@linux.intel.com>
Date: Wed, 25 Feb 2026 09:36:02 +0800
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <e1e05b38-6a7e-4e09-8044-b71e4f6ffb86@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/25/2026 9:11 AM, Chang S. Bae wrote:
> On 2/24/2026 4:55 PM, Mi, Dapeng wrote:
>> Thanks, 'xregs' is a good word. But considering current naming convention
>> in arch/x86/events/core.c, I would add the "x86_pmu" prefix
> Do you know or can explain the purpose of that prefix on every function 
> there? Is it for 'git grep x86_pmu'? But that's probably useful for 
> those in a header file. Looks like just make it longer without good reason.

Per my understanding, the naming prefix "x86_pmu" is to emphasize the
function is a x86-arch generic function instead of a vendor specific PMU
function, like intel_pmu_* or amd_pmu_*, or other architectural PMU functions. 

E.g., there is the generic x86 event enabling function
x86_pmu_enable_event() and the vendor specific event enabling functions,
intel_pmu_enable_event()/amd_pmu_enable_event() in current perf code.

Thanks.

>
