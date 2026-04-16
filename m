Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69A54774;
	Thu, 16 Apr 2026 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776309957; cv=none; b=BnH0RAwOuc/Vk6SuvuSm7me8QRsXFO8Z4mPOjVlFIEOdYny2bb9l/bBy+tkf9fx9YOnhs4WSMF0bNO/6NCS+e37SbHUC3pzgHKtOcQkQXZHTUEptKdIkrkI3410w+4+OdprESQ8QQI52Il8wA18ZvNSiu74dUGCLnopQbyV5SDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776309957; c=relaxed/simple;
	bh=pB9idZMSuT7zl1ostVs/fhE3qTEmEFz4oUWbkwUwnzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkpAXUEyquHK9NkJRhjPKNmNH4Y7NGZXu3hdBFK19EH5YSTW70HKbVHqAelPamEWkNutTyr6scnGd4bAOuO/5i9Wu7USOONfU8F943WOTnzF0NjrBwpvRd9tdxCyzJuGbE1u0pWg/u6ns1NYsqFCK7ulNPEsz8VCmk0h/RYqwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMy17Z4f; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMy17Z4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776309956; x=1807845956;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pB9idZMSuT7zl1ostVs/fhE3qTEmEFz4oUWbkwUwnzw=;
  b=TMy17Z4fJEoJmj5Z+lSFrBA4OI7s6x2V2/MccjMvHjeeyBs58isDuBmK
   DY32wJmk07ndyCTxtfZf5wV+BDTgoCrFeSi2TX9drTbhXVOs16hcvTcXo
   4x0sM7dQTKeu7awfGenkX4FL8Y7rShTsQny7+64i76je6AF6t0QRqcuOi
   v+EXMisk7ZlIvVuLKijxAYURswB2iHzUygNtN1zR/DtD9sYbSh1rLwadW
   CgATsr/FXKQEG/BtKaP4Y51LGI23x2kyp6f/UGouEeEQ5k8Y0NFrT7eLp
   rB204G5T0/y5QNEdQgqFULYoM5umBVx98xDE61k7bAiy5Ifz+Cd4qzLD4
   w==;
