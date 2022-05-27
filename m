Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD66C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 May 2022 14:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347786AbiE0Oy3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 May 2022 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbiE0Oy2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 May 2022 10:54:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B135F12E331;
        Fri, 27 May 2022 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653663266; x=1685199266;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B30RuRFE5S9UQxQhIU/oFdlqy26VTGbgzrAhSIpCMEc=;
  b=O8U2oe3soier2ccmdsisQPhU3OGQDYDk4TYoMiaLCpv0YigK6050Lqkr
   oOH+R3i0p6dHS54JpgVSi0PH+2GOObFRiEZRwtHn/G4nfQc4cLgGTGDNJ
   Uj0LNCrfFxWs5aBlNFt1bLfYISiSg4Ah1M2cSgUnTNahN6xzhPhAjYrIA
   kIP87HSSrFEOqVmBAJPdGGDGnMvOtd+Xw7cBCDG1nrYKWUJJpulY7hOXS
   aN/LoMuXzRd0fzbjECp/iPZvbBABsBuKn3MKJEjPKGSNu8jTeakWDzuaT
   C1i/bTpgX1LFBjwz/rXBYcR7etSGpNFpi4LY8VsKicgNw94xdz3zOsVaK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="273312071"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="273312071"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 07:54:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="550243644"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.251.21.118]) ([10.251.21.118])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 07:54:25 -0700
Message-ID: <76dce5d3-6c69-e403-c4d9-f882967a4467@linux.intel.com>
Date:   Fri, 27 May 2022 07:54:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] perf metrics: Add literal for system TSC frequency
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>
Cc:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220527040407.4193232-1-irogers@google.com>
 <YpCeo6APNtXvrTPJ@hirez.programming.kicks-ass.net>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <YpCeo6APNtXvrTPJ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 5/27/2022 2:49 AM, Peter Zijlstra wrote:
> On Thu, May 26, 2022 at 09:04:07PM -0700, Ian Rogers wrote:
>> Such a literal is useful to calculate things like the average frequency
>> [1]. The TSC frequency isn't exposed by sysfs although some experimental
>> drivers look to add it [2]. This change computes the value using the
>> frequency in /proc/cpuinfo which is accurate at least on Intel
>> processors.

It would be better to use CPUID if available which is far more accurate. 
Also I believe newer Intel CPUs drop the frequency in the brand string.

BTW it also has the problem that if perf script is run on some other 
system to compute metrics it won't work.

>
> This all seems bonghits inspired... and perf actually does expose the
> tsc frequency. What do you think is in perf_event_mmap_page::time_* ?


That's not really available to perf stat, which is the primary metrics user.


-Andi



