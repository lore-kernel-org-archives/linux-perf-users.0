Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0533AC0EC;
	Mon,  8 Jun 2026 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907217; cv=none; b=cfNyA3FxsoVRe616HiaQTqmRdT1Yr+w2nRsQZlH1w5uW8p0hye2M8S4uRezNqjktmXOr06lILJrwXhv1RlwcUEl2lW2EVoJNdSDLl36scU+THquN7MR1lPBuvT59VEvjOLmmvJx6v2E/jxZ58O8I+zGK9N/NsyXMn+CtcFHzUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907217; c=relaxed/simple;
	bh=CxRdnewMXxVE9RgVvzHfsVZaqLzBxph2JoapufR7how=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=otFqbuCBGG16O1ewJsZ7xTZ4ejV4HCEp5YGqf75Z3+UpQSh9eguAkTlsc4qgwylrF5Q6TUPUYo8vB7pKo6VeHFDbJUt1YqspEGmfGUNnUgxGtYSEngtPGg+2DUm9PP7MHKlTcJNtEYyPOcdyoe+k4fg6JDIoZTbRHu3E6EmPCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikv252V0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikv252V0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780907216; x=1812443216;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=CxRdnewMXxVE9RgVvzHfsVZaqLzBxph2JoapufR7how=;
  b=ikv252V0ZaeURUJw05jZMtD55rFAfI0n3EQ1MgJNRI31evXqejc5EMTR
   l/uNkN9IZF5wMsEBphAKJY+JgNCHkUz84LJ9d4olCPoQn/neekHU7J5xo
   2XozBO36fGpUn6tyinWh/ut7jrDzUKCMyHEdSepXqar5t3ejaOc623W0A
   sP/PDnFtlvOF5KNmxX6hSJl6HoN3TFxJ4kk/Auisv8R8z+MNi9surQ+tn
   poYvMtvp2wLSSnfn54YkIj7WAR1AEN99pVZ9QM7P8MTTeRWH1z5P0x1L0
   QNVmcanU8tj4KvU3rqZn4Z+3xq6shlBl9Lrx8mrMnLWyZMr5Qgcu0AQjF
   Q==;
X-CSE-ConnectionGUID: SIEn75JqRhCOIFwIXWq0NA==
X-CSE-MsgGUID: LHJ4bEX4T4qBUAJ3uC+5Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="85490700"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="85490700"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 01:26:55 -0700
X-CSE-ConnectionGUID: o6jAKCgHTdC33cZA2eBVmQ==
X-CSE-MsgGUID: X2wSWDMXRy+Mi9hxoVpcaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="245581726"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 01:26:51 -0700
Message-ID: <39474532-c6a3-4faf-8185-15dfd553bd87@linux.intel.com>
Date: Mon, 8 Jun 2026 16:26:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3] perf tests: Add auto counter reload (ACR) sampling
 test
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260421045511.2401316-1-dapeng1.mi@linux.intel.com>
 <cc0a4682-20ca-4796-82b2-f7eb8eba3a7f@linux.intel.com>
Content-Language: en-US
In-Reply-To: <cc0a4682-20ca-4796-82b2-f7eb8eba3a7f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ping again ...

Thanks.

