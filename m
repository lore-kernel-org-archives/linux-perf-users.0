Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92E1A6829
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779416772; cv=none; b=ttmQMSRQgTIy0xD/igVXCyBMB0HZEgDSeaqOXmOhkmPKsJ6/AfqjP52TMUuuZcdfEp+um8IdBhEotSFXvOF11Brb/8TvvZnwqC2Gq9uedv8weGd927ECEYp6nFFgEbjCnrImEMS+QhNosoqTCu9IT7bmkF2yWNVzL7VygZR3Qyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779416772; c=relaxed/simple;
	bh=G1f5+wBTWyzdYkKAo4SLFoGIcGKxUaofeBOJPrUUC/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KracvOtzrLNlyV65yH4TcUX4fTlYnbpmyOyXpY6MqQxo+a/HBN7tyZ06+LFQd5pfS+O/h3LdX02gHpi8hN4mOG7wBsQjVNMQi8zhVaoZ/sWAhZdguL6BrlzwGccxoinzL6zXtvHKed9BuT+zi+RUqRtB2ZPAtdSw6/VAxcVLD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAL3aagZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAL3aagZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779416771; x=1810952771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G1f5+wBTWyzdYkKAo4SLFoGIcGKxUaofeBOJPrUUC/k=;
  b=oAL3aagZZMnFEbKHYhFLoTrJoksIjbPInWPadnOFyW90Mz8spOmtsSsG
   igP/AI3J15GqXk94rF03SFE9CFm9ynBnfTOVkzkMo98YPuaRdxMsfMWLY
   2/WXY8rnAjo01aKeSc8cqNbqyHa1ETvacxlJp8/nMfZMjGY5Vck3tN8nO
   HNC7vQi+9fjtQYvWzEFKMgDXSn/Fb5Vto3G+HgIUujqqVz8vwQJT5w1XJ
   +80Q1AGL8NnNX/doRLmdyNJPrsf2P5O+6GPdE4wiE7wJ7Af28jGqvGMSE
   +SHaS56kkIBFbmikzJsx7hUW6pnLXUdxVBqyLk/IFCAqu3j/nka7cviKI
   Q==;
X-CSE-ConnectionGUID: uV8P0dQjTvuESR8544JQUQ==
X-CSE-MsgGUID: bLoaVJnUTQOFKHg3HowuPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80400957"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80400957"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 19:26:10 -0700
X-CSE-ConnectionGUID: qEDF4HO9REmh999KK6t65A==
X-CSE-MsgGUID: MX1PA2wrRsSJnCRMWk5+bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="236336792"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 19:26:08 -0700
Message-ID: <1285cb4a-6084-40ad-98c5-fb43bc44c626@linux.intel.com>
Date: Fri, 22 May 2026 10:26:06 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] perf/x86/intel: Ensure guest PEBS path doesn't set
 unwanted PERF_GLOBAL_CTRL bits
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko@lists.linux.dev, linux-perf-users@vger.kernel.org
References: <20260508231353.406465-2-seanjc@google.com>
 <20260508234018.F06AEC2BCB0@smtp.kernel.org>
 <ccea937f-8ad5-4a6e-b6a4-917f2ee02579@linux.intel.com>
 <agZiTeGgRO4PJ9mI@google.com>
 <02461927-589b-4179-9f93-2f9e10172879@linux.intel.com>
 <a75397bd-6122-4fa8-8197-334b2fbbb5af@linux.intel.com>
 <ag8Q-UM5dcVtBijd@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <ag8Q-UM5dcVtBijd@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/21/2026 10:04 PM, Sean Christopherson wrote:
> On Thu, May 21, 2026, Dapeng Mi wrote:
>> On 5/15/2026 9:49 AM, Mi, Dapeng wrote:
>>> On 5/15/2026 8:01 AM, Sean Christopherson wrote:
>>>>> Anyway, we could optimize the code further like below and thoroughly filter
>>>>> away these extra bits. (only building, not test on real HW)
>>>> Hmm, I think I'd rather figure out what it would take to drop the FIXME entirely.
>>>> And if we need to keep the check, I'm a-ok risking false positives until we have
>>>> a better understanding of why the check exists.
>>> Kan Liang should be the best man who knows the history, but he has left
>>> Intel. I would check this with other guys internally and look at if they
>>> know the reason.
>> Just checked the commit history, It looks the reason of disabling guest
>> PEBS here is to avoid breaking the host !exclude_guest PEBS event sampling.
>> Host may create !exclude_guest event to profile both root and non-root
>> mode, but it's conflicted with guest PEBS sampling in non-root mode. So
>> guest PEBS sampling has to be disabled if there are active host PEBS
>> events. Thanks.
> But that doesn't make any sense, because the host can't use PEBS to sample non-root
> mode due to the DS area being virtually addressed.  It's entirely possible that
> was pure oversight, given that commit 58f6217e5d01 ("perf/x86/intel: KVM: Mask
> PEBS_ENABLE loaded for guest with vCPU's value.") was necessary.
>
> But I'm still not convinced: if that _really_ was the motivation, then I would
> hope that scenario was at least smoke tested, and any testing whatsoever would
> have crashed the guest.
>
> Though given how buggy this code has been, I suppose it's plausible there was
> simply testing.

Yes, you are right. It's impossible to support PEBS sampling for both root
and non-root mode for the legacy PEBS, and that's one main reason why the
arch-PEBS is introduced. 

But the conclusion is still correct. Before the commit 58f6217e5d01
("perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest with vCPU's
value."), if users create a !exclude_guest event on host, the event would
be enabled in IA32_PEBS_ENABLE after the vm-entry and it would cause guest
crash if no such global guest PEBS disabling. That's the reason why the
guest PEBS is globally disabled here if there are active PEBS events on host.

After introducing the commit 58f6217e5d01 ("perf/x86/intel: KVM: Mask
PEBS_ENABLE loaded for guest with vCPU's value."), it looks this global
guest PEBS disabling becomes unnecessary any more. 

Thanks.


>
