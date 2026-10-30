Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324683;
	b=ieVVPS9rEeKkH0SBOefPaGdAh/OBPnFD2P3EPNmMkH2EvlplQRuUhjPjPP4nDJcNlSoD
	 q7UOyJXquQU13KRzLNQj2RK3NI7RMIbGKO2zsenyDnqdnpFqvnFzZmL6l3JRpcrvYLiTT
	 4K+lfZ6r0GVu5Q+BKrQOeEYx3Vi+we2PHHEvObIpWYDJ5BMnVlRE04a3txX5MHig1qF8I
	 ed8i2Bqv8mQSd6SoQAY9h8fVu22LotfXJeJH9MbSIU8mCNb3qqezPm7gHFWAROS93BMYF
	 GJZDaj0nDNfei38dDthvCUCGsHhrRblfOcP7ve3WTqK5MfP8tahjLjviKJhrL73P+5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324683;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lO7hnY2CRfipOrfprVP/EBrwCU0wqavFT/XJgQDB9zs=;
	b=GlYzjntUindBjsrsodqEbLgNVV9aYppVf2FzejMgUqYOorcVLh+K0P3gZXJD+paq0oGw
	 BWiECassPdOGGWRbIvHb9VMvBZgSc0eFoYMpiywJwUG8LxISOdze8TsGbONLret1YMc4j
	 D8uqFvcZrxUWvxLx6QYPw/Ju9cFNrPHFGyfpdTSWOWsLh1BLj0P2KO0SDHGK+9kwnz5r+
	 Bh2pjnCqMFE8xapQBOG3EOHzHCE3ENB5PtOAhMR2++QSeMsGgOtXzDMoXcApMiZ4jYs1I
	 e47JI6UARVGCjDH4dLUgIv5gDPGTMs9F27aXef4LBHamxq7Ete4+2MzONBWb/CSwwaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DN4Nz7MU;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B7606A31C;
	Fri, 30 Oct 2026 01:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 385B7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DN4Nz7MU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793324682; x=1824860682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sn3tuZDu6V0K33oQBK5ChMdybS0sLmHQ6wLtcBb5GxQ=;
  b=DN4Nz7MUijoCiBljYLy1SuXJorySUvEjT8QishHd8kbITT7LMFAGbFui
   QMVP54CTVI2HfrBHEr/AgmgLDhKTsAU3Vqi4ZX6sj5WTyhzn15cPYAz1C
   a3luW0CbvDKDmSiPD6ywqxiAikyn7qhpWio5ZRh6ElyOFraYVE92iBEsJ
   qa0ndrH1BhoTkURZduZ423z2/TKgeZB6vkYGu26mPbl6oi2pVkFKKCFdy
   un7NGSVezrLRODWrXeTjScrVqPUo1Mg0alE6AMEN8H9WyGmbRM2bp6GcA
   NpPF61Y5Hf+DwDokhnqyA/az9p/vih3Jeay3a50ylKe+mM9kigTHndNWO
   g==;
X-CSE-ConnectionGUID: dKzFmrCaSduBLo5mjbFaHQ==
X-CSE-MsgGUID: HLquyyOFRvykYSBKKHpm6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2086290"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2086290"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:44:42 -0700
X-CSE-ConnectionGUID: VMwr1BgTSN2NtuUYB7bmSQ==
X-CSE-MsgGUID: FIAiufvURlq31pBM1ji5Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5197821"
Received: from unknown (HELO [10.238.2.61]) ([10.238.2.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:44:36 -0700
Message-ID: <acd2d0d6-0b2e-4fe5-8574-1155cb563dbe@linux.intel.com>
Date: Fri, 30 Oct 2026 09:44:33 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 11/18] perf/x86/intel: Use a dedicated LBR stack for
 BPF snapshotting
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Sashiko <sashiko-bot@kernel.org>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-12-dapeng1.mi@linux.intel.com>
 <20261029104115.GM1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261029104115.GM1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/29/2026 6:41 PM, Peter Zijlstra wrote:
> On Thu, Oct 29, 2026 at 12:39:07PM +0800, Dapeng Mi wrote:
>> BPF LBR snapshotting currently reuses the default LBR stack
>> (cpuc->lbr_stack) when storing sampled data. This is unsafe when the
>> BPF helper runs in PMI context via bpf_overflow_handler(): it can
>> overwrite the cached LBR state for active PEBS LBR events, causing
>> incorrect LBR data to be reported to userspace. When the PEBS and BPF
>> stacks have different depths, this can also lead to out-of-bounds reads
>> when the LBR stack is later exported.
>>
>> Use a dedicated LBR stack for BPF snapshotting so the BPF path no
>> longer clobbers the shared LBR state used by other perf events.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> AMD has the same problem, no?

No. According what I know, currently AMD doesn't support branch sampling in
IBS and the LBR is frozen in the whole PMI handling, BPF would see same LBR
stack here with the PMI handler at the PMI entry. So although BPF path
indeed overwrites the default cpuc->lbr_stack, it won't break anything
since the snapshotted LBR stacks are same for PMI and BPF.

But this indeed causes the deviation on the coding level. A generic way is
to add BPF dedicated LBR stack in cpuc structure, then use the dedicated
BPF stack to store BPF snapshot for both AMD and Intel. But it could waste
some memory on AMD platforms.

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d0ed4a2e1683..6e5144fbde9f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -530,6 +530,9 @@ struct cpu_hw_events {
        struct perf_branch_stack        lbr_stack;
        struct perf_branch_entry        lbr_entries[MAX_LBR_ENTRIES];
        u64                             lbr_counters[MAX_LBR_ENTRIES]; /*
branch stack extra */
+       struct perf_branch_stack        bpf_lbr_stack;
+       struct perf_branch_entry        bpf_lbr_entries[MAX_LBR_ENTRIES];
+       u64                             bpf_lbr_counters[MAX_LBR_ENTRIES];
/* branch stack extra */
        union {
                struct er_account               *lbr_sel;
                struct er_account               *lbr_ctl;

What do you prefer?

Thanks.


>
>> ---
>>  arch/x86/events/intel/core.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 5eda551cc9f2..482a148916bf 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2819,18 +2819,24 @@ static void intel_pmu_enable_all(int added)
>>  	__intel_pmu_enable_all(false);
>>  }
>>  
>> +struct lbr_snapshot {
>> +	struct perf_branch_stack stack;
>> +	struct perf_branch_entry entries[MAX_LBR_ENTRIES];
>> +	u64 counters[MAX_LBR_ENTRIES];
>> +};
>> +static DEFINE_PER_CPU(struct lbr_snapshot, lbr_snapshot);
>> +
>>  static noinline int
>>  __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>>  				  unsigned int cnt, unsigned long flags,
>>  				  int pmu_enabled, int lbr_enabled)
>>  {
>> -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	struct lbr_snapshot *bpf = this_cpu_ptr(&lbr_snapshot);
>>  
>> -	intel_pmu_lbr_read(&cpuc->lbr_stack,
>> -			   cpuc->lbr_entries, cpuc->lbr_counters);
>> -	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
>> +	intel_pmu_lbr_read(&bpf->stack, bpf->entries, bpf->counters);
>> +	cnt = min_t(unsigned int, cnt, bpf->stack.nr);
>>  
>> -	memcpy(entries, cpuc->lbr_entries,
>> +	memcpy(entries, bpf->entries,
>>  	       sizeof(struct perf_branch_entry) * cnt);
>>  
>>  	/*
>> -- 
>> 2.34.1
>>
