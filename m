Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFD26B0A9;
	Fri,  7 Nov 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504625; cv=none; b=QvrSfj8ttfLQqUcx4p6Tz+wiREZGX9hNkNUy3o9FU0805aUNSROVeth8jS+Z1e4gfG2p0I4FdqAmTMB/xrmsnblfQ/e3oTLq2EQVeRd9uAy7wZCfyoH71sJ90X3LytcJ+4GcJ1T28G52VRs6rowuOcS9OJyQNe+YujZz3hc06AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504625; c=relaxed/simple;
	bh=Y3reWQABlAFnYvu/Zcunyq/onxJiQhoWKZERah3Idzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HF6MAqYwi+mvOBiRmWCzq/hX5Kg/wSTHT58TLtD3RioTE+qivg/nQp5h50PYchxgqcqPtRle//gN5oRiAV9eHGq4CFdU4ktnyCQv/yDx6ttXPdc3FfsPQf5FwuqGwRW/8zyUerH/BjvcniMaNydBgmYKfZPdehk5fYVwBm21BK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uu8m0Lr6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uu8m0Lr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762504616; x=1794040616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y3reWQABlAFnYvu/Zcunyq/onxJiQhoWKZERah3Idzk=;
  b=Uu8m0Lr60TQgPTvFO0OMWcVqdm4Z1RYiX0YpYd8B5uIw3/QOxe52jDl1
   o0IQYPob9qI6fY9pNtcCVocKDD6ceWvkKv+5gQ4g+OfGkYRP5ZsJ/zEcp
   f+oTYzHwehTr0PvemXCx99KtSNF+zJHOD7ntmz3QF+dvXBo+LEpA/iO4Y
   B4YxZefR4errvwNqp/XOJ6mn4EGia0LkdckA7L7j9OojbnHYZ9MttfUdH
   CfruvKX4MLe9Z7PE/4d+rK+ml/XCocC9KX5hG+qgCoBzLevzmJM0D91qm
   fIdV/ReOiksLtALedmmvml0cb6LpfvJiBKbjuVZwtoXFRMTdpoqQlamrD
   Q==;
X-CSE-ConnectionGUID: Gei2Sza5TOKireD4rKssCQ==
X-CSE-MsgGUID: ISUPBvJqT6CZZh5lWuCesg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64535860"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="64535860"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 00:36:53 -0800
X-CSE-ConnectionGUID: e7KsLRyETqanf53+R0krBg==
X-CSE-MsgGUID: 77pMSZ+tRD+SLdWPo83SVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="192081216"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 00:36:50 -0800
Message-ID: <0de9c70b-f298-4a9b-9f9c-279115e5d552@linux.intel.com>
Date: Fri, 7 Nov 2025 16:36:47 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 10/12] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
 <20251106145217.GA4067720@noisy.programming.kicks-ass.net>
 <09210c12-cc61-4af5-bd13-830fd9650f9b@linux.intel.com>
 <20251107082845.GB1508773@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251107082845.GB1508773@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/7/2025 4:28 PM, Peter Zijlstra wrote:
> On Fri, Nov 07, 2025 at 02:11:09PM +0800, Mi, Dapeng wrote:
>> On 11/6/2025 10:52 PM, Peter Zijlstra wrote:
>>> On Wed, Oct 29, 2025 at 06:21:34PM +0800, Dapeng Mi wrote:
>>>> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
>>>> sampling and precise distribution PEBS sampling. Thus PEBS constraints
>>>> should be dynamically configured base on these counter and precise
>>>> distribution bitmap instead of defining them statically.
>>>>
>>>> Update event dyn_constraint base on PEBS event precise level.
>>> What happened to this:
>>>
>>>   https://lore.kernel.org/all/e0b25b3e-aec0-4c43-9ab2-907186b56c71@linux.intel.com/
>> About the issue, Kan ever posted a patch to mitigate the risk, but it seems
>> the patch is not merged yet.
>>
>> https://lore.kernel.org/all/20250512175542.2000708-1-kan.liang@linux.intel.com/
>>
> Clearly it became a victim of some scatter brained maintainer or
> something.
>
> Let me stick that near this set and go read the last few patches.

Thanks.


>
