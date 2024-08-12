Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF117F4EC;
	Mon, 12 Aug 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472803; cv=none; b=SoYCoUzg1YuVkjwTd+75GOIbr4zR4+qOoM60p2XMpSSpsZrclGNySeNU9FHGYdUg911ENNW3Y/x9VXC9YBLXN2DvtQ7/4sF4G+hnO00G5tN6mJOl4xLOvTuB6/5kxS5UHs9uqglr4reOja/Zvvn1tM05E6XLRHp53fOh1zJW8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472803; c=relaxed/simple;
	bh=usEXgByM1F1dL4IRVH0bQzX+lePJCRMP3GLgFrja/U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqal9PwStBWO6yIp5YPO/QotVtHsi7SgT9PrzGYAoWtgGpHzfHbVIwQa0VVO4iSQlag+UJrwXs/fUPsYcGATyQYPLJANqxdJNODqWJoQ8oZ9osdajyXM9ekCqCpt7MxuKHio5BL4ktQ9UI7D9Kw9RDK5umVydMBnxevFXy0qtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7wjRbfq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7wjRbfq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723472801; x=1755008801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=usEXgByM1F1dL4IRVH0bQzX+lePJCRMP3GLgFrja/U0=;
  b=h7wjRbfqyMJ4onulvaR8oJ7acKB8zHsOpTQREzm03yOmPVe3UiFFxGUs
   V79Yd8Ku7r1FaQON50MKzjuXTiAIDUGGooyiixn9nWl/+LveEo7SpNaWH
   Nk0nAyX43yPSyI4iiixRqouY/sVm92ZCny0ctRXHKtxKkCv7A3btrT6pU
   Yq6o9J0T86R0T7P46Z+9BtAJPl/TcDHL0ER+v4YvUpJDf+7Zj9eF9Som6
   Nd9MNdLzmC8LZ6P54ecJ6ePCGqFbsUpXr7PgNHKQs2JgQRrSvaMuvMjpt
   xpaH5H6RC+D92ynT4eurtP2PFKP2ZeJn4lLpOHOKPM3tMFA+uixrNuPju
   A==;
