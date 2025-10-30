Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A7253B42;
	Thu, 30 Oct 2025 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845940; cv=none; b=oKrNsrw3TEAkB2bkdlXgdQZK922HTR18TSn4+o1IHr9TrMz3uIzZq6CG1BOFQcMztbeCng8Dyl5LcUvw1i6vkpZT/VQggBS2fphZGRdXeTFKFBTjVhheQfnDC/Oek0b1ZevDyNHakHf4tSRN/Utl3sQamlPGeaCH9Xp8/1gCGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845940; c=relaxed/simple;
	bh=/UPKDyvVWB4kKUrCrgXmDwQqbD2oxGQL6Jet9kzEgVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmEYiWm5Zadzy9BiiW5bGqKtSfnMSDUzos+s6spnZtCE6wU4Mn47iFrAdtvOaVbneWbC702QntcQ2Z94sEVZ4Fru+DrD3d8f3+pGnX2eZFgVDCHeV1eocugUJj6ePkyuFQ9LwSmiojHCTL/6E9+lkFXN8hTwn1a658HyDIXlwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQ7F0kXx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQ7F0kXx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761845938; x=1793381938;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/UPKDyvVWB4kKUrCrgXmDwQqbD2oxGQL6Jet9kzEgVY=;
  b=EQ7F0kXxf8hMcxykKKNvgbNUD8jSiWHMGWNs72vYp3rufYZzjAo9gxVi
   k4G/TLgWikoHy795xKoWbXSuUZ76xkmULXalEdXaaMTf3eR+txhxVMgTg
   aCRxvV9sfvGUfNmUYFMiMEPg6MB929sTUjbFg4LxDwtRuC1oviDhQO3rN
   43kTFGohgVrFCvUq521k2ArxRmnWfRpn9t1X6PgEQueVK0xwLglek2PIm
   1AeECeAvdbatMNiypjP2aj76y1eEM9q8l8ugYnkh2qLwCqIC/dBkdc3gL
   CDdc+ELTrhJFKKJU5088V6CT1qTi+VlaWxQp1dcJz5Il6PX+xrEOAOyvD
   w==;
X-CSE-ConnectionGUID: +TJdvbFkS1+QEaCMpXGJng==
X-CSE-MsgGUID: ATxufDvOQAyrX9IdGsGOmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75345843"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="75345843"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:38:57 -0700
X-CSE-ConnectionGUID: 58dnJo8KQa6TUBuI/IcyXw==
X-CSE-MsgGUID: mc8ZvrNXTH+cxyQ5pfXDmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="186753503"
Received: from unknown (HELO [10.241.241.94]) ([10.241.241.94])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:38:57 -0700
Message-ID: <9c21d7e0-fcfd-43c2-ba5d-5881400a46ca@intel.com>
Date: Thu, 30 Oct 2025 10:38:56 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/3] perf/x86/intel/cstate: Add Clearwater Forest
 support
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>,
 Artem Bityutskiy <artem.bityutskiy@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Zhenyu Wang <zhenyuw.linux@gmail.com>
References: <20251023223754.1743928-1-zide.chen@intel.com>
 <20251023223754.1743928-2-zide.chen@intel.com> <aQMrONyVjGsCFXe2@gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aQMrONyVjGsCFXe2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/2025 2:09 AM, Ingo Molnar wrote:
> 
> * Zide Chen <zide.chen@intel.com> wrote:
> 
>> Clearwater Forest is based on the Darkmont Atom microarchitecture.
>> From the perspective of C-state residency profiling, it supports the
>> same residency counters as Sierra Forest: CC1/CC6, PC2/PC6, and MC6.
>>
>> Please note that the C1E residency counter can only be read via PMT,
>> not MSR. Therefore, tools relying on the perf_event framework cannot
>> access the C1E residency.
>>
>> Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Zhenyu Wang <zhenyuw.linux@gmail.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> 
> So, this is not a valid SOB chain: primary author should be the first 
> SOB, or if it was co-developed, it should have the proper 
> Co-developed-by tags.
> 
> Here I can see two possibilities:
> 
> (1) if Zhenyu Wang was the primary author, and Zide Chen reviewed, 
>     tested and submitted it upstream, then:
> 
> 
>   | From: Zide Chen <zide.chen@intel.com>
>   | Subject: [PATCH 1/3] perf/x86/intel/cstate: Add Clearwater Forest support
> 
>     From: Zhenyu Wang <zhenyuw.linux@gmail.com>
>     ...
> 
>     Signed-off-by: Zhenyu Wang <zhenyuw.linux@gmail.com>
>     Signed-off-by: Zide Chen <zide.chen@intel.com>
> 
> (I.e. add the extra From line as the first line of the changelog.)

Yes, that is the case.
Thank you very much for pointing this out! I will pay extra attention to
the SoB chain going forward.


> (2) if it was co-developed, with Zhenyu Wang and Zide Chen having each 
>     written unique lines of code of their own that finally resulted in 
>     this submission, then:
> 
>   | From: Zide Chen <zide.chen@intel.com>
>   | Subject: [PATCH 1/3] perf/x86/intel/cstate: Add Clearwater Forest support
> 
>     ...
> 
>     Co-developed-by: Zide Chen <zide.chen@intel.com>
>     Signed-off-by: Zide Chen <zide.chen@intel.com>
>     Co-developed-by: Zhenyu Wang <zhenyuw.linux@gmail.com>
>     Signed-off-by: Zhenyu Wang <zhenyuw.linux@gmail.com>
> 
> Which one was it? :-)
> 
> Thanks,
> 
> 	Ingo

