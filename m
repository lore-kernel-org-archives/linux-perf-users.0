Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF51F4CB3
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666141; cv=none; b=Le4sAChWfglOgiJlgkd2y2oyV+VBanhLWdU+nD5HWj7Fh5na2AiHkKX/P5e6PAv/ILR7bP9JLEzRiHu6jZOYSVkjHG68vh4RBbVD26oX75TUixVcDoSo7vIr0CnRBXAgONIAUdXUhnifABuX5OKDk+4EjIRD+TVo+3ADLiOQzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666141; c=relaxed/simple;
	bh=g7bC6shOFqWUkJPQohJlp6xKTslLg7u7rypZKuZ35UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdpEaBTg9348FMHZxuC5S/D/3btn/pbGPJclNvVmw7kbtm46G1zQd56u6T9AKK72i8NeqY1wXlpIti5Q/Www/8Tg06oqRjJ4em2cMxfp/s8imtI2oohvDrNAdwVd2rnWMjiQ69JsMK8pPeDjh/YEhh6nYSRnvxZUrrU/GYCcHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UJRn3Qpj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJRn3Qpj"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a588da60dfso2309126f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 01:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750666138; x=1751270938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwIuDB9l6P1vly8lEea5LFQTAzgsABGn7EGIVKdG0ZU=;
        b=UJRn3QpjniAPCpItwsB7saoHpJ2HNAZzPt6H1CuqZQlREElRY/pSNdMxW8KRjgvQb2
         ZyqB6egN52/g7/PTO0+a68+CGw2NTfkxDbhXLzRTbcsvXCh3x4pAXolmS3lBLCfHegAE
         mSKUTQucrDrAHk6kqTj6lq2Q1dFPRpxVnXP8v8dCgtv5qpsqruNgZcNIyfEU4cFg74td
         gGXeOuQqqz+D6TGM100P8VwRB9f7IxEC2++jGbZb6t82Fcfpfc0pS+Nk+wlCFBZimuHl
         fsafQ+g4lqCUcEeSAOL1xunHsZGm5IjZtwlqSDv/2Dub8B1AREW4Le0RPdhrecVVqKCf
         FfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666138; x=1751270938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwIuDB9l6P1vly8lEea5LFQTAzgsABGn7EGIVKdG0ZU=;
        b=ngD8nu3pZl5G+3jv+khlm6GiDhsoGR3nPAONdicHYsJEMp6Fn5+YTloiXaagY19nHe
         2iknT3BMKgp2t5EkWljH14UuHY0jYKWHzXFObZfgO/9HkP+1YOGx9JlYi5x6T1EibRO4
         Ue9t5Z3OP5c6Qi4HT460lGepRNOXdSIdWthvULHIieme/gcIHmc1v2P6Rt+nYSBBy/kK
         J1sFxKqGvO6DJlJgn8FsaMLp830E4bIBdrfDlIAySGCNe4wOETyCpBTHd+4FbhuXTKNI
         dtgSLNig5kTgB3QDYvR36nYWzPHVtVbC4/GLb8YntjVOJJo4TiOEQlAxK8IbB8p3xZwg
         Chig==
X-Forwarded-Encrypted: i=1; AJvYcCUDo5zXFNy8u8Q9ZBxhDCcdN0roo9j/0kxAVXujw2Z5z9v8H6elvqvy3/dZMiU85Bxw7v0XeGbogcs2Zhxkz9f7@vger.kernel.org
X-Gm-Message-State: AOJu0YwZik6FJNb2X1uLX3b56J7KCD/U2DRUNInOsVqk5d2XpRjCApN+
	Zry0SJkyDrrbNWARz4ENdPOQbp5d3oLDsxOXdek3jtUAnISQLX6qdg4zhAkRX41x9r8=
