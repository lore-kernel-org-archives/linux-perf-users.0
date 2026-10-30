Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354187;
	b=IL2muCWxwuDZNiokL1K3eP/B7/qO1VxTeMnS+6Ldd0QqbCcuIbSWC4Q3IdFx+4SYNCW5
	 ILAkNXlqd71n3TGignxmvLx57TC9IsVVJhKnQ3K14OnzJllwPlEgqetDG1n60KHHT79zl
	 N9ji3Qwjr2DFNc/kjFZ7d0zVb8uBxo3s0PuOQLxS5x2bJI2ecoUfCoUoCjF4+TjP+x1qN
	 B6N1GrogjYd3zMRTTYZYU9Vl3iU0Gvmx3EkN1LQVObLrCjNlLx+2vkCZaS050+6sPJ5fa
	 e0enhPJSG/tl7mXW12gBuDEdS6wpQUeaDEbi33vvj/jJ8QgZSvUP6AoV53U1aOMzgdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354187;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qKvtHqmAnWh7jrzVhAmBXGE1jVfwGOGfObLDn64oZ8A=;
	b=daY7FkIBD732ooe5oFyDldPXn9rx+2SFlDCN0ufn6qkr8KE+uVYQCwGXIr+020XpF1uL
	 LMIRhw6cKymn2hWlBeBT2/pebINryU0xYlAdhZ3ALJVJRsrV+Vt8fTZ6hbW8gjzEQgpo4
	 hDy8DrBdpm3kgTgbTphOapOxVvkd3B4Fnv+tB1Ty6B6MD3+Z9BZzHPJVAkA3iljLGh0wo
	 sgxwwMCQaOCcSIb8DxVnXqdK0xDjnqllYKOo8nAEZvrCyJRwXSBQVoNbaJ4dR3Hvccutk
	 IpTYPjbaMvvP41pI36RmxmjWQYvEuVjjRCOyr+zD1pCkPmT5g/5wvz/wZnFdz9H2LUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=idVcZe+a;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660DF606A321;
	Fri, 30 Oct 2026 09:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660DF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=idVcZe+a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793354186; x=1824890186;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dnHareNJED8u8bx64z5ln4QTw+6nV9eOXs3XlfsAUTI=;
  b=idVcZe+aDj5brND6UiZU4/XD2KIpLBwZOxR8XqqdOR2stOmKHK0rWnvN
   UCpMza+hPXO9NLKSURBd+qaGLBW8aCwZIGCDLDThYReUlrIFjb6xENTyr
   AiV2phhmRB/Zoe0ryFFYkeSvBpNm4PpJMgUGN2zjmjPYjGFbdBgTBQqVy
   70i9HScfEphwcHhhSN5qSCHOYlr+Qv2Hx7ivAs6Ksf3I0hC/NSv4CZvxk
   81SSFUi694XS7gejmg5t8mwKDzgRaQOCh/XBzutR3h1Drtl1+rCgS8dcH
   vAVrha+NjsA8ncFBcD8SWfOTF8NB1xlWUmYgsBpMr4PbehMb7SowxHfS4
   w==;
X-CSE-ConnectionGUID: wTXite3zRfOqnq0dM3Okgw==
X-CSE-MsgGUID: UHVByK9pTJK+KUiRvaWlLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1994367"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="1994367"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:56:26 -0700
X-CSE-ConnectionGUID: vXAQfDwpT5iDiZlGfbNaUg==
X-CSE-MsgGUID: ZS64ffXnRtq8cRjMHCAMrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7221831"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:56:21 -0700
Message-ID: <d9577c81-ce88-4e21-bd68-d770d394c68f@linux.intel.com>
Date: Fri, 30 Oct 2026 17:56:18 +0800
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
Subject: Re: [Patch v5 13/18] perf/x86/intel: Refresh LBR stack for non-PEBS
 LBR events if needed
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
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-14-dapeng1.mi@linux.intel.com>
 <20261029110046.GO1779021@noisy.programming.kicks-ass.net>
 <16441880-1831-4741-ac90-02e5f662435d@linux.intel.com>
 <20261030093013.GM2668804@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261030093013.GM2668804@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/30/2026 5:30 PM, Peter Zijlstra wrote:
> On Fri, Oct 30, 2026 at 09:54:02AM +0800, Mi, Dapeng wrote:
>
>>>> @@ -4012,8 +4023,14 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>>>  
>>>>  		perf_sample_data_init(&data, 0, last_period);
>>>>  
>>>> -		if (has_branch_stack(event))
>>>> +		if (has_branch_stack(event)) {
>>>> +			if (lbr_need_update) {
>>>> +				intel_pmu_lbr_read(&cpuc->lbr_stack,
>>>> +					cpuc->lbr_entries, cpuc->lbr_counters);
>>>> +				lbr_need_update = false;
>>>> +			}
>>>>  			intel_pmu_lbr_save_brstack(&data, cpuc, event);
>>>> +		}
>>>>  
>>>>  		x86_pmu_clear_perf_regs(regs);
>>>>  		x86_pmu_update_perf_regs(event, &data, regs, false);
>>> Or... you move intel_pmu_lbr_read() from handle_irq() into pmi_common()
>>> after we done the PEBS things?
>> Yes, I ever tried to do that, but I found it would break the PEBS LBR
>> sampling on the platforms prior to ICE LAKE. The PEBS doesn't support
>> snapshot LBR stack on these old platforms, so PMI handler has to snapshot
>> the LBR stack before draining the PEBS buffer.
> Argh; we have so many variations :-(
>
> Still, re-reading those MSRs seems wasteful, esp. if most modern chips
> will be affected.
>
> Can't we have a toggle between early and late LBR read or something?

Hmm, yes. I would refactor the code and eliminate the duplicated LBR
reading. Thanks.



