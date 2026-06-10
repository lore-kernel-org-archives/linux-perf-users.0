Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C23328611;
	Wed, 10 Jun 2026 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056080; cv=none; b=o5qi6EK8Eas890qed3F7et5dk+8U3RwYHIO0o/h96dpCoaGdbq9gyfQPcfsthH0xAgd2CebmgpIqRqOH5kEv2H5T/lOXMIKRY1nh9vplWxA94pg6EIRZnmfDgwaftBefQ4e+ReicgvsOlnBjgQxC0rE2THTiBtZfZMrmKA8g94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056080; c=relaxed/simple;
	bh=T5yJMN8rRvTP14H+vNXf9dcMaiK+Ou2hENgINVWFdIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVDAxcAlNCFASly3pHwAuoRDTimhewOXEJZL+it8C8FIjI6JbwWUA5mafa4YtbEGAddBiyg6eakK+sXcBTcd4Cw8Z59aVYwFY0hQezFTr8DitM85XWSjsv6GZF6P71nO6NvwlnxMw94pLsAizLUi1C289xtHi6sCb9VE2e+pYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JuEwjoQK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuEwjoQK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781056077; x=1812592077;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T5yJMN8rRvTP14H+vNXf9dcMaiK+Ou2hENgINVWFdIk=;
  b=JuEwjoQK2IqtdfAQaXv7QeXtXbrohOxkt0BI4VDOOxs4cv30v24f3UId
   oPpqiFWNYLMZnhucwMvEL5U9eXpCpvTw3WD39xWa4YIfCWXa8Ygg7GCwQ
   IAXdZ5eu5XA8atF615+FBIq/9gbm4gBVinsHsAXu+ot4o6LyjlnFilUR7
   abwS9Y//0Ws6Fr/FYEnGrMIzMG1tJhxkKrZDfb2c7S5HrMCpsMGEqfp6L
   gay8JLSnwEJzdzdWX6PFYCxhqCOW4ulC9bPOGUd/FC8VYd2hjKO8rl86R
   Lu/AScmTWJHE6FN0Jvj7+a2QF8NryesI5v96hrhphrZoKrVPlziT8Oxxz
   A==;
X-CSE-ConnectionGUID: ZcW3IO/6RJOH+HoUmr4qzA==
X-CSE-MsgGUID: kx6yS+mXRu2t02McGDkE5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92513315"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="92513315"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 18:47:56 -0700
X-CSE-ConnectionGUID: cgGCwSRbTJuwiSYW0nIwCg==
X-CSE-MsgGUID: QfZ4GDfURMyhryvjcIglJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="243056771"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 18:47:53 -0700
Message-ID: <d8c41bd3-d167-41d0-8b49-042b16607101@linux.intel.com>
Date: Wed, 10 Jun 2026 09:47:50 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 3/9] perf/x86: Update cap_user_rdpmc base on rdpmc user
 disable state
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-4-dapeng1.mi@linux.intel.com>
 <20260609144812.GB49951@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260609144812.GB49951@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/9/2026 10:48 PM, Peter Zijlstra wrote:
> On Tue, Jun 09, 2026 at 01:02:16PM +0800, Dapeng Mi wrote:
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 3bd0522afe6d..6cd95b8e31cb 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2797,6 +2797,9 @@ void arch_perf_update_userpage(struct perf_event *event,
>>  	userpg->cap_user_time_zero = 0;
>>  	userpg->cap_user_rdpmc =
>>  		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
>> +	if (x86_pmu_has_rdpmc_user_disable(event->pmu) &&
>> +	    event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
>> +		userpg->cap_user_rdpmc = 0;
>>  	userpg->pmc_width = x86_pmu.cntval_bits;
>>  
>>  	if (!using_native_sched_clock() || !sched_clock_stable())
> Remember, this is evaluated very very often. So it makes more sense to
> ensure the hw.flags state is correct such that this remains a simple
> expression.

Yes, directly manipulating PERF_EVENT_FLAG_USER_READ_CNT is a simpler way.
Thanks.

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6cd95b8e31cb..3bd0522afe6d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2797,9 +2797,6 @@ void arch_perf_update_userpage(struct perf_event *event,
        userpg->cap_user_time_zero = 0;
        userpg->cap_user_rdpmc =
                !!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
-       if (x86_pmu_has_rdpmc_user_disable(event->pmu) &&
-           event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
-               userpg->cap_user_rdpmc = 0;
        userpg->pmc_width = x86_pmu.cntval_bits;

        if (!using_native_sched_clock() || !sched_clock_stable())
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index efd9caa3502c..afb86e5611bf 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3532,10 +3532,13 @@ static void
intel_pmu_update_rdpmc_user_disable(struct perf_event *event)
         */
        if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_ENABLE ||
            (x86_pmu.attr_rdpmc == X86_USER_RDPMC_CONDITIONAL_ENABLE &&
-            event->ctx->task))
+            event->ctx->task)) {
                event->hw.config &= ~ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
-       else
+       } else {
                event->hw.config |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
+               if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
+                       event->hw.flags &= ~PERF_EVENT_FLAG_USER_READ_CNT;
+       }
 }


