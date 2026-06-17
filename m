Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8DE33FE02
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717738; cv=none; b=I/5wNurSi7gWO3rLLt5lrQkpFXzgNH2aJO3ZhLKIX+vawi1y1lYACL++bWRoaN8/l4NSXNZAtqRPQZyCwIQ91hOl6ufeK8fCklMgy9cdtNANSgF9HyAq9GD3/q3+8V4P7GnJq+aJFJNvPUGU1apGpC2o1t7naU532EROysgnzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717738; c=relaxed/simple;
	bh=40AA+w8DMyPZxZArtDvvXE0vfYCyQ96LWNfbLLhav7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=WmOAmZ4+exlEQCnsvj4Z6c64zlshDdi7RarTxbTA20JyoY1yuM1hYKB8gyn99Ncu8GXpxEGaZ+2F1Naqzf+M+l0UniPkxZkWbAWrzTqmX8xSfoxW83Tkt0MKiohz8al6pjy8ygqL3k63rXFPLl9YDZQBefu5oluxOoLkocfvqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vw7XcHs1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vw7XcHs1"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so10074635e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781717735; x=1782322535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZbfT4p8yU7ZrJ4sRwz2av7CZIwruqT0NN3US4mW4m7I=;
        b=Vw7XcHs1v4N9bd6HmTRYBGDZwuckZFM/Wt8IEMggqaPBL0ZiGmhohYpnTuWkfwOAIM
         BC2LE95kpdANHwdlFSqCDC9sChsFmAUaSsjgKKxAQD5jpF0t+Fh5fcgOncDetCmeuua6
         g9+jWinZtXwRzB+NSAUv3gLYV3tYdOCccioHFf7LC/uyLsOzj0MRhbDFAJ4tc4YcUskv
         5qsitcMuvO+g/O3wFmuim3W3Nw/oyz7YpTVK+vNvqIhyXqazWsBG+I9rnhST9RLLHqXl
         uK1/hUUcs18NNZk2qtbjKk4D7PhP5eWLIvQ6JGjx6133FRvzpdKs0BKVE9IUGwl4ugzM
         aDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781717735; x=1782322535;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbfT4p8yU7ZrJ4sRwz2av7CZIwruqT0NN3US4mW4m7I=;
        b=V41XUuTLdmrvjBEIW/HfQtuCgNO9DQCRnLx/ctMS8RXzN45BZg3XyXMEoYwISXlBdU
         wtMyml5cRo/AzVdLeJFB2uy+cPKueS7+cE9WrKn1ONwWnhp4LEjUbtShbzefj664HsF4
         dbAAx7maDHNXA48rsui/YsKSQ9SfIxOH9ec/pJQNXD+Kw/HhETaz/ybZKbw4kQQ7PF7T
         xR7ftrSK4G5Kf0tXtHEa5JLVnGqRJbSrFo/wU679f7JBXSSJuJYgiM4ap0wvkEQ2xZFW
         Yxj+rZXaluw+RZrPMrXO2PbGtYRiERBoAfqatW3EI2OkE6sUHmc2sRVZI7wmWKkvFnrn
         8KUg==
X-Forwarded-Encrypted: i=1; AFNElJ+zVWN9c2O7LYvKcGU2O1QR/v2GF68fO6/7Dm9ubu6TYLI6ZjA1XRo0GPfZJqhC+fC1smuWISjdCKgvYHR0H9vy@vger.kernel.org
X-Gm-Message-State: AOJu0YxSi5V5486vKnXhRoM5WIHeJws5UJqfDuF1IpDKVtgE3v2lXLpF
	0dVc7dYb/FwYNRhLv/FtrEDWEBTcl2wHYOh9dhU60yMyrj1rfdO7DHgckn2XoJxu5WI8+kcf9l8
	A0VnAFZY=