X-Gm-Gg: ASbGncs8rawvMf2l5e0Jf+s49jSDj0al0tz1MA0XlqViz8sfhWGajk5JZmmeg7haOI4
	idvcys9UWMyrJLfrT2g+bLig6/Yr7j1AU9x7armtygYCVwXDWHNtC1O4STENvWLtvm6vrSVUwZq
	x7qSaOskTGVBKQihGRZhxbw4/YBunUGBUSYvamAKLPHUT7h8GsAXrXahQZHhS7qxjVZ1oEdfaoY
	WAK5d8jcbTi04y9G8EiFUTQWuIog1k0Xe3uc58qHEMPMynmBGeFgAoBP16ME+q6f6mdoDTvVsRX
	wQwVMP6LDIHgS/yccH1PxKkZFFjrU370cirP1dOGsXHd5UM+JcwkKRkQy7wH53x4LY4=
X-Google-Smtp-Source: AGHT+IHJo0IMTbVg3Z6+qf+LRb91spKikOGF2OIevASop9FQHg4V8AyHRHED02E1tc6rIuUJdkrS4Q==
X-Received: by 2002:adf:e187:0:b0:3a4:f723:3e73 with SMTP id ffacd0b85a97d-3a6d129ccdbmr7878848f8f.16.1750666138114;
        Mon, 23 Jun 2025 01:08:58 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c03asm8650522f8f.49.2025.06.23.01.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 01:08:57 -0700 (PDT)
Message-ID: <52e64bd1-dd5a-48b4-8acc-c7af5b811d30@linaro.org>
Date: Mon, 23 Jun 2025 09:08:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build: Specify that spellcheck should use the bash
 dialect.
To: Namhyung Kim <namhyung@kernel.org>
Cc: Collin Funk <collin.funk1@gmail.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
 <20cce2b1-eaad-4565-817b-b094aecee0a5@linaro.org>
 <aFW7T9DH9WrjtgJ-@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aFW7T9DH9WrjtgJ-@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/06/2025 8:49 pm, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Jun 19, 2025 at 11:28:46AM +0100, James Clark wrote:
>>
>>
>> On 13/06/2025 4:36 am, Collin Funk wrote:
>>> When someone has a global shellcheckrc file, for example at
>>> ~/.config/shellcheckrc, with the directive 'shell=sh', building perf
>>> will fail with many shellcheck errors like:
>>>
>>>       In tests/shell/base_probe/test_adding_kernel.sh line 294:
>>>       (( TEST_RESULT += $? ))
>>>       ^---------------------^ SC3006 (warning): In POSIX sh, standalone ((..)) is undefined.
>>>
>>>       For more information:
>>>         https://www.shellcheck.net/wiki/SC3006 -- In POSIX sh, standalone ((..)) is...
>>>       make[5]: *** [tests/Build:91: tests/shell/base_probe/test_adding_kernel.sh.shellcheck_log] Error 1
>>>
>>> Passing the '-s bash' option ensures that it runs correctly regardless
>>> of a developers global configuration.
>>>
>>> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
>>> ---
>>>    tools/perf/tests/Build | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
>>> index 2181f5a92148..26efc5d20f6c 100644
>>> --- a/tools/perf/tests/Build
>>> +++ b/tools/perf/tests/Build
>>> @@ -89,7 +89,7 @@ endif
>>>    $(OUTPUT)%.shellcheck_log: %
>>>    	$(call rule_mkdir)
>>> -	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
>>> +	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
>>>    perf-test-y += $(SHELL_TEST_LOGS)
>>
>> If we're enforcing bash style with static analysis shouldn't we also change
>> all the hashbangs to bash? Recently there have been changes to change sh to
>> bash in some of the tests so presumably the hard rule for sh is no more?
>>
>> In the past I've had to replace bashisms that didn't work in sh but it would
>> be nice to have only one language to write tests in. I doubt anyone running
>> the tests today is running somewhere without bash, or that changing it will
>> break anything. If anything it will fix more bashisms that have already been
>> written.
>>
>> Just for reference there are 34 #!/bin/bash and 42 #!/bin/sh in
>> tools/perf/tests
> 
> Thanks for raising the concern.  I agree that having one standard is a
> way to go but I really don't have preference between those shells.
> 
> Thanks,
> Namhyung
> 

I would vote for bash then, just because it has a few extra builtins 
that are sometimes useful. I can send a patch that does the change to 
see if anyone objects.

Thanks
James


