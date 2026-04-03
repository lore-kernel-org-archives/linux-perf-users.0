Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07B1FCFFC
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201793; cv=none; b=uaYD6TWzUxynfNBnEpVLXf3iqB7bU/Bbx5+ATIfSlXI8ndFv42AwoCJBhRZPYPHb3BwNgs1Q8wBhCLV+uGqeeDEeq5kYnxhA2CTRgOg28FYB5GjLwKyjcW8PD0yVSmIhIkOXR0RbX8pYQyXT3ptLE9NgqDyxbzinStyaFu9FIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201793; c=relaxed/simple;
	bh=p7Y9L4OJMuhbRMFw7kwUwGX6q7lzuCeO9xRBw9z8HZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZcl4bXRCWrxOv+wlWrlg0caSp2OU5zqvEY7C7cuw2iu6K1M19eAdYvxOLTffpUghtSf6Z9qtRTx095holgAJP3Cv6UhrGm1UEKpdB4FDCoFsJPuA39DZJAi/caUixu+MrtMmnf+RUuPX4A62CnOSU3N83bGNSemQ1OppT2DDqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LI6jb3od; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LI6jb3od"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775201791; x=1806737791;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p7Y9L4OJMuhbRMFw7kwUwGX6q7lzuCeO9xRBw9z8HZ0=;
  b=LI6jb3odbXs7yUocLn3wXU9Vwv9yhW8Jd3fM6nR+a1NE4Ua5Ov8fLxfD
   ZCmuAtnSZzd7XLB16DMrdEdIBuLLYpjQ/Q8hkeml1JdLRxlieRL/lI+jk
   /z3GeT1c32qr52Rx/ME60OON/BNKdoFT+zYQelfTcXgnB+UF4/cRzjHG6
   sRvVAzUwATGWTqTNl26U8Xfzi8ifq/KylwccpaVxld58EXxJF6iXKQdvj
   +nDlMak4Ldav9sHtYC14p8xQwKR5bZD8KF8wQ5FOPTyO1Yqeht4kQqBBo
   tnEYz8fmHsKOq75dskZBwMaD0zI4YzEjh4G9vlkHkKiA9EDrCnclHIbf+
   A==;
X-CSE-ConnectionGUID: m9lMQ5kDS3+KGdoQrSU6Tg==
X-CSE-MsgGUID: 0E6bp4XTRrKBPOd6ck9H6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75308277"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75308277"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 00:36:28 -0700
X-CSE-ConnectionGUID: wue1cdC4R7qnuG/OQKbPzQ==
X-CSE-MsgGUID: kDxDuZQ4QYW3K8SqCYnEIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="224359789"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 00:36:23 -0700
Message-ID: <cf702c86-7dea-44af-8dd2-0c27e19da1b5@linux.intel.com>
Date: Fri, 3 Apr 2026 15:36:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
To: "Falcon, Thomas" <thomas.falcon@intel.com>,
 "atrajeev@linux.ibm.com" <atrajeev@linux.ibm.com>,
 "venkat88@linux.ibm.com" <venkat88@linux.ibm.com>,
 "Rogers, Ian" <irogers@google.com>
Cc: "Kleen, Andi" <andi.kleen@intel.com>,
 "Shivani.Nittor@ibm.com" <Shivani.Nittor@ibm.com>,
 "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
 "hbathini@linux.vnet.ibm.com" <hbathini@linux.vnet.ibm.com>,
 "mpetlan@redhat.com" <mpetlan@redhat.com>,
 "Tanushree.Shah@ibm.com" <Tanushree.Shah@ibm.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "maddy@linux.ibm.com" <maddy@linux.ibm.com>, "Chen, Zide"
 <zide.chen@intel.com>, "vmolnaro@redhat.com" <vmolnaro@redhat.com>,
 "Tejas.Manhas1@ibm.com" <Tejas.Manhas1@ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "acme@kernel.org" <acme@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
 "Mi, Dapeng1" <dapeng1.mi@intel.com>,
 "namhyung@kernel.org" <namhyung@kernel.org>
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
 <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
 <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
 <ec33d914a3eb3f8cc1a0ad16bf877ff7284072c9.camel@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <ec33d914a3eb3f8cc1a0ad16bf877ff7284072c9.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/3/2026 1:32 AM, Falcon, Thomas wrote:
