Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94790201278;
	Tue, 13 Jan 2026 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768271394; cv=none; b=rQy3ZPPgLDknCW5K1QD7b9hen3e4kGr+QFdt7kZZbi4vvXroYXJLB1o3TVveQbg51ewNqo2T3zdnNOIgX9NdohzEUeZ+kpATZ/gnAGkoPZHPE99LJWvR/BdZ5tfH8WzRpSbULAszAQpi2zhO+1bW/uAtzRq7EBhNAqEBzmWB8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768271394; c=relaxed/simple;
	bh=/R8dHtXcKpyPoXVvJ4FTpRAkbLS4LXUM+SZLruABheo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJ3HiwCx7SVO1W2V6XmXugJiSsvO22YOJAafjZcB7mvd9y3mHk4kKxnFKk2sh2dCJwhBbrVf2egIRHxSak5mDjKFb8xSmRl+vUDLHMKivFGlyUqFVCFqgBZPH5OfJuKFU2mzmbaiV3Ko1PjPZ1gRRGCbYOnO9Frq0TL79Xe0kK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKybxUcD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKybxUcD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768271393; x=1799807393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/R8dHtXcKpyPoXVvJ4FTpRAkbLS4LXUM+SZLruABheo=;
  b=MKybxUcDC60h9S69/X5yZuA7Zs677Ygq+NfhbYNUBi1NrlciEa7KjL81
   2y6f90AFtm4v2J8+gsZOIU97VxFntpF3FuCRcjgwGezb3pXK+3tWF+JX7
   6GUqW+VeCK6NE7dtyBouiYfqm02KMdngzqRoGz722d6CVSzXVbDyNTISw
   Bw/vvQ0wuag436nW3BaDgZ8H2P2CSQQVeHW1w+uneM40KbvYbil6QXoiW
   H82T0EEgHs8tqIgWLEvc0aoe4ewLA/vU7FH8KHMZmUZ8nwGiQCm62t/Th
   nfjABHajqfPHPNVMWtQKGL6g5rnzMqzulv0dQ9DR8IsrYgZC4i6eWI5rE
   w==;
X-CSE-ConnectionGUID: oejvZasXQaGhi+axuyn/LA==
X-CSE-MsgGUID: KRZ6yLH1Ts+E7qee/noI9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="80271734"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="80271734"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 18:29:53 -0800
X-CSE-ConnectionGUID: 9agw02yzRVG8J5EmBZxoNw==
X-CSE-MsgGUID: kaSKE/jlTk6DfNppUE3mDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204655806"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 18:29:49 -0800
Message-ID: <35123882-b909-43b7-879d-f3802dca2da1@linux.intel.com>
Date: Tue, 13 Jan 2026 10:29:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 7/7] perf/x86/intel: Add support for rdpmc user disable
 feature
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
 <20260112051649.1113435-8-dapeng1.mi@linux.intel.com>
 <20260112105738.GG830755@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260112105738.GG830755@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/12/2026 6:57 PM, Peter Zijlstra wrote:
> On Mon, Jan 12, 2026 at 01:16:49PM +0800, Dapeng Mi wrote:
>
>> +static void intel_pmu_update_rdpmc_user_disable(struct perf_event *event)
>> +{
>> +	/*
>> +	 * Counter scope's user-space rdpmc is disabled by default
>> +	 * except two cases.
>> +	 * a. rdpmc = 2 (user space rdpmc enabled unconditionally)
>> +	 * b. rdpmc = 1 and the event is not a system-wide event.
>> +	 *    The count of non-system-wide events would be cleared when
>> +	 *    context switches, so no count data is leaked.
>> +	 */
>> +	if (x86_pmu_has_rdpmc_user_disable(event->pmu)) {
>> +		if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_ENABLE ||
>> +		    (x86_pmu.attr_rdpmc == X86_USER_RDPMC_CONDITIONAL_ENABLE &&
>> +		     event->ctx->task))
>> +			event->hw.config &= ~ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
>> +		else
>> +			event->hw.config |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
>> +	}
>> +}
> Is it not simpler to invert that condition?
>
> 	if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_NEVER ||
> 	    !event->ctx->task)
> 		event->hw.config |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
> 	else
> 		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;

Hmm, it seems the logic changes along with the code change. The system-wide
event should be allowed to read with rdpmc from user space when attr_rdpmc
== X86_USER_RDPMC_ALWAYS_ENABLE, but it doesn't with the new code.

If we don't change the logic and just invert the condition, the code
simplicity has no much change.

	if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_NEVER ||
            (x86_pmu.attr_rdpmc == X86_USER_RDPMC_CONDITIONAL_ENABLE &&
	    !event->ctx->task))
		event->hw.config |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
	else
		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;


