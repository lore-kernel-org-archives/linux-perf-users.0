Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366713D5642
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163426; cv=none; b=uD7xUhAaydtZU8tWuh0+3e4+wHdHt18NlctX97gbtAu7MkggMnHwBaL8699Gqh+JpXAGs4ehPezuGR2Ure3iJFiPeYcRQsa1dy4Av8vaSUNF0u2vLCWRQmFPy7oINcLNMYOInFMFm0N9Glj0WSY/5HCvKsdYeDefBfl4ksYYjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163426; c=relaxed/simple;
	bh=FcPcD2jCRVMoZdVIS2wuIcC44izpJ4CoQtCnahgS6MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTn/dHtQ4atbozdMveQQxACtRsGJfDA8rSAU2JfHsX6wIMC7YdVYPvi9CJ6AGIdWa6EZEN+Fl26n53FppKm2VAuJd9L7+6Vjz5P4fOAU8eC0wPTeq/VHVjpUeFWjC1dEBKVFI9b5gpiGmpinkkffvdWShfTP73TrEPbfI8osulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CC4BskPF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CC4BskPF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488c21c636dso32526645e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776163418; x=1776768218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjba3fEWzHEXMsSnILD9Bp6+IzbtndU1P8h+RQyjgRA=;
        b=CC4BskPFz4cvhed9IZf6x9BNpJLpyWx9wiX7/nigtHlCLQwyCixYIgEnRxRw7IyUpi
         kKIdgxV3qwfe3MxUhpZ2gBbOEPQx1Ak2p93dJhEiHlnbePSK75tOr8i3ob7CF7dG0yO0
         b6wuQVxZsyCTzgMrq76M7oBvvwShrY4Th0Zs8g5HsY68O16tzYowmQ23Nqz2V4NxyNWh
         CompAZ51/yQoJwADxO7MYXnraaHdpmj8evVXU/vfDiOZx0GJUuf32dvUg1tXI5HXpJLq
         iTWE4ugK4F97X+euo3vNtYOS9CogUvFSw7In0H0LIcee5JVxtfC6k6y8+uZ10VYTYziI
         3nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163418; x=1776768218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjba3fEWzHEXMsSnILD9Bp6+IzbtndU1P8h+RQyjgRA=;
        b=UT4f2P7iDGxDxoTBTdOZDUxkEldUs/fW9dQkdU7ajyeeYAiHlRcvoACsEHx1p54gZh
         VkjcEbYcTnDlz6s3dnHwZVYGDThqNbddG4fAwQEv2z2xftluDKnXssPgLh8dy3MPis+9
         TUpyQLvUy21wBv793DBOxTmzsQpWGiEp/JledTIucqBjIGbSEoVtEik+BLXPiP+8p0Ap
         GLzYmrll74v4jxOuwH/SWbSbjJBs+jdxvqbxo7j/uCNxldVv9/f9hd6Upscu5tUhDxBZ
         x0tlIe16D2m4J9yDKshZcdrIzvGRen0MJzdgOfIEw9SvOoN0UyaS5BX8p29vzOkvFa4V
         b9uw==
X-Gm-Message-State: AOJu0Yzfr0EhRtyapldvjwMhTumIMC1EyaQc/4MToTE8fnr5Vb+TpSlJ
	V7DChhXzz87gNhZqli3mJ6CgJtj85EZYZgc21gEvljsxYVBPrIN5QV6ZzIhhCRDmHb4=
X-Gm-Gg: AeBDieuDJDlt6p2ZjdbB4cZDe05gLO/oP/n1KrgopDvYdI/SnBKUwH8J1XnBKc71o7I
	LA7MfGixz0135387cbC2UybxBJp+yCSPA0rvMuJnzMOCiJ52N8fikDY4cF51VmcvxS1zdTJxC6y
	YfryM1hOO+fcHRxqGXMZPte27o2V6GkmpEZaxZsbCYrhXZqnWBChHYnIfKgWNEYiKU4o4qOw8QF
	71zgRg32VqS6CAwAibi/Gb9n4AvT+kzVuxtgI2eLnwnc6xadbj7B0XTM/jYLroYfCfd04QrsCQs
	siZfbo/aEF0Wx9QEolIjwmMyiROYVDNLBE9OTiyl7ZLi93GhXeX6cLplQh3pMXQxJowrsABzf+J
	2DktDpXEN/YwIQE6mncUdypOLMawMGdhkAXhAvo4DjGMtNBxzaqVlsJfTp3cwlJ341G0jskRqP9
	Cc89K8ar/ZvBs9wNRQnnv8Ljj2wgZpz3A/7sJdpTjz
