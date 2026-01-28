Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B675D7080E
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619000; cv=none; b=C/BTpu6AmP1sHzUGCfnAwPXkR46/O2hONcoG/tMqcmhX6RPbHoxsezesi6u7s+Tzcf9AWgSSx6GfvjkGfPXV2g1JjqZODM9yftnRcC231IevtOLCdHY3gFQ776j/A4yuZEDkPQFEj/uKYS5RQF2dlY1jEPoN6SOMSUGX4iKVRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619000; c=relaxed/simple;
	bh=L4y1Qg+ISQ7VKkUCwYhdNoKOITqIV8w5JwUM9ED/dXM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LzAvT+7jpWUXNGckZKwHU8j6swjQfkfFjaqUTiFuwxk5TY2pmGKknjz/pk7eiCwGIputA2GRrAsgwcA+O/6Uuka0GtY8nqmDz7osrqcgg/xWaeRtVbkEr+4BfIg+iowhNqNZtAsE+hqosRQPz9/8Uf4JXS/LQ+NMRVMWWfC+HnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WJnNnScu; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WJnNnScu"
Message-ID: <e3e37e53-59ce-4fd8-8e4c-a3c05acda497@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769618994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=euyA54511DgFcWgvoxcxbL5506Ltf9G2W8L6hecfNLs=;
	b=WJnNnScuuebuv8VCakHLztEIGVS+YWmKl/01PKvasF1pklTziOai/k5D5FQRYF8bi/NDSJ
	2GhhL+i4P+fKz8mz9cj40ONhgXihEWPQcNp22Pgats4bGrx4IoN94yh+UJvMFAM19fqqG2
	Kag/Vfqn8SC2sohi7ytrynT8HMGX1Q0=
Date: Thu, 29 Jan 2026 00:49:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 song@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev>
 <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
In-Reply-To: <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/1/28 17:10, Peter Zijlstra 写道:
> On Mon, Jan 26, 2026 at 03:43:30PM +0800, Tao Chen wrote:
>>  From BPF stack map, we want to ensure that the callchain buffer
>> will not be overwritten by other preemptive tasks and we also aim
>> to reduce the preempt disable interval, Based on the suggestions from Peter
>> and Andrrii, export new API __get_perf_callchain and the usage scenarios
>> are as follows from BPF side:
>>
>> preempt_disable()
>> entry = get_callchain_entry()
>> preempt_enable()
>> __get_perf_callchain(entry)
>> put_callchain_entry(entry)
> 
> That makes no sense, this means any other task on that CPU is getting
> screwed over.
> 
> Why are you worried about the preempt_disable() here? If this were an
> interrupt context we'd still do that unwind -- but then with IRQs
> disabled.

Hi Peter,

Right now, obtaining stack information in BPF includes 2 steps:
1.get callchain
2.store callchain in bpf map or copy to buffer

There is no preempt disable in BPF now, When obtaining the stack 
information of Process A, Process A may be preempted by Process B. With 
the same logic, we then acquire the stack information of Process B. 
However, when execution resumes to Process A, the callchain buffer will 
store the stack information of Process B. Because each context(task, 
soft irq, irq, nmi) has only one callchain entry.

       taskA                             taskB
1.callchain(A) = get_perf_callchain
		<-- preepmted by B   callchain(B) = get_perf_callchain	
2.stack_map(callchain(B))
	

So we want to ensure that when task A is in use, the preepmt task B 
cannot be used. The approach involves deferring the put_callchain_entry 
until the stack is captured and saved in the stack_map.

       taskA                             taskB
1.callchain(A) = __get_perf_callchain
		<-- preepmted by B   callchain(B) = __get_perf_callchain
2.stack_map(callchain(A))
3.put_callchain_entry()		
	
taskB can not get the callchain because taskA hold it.

And the preempt_disable() for get_callchain_entry was suggested from 
Yonghong in v4
https://lore.kernel.org/bpf/c352f357-1417-47b5-9d8c-28d99f20f5a6@linux.dev/

Please correct me if I'm mistaken. Thanks.

-- 
Best Regards
Tao Chen
