Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9156426AA82;
	Thu,  5 Jun 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131198; cv=none; b=QJPJcMdDXYFuNVPjqSfkl8kqxJJULPfTofBukjz2trfCt7WUm8hBFTo9NaL6WpK6LAA2MzVi/aYqL1c5xx1HwpOF/ptlnYJM121720Pgo7wD/LTWuxIAgR4mFoU8ro0H2ikAweUek4tT2Ztb9HyiTOc1U+SBBmmOPHxVUQwb4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131198; c=relaxed/simple;
	bh=Tpf9ItGaBou0FWnVAa3e7cYiVATjsvVi5B2ILbnbgAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eT9C+N4U1Ye5M8d9/dQThWSCUk+BiVNte4swuNT8yat/py8mvQPWuDgmEmiUyFW2MVu1vW65kh2kGcPQmDvl6VOiYnNtxBqClOzNbmYpH+dHl0WFMdYqjtdotrtzyqTGVZgRegy8YzP4Avxs63RHY3xaUPXG4FjoqHna8VAWTjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMUUy8l7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMUUy8l7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749131197; x=1780667197;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tpf9ItGaBou0FWnVAa3e7cYiVATjsvVi5B2ILbnbgAc=;
  b=nMUUy8l7SCUuxShDmR9ax6+uSKS8uW5k7SClpA5juijbGL2oFVBH0PrL
   kDQMQ0VBwukItViF8FYaKuyHiSitvxOEhRe76Q93PEYqSFbr/fziGR64f
   AwHGFpcYAvhz+e5Hlyarj+ZJ+zOzRR1uoKeuXvmDYA/pkGLtmkhTqXSa7
   L2+zRl63Eq+l2jDZSi9ducW8TU0tttMiDYj8hmoZMBtDEisAYSeeM5sra
   ESJB3A09sIXYqoDj/dNLd4IfxLDmEhKF8WWAaiW5INR2Orv2U5CdmE7++
   3A4ERZmPcWTZrYJxg85FiIC6GF7FzGMOb1y0Zx1VZqsBH6y5v994kg/Wf
   w==;
X-CSE-ConnectionGUID: RgKyhc41QJeGsd26H/HLLQ==
X-CSE-MsgGUID: vbMp3goqRp2rErDWsQOYrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="73782036"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="73782036"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 06:46:37 -0700
X-CSE-ConnectionGUID: Kj+CZmbWSh+lfX1+Useb+w==
X-CSE-MsgGUID: Iw4kSaOnQ46FeR9Srzp1cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="145391614"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 06:46:36 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B052E20B5736;
	Thu,  5 Jun 2025 06:46:33 -0700 (PDT)
Message-ID: <d5fcf34f-63fe-451b-89ad-621c38981709@linux.intel.com>
Date: Thu, 5 Jun 2025 09:46:32 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] perf: Fix the throttle error of some clock events
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAADnVQKjyzdNVR_+WCMzORPJAX00tD3HK0vaCz13ZprWaG72Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-06-04 7:21 p.m., Alexei Starovoitov wrote:
> On Wed, Jun 4, 2025 at 10:16 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Both ARM and IBM CI reports RCU stall, which can be reproduced by the
>> below perf command.
>>   perf record -a -e cpu-clock -- sleep 2
>>
>> The issue is introduced by the generic throttle patch set, which
>> unconditionally invoke the event_stop() when throttle is triggered.
>>
>> The cpu-clock and task-clock are two special SW events, which rely on
>> the hrtimer. The throttle is invoked in the hrtimer handler. The
>> event_stop()->hrtimer_cancel() waits for the handler to finish, which is
>> a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART should
>> be used to stop the timer.
>>
>> There may be two ways to fix it.
>> - Introduce a PMU flag to track the case. Avoid the event_stop in
>>   perf_event_throttle() if the flag is detected.
>>   It has been implemented in the
>>   https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/
>>   The new flag was thought to be an overkill for the issue.
>> - Add a check in the event_stop. Return immediately if the throttle is
>>   invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
>>   method to stop the timer.
>>
>> The latter is implemented here.
>>
>> Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
>> the order the same as perf_event_unthrottle(). Except the patch, no one
>> checks the hw.interrupts in the stop(). There is no impact from the
>> order change.
>>
>> Reported-by: Leo Yan <leo.yan@arm.com>
>> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
>> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
>> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw/
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293@linux.ibm.com/
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> It seems the patch fixes one issue and introduces another ?
> 
> Looks like the throttle event is sticky.
> Once it's reached the perf_event no longer works ?

No. It should still work even the throttle is triggered.

sdp@d404e6bce080:~$ sudo bash -c 'echo 10 >
/proc/sys/kernel/perf_event_max_sample_rate'
sdp@d404e6bce080:~$ sudo perf record -a -e cpu-clock -c10000 -- sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.559 MB perf.data (584 samples) ]
sdp@d404e6bce080:~$ sudo perf record -a -e cpu-clock -c10000 -- sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.564 MB perf.data (613 samples) ]
sdp@d404e6bce080:~$ sudo perf record -a -e cpu-clock -c10000 -- sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.545 MB perf.data (502 samples) ]


> Repro:
> test_progs -t perf_branches/perf_branches_no_hw
> #250/2   perf_branches/perf_branches_no_hw:OK
> 
> test_progs -t stacktrace_build_id_nmi
> #393     stacktrace_build_id_nmi:OK
> 
> test_progs -t perf_branches/perf_branches_no_hw
> perf_branches/perf_branches_no_hw:FAIL
> 

Do you have more logs regarding where it's failed?

Thanks,
Kan> Maybe it's an unrelated bug.
> 

