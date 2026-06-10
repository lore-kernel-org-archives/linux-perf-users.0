Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F03FE671;
	Wed, 10 Jun 2026 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091749; cv=none; b=NenKSuMmMvzO3RUCVlRmCZ8ZNvpfOgirEAJUlBtjnOFuF1lN1PuDFbfe/AgZIfA0GWsGquaq2deugq0PbI68rDUJa2UxSEFshF53CM87mz/mJupAy/kMokQ3jHqEizqszDRaVvb7fbjiu5f5iQ1GFsFDarCuiw5SJkHL9eiqRdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091749; c=relaxed/simple;
	bh=Y7SdnMkmkNLVQtzdzF2W83a2lzw+x6Jem21gd+wkGDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRtCN2HIJWkQRa1l3MfsrHdjacBXf5z/Lx30pqI0c9keMZyqnmNRBky9hpk+hS70629Bo9EeBnfXbLFX63avmiuYvYkwKPLYHgU+DrSdAq1ScMsgu+Ctjd3I4iUR0/os00nPavJxUZhB7Ms8v+H05pD9S9jpBlFPp0bwVRDLcqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=by9y308Y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="by9y308Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781091743; x=1812627743;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y7SdnMkmkNLVQtzdzF2W83a2lzw+x6Jem21gd+wkGDw=;
  b=by9y308Y5A/44gc4shmka6eqAcpB/WnoT8B7260eG9y9GpSQCRblzrSi
   IyzMm30DzZ4ohaeEsDemcpHUvQ4LJxrB6GgFjmmC84LqHVaI4GxC9LPxh
   yilaEjl+LMOPZ46/yQ3rP3AbLBAL95CB2dbUEsyD2OtQgrhhccUQXu4J0
   42xaOOljv7Y6lYUqS4umjc7My+njHlWEP1QnpJuTXIEYFGKx/qNRdNYxS
   QFstyiS5mZifR8Nhht4qOTMGMl/YvTajR14zcTeQ6w97Dhwde3qhDYnUO
   yF5FDT9KQzJ4QNelYJRZl5MX92MD2z+XfmEukpxO0qV9JLO1cwR18qtwZ
   A==;
X-CSE-ConnectionGUID: YUMBvbXUT9Ojp/yGrjt50Q==
X-CSE-MsgGUID: 1mpACGu2SJWQkYsZzxHIkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99459010"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="99459010"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 04:42:22 -0700
X-CSE-ConnectionGUID: 8LMM+BiNR++DIOmZsy5yug==
X-CSE-MsgGUID: R8rx7C3TRIet+dEgkDUDlA==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 04:42:18 -0700
Message-ID: <0636b71e-acb8-4e9e-bf55-2343471e52bd@linux.intel.com>
Date: Wed, 10 Jun 2026 19:42:16 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 7/9] perf/x86/intel: Drop fixed-counter PEBS
 constraints for baseline PEBS
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Yi Lai <yi1.lai@intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-8-dapeng1.mi@linux.intel.com>
 <20260610082051.GF49951@noisy.programming.kicks-ass.net>
 <b3485f13-039d-44d9-af02-5cea084ca304@linux.intel.com>
 <20260610112114.GD187714@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260610112114.GD187714@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/10/2026 7:21 PM, Peter Zijlstra wrote:
> On Wed, Jun 10, 2026 at 04:50:45PM +0800, Mi, Dapeng wrote:
>> On 6/10/2026 4:20 PM, Peter Zijlstra wrote:
>>> On Tue, Jun 09, 2026 at 01:02:20PM +0800, Dapeng Mi wrote:
>>>> On SPR guests where pebs_baseline is not advertised, running:
>>>>
>>>> $ ./perf record -e cpu/event=0x00,umask=0x01,i\
>>>> 	 name=INST_RETIRED.PREC_DIST/p -c 10000 sleep 1
>>>>
>>>> can trigger:
>>>>
>>>> unchecked MSR access error: WRMSR to 0x3f1 ... in\
>>>> 	 intel_pmu_pebs_enable_all()
>>>>
>>>> Root cause:
>>>> SPR-specific PEBS constraints allow fixed-counter scheduling,
>>>> for example INST_RETIRED.PREC_DIST on fixed counter 0. In guests without
>>>> pebs_baseline, KVM does not support PEBS sampling on fixed counters,
>>>> so enabling such events reaches an invalid MSR programming path.
>>>>
>>>> Fix:
>>>> Drop fixed-counter entries from the PEBS constraint table. Without
>>>> pebs_baseline, those fixed-counter PEBS events now resolve to empty
>>>> constraints and are not scheduled/enabled, avoiding the warning and the
>>>> broken guest PEBS path.
>>>>
>>>> This is safe because, in pebs_baseline-capable cases, PEBS constraint
>>>> lookup already falls back to non-PEBS constraints when needed, and
>>>> fixed-counter constraints are effectively shared there.
>>> I am confused, this works outside of KVM? (It appears to work fine on my
>>> spr).. so removing this to fix some guest only issue seems wrong.
>> The reason that it works on bare metal is currently the constraint lookup
>> would fallback into non-PEBS constraints if there is no matched entry in
>> the PEBS constraints as long as the PEBS supports sampling on all counters
>> including fixed counters (what the flag "PMU_FL_PEBS_ALL" indicates), like
>> the below code shows.
>>
>> ```
> Why the markdown nonsense? You're not an LLM, right? And you all know
> I'm reading this in mutt. Its just visual noise.
>
> Anyway, please clarify the Changelog.

Sorry for the visual noise. I'm using the thunderbird mail client,  not
sure why the markdown doesn't work.

Sure. I would rewrite the change log and increase more details. Thanks.


