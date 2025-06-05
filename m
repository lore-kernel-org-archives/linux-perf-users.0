Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27527510C;
	Thu,  5 Jun 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142725; cv=none; b=Aqd84/vKtbHwt0RoH6Q5V2qweCWNJ9ThL7vzPV7DG7cvpAqzqMjGimjsZ6IUNI46qf5FuVjQ3Pgr9VTtGb3T1ItU7ChKCU40OicPhUsQZTOCjm4O8km0pcIDz7qRqGnxl26UVWFHei6HQRX9Pig5/7ZaouWLZ2oDJBX1juAF1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142725; c=relaxed/simple;
	bh=V+RGtOXj+Div4Ph+uYyTLz/ZlWZWtTVuSKRa6XJvkRE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hc5FIBh8aAz/W56GOnPpkd19TP2JF5QHIyh98tY6rQLy1QvPmu4rwxczHbBf8HvM+kcalP7SdqaLnC7Rw5Va658R5kXG7dfbiX/fVHWjujdxbzBou9GU5TrDPD5eHa4kkR5fcgoEfr5CQxyl4ORCvQiu3gZk6RQGcyw4x1CBYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glcvHbI4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glcvHbI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749142724; x=1780678724;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=V+RGtOXj+Div4Ph+uYyTLz/ZlWZWtTVuSKRa6XJvkRE=;
  b=glcvHbI4xhobYW25ZHxH7O9sHXcvSMH1H7Za+biUkRDgWXEElhCTqSCd
   NMUVqdN8+ye+jl+Dzn5/bG9Vvx9olYRdymUXmCY0AxMxY55XY1VliZMPA
   Z+Qo6fpV1JNjUoad/HEINYOCB+CSZTSZcG4QvN7ps1GAz/+uic/RW7tjD
   IevtiUbufM0wOULrGGsqb/5Who/V0tjjGgunrkcXZS5yfGYXSkzeL4C8U
   bh64wZQ2utYsxObrot8/fQUTWXsuBosO2uIignWjox6oH/cIe+Bw1drlT
   SPGv5j+zXq3qnYMEiPHZOT5vG/YZM5blvj9uW4esXytVkr1YKhbCxhgLF
   Q==;
X-CSE-ConnectionGUID: t3BHrIU1SNaO1+81gNGmxQ==
X-CSE-MsgGUID: 9fCVKPXMSIGrPwpERi65tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="55081374"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="55081374"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 09:58:43 -0700
X-CSE-ConnectionGUID: NOPijMEIR2+RuRTbWL0dyg==
X-CSE-MsgGUID: WSA14enaRF+vDbDZschLWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="150833768"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 09:58:43 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0285C20B5736;
	Thu,  5 Jun 2025 09:58:40 -0700 (PDT)
Message-ID: <b5c3cc21-26d6-4e87-84de-fa99909bdf1c@linux.intel.com>
Date: Thu, 5 Jun 2025 12:58:38 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] perf: Fix the throttle error of some clock events
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Mark Rutland <mark.rutland@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 "linux-perf-use." <linux-perf-users@vger.kernel.org>,
 Stephane Eranian <eranian@google.com>, Chun-Tse Shao <ctshao@google.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Leo Yan <leo.yan@arm.com>,
 Aishwarya TCV <aishwarya.tcv@arm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20250604171554.3909897-1-kan.liang@linux.intel.com>
 <CAADnVQKjyzdNVR_+WCMzORPJAX00tD3HK0vaCz13ZprWaG72Tg@mail.gmail.com>
 <d5fcf34f-63fe-451b-89ad-621c38981709@linux.intel.com>
