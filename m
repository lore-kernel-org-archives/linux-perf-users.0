Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13218101E6;
	Wed, 30 Apr 2025 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022373; cv=none; b=VIHaSe/53YQc8IeQ3g8OcPGUw2mMAVCSMw8K652RBwEqg3SZXv6RQBqOt5vM5SKFeV4Rixt+rW8LOdKOpKl7oEdEgBX6P1E1Y/xsfl7UoFZPsH28umgmJf86avD37j/HY1zMinlIr4YxlE1gkofAbr758RtWuDNSg/XARAlrF50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022373; c=relaxed/simple;
	bh=HcvCTaVzzx3q7RPBC6uFYMN9Hd7p5KMc6tnbL+F69YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+Z4opyBsS3N8em5QKYj2k+Ekno9vKFxrjW6OEh3VlBL90JOlEeM40bmRS2kkficYlFat2vRB5thPHIz61IC9Mm0BcKfqZoiPVQzuFsfsLwJ82JjcjFS1+l5EYB8gqcp3fOdD0U5kvxiOSzU17iJn80sO0+f6/sz7KrK87XjtrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fT24SPJZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fT24SPJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746022372; x=1777558372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HcvCTaVzzx3q7RPBC6uFYMN9Hd7p5KMc6tnbL+F69YU=;
  b=fT24SPJZ1R7B8fS3Xrp1K0DXDSsoteiVoF753o89i9ib20K5TIqPTXhs
   uKK95k2CmRxjgqjpHbnsZ0Qn2vyRN2M7uxIeTr8+W8iJyWHcPiX6SRI49
   7i7vaOzP3fthDggxJtXvpTchrtZ0eaI9Fx5578JP/RHhYlFT3KPOtRj/h
   SudUJMlr2l2nf5cvElquVGCkSBp/8DLRIsbIk2q/xgj+wZGqI4GDA6/8A
   c43PC3kfvvZuEanEHiZuiFapCgxdRA1VhCcVn88AsataZ6gcLtYZ/T3fI
   IQMg8lI6pDoh8cCTy8WbbXfkjeMq8m5fE7tYq9nEjYtB3xyMzGbjUcpYS
   A==;
X-CSE-ConnectionGUID: VQ5Ek9f5SsSeLxafDbcVfg==
X-CSE-MsgGUID: yqnVlpdKRPmEcdJOONtVFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="70187901"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="70187901"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 07:12:51 -0700
X-CSE-ConnectionGUID: PlSVIgpdST2WQ3C+krywdg==
X-CSE-MsgGUID: GsQDU0juQwGzNeL0+Vaqug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135111904"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 07:12:51 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id DA07B20B5736;
	Wed, 30 Apr 2025 07:12:48 -0700 (PDT)
Message-ID: <5206f699-ae03-47ad-98e9-3805bc8f2548@linux.intel.com>
Date: Wed, 30 Apr 2025 10:12:47 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: Fix open counting event error
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Luo Gengkun <luogengkun@huaweicloud.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "irogers@google.com" <irogers@google.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
 <f8c349c8-b074-4b27-b799-e484631b9b3e@amd.com>
 <1d1cb14f-5729-4200-af20-d66b4feebe94@linux.intel.com>
 <a04c37c6-8f83-45e9-a39f-1e1ba613f7f4@amd.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <a04c37c6-8f83-45e9-a39f-1e1ba613f7f4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ravi,

Sorry for the late response. I was on vacation.

On 2025-04-25 6:12 a.m., Ravi Bangoria wrote:
> Hi Kan,
> 
>>>> Perf doesn't work at perf stat for hardware events:
>>>>
>>>>  $perf stat -- sleep 1
>>>>  Performance counter stats for 'sleep 1':
>>>>              16.44 msec task-clock                       #    0.016 CPUs utilized
>>>>                  2      context-switches                 #  121.691 /sec
>>>>                  0      cpu-migrations                   #    0.000 /sec
>>>>                 54      page-faults                      #    3.286 K/sec
>>>>    <not supported>	cycles
>>>>    <not supported>	instructions
>>>>    <not supported>	branches
>>>>    <not supported>	branch-misses
>>>
>>> Wondering if it is worth to add this in perf test. Something like
>>> below?
>>>
>>> --- a/tools/perf/tests/shell/stat.sh
>>> +++ b/tools/perf/tests/shell/stat.sh
>>> @@ -16,6 +16,24 @@ test_default_stat() {
>>>    echo "Basic stat command test [Success]"
>>>  }
>>>  
>>> +test_stat_count() {
>>> +  echo "stat count test"
>>> +
>>> +  if ! perf list | grep -q "cpu-cycles OR cycles"
>>> +  then
>>> +    echo "stat count test [Skipped cpu-cycles event missing]"
>>> +    return
>>> +  fi
>>> +
>>> +  if perf stat -e cycles true 2>&1 | grep -E -q "<not supported>"
>>> +  then
>>> +    echo "stat count test [Failed]"
>>> +    err=1
>>> +    return
>>> +  fi
>>> +  echo "stat count test [Success]"
>>> +}
>>> +
>>>  test_stat_record_report() {
>>>    echo "stat record and report test"
>>>    if ! perf stat record -o - true | perf stat report -i - 2>&1 | \
>>> @@ -201,6 +219,7 @@ test_hybrid() {
>>>  }
>>>  
>>>  test_default_stat
>>> +test_stat_count
>>
>> I think the perf stat default should always be supported, not just cycles.
>> Maybe we should add the check in test_default_stat?
> 
> Do you mean:
> 
>   if perf stat true 2>&1 | grep -E -q "<not supported>"
>     err=1
>

Yes, I assumed that all the events in the perf stat are always
available. But it seems the assumption is only true for bare metal.


> Isn't this ambiguous? Also, this fails on machines where HW pmu
> is not supported. For ex, on my qemu guest with `-cpu pmu=off`:
> 
>   $ ./perf list | grep "cpu-cycles OR cycles"
>   <empty output>
> 
>   $ ./perf stat true
>    Performance counter stats for 'true':
>                 0.42 msec task-clock:u                     #    0.470 CPUs utilized
>                    0      context-switches:u               #    0.000 /sec
>                    0      cpu-migrations:u                 #    0.000 /sec
>                   48      page-faults:u                    #  113.874 K/sec
>      <not supported>      cycles:u
> 
If taking the virtualization into account, the test_stat_count looks
good to me.

Thanks,
Kan