X-CSE-ConnectionGUID: IpnhOTkxSmekEpEOiFGnFQ==
X-CSE-MsgGUID: SlCvDFzySbm94kLLLQZ3Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77175343"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77175343"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 20:25:55 -0700
X-CSE-ConnectionGUID: H7vHMaEoQVeIKpFxWR7t0w==
X-CSE-MsgGUID: gx/q/LjqTRSj76yz5ty9gw==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.1.30]) ([10.238.1.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 20:25:51 -0700
Message-ID: <7b75a855-fcaf-4ed6-bddf-811b9a15ada6@linux.intel.com>
Date: Thu, 16 Apr 2026 11:25:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: Add auto counter reload (ACR) sampling test
To: Ian Rogers <irogers@google.com>
Cc: Falcon Thomas <thomas.falcon@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260413010920.546501-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fW0Z0zXDjqR_tpJbT-0nbyXQO-Zcc+4Fpk=XejYX8uF4g@mail.gmail.com>
 <0ce093d8-3647-4879-9d65-acd52d4c0ab0@linux.intel.com>
 <CAP-5=fWj4PaadfdmkoNyOVnbNb9aAdhgxOr-CG+R8OLx2jFRCg@mail.gmail.com>
 <52a669dd-243c-4956-855e-ae76f6951ec4@linux.intel.com>
 <CAP-5=fWSQ1m1q0Umq=HqYZmrzqxTkJDjjNHj-839Mu1kQzaC2Q@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWSQ1m1q0Umq=HqYZmrzqxTkJDjjNHj-839Mu1kQzaC2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/16/2026 11:17 AM, Ian Rogers wrote:
> On Wed, Apr 15, 2026 at 8:06 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 4/16/2026 1:13 AM, Ian Rogers wrote:
>>> On Wed, Apr 15, 2026 at 2:19 AM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>> On 4/13/2026 9:30 AM, Ian Rogers wrote:
>>>>> On Sun, Apr 12, 2026 at 6:14 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>>>>>> Add auto counter reload sampling test to verify that the intended event
>>>>>> records can be captured and the self-reloaded events won't generate any
>>>>>> records.
>>>>>>
>>>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>>>> ---
>>>>>>  tools/perf/tests/shell/record.sh | 42 ++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 42 insertions(+)
>>>>>>
>>>>>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>>>>>> index 7cb81cf3444a..1068843282f5 100755
>>>>>> --- a/tools/perf/tests/shell/record.sh
>>>>>> +++ b/tools/perf/tests/shell/record.sh
>>>>>> @@ -402,6 +402,47 @@ test_callgraph() {
>>>>>>    echo "Callgraph test [Success]"
>>>>>>  }
>>>>>>
>>>>>> +test_acr_sampling() {
>>>>>> +  events="{instructions/period=20000,acr_mask=0x2/u,cycles/period=40000,acr_mask=0x3/u}"
>>>>>> +  pebs_events="{instructions/period=20000,acr_mask=0x2/pu,cycles/period=40000,acr_mask=0x3/u}"
>>>>>> +  echo "Auto counter reload sampling test"
>>>>>> +  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/null
>>>>>> +  then
>>>>>> +    echo "Auto counter reload sampling [Skipped not supported]"
>>>>>> +    return
>>>>>> +  fi
>>>>>> +  if ! perf script -i "${perfdata}" | grep -q "period=20000,acr_mask=0x2"
>>>>>> +  then
>>>>>> +    echo "Auto counter reload sampling [Failed missing instructions event]"
>>>>>> +    err=1
>>>>>> +    return
>>>>>> +  fi
>>>>>> +  if perf script -i "${perfdata}" | grep -q "period=40000,acr_mask=0x3"
>>>>>> +  then
>>>>>> +    echo "Auto counter reload sampling [Failed cycles event shouldn't be sampled]"
>>>>>> +    err=1
>>>>>> +    return
>>>>>> +  fi
>>>>>> +  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog} 2> /dev/null
>>>>>> +  then
>>>>>> +    echo "Auto counter reload PEBS sampling [Skipped not supported]"
>>>>>> +    return
>>>>>> +  fi
>>>>>> +  if ! perf script -i "${perfdata}" | grep -q "period=20000,acr_mask=0x2"
>>>>>> +  then
>>>>>> +    echo "Auto counter reload PEBS sampling [Failed missing instructions event]"
>>>>>> +    err=1
>>>>>> +    return
>>>>>> +  fi
>>>>>> +  if perf script -i "${perfdata}" | grep -q "period=40000,acr_mask=0x3"
>>>>>> +  then
>>>>>> +    echo "Auto counter reload PEBS sampling [Failed cycles event shouldn't be sampled]"
>>>>>> +    err=1
>>>>>> +    return
>>>>>> +  fi
>>>>>> +  echo "Auto counter reload sampling [Success]"
>>>>> Thanks Dapeng! Could we also test ratio-to-prev as well as just the
>>>>> plain acr_mask?
>>>> Ian, it could be hard to validate ratio-to-prev option in this test. On
>>>> platforms which don't support ACR, perf would automatically fallback the
>>>> ACR sampling to normal sampling, this would lead to false positives on
>>>> checking the existence of records from cycles event. I didn't find a good
>>>> way to figure out this fallback.
>>>>
>>>> Since we already have independent test case to validate the ratio_to_prev
>>>> parsing. It may be unnecessary to add ratio-to-prev validation in this ACR
>>>> test.
>>> So the ratio_to_prev test covers parsing the ratio-to-prev option (it
>>> only has `perf record` commands) and ensures it is acted upon, but it
>>> doesn't check the option's functional behavior - what the output is.
>>> This test makes sure the acr_mask option is functional and so would be
>>> complemented by ratio-to-prev testing somethig like:
>>> ```
>>>   rtp_events="{instructions,cycles/period=40000,ratio-to-prev=0.5/u}"
>>>
>>>   # Test ratio-to-prev
>>>   if ! perf record -o "${perfdata}" -e "${rtp_events}" ${testprog} 2> /dev/null
>>>   then
>>>     echo "Auto counter reload ratio-to-prev sampling [Failed record
>>> ratio-to-prev]"
>>>     err=1
>>>     return
>>>   fi
>>>   if ! perf script -i "${perfdata}" | grep -q "instructions"
>>>   then
>>>     echo "Auto counter reload ratio-to-prev sampling [Failed missing
>>> instructions event]"
>>>     err=1
>>>     return
>>>   fi
>>>   if perf script -i "${perfdata}" | grep -q "cycles"
>>>   then
>>>     echo "Auto counter reload ratio-to-prev sampling [Failed cycles
>>> event shouldn't be sampled]"
>>>     err=1
>>>     return
>>>   fi
>>> ```
>>> The first thing your test does is to make sure the acr_mask is
>>> supported, so I'm not sure how the fall back can happen?
>>> We could additionally check for
>>> `/sys/bus/event_source/devices/cpu*/format/acr_mask`.
>> Yes, that's initially what I intended to do, but it would cause false
>> positives on some hybrid platform, like PTL which only supports ACR on E-core.
>>
>> ```
>>
>> $ grep . /sys/bus/event_source/devices/cpu_core/format/*
>> /sys/bus/event_source/devices/cpu_core/format/cmask:config:24-31
>> /sys/bus/event_source/devices/cpu_core/format/edge:config:18
>> /sys/bus/event_source/devices/cpu_core/format/eq:config:36
>> /sys/bus/event_source/devices/cpu_core/format/event:config:0-7
>> /sys/bus/event_source/devices/cpu_core/format/frontend:config1:0-23
>> /sys/bus/event_source/devices/cpu_core/format/inv:config:23
>> /sys/bus/event_source/devices/cpu_core/format/ldlat:config1:0-15
>> /sys/bus/event_source/devices/cpu_core/format/metrics_clear:config1:0
>> /sys/bus/event_source/devices/cpu_core/format/offcore_rsp:config1:0-63
>> /sys/bus/event_source/devices/cpu_core/format/pc:config:19
>> /sys/bus/event_source/devices/cpu_core/format/umask:config:8-15,40-47
>>
>> $ grep . /sys/bus/event_source/devices/cpu_atom/format/*
>> /sys/bus/event_source/devices/cpu_atom/format/acr_mask:config2:0-63
>> /sys/bus/event_source/devices/cpu_atom/format/cmask:config:24-31
>> /sys/bus/event_source/devices/cpu_atom/format/edge:config:18
>> /sys/bus/event_source/devices/cpu_atom/format/eq:config:36
>> /sys/bus/event_source/devices/cpu_atom/format/event:config:0-7
>> /sys/bus/event_source/devices/cpu_atom/format/inv:config:23
>> /sys/bus/event_source/devices/cpu_atom/format/ldlat:config1:0-15
>> /sys/bus/event_source/devices/cpu_atom/format/offcore_rsp:config1:0-63
>> /sys/bus/event_source/devices/cpu_atom/format/pc:config:19
>> /sys/bus/event_source/devices/cpu_atom/format/snoop_rsp:config1:0-63
>> /sys/bus/event_source/devices/cpu_atom/format/umask:config:8-15,40-47
>>
>> ```
>>
>> So strictly speaking, we need to check if it's a hybrid platform first and
>> then check if the exact P-core/E-core supports ACR, then run the above ACR
>> tests. It seems a little bit over-complicated and I'm not sure if it's
>> accepted to add so much Intel specific check in the record.sh.
>>
>> How's your idea on this? Thanks.
> Potentially auto counter reload and ratio to prev are generic
> concepts, it just happens that we only have Intel e-core
> implementations :-) Matching against cpu* already misses ARM core
> PMUs. I'm always happy for as much testing as possible. The last code
> coverage number I have for Linux v6.17 is 38.6% of lines under
> tools/perf. Since then, I've added quite a bit of testing for commands
> like `perf top`. Perhaps we now cover over 50% of the lines of code.

Ok, incomplete tests are always better than no tests. I would add the test
although it looks not so pretty. :)


>
> Thanks,
> Ian
>
>>> Thanks,
>>> Ian
>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>>> +}
>>>>>> +
>>>>>>  test_ratio_to_prev() {
>>>>>>    echo "ratio-to-prev test"
>>>>>>    if ! perf record -o /dev/null -e "{instructions, cycles/period=100000,ratio-to-prev=0.5/}" \
>>>>>> @@ -457,6 +498,7 @@ test_leader_sampling
>>>>>>  test_topdown_leader_sampling
>>>>>>  test_precise_max
>>>>>>  test_callgraph
>>>>>> +test_acr_sampling
>>>>>>  test_ratio_to_prev
>>>>>>
>>>>>>  # restore the default value
>>>>>>
>>>>>> base-commit: 4e03d6494f9504f8af46ba68a2a8b6877c196789
>>>>>> --
>>>>>> 2.34.1
>>>>>>
