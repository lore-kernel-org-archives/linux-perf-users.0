Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A11374CB;
	Thu, 11 Jul 2024 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720680409; cv=none; b=T8e+nzl1mmpFW3cZNd+2ERvmMSwyAW0FfLCP7YgXUFmR9UjO9PQ6X1GIs4ds0o2A3f5TQ74Vb6yDrve5Hwd3M8TQqwyLmbE6bw18VbIvE7fQJki/JwCRReYVH4RzVaoMPV+dRQM+muO4RhzPTG3FmKx+Jl8VLEnkUz0fq7x5ljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720680409; c=relaxed/simple;
	bh=H3WYf7DSpPDHp37WEQQm5ToLTT9K/89H9E4cDPzGrkk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=bD9/FioP5ejSOOHIMzGnGDIY/CoU7xuAw/hT+6Ozja6pMT/+Pr7OwRwc6yjkh2pP41+9S7t3BqWM1kDdsvm1Q1gnwLG5IGe2pqvKTukyrJ3Y3n13QoPGX7aYnwfeQsopc7JutQasvIWKvskadvMK8qTzci0MMn55qq0RHRFlwxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGGc6Gc8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGGc6Gc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720680408; x=1752216408;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to:content-transfer-encoding;
  bh=H3WYf7DSpPDHp37WEQQm5ToLTT9K/89H9E4cDPzGrkk=;
  b=mGGc6Gc8wqECmJuPpw7mzM+iRObceMeQ/F3ms0uCJgS2aeS2nV0xYM51
   txciSSVYTY+OAI4i50yc/T003BCZ7ZHW1AMDbmhMzMQd0wSrOzWE24p79
   kfYE7xJl7CikqF4QSCFciRob6UoPxxuzSFS8oDOzKXa0bGhR5K+nnOGkV
   gWHwTZ9UVB+AnzyeF4IXAJ7vrK9/QXtly2tA3ePRnBA2TK2Zucvfb/fE7
   Ost9SgoziNR3NZZGdbeRKdCC/ZTuJYqpLJGIMzyMPQVdV8MKpq+1eDFd0
   zuSY9hQfTVSARhZlAFFpVDdTZp6bqxB578BcbyGdOZRTKySwG8FLlJEXA
   w==;
X-CSE-ConnectionGUID: 1X191ghsQ8OwcYzfJ2imMg==
X-CSE-MsgGUID: jPUWY45VQVqY+ml210FfuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17987090"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="17987090"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 23:46:47 -0700
X-CSE-ConnectionGUID: hDRucU2LRYWXfnDIazw/qg==
X-CSE-MsgGUID: qHDi0sBFQDiCoujPqpkchQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48544178"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 23:46:37 -0700
Message-ID: <b4d28088-3de5-43a5-a4b6-12d3a29244b7@intel.com>
Date: Thu, 11 Jul 2024 09:46:33 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/28] perf auxtrace: Remove dummy tools
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Nick Terrell <terrelln@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240629045350.285243-1-irogers@google.com>
 <20240629045350.285243-2-irogers@google.com>
 <d55916c7-a771-4fae-8bc8-595b7b1e9861@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <d55916c7-a771-4fae-8bc8-595b7b1e9861@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/24 09:43, Adrian Hunter wrote:
> On 29/06/24 07:53, Ian Rogers wrote:
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 0ec92d47373c..44db5b49128f 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -1764,6 +1764,36 @@ int perf_session__deliver_synth_event(struct perf_session *session,
>>  	return machines__deliver_event(&session->machines, evlist, event, sample, tool, 0, NULL);
>>  }
>>  
>> +int perf_session__deliver_synth_attr_event(struct perf_session *session,
>> +					   const struct perf_event_attr *attr,
>> +					   u64 id)
>> +{
>> +	union {
>> +		struct {
>> +			struct perf_record_header_attr attr;
>> +			u64 ids[1];
>> +		} attr_id;
>> +		union perf_event ev;
>> +	} ev = {
>> +		.attr_id = {
>> +			.attr = {
>> +				.header = {
>> +					.type = PERF_RECORD_HEADER_ATTR,
>> +					.size = PERF_ALIGN(sizeof(struct perf_event_attr),
>> +							   sizeof(u64))
>> +					    + sizeof(struct perf_event_header)
>> +					    + sizeof(u64),
>> +				},
>> +			},
>> +			.ids = { id, }
>> +		},
> 
> Nested definitions are not needed.  It can just be:
> 
> 		.attr_id.attr.header.type = PERF_RECORD_HEADER_ATTR,
> 		.attr_id.attr.header.size = sizeof(ev.attr_id),
> 		.attr_id.ids[0] = id,
> 
>> +	};
>> +
>> +	memcpy(&ev.attr_id.attr.attr, attr, min((u32)sizeof(struct perf_event_attr), attr->size));
> 
> It is not unreasonable to validate attr->size, but neither slicing
> nor padding will work.  Better to just return an error:
> 
> 	if (attr->size != sizeof(ev.attr_id.attr))

Or rather

 	if (attr->size != sizeof(ev.attr_id.attr.attr))

> 		return -EINVAL;
> 
> Then:
> 
> 	ev.attr_id.attr.attr = *attr;
> 
> 
>> +	ev.attr_id.attr.attr.size = sizeof(struct perf_event_attr);
>> +	return perf_session__deliver_synth_event(session, &ev.ev, NULL);
>> +}
>> +