> On Wed, 2026-04-01 at 13:40 -0700, Ian Rogers wrote:
>> On Mon, Mar 23, 2026 at 3:40 AM Venkat <venkat88@linux.ibm.com>
>> wrote:
>>>
>>>
>>>> On 15 Mar 2026, at 4:27 PM, Athira Rajeev
>>>> <atrajeev@linux.ibm.com> wrote:
>>>>
>>>> Currently in "perf all PMU test", for "perf stat -e <event>
>>>> true",
>>>> below checks are done:
>>>> - if return code is zero, look for "not supported" to decide pass
>>>>  scenario
>>>> - check for "not supported" to ignore the event
>>>> - looks for "No permission to enable" to skip the event.
>>>> - If output has "Bad event name", fail the test.
>>>> - Use "Access to performance monitoring and observability
>>>> operations is
>>>>  limited." to ignore fail due to access limitations
>>>>
>>>> If we failed to see event and it is supported, retries with
>>>> longer
>>>> workload "perf bench internals synthesize".
>>>> - Here if output has <event>, the test is a pass.
>>>>
>>>> Snippet of code check:
>>>>  ```
>>>>  output=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
>>>>  if echo "$output" | grep -q "$p"
>>>>  ```
>>>> - if output doesn't have event printed in logs, considers it
>>>> fail.
>>>>
>>>> But this results in false pass for events in some cases.
>>>> Example, if perf stat fails as below:
>>>>
>>>> # ./perf stat -e pmu/event/  true
>>>> event syntax error: 'pmu/event/'
>>>>                     \___ Bad event or PMU
>>>>
>>>> Unable to find PMU or event on a PMU of 'pmu'
>>>> Run 'perf list' for a list of valid events
>>>>
>>>>  Usage: perf stat [<options>] [<command>]
>>>>
>>>>    -e, --event <event>   event selector. use 'perf list' to list
>>>> available events
>>>> # echo $?
>>>> 129
>>>>
>>>> Since this has non-zero return code and doesn't have the
>>>> fail strings being checked in the test, it will enter check using
>>>> longer workload. and since the output fail log has event, it
>>>> declares test as "supported".
>>>>
>>>> Since all the fail strings can't be added in the check, update
>>>> the testcase to check return code before proceeding to longer
>>>> workload run.
>>>>
>>>> Another missing scenario is when system wide monitoring is
>>>> supported
>>>> example:
>>>> # ./perf stat -e pmu/event/ true
>>>> Error:
>>>> No supported events found.
>>>>  Unsupported event (pmu/event/H) in per-thread mode, enable
>>>> system wide with '-a'.
>>>>
>>>> Update testcase to check with "perf stat -a -e $p" as well
>>>>
>>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>>>> ---
>>> Tested this patch.
>>>
>>>
>>> With this patch:
>>>
>>> Testing hv_24x7/CPM_ADJUNCT_INST/ -- perf stat failed with non-zero
>>> return code
>>> Testing hv_24x7/CPM_ADJUNCT_PCYC/ -- perf stat failed with non-zero
>>> return code
>>>
>>>
>>>
>>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Testing on an Intel Alderlake the test is now failing:
>> ```
>> ...
>> Testing offcore_requests_outstanding.l3_miss_demand_data_rd --
>> supported
>> Testing ocr.full_streaming_wr.any_response -- perf stat failed with
>> non-zero return code
>> Testing ocr.partial_streaming_wr.any_response -- perf stat failed
>> with
>> non-zero return code
>> Testing ocr.streaming_wr.any_response -- supported
>> ...
>> ```
>>
>> Running `perf stat` manually reveals an issue with the event:
>> ```
>> $ sudo perf stat -vv -e ocr.full_streaming_wr.any_response -a sleep
>> 1
>> Using CPUID GenuineIntel-6-B7-1
>> Attempt to add: cpu_atom/ocr.full_streaming_wr.any_response/
>> ..after resolving event:
>> cpu_atom/event=0xb7,period=0x186a3,umask=0x1,offcore_rsp=0x8000000100
>> 00/
>> ocr.full_streaming_wr.any_response ->
>> cpu_atom/ocr.full_streaming_wr.any_response/
>> Control descriptor is not initialized
>> ------------------------------------------------------------
>> perf_event_attr:
>>  type                             10 (cpu_atom)
>>  size                             144
>> ------------------------------------------------------------
>> perf_event_attr:
>>  type                             0 (PERF_TYPE_HARDWARE)
>>  config                           0xa00000000
>> (cpu_atom/PERF_COUNT_HW_CPU_CYCLES/)
>>  disabled                         1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 3
>> ------------------------------------------------------------
>> perf_event_attr:
>>  type                             0 (PERF_TYPE_HARDWARE)
>>  config                           0x400000000
>> (cpu_core/PERF_COUNT_HW_CPU_CYCLES/)
>>  disabled                         1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 3
>>  config                           0x1b7
>> (ocr.demand_data_rd.l3_hit.snoop_hit_no_fwd)
>>  sample_type                      IDENTIFIER
>>  read_format                     
>> TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>  disabled                         1
>>  inherit                          1
>>  { bp_addr, config1 }             0x800000010000
>> ------------------------------------------------------------
>> sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8
>> sys_perf_event_open failed, error -22
>> switching off deferred callchain support
>> Warning:
>> ocr.full_streaming_wr.any_response event is not supported by the
>> kernel.
>> The sys_perf_event_open() syscall failed for event
>> (ocr.full_streaming_wr.any_response): Invalid argument
>> "dmesg | grep -i perf" may provide additional information.
>>
>> Error:
>> No supported events found.
>> The sys_perf_event_open() syscall failed for event
>> (ocr.full_streaming_wr.any_response): Invalid argument
>> "dmesg | grep -i perf" may provide additional information.
>> ```
>>
>> This looks like a latent Intel cpu_atom PMU bug. Thomas, wdyt?

