Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FFA222D42
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018360; cv=none; b=umQF6z3/H/LwXNskWFCPBltxd6u2jEv/rcv4gFl1SM1ma2q8y/5tf89f1FZR1PRdZ1Wg8shHIn00NBholPWYdqbafB+edfI5K7PkAkSp6wcKp0HJhUZtwY2FDr4oQuA2WTYPbf+4rFNJ+l0IKYFqOO+Y6x40UusYy7ZrXr1xdK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018360; c=relaxed/simple;
	bh=7CZj15hBqctqnSbld2qny0agH0G5KAVCp5x5TNafiRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC+kGTA9mISy8tDKSgw2ktSDvcknsdgVpjQkce9fViImP/o0Sc/Xp96CShDMA3KCz4cflz9P9VLMnZP6Oppc6qtQ4nfwUCuJQ+l0lJbQsG6y1+DJMlh8ZhBkZPGRUIEBGkrgJIwwCeD0Y862o3CusdCOaH5MKUoHNs7DzwdvwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vejWZShE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vejWZShE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso5504405e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 07:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734018357; x=1734623157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6a1zDSEYLXc+eJA0b3qVc7acpkK4+miJnhJ0ZW+WWX8=;
        b=vejWZShEZ+dK9+YsiBgY7GoOMHVKp9tkYSKGEU/cgn3lLy5SRuDIFsmKUp4VTsCNhq
         ZbtRDZdHdVzzXANMoTxN7PLeIDWQpDbctgWjw9uzUV3cX7NirpPFcKQpwLyd2/ApDcbr
         cNgStaNbALoWFAE63O3cleBPoda3nV/WxUZM8s4+ldceewiCvtckYOtXr618zAlPWgqQ
         lshQVpMILqqaNSni6Mzt0jUZyyZy9sf3yOQRc3Sp3hpNsTQugurdFu2e3Gap4oakGI1/
         F/yZ9VkjS67GgXG7p6f3qDjDVsQwbb30rj/8OaDnOeblfIsm2K63kn9Tsy5C7g5n0Dq+
         VD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018357; x=1734623157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6a1zDSEYLXc+eJA0b3qVc7acpkK4+miJnhJ0ZW+WWX8=;
        b=TPlFSXE74/AsbIRJfn8y/Zhx3vuZCb39Yv/e9rQC70+TPp8Kpk4+d++QTOAaN6hcWu
         qiBNxbD6zmFCv2NHlgF7tXT+69vfs4Jq8DDCv/Dl+PQmZBSc8ZLWBsMPWIZqrOughNqJ
         lYn1FOe3HQJerp9SFkHhmN4DFRZCT0jLhz7k8d8A2KTdrWe9Ra98tll9cmgmdQMtXiDM
         5TyT1mEQTevXw7aKTfgZGThQaBxA2lwomHp2BAsbPLQmlPg4wMv4/T52+SttJoTbh3PD
         YHKvGEP35mQ83/H+lVZzxXk7NSNo1BY5wKdtmFck+FfTzL75nZo+feq5LxJ5oFCh6vpC
         0pXg==
X-Forwarded-Encrypted: i=1; AJvYcCXPDtu6DrTbDaxXFGxx6QR4xGNdHrm3BCv5VW69R1+/nuYQZRqWdwtL4weicLdFExtzhdVe19OTd0PUGnu/kjHV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+RiEduciCFCyrJcUDbbHTRk31+jKIewdF9OdGH0YPH5sa61Nk
	YXMllEBrZlSXEmYeAdzCgpTmHoHmcCvJGvnrHf5VPWBhX3rGuH/KgXsRU5Pl+BM=
X-Gm-Gg: ASbGnctQTHLk/oT4FP68drXE3CAPGc97asZm/bVihbaXzCppBvhxrzgQY9JguaG6DRy
	ca787VX4nvsj36Jq1/GFeiJ6wU4XA8Uy2zMSlbmNROw2EKlMf0+ViFNaugaD65ps0CMonA5jXbk
	WwEZna/V9vpufcoFOD4E3oi3nI5vkpQ4fxwCCqYCtL+mKaffvr4ZwQyMi9BKA7IDlfqfMO8Reog
	cSZb+XjysLDCYWtt377wyKkG31RQyDrPSy0Q9ceY6ULKEtqtqw+UqjAhltm+OjhbCg=
