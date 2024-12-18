Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE03597A;
	Wed, 18 Dec 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540957; cv=none; b=SumHBqwrMqwbfSsrFkf/F5lnhEejL9HLdxgn0x0Cxx02doQ15Qw0s+hGWaFWfGI5gpOLM+VKepdFnlA+WuDMxMNuBJw5UIp+HrB8H8ZyH6EQ+cGbVMk2miuy1V6PNDAC2ujxTTb/382IKeAe/6u2wl5ejXOvP2daAv4/IWO+yIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540957; c=relaxed/simple;
	bh=0xp2okdvI0rcyKnmhJFgpngsrombWFrPGfSYko4S/cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmNl26UJxZNDEWezR7bvJx2SuuSSG6pkc/qf9+BLQOuZ2pPt9jSw1zklTevZDlHQFfyEV1+gAGZ1Yx7aB0wNZ8NZr61rUSBjsn1MBwwamwuaRYj0tcGjEPeIZ7WIdEETmFDDPrnt5M8ySTMHS4YHdkT+r3uKC9sH54YfAtH714w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnU6LZfH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnU6LZfH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734540956; x=1766076956;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0xp2okdvI0rcyKnmhJFgpngsrombWFrPGfSYko4S/cc=;
  b=dnU6LZfH2yXrNh4CSkRsGbfLniaY/8eQBlelzoOet/9rAg2Vnw8bmTeM
   x84yVJ6+kJuUJZuK9d+ezyxB0ZG6IYnWlg9P/uNORTJcP2yu5CZcskg9+
   PBYAsJmZ8WEUIg/FgJph83G+mUrCvPmDsc7JoUIarvJvV2775B/0qe/Fb
   xuaSDz3ZdojFHlgqE1ZCMZ8gl1k9PACPPs+LOP0OQfmITMxzCSy2mdbD0
   csPuM38gRsKiQ5BQEDtVw/mI6ALWW50v2g/o/RQdwHd6uOrnTta0DwQBk
   a38aLXGST/GhzuRjD49bqwPrQ6V05We3C5dP8TJx++D+0Jm3LaeLAqyb3
   Q==;
X-CSE-ConnectionGUID: Zj1sPwI9Sy+Yh4HMM+tJDg==
X-CSE-MsgGUID: 321V32beRNKUhh9+mg3PjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34908001"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="34908001"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:55:56 -0800
X-CSE-ConnectionGUID: K+8aPL0jTYycELpEGMWUag==
X-CSE-MsgGUID: LJe/KtmXTAyMGJoabHH1YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97753020"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:55:55 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 61ACA20B5713;
	Wed, 18 Dec 2024 08:55:54 -0800 (PST)
Message-ID: <3d63f8b2-c028-4cae-ad72-76378425c73a@linux.intel.com>
Date: Wed, 18 Dec 2024 11:55:53 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 3/3] perf/x86/intel: Support PEBS counters snapshotting
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, eranian@google.com,
 dapeng1.mi@linux.intel.com
References: <20241218151643.1031659-1-kan.liang@linux.intel.com>
 <20241218151643.1031659-3-kan.liang@linux.intel.com>
 <20241218163249.GI2354@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241218163249.GI2354@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-18 11:32 a.m., Peter Zijlstra wrote:
> On Wed, Dec 18, 2024 at 07:16:43AM -0800, kan.liang@linux.intel.com wrote:
> 
>> To prevent the case that a PEBS record value might be in the past
>> relative to what is already in the event, perf always stops the PMU and
>> drains the PEBS buffer before updating the corresponding event->count.
> 
> Like I wrote here:
> 
>   https://lkml.kernel.org/r/20241218082404.GI11133@noisy.programming.kicks-ass.net
> 
> I don't think this is sufficient.


I replied with an explanation this morning in the old V5 thread. I'm not
sure if you got a chance to look at it.
https://lore.kernel.org/all/5a4ab06e-8628-4e1d-addb-2af920deffad@linux.intel.com/

There will be a drain_pebs() right before handling A-overflow-PMI.

  B-assist			A=1
  C				A=2
  B-assist			A=3
  		<- drain_pebs()
  A-overflow-PMI		A=4
  C-assist-PMI (DS buffer)	A=5

So the A-overflow-PMI will
   - Process the DS. adjust A->count to 3
   - adjust A->count to 4

Is it sufficient?
If not, could you please share more details?

Thanks,
Kan


