Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78A37F8D2
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Mar 2026 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615408; cv=none; b=Edlz4ln/BQs2V7L18moLeLmfn8aVhXchxvcW7wNdr/WJxV3jvQYrheqLNYPyeFcUKDxpI/sqIO9ZVKG0WhKLIL2ML589XBkrmiOaComrFLG0CNbKyFjzSUUU9LVv8Yt6vz3qr/c7TQNEmGwM+lsFE9aT3lgQcvNbBDrhYY2fdlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615408; c=relaxed/simple;
	bh=xTHcZR9Y6fW3DtqZPI/YYZUQPXkPFsw7XdARufuD4qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLdtVwUtxdkiR0wUKaIR4067gPnBLh4CCr1d6I6oef8vlQBskamgBMG2xhVPGwr+w0gtZEcMQYczFPdjHs6e5AgPB/SOsFN5LtyO4DF7WfIAqPrMVbv9YObZfSYQSsyROGr69LZyf2vsVTXA0kEgge+vqsq76wqUNfzOqnYKLpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=frZOQien; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frZOQien"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b78b638eso3174965f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2026 01:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772615406; x=1773220206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4CAhwn0L/es+Z/kiWXoW/P41mLkYQ6qC5q4Cz2nXIOA=;
        b=frZOQienvsalSRQ4kPRQbAjCpJNcvFVPQEWT58XYCOHUIruAIVk0S/mHxkRyxpIvGH
         YCUSzTeh62D4wWbexS+TgI/VHYZX4pzLCnsHuPGxE3J9i6kdeY5uXPlUHUqp3ei+tQrr
         jK5Kte3vSGX/Ld0q3/ZzBLVl7OCrCbShLveI40v1xqMGfRNM8BQQRRFeLy57xpFvsgSu
         sQuv2Zy6QaERTHP1bzl+AraCuxdB0UDdeNew0mdxkfEKF8EQMokxEGsCmLqgMUMUq21E
         Fg/9LGTRM529Nr0O6QGiRuBREHaJlU3vTcK0+vbDJjqYI4ACeTCLYDFKwQMivp+qhN9R
         oQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772615406; x=1773220206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CAhwn0L/es+Z/kiWXoW/P41mLkYQ6qC5q4Cz2nXIOA=;
        b=v1PE9tpTVwxSmSaFDQ0qdWaSb/uHJpAaGepr9K/UQYs1GC9VqfZ+3nQxjr5wlroSXf
         bNpGQTYyPw+GkRjWiuJtD7T4ecSBxWtL7+VyYNWNBi3ihd9eSiW45yiSkxCK7Ew5gVnB
         851yW4AEwnS14In9y1KRWOLztasbHSoU4/lDms7RBxCobxMTnhHUGvPi5UH2C1n/kgcC
         HJ6NhVK8Q0O45LTiAUmVNu2QwhhJwPqgseclcG/sNiUdPAQGtWJv3TZwY55Dbh1mEV3Z
         sA2AygtOTQl1nlS2hBG/rduAUVWK0wNwwhunfPCml3uMPELAGX3k3MrnoHLz9GoMIzCf
         bG2g==
X-Forwarded-Encrypted: i=1; AJvYcCVbsT/CtK28uSiK7nzU4K0T/4TZKWKlaSMhbhgKL5qYWSv2zQYyfP2MozB2qOdUL5+CuwH+wciFUbBUujau8AsG@vger.kernel.org
X-Gm-Message-State: AOJu0YxqSJ8ROTSRmNWTGsiBlwxFv9OQnz9se2/nGa77dR4blgMKuOty
	VfBvnI+VbvF0dtVTC/HyiQIgsy9Y4SuBQRGWRteGL7INZEHHaTbiXjsi8BGtd03xL0Q=
X-Gm-Gg: ATEYQzzFySgm5DAAONemCEajxSQpcwMUpAf1NNWmuk7yjSktmKpwf8Ihk2x1+UJ33PX
	RDxAi+D71gkNvmLClfhAifrrHcPPUNiSfbKWj6N3XXvZ6gzr+T/ztw3yM2RGKQMpAy6bMXUFK1e
	O2C1GHAN+ot/i2NACVPWYQb9Il4rLkz/lQEZFl14KrMc3NJR4s5aS0per7rYSrO0911haq/Hk9+
	X6lKxQgAAT7OwucaB2SrhhJM+BtubzFB4hfVOYWYMZpUKFMnKXgC22gdU7ttGEnNj/qAiPL9l2h
	LQOy/T2Iw1pBCKbz/mGWeidaScOG54xzZth+Xek/DgZZbukjwfc437XYETW3IA9Xahyie7ADNl2
	qAYlzd9ydC19V70dqhuvtV1od/s4JARw2xXgliFm4YU5B3MAzKfrRfChBTC0yM+hxsCf4uZNvox
	/YuR0KobwomM+LtVdaeV1SHOnn8zr1
