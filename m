Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F4E2EB87C
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766844; cv=none; b=WcPOcF1QI0RckZLmgj4LrXAOQ6VaGgX8qKffukS7MPfGKdGP9gxzVuMN0EDfs8MrZ0r4Y22EDaoSdhdYi3SqORzMaq6P5/bvxh53YPcTcz0qGo0P3xZoJoWUeRvaEYXpeMRgx12pvRFTVhfW/i0CunSzaUEoIThvqyeqK7rwS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766844; c=relaxed/simple;
	bh=0y1x6vuTqY1a4bcKRJr6zJO92StO1GY4H2TcgO+Dxqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkFwEzn+fMjia0ItOtNznidnvSLsOphRvdJmQi6urg0KIH2FrKjREkL61eZuMx2tSS2OQseD5yVME5DOMKf1wEttJq7f0sPtM2isAdUJ2XZ0upRFRG9u+aL2dgY5I/CIHx+W5IKgXTRx7iufPu9JQBe5vhTITZylSn4Lo7nU0xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jqbUXIZB; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jqbUXIZB"
Message-ID: <3d26b162-d218-41ec-b5ab-3657eaffadf6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762766839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45w11IYUjkqWJv5rhQ2qNwbknmdZ/cYVdBVIbaYQLFQ=;
	b=jqbUXIZBGWeJW5cmG+92WJ8dqj1WnvF2UMEmTKPmyy9OR0qwI2HnIxlJoJ6pLhgHZFPSt+
	oxAI4CVUjt05ctOjeDqz1kJbcPlRq4IjY8xQG9yj7VZ/fl4fk+E3CtCI98048kWYEuNiWv
	9BjBMMN9l63HZs6F8oxK3TSoTpGJBBc=
Date: Mon, 10 Nov 2025 17:26:42 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/3] perf: Add atomic operation in
 get_recursion_context
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>
References: <20251109163559.4102849-1-chen.dylane@linux.dev>
 <20251109163559.4102849-3-chen.dylane@linux.dev>
 <20251110085210.GV3245006@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <20251110085210.GV3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/11/10 16:52, Peter Zijlstra 写道:
> On Mon, Nov 10, 2025 at 12:35:58AM +0800, Tao Chen wrote:
>>  From BPF side, preemption usually is enabled. Yonghong said, it is
>> possible that both tasks (at process level) may reach right before
>> "recursion[rctx]++;". In such cases, both tasks will be able to get
>> buffer and this is not right.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
> 
> Nope, this function really is meant to be used with preemption disabled.
> If BPF doesn't abide, fix that.
> 

Ok, let us use preempt_disable in bpf stackmap, thanks. I will change it 
in v6.

>>   kernel/events/internal.h | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
>> index d9cc5708309..684bde972ba 100644
>> --- a/kernel/events/internal.h
>> +++ b/kernel/events/internal.h
>> @@ -214,12 +214,9 @@ static inline int get_recursion_context(u8 *recursion)
>>   {
>>   	unsigned char rctx = interrupt_context_level();
>>   
>> -	if (recursion[rctx])
>> +	if (cmpxchg(&recursion[rctx], 0, 1) != 0)
>>   		return -1;
>>   
>> -	recursion[rctx]++;
>> -	barrier();
>> -
>>   	return rctx;
>>   }
>>   
>> -- 
>> 2.48.1
>>


-- 
Best Regards
Tao Chen