X-CSE-ConnectionGUID: fujv4lV3TXaRBFTRKMSHRA==
X-CSE-MsgGUID: 97xBPByBQ7uNBjjjL/VF6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32989887"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="32989887"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 07:26:40 -0700
X-CSE-ConnectionGUID: v7InI5kvRzWgc399Qq9Edg==
X-CSE-MsgGUID: Kkn1hiyoQF6dIL1fUrJprg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="63208729"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 07:26:40 -0700
Received: from [10.212.112.28] (kliang2-mobl1.ccr.corp.intel.com [10.212.112.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C3B5720CFED0;
	Mon, 12 Aug 2024 07:26:37 -0700 (PDT)
Message-ID: <6947c956-2ba6-4fec-8d8b-79c5bbd3d725@linux.intel.com>
Date: Mon, 12 Aug 2024 10:26:36 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf vendor events: SKX, CLX, SNR uncore cache event
 fixes
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Weilin Wang <weilin.wang@intel.com>, Song Liu <song@kernel.org>
References: <20240811042004.421869-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240811042004.421869-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-11 12:20 a.m., Ian Rogers wrote:
> Cache home agent (CHA) events were setting the low rather than high
> config1 bits. SNR was using CLX CHA events, however its CHA is similar
> to ICX so remove the events.
> 
> Incorporate the updates in:
> https://github.com/intel/perfmon/pull/215
> https://github.com/intel/perfmon/pull/216
> 
> Co-authored-by: Weilin Wang <weilin.wang@intel.com>
> Reported-by: Song Liu <song@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com/
> Fixes: 4cc49942444e ("perf vendor events: Update cascadelakex events/metrics")
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks Ian and Weilin

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  .../arch/x86/cascadelakex/uncore-cache.json   | 60 +++++++++----------
>  .../arch/x86/skylakex/uncore-cache.json       | 60 +++++++++----------
>  .../arch/x86/snowridgex/uncore-cache.json     | 57 ------------------
>  3 files changed, 60 insertions(+), 117 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
> index c9596e18ec09..6347eba48810 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
> @@ -4577,7 +4577,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
> -        "Filter": "config1=0x40233",
> +        "Filter": "config1=0x4023300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : CRds issued by iA Cores that Hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -4588,7 +4588,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
> -        "Filter": "config1=0x40433",
> +        "Filter": "config1=0x4043300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : DRds issued by iA Cores that Hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -4599,7 +4599,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
> -        "Filter": "config1=0x4b233",
> +        "Filter": "config1=0x4b23300000000",
>          "PerPkg": "1",
>          "UMask": "0x11",
>          "Unit": "CHA"
> @@ -4609,7 +4609,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
> -        "Filter": "config1=0x4b433",
> +        "Filter": "config1=0x4b43300000000",
>          "PerPkg": "1",
>          "UMask": "0x11",
>          "Unit": "CHA"
> @@ -4619,7 +4619,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefRFO",
> -        "Filter": "config1=0x4b033",
> +        "Filter": "config1=0x4b03300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores that hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -4630,7 +4630,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
> -        "Filter": "config1=0x40033",
> +        "Filter": "config1=0x4003300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that Hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -4651,7 +4651,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
> -        "Filter": "config1=0x40233",
> +        "Filter": "config1=0x4023300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : CRds issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -4662,7 +4662,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
> -        "Filter": "config1=0x40433",
> +        "Filter": "config1=0x4043300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : DRds issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -4673,7 +4673,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
> -        "Filter": "config1=0x4b233",
> +        "Filter": "config1=0x4b23300000000",
>          "PerPkg": "1",
>          "UMask": "0x21",
>          "Unit": "CHA"
> @@ -4683,7 +4683,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
> -        "Filter": "config1=0x4b433",
> +        "Filter": "config1=0x4b43300000000",
>          "PerPkg": "1",
>          "UMask": "0x21",
>          "Unit": "CHA"
> @@ -4693,7 +4693,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefRFO",
> -        "Filter": "config1=0x4b033",
> +        "Filter": "config1=0x4b03300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores that missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -4704,7 +4704,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
> -        "Filter": "config1=0x40033",
> +        "Filter": "config1=0x4003300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -4747,7 +4747,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
>          "Experimental": "1",
> -        "Filter": "config1=0x49033",
> +        "Filter": "config1=0x4903300000000",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of entries successfully inserted into the TOR that are generated from local IO ItoM requests that miss the LLC. An ItoM request is used by IIO to request a data write without first reading the data for ownership.",
>          "UMask": "0x24",
> @@ -4759,7 +4759,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RDCUR",
>          "Experimental": "1",
> -        "Filter": "config1=0x43C33",
> +        "Filter": "config1=0x43c3300000000",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of entries successfully inserted into the TOR that are generated from local IO RdCur requests and miss the LLC. A RdCur request is used by IIO to read data without changing state.",
>          "UMask": "0x24",
> @@ -4771,7 +4771,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
>          "Experimental": "1",
> -        "Filter": "config1=0x40033",
> +        "Filter": "config1=0x4003300000000",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of entries successfully inserted into the TOR that are generated from local IO RFO requests that miss the LLC. A read for ownership (RFO) requests a cache line to be cached in E state with the intent to modify.",
>          "UMask": "0x24",
> @@ -4999,7 +4999,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
> -        "Filter": "config1=0x40233",
> +        "Filter": "config1=0x4023300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that Hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -5010,7 +5010,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
> -        "Filter": "config1=0x40433",
> +        "Filter": "config1=0x4043300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that Hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -5021,7 +5021,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
> -        "Filter": "config1=0x4b233",
> +        "Filter": "config1=0x4b23300000000",
>          "PerPkg": "1",
>          "UMask": "0x11",
>          "Unit": "CHA"
> @@ -5031,7 +5031,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
> -        "Filter": "config1=0x4b433",
> +        "Filter": "config1=0x4b43300000000",
>          "PerPkg": "1",
>          "UMask": "0x11",
>          "Unit": "CHA"
> @@ -5041,7 +5041,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
> -        "Filter": "config1=0x4b033",
> +        "Filter": "config1=0x4b03300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Cores that hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -5052,7 +5052,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
> -        "Filter": "config1=0x40033",
> +        "Filter": "config1=0x4003300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that Hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -5073,7 +5073,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
> -        "Filter": "config1=0x40233",
> +        "Filter": "config1=0x4023300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -5084,7 +5084,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
> -        "Filter": "config1=0x40433",
> +        "Filter": "config1=0x4043300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -5095,7 +5095,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
> -        "Filter": "config1=0x4b233",
> +        "Filter": "config1=0x4b23300000000",
>          "PerPkg": "1",
>          "UMask": "0x21",
>          "Unit": "CHA"
> @@ -5105,7 +5105,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> -        "Filter": "config1=0x4b433",
> +        "Filter": "config1=0x4b43300000000",
>          "PerPkg": "1",
>          "UMask": "0x21",
>          "Unit": "CHA"
> @@ -5115,7 +5115,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
> -        "Filter": "config1=0x4b033",
> +        "Filter": "config1=0x4b03300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Cores that missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -5126,7 +5126,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
> -        "Filter": "config1=0x40033",
> +        "Filter": "config1=0x4003300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -5171,7 +5171,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
>          "Experimental": "1",
> -        "Filter": "config1=0x49033",
> +        "Filter": "config1=0x4903300000000",
>          "PerPkg": "1",
>          "PublicDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that are generated from local IO ItoM requests that miss the LLC. An ItoM is used by IIO to request a data write without first reading the data for ownership.",
>          "UMask": "0x24",
> @@ -5183,7 +5183,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RDCUR",
>          "Experimental": "1",
> -        "Filter": "config1=0x43C33",
> +        "Filter": "config1=0x43c3300000000",
>          "PerPkg": "1",
>          "PublicDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that are generated from local IO RdCur requests that miss the LLC. A RdCur request is used by IIO to read data without changing state.",
>          "UMask": "0x24",
> @@ -5195,7 +5195,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
>          "Experimental": "1",
> -        "Filter": "config1=0x40033",
> +        "Filter": "config1=0x4003300000000",
>          "PerPkg": "1",
>          "PublicDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that are generated from local IO RFO requests that miss the LLC. A read for ownership (RFO) requests data to be cached in E state with the intent to modify.",
>          "UMask": "0x24",
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
> index da46a3aeb58c..4fc818626491 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
> @@ -4454,7 +4454,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
> -        "Filter": "config1=0x40233",
> +        "Filter": "config1=0x4023300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : CRds issued by iA Cores that Hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -4465,7 +4465,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
> -        "Filter": "config1=0x40433",
> +        "Filter": "config1=0x4043300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : DRds issued by iA Cores that Hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -4476,7 +4476,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
> -        "Filter": "config1=0x4b233",
> +        "Filter": "config1=0x4b23300000000",
>          "PerPkg": "1",
>          "UMask": "0x11",
>          "Unit": "CHA"
> @@ -4486,7 +4486,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
> -        "Filter": "config1=0x4b433",
> +        "Filter": "config1=0x4b43300000000",
>          "PerPkg": "1",
>          "UMask": "0x11",
>          "Unit": "CHA"
> @@ -4496,7 +4496,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefRFO",
> -        "Filter": "config1=0x4b033",
> +        "Filter": "config1=0x4b03300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores that hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -4507,7 +4507,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
> -        "Filter": "config1=0x40033",
> +        "Filter": "config1=0x4003300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that Hit the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -4528,7 +4528,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
> -        "Filter": "config1=0x40233",
> +        "Filter": "config1=0x4023300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : CRds issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -4539,7 +4539,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
> -        "Filter": "config1=0x40433",
> +        "Filter": "config1=0x4043300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : DRds issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -4550,7 +4550,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
> -        "Filter": "config1=0x4b233",
> +        "Filter": "config1=0x4b23300000000",
>          "PerPkg": "1",
>          "UMask": "0x21",
>          "Unit": "CHA"
> @@ -4560,7 +4560,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
> -        "Filter": "config1=0x4b433",
> +        "Filter": "config1=0x4b43300000000",
>          "PerPkg": "1",
>          "UMask": "0x21",
>          "Unit": "CHA"
> @@ -4570,7 +4570,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefRFO",
> -        "Filter": "config1=0x4b033",
> +        "Filter": "config1=0x4b03300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores that missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -4581,7 +4581,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
> -        "Filter": "config1=0x40033",
> +        "Filter": "config1=0x4003300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -4624,7 +4624,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
>          "Experimental": "1",
> -        "Filter": "config1=0x49033",
> +        "Filter": "config1=0x4903300000000",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of entries successfully inserted into the TOR that are generated from local IO ItoM requests that miss the LLC. An ItoM request is used by IIO to request a data write without first reading the data for ownership.",
>          "UMask": "0x24",
> @@ -4636,7 +4636,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RDCUR",
>          "Experimental": "1",
> -        "Filter": "config1=0x43C33",
> +        "Filter": "config1=0x43c3300000000",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of entries successfully inserted into the TOR that are generated from local IO RdCur requests and miss the LLC. A RdCur request is used by IIO to read data without changing state.",
>          "UMask": "0x24",
> @@ -4648,7 +4648,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
>          "Experimental": "1",
> -        "Filter": "config1=0x40033",
> +        "Filter": "config1=0x4003300000000",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of entries successfully inserted into the TOR that are generated from local IO RFO requests that miss the LLC. A read for ownership (RFO) requests a cache line to be cached in E state with the intent to modify.",
>          "UMask": "0x24",
> @@ -4865,7 +4865,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
> -        "Filter": "config1=0x40233",
> +        "Filter": "config1=0x4023300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that Hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -4876,7 +4876,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
> -        "Filter": "config1=0x40433",
> +        "Filter": "config1=0x4043300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that Hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -4887,7 +4887,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
> -        "Filter": "config1=0x4b233",
> +        "Filter": "config1=0x4b23300000000",
>          "PerPkg": "1",
>          "UMask": "0x11",
>          "Unit": "CHA"
> @@ -4897,7 +4897,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
> -        "Filter": "config1=0x4b433",
> +        "Filter": "config1=0x4b43300000000",
>          "PerPkg": "1",
>          "UMask": "0x11",
>          "Unit": "CHA"
> @@ -4907,7 +4907,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
> -        "Filter": "config1=0x4b033",
> +        "Filter": "config1=0x4b03300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Cores that hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -4918,7 +4918,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
> -        "Filter": "config1=0x40033",
> +        "Filter": "config1=0x4003300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that Hit the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x11",
> @@ -4939,7 +4939,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
> -        "Filter": "config1=0x40233",
> +        "Filter": "config1=0x4023300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -4950,7 +4950,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
> -        "Filter": "config1=0x40433",
> +        "Filter": "config1=0x4043300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -4961,7 +4961,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
> -        "Filter": "config1=0x4b233",
> +        "Filter": "config1=0x4b23300000000",
>          "PerPkg": "1",
>          "UMask": "0x21",
>          "Unit": "CHA"
> @@ -4971,7 +4971,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
> -        "Filter": "config1=0x4b433",
> +        "Filter": "config1=0x4b43300000000",
>          "PerPkg": "1",
>          "UMask": "0x21",
>          "Unit": "CHA"
> @@ -4981,7 +4981,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
> -        "Filter": "config1=0x4b033",
> +        "Filter": "config1=0x4b03300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Cores that missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -4992,7 +4992,7 @@
>          "Counter": "0",
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
> -        "Filter": "config1=0x40033",
> +        "Filter": "config1=0x4003300000000",
>          "PerPkg": "1",
>          "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that Missed the LLC : For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent.     Does not include addressless requests such as locks and interrupts.",
>          "UMask": "0x21",
> @@ -5037,7 +5037,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
>          "Experimental": "1",
> -        "Filter": "config1=0x49033",
> +        "Filter": "config1=0x4903300000000",
>          "PerPkg": "1",
>          "PublicDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that are generated from local IO ItoM requests that miss the LLC. An ItoM is used by IIO to request a data write without first reading the data for ownership.",
>          "UMask": "0x24",
> @@ -5049,7 +5049,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RDCUR",
>          "Experimental": "1",
> -        "Filter": "config1=0x43C33",
> +        "Filter": "config1=0x43c3300000000",
>          "PerPkg": "1",
>          "PublicDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that are generated from local IO RdCur requests that miss the LLC. A RdCur request is used by IIO to read data without changing state.",
>          "UMask": "0x24",
> @@ -5061,7 +5061,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
>          "Experimental": "1",
> -        "Filter": "config1=0x40033",
> +        "Filter": "config1=0x4003300000000",
>          "PerPkg": "1",
>          "PublicDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that are generated from local IO RFO requests that miss the LLC. A read for ownership (RFO) requests data to be cached in E state with the intent to modify.",
>          "UMask": "0x24",
> diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
> index 7551fb91a9d7..a81776deb2e6 100644
> --- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
> @@ -1,61 +1,4 @@
>  [
> -    {
> -        "BriefDescription": "MMIO reads. Derived from unc_cha_tor_inserts.ia_miss",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x35",
> -        "EventName": "LLC_MISSES.MMIO_READ",
> -        "Filter": "config1=0x40040e33",
> -        "PerPkg": "1",
> -        "PublicDescription": "TOR Inserts : All requests from iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
> -        "UMask": "0xc001fe01",
> -        "Unit": "CHA"
> -    },
> -    {
> -        "BriefDescription": "MMIO writes. Derived from unc_cha_tor_inserts.ia_miss",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x35",
> -        "EventName": "LLC_MISSES.MMIO_WRITE",
> -        "Filter": "config1=0x40041e33",
> -        "PerPkg": "1",
> -        "PublicDescription": "TOR Inserts : All requests from iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
> -        "UMask": "0xc001fe01",
> -        "Unit": "CHA"
> -    },
> -    {
> -        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . Derived from unc_cha_tor_inserts.ia_miss",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x35",
> -        "EventName": "LLC_MISSES.UNCACHEABLE",
> -        "Filter": "config1=0x40e33",
> -        "PerPkg": "1",
> -        "PublicDescription": "TOR Inserts : All requests from iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
> -        "UMask": "0xc001fe01",
> -        "Unit": "CHA"
> -    },
> -    {
> -        "BriefDescription": "Streaming stores (full cache line). Derived from unc_cha_tor_inserts.ia_miss",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x35",
> -        "EventName": "LLC_REFERENCES.STREAMING_FULL",
> -        "Filter": "config1=0x41833",
> -        "PerPkg": "1",
> -        "PublicDescription": "TOR Inserts : All requests from iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
> -        "ScaleUnit": "64Bytes",
> -        "UMask": "0xc001fe01",
> -        "Unit": "CHA"
> -    },
> -    {
> -        "BriefDescription": "Streaming stores (partial cache line). Derived from unc_cha_tor_inserts.ia_miss",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x35",
> -        "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
> -        "Filter": "config1=0x41a33",
> -        "PerPkg": "1",
> -        "PublicDescription": "TOR Inserts : All requests from iA Cores that Missed the LLC : Counts the number of entries successfully inserted into the TOR that match qualifications specified by the subevent.   Does not include addressless requests such as locks and interrupts.",
> -        "ScaleUnit": "64Bytes",
> -        "UMask": "0xc001fe01",
> -        "Unit": "CHA"
> -    },
>      {
>          "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgress 0",
>          "Counter": "0,1,2,3",
