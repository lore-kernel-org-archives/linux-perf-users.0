Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBCF1C68BB
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791072; cv=none; b=i+SsHDJ9PUsY1im1ra4JQ3IIP1ITdJMXv5DSC86aj7n9nB4iil9F67qDJmWejk+2cmqjOgL3efeQJoDTqanHcMbS4JVPX/Vzn1/k297sHTIzQYzRt377IubBl1H4dVQQSKJgRD3uV1HqOBXZTuULvinLyUWTrr9kvkSd+JyS66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791072; c=relaxed/simple;
	bh=jvTeJqdjVh8BbYEjs3qIqtSoQPkfpt4ys9h85rINLo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svx3NmNfCrnomzUD4Xic1RxDQr4SwdUEANxg1CPReAnDcBZAU4cd/KnfTPAorFYgWSa/QL9e5ysL6Ak3TtwceKXUPJMtglH4qs/nWI4ccNq1rJcXgeKnpWcgY3213ZoH7cLOE/6q51JWLjaQjuBruqB2LvdL0O6DkZDDuqiF0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RcyJSRnK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcyJSRnK"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso1035549166b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727791067; x=1728395867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzrewytZX4x2Dhm5y4nov57RSswWXBHTu+zxZpSsOaY=;
        b=RcyJSRnKhNLysk1UcrxkD62gdyrik3GMm+vimWN9RdELLkVhj5Da0Y0KbjTg1ydV9T
         tODqwcSKSPsEcP7jJZOwL58tzzCHDGdsSL9PxTzOwcUsDy8leGbFZeRDVYT7rs7dlK+d
         yg9OiGAM3SqvVCu8BoELnWk1tf0e7oaEP35qWghJdR3Y88V6CNMkDHJiZkkaaszNlvjr
         1J8Mc+p6aDH/zjsJM36hRLfhiws+PevWknu+p/J4/ADeOCd/Q12G++LiTJqfDg0GzO1B
         MIMCWloK+t3OWYkuhXNvpDaX6hzjKQwMyZ3owKiighYb3Dk2S5rFYWz5XJHSvRH9Sbah
         1RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791067; x=1728395867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzrewytZX4x2Dhm5y4nov57RSswWXBHTu+zxZpSsOaY=;
        b=H6e+oCz30capWqfpS7NDBlU9OmkmsGikDieF8EvRp+CwCmd5zo51avNJZlSuLDptyN
         fox8af2faOFpZttSDXM6mfI/qRJBipREHHaHsw+Vsrj98B790vsWNmBxx4s8WGwCWgQ9
         Blwm7PpfDGuInQentT7fnq8JEE1lKVM2CJkp/qxxMimGt4PNB2eCERWOca8TJDkaSSQp
         PPJCoQejOs0mTdCNyrzKzmkfvC0nduFqiw/bBcfXKIL61Kvl5suaya+N2BhRsEl4/A+X
         UgofkHezg8/7QSWqUTzbSZMZ8JnvBsF0TmzCt25UYJEVxjxUDE9hnEz4w9i1QG0Tj/KU
         X2IA==
X-Gm-Message-State: AOJu0YwqMLe7/+XQ3vowMtoWKlZpLPuWkcoMA+e8ohmdpO+0ANKZxQfz
	YNto7VRigRrfAfjpa8T0bVwLWn9tpkr3ny1g6Oo0uy+NwYuCfquDndsqEhcHi+s=
X-Google-Smtp-Source: AGHT+IGgYvloqWvCe/iRPFkUzCxEs/DaBdxvqoYrIA4evpeVeZO/xxTaBJ+9VJvbL0CddUVZfeqBCw==
X-Received: by 2002:a17:906:c52:b0:a98:c4b7:7971 with SMTP id a640c23a62f3a-a98c4b787b9mr227638166b.32.1727791067439;
        Tue, 01 Oct 2024 06:57:47 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c58fbsm715322266b.56.2024.10.01.06.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:57:46 -0700 (PDT)
Message-ID: <abfe5431-4845-4bf8-89a1-331f68f76d05@linaro.org>
Date: Tue, 1 Oct 2024 14:57:45 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf dwarf-aux: Fix build with
 !HAVE_DWARF_GETLOCATIONS_SUPPORT
To: Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain
 <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <20241001123625.1063153-1-james.clark@linaro.org>
 <Zvv9eBDrquBHBHhF@x1>
 <CAP-5=fX3X22NS35YQwcMgv03Cw9acjDC_AC-Yocm-zMJXpBg4g@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fX3X22NS35YQwcMgv03Cw9acjDC_AC-Yocm-zMJXpBg4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/10/2024 2:51 pm, Ian Rogers wrote:
> On Tue, Oct 1, 2024 at 6:47 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>
>> On Tue, Oct 01, 2024 at 01:36:25PM +0100, James Clark wrote:
>>> The linked fixes commit added an #include "dwarf-aux.h" to disasm.h
>>> which gets picked up in a lot of places. Without
>>> HAVE_DWARF_GETLOCATIONS_SUPPORT the stubs return an errno, so include
>>> errno.h to fix the following build error:
>>>
>>>    In file included from util/disasm.h:8,
>>>                   from util/annotate.h:16,
>>>                   from builtin-top.c:23:
>>>    util/dwarf-aux.h: In function 'die_get_var_range':
>>>    util/dwarf-aux.h:183:10: error: 'ENOTSUP' undeclared (first use in this function)
>>>      183 |  return -ENOTSUP;
>>>          |          ^~~~~~~
>>>
>>> Fixes: 782959ac248a ("perf annotate: Add "update_insn_state" callback function to handle arch specific instruction tracking")
>>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> There are a few variants of this same patch flying around:
> https://lore.kernel.org/lkml/20240919013513.118527-4-yangjihong@bytedance.com/
> https://lore.kernel.org/lkml/20240924003720.617258-4-irogers@google.com/
> Just a heads up that we only need to apply 1.
> 
> Thanks,
> Ian
> 

Oops thanks for the heads up. Usually I check if it was already posted 
but this time it was so small I didn't do it. I'll check next time...

I don't think the fixes commit on 
https://lore.kernel.org/lkml/20240919013513.118527-4-yangjihong@bytedance.com/ 
is quite right though, so maybe this one is slightly better.

