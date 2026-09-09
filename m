Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2113D53C;
	Wed,  9 Sep 2026 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916825; cv=none; b=pOT5sfsmi2xTlJNL/uY5g70oIZRWj5oL9ZsvpjZtOXcHUVjjL6h4npv4CmQbMgZDeHY0bdz4bBWopgTP+T52uc0qBja50VxP+6GbQAyBHJ8tGg8rAmk8o/+bQP9HhQdioIZCdeX8Kc68tAsN/JZWtPfGqKu9IM8xD0bV5jAT9Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916825; c=relaxed/simple;
	bh=QDRn14T19zkyR72KdJ9/AXEWcrC7lV3OiIVXOiph4+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rITW9vGPAVbugBCTphby/hAijCiF3zHMY4CvwJgGgSKoVK4leSjvzZqKYVb6Hx3q8O4/5eZklJkFW28GyXsqNOQnZmD6K85Ctu0gBeCOYmPgnjfslvVt8bTkBp4dvR918slY3KIFdFEVYSctu32UGXZtXD7yd2eapqsaSRDrbIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQcaGNrs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQcaGNrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788916823; x=1820452823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QDRn14T19zkyR72KdJ9/AXEWcrC7lV3OiIVXOiph4+U=;
  b=OQcaGNrsQtr7dCM+GMucSjmD0sgDcaBDfFQIvFEt2W/hnbRe0TvDamY0
   qCJOxY+TcBh4t/hXJtG6JYz9HXkHePfkC/K0d7HKs4zyuWwS5peB8eEQb
   OxpTHynnD3oRGm1lJOe1XMoIBKBll8emDP4S8gqBXS8XAh/DPS/bxnKPD
   bFvx8+5/szTxbsQpjhQbQxWgfWtrwEND4ndBh0A8ggVDtVajcwgiL8lFN
   EVj8zfJyrRT28igsLgbUliSce1Eez0Sy8+JK5lvm7GEGWcGQtAMvEEuE8
   0NCJ7M7qY9J49iCZimWAfCuMWFpZYpkj8HigmO1tlqhIw8jkql700KiAU
   Q==;
X-CSE-ConnectionGUID: FrWCozNFQLqjEkfsm9yR/A==
X-CSE-MsgGUID: +dcEjUJIR1usqySAw6EXTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="76893443"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="76893443"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 18:20:22 -0700
X-CSE-ConnectionGUID: ZOwVBNcSShieWAZmJjbt0A==
X-CSE-MsgGUID: p/P6WzAgTa6VAJ6aY2yhFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="296103680"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 18:20:19 -0700
Message-ID: <cb7d5114-be2e-4e14-acf3-a2d18c5eec82@linux.intel.com>
Date: Wed, 9 Sep 2026 09:20:16 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Gennady Kupava <gennady.kupava@gmail.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
 <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
 <1691a05c-49a6-4b16-8bad-cb3c004ed07c@linux.intel.com>
 <20260908101914.GQ4121339@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260908101914.GQ4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/8/2026 6:19 PM, Peter Zijlstra wrote:
> On Tue, Sep 08, 2026 at 04:56:22PM +0800, Mi, Dapeng wrote:
>> On 9/8/2026 4:49 PM, Peter Zijlstra wrote:
>>> On Tue, Sep 08, 2026 at 03:51:02PM +0800, Dapeng Mi wrote:
>>>> PERF_SAMPLE_STACK_USER needs to return the user stack and user registers
>>>> to user space when the PMI exits. Since the skid from the PEBS/IBS sample
>>>> and PMI delivery, the PEBS/IBS register snapshot (especially IP/SP/BP)
>>>> can diverge from the user stack at PMI return. That mismatch breaks DWARF
>>>> unwinding.
>>>>
>>>> Precise sampling provides no benefit in this case, so disable PEBS/IBS
>>>> precise sampling and allow only PMI-based sampling when
>>>> PERF_SAMPLE_STACK_USER is requested.
>>>>
>>>> Reported-by: Gennady Kupava <gennady.kupava@gmail.com>
>>>> Closes: https://lore.kernel.org/all/CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com/
>>>> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>>>> Fixes: c5ebcedb566e ("perf: Add ability to attach user stack dump to sample")
>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> This breaks long standing existing behaviour.
>> Yeah, but it seems there is no better way to fix this issue.
> Breaking things that worked before isn't fixing.. people get upset.
>
>> An alternative way to fix this issue is still to return the PMI
>> context register state rather than the PEBS precise registers for user
>> stack sampling, but this actually falls back the imprecise PMI-based
>> sampling. 
> That's what we already do, no? I have distinct memories of making the
> stack unwind use the NMI regs rather then the PEBS regs.

Unfortunately it's not. :(

Currently pt_regs->ip would be unconditionally overwritten by PEBS/IBS
snapshotted IP register value, and then the pt_regs->ip is used to
generated the SAMPLE_IP.

    if (filtered_sample_type & PERF_SAMPLE_IP) {
        data->ip = perf_instruction_pointer(event, regs);
        data->sample_flags |= PERF_SAMPLE_IP;
    }

As Ian suggested, the better way to fix this issue could be to decouple
PERF_SAMPLE_IP and PERF_REG_X86_IP. PERF_SAMPLE_IP still stores the precise
IP from PEBS/IBS, but the whole user register snapshot keeps the PMI
context registers. DWARF depends on the user register snapshot to unwind
the call chain instead of PERF_SAMPLE_IP.

I would follow this way and send V2 patches. 

Thanks.


>
>> In my opinion, it could even make the thing worse. User
>> requires to get precise samplings, but perf silently returns imprecise
>> records, this would mislead user. 
> Mostly just the unwind might be off a little, the rest is accurate. This
> has been the case 'forever'. Performance analysis isn't for silly
> people, if they can't deal with a little fuzz then perhaps they're in
> the wrong business.