X-Google-Smtp-Source: AGHT+IFTDlMjXTmHhNf213X7LLWtzJR/Hkn4hyuAJCLqqxMOf4mdJJzUGGOYyWTGWfD2Hf8SJQAU+w==
X-Received: by 2002:a05:6000:1f82:b0:385:f56c:d90a with SMTP id ffacd0b85a97d-3864ced1f55mr6224618f8f.55.1734018357326;
        Thu, 12 Dec 2024 07:45:57 -0800 (PST)
Received: from [192.168.68.163] ([145.224.65.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387825296desm4316543f8f.111.2024.12.12.07.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:45:56 -0800 (PST)
Message-ID: <f37cd857-7577-4275-b799-1445fd31d321@linaro.org>
Date: Thu, 12 Dec 2024 15:45:55 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test stat: Avoid hybrid assumption when
 virtualized
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241211061010.806868-1-irogers@google.com>
 <7c118b40-3b31-46d0-8967-e7c35f6a4868@linaro.org>
 <CAP-5=fVxPaSYtB62ZqcLOG1F9Va-0rwBWUCiVNdaBpmsGXUVaA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVxPaSYtB62ZqcLOG1F9Va-0rwBWUCiVNdaBpmsGXUVaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/12/2024 5:58 pm, Ian Rogers wrote:
> On Wed, Dec 11, 2024 at 1:50 AM James Clark <james.clark@linaro.org> wrote:
>>
>> On 11/12/2024 6:10 am, Ian Rogers wrote:
>>> The cycles event will fallback to task-clock in the hybrid test when
>>> running virtualized. Change the test to not fail for this.
>>>
>>> Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat command")
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>    tools/perf/tests/shell/stat.sh | 10 +++++++---
>>>    1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
>>> index 5a2ca2bcf94d..60cea07350e1 100755
>>> --- a/tools/perf/tests/shell/stat.sh
>>> +++ b/tools/perf/tests/shell/stat.sh
>>> @@ -165,9 +165,13 @@ test_hybrid() {
>>>
>>>      if [ "$pmus" -ne "$cycles_events" ]
>>>      then
>>> -    echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
>>> -    err=1
>>> -    return
>>> +     # If virtualized the software task-clock event will be used.
>>> +     if ! perf stat -- true 2>&1 | grep -q "task-clock"
>>> +     then
>>> +       echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
>>> +       err=1
>>> +       return
>>> +     fi
>>>      fi
>>>      echo "hybrid test [Success]"
>>>    }
>>
>> Hi Ian,
>>
>> Isn't the distinction between task-clock and cpu-clock whether the event
>> is per-cpu or not?
>>
>> $ perf stat -C 1 -- true 2>&1 | grep cpu-clock
>>                 1.49 msec cpu-clock       #    0.917 CPUs utilized
>>
>> $ perf stat -- true 2>&1 | grep task-clock
>>                 0.30 msec task-clock      #    0.366 CPUs utilized
>>
>> The test uses per-task mode so this change makes it always pass, even
>> when the number of cycles events doesn't match the PMUs.
> 
> So I'm confused by the test, but it has caused a passing test to be
> broken for me when I run virtualized. The test is checking a cycles
> event is opened on each hybrid PMU, but this is conflated with
> checking perf stat's "default" output. The cycles event will fall back
> to task-clock in per-task mode but we also open a task-clock in
> default mode. Should:
> ```
> if [ "$pmus" -ne "$cycles_events" ]
> ```
> be something like this then:
> ```
> # The expectation is that default output will have a cycles events on
> each hybrid
> # PMU, but in situations with no cycles PMU events, like
> virtualized,this can fall
> # back to task-clock and so the end count may be 0. Fail if neither
> condition holds.
> if [ "$pmus" -ne "$cycles_events" ] && [ "$pmus" -ne "0" ]

Yes it might make sense to skip this part if pmus == 0 then. Namhyung 
suggested to always assume 1 PMU to cover platforms that don't publish 
any PMU with the cpus file, but I suppose that breaks in this case.

If you still add the fallback check for task-clock it covers hybrid, 1 
PMU and virtualized and we could even rename the test to 
test_default_stat_2.

> ```
> 
> Thanks,
> Ian

