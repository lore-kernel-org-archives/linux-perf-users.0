Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4C1509AB;
	Mon,  1 Jun 2026 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293237; cv=none; b=mY658Wb8sE3Q24tdqCMQ+v7p5wvA62rO/NfTln9xHk0mtEXIRnNmcDBlz4GFhawEbCe3Uulo3TVhX5kiK+mfZmwXzL3KGiyc1Idvaakmrenh4/V4u2zM43fXSEKqF2xBIpnzvEkfkiPPPor0ChsPuEe7ZNGsEMh35zuaci6IduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293237; c=relaxed/simple;
	bh=U2cw/ygGVAVgVXItBjJhtWIjJpFITS+Ea3m4SUMcyxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUMH95WilDySpwnYTREocJXiJEayTaju5RTuGvl9RXhh6icc5UcRxw2tMkn0T0BOTpFgX6ZdbWVL1BPr/o2dZCpq0Vh2+dOhTfP3Zynblf1KUHa5GN3xCSBfOjjOyhR/Ikgk4wyzjfCLJui1lTEYGdH0pdipEDKYfVcj80to0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PomBpzo+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PomBpzo+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780293236; x=1811829236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U2cw/ygGVAVgVXItBjJhtWIjJpFITS+Ea3m4SUMcyxM=;
  b=PomBpzo+ykZ8ze/F35cEgwqmMDeSfa/JPNMh/4xLNIVDQfjUy/vlKoqr
   jllDloLVkhoI1qqSJk9ChbsAQsSN64rnRbp2ZFanfcbCZ+lK7f2j88H7q
   ZvGsWUPlh0hPiVX1+U4/Wz/2xcJpatJg44lsodNTnQUqJukgmCO8NfmgN
   /rgxcASRkh1MCoQFDRaCAtm2NyUZCfCA16ZhlwiMgtXshvF49EQqfVTFq
   HSgi3aWAObjc+OrPCHObOY3YfkmWIhaBLlOsAIQpzTngdCgTALi2DalV6
   VtvfSyXlxl7cqE1pZYn3/Zj8KpjkC5vSSlqkv8BEws5tNlV+fyYKlIVQh
   A==;
X-CSE-ConnectionGUID: 6jV+xb17Ra6+qe4Gg8v9aA==
X-CSE-MsgGUID: YeUfAgA4QpG/wh1aauH3Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="83619953"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="83619953"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 22:53:55 -0700
X-CSE-ConnectionGUID: UmZNiSEHSVCrRkJxzMJfWQ==
X-CSE-MsgGUID: BEZgg1+2Qw+qub1KdR2w5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="240960761"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 22:53:50 -0700
Message-ID: <69ebb113-fbc0-459a-a9d2-55a8415ed2a4@linux.intel.com>
Date: Mon, 1 Jun 2026 13:53:47 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 11/23] perf/x86: Enable XMM register sampling for
 REGS_USER case
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
 <20260529075645.580362-12-dapeng1.mi@linux.intel.com>
 <20260529114255.GL3493090@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529114255.GL3493090@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/29/2026 7:42 PM, Peter Zijlstra wrote:
> On Fri, May 29, 2026 at 03:56:33PM +0800, Dapeng Mi wrote:
>> This patch adds support for XMM register sampling in the REGS_USER case.
>>
>> To handle simultaneous sampling of XMM registers for both REGS_INTR and
>> REGS_USER cases, a per-CPU `x86_user_regs` is introduced to store
>> REGS_USER-specific XMM registers. This prevents REGS_USER-specific XMM
>> register data from being overwritten by REGS_INTR-specific data if they
>> share the same `x86_perf_regs` structure.
>>
>> To sample user-space XMM registers, the `x86_pmu_update_user_xregs()`
>> helper function is added. It checks if the `TIF_NEED_FPU_LOAD` flag is
>> set. If so, the user-space XMM register data can be directly retrieved
>> from the cached task FPU state, as the corresponding hardware registers
>> have been cleared or switched to kernel-space data. Otherwise, the data
>> must be read from the hardware registers using the `xsaves` instruction.
>>
>> For PEBS events, `x86_pmu_update_user_xregs()` checks if the PEBS-sampled
>> XMM register data belongs to user-space. If so, no further action is
>> needed. Otherwise, the user-space XMM register data needs to be
>> re-sampled using the same method as for non-PEBS events.
>>
>> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Sashiko has fun comments; I don't think we care about the cross-vm data
> leak, that's not worse than we already have on the regular regs. In
> fact, it might be considered correct behaviour ;-)

Yes, it suppose to be the correct behavior and what is intended. User may
want to profile the guest's behavior by host events, this is what current
patch does.


>
> It does have a point about noxsaves; or xsaves being masked by a VM.

Yes, as previous comments, I would enhance the check and only set the
PERF_PMU_CAP_EXTENDED_REGS capabilities when both PEBS and xsaves support
XMM sampling.

Thanks.



