Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8C2BEC2C;
	Wed, 12 Nov 2025 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935653; cv=none; b=XjLILVao3Kz/SAnsKcCwFDJGUQ6NO1IUoUb/SLUS13VbqgwPzqWO8ojE67Dvul+mvqLSkqHLE7uKee9F9Q+IgTnfv4Un5x/lmrQAF9mwjdc740urxK03UoPuzPLyjg0RSjY8MS/+v0SnGmM3ZAqiaUAlg222N39Rg5H95ultcXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935653; c=relaxed/simple;
	bh=tDovnU/F87QjMyIAitrnddCeo2J61Wr57VXrCYCk5Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UI0NKFVBpPXXCFHkPUuB0NI1ktXfmnt0+kD0QuEx6VxvoyCwEBull8IgIik9oodHW0tO3SIufEIxzhp24aIoUx/TsxrxVAdAPmKonuIpbLOZ2cBQ21C7ryUQtG/ZQYSVM4NOrAJyl3Flx+Aur6H6aZzcP7WEqqzAo3/u148oZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1XxyZsi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1XxyZsi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762935652; x=1794471652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tDovnU/F87QjMyIAitrnddCeo2J61Wr57VXrCYCk5Bo=;
  b=e1XxyZsiVwuKX3gAZCJ6id3qEGtN/IrJGXaSbfkmMcVXa1DM7lGXFfGe
   Ntx0LaLzECTtzvosQoNpbNuFtJ5CExNp5yl9PajH7O6Q7S9aqSKaxo+cL
   5Mg8+HsH7XIstefmwP4mNiMi1Ljm3wMIuF6RFOnPSZ3/5TksAJhaIVxq3
   xkzdrgVIdO5NkZIS6w/h4bPu5eQG51MpPPUz4q64VXVQLx9DRbHGwdcC9
   yGsX8wE/LGsj6P8G78zmaP+ihQBm1Ckf7/ShMTP8bvfw28DmMkZXt1uAO
   3mOGAdeW51roCKuyommO1tMcj02wYTBdxl0SfWhDu28KIa6aY5xHjJj2q
   w==;
X-CSE-ConnectionGUID: CWRWk52vQ96OFnFuQtOymg==
X-CSE-MsgGUID: wjZ7QCQvTRatNBeK1IEgNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76342846"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="76342846"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:20:51 -0800
X-CSE-ConnectionGUID: hEXvl5iUS8yuNL7za2zs1w==
X-CSE-MsgGUID: nQFEgVN8TxaYi7k8/rZa7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="194135950"
Received: from unknown (HELO [10.238.3.175]) ([10.238.3.175])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 00:20:46 -0800
Message-ID: <b81536bd-6e03-431d-9f9f-5d048fd69f2f@linux.intel.com>
Date: Wed, 12 Nov 2025 16:20:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/18]
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
 Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Collin Funk <collin.funk1@gmail.com>, Thomas Falcon
 <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>,
 Levi Yun <yeoreum.yun@arm.com>, Yang Li <yang.lee@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
References: <20251111212206.631711-1-irogers@google.com>
 <aRO7vPpfuH7vzRg-@google.com>
 <CAP-5=fWQqsAHZvyxu6db5Qyfx0n-2pNeYDP7u_WtpxKr2TLHxA@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWQqsAHZvyxu6db5Qyfx0n-2pNeYDP7u_WtpxKr2TLHxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/12/2025 7:13 AM, Ian Rogers wrote:
> On Tue, Nov 11, 2025 at 2:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
>> On Tue, Nov 11, 2025 at 01:21:48PM -0800, Ian Rogers wrote:
>>> Prior to this series stat-shadow would produce hard coded metrics if
>>> certain events appeared in the evlist. This series produces equivalent
>>> json metrics and cleans up the consequences in tests and display
>>> output. A before and after of the default display output on a
>>> tigerlake is:
>>>
>>> Before:
>>> ```
>>> $ perf stat -a sleep 1
>>>
>>>  Performance counter stats for 'system wide':
>>>
>>>     16,041,816,418      cpu-clock                        #   15.995 CPUs utilized
>>>              5,749      context-switches                 #  358.376 /sec
>>>                121      cpu-migrations                   #    7.543 /sec
>>>              1,806      page-faults                      #  112.581 /sec
>>>        825,965,204      instructions                     #    0.70  insn per cycle
>>>      1,180,799,101      cycles                           #    0.074 GHz
>>>        168,945,109      branches                         #   10.532 M/sec
>>>          4,629,567      branch-misses                    #    2.74% of all branches
>>>  #     30.2 %  tma_backend_bound
>>>                                                   #      7.8 %  tma_bad_speculation
>>>                                                   #     47.1 %  tma_frontend_bound
>>>  #     14.9 %  tma_retiring
>>> ```
>>>
>>> After:
>>> ```
>>> $ perf stat -a sleep 1
>>>
>>>  Performance counter stats for 'system wide':
>>>
>>>              2,890      context-switches                 #    179.9 cs/sec  cs_per_second
>>>     16,061,923,339      cpu-clock                        #     16.0 CPUs  CPUs_utilized
>>>                 43      cpu-migrations                   #      2.7 migrations/sec  migrations_per_second
>>>              5,645      page-faults                      #    351.5 faults/sec  page_faults_per_second
>>>          5,708,413      branch-misses                    #      1.4 %  branch_miss_rate         (88.83%)
>>>        429,978,120      branches                         #     26.8 M/sec  branch_frequency     (88.85%)
>>>      1,626,915,897      cpu-cycles                       #      0.1 GHz  cycles_frequency       (88.84%)
>>>      2,556,805,534      instructions                     #      1.5 instructions  insn_per_cycle  (88.86%)
>>>                         TopdownL1                 #     20.1 %  tma_backend_bound
>>>                                                   #     40.5 %  tma_bad_speculation      (88.90%)
>>>                                                   #     17.2 %  tma_frontend_bound       (78.05%)
>>>                                                   #     22.2 %  tma_retiring             (88.89%)
>>>
>>>        1.002994394 seconds time elapsed
>>> ```
>>>
>>> Having the metrics in json brings greater uniformity, allows events to
>>> be shared by metrics, and it also allows descriptions like:
>>> ```
>>> $ perf list cs_per_second
>>> ...
>>>   cs_per_second
>>>        [Context switches per CPU second]
>>> ```
>>>
>>> A thorn in the side of doing this work was that the hard coded metrics
>>> were used by perf script with '-F metric'. This functionality didn't
>>> work for me (I was testing `perf record -e instructions,cycles`
>>> with/without leader sampling and then `perf script -F metric` but saw
>>> nothing but empty lines) but anyway I decided to fix it to the best of
>>> my ability in this series. So the script side counters were removed
>>> and the regular ones associated with the evsel used. The json metrics
>>> were all searched looking for ones that have a subset of events
>>> matching those in the perf script session, and all metrics are
>>> printed. This is kind of weird as the counters are being set by the
>>> period of samples, but I carried the behavior forward. I suspect there
>>> needs to be follow up work to make this better, but what is in the
>>> series is superior to what is currently in the tree. Follow up work
>>> could include finding metrics for the machine in the perf.data rather
>>> than using the host, allowing multiple metrics even if the metric ids
>>> of the events differ, fixing pre-existing `perf stat record/report`
>>> issues, etc.
>>>
>>> There is a lot of stat tests that, for example, assume '-e
>>> instructions,cycles' will produce an IPC metric. These things needed
>>> tidying as now the metric must be explicitly asked for and when doing
>>> this ones using software events were preferred to increase
>>> compatibility. As the test updates were numerous they are distinct to
>>> the patches updating the functionality causing periods in the series
>>> where not all tests are passing. If this is undesirable the test fixes
>>> can be squashed into the functionality updates, but this will be kind
>>> of messy, especially as at some points in the series both the old
>>> metrics and the new metrics will be displayed.
>>>
>>> v4: K/sec to M/sec on branch frequency (Namhyung), perf script -F
>>>     metric to-done a system-wide calculation (Namhyung) and don't
>>>     crash because of the CPU map index couldn't be found. Regenerate
>>>     commit messages but the cpu-clock was always yielding 0 on my
>>>     machine leading to a lot of nan metric values.
>> This is strange.  The cpu-clock should not be 0 as long as you ran it.
>> Do you think it's related to the scale unit change?  I tested v3 and
>> didn't see the problem.
> It looked like a kernel issue. The raw counts were 0 before being
> scaled. All metrics always work on unscaled values. It is only the
> commit messages and the formatting is more important than the numeric
> values - which were correct for a cpu-clock of 0.

Yes, It's a kernel issue. I also found it several days ago. I have posted a
patch to fix it. :)

https://lore.kernel.org/all/20251112080526.3971392-1-dapeng1.mi@linux.intel.com/


>
> Thanks,
> Ian
>
