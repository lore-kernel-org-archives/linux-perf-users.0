Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A743CE7E;
	Wed,  9 Sep 2026 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946617; cv=none; b=lRdl/XMo0GtMpJZRqfPyhudIjP1exm+4EpSC9OI/HMc8J24KSxgRsU33D9znyj3TJP5T0hamXxtidUvX3B4Zqo5J/WsulalKG7udt2LX5pbSbZ03iY6Q9LjznoYD0Y0HLw4JFyEZRTqTr3Lsodh6uAZLHTDW1/jEfClbxHoN8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946617; c=relaxed/simple;
	bh=gtdN4LNeuPVCb5WEafuay1ViQVfuEkdz9joF72/XfMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5hXyzBiLgzWUHXyIyTrzzCt3L1k14dRcHBsbH9cvq3CXQgPL0lzBe4aLri+KQ4HZ5/9oFI52l0rYfXst5kq/mmtM+ZAzYf1aWiiKyI3COZ5LB6cTZbozqeQIjzi3/9smVcmghps1y+7GH1Or8Sr1Tz57cEFbfOixgIBKevY2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsH31zph; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsH31zph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788946613; x=1820482613;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gtdN4LNeuPVCb5WEafuay1ViQVfuEkdz9joF72/XfMo=;
  b=IsH31zphQfRTTo7pq5iRulOeDe0fHeqRDtOexa3MwaTnfMng7ADLMurj
   /bMaYC2uWRvTrumhrCW7hPZBxf20D5VAdH2E3iSgv6dyobJaDdrpgYkTb
   UpuH0ATffZ3zzlD1G0QXDzOT07T827MO3HjyV80RRvwT48PGxMUHlEh/1
   ImhHWmMydxinh5WCzUV/gcFGg8PJhrzTvIzX/HneMTurUj1TQDJPTq1OS
   V8Sq322998bXwTFOLJQodfi43ZxFJlmDKBy+7Bijsqy0MeGgQSou0lr4d
   wBA71xCU+bqZdq217Y3o87crrri/K4yPkQ3Ru/3+iA+ElmWl5cKCAk8RU
   Q==;
X-CSE-ConnectionGUID: bd28EUVWQziUe5DHr4oAJA==
X-CSE-MsgGUID: lPwZG/lnSZiAxN7msKMZ9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89397072"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89397072"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 02:36:51 -0700
X-CSE-ConnectionGUID: a616dES4QkikDtTccGBMuA==
X-CSE-MsgGUID: iyw9qPkWSwqDH20+p4eCsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="266980263"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 02:36:47 -0700
Message-ID: <19a610df-530a-4397-9fb6-a1e12251c987@linux.intel.com>
Date: Wed, 9 Sep 2026 17:36:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
To: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260909081101.GS4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/9/2026 4:11 PM, Peter Zijlstra wrote:
> On Tue, Sep 08, 2026 at 01:56:56PM -0700, Ian Rogers wrote:
>> On Tue, Sep 8, 2026 at 8:10 AM Andi Kleen <ak@linux.intel.com> wrote:
>>>> That's what we already do, no? I have distinct memories of making the
>>>> stack unwind use the NMI regs rather then the PEBS regs.
>>>>
>>>>> In my opinion, it could even make the thing worse. User
>>>>> requires to get precise samplings, but perf silently returns imprecise
>>>>> records, this would mislead user.
>>>> Mostly just the unwind might be off a little, the rest is accurate. This
>>>> has been the case 'forever'. Performance analysis isn't for silly
>>>> people, if they can't deal with a little fuzz then perhaps they're in
>>>> the wrong business.
>>> Is the main problem that the stack doesn't agree? Perhaps there
>>> could be a check for regs->rsp == pebs->user rsp (if in user space)
>>> to detect problematic samples.
>>>
>>> The question is how to report it and who should do the checking.
>>>
>>> It may need new fields in the ABI either to communicate the extra PEBS RSP
>>> or a bit to indicate that there might be a mismatch.
>>>
>>> I guess checking in the kernel and reporting an error might be simpler
>>> and maybe cleaner, but it would likely limit more advanced recovery
>>> possibilities.
>>>
>>> Are there other mismatches that break the unwinding? Perhaps the same
>>> for RBP?
>> For DWARF unwinding any register may be the source of a frame pointer
>> (e.g. the OpenSSL library would use R11 rather than RBP).
>>
>> There is redundancy on x86 you can sample the PERF_REG_X86_IP register
>> in the user register and there is PERF_SAMPLE_IP in the sample event
>> itself.
>>
>> My understanding is that IBS can only sample IP and so for precise
>> samples we can use PERF_SAMPLE_IP as the precise location and the user
>> register PERF_REG_X86_IP as the interrupt IP - this would match the
>> other register values in the interrupt.
>>
>> In DWARF unwinding, we initialize the register state using the sampled
>> user registers:
> Oh, I had trouble reading yesterday :/ This is about USER_STACK, not
> CALLCHAIN.

Yes, this is about USR_STACK. The CALLCHAIN doesn't suffer this issue since
perf already returns an IP chain and user space can directly map them to
the symbols without depending on any register or stack snapshots. :)


>
> I think we should try very hard to not use USER_STACK, it is an
> abomination. Instead we really should improve CALLCHAIN to be more
> useful. There are a pile of patches for kernel based unwinders,
> including for .eh_frame (if only I had time to actually go look at
> them).
>
> And we should probably look at doing a shadow stack based unwinder as
> well.
>
> This USER_STACK is really the absolute worst possible option. And
> perhaps refusing PEBS+USER_STACK makes sense.

If no others insist to implement the precise USER_STACK sampling (what Ian
suggested), I would give up for sending the drafted precise USER_STACK
sampling patches. Per my understanding, refusing precise USER_STACK
sampling what current version does is a cleaner and simpler way.
Supporting precise USER_STACK sampling inevitably complexes the PEBS/IBS
handling.

BTW, currently perf tools already support the events creation fallback. As
long as user doesn't explicitly require precise USER_STACK sampling, the
USER_STACK sampling (--call-graph dwarf) would automatically fallback to
the PMI-based USER_STACK sampling after the initial precise USER_STACK
sampling try fails. So it won't really lead to the USER_STACK sampling fails. 

Thanks.


