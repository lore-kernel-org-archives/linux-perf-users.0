Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693E3815E2
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773958870; cv=none; b=cqhxiJPXVwettTMF6jVlt4gMQqzAYZe6nCtXzVoSLq56WtPojZbYcN2F011H0UlhHyix88EAyXWXUPBLvYgw2JCK/Es+9FKYVa3RGGgwfrLlGgn7vg5QUTo1zQMOU0puBNetPkrVJcEdZC0phSEnd4zD2tHq91e9waCiWhRT8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773958870; c=relaxed/simple;
	bh=ZBH6NS3ja5+c+YNg5rCrzPVnOSo36P3Iy+l5/5xqIYI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=q0ZEx/tfVXVuNi4IHzPRUaDwe35TDOmjl7PMOjP4xULPRXyumfqkZZ7PRz0F8kAN0KE5U1uQAqiTgONhOnoCdc3vf7B3BNTKA6c5DuyThsUexLBfLA8TGKV5tsUpLu+U4GNSr3L2eWDJOJoRce49et6pLTCaDEFK0C6czkPeugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lah0f46P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lah0f46P"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so12329795e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773958867; x=1774563667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qlrYoKxU1+2i+RAnVyvubSDpYIvMgPyLxmBALMH7/EY=;
        b=lah0f46PxYUE96FDaKt9sRDQO3c+eQTeoy16qTYD+rRoZovaqq9Ava1AMowd50nPFt
         F2eZ3NBs/VEVi92jrIq6DRzXl9PG5hJtSxOc/rb5ldJltw+RxpuzVy7S2ZUR3kE267uw
         iZVAs6wF0co9kOXCjtnrlwqsH23qo0lbTsA2bdCmd0UwpPOMGIEFeD5KsY0tKE3rMD3W
         llQnP2GrMJZldU4TSq6TpPyG42/pwlW5m/SRAI2QCTauYO0QnQT8ltDir6n40J/CpB8o
         Kpdl1LHFotZv09uRgMXe3FidU8P3v/z8ffBhkc/zHVk9tIO8FVo8XyCNdCq9oVY8Nt3A
         CcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773958867; x=1774563667;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlrYoKxU1+2i+RAnVyvubSDpYIvMgPyLxmBALMH7/EY=;
        b=CAWcMxGvOQBmN1VavO/zJpass4Mw9Xh6k1hqvdbqgHlzGYlf4dXTdoGE9xmzddlliN
         5BF2+H8OZIBQnFgGKkVfPxnHYY1YhCaTgsGTTAnMcwTkN1cPT+Snef58zQmS5z4ezPI3
         4qIYC/ptWD9pQdp8a8+aEGsEQXgGqNgMbWFwdJ5XMVonp9jqpW0jf9SBBajgPdRhIRhO
         QdVljQ5hJ67Pw2DrXovPrlAzmbK4lxOEOV9M3d8MdVQbd14/QlZv258pamink1vVneRY
         xn8zqZ0wo9PRRnjyQ7yP7VVTQuow95uH6ZX5PfHJt13DH5yKusxqGIXUDxPXrJsV0vvn
         6EvA==
X-Forwarded-Encrypted: i=1; AJvYcCViEiqMqlo0OOkcQdlOkMjkrAk3qIVVG5K24mHE60Ow3ztD67PCCb5+mgUmALEJWlblVIRBXv2wZlzpP0oQQIgP@vger.kernel.org
X-Gm-Message-State: AOJu0YxC/Ho6xWCcPYGTZVUksTYLA+ClvsodJz9lEiI7sjroFeHT8ChM
	hh9PGKx8jrtJU9RRkTYRIbePIZwgFxcXDGwQ9Z3wrF506Fy67kQFwxlF
