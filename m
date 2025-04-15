Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325C1F416A
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Apr 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732381; cv=none; b=BhJwbQxZVa8dHfCY5enC+dctrhYxUV5/LqiWX8TmLVBZ3QQSkmN7J8D4gDIUmsWlvLQqGj+rMjh6xLMGtwsNfJDktSzhrGikl2dr7dBswmHoJEMKsoYBnpVuwxJsYY5TQU89N51DSdlz/PMfKVO5Mc33dd4ZjOAVF0alRGmfOgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732381; c=relaxed/simple;
	bh=1s5VUpfsnLrgZQzcnItw9zwtWIcSEbXxWfNt96WJWRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGJf+klgrcCAX6qOPD3IUBxlGo6sCLye1C2hSLunZxD5nOHoWiG9DeVe4lPx+rQdKSpimNA8FEu5OEtg/csC2MLUfMVszUc3XZ/96ofMgbdzeFoALF+7MsudHRooUreYBsGp/ge29q1nvZ3zvLbynP1WuZa2cJvIeI4cNuciV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=caRmoM1X; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="caRmoM1X"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so60459875e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Apr 2025 08:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744732378; x=1745337178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4JLTNvpaptplrjpn5KAL5k+FFz54c8FMnV1vnh7J1TI=;
        b=caRmoM1XbBPpexImhybaQTxNStkQnwIHa4lpr6DMrjtQUBTEBE2EoWlAnioQG5KUrX
         t4LZC2JdvmhEGS2oGWtS9iZQ5Jxg7j1w91nz6+xd5ovYOyOIbXPLJW74UdiH0CfPJyv1
         PLUOrHlRo9dY7oWWzeQwjNbSXLEh7TiXhb22BXlWWIZzPR8L1aVHdY0reTty6DnyrBCj
         vWfSfq8YfrSliGd0sfvy2U+yH/yNHRVy/SdeZ/8vfaNKhjImSWRFQ5izEtLBUBkByR9L
         JIkr7V7AS7Ig/lzZ4Yyo9vKIVBPkmcmp+H0j1pj4wNd0t7dalDwzjIiYzbN+UikJAgBA
         SNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744732378; x=1745337178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JLTNvpaptplrjpn5KAL5k+FFz54c8FMnV1vnh7J1TI=;
        b=E45rO+g8nfLdNSLIemhwwF5RvnQ36XWjUjknCTM85FobtSk47f/l1yl2ZH6wH+Sak3
         QnOIo82k1owebhdPKysZtOPX2rz5ctA/hEStmXKro3k+MFxKnSIM6Z060VrcySPrjdp1
         7qDfOigO1hbTG7JgVS1EzfdCZ4XzktHPqZufJhynS9bErGih43GqJoe1k65kNedLvgsV
         Uxzw9Mz1GBEYn/8SUAxsirrtFPVIxsNC0frtGusxCfbnAr1CBPfuL6bLJMDOasaoDcOH
         qvC/uoa0J9AI/Q0qFgWDoJXpHKD/KdEeYkWVrzpNItJEc4XhPL2Eqegq9CGthEzqtELh
         xKTA==
X-Forwarded-Encrypted: i=1; AJvYcCXvDc5RFdUZ0RkeQXHn2z6tl2hAypa8qoFhnHjFDjdC7LhamEl0ik0U15CAmML1Y3T+/wvLYhIwxjrI34vsgrmw@vger.kernel.org
X-Gm-Message-State: AOJu0YzA2wrIVmapxOQZn+0FYCXX7BziMF7HKRNwzoe2OExN40BXEf8R
	3Xk/h5QO8GBorAANZ9SajNFbAisijvOWLYrrTsxkGHPrcUUkPea0YEIdXqaXocE=
X-Gm-Gg: ASbGnctOXM1x3ryrWDpZ6Af0MJ+MfGCB2RBh6O0hbeqlhLehEuB5/MBDv73vD/EwDGN
	0rH1V8+kjxM948FOnCiYsaAmUqpZahTxwzeZDigGt3tEa0Z/+EQVV/i+F2Tvvowvd//Dt8gVNKS
	PHRrMAoQ9MAE4lAx0R5nk2rCTAADeSG0C5djQGHro8wVBKpHEz6YAm4BYX9wUtts19IQzUDDTle
	4CTp4Pntdh8fXk7gr1ikCZA1b1mskdtccmpn3drh06t6lxwq9ZnYBSUlnmI+UPCm3v6PDN+dEk9
	7CKhJ2W+iU05kdI6H+80KYDIKNJQKvWK4e9mV9NXKlU=