Hmm, it looks the error is caused by the invalid bitmask of OFFCORE_RSP_x
MSRs. Currently the valid bitmask of OFFCORE_RSP_x MSR is set to
0x3fffffffff in intel_grt_extra_regs[], while the msr value is set
0x800000010000 for the ocr.full_streaming_wr.any_response event. The bit 47
is recognized an invalid bit and then abort the event creation.

Base on the description "Table 21-56. MSR_OFFCORE_RSPx Request Type
Definition" in SDM, bit 47 should be a valid bit now. Suppose bit 47 should
not be a valid bit when adding the ADL PMU support, but it's updated and
becomes valid later.

Along with the constant updates of perf event lists
(https://github.com/intel/perfmon), we have noticed there are mismatches
more or less between the driver hardcoded events and perfmon event list.
Currently we are summarizing the mismatches. Once these mismatches are
finalized. we would submit a patchset to fix these mismatches.

Thanks.

> +Dapeng, Zide, Andi
>
> Thanks,
> Tom
>
>> Thanks,
>> Ian
>>
>>> Regards,
>>> Venkat.
>>>
>>>
>>>
>>>> tools/perf/tests/shell/stat_all_pmu.sh | 20 ++++++++++++++++++++
>>>> 1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh
>>>> b/tools/perf/tests/shell/stat_all_pmu.sh
>>>> index 9c466c0efa85..6c4d59cbfa5f 100755
>>>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
>>>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
>>>> @@ -53,6 +53,26 @@ do
>>>>     continue
>>>>   fi
>>>>
>>>> +  # check with system wide if it is supported.
>>>> +  output=$(perf stat -a -e "$p" true 2>&1)
>>>> +  stat_result=$?
>>>> +  if echo "$output" | grep -q "not supported"
>>>> +  then
>>>> +    # Event not supported, so ignore.
>>>> +    echo "not supported"
>>>> +    continue
>>>> +  fi
>>>> +
>>>> +  # checked through possible access limitations and permissions.
>>>> +  # At this step, non-zero return code from "perf stat" needs to
>>>> +  # reported as fail for the user to investigate
>>>> +  if [ $stat_result -ne 0 ]
>>>> +  then
>>>> +    echo "perf stat failed with non-zero return code"
>>>> +    err=1
>>>> +    continue
>>>> +  fi
>>>> +
>>>>   # We failed to see the event and it is supported. Possibly the
>>>> workload was
>>>>   # too small so retry with something longer.
>>>>   output=$(perf stat -e "$p" perf bench internals synthesize
>>>> 2>&1)
>>>> --
>>>> 2.47.3
>>>>