X-Received: by 2002:a05:600c:c0da:b0:488:b043:5efd with SMTP id 5b1f17b1804b1-488d682628dmr204920175e9.13.1776163417825;
        Tue, 14 Apr 2026 03:43:37 -0700 (PDT)
Received: from [172.17.16.20] ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d689110asm123620585e9.35.2026.04.14.03.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 03:43:36 -0700 (PDT)
Message-ID: <ee8e6379-6bb4-4a83-87d3-5ae30fc0e95c@linaro.org>
Date: Tue, 14 Apr 2026 11:43:35 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: fix "argument list too long" in second
 location
To: Markus Mayer <mmayer@broadcom.com>
Cc: Perf Mailing List <linux-perf-users@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20260409221418.185343-1-mmayer@broadcom.com>
 <20260409221418.185343-2-mmayer@broadcom.com>
 <d9c9eddf-8f66-4757-98b4-16b4ba505f5e@linaro.org>
 <CAGt4E5tinak=M+301yDCE_R0qREcQvWY6uGQ9vPZjhfrCTxk7g@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAGt4E5tinak=M+301yDCE_R0qREcQvWY6uGQ9vPZjhfrCTxk7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/04/2026 02:07, Markus Mayer wrote:
> On Fri, 10 Apr 2026 at 02:25, James Clark <james.clark@linaro.org> wrote:
>>
>> On 09/04/2026 11:14 pm, Markus Mayer wrote:
>>> Turns out that displaying "RM $^" via quiet_cmd_rm can also upset the
>>> shell and cause it to display "argument list too long".
>>>
>>> Trying to quote $^ doesn't help.
>>>
>>> In the end, *not* displaying the (potentially long) list of files is
>>> probably the right thing to do for a "quiet" message, anyway. Instead,
>>> let's display a count of how many files were removed. There is always
>>> V=1 if more detail is required.
>>>
>>>     TEST    linux/tools/perf/pmu-events/metric_test.log
>>>     RM      ...634 orphan file(s)...
>>>     LD      linux/tools/perf/util/perf-util-in.o
>>>
>>> Also move the comment regarding xargs before the rule, so it doesn't
>>> show up in the build output.
>>>
>>
>> I'm assuming this is just a cosmetic issue so it doesn't need a fixes
>> tag? And "upsetting the shell" doesn't cause a build failure?
> 
> No. It's not just cosmetic. It absolutely DOES cause a build failure.
> 
>  From the cover letter in this thread:
> 
>    GEN     linux/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/extra-metricgroups.json
>    TEST    linux/tools/perf/pmu-events/metric_test.log
> make[5]: /bin/sh: Argument list too long
> make[5]: *** [pmu-events/Build:220: prune_orphans] Error 127
> 

Ah in that case it should have a fixes: tag then. And it's worth putting 
the actual build failure in the commit message IMO.

>> Otherwise looks good to me.
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
> 
> Thanks!
> 
> Regards,
> -Markus
> 
>>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>>> ---
>>>    tools/perf/pmu-events/Build | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
>>> index dc5f94862a3b..dc1df2d57ddc 100644
>>> --- a/tools/perf/pmu-events/Build
>>> +++ b/tools/perf/pmu-events/Build
>>> @@ -211,10 +211,10 @@ ifneq ($(strip $(ORPHAN_FILES)),)
>>>
>>>    # Message for $(call echo-cmd,rm). Generally cleaning files isn't part
>>>    # of a build step.
>>> -quiet_cmd_rm  = RM      $^
>>> +quiet_cmd_rm = RM      ...$(words $^) orphan file(s)...
>>>
>>> +# The list of files can be long. Use xargs to prevent issues.
>>>    prune_orphans: $(ORPHAN_FILES)
>>> -     # The list of files can be long. Use xargs to prevent issues.
>>>        $(Q)$(call echo-cmd,rm)echo "$^" | xargs rm -f
>>>
>>>    JEVENTS_DEPS += prune_orphans
>>