On 5/21/2026 8:52 AM, Mi, Dapeng wrote:
> Kindly ping. :)
>
> Thanks.
>
>
> On 4/21/2026 12:55 PM, Dapeng Mi wrote:
>> Add auto counter reload sampling test to verify that the intended event
>> records can be captured and the self-reloaded events won't generate any
>> records.
>>
>> Additionally, enhance ratio_to_prev test to verify ACR sampling as well
>> if ACR is supported.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>
>> V3: Move ratio-to-prev ACR sampling test into ratio_to_prev test.
>> V2: https://lore.kernel.org/all/20260420025501.2133495-1-dapeng1.mi@linux.intel.com/
>> v1: https://lore.kernel.org/all/20260413010920.546501-1-dapeng1.mi@linux.intel.com/
>>
>>  tools/perf/tests/shell/record.sh | 92 +++++++++++++++++++++++++++++++-
>>  1 file changed, 91 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index 7cb81cf3444a..091d8b0a998b 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -402,7 +402,52 @@ test_callgraph() {
>>    echo "Callgraph test [Success]"
>>  }
>>  
>> +test_acr_sampling() {
>> +  events="{instructions/period=40000,acr_mask=0x2/u,cycles/period=20000,acr_mask=0x3/u}"
>> +  pebs_events="{instructions/period=40000,acr_mask=0x2/pu,cycles/period=20000,acr_mask=0x3/u}"
>> +  echo "Auto counter reload (ACR) sampling test"
>> +  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/null
>> +  then
>> +    echo "Auto counter reload sampling [Skipped not supported]"
>> +    return
>> +  fi
>> +  if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
>> +  then
>> +    echo "Auto counter reload sampling [Failed missing instructions event]"
>> +    err=1
>> +    return
>> +  fi
>> +  if perf script -i "${perfdata}" -F event | grep -q "cycles"
>> +  then
>> +    echo "Auto counter reload sampling [Failed cycles event shouldn't be sampled]"
>> +    err=1
>> +    return
>> +  fi
>> +  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog} 2> /dev/null
>> +  then
>> +    echo "Auto counter reload PEBS sampling [Skipped not supported]"
>> +    echo "Auto counter reload sampling [Success]"
>> +    return
>> +  fi
>> +  if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
>> +  then
>> +    echo "Auto counter reload PEBS sampling [Failed missing instructions event]"
>> +    err=1
>> +    return
>> +  fi
>> +  if perf script -i "${perfdata}" -F event | grep -q "cycles"
>> +  then
>> +    echo "Auto counter reload PEBS sampling [Failed cycles event shouldn't be sampled]"
>> +    err=1
>> +    return
>> +  fi
>> +  echo "Auto counter reload sampling [Success]"
>> +}
>> +
>>  test_ratio_to_prev() {
>> +  ratio_events="{instructions:u,cycles/period=20000,ratio-to-prev=0.5/u}"
>> +  p_core_ratio_events="{cpu_core/instructions/u,cpu_core/cycles,period=20000,ratio-to-prev=0.5/u}"
>> +  e_core_ratio_events="{cpu_atom/instructions/u,cpu_atom/cycles,period=20000,ratio-to-prev=0.5/u}"
>>    echo "ratio-to-prev test"
>>    if ! perf record -o /dev/null -e "{instructions, cycles/period=100000,ratio-to-prev=0.5/}" \
>>       true 2> /dev/null
>> @@ -438,7 +483,51 @@ test_ratio_to_prev() {
>>      err=1
>>      return
>>    fi
>> -  echo "Basic ratio-to-prev record test [Success]"
>> +
>> +  ratio_err=0
>> +  do_ratio_to_prev_test() {
>> +    local events=$1
>> +    local cpu=$2
>> +    if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/null
>> +    then
>> +      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed sampling]"
>> +      ratio_err=1
>> +      return
>> +    fi
>> +    if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
>> +    then
>> +      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed missing instructions event]"
>> +      ratio_err=1
>> +      return
>> +    fi
>> +    if perf script -i "${perfdata}" -F event | grep -q "cycles"
>> +    then
>> +      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed cycles event shouldn't be sampled]"
>> +      ratio_err=1
>> +      return
>> +    fi
>> +  }
>> +
>> +  # ratio-to-prev sampling would fallback to normal sampling if ACR sampling
>> +  # is not supported, so acr_mask must be checked before testing ratio-to-prev sampling.
>> +  if [ -e /sys/bus/event_source/devices/cpu/format/acr_mask ]
>> +  then
>> +    do_ratio_to_prev_test "${ratio_events}" ""
>> +  fi
>> +  if [ -e /sys/bus/event_source/devices/cpu_core/format/acr_mask ]
>> +  then
>> +    do_ratio_to_prev_test "${p_core_ratio_events}" "P-core"
>> +  fi
>> +  if [ -e /sys/bus/event_source/devices/cpu_atom/format/acr_mask ]
>> +  then
>> +    do_ratio_to_prev_test "${e_core_ratio_events}" "E-core"
>> +  fi
>> +  if test "$ratio_err" -eq 0
>> +  then
>> +    echo "Basic ratio-to-prev record test [Success]"
>> +  else
>> +    err="${ratio_err}"
>> +  fi
>>  }
>>  
>>  # raise the limit of file descriptors to minimum
>> @@ -457,6 +546,7 @@ test_leader_sampling
>>  test_topdown_leader_sampling
>>  test_precise_max
>>  test_callgraph
>> +test_acr_sampling
>>  test_ratio_to_prev
>>  
>>  # restore the default value
