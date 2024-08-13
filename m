Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920836139;
	Tue, 13 Aug 2024 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533316; cv=none; b=UnntgHX4aO7LaBccze50zrjhllP7ZuORGiz1qfhwAQ/8P7YJq65D1aZ2TCW2M31xtiGghacri7ff6qrUuRMH7Rft38CxjUhz2ABSozc4N/hL/pCSmWSITizOs/qUJaHZxgiEyMrNx7JByIHS0Qzn2jOzTsX4Xio081rkQddgT4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533316; c=relaxed/simple;
	bh=X/xieVPZ2l99Uch5sSt1ctN8MsSmmC32xUKWmhNdcow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ci/OfuF9VJil11uLoxFEwy7UY8aWkLRze08HmlXnvQttA99ddneExDw7gex9Spj7I2pyb71do2nG+96CTKRSDF5QDXtEcgpnB9kKiisdCloH4j/40vEWHbXDu6QVgFcsrc5mC3N28WRssM2+NnPBcpgHpZbbOHijT4ow+1JyMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brcKfHBH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brcKfHBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723533314; x=1755069314;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X/xieVPZ2l99Uch5sSt1ctN8MsSmmC32xUKWmhNdcow=;
  b=brcKfHBHDAoZRtq2JoEVfSrt8dRnSHNVa+Qat9Sd7dXR8J7etgv1gloI
   LKKmSA9UvgZCSphOCsOEqqXuhUCFhRwKnMeVg83cIRVlkXocLYKVIcvms
   q/U2P/c26MWTWoZ2GvQ+KBcgY9FNf133rkbzY4fI33K9zEr2k92yPfTRt
   MUH60iWCHR2ze7Ws3XhkOI/YTyrX9Hi/W295hGevtaqeCa9pk01Hq9aPN
   C6zUN5cdM39QkTU6159xTJnuCQKCrjBEBzWZgKkHJy3TIVO1fQOcYHTgz
   URmKapk7a3tz2LfKUPGSO6+1ZCggKrBqdeAPZA2amazPCsnklS+e+JGtE
   A==;
X-CSE-ConnectionGUID: ByIGr9HoT9muP+NL0dSVWA==
X-CSE-MsgGUID: mfylf+kXSSqSQbkYDanrhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33079368"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="33079368"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:15:14 -0700
X-CSE-ConnectionGUID: XtCBoT3QQdO13TBbAV0Ozw==
X-CSE-MsgGUID: wdQa+sBiRMOFy78/AViuyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="89381705"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:15:11 -0700
Message-ID: <b9cd52b6-b7c3-4f9c-b8d5-6f6508465075@linux.intel.com>
Date: Tue, 13 Aug 2024 15:15:08 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 2/5] perf x86/topdown: Correct leader selection with
 sample_read enabled
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
 <20240712170339.185824-3-dapeng1.mi@linux.intel.com>
 <ab4e2929-a9f7-445d-9eb0-547556799a57@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <ab4e2929-a9f7-445d-9eb0-547556799a57@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/12/2024 11:18 PM, Liang, Kan wrote:
>
> On 2024-07-12 1:03 p.m., Dapeng Mi wrote:
>> Addresses an issue where, in the absence of a topdown metrics event
>> within a sampling group, the slots event was incorrectly bypassed as
>> the sampling leader when sample_read was enabled.
>>
>> perf record -e '{slots,branches}:S' -c 10000 -vv sleep 1
>>
>> In this case, the slots event should be sampled as leader but the
>> branches event is sampled in fact like the verbose output shows.
>>
>> perf_event_attr:
>>   type                             4 (cpu)
>>   size                             168
>>   config                           0x400 (slots)
>>   sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
>>   read_format                      ID|GROUP|LOST
>>   disabled                         1
>>   sample_id_all                    1
>>   exclude_guest                    1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                             0 (PERF_TYPE_HARDWARE)
>>   size                             168
>>   config                           0x4 (PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
>>   { sample_period, sample_freq }   10000
>>   sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
>>   read_format                      ID|GROUP|LOST
>>   sample_id_all                    1
>>   exclude_guest                    1
>>
>> The sample period of slots event instead of branches event is reset to
>> 0.
>>
>> This fix ensures the slots event remains the leader under these
>> conditions.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/arch/x86/util/topdown.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
>> index 49f25d67ed77..857e00cf579f 100644
>> --- a/tools/perf/arch/x86/util/topdown.c
>> +++ b/tools/perf/arch/x86/util/topdown.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include "api/fs/fs.h"
>>  #include "util/evsel.h"
>> +#include "util/evlist.h"
>>  #include "util/pmu.h"
>>  #include "util/pmus.h"
>>  #include "util/topdown.h"
>> @@ -87,11 +88,22 @@ bool arch_is_topdown_metrics(const struct evsel *evsel)
>>   */
>>  bool arch_topdown_sample_read(struct evsel *leader)
>>  {
>> +	struct evsel *evsel;
>> +
>>  	if (!evsel__sys_has_perf_metrics(leader))
>>  		return false;
>>  
>> -	if (arch_is_topdown_slots(leader))
>> -		return true;
>> +	if (!arch_is_topdown_slots(leader))
>> +		return false;
>> +
>> +	/*
>> +	 * If slots event as leader event but no topdown metric events
>> +	 * in group, slots event should still sample as leader.
>> +	 */
>> +	evlist__for_each_entry(leader->evlist, evsel) {
> 		evsel = leader->leader;
> 		evlist__for_each_entry_continue(leader->evlist, evsel)
> 			if (evsel->leader != leader->leader)
> 				return false;
>
> Maybe we should limit the check in a group, rather than the entire
> evlist. Something as above (not tested)?

Good point. Would limit the check in the group.


>
> Thanks,
> Kan
>> +		if (evsel != leader && arch_is_topdown_metrics(evsel))
>> +			return true;
>> +	}
>>  
>>  	return false;
>>  }