X-Google-Smtp-Source: AGHT+IEW4aMzZl2rGLN44yAGHE5w9xSC1sSpotrF9GYoahU/09L/4ARMu3yhHo2dTSnx9WvVaGY6jw==
X-Received: by 2002:a05:600c:5107:b0:43c:fcb1:528a with SMTP id 5b1f17b1804b1-43f3a93379dmr138039845e9.6.1744732377761;
        Tue, 15 Apr 2025 08:52:57 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f204c500bsm222451965e9.0.2025.04.15.08.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 08:52:57 -0700 (PDT)
Message-ID: <77036114-8723-4af9-a068-1d535f4e2e81@linaro.org>
Date: Tue, 15 Apr 2025 16:52:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:perf/core] [perf] da916e96e2:
 BUG:KASAN:null-ptr-deref_in_put_event
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>
References: <202504131701.941039cd-lkp@intel.com>
 <20250414190138.GB13096@noisy.programming.kicks-ass.net>
 <Z/3krxHJLaWJTj4R@xsang-OptiPlex-9020>
 <5bc5f54b-ce6a-4834-86d4-5014d44c7217@linaro.org>
 <20250415100840.GM5600@noisy.programming.kicks-ass.net>
 <20250415131446.GN5600@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250415131446.GN5600@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/04/2025 2:14 pm, Peter Zijlstra wrote:
> On Tue, Apr 15, 2025 at 12:08:40PM +0200, Peter Zijlstra wrote:
>> On Tue, Apr 15, 2025 at 10:14:05AM +0100, James Clark wrote:
>>> On 15/04/2025 5:46 am, Oliver Sang wrote:
>>
>>>> yes, below patch fixes the issues we observed for da916e96e2. thanks
>>>>
>>>> Tested-by: kernel test robot <oliver.sang@intel.com>
>>>>
>>>
>>> Also fixes the same issues we were seeing:
>>>
>>> Tested-by: James Clark <james.clark@linaro.org>
>>
>> Excellent, thank you both! Now I gotta go write me a Changelog :-)
> 
> Hmm, so while writing Changelog, I noticed something else was off. The
> case where event->parent was set to EVENT_TOMBSTONE now didn't have a
> put_event(parent) anymore. So that needs to be put back in as well.
> 
> Frederic, afaict this should still be okay, since if we're detached,
> then nothing will try and access event->parent in the free path.
> 
> Also, nothing in perf_pending_task() will try and access either
> event->parent or event->pmu.
> 
> ---
> Subject: perf: Fix event->parent life-time issue
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Apr 15 12:12:52 CEST 2025
> 
> Due to an oversight in merging da916e96e2de ("perf: Make
> perf_pmu_unregister() useable") on top of 56799bc03565 ("perf: Fix
> hang while freeing sigtrap event"), it is now possible to hit
> put_event(EVENT_TOMBSTONE), which makes the computer sad.
> 
> This also means that for the event->parent == EVENT_TOMBSTONE, the
> put_event() matching inherit_event() has gone missing.
> 
> Previously this was done in perf_event_release_kernel() after calling
> perf_remove_from_context(), but with it delegated to put_event(), this
> case is now entirely missed, leading to leaks.
> 
> Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/events/core.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2343,6 +2343,7 @@ static void perf_child_detach(struct per
>   	 * not being a child event. See for example unaccount_event().
>   	 */
>   	event->parent = EVENT_TOMBSTONE;
> +	put_event(parent_event);
>   }
>   
>   static bool is_orphaned_event(struct perf_event *event)
> @@ -5688,7 +5689,7 @@ static void put_event(struct perf_event
>   	_free_event(event);
>   
>   	/* Matches the refcount bump in inherit_event() */
> -	if (parent)
> +	if (parent && parent != EVENT_TOMBSTONE)
>   		put_event(parent);
>   }
>   

Hi Peter,

Unrelated to the pointer deref issue, I'm also seeing perf stat not 
working due to this commit. And that's both with and without this fixup:

  -> perf stat -- true

  Performance counter stats for 'true':

      <not counted> msec task-clock 

      <not counted>      context-switches 

      <not counted>      cpu-migrations 

      <not counted>      page-faults 

      <not counted>      armv8_cortex_a53/instructions/ 

      <not counted>      armv8_cortex_a57/instructions/ 

      <not counted>      armv8_cortex_a53/cycles/ 

      <not counted>      armv8_cortex_a57/cycles/ 

      <not counted>      armv8_cortex_a53/branches/ 

      <not counted>      armv8_cortex_a53/branch-misses/ 

      <not counted>      armv8_cortex_a57/branch-misses/ 


        0.074139992 seconds time elapsed

        0.000000000 seconds user
        0.054797000 seconds sys

Didn't look into it more other than bisecting it to this commit, but I 
can dig more unless the issue is obvious. This is on Arm big.LITTLE, 
although I didn't test it elsewhere so I'm not sure if that's relevant 
or not.

Thanks
James

