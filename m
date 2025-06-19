Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907C2236FF
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328931; cv=none; b=Qvd+/wfkJHvtIwAEfnNJO+wLD+vxyzYKUuUH9vECFnpmgPV8FBLPURfNOKvBuvSbG5wWGktp/N06tR/B8cVs/sDgN06gbOPwH1DrVs0LIl20NSfb6pEwcgAvK3lSY42Imi9n7kbxnvFdS8uT+QT4QhKs5OWCgpIZDNg74qqjNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328931; c=relaxed/simple;
	bh=5qvqfMcze7cLjGLEuTDIxztt8BOtmCXLYindzOT3lfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nq7wZRHSEKlezdYq+mtqQ3eDdMajrm6M9CtyHOMJ6wgP3hgpXAdbrh08Z7UmSiR4y4JeH7H0f+VItbbsy0rtO+QZIvtO7xhqiN+4IHSzgV4hYX2u4HOB9a7Hg5WQo4lL4FK5yvcLhHEw19/8eRCu2ltbI4wAudVT654q/hCAo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AgzhajJv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgzhajJv"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so391659f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 03:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750328928; x=1750933728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVEUVdRtq9rZDfocx5InCdOyBFQKK/3wZPDu0Oee+YU=;
        b=AgzhajJvVKLa7/sdfKWGg8szDqto9dgWOKwBqSlvev1AvaXIPCBmaHKv6g9/dNQX0m
         jEJZb0RgVXhuYOQpAbOZg+sfqD56BYVo/FFChRhYHH+RPyT8BdhGKKe08u99SkDMO198
         ysSWVRraHse77CXNltyeMrI33EvYg4kj5wbiCQNDWre1vUeNVCHFtNEGoVNW7k/4AG4B
         VYy/HPaSz+edayn28jA+RV2cWkukghkHPrAiyLwMHtK8LhEgx7tHc+AVOebNDYnxsiG6
         HwB/R4qDuTNhODYWQUBxwo6BaLF48vGUfeTkrJCUOKWZ0cnj7reT1A4UXRTf38DzsiI8
         oWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750328928; x=1750933728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVEUVdRtq9rZDfocx5InCdOyBFQKK/3wZPDu0Oee+YU=;
        b=VeH2D7Jw9MVV0oQx4ziJS+XhOwXjZXHaiUMQ943H3b8+knfAjAKDs9yQN9sQDcsMYS
         aE4QWGLyIgjmqxXJSi1P71I869YnFE7bhQTHbsWAL5R9nckkr6PSQyewXDAkdezT47lL
         Uw3/AyYka+gHiMWMXT6oZSw/F8tfAilFYjPa/WQ/6vGEK+KnaVWzJrMierJVKP3ohJKH
         Q2S8+pAVnTZ6c3IQcg8d4rJfUtHDDAXjK6D3a0z1euJlrYKjygsHCJ1qhymkEoeogYrV
         G98WvUCE5558cHFIj889kucme1NW7yre/wG3giXIvHi2Hw6J9no+6zv5A4SeKuuiCxTk
         RcTQ==
X-Gm-Message-State: AOJu0Yw6T0Z7gdoiWG6T775uu+YJUDQXSaHxtWb8JuXbirRPvClBPixv
	bu7JLk2z8iarhBH8v4CpCnWnGJUvv5mRu5dy1gfYtVB/jcBZ15ZZPO6osymxgH9qOTM=
X-Gm-Gg: ASbGnctAGbXaKX8N7+H20SvmmFnnc2fsqehxp+oR9ntrDMKKk5Na9kp4S8xgOZ56ph+
	UJ+Ekvbvg2g7uW3XRWGmWPelgHuycZglbqKV5DMAIzdcGDJey2Cdf7wCOtrlbQ9sCbuHJnw8HZ5
	Gt/B9Omy1BcxtIady2vZ7p9hXXzm+gIP+fkV11kLM0DnCoCFkycGVxLY8f3rG2AQgWV8jmDnxom
	TNE75IhxNxzyn68McD2M2V5Msf+HCJ2VschJJkXi77DSh2EH2PBibIiJA5cGuTe/WATHZB19T4g
	5woKcjfIkRdMUKDyJWK7LaoAQU8Y6bvJlIdxuXrVBwHOXZTYzGbsJOKDseHDFj5/dGI=
X-Google-Smtp-Source: AGHT+IEx2YSSQWO7fP8kYOJC+ks89PKgG9aYLFMDHVAeBvxu2cwUIrTYReyJm/cQxYnC7wgFGS+BQg==
X-Received: by 2002:a5d:64ca:0:b0:3a3:6a9a:5ebf with SMTP id ffacd0b85a97d-3a5723a352dmr19570818f8f.20.1750328928203;
        Thu, 19 Jun 2025 03:28:48 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54d1fsm18906368f8f.2.2025.06.19.03.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 03:28:47 -0700 (PDT)
Message-ID: <20cce2b1-eaad-4565-817b-b094aecee0a5@linaro.org>
Date: Thu, 19 Jun 2025 11:28:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build: Specify that spellcheck should use the bash
 dialect.
To: Collin Funk <collin.funk1@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:36 am, Collin Funk wrote:
> When someone has a global shellcheckrc file, for example at
> ~/.config/shellcheckrc, with the directive 'shell=sh', building perf
> will fail with many shellcheck errors like:
> 
>      In tests/shell/base_probe/test_adding_kernel.sh line 294:
>      (( TEST_RESULT += $? ))
>      ^---------------------^ SC3006 (warning): In POSIX sh, standalone ((..)) is undefined.
> 
>      For more information:
>        https://www.shellcheck.net/wiki/SC3006 -- In POSIX sh, standalone ((..)) is...
>      make[5]: *** [tests/Build:91: tests/shell/base_probe/test_adding_kernel.sh.shellcheck_log] Error 1
> 
> Passing the '-s bash' option ensures that it runs correctly regardless
> of a developers global configuration.
> 
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>   tools/perf/tests/Build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 2181f5a92148..26efc5d20f6c 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -89,7 +89,7 @@ endif
>   
>   $(OUTPUT)%.shellcheck_log: %
>   	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
>   
>   perf-test-y += $(SHELL_TEST_LOGS)
>   

If we're enforcing bash style with static analysis shouldn't we also 
change all the hashbangs to bash? Recently there have been changes to 
change sh to bash in some of the tests so presumably the hard rule for 
sh is no more?

In the past I've had to replace bashisms that didn't work in sh but it 
would be nice to have only one language to write tests in. I doubt 
anyone running the tests today is running somewhere without bash, or 
that changing it will break anything. If anything it will fix more 
bashisms that have already been written.

Just for reference there are 34 #!/bin/bash and 42 #!/bin/sh in 
tools/perf/tests

Thanks
James

