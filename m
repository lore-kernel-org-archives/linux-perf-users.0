Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0C2459D4
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148827; cv=none; b=KqmM3Ctnk4xw9CCHpy6FhNliQ7zCQgWEQrjJ+YwPyGs2aCKO1F2CgXR337WNbOVOPw9kzbi6ReQ4+3OVSwk9V7zQrKp8GWfZ/sZZtRnX5pNjgkRchlpigMhm4atvzs7+wi57F90wPlxoxqGKNkmXHzO9AuzfXofq8KLjFHesCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148827; c=relaxed/simple;
	bh=jbu7M00koy29d91adFhRysiT6pdG6JgiTtHNdmMfJek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=II20i5BOCcW7iOcNV5IVUDhrf3jfrCN9eo/IVGOi1iHiHkCx7P7RfIRFQnqcmvAF02h4qwB4Ed6hb2hTYowVRdFJAGgtxqiQQHL6Wz0L3LSbmRrDByH7MCh85vdl/Tssi2nvpj++lNCn2hmCJgy7m3xCy7BMyLltkW1inZCitwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qC7J67qH; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qC7J67qH"
Message-ID: <cbee1f3b-49df-4228-898c-f6dc07e52add@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761148822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yp2cQvFiaIaAz+JhdGJjrvgCDsYO80NbgcjJ/2JWtSU=;
	b=qC7J67qHBbXFf8znPbB+TkYYl2uLEniHZ8byowwo+150h34q6YJrsdpYOPXzJH1SK1gl5f
	/uXLBaRH4Hh0gyxLtH1U2Qbw2ZD8PoTqVOSRQmyU54JlcB4aDjTZJ4ThdwKaNZKFs8tPqv
	5O3cThVkFDvku8dHLxbEAWZu4x6tHfA=
Date: Wed, 22 Oct 2025 23:59:32 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Use per-cpu BPF callchain entry to
 save callchain
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 song@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251019170118.2955346-1-chen.dylane@linux.dev>
 <20251019170118.2955346-3-chen.dylane@linux.dev>
 <20251020110303.GS3419281@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <20251020110303.GS3419281@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/20 19:03, Peter Zijlstra 写道:
> On Mon, Oct 20, 2025 at 01:01:18AM +0800, Tao Chen wrote:
>> As Alexei noted, get_perf_callchain() return values may be reused
>> if a task is preempted after the BPF program enters migrate disable
>> mode. Drawing on the per-cpu design of bpf_bprintf_buffers,
>> per-cpu BPF callchain entry is used here.
> 
> And now you can only unwind 3 tasks, and then start failing. This is
> acceptable, why?

Yes it is, if we use per-cpu-bpf-callchain-entry like 
bpf_bprintf_buffers, this is a proposal from Andrii and Alexei,
In my understanding, is it a low-probability event to be preempted three 
times in a row in the same cpu?

> 
>> -	if (may_fault)
>> -		rcu_read_lock(); /* need RCU for perf's callchain below */
>> -
> 
> I know you propose to remove this code; but how was that correct? The
> perf callchain code hard relies on non-preemptible context, RCU does not
> imply such a thing.
>

Alexei mentioned this rcu-lock issue before，
It seems we need preemption protection.
https://lore.kernel.org/bpf/CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com

>>   	if (trace_in)
>>   		trace = trace_in;
>> -	else if (kernel && task)
>>   		trace = get_callchain_entry_for_task(task, max_depth);
>> -	else
>> -		trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
>> -					   crosstask, false);
> 
> 


-- 
Best Regards
Tao Chen
