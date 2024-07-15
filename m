Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85C633C5;
	Mon, 15 Jul 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073933; cv=none; b=hC2NeEBowJFXwkYKasUEfnM9cFHY+bNYJGV+EAoZjMlaRL0EWLxK19IvPK1P65kUah12hd4vzV2/jl0qGSY7ZXrokvFq8F4BFndrwmyxG5u5zDbrgp2iHLDqClnz81ptBZk2oyuR+ibzXCv4c/5hKMdLvKpMQl5H4c90DxIMt8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073933; c=relaxed/simple;
	bh=/DOi2ls71ic2OyuxBaWpZlE+L/2u4kMQ6x6k0YhB6TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MboqXMSa1tXrvxXBpfPz4uXaC8olsWp12gpG/idNDHxOBe5/QoB0GQMNO2Qz8ZYkfNlaTqaKRhlJzrQJBlsN2VreQ2Lisw4HXUHR+5L+BKiRSsVIYX5OnJyeXnDIPy1HcxigX5NE0K6/sfbm2PNeo826gSVXs86InJz6XbNlL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RurrY/Ry; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RurrY/Ry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721073931; x=1752609931;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/DOi2ls71ic2OyuxBaWpZlE+L/2u4kMQ6x6k0YhB6TY=;
  b=RurrY/RyQjpsBhmmn2MhWHuDywQxYNcJ7WWaywEo2iA1TE2uhgO5p87u
   Ji0u0sz5cHByD02GbmJsH3W2t2B8A2HX56IumxMJLU9XAwnj00ho31/ZS
   xIoHND8jaGv8ClIOqE4Ynq6wg7aZGU+9NZhJu3dA8YVhtsag4I37fJPo0
   4uHLTmr45KiuvTcMyeE7GoKBo9IpmqPNKEwFszOQiH8rc17od7U2v1e4A
   B2D86lcKKpItQVFwz7PHOtRJxGI00AQtAg0dnY01OocJBHmJKXQ/IMlLO
   B9xFFxToZrvWuXG/P9qwiB9sshi9u7OkOeX6VOwA5VDM6eHIPqNp8GfwE
   w==;
X-CSE-ConnectionGUID: vuawb8eESxO7Tllhwb6WlQ==
X-CSE-MsgGUID: dfxWTIX6SPejopNN2lmKBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18615566"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18615566"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 13:05:31 -0700
X-CSE-ConnectionGUID: wFLa480YSAa2EZOT+0vNKw==
X-CSE-MsgGUID: y16IyOeCRt2hKFkEqfJpxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49591891"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 13:05:31 -0700
Received: from [10.212.96.36] (kliang2-mobl1.ccr.corp.intel.com [10.212.96.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id ED7D620B8CD6;
	Mon, 15 Jul 2024 13:05:28 -0700 (PDT)
Message-ID: <ec744c86-b73e-417a-8e3a-c07142bf37d1@linux.intel.com>
Date: Mon, 15 Jul 2024 16:05:27 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [perf vendor events] e2641db83f:
 perf-sanity-tests.perf_all_PMU_test.fail
To: kernel test robot <oliver.sang@intel.com>, Ian Rogers <irogers@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Namhyung Kim <namhyung@kernel.org>, Weilin Wang <weilin.wang@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202407101021.2c8baddb-oliver.sang@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <202407101021.2c8baddb-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ian,

On 2024-07-10 12:59 a.m., kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "perf-sanity-tests.perf_all_PMU_test.fail" on:
> 
> commit: e2641db83f18782f57a0e107c50d2d1731960fb8 ("perf vendor events: Add/update skylake events/metrics")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b04384257]
> 
> in testcase: perf-sanity-tests
> version: 
> with following parameters:
> 
> 	perf_compiler: gcc
> 
> 
> 
> compiler: gcc-13
> test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> we also observed two cases which also failed on parent can pass on this commit.
> FYI.
> 
> 
> caccae3ce7b988b6 e2641db83f18782f57a0e107c50
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     perf-sanity-tests.perf_all_PMU_test.fail
>            :6          100%           6:6     perf-sanity-tests.perf_all_metricgroups_test.pass
>            :6          100%           6:6     perf-sanity-tests.perf_all_metrics_test.pass
> 
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202407101021.2c8baddb-oliver.sang@intel.com
> 
> 
> 
> 2024-07-09 07:09:53 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 105
> 105: perf all metricgroups test                                      : Ok
> 2024-07-09 07:10:11 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 106
> 106: perf all metrics test                                           : Ok
> 2024-07-09 07:10:23 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 107
> 107: perf all libpfm4 events test                                    : Ok
> 2024-07-09 07:10:47 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 108
> 108: perf all PMU test                                               : FAILED!
>

The failure is caused by the below change in the e2641db83f18.

+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK
cycles",
+        "Counter": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "PublicDescription": "This 48-bit fixed counter counts the UCLK
cycles.",
+        "Unit": "cbox_0"
     }

The other cbox events have the unit name "CBOX", while the fixed counter
has a unit name "cbox_0". So the events_table will maintain separate
entries for cbox and cbox_0.

The perf_pmus__print_pmu_events() calculate the total number of events,
allocate an aliases buffer, store all the events into the buffer, sort,
and print all the aliases one by one.

The problem is that the calculated total number of events doesn't match
the stored events on the SKL machine.

The perf_pmu__num_events() is used to calculate the number of events. It
invokes the pmu_events_table__num_events() to go through the entire
events_table to find all events. Because of the
pmu_uncore_alias_match(), the suffix of uncore PMU will be ignored. So
the events for cbox and cbox_0 are all counted.

When storing events into the aliases buffer, the
perf_pmu__for_each_event() only process the events for cbox.

Since a bigger buffer was allocated, the last entry are all 0.
When printing all the aliases, null will be outputed.

$ perf list pmu

List of pre-defined events (to be used in -e or -M):

  (null)                                             [Kernel PMU event]
  branch-instructions OR cpu/branch-instructions/    [Kernel PMU event]
  branch-misses OR cpu/branch-misses/                [Kernel PMU event]


I'm thinking of two ways to address it.
One is to only print all the stored events. The below patch can fix it.

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3fcabfd8fca1..2b2f5117ff84 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -485,6 +485,7 @@ void perf_pmus__print_pmu_events(const struct
print_callbacks *print_cb, void *p
 		perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
 					perf_pmus__print_pmu_events__callback);
 	}
+	len = state.index;
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (int j = 0; j < len; j++) {
 		/* Skip duplicates */

The only drawback is that perf list will not show the new cbox_0 event.
(But the event name still works. Users can still apply perf stat -e
unc_clock.socket.)

Since the cbox_0 event is only available on old machines (SKL and
earlier), people should already use the equivalent kernel event. It
doesn't sounds a big issue for me. I prefer this simple fix.

I think the other way would be to modify the perf_pmu__for_each_event()
to go through all the possible PMUs.
It seems complicated and may impact others ARCHs (e.g., S390). I haven't
tried it yet.

What do you think?
Do you see any other ways to address the issue?

Thanks,
Kan