X-Gm-Gg: Acq92OH2u6XHVohsGuxi+/Go6rcs6MxuTwrQuDGp0R0nFYw188rFufrnHak+bwQns0I
	IPlRi4hpqtUAFcdSOcIDZ7FML6ppnXy8VeQOTMI4jZib76T7wPjVEKLWIIG0bl/APMN//wHGlLA
	WFclhV6ocubvWnxGOTjZDWFWbE3HmX5erD90T5YqYgk/FaYfK9ziyUFQAwnjBk1toESentXYj5F
	opu36CA5vTya+FnCaxB+opnygitWxcpCed9TuQ3mq6rYmvrcnfscb7aogkpwM7TIHN2FYZxeSrq
	vBUPGKZDr7AMJw4MLO/3U6sKKG9CxlhI7gaSWv4htu/BeLzQcKNdNtCLxBuJbhuKlMHAWkZl9Sg
	slbfY/Zp733jHNfjV8WpXyO/zTs4ZY5IvdVF34m+HzmC3k1L7UvwRmAlVVZDArQSBjovG2OmYBl
	NvOf+fVpzkS9Oxl8ibOQ==
X-Received: by 2002:a05:600c:6089:b0:490:5000:917 with SMTP id 5b1f17b1804b1-4923815425fmr6793785e9.1.1781717735275;
        Wed, 17 Jun 2026 10:35:35 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923687d2casm30255415e9.0.2026.06.17.10.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:35:34 -0700 (PDT)
Message-ID: <41a05d00-a870-490e-beed-5c4eff46db38@linaro.org>
Date: Wed, 17 Jun 2026 18:35:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 9/9] perf test: Add Arm CoreSight callchain test
To: Leo Yan <leo.yan@arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
 <20260616-b4-arm_cs_callchain_support_v1-v9-9-f8fad931c413@arm.com>
 <6855d77f-d2f4-4dab-8481-a8c586e4872b@linaro.org>
 <20260617123322.GD31870@e132581.arm.com>
 <20260617150828.GE31870@e132581.arm.com>
Content-Language: en-US
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260617150828.GE31870@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/06/2026 4:08 pm, Leo Yan wrote:
> On Wed, Jun 17, 2026 at 01:33:22PM +0100, Coresight ML wrote:
>> On Wed, Jun 17, 2026 at 11:03:07AM +0100, James Clark wrote:
>>
>> [...]
>>
>>>> +	# It is safe to use 'i3i' with a three-instruction interval, since the
>>>> +	# workload is compiled with -O0.
>>>> +	perf script --itrace=g16i3il64 -i "$data" > "$script"
>>>
>>> Is there a reason we don't generate callstacks on branch samples and use
>>> --itrace=g16bl64? That removes the magic number 3 and reduces the output
>>> file size and test runtime a bit.
>>
>> I checked Intel-PT which does not generate callchain and branch stack for
>> branch samples. I just keep cs-etm aligned.
>>
>> I can add callstack / branch stack for branch samples.
> 
> Tried a bit for this.
> 
> The branch stack is skipped due the check:
> 
>    if (is_bts_event(attr)) {
>            perf_sample__fprintf_bts(sample, evsel, thread, al, addr_al, machine, fp);
>            return;
>    }
> 
> For the callstack attached to branch samples, the output seems not
> directive:
> 
>    callchain_test    4372 [003] 75596.459422:          1 branches:
>              aaaaabdb0794 print+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>              aaaaabdb0798 print+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>              aaaaabdb07b0 foo+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>              aaaaabdb07c8 main+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
>              ffff9a10225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
>              ffff9a10233c call_init+0x9c (inlined)
>              ffff9a10233c __libc_start_main_impl+0x9c (inlined)
>              aaaaabdb0670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)
>              ffff9a2206a0 __libc_early_init+0x100 (/usr/lib/aarch64-linux-gnu/libc.so.6)
>   =>     aaaaabdb0768 do_svc+0x0 (/home/kernel/leoy/test_cs_callchain/callchain_test)
> 
> It is hard to digest the log as it separates branch from address
> (aaaaabdb0794 print+0x8) and to address (aaaaabdb0768 do_svc+0x0),
> and put the callchain in the middle of from and to ranges.
> 
> Given this is not enabled by other hardware trace (e.g., Intel-PT),
> and we need to change the common code to make it better, I'd first
> enable callchain/branch stack for instruction samples. Let's see if
> further requirement after get this done.
> 
> Thanks,
> Leo

Yep that sounds ok to me
