Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928332B113;
	Thu, 30 Jul 2026 05:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390400; cv=none; b=bU6SBrJuKr671g+8Lvs7C/5VeLEuXttRRNyhFfJRlwD+SSVjs95ItO+w7q2Iigq25eTAuhbEsnVUwJ7/PIsbW01lFoMrCC/Ju90I2MK0q/+dThHmT+WjZEyjYdmPOEG3UEVwex5gueERlJpJwcM9Nm6NLU5IhY/ZtHyGdt4JQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390400; c=relaxed/simple;
	bh=Jp6KjHcdsGGOOgnblzB2KOu4ipmWaTf75SWs6G2RWqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maJrGU9nbSjikhYFWyH6mOUkrgeQG1Jh/b5Cqs2lj79Zf8Q6KBxlr3jM7vExOzwkj6R9IMKofojc8lrCGdbk+Xv0WiLrFypb8IdlaDGVpGXuSVrXngKrbxoRZ1KLY0dmQw/m7iXpCX2hUwji+tCNr4BppjGI7StmAQ2BXahV3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgBpwk/V; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgBpwk/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785390398; x=1816926398;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jp6KjHcdsGGOOgnblzB2KOu4ipmWaTf75SWs6G2RWqY=;
  b=JgBpwk/VpSXnQIbXHC3SQh/svJ+46BBDZ+z9QYi/dqokvTxPH4a6ZJk1
   glT8OrTbpnVBKhlAFzfj6YPi7e8rpivuKdgjK3EM3CJnu03ZndIDKYpsg
   rHS+JorPxViqzd9+uqsVT9ZGqSQEZDUq7+1TjN3YEEqSXyu9Z7hblkxT3
   Q4APwYwiydLRABPbAB+WL69P9dacHWxJhtb8AtN7UVNz4BK0tTJYmTCoS
   4/z0UTKSTDrWs0EfF3h6vduK63qqL7CWzf83IhcIB5ECdkq06BBfAOL9F
   1gO5YuFpgOe27sTv4Du3XcHcKuKMf9h8+rtY/pQT/zeaTDb1dOTgjKiZR
   Q==;
X-CSE-ConnectionGUID: eJ0eFYzoQpejCBEiWkOU+Q==
X-CSE-MsgGUID: Rp7IWr36STGiHXmAt1LJQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86019220"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="86019220"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 22:46:33 -0700
X-CSE-ConnectionGUID: jiDFBmQCRVGjvQs6RqxYEQ==
X-CSE-MsgGUID: eF3IkpqiSvuzWlwF7ylKkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="258424948"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.178]) ([10.124.241.178])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 22:46:30 -0700
Message-ID: <8829286c-c05c-456d-82ad-6e75ab864f1d@linux.intel.com>
Date: Thu, 30 Jul 2026 13:46:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] perf mem: Add support for printing
 PERF_MEM_LVLNUM_L0
To: Namhyung Kim <namhyung@kernel.org>,
 Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-3-thomas.falcon@intel.com>
 <amjjSlWIQRA64qSy@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <amjjSlWIQRA64qSy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/29/2026 1:13 AM, Namhyung Kim wrote:
> Hello,
>
> On Mon, Jul 13, 2026 at 07:43:55PM -0500, Thomas Falcon wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Add support for printing PERF_MEM_LVLNUM_L0 in perf mem report.
> What's the L0, by the way?

Per my understanding, the L0 cache is newly added a small piece of cache
which is the closest, lowest-latency memory cache tied directly to the
execution pipeline. 

The table "Table 9-4. Data Source Field Encodings for Panther Cove and
Coyote Cove Microarchitectures" in the ISE doc chapter "9.2.1 Panther Cove
and Coyote Cove Microarchitectures Memory Auxiliary Field Layout" indicates
the code "01H" means the "L0 Hit - Minimal latency core cache hit. This
request was satisfied by the L0 data cache."

https://www.intel.com/content/www/us/en/content-details/922690/intel-architecture-instruction-set-extensions-programming-reference.html 


