Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA6382383
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534308; cv=none; b=XhRIjGL5PG/flUyOxti/eHseDuLqAVtlz8IuxzIqrF3RSe9jZVnfsmruMuAHLpSP9UHcNnM50oqX8XPwl0N+UEeWom9uSjhEEWYgGmieY7UwgOTviOICk3atfrKgKQLtdsyAQV/X1lIOVGfVP5nPCMb/Z2X6358mX7xOx25KoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534308; c=relaxed/simple;
	bh=taiMMM4Q9ienyOKePrmJLIt8IiDl6KKB7YEh0peOMmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYrGtnzjymNRWx4ww/R3z+JV8HAHLyIjUpCxhY3C0KL4HS/cJFztu/hlqLOyW7956EQGCACV1IJnuiN01oo46nHB7MsHblfXHxYUaLvS+RvOc2g3ApxxQjvWmGq8bvrVDE19zsI/ZbyW7qvQPisDabFbFNFVbyp3fF8alaggdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOw60Zlk; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOw60Zlk"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4327790c4e9so4097217f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 02:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772534306; x=1773139106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnBOzFJcfXoWhFGXXIv8+0FYSpLPtwiqAebZRn6kZlI=;
        b=AOw60Zlkkaf+mww2O/NRXzsS1/RVSVST5Mp5Wshj59j/i9sfftqIJo4oBn1s+cQhdP
         PjaPG75qJAqp9lOyo/7a8wRNUOTmUllyZ3PXG27ctQacqubHqaPO4ucDc5AskWEMiOLx
         Q8J85P19wLTAHNZwO3ZStOLKUlnCJkTIf31RyvrXMpOZ9p6hWh0Msx3rhv2sDGY4c0Og
         nFjc4k+tO8xhpaPstYIwO6Iw/EnlH1gDZw5aet26zqpmaCBbYv0PJaaf8WLuzlXdOA/3
         Gj4OOWktYyp8wznJxAiKoT4AdN0h8e8lnWNwtXLkAliIY0keJIhs9qp+lo5JEN29AE11
         Fvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772534306; x=1773139106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnBOzFJcfXoWhFGXXIv8+0FYSpLPtwiqAebZRn6kZlI=;
        b=XF0XQ1/9VFFOR59UsCj5hOvt723rilVVaqlvrm8EyDFoAtmi45QhcL7TrFnuu5GkDP
         WnYdSC3X17SfGe614Gnr7H32sIeO1SCucSSSs+hfnuq8nBUwzSWh23NwNpPSznkfGFpz
         i3HTDZS1lQ1HrJhSC7gAoOIS9dwpEQ0FpN/iV2jBWaPv0NXK94mseIGi88nzRTWtWtvO
         Q5to6kxbVtT71ZUu62+W2RtINieUehAmmMxYSz718hmHJegNw9o2w2B1U+J/9yEnc9rB
         LwApsmIYviZpbnw1pp0cvdJ6oT9sNu8ZRRX+t+hyM7iUccW2zX0p9WENwsC0TkEWtkLV
         VZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeEiU6TMNG0kCYjml6Uvz2gnkfuLqA41/tNVBM5ljZcn8iMJMy+p83SdNB4Vj6PeVVvS4QIYlwucLKnD79fIqo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzui0QF2JRY8H7mYDdz3yQqGQ9ACnd87eQOHabYGtF/uYRbw1og
	aKRHWgqpTRFnrtWFVE0F9vFEoVPfqje3gLKep6CpS7c35tttXBF39BNM4FZASiuzRl8=
X-Gm-Gg: ATEYQzwFy1Z3B3X2aGLiGb7DJR+CUTNG8pINwYFe++rLVHArI3LSSqOH/C7DX2+A3Gp
	dqKQ3ZnQNhC9fLcZBZBvfZVFFoK3Yx8ViAX9DjERyAy+Em1kt3hFXH9RtBworlNT4lS42sHDVQ5
	0RPkx6S1uZg6NjTX6dNQ0EuLO/sf2TrsCmCK+7AmlkxmjcORdHkMmlpo2Z41YiEkt3PCOJACEO9
	RwVtoNx/0Cni1F0kMzWWJu/OKKFurhoyNFt5kzTVBrRVjPFEWZJYD3XFvyZ3WKcSnSx+1jxSUDl
	w7SAh3QycasD0sUokV7QamZOvABX27pt9ORialBjNfdHYUtsoKORQOLMgiBNXu2OEhVJNePvPdy
	KKYojih06oJoYI2cjEdKRhxxXgXQk6EdcdZYJ7NwLzlkHt3FmSantjxib9pHSrGfctVvWo+RRbZ
	fNgmx87gf1ReF+okm/FSNSOCV0ajAgxhMABVWWuk8=
