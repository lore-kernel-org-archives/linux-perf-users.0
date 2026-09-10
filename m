Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927227EC7C;
	Thu, 10 Sep 2026 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999174; cv=none; b=SCsqNeKbl3A1LxKVnGoC3Ba83l8cLiEBXMhI0Lbuh7z7urbcGnMYLlIXLYHdx7wx3oqT9dxj3vUfq38fmIVP9zBajdDWXlfvVx+wMsod/OsOnZt6YGKo1J2nhelYLfHZy1WTUViUXn5Z09/e2bmRpoLxBJjvbgUKDe09HSvr27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999174; c=relaxed/simple;
	bh=YQO5ksl1AUzBeUyM2iZ03PCdAnjuaojmJNTcWtL8+Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSk6NIO9rccUhcylX68DGTlzXrH14dl0TrJJhpJVL2kriZ+OCsMyt16heh8wm3iVgA/vhC54iW8UyMorVBNBJQxzCBxrfpGT9Zt/9X0mDHDje6lnNf+sbWUVaEYE1tmHad+zIsN8Kdyii3qe7HICSUcEQcfiQeegCD35s8PbHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMRwo2or; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMRwo2or"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788999173; x=1820535173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YQO5ksl1AUzBeUyM2iZ03PCdAnjuaojmJNTcWtL8+Co=;
  b=bMRwo2ore3blNPdg331ojZwrt1nj84Afb6e3RawDrnYUzaoY4VGVZsgd
   pufMBYO8+fXk6b8S3RPRPZYVt59Aefhs9sGcKmOgEFKPoR15QSDfvWqJk
   u9ZcNvi2fFpv/PHFUEZozIjMnySSUTxUsYz0gNR1EF8kg7gZYBjWdBB33
   UC6+xN2RxCBu8JolKTbFTBqp2Ij0P9utIgwf7UfY1STBiZkOqqdFrXWUs
   a/pp60+yrNCiLaWVc68Y7xsHVIUeyGG+RsNtPsRkT6wPoFexjxlBFVC65
   kPaAE5XNHQ58xq1WN1Hvz51VBMF/igf6vwgBli3ztn2jdoQzTV7Fmmcnd
   w==;
X-CSE-ConnectionGUID: u9/FeSK/R/iM1E8oMIjrPw==
X-CSE-MsgGUID: nMtGy9TMRRCrw5M57QEpQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="112212381"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="112212381"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 17:12:52 -0700
X-CSE-ConnectionGUID: 2J5fCTJ4SJyz5zR2/IKczQ==
X-CSE-MsgGUID: adGD/2/jR9Szvp7WWKc+eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="309723107"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 17:12:47 -0700
Message-ID: <c75ce5b7-89ce-4871-b630-50f52bbd113f@linux.intel.com>
Date: Thu, 10 Sep 2026 08:12:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>,
 Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Gennady Kupava
 <gennady.kupava@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
 <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
 <1691a05c-49a6-4b16-8bad-cb3c004ed07c@linux.intel.com>
 <20260908101914.GQ4121339@noisy.programming.kicks-ass.net>
 <aqAlddsFPYJvRhFr@tassilo>
 <CAP-5=fWbSNYpt8p3e+pqjY+xhqs8WrzsBfPaKB1NLBm88mH8Yg@mail.gmail.com>
 <20260909081101.GS4121339@noisy.programming.kicks-ass.net>
 <19a610df-530a-4397-9fb6-a1e12251c987@linux.intel.com>
 <aqGz7324WTIwJ_8U@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aqGz7324WTIwJ_8U@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/10/2026 3:30 AM, Namhyung Kim wrote:
