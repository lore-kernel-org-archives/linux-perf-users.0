Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4D5620;
	Tue,  9 Jul 2024 04:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720498683; cv=none; b=uGdUeoRe8VV7umanlACq3JQ/uWLR1z/5c46Ci4MyJuuFqiaX+CZmtzjJ1NFlHyvTZBNEiCvcg8UD7LcBIsv7vupYZKzf1nPxP/IS0Ctafsua7lpXidSJng8vQd3J3OMA9hZ7loabAcvDIxV3l+ypsQrsnhwGlxVQr7lVJGdE87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720498683; c=relaxed/simple;
	bh=0umrLKs/D2wKddOhXgjcIazLSq/Hbp2xYf2rHZ28AWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCOgviUnU8BuObHx3AoV6t/3VEwbhaTJbn+WMVWwzR00fNWko4RvzfEI0wMwWTYlWVNw1Esah8cUEkVvMxnrDKTk4t87i9oCUO6Igtfds97e0yeYlmP6ZrQIgYAYClzkPXjPc9VB7YCENwsxhFH1iCKerul8L+uH6kvzP51AnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsZtANPc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsZtANPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720498682; x=1752034682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0umrLKs/D2wKddOhXgjcIazLSq/Hbp2xYf2rHZ28AWE=;
  b=BsZtANPcFC/tb+opb3KCcGRJoJD+A/EkFJW0zvMQtPbQJT8FQc6Q3VdZ
   1FrQJCkkLU4hi1gaeZ5jGke6LjbuPzkIdXo4qsNqgaF05MOVL5VjpRsO/
   dOVHrz33tChk/07Wns7gO9wm39NurHS9FO+JDX6VQ68sqHfQSGdDWOvqI
   GgjfaoWqz72DvlZWmaWQXB23tyBoyfOEve9Cdt3L7aaBlg8uioLmsZbWo
   laDxOW2Wz2nQ8UXQJu74QQy5flkxcTyHhJCNxIQAzUAejz5/8PCT/hrfv
   Q0KIZjrDbMZVFtPSalvGVJLCwJ4Hgj7AnAqLmjNkLCvFpY3BTyfXrXxio
   A==;
X-CSE-ConnectionGUID: C2C4NYU+QaWMP2aIUSMXNw==
X-CSE-MsgGUID: AmzsL0vrQBqv38noG311hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28329276"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="28329276"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 21:18:01 -0700
X-CSE-ConnectionGUID: gRwl7b5SQJmWxa09PlzioA==
X-CSE-MsgGUID: Oh/y5CggR2GOqiWy9JytEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="48381604"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 21:17:57 -0700
Message-ID: <4d39856e-396d-4a48-9ca3-2e1a574f50d7@linux.intel.com>
Date: Tue, 9 Jul 2024 12:17:54 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 3/5] perf x86/topdown: Don't move topdown metrics
 events when sorting events
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
 <20240708144204.839486-4-dapeng1.mi@linux.intel.com>
 <CAP-5=fVPb4JGR3RxfPBGrihrra8bFzdJfFt2iASSs2xHOy=U4g@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fVPb4JGR3RxfPBGrihrra8bFzdJfFt2iASSs2xHOy=U4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/8/2024 11:08 PM, Ian Rogers wrote:
> On Mon, Jul 8, 2024 at 12:40 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> when running below perf command, we say error is reported.
>>
>> perf record -e "{slots,instructions,topdown-retiring}:S" -vv -C0 sleep 1
>>
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                             4 (cpu)
>>   size                             168
>>   config                           0x400 (slots)
>>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>>   read_format                      ID|GROUP|LOST
>>   disabled                         1
>>   sample_id_all                    1
>>   exclude_guest                    1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                             4 (cpu)
>>   size                             168
>>   config                           0x8000 (topdown-retiring)
>>   { sample_period, sample_freq }   4000
>>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>>   read_format                      ID|GROUP|LOST
>>   freq                             1
>>   sample_id_all                    1
>>   exclude_guest                    1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
>> sys_perf_event_open failed, error -22
>>
>> Error:
>> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-retiring).
>>
>> The reason of error is that the events are regrouped and
>> topdown-retiring event is moved to closely after the slots event and
>> topdown-retiring event needs to do the sampling, but Intel PMU driver
>> doesn't support to sample topdown metrics events.
>>
>> For topdown metrics events, it just requires to be in a group which has
>> slots event as leader. It doesn't require topdown metrics event must be
>> closely after slots event. Thus it's a overkill to move topdown metrics
>> event closely after slots event in events regrouping and furtherly cause
>> the above issue.
>>
>> Thus delete the code that moving topdown metrics events to fix the
>> issue.
> I think this is wrong. The topdown events may not be in a group, such
> cases can come from metrics due to grouping constraints, and so they
> must be sorted together so that they may be gathered into a group to
> avoid the perf event opens failing for ungrouped topdown events. I'm
> not understanding what these patches are trying to do, if you want to
> prioritize the event for leader sampling why not modify it to compare

Per my understanding, this change doesn't break anything. The events
regrouping can be divided into below several cases.

a. all events in a group

perf stat -e "{instructions,topdown-retiring,slots}" -C0 sleep 1
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'CPU(s) 0':

        15,066,240      slots
         1,899,760      instructions
         2,126,998      topdown-retiring

       1.045783464 seconds time elapsed

In this case, slots event would be adjusted as the leader event and all
events are still in same group.

b. all events not in a group

perf stat -e "instructions,topdown-retiring,slots" -C0 sleep 1
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'CPU(s) 0':

         2,045,561      instructions
        17,108,370      slots
         2,281,116      topdown-retiring

       1.045639284 seconds time elapsed

In this case, slots and topdown-retiring are placed into a group and slots
is the group leader. instructions event is outside the group.

c. slots event in group but topdown metric events outside the group

perf stat -e "{instructions,slots},topdown-retiring"  -C0 sleep 1
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'CPU(s) 0':

        20,323,878      slots
         2,634,884      instructions
         3,028,656      topdown-retiring

       1.045076380 seconds time elapsed

In this case, topdown-retiring event is placed into previous group and
slots is adjusted to leader event.

d. multiple event groups

perf stat -e "{instructions,slots},{topdown-retiring}"  -C0 sleep 1
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'CPU(s) 0':

        26,319,024      slots
         2,427,791      instructions
         2,683,508      topdown-retiring

       1.045495830 seconds time elapsed

In this case, the two groups are merged to one group and slots event is
adjusted as leader.

The key point of this patch is that it's unnecessary to move topdown
metrics events closely after slots event. It's a overkill since Intel core
PMU driver doesn't require that. Intel PMU driver just requires topdown
metrics events are in a group where slots event is the group leader, and
worse the movement for topdown metrics events causes the issue in the
commit message mentioned.

This patch doesn't block to regroup topdown metrics event. It just removes
the unnecessary movement for topdown metrics events.


> first?
>
> Thanks,
> Ian
>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/arch/x86/util/evlist.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
>> index 332e8907f43e..6046981d61cf 100644
>> --- a/tools/perf/arch/x86/util/evlist.c
>> +++ b/tools/perf/arch/x86/util/evlist.c
>> @@ -82,11 +82,6 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>>                         return -1;
>>                 if (arch_is_topdown_slots(rhs))
>>                         return 1;
>> -               /* Followed by topdown events. */
>> -               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>> -                       return -1;
>> -               if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
>> -                       return 1;
>>         }
>>
>>         /* Default ordering by insertion index. */
>> --
>> 2.40.1
>>
