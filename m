Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAC33DEC0;
	Thu, 30 Jul 2026 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390642; cv=none; b=rDOiXhFfg7iKa6cCBEKufLOQm9rVgUoPD70idPVHpBqYQwiWler5uTourrVbbyKQoRk4uvtowKa4OrDW1bzwojDkGDQj1Hs/nSmT4xHXZ2nXKgCAtq0XXlRRQXB4bhieAlVJEc1+APNXvfLWmrQbfyfJMUM3JNmDrJUHxRLxO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390642; c=relaxed/simple;
	bh=z9/pesGbgdc0TNX+gkQnVawgAw9OF9LneU4R/kjbs8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4RaJxI2Q122PoreJr8qJfg48IqsvDTDNocm9r7QbEujJMfrA2Tp1Y0wJlfPRbw0Puk+4+ZrFUyGG7vp69+qLe2ZgfqNKGR2iLL7ABRTXB7aPE9yIVZCrvWxwCQP5tuwHz+abApCgU33QFxcujpL9olx5SYZc80CF9FECsePimE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOL+lEZ0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOL+lEZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785390641; x=1816926641;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z9/pesGbgdc0TNX+gkQnVawgAw9OF9LneU4R/kjbs8I=;
  b=dOL+lEZ0WLQ4GVsdT67HJpXHO6HyoK9/6uUHUxZM7oNJ9iAFavYJluab
   UItpEK2HRrewQ7VtYTzei6twMeb/EsIJtBJtcze9N2uYboNFufTINAoHd
   Le4/KLbkh6xXsyTkXsd9FabpGzT48qi0IupT/qtDIDQXv4Q/3toEPCsm1
   qwyrx1UCePVGdEEUB+UupP2Gy2KakA353+hpjqXuUaz29YmTamixBB/r7
   E87x9KusG9GltwFK+r00f4tFin6HCLAVR8hAFkWOJPJEs9uVqTtsvlowt
   KF+Z7FGF7jTrh4FTp91iOkFVUhX3NpcoArWSrdlYRk5Y9FfMYPrasHPlk
   A==;
X-CSE-ConnectionGUID: TYzNFpcWS1C9k2pTvUNqyA==
X-CSE-MsgGUID: VWbyL6whS2SubDYtXqQrJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85766048"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85766048"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 22:50:41 -0700
X-CSE-ConnectionGUID: Z2zYNWgxSI2unsX0Mq/gGg==
X-CSE-MsgGUID: vUVUSc5sT66kA1BGQBfilw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="262162198"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.178]) ([10.124.241.178])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 22:50:37 -0700
Message-ID: <f317bf8b-253a-4862-8d72-74507232a1bf@linux.intel.com>
Date: Thu, 30 Jul 2026 13:50:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] perf tools: Show memory region in perf-script
 subcommand
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
 <20260714004359.179451-5-thomas.falcon@intel.com>
 <amjkb_AGLUTB7GAx@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <amjkb_AGLUTB7GAx@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/29/2026 1:18 AM, Namhyung Kim wrote:
> On Mon, Jul 13, 2026 at 07:43:57PM -0500, Thomas Falcon wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Show the memory region in perf-script subcommand. Memory region is found
>> in the mem_region field of the memory information data source. This
>> field was included with the introduction of support for the Off-module
>> Response facility (OMR) [1] in Intel's Diamond Rapids and Nova Lake
>> Architectures.
>>
>> An example of perf-script output with the new memory region field is shown
>> below:
>>
>> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2ec
>> random    2411a68201042 |OP LOAD|LVL RAM hit|SNP Hit|TLB L1 or L2 hit|LCK No|BLK  N/A|Region  Mem-1                          561de7f8910a
>> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
>> random      20e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  Data|Region  N/A                          7f32ae64a2d0
>> random      20e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  Data|Region  N/A                          7f32ae64a2d0
>> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2ec
>> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
>> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
>> random    2411a68201042 |OP LOAD|LVL RAM hit|SNP Hit|TLB L1 or L2 hit|LCK No|BLK  N/A|Region  Mem-1                          561de7f8910a
>> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2ec
>> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
>>
>> [1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
>> ---
>> Changes in v2:
>> -- increased buffers passed to perf_script__meminfo_scnprintf() from 150
>>    to 200 bytes to avoid silent truncation
>> ---
>>  tools/perf/builtin-script.c                   |  8 +--
>>  tools/perf/util/mem-events.c                  | 68 +++++++++++++++++++
>>  .../scripting-engines/trace-event-python.c    |  4 +-
>>  3 files changed, 74 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index f91d8b1fbd01..ba8ec0093f4f 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -2081,8 +2081,8 @@ static int evlist__max_name_len(struct evlist *evlist)
>>  static int data_src__fprintf(u64 data_src, FILE *fp)
>>  {
>>  	struct mem_info *mi = mem_info__new();
>> -	char decode[100];
>> -	char out[100];
>> +	char decode[200];
>> +	char out[200];
>>  	static int maxlen;
>>  	int len;
>>  
>> @@ -2090,10 +2090,10 @@ static int data_src__fprintf(u64 data_src, FILE *fp)
>>  		return -ENOMEM;
>>  
>>  	mem_info__data_src(mi)->val = data_src;
>> -	perf_script__meminfo_scnprintf(decode, 100, mi);
>> +	perf_script__meminfo_scnprintf(decode, 200, mi);
>>  	mem_info__put(mi);
>>  
>> -	len = scnprintf(out, 100, "%16" PRIx64 " %s", data_src, decode);
>> +	len = scnprintf(out, 200, "%16" PRIx64 " %s", data_src, decode);
>>  	if (maxlen < len)
>>  		maxlen = len;
>>  
>> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
>> index 4fd48fd20055..ff08f1fee0e3 100644
>> --- a/tools/perf/util/mem-events.c
>> +++ b/tools/perf/util/mem-events.c
>> @@ -604,6 +604,72 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
>>  	return l;
>>  }
>>  
>> +static int perf_mem__region_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
>> +{
>> +	size_t l = 0;
>> +	u64 mem = PERF_MEM_REGION_NA;
>> +
>> +	sz -= 1; /* -1 for null termination */
>> +	out[0] = '\0';
>> +
>> +	if (mem_info)
>> +		mem = mem_info__const_data_src(mem_info)->mem_region;
>> +
>> +	switch (mem) {
>> +	case PERF_MEM_REGION_NA:
>> +	case PERF_MEM_REGION_RSVD:
>> +		l += scnprintf(out + l, sz - l, " N/A");
>> +		break;
>> +	case PERF_MEM_REGION_L_SHARE:
>> +		l += scnprintf(out + l, sz - l, " Local-shared-cache");
>> +		break;
>> +	case PERF_MEM_REGION_L_NON_SHARE:
>> +		l += scnprintf(out + l, sz - l, " Local-non-shared-cache");
>> +		break;
>> +	case PERF_MEM_REGION_O_IO:
>> +		l += scnprintf(out + l, sz - l, " Other-IO");
>> +		break;
>> +	case PERF_MEM_REGION_O_SHARE:
>> +		l += scnprintf(out + l, sz - l, " Other-shared-cache");
>> +		break;
>> +	case PERF_MEM_REGION_O_NON_SHARE:
>> +		l += scnprintf(out + l, sz - l, " Other-non-shared-cache");
>> +		break;
>> +	case PERF_MEM_REGION_MMIO:
>> +		l += scnprintf(out + l, sz - l, " MMIO");
>> +		break;
>> +	case PERF_MEM_REGION_MEM0:
>> +		l += scnprintf(out + l, sz - l, " Mem-0");
>> +		break;
>> +	case PERF_MEM_REGION_MEM1:
>> +		l += scnprintf(out + l, sz - l, " Mem-1");
>> +		break;
>> +	case PERF_MEM_REGION_MEM2:
>> +		l += scnprintf(out + l, sz - l, " Mem-2");
>> +		break;
>> +	case PERF_MEM_REGION_MEM3:
>> +		l += scnprintf(out + l, sz - l, " Mem-3");
>> +		break;
>> +	case PERF_MEM_REGION_MEM4:
>> +		l += scnprintf(out + l, sz - l, " Mem-4");
>> +		break;
>> +	case PERF_MEM_REGION_MEM5:
>> +		l += scnprintf(out + l, sz - l, " Mem-5");
>> +		break;
>> +	case PERF_MEM_REGION_MEM6:
>> +		l += scnprintf(out + l, sz - l, " Mem-6");
>> +		break;
>> +	case PERF_MEM_REGION_MEM7:
>> +		l += scnprintf(out + l, sz - l, " Mem-7");
>> +		break;
>> +	default:
>> +		l += scnprintf(out + l, sz - l, " N/A");
>> +		break;
>> +	}
>> +
>> +	return l;
>> +}
>> +
>>  int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
>>  {
>>  	int i = 0;
>> @@ -620,6 +686,8 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
>>  	i += perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
>>  	i += scnprintf(out + i, sz - i, "|BLK ");
>>  	i += perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
>> +	i += scnprintf(out + i, sz - i, "|Region ");
>> +	i += perf_mem__region_scnprintf(out + i, sz - i, mem_info);
> Same thing.  Would be nice if it can be conditional.

Sure. Thanks.


>
> Thanks,
> Namhyung
>
>>  
>>  	return i;
>>  }
>> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
>> index 8f832ae316ca..57ec259897e4 100644
>> --- a/tools/perf/util/scripting-engines/trace-event-python.c
>> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
>> @@ -695,7 +695,7 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
>>  				      struct perf_sample *sample)
>>  {
>>  	struct mem_info *mi = mem_info__new();
>> -	char decode[100];
>> +	char decode[200];
>>  
>>  	if (!mi)
>>  		Py_FatalError("couldn't create mem-info");
>> @@ -704,7 +704,7 @@ static void set_sample_datasrc_in_dict(PyObject *dict,
>>  			PyLong_FromUnsignedLongLong(sample->data_src));
>>  
>>  	mem_info__data_src(mi)->val = sample->data_src;
>> -	perf_script__meminfo_scnprintf(decode, 100, mi);
>> +	perf_script__meminfo_scnprintf(decode, 200, mi);
>>  	mem_info__put(mi);
>>  
>>  	pydict_set_item_string_decref(dict, "datasrc_decode",
>> -- 
>> 2.43.0
>>
