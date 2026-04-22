Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD232A3FD
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852174; cv=none; b=IuycdrsmGq/ntQmQdVrHL7jg8/MHd1qrfqJ1usoCbzBd+5Eo/KgQqc64Eu315eOkpr3MzM86rKEgzAh3CFla5+vQ9s259z5fx9rs5Cwt561wCq0CjrOMFqGRtO+EVnAQx+OstYQyRZ2TpxdfBjSd2sZG7mS9cxo8oO2rB4ECig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852174; c=relaxed/simple;
	bh=u8rIo2p9Vf23h1Al8Mt+KHFE5zan914uUk79lylcKvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8AJPihSWdlHuojK0WX/QKpcOep7Ut6MOnbyAnqgK2DM4ZbKxkDU1eMotca+Phs6j9UW38mFnoR2PnXoHeHdBe6BWxmqPwO9WdZUQ4EwXJ3GVKRQVHZiJ8d4XiOhpQS0S0wFG3s1YElLJ83gy5UYZBOQ7gUSJOCDQjVUnDReRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Olhj8oj2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Olhj8oj2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so42984685e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 03:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776852172; x=1777456972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVLsRbZRawpqylPGnfo96Im1C4lXMT3MbehKmfyXIiY=;
        b=Olhj8oj2ITVNsgLgenyP64VnxplDAneta+KTuvRXdcQlbSxFLxt+xcCZtAf7r7BcIA
         1avdQ57iazvWmj/ppb4kMvV7qNgnjEZAT/3K1EFMqbEGFe+QYebDDWegBS/iSzhA3RJI
         jAUErun8atlqdDSpCULoA27AOHkQlIaAFZ8w5bt8CV1Vgffpz6RFM2JBBnX2TIB8z8Mx
         VV9ivBRubX2ZS91iPnhAHFHXDeHxBLkP62d0CplrFqBe7eW9aTpvAX+po0qomXDCpL2j
         /DNu21fUzH2H1kBSrrfbNlJoGxIO++48znKJ8knKKdI0Pq4Xjy8EiQ72aurKNsADXnfq
         Orrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776852172; x=1777456972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVLsRbZRawpqylPGnfo96Im1C4lXMT3MbehKmfyXIiY=;
        b=MSd9NZ4Pwv5kUllISCg0tOZUjJdIx9WNx1FTTEARAcLfikoZT6XS2lEc7hqCYYE7Mq
         Tt2cd1UKqCAIgg1fFQdLx4oimKptjpR8Jrj3LVGyxfYnZ0D4EdkcXrWgEDQeW6cjLMnk
         G9SCfx6a+6A2PFR9NJB2YFamx2ZsGqyFgjptOsuMh5daaeEZ9Ne57MOHMS1tczNLzLhP
         Z0UZQdhV6NGuiCHTPsuyanR514IDHYGvpriXC7mWFqrALji0//rHnWzzrWErihcuF+b1
         sQE7xa6twViqoZLHuyTU6HUiC16Z920UfpyzWFlux911aaRjgS/hwfYqhVOh+RguISSh
         MfKw==
X-Gm-Message-State: AOJu0Yx5eLXq5QPsnrevIsOaNZBZ2q/dALtx8EIFBtuDj/Dt3FCwVp4Q
	NvyXYKFhvXK9rHWr5XAEHsuST9Cq4mDFX3Crg+C6PnJpox9wQfUEgdeDI21BgIoVvmk=
X-Gm-Gg: AeBDieuUV+dRt1NyneTaf2YvakI83/saiyetAqBwmowVVHW+dOxhObKvrFr+PIMwhUo
	uyxoJNvUepKBypO82AsADixRNss0xShHVRDIhQaKFVCptxhq5Onp3/NrtNQ70kFgdJDIP5DsHog
	81vFFTClyg4wBgcQxk1Jro+stIxwqhyxQt7xlq9qccT8wARp5v8N2dRBbEC8zMRbg+JkdwxGFH6
	1Uv2br47lTkcDWyT/vYnjyKbES6bXTDit8kYUE3nR8HLzbK+bV+UyG8HxgCMMtEaiIxnX8qGubG
	+TqMELZFLcXBVPeXDiqmjVNXmib/Nshi09mK1LT4SfgA4pv9expzJE5ubO2VmB0UeYQPZiPah9+
	4sF5sHRNdVt4RKA0Y38+wKM47w+V1r9Wfgj8Ftacicy2z3wwG0uxq/+JfLC+s7hGdgtFzza3b9L
	p7uOZ/D01NXo7zMcXRA0i0y2grXJp07vXQ3ljdCUAbWMk=