> Hello,
>
> I missed this thread before sending my previous reply.
>
> On Wed, Sep 09, 2026 at 05:36:45PM +0800, Mi, Dapeng wrote:
>> On 9/9/2026 4:11 PM, Peter Zijlstra wrote:
>>> On Tue, Sep 08, 2026 at 01:56:56PM -0700, Ian Rogers wrote:
>>>> On Tue, Sep 8, 2026 at 8:10 AM Andi Kleen <ak@linux.intel.com> wrote:
>>>>>> That's what we already do, no? I have distinct memories of making the
>>>>>> stack unwind use the NMI regs rather then the PEBS regs.
>>>>>>
>>>>>>> In my opinion, it could even make the thing worse. User
>>>>>>> requires to get precise samplings, but perf silently returns imprecise
>>>>>>> records, this would mislead user.
>>>>>> Mostly just the unwind might be off a little, the rest is accurate. This
>>>>>> has been the case 'forever'. Performance analysis isn't for silly
>>>>>> people, if they can't deal with a little fuzz then perhaps they're in
>>>>>> the wrong business.
>>>>> Is the main problem that the stack doesn't agree? Perhaps there
>>>>> could be a check for regs->rsp == pebs->user rsp (if in user space)
>>>>> to detect problematic samples.
>>>>>
>>>>> The question is how to report it and who should do the checking.
>>>>>
>>>>> It may need new fields in the ABI either to communicate the extra PEBS RSP
>>>>> or a bit to indicate that there might be a mismatch.
>>>>>
>>>>> I guess checking in the kernel and reporting an error might be simpler
>>>>> and maybe cleaner, but it would likely limit more advanced recovery
>>>>> possibilities.
>>>>>
>>>>> Are there other mismatches that break the unwinding? Perhaps the same
>>>>> for RBP?
>>>> For DWARF unwinding any register may be the source of a frame pointer
>>>> (e.g. the OpenSSL library would use R11 rather than RBP).
>>>>
>>>> There is redundancy on x86 you can sample the PERF_REG_X86_IP register
>>>> in the user register and there is PERF_SAMPLE_IP in the sample event
>>>> itself.
>>>>
>>>> My understanding is that IBS can only sample IP and so for precise
>>>> samples we can use PERF_SAMPLE_IP as the precise location and the user
>>>> register PERF_REG_X86_IP as the interrupt IP - this would match the
>>>> other register values in the interrupt.
>>>>
>>>> In DWARF unwinding, we initialize the register state using the sampled
>>>> user registers:
>>> Oh, I had trouble reading yesterday :/ This is about USER_STACK, not
>>> CALLCHAIN.
>> Yes, this is about USR_STACK. The CALLCHAIN doesn't suffer this issue since
>> perf already returns an IP chain and user space can directly map them to
>> the symbols without depending on any register or stack snapshots. :)
>>
>>
>>> I think we should try very hard to not use USER_STACK, it is an
>>> abomination. Instead we really should improve CALLCHAIN to be more
>>> useful. There are a pile of patches for kernel based unwinders,
>>> including for .eh_frame (if only I had time to actually go look at
>>> them).
> That would be great!
>
>>> And we should probably look at doing a shadow stack based unwinder as
>>> well.
> Cool. It'd be nice to see that happen.
>
>>> This USER_STACK is really the absolute worst possible option. And
>>> perhaps refusing PEBS+USER_STACK makes sense.
>> If no others insist to implement the precise USER_STACK sampling (what Ian
>> suggested), I would give up for sending the drafted precise USER_STACK
>> sampling patches. Per my understanding, refusing precise USER_STACK
>> sampling what current version does is a cleaner and simpler way.
>> Supporting precise USER_STACK sampling inevitably complexes the PEBS/IBS
>> handling.
> I think precise is for IP and it's not clear if it applies to other REGS
> too.  But agree that it'd be simpler to reject.
>
>> BTW, currently perf tools already support the events creation fallback. As
>> long as user doesn't explicitly require precise USER_STACK sampling, the
>> USER_STACK sampling (--call-graph dwarf) would automatically fallback to
>> the PMI-based USER_STACK sampling after the initial precise USER_STACK
>> sampling try fails. So it won't really lead to the USER_STACK sampling fails. 
> That's true.  perf tools can fallback to auto-reduce the precise level
> unless it's requested manually.  If we go on this direction, I think we
> should mention this in the man page though.  Probably the condition is
> precise_ip + USER_REGS + USER_STACK.

Good idea. I would add an independent perf-tools patch to mention this once
we decide to go on this direction. Thanks.


>
> Thanks,
> Namhyung