>
> Thanks,
> Namhyung
>
>> Assisted-by: Sashiko:gemini-3.1-pro-preview
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
>> ---
>>  tools/perf/Documentation/perf-record.txt | 2 +-
>>  tools/perf/util/bpf-filter.l             | 1 +
>>  tools/perf/util/mem-events.c             | 5 +++++
>>  tools/perf/util/mem-events.h             | 1 +
>>  4 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index 178f483140ed..b54032efe41c 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -212,7 +212,7 @@ OPTIONS
>>  	The <value> can be one of:
>>  	  <number> (for any term)
>>  	  na, load, store, pfetch, exec (for mem_op)
>> -	  l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
>> +	  l0, l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
>>  	  na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
>>  	  remote (for mem_remote)
>>  	  na, locked (for mem_locked)
>> diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
>> index 6aa65ade3385..1be9df6550fc 100644
>> --- a/tools/perf/util/bpf-filter.l
>> +++ b/tools/perf/util/bpf-filter.l
>> @@ -131,6 +131,7 @@ store		{ return constant(PERF_MEM_OP_STORE); }
>>  pfetch		{ return constant(PERF_MEM_OP_PFETCH); }
>>  exec		{ return constant(PERF_MEM_OP_EXEC); }
>>  
>> +l0		{ return constant(PERF_MEM_LVLNUM_L0); }
>>  l1		{ return constant(PERF_MEM_LVLNUM_L1); }
>>  l2		{ return constant(PERF_MEM_LVLNUM_L2); }
>>  l3		{ return constant(PERF_MEM_LVLNUM_L3); }
>> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
>> index 4e490f9cd348..4fd48fd20055 100644
>> --- a/tools/perf/util/mem-events.c
>> +++ b/tools/perf/util/mem-events.c
>> @@ -391,6 +391,7 @@ static const char * const mem_lvlnum[] = {
>>  	[PERF_MEM_LVLNUM_L4] = "L4",
>>  	[PERF_MEM_LVLNUM_L2_MHB] = "L2 MHB",
>>  	[PERF_MEM_LVLNUM_MSC] = "Memory-side Cache",
>> +	[PERF_MEM_LVLNUM_L0] = "L0",
>>  	[PERF_MEM_LVLNUM_UNC] = "Uncached",
>>  	[PERF_MEM_LVLNUM_CXL] = "CXL",
>>  	[PERF_MEM_LVLNUM_IO] = "I/O",
>> @@ -831,6 +832,8 @@ int mem_stat_index(const enum mem_stat_type mst, const u64 val)
>>  		}
>>  	case PERF_MEM_STAT_CACHE:
>>  		switch (src.mem_lvl_num) {
>> +		case PERF_MEM_LVLNUM_L0:
>> +			return MEM_STAT_CACHE_L0;
>>  		case PERF_MEM_LVLNUM_L1:
>>  			return MEM_STAT_CACHE_L1;
>>  		case PERF_MEM_LVLNUM_L2:
>> @@ -915,6 +918,8 @@ const char *mem_stat_name(const enum mem_stat_type mst, const int idx)
>>  		}
>>  	case PERF_MEM_STAT_CACHE:
>>  		switch (idx) {
>> +		case MEM_STAT_CACHE_L0:
>> +			return "L0";
>>  		case MEM_STAT_CACHE_L1:
>>  			return "L1";
>>  		case MEM_STAT_CACHE_L2:
>> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
>> index 5b98076904b0..daa22748f9fe 100644
>> --- a/tools/perf/util/mem-events.h
>> +++ b/tools/perf/util/mem-events.h
>> @@ -109,6 +109,7 @@ enum mem_stat_op {
>>  };
>>  
>>  enum mem_stat_cache {
>> +	MEM_STAT_CACHE_L0,
>>  	MEM_STAT_CACHE_L1,
>>  	MEM_STAT_CACHE_L2,
>>  	MEM_STAT_CACHE_L3,
>> -- 
>> 2.43.0
>>