Content-Language: en-US
In-Reply-To: <d5fcf34f-63fe-451b-89ad-621c38981709@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-06-05 9:46 a.m., Liang, Kan wrote:
> 
> 
> On 2025-06-04 7:21 p.m., Alexei Starovoitov wrote:
>> On Wed, Jun 4, 2025 at 10:16 AM <kan.liang@linux.intel.com> wrote:
>>>
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> Both ARM and IBM CI reports RCU stall, which can be reproduced by the
>>> below perf command.
>>>   perf record -a -e cpu-clock -- sleep 2
>>>
>>> The issue is introduced by the generic throttle patch set, which
>>> unconditionally invoke the event_stop() when throttle is triggered.
>>>
>>> The cpu-clock and task-clock are two special SW events, which rely on
>>> the hrtimer. The throttle is invoked in the hrtimer handler. The
>>> event_stop()->hrtimer_cancel() waits for the handler to finish, which is
>>> a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART should
>>> be used to stop the timer.
>>>
>>> There may be two ways to fix it.
>>> - Introduce a PMU flag to track the case. Avoid the event_stop in
>>>   perf_event_throttle() if the flag is detected.
>>>   It has been implemented in the
>>>   https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/
>>>   The new flag was thought to be an overkill for the issue.
>>> - Add a check in the event_stop. Return immediately if the throttle is
>>>   invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
>>>   method to stop the timer.
>>>
>>> The latter is implemented here.
>>>
>>> Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
>>> the order the same as perf_event_unthrottle(). Except the patch, no one
>>> checks the hw.interrupts in the stop(). There is no impact from the
>>> order change.
>>>
>>> Reported-by: Leo Yan <leo.yan@arm.com>
>>> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
>>> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
>>> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>> Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw/
>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>> Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293@linux.ibm.com/
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>
>> It seems the patch fixes one issue and introduces another ?
>>
>> Looks like the throttle event is sticky.
>> Once it's reached the perf_event no longer works ?
> 
> No. It should still work even the throttle is triggered.
> 
> sdp@d404e6bce080:~$ sudo bash -c 'echo 10 >
> /proc/sys/kernel/perf_event_max_sample_rate'
> sdp@d404e6bce080:~$ sudo perf record -a -e cpu-clock -c10000 -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.559 MB perf.data (584 samples) ]
> sdp@d404e6bce080:~$ sudo perf record -a -e cpu-clock -c10000 -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.564 MB perf.data (613 samples) ]
> sdp@d404e6bce080:~$ sudo perf record -a -e cpu-clock -c10000 -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.545 MB perf.data (502 samples) ]
> 
> 
>> Repro:
>> test_progs -t perf_branches/perf_branches_no_hw
>> #250/2   perf_branches/perf_branches_no_hw:OK
>>
>> test_progs -t stacktrace_build_id_nmi
>> #393     stacktrace_build_id_nmi:OK
>>
>> test_progs -t perf_branches/perf_branches_no_hw
>> perf_branches/perf_branches_no_hw:FAIL
>>
> 
> Do you have more logs regarding where it's failed?
> 
> Thanks,
> Kan> Maybe it's an unrelated bug.

I tried the tests on my machine. I don't see any issues.

sdp@d404e6bce080:~/tip/tools/testing/selftests/bpf$ sudo ./test_progs -t
perf_branches/perf_branches_no_hw
#240/2   perf_branches/perf_branches_no_hw:OK
#240     perf_branches:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
sdp@d404e6bce080:~/tip/tools/testing/selftests/bpf$ sudo ./test_progs -t
stacktrace_build_id_nmi
#376     stacktrace_build_id_nmi:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
sdp@d404e6bce080:~/tip/tools/testing/selftests/bpf$ sudo ./test_progs -t
perf_branches/perf_branches_no_hw
#240/2   perf_branches/perf_branches_no_hw:OK
#240     perf_branches:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
sdp@d404e6bce080:~/tip/tools/testing/selftests/bpf$ sudo ./test_progs -t
stacktrace_build_id_nmi
#376     stacktrace_build_id_nmi:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
sdp@d404e6bce080:~/tip/tools/testing/selftests/bpf$ sudo ./test_progs -t
perf_branches/perf_branches_no_hw
#240/2   perf_branches/perf_branches_no_hw:OK
#240     perf_branches:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED


Thanks,
Kan