X-Received: by 2002:a05:6000:2c10:b0:439:b744:c5fa with SMTP id ffacd0b85a97d-439b744c836mr12755157f8f.30.1772534305718;
        Tue, 03 Mar 2026 02:38:25 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60e40fsm33905284f8f.7.2026.03.03.02.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 02:38:25 -0800 (PST)
Message-ID: <197f3d1e-5d1e-4b2d-a12b-782287eecc43@linaro.org>
Date: Tue, 3 Mar 2026 10:38:23 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] perf arm64: Send pointer auth masks to ring buffer
To: Jakub Brnak <jbrnak@redhat.com>, James Clark <james.clark@arm.com>,
 Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 broonie@kernel.org, acme@kernel.org, Andrew Kilroy <andrew.kilroy@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>, Mark Rutland
 <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kristina.martsenko@arm.com
References: <20221020101921.1219533-1-james.clark@arm.com>
 <20221020101921.1219533-2-james.clark@arm.com>
 <Y1F8DUWaWhlh/phL@hirez.programming.kicks-ass.net>
 <4e50b890-0588-1551-fb7c-6cd8191d1054@arm.com>
 <Y1q914IVy6XgE1xq@hirez.programming.kicks-ass.net>
 <133c2f4b-1ca5-2d0c-f4f4-e01ff5e028c8@arm.com>
 <aaW7s-ISz1QGpmqB@jbrnak-thinkpadx1carbongen9.tpbc.csb>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aaW7s-ISz1QGpmqB@jbrnak-thinkpadx1carbongen9.tpbc.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/03/2026 4:33 pm, Jakub Brnak wrote:
> On Mon, Oct 31, 2022 at 01:48:56PM +0000, James Clark wrote:
>>
>>
>> On 27/10/2022 18:20, Peter Zijlstra wrote:
>>> On Tue, Oct 25, 2022 at 04:28:12PM +0100, James Clark wrote:
>>>
>>>>> Why do we want the same mask repeated over and over with each sample;
>>>>> should this not be part of the address space (side-band) data?
>>>>
>>>> You are probably right that it could be done that way. The reason that
>>>> we did it this way was to be consistent with ptrace feature [1] where it
>>>> is delivered to userspace on a per-process basis. And there is also a
>>>> prctl for the enabled key types [2] which can be changed dynamically.
>>>> Particularly for the last reason is why it was done per sample.
>>>>
>>>> Having said that, the enabled keys field is not used by perf, only the
>>>> mask is used, so I can drop the per sample data until enabled keys is
>>>> needed, which may be never.
>>>>
>>>> I'm going to assume that perf shouldn't use ptrace because of
>>>> permissions and conflicts with debuggers, so I could put the mask
>>>> somewhere like PERF_RECORD_FORK instead of per sample.
>>>
>>> Yeah, or create an new RECORD type which you can also send around at
>>> prctl() time.
>>>
>>> The only thing that's needed on top of that is exposing the mask
>>> somewhere in /proc for existing tasks; which is what perf also uses to
>>> syntesize RECORD_MMAP events on startup etc..
>>>
>>
>> Hmm ok, in that case I can just add the /proc interface for now because
>> the mask won't change and we can add the new record type at the point
>> it's needed in the future.
>>
>> Thanks for the feedback.
> 
> Hi all,
> 
> Does anyone know how this issue was eventually resolved?
> Specifically, is the mask for the pointer authentication bits
> currently exposed and stored somewhere in perf.data so it can be
> used when running perf report?
> 
> Thanks,
> Jakub
> 
> 

Hi Jakub,

No we never finished this, you're actually the first person to mention 
it. Can you give a bit more detail about your use case? Maybe we can dig 
out the old branches and work on it again.

For a summary of the current status, frame pointer unwinds in the kernel 
are working with pointer auth because the kernel strips them.

We patched libunwind for support on commit f67ef2867bc5 ("Unwind with 
pointer authentication on arm64"). And libdw on commit 0af6c7289c22 
(libdwfl, aarch64: Demangle return addresses using a PAC mask). These 
two were to support dwarf unwinding, but the kernel changes to expose 
the mask and Perf changes to pass it to the unwinders were never finished.

Thanks
James

