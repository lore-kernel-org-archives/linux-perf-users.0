Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAC2A8D0;
	Thu,  6 Feb 2025 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805540; cv=none; b=ta9AQzQEF3cGzRqIFzpi42sZYJhgDPU3UDDerpbaJhVNy/392aKdDbNtNN86jHEx1sXlnw9wd0Q6tSyB0drdRhEiSwEOv5LTN7WS92LgFE8+voJHD1sE/mwJJES99mArm42urqt0UcaSevTcRuudciBp0xhaiKp22xFhOGU45NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805540; c=relaxed/simple;
	bh=SZUfLrOq5zFNJDq8tAihCiFfZ15937c+cni40sXRVgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWi171AfvYbUa4KotEYdxS/cRQy4WsCLhMY5yzJXFUwIiAzQ7xLvHtC7x/BrsvfnIOV3Pw0gC3NfcDoLG9/orB1Kuqur6CPYSJUPQebZBTijywZ3TruI3tqu94malFsaX6izH4OFGk+n2+5tr0H/nhyHnBdP8fVFIqQWG79VDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbjJQVjz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbjJQVjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738805538; x=1770341538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SZUfLrOq5zFNJDq8tAihCiFfZ15937c+cni40sXRVgQ=;
  b=nbjJQVjzTV/YJQBYEIETYAV9RZ8/n2GNHxGprIEvrwdEfH5tu+B1SODv
   38Xeuls3eaZTMI/WMVLD8DoDVzwUL+gcwcAQBktow8+pe+hNUOsu0G1CV
   43fO2Kh07n4/GpFOn77SCP3Miv52BhVa5lkig+bL8N8pgPOxpNWq7l/L8
   8X+f2nUKtvglmkd2OHLBve6UF5t+P2XjyH4JUIJ3riqln73PnFVAPB3tW
   6SGtNVUysa6yKn74xweNh5GgG4oqBwaNA7w5dlmkdMrmzx3q/VExM4jX0
   qB0y0Mw1XUBsGh+2pBgYQRr76UBIDNvCeBY3GGq0bIO6Cz5ZSaHMgbEI1
   g==;
X-CSE-ConnectionGUID: dTo1V/vtRKynkuYib3uWkA==
X-CSE-MsgGUID: AECJC0WRTkiOcCLeHz55NQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="26996302"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="26996302"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 17:32:16 -0800
X-CSE-ConnectionGUID: qzTUOincTQuh3bw99CXjRg==
X-CSE-MsgGUID: P6M9K01nSLqfWcroKRzTNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116258824"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 17:32:06 -0800
Message-ID: <d31dcd21-7455-4108-96d7-e29ecde1c5de@linux.intel.com>
Date: Thu, 6 Feb 2025 09:31:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] perf/x86/intel: Add PMU support for Clearwater
 Forest
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-2-dapeng1.mi@linux.intel.com>
 <20250127162651.GL16742@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250127162651.GL16742@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/28/2025 12:26 AM, Peter Zijlstra wrote:
> On Thu, Jan 23, 2025 at 02:07:02PM +0000, Dapeng Mi wrote:
>> From PMU's perspective, Clearwater Forest is similar to the previous
>> generation Sierra Forest.
>>
>> The key differences are the ARCH PEBS feature and the new added 3 fixed
>> counters for topdown L1 metrics events.
>>
>> The ARCH PEBS is supported in the following patches. This patch provides
>> support for basic perfmon features and 3 new added fixed counters.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index b140c1473a9d..5e8521a54474 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2220,6 +2220,18 @@ static struct extra_reg intel_cmt_extra_regs[] __read_mostly = {
>>  	EVENT_EXTRA_END
>>  };
>>  
>> +EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_skt,        "event=0x9c,umask=0x01");
>> +EVENT_ATTR_STR(topdown-retiring,       td_retiring_skt,        "event=0xc2,umask=0x02");
>> +EVENT_ATTR_STR(topdown-be-bound,       td_be_bound_skt,        "event=0xa4,umask=0x02");
>> +
>> +static struct attribute *skt_events_attrs[] = {
>> +	EVENT_PTR(td_fe_bound_skt),
>> +	EVENT_PTR(td_retiring_skt),
>> +	EVENT_PTR(td_bad_spec_cmt),
>> +	EVENT_PTR(td_be_bound_skt),
>> +	NULL,
>> +};
> The skt here is skymont, which is what Sierra Forest was based on, and
> you just said that these counters are new with Darkmont, and as such the
> lot should be called: dmt or whatever the proper trigraph is.

Sorry for late response since the Chinese new year holiday.

Sierra Forest is based on Crestmont instead of Skymont. The 3 new fixed
counters are introduced from Skymont and Darkmont inherits them. So these
attributes are named with "skt" suffix.


>
