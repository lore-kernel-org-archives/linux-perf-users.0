Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE6E571;
	Tue, 15 Apr 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733377; cv=none; b=Nf5XXLIJEquZRN+g1AlKa/CGJXi+8SAoLCChlbYxhbueoezmaZ5tbrmnFR/ga8YdoC5w15Q0mb73wCLY5SWlqgKid2GmK/zq5z1nAS8JP/+Ka5SLq3VpiahkybmhUGENzGTv+SxI8Ix6q3JPXREhH7yOmsQhaAsxOg37BvcbpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733377; c=relaxed/simple;
	bh=W1vlDCxe+5Rfzi02fWdsezjZcXCn18F45MSqcelkLpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/VY4QmGTI1ybIit4asg+t61Depo3zG36Pl1+wdsbsBKjrnJHIzfmztS8KiZ5nNacVXaKdZZccL48DyNDz/WIqSrm4yte7gFCkbCKpiVbY5VvvCX136nR7uQJlULWnNV3s9D4Tqgl9vbRDrtnUaoe45EbEIRPSM7zXFoEQM+6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYbX0qI6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYbX0qI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744733375; x=1776269375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W1vlDCxe+5Rfzi02fWdsezjZcXCn18F45MSqcelkLpw=;
  b=bYbX0qI6MJrBX24pB3GiZaxB+4gbrBk4HVO6sXL2XMUshpFJgBcewi7u
   XOZI9Xj/vm1Nh9Nx6CGVej19YJ4OK0U/dMsrHWDYyLUYiuwnNWyuoJLdu
   qMsZnWJWsbPfg+ril4IwwrpHqCG6awyGJvPcEKmzeOBcS4csQ6XgOa0b9
   htOKZvlUz8gWb46fzPtkSR+K13sCy4Nyr1YL/s7q5Ro90QeBZLqSmy6wu
   0CO7i+S5mpvFXv38XwJBhczalqwkQlOu7yS3HmUXKJJFLCapXWEFzxE7e
   fw4LablgibDDTo3z03qBOg6D/9+8QZxYM1fNV8uBEU3+wiR049wtwM4hb
   g==;
X-CSE-ConnectionGUID: BNmd3TAeRqizbDBOPg8BVw==
X-CSE-MsgGUID: JgrEdUNFTmyYmw6zXZORKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="57636930"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="57636930"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 09:09:34 -0700
X-CSE-ConnectionGUID: CoHLab+qQs+nMA9NoYodhA==
X-CSE-MsgGUID: S5GL+c0nTQi/Qnnr7x/VPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130710105"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 09:09:34 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 3D58B20B5736;
	Tue, 15 Apr 2025 09:09:31 -0700 (PDT)
Message-ID: <7dae1dbe-02fb-4294-90b8-0c4b2aa7d70a@linux.intel.com>
Date: Tue, 15 Apr 2025 12:09:29 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 10/22] perf/x86/intel: Process arch-PEBS records or
 record fragments
To: Peter Zijlstra <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-11-dapeng1.mi@linux.intel.com>
 <20250415135700.GD4031@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250415135700.GD4031@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-15 9:57 a.m., Peter Zijlstra wrote:
> On Tue, Apr 15, 2025 at 11:44:16AM +0000, Dapeng Mi wrote:
>> A significant difference with adaptive PEBS is that arch-PEBS record
>> supports fragments which means an arch-PEBS record could be split into
>> several independent fragments which have its own arch-PEBS header in
>> each fragment.
> 
> With the constraint that all fragments for a single event are
> contiguous, right?

Yes. If a record is split into n fragments, the first n-1 fragments will
have the CONTINUED bit set and the last fragment will have its CONTINUED
bit cleared. They are contiguous.

Thanks,
Kan