X-Gm-Gg: ATEYQzyQEQdC7sapprHDspjFxvb4kwoB7rxoPGZnv5UtlzcSYTPSdv5UxnDRcOmie9L
	j4ONqUusXPBL5311dA4rGl1BfpZEUdtlPhncFCpwMlfjobC8XB7L23uSZ08ei1vrOdE+wju+9V0
	f3xirwfIKBMoeb5bOd7NHdnBmz7PLF2smNcADdgxo8zYdsRO6hqAv1xy/Pihf8ebvPmb9bV9SIr
	n8lzAHTs3W53k0jWASxLi6yEKYBtUn/DqNOdn+vzGAUlzELqY3QkGrYThybMRd52sbHttMW7Mpp
	XxIIGwS6zYs1Ws5m+qaAInIk6cgZkVwXCccSWb47G5xRjJ9l5QUP78zXkEbs1oW5Q2OgWSONwx8
	OvEXI7fVzeRM59K7pHfK5lEQN/e73C3Q5Wp7m1GK9BWVQuKxCv6SJdumzqhg4rmsVaeEZewPtIU
	tiRC2Q7cXeNc7WRZSqWL06/r96BqQ3bY1M27fAfoFn2T5XRrZaS5yBfNyoh+NDJNUrXNc6OzNL9
	yHZrpUFPw==
X-Received: by 2002:a05:600d:8401:b0:485:35a4:939f with SMTP id 5b1f17b1804b1-486fee297bcmr8481075e9.28.1773958866366;
        Thu, 19 Mar 2026 15:21:06 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5402:d840:f1ee:c5d:74e4:6e19? ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe889652sm7216775e9.2.2026.03.19.15.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 15:21:06 -0700 (PDT)
Message-ID: <a8a8ad35-7e92-41ec-b6a5-b471a91811b2@gmail.com>
Date: Thu, 19 Mar 2026 23:20:59 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Aldo Conte <aldocontelk@gmail.com>
Subject: Re: [PATCH] perf/x86/intel/p4: Fix unused variable warning in
 p4_pmu_init()
To: Dave Hansen <dave.hansen@intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, tglx@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 james.clark@linaro.org, hpa@zytor.com, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20260319152210.210854-1-aldocontelk@gmail.com>
 <cab98c76-9772-46f8-8830-68c7af453aaa@intel.com>
Content-Language: en-US
In-Reply-To: <cab98c76-9772-46f8-8830-68c7af453aaa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/19/26 4:30 PM, Dave Hansen wrote:
> On 3/19/26 08:22, Aldo Conte wrote:
>> This patch prints the full content of Model-Specific Register
>> via `pr_cont` and so both the low and high part. It is also
>> very useful to have the contents of MSR_IA32_MISC_ENABLE
>> in dmesg for debugging purposes.
> 
> I'd probably just switch it over to rdmsrq():
> 
> 	unsigned int misc;
> 
> 	rdmsr(MSR_IA32_MISC_ENABLE, misc);
> 
> 	if (!(misc & MSR_IA32_MISC_ENABLE_EMON)) {
> 		...
> 
> I'm kinda surprised the compiler is complaining, though. I suspect we've
> got a ton of these around where one of the registers isn't used.
Okay, your comment actually caught my attention. I looked into it 
further and noticed that `rdmsr` is defined as a macro in both
`arch/x86/include/asm/msr.h` and `/arch/x86/include/asm/paravirt.h`. In 
the first header, however, the expansion shows that high and low are 
evaluated as follows:
(void)((low) = (u32)__val);                \
(void)((high) = (u32)(__val >> 32));            \
so with a sort of warning suppressor, whereas in the second header, the 
(void) is not used.

Now, the file `arch/x86/events/intel/p4.c` includes `msr.h` and thus the 
expansion of `rdmsr`, which in theory contains `void`.

However, scrolling through the msr.h file, you can see that if the 
CONFIG_PARAVIRT_XXL configuration parameter is defined, then the second 
header (paravirt.h) is included, which then causes rdmsr to expand to

#define rdmsr(msr, val1, val2)            \
do {                        \
	u64 _l = paravirt_read_msr(msr);    \
     val1 = (u32)_l;				\
     val2 = _l >> 32;            \
} while (0)

Since there is no (void) in front of val1 and val2, this will trigger a 
warning.

I admit I'm a novice in this field, so what do you suggest is the best 
fix at this point?
Should I use the “warning suppressor" with something like
     (void) val1 = (u32)_l;                \
     (void) val2 = _l >> 32;            \
or implement the solution you suggested?
