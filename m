Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF112E6C
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Nov 2023 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCtdGlbW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3CBED;
	Tue,  7 Nov 2023 02:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699352195; x=1730888195;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eGwALYACwi9GTa9+cK3u9YrctMaWgutJvGUdFWLOeoM=;
  b=oCtdGlbWgpB+zHNJA3xUJBHzB5oANaJsCBAJ4HT39R3y+xTKM7cz0spF
   70784zt+l8b4ugdT973WcUPLx1BPaSnVfRhFgcI6clBuxGk/hiWKGYlp2
   +3LVBPHFiLvgxc4PO+X54tWgYM4qremymxZaYovBBcIC4DbBedEpkxmTw
   oW/4+VKlEYpaT3vEa4f8omuIroErG6hztk9M9dEM5/ArTdATRmNsRy466
   R7LhdOxkjwqnqiQhEb0mZJJ9JIVVUbRk0gk4sqbgSbffP2ji4xMcESeFQ
   +TDkoWaMnfwC/KGuNIlcs9p36ywZHuB8nLud1BQXbRt0Dx0lgqOfQGGSi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="11016595"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="11016595"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 02:16:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="886243075"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="886243075"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.31])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 02:16:30 -0800
Message-ID: <6fc8bc4c-abc3-45d5-a8c8-045f91adfebf@intel.com>
Date: Tue, 7 Nov 2023 12:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf auxtrace: Add 'T' itrace option for timestamp
 trace
Content-Language: en-US
To: Leo Yan <leo.yan@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 James Clark <james.clark@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231014074513.1668000-1-leo.yan@linaro.org>
 <20231014074513.1668000-2-leo.yan@linaro.org>
 <8a2ea58f-f835-4d1a-8bd6-3a63b3b0db94@intel.com>
 <ZUlgM8pgf19UeyM9@kernel.org>
 <2940af18-8bcd-4456-a8ed-e77cade1b160@intel.com>
 <20231107094852.GA656098@leoy-yangtze.lan>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231107094852.GA656098@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/23 11:48, Leo Yan wrote:
> Hi Adrian,
> 
> On Tue, Nov 07, 2023 at 09:19:10AM +0200, Adrian Hunter wrote:
>> On 6/11/23 23:52, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, Oct 19, 2023 at 01:47:15PM +0300, Adrian Hunter escreveu:
>>>> On 14/10/23 10:45, Leo Yan wrote:
>>>>> An AUX trace can contain timestamp, but in some situations, the hardware
>>>>> trace module (e.g. Arm CoreSight) cannot decide the traced timestamp is
>>>>> the same source with CPU's time, thus the decoder can not use the
>>>>> timestamp trace for samples.
>>>>>
>>>>> This patch introduces 'T' itrace option. If users know the platforms
>>>>
>>>> "If users know" <- how would users know?  Could the kernel
>>>> or tools also figure it out?
>>>
>>> Adrian, I'm trying to go all the outstanding patches, do you still have
>>> any issues with this series?
>>
>> No, although the question wasn't actually answered.  I presume users
>> just have to try the 'T' option and see if it helps.
> 
> Sometimes, users are software developers in SoC companies, they can
> know well for the hardware design but are confused why current
> implementation cannot use timestamp trace.  This is the main reason
> I sent this patch set.
> 
> An example hardware platform is DB410c [1], we know its CoreSight can
> support timestamp trace, but if without this adding option 'T', we
> have no chance to use it due to it its CPU arch is prior to Armv8.4.

perf config might be better than an itrace option, but you decide.

> 
> @Arnaldo, since James gave comments in his replying, I will respin new
> patch set and send out.  Thanks for popping up this patch set!
> 
> Leo
> 
> [1] https://developer.qualcomm.com/hardware/dragonboard-410c

