Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428717C79;
	Mon, 27 Jan 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994547; cv=none; b=hnlR1pgg9ZMu3iV28FMw10bvMF8lY1J6tx9a62wLCNslmARg8O30UaRYSo+a9AIoUj/BUcMRKa2hJKLZDrKqdnnEuVamkvpNs/UOf32aDKIpKZoVVLJe9hv0ZeaLg+L99kFGAQPZMnueYTXSbTuhIgKXwONU9vk42eoy051EX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994547; c=relaxed/simple;
	bh=h8xXPEsraKIuM267aWpSXYAPt2KAHLp7sy2oHgoNCvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHQlpsQ3CEFIoYObEgmzIf31OIoyxMZN3W5EVAiqolHIIqzSu96sHpvzJ6cwAwSE7Ysz5C+YOVymaemkYPaKfCQjbcALoYc/0h27USEmkXj81CS8fwbiXX9XbzSilevJZVQJOpd8ovMnVzKI4/a1Rd9afF7vJU6S1T2fyHmQvb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=js3gSvpJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="js3gSvpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737994546; x=1769530546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h8xXPEsraKIuM267aWpSXYAPt2KAHLp7sy2oHgoNCvU=;
  b=js3gSvpJje4j2cscNdQnxiFzGDI1QcfHhy81rU3PM+cSy6/kMfUNGmEg
   di78tIg/U2xyikhcQtsTh/vBE1t1RHeyGGTd/P06SY78jhuzB3flS8Xua
   fl+/64urI9zXlQseY9Qjh4k+4CkTPf/wtg1UiLniR8WWIZtPw9PMsM41C
   pv+fjF1RDxv6Y9qOOw1KG58ayLFE41cW4KQ9SZOwVDgCh0bkW4GMSm9f8
   caBy4P4IeJzBjME8pdDsBq2ouH/u+7GLs1bxJQrnEF1kCMw2pTABX+Ebm
   P6bxbXYptXcjLlajixFBnnW34aaxRpcdePxcJGa5R9lkVZXAZRgK8P0MD
   g==;
X-CSE-ConnectionGUID: Obw6J+7zS5SybO7BnBC6FQ==
X-CSE-MsgGUID: WfKDYQP2QZaHQ1Lq2B7s5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="42216603"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="42216603"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 08:15:45 -0800
X-CSE-ConnectionGUID: KnRExMt3T7qqCdczlikZhw==
X-CSE-MsgGUID: TzYuInXdSZmLFhbo9t6MhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113102905"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 08:15:45 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id CFB8620B5713;
	Mon, 27 Jan 2025 08:15:43 -0800 (PST)
Message-ID: <4436988f-4403-417c-8945-bb8f028ad3aa@linux.intel.com>
Date: Mon, 27 Jan 2025 11:15:42 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 4/4] perf/x86/intel: Support PEBS counters
 snapshotting
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, eranian@google.com,
 dapeng1.mi@linux.intel.com
References: <20250121152303.3128733-1-kan.liang@linux.intel.com>
 <20250121152303.3128733-4-kan.liang@linux.intel.com>
 <20250127155107.GI16742@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250127155107.GI16742@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-27 10:51 a.m., Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 07:23:03AM -0800, kan.liang@linux.intel.com wrote:
> 
>> @@ -471,6 +477,15 @@ struct pebs_xmm {
>>  
>>  #define IBS_CPUID_FEATURES		0x8000001b
>>  
>> +struct pebs_cntr_header {
>> +	u32 cntr;
>> +	u32 fixed;
>> +	u32 metrics;
>> +	u32 reserved;
>> +};
>> +
>> +#define INTEL_CNTR_METRICS		0x3
> 
> I've moved this up a little, so that all the adaptive pebs crud is
> together.
> 

Sure. Thanks!

> Other than that, I've picked up these patches and will merge the lot
> past -rc1.
> 

Thanks!

Kan