X-Received: by 2002:a05:6000:604:b0:439:b744:c5fe with SMTP id ffacd0b85a97d-439c7ffcb6emr2262601f8f.52.1772615405678;
        Wed, 04 Mar 2026 01:10:05 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a5970sm17858078f8f.33.2026.03.04.01.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 01:10:05 -0800 (PST)
Message-ID: <7b008bb8-47de-450b-823f-29d28b2366f0@linaro.org>
Date: Wed, 4 Mar 2026 09:10:03 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] perf arm64: Send pointer auth masks to ring buffer
To: Jakub Brnak <jbrnak@redhat.com>
Cc: James Clark <james.clark@arm.com>, Leo Yan <leo.yan@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org,
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
 <197f3d1e-5d1e-4b2d-a12b-782287eecc43@linaro.org>
 <aab9ioyUSAZ7n8Gw@jbrnak-thinkpadx1carbongen9.tpbc.csb>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aab9ioyUSAZ7n8Gw@jbrnak-thinkpadx1carbongen9.tpbc.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/03/2026 3:26 pm, Jakub Brnak wrote:
> On Tue, Mar 03, 2026 at 10:38:23AM +0000, James Clark wrote:
>>
>>
>> On 02/03/2026 4:33 pm, Jakub Brnak wrote:
>>> On Mon, Oct 31, 2022 at 01:48:56PM +0000, James Clark wrote:
>>>>
>>>>
>>>> On 27/10/2022 18:20, Peter Zijlstra wrote:
>>>>> On Tue, Oct 25, 2022 at 04:28:12PM +0100, James Clark wrote:
>>>>>
>>>>>>> Why do we want the same mask repeated over and over with each sample;
>>>>>>> should this not be part of the address space (side-band) data?
>>>>>>
>>>>>> You are probably right that it could be done that way. The reason that
>>>>>> we did it this way was to be consistent with ptrace feature [1] where it
>>>>>> is delivered to userspace on a per-process basis. And there is also a
>>>>>> prctl for the enabled key types [2] which can be changed dynamically.
>>>>>> Particularly for the last reason is why it was done per sample.
>>>>>>
>>>>>> Having said that, the enabled keys field is not used by perf, only the
>>>>>> mask is used, so I can drop the per sample data until enabled keys is
>>>>>> needed, which may be never.
>>>>>>
>>>>>> I'm going to assume that perf shouldn't use ptrace because of
>>>>>> permissions and conflicts with debuggers, so I could put the mask
>>>>>> somewhere like PERF_RECORD_FORK instead of per sample.
>>>>>
>>>>> Yeah, or create an new RECORD type which you can also send around at
>>>>> prctl() time.
>>>>>
>>>>> The only thing that's needed on top of that is exposing the mask
>>>>> somewhere in /proc for existing tasks; which is what perf also uses to
>>>>> syntesize RECORD_MMAP events on startup etc..
>>>>>
>>>>
>>>> Hmm ok, in that case I can just add the /proc interface for now because
>>>> the mask won't change and we can add the new record type at the point
>>>> it's needed in the future.
>>>>
>>>> Thanks for the feedback.
>>>
>>> Hi all,
>>>
>>> Does anyone know how this issue was eventually resolved?
>>> Specifically, is the mask for the pointer authentication bits
>>> currently exposed and stored somewhere in perf.data so it can be
>>> used when running perf report?
>>>
>>> Thanks,
>>> Jakub
>>>
>>>
>>
>> Hi Jakub,
>>
>> No we never finished this, you're actually the first person to mention it.
>> Can you give a bit more detail about your use case? Maybe we can dig out the
>> old branches and work on it again.
>>
>> For a summary of the current status, frame pointer unwinds in the kernel are
>> working with pointer auth because the kernel strips them.
>>
>> We patched libunwind for support on commit f67ef2867bc5 ("Unwind with
>> pointer authentication on arm64"). And libdw on commit 0af6c7289c22
>> (libdwfl, aarch64: Demangle return addresses using a PAC mask). These two
>> were to support dwarf unwinding, but the kernel changes to expose the mask
>> and Perf changes to pass it to the unwinders were never finished.
>>
>> Thanks
>> James
>>
> 
> Hi James,
> 
> Thanks for the answer. I was investigating a failure in one of the perf tests on
> AArch64 RHEL-10 that verifies stack unwinding using DWARF, and it was consistently
> failing. I dug a bit deeper and discovered that DWARF unwinding in perf report does
> not work correctly at all, and addresses polluted by PAC bits are likely the cause.
> I stepped through the program and observed that in libdw the code path responsible for
> masking these bits is executed, but the mask is always set to 0 and therefore has no effect.
> During the unwinding process, there is a structure that is supposed to store the
> mask and use it later. However, since perf constructs the unwinding context offline from samples
> and currently does not store the mask anywhere in perf.data, there is likely a no way to propagate
> it into that structure. It would be nice if we could push this forward.
> 
> Thanks,
> Jakub
> 

Sure, I can put it back on the todo list.