X-Received: by 2002:a05:600c:c108:b0:488:a82f:bbb6 with SMTP id 5b1f17b1804b1-488fb78e576mr215792605e9.27.1776852171487;
        Wed, 22 Apr 2026 03:02:51 -0700 (PDT)
Received: from [192.168.178.64] ([84.246.200.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm264458735e9.6.2026.04.22.03.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 03:02:50 -0700 (PDT)
Message-ID: <6637f991-4f4f-480c-9d3f-3f44363477a8@linaro.org>
Date: Wed, 22 Apr 2026 11:02:50 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: fix "argument list too long" in second
 location
To: Markus Mayer <mmayer@broadcom.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Perf Mailing List <linux-perf-users@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20260409221418.185343-1-mmayer@broadcom.com>
 <20260409221418.185343-2-mmayer@broadcom.com>
 <d9c9eddf-8f66-4757-98b4-16b4ba505f5e@linaro.org>
 <CAGt4E5tinak=M+301yDCE_R0qREcQvWY6uGQ9vPZjhfrCTxk7g@mail.gmail.com>
 <ee8e6379-6bb4-4a83-87d3-5ae30fc0e95c@linaro.org>
 <CAGt4E5t4v3ztJPFRX-x0ygTk3cgnM_SwB_t+vvbNJ+_ifa=KHA@mail.gmail.com>
 <aee4R3i-xnb0F0qb@google.com>
 <CAGt4E5snokobnozpiVcAUKuj3nmOMifNWn2ZT+KKPcRqZh2-dQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAGt4E5snokobnozpiVcAUKuj3nmOMifNWn2ZT+KKPcRqZh2-dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/04/2026 22:12, Markus Mayer wrote:
> On Tue, 21 Apr 2026 at 10:47, Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Mon, Apr 20, 2026 at 11:26:42AM -0700, Markus Mayer wrote:
>>> On Tue, 14 Apr 2026 at 03:43, James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> On 11/04/2026 02:07, Markus Mayer wrote:
>>>>> On Fri, 10 Apr 2026 at 02:25, James Clark <james.clark@linaro.org> wrote:
>>>>>>
>>>>>> On 09/04/2026 11:14 pm, Markus Mayer wrote:
>>>>>>> Turns out that displaying "RM $^" via quiet_cmd_rm can also upset the
>>>>>>> shell and cause it to display "argument list too long".
>>>>>>>
>>>>>>> Trying to quote $^ doesn't help.
>>>>>>>
>>>>>>> In the end, *not* displaying the (potentially long) list of files is
>>>>>>> probably the right thing to do for a "quiet" message, anyway. Instead,
>>>>>>> let's display a count of how many files were removed. There is always
>>>>>>> V=1 if more detail is required.
>>>>>>>
>>>>>>>      TEST    linux/tools/perf/pmu-events/metric_test.log
>>>>>>>      RM      ...634 orphan file(s)...
>>>>>>>      LD      linux/tools/perf/util/perf-util-in.o
>>>>>>>
>>>>>>> Also move the comment regarding xargs before the rule, so it doesn't
>>>>>>> show up in the build output.
>>>>>>>
>>>>>>
>>>>>> I'm assuming this is just a cosmetic issue so it doesn't need a fixes
>>>>>> tag? And "upsetting the shell" doesn't cause a build failure?
>>>>>
>>>>> No. It's not just cosmetic. It absolutely DOES cause a build failure.
>>>>>
>>>>>   From the cover letter in this thread:
>>>>>
>>>>>     GEN     linux/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/extra-metricgroups.json
>>>>>     TEST    linux/tools/perf/pmu-events/metric_test.log
>>>>> make[5]: /bin/sh: Argument list too long
>>>>> make[5]: *** [pmu-events/Build:220: prune_orphans] Error 127
>>>>>
>>>>
>>>> Ah in that case it should have a fixes: tag then. And it's worth putting
>>>> the actual build failure in the commit message IMO.
>>>
>>> Unfortunately, it looks like the patch was already applied.[1] Is
>>> there anything I (or someone else) can do to fix up that commit
>>> message in the way you are suggesting?
>>
>> It's already merged to the Linus tree.  I don't think we can change that
>> anymore.
> 
> Agreed. If Linus already merged it, it is too late. Sorry guys.
> 
> Regards,
> -Markus

No worries, it's not that big of a deal

