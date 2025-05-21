Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314115B115;
	Wed, 21 May 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835743; cv=none; b=FjOHe/qIEtaXPvCj6XHTmxoXmZU0vcpRtJHJOjK4RzaOEpjCQ7lE1BzyezKGv923kqM8pRNBTYL3Wl9S/LzqVx6axgYdIqj0tFrWzE605a5Gj6Q7gsYYsZUjzFEHBxJ/gC5ay1tQMjzYHWpNSdxDderdUkyLidPAr8eCrwEBiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835743; c=relaxed/simple;
	bh=5YlHzEyAD+um+Lq9ABkZ57kvbO9EugG1rXUX7Ecj+9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/nK7IasMXE/OON0NqvyP8KxV+ZaWaVfxcqZR5yi5Sly4fW7uGKWLBLHlx7/2YDcxcQegAhQTVswatuomJxQ5GYF3euRZ3IL0GuJmGiTQdo2LbkzProjbH0irK51rXRx+G6LaKaG2eEsos/rWDZW0yON5YXyGvjp5JaOk7cANoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCbr6dQh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCbr6dQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747835743; x=1779371743;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5YlHzEyAD+um+Lq9ABkZ57kvbO9EugG1rXUX7Ecj+9Q=;
  b=PCbr6dQhblLE1xlDDAsq9fGWtdoK9oY4DyOSm+Ee53IlAOnBcacdBJhb
   A5jKc7PUXpiLpqKlzAc/0z1z4uxpcUcY2sRlrHLRpaoIAcFw0anCeXNaM
   p4XLPklvfhFJmET8JrFX6qBD+HXsMGKAmX4Wf0pWPCXT+aP53Mu9QJc4i
   h8v8efK1KEovk3nU4wbZYRqBsQamnjQBKOqI9cSNls/fmmkY67VKHmgdB
   hilueYvqULjDrGFHnF/8XFjs9cukDkOGcbvwFh0ErmsJDRnFuwQLif9QI
   dmvNrLH3mbm+3uG2TWKmxNz1NeBSyYVaPav1qa4VrW/3HHe/PDEVEG8+N
   A==;
X-CSE-ConnectionGUID: Kvmkxow8RXuWIaL94V1Wng==
X-CSE-MsgGUID: ulQjQ5V0TOmLt7fhlVjVHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="67231765"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="67231765"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 06:55:41 -0700
X-CSE-ConnectionGUID: bv2XtKf2SMGxMyne/i/s2A==
X-CSE-MsgGUID: 4lSJJupjQ2yTJcKL9Nt7Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140152954"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 06:55:40 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id A21DC20B5736;
	Wed, 21 May 2025 06:55:38 -0700 (PDT)
Message-ID: <ce9cd541-04ba-4ed5-9d36-3f2ecd95d484@linux.intel.com>
Date: Wed, 21 May 2025 09:55:37 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 02/16] perf: Only dump the throttle log for the leader
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, namhyung@kernel.org, irogers@google.com,
 mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, leo.yan@arm.com
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-3-kan.liang@linux.intel.com>
 <20250521120541.GD39944@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250521120541.GD39944@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-21 8:05 a.m., Peter Zijlstra wrote:
> On Tue, May 20, 2025 at 11:16:30AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The PERF_RECORD_THROTTLE records are dumped for all throttled events.
>> It's not necessary for group events, which are throttled altogether.
>>
>> Optimize it by only dump the throttle log for the leader.
>>
>> The sample right after the THROTTLE record must be generated by the
>> actual target event. It is good enough for the perf tool to locate the
>> actual target event.
> 
> So while both patches change behaviour; the first patch should preserve
> all that was done and simply do more. OTOH this patch explicitly changes
> behaviour in that what was done, is now no longer done.
> 
> Are we very sure there isn't a tool that expect per event throttle
> messages?
> 

For a non-group event, the behavior is not changed. The event throttle
message is dumped for each of them, because the leader is itself.

The second patch may only change the behavior of some cases of the group
events, but not all of them. For example, the behavior of the common
usage sampling read case is not changed, since the leader is the
sampling event.
Also, as far as I know, the current perf tool doesn't track which event
is throttled.
Furthermore, the group events were broken. I doubt there are other tools
really work with group events throttle message.
All in all, we don't lose the throttle information for each event. Based
on the current information, tools can reconstruct it. Since the tool
needs to be fixed anyway, I don't see a problem.

Thanks,
Kan



