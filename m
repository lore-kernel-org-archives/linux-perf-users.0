Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2651957FD
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Sep 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081243; cv=none; b=AZRSDRVYaOx8XNJko7yI23od4y94IrFXMy/uRn/XAR35R3E5iSWk1wzXsZKxSgsoUWQkVOzIDjI0vzSmUFRB5bNJIHLxUg2aLu6IGEjAVnotWM+oHwf/ai+H2rob+Q1/YKgt+L0arZZHWGcYeZPvEhNjI/XHOcZnhdK5/3DyNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081243; c=relaxed/simple;
	bh=gn5HztYpt6xs5NuwjQT8YgkLiLEYLRCC7gFx73E8Yuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqlnzKznMolo13uWByZFPH2/bUjJr60nXRRG0jDWEgGssBT8qpErg+l1wxeqN8GqFEnECUM/9z8psQwRiG3geRZrLrR7jmg7/1TAXGb2St25whIwUemBHx6Dh4cg3zlFCrD2wgYnaFAYacrRqFkerUKef+5VtLzdkLc8h+nB2hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L0R7Y7Uh; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0R7Y7Uh"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53654e2ed93so4540265e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Sep 2024 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727081240; x=1727686040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLQTF5xjybPIoAvk2AufN1W0OK2/B6R1sbg3NDoXPnM=;
        b=L0R7Y7UhkckySCIQcnh8g6WSVr237LaPdrJyfMCS1V7qHuTiPCWRhhO7HhPjzU6bzW
         6PM+9MlqHpuIrOPA0iD0CQfHr0Agis/5eYevBgf4QO9xnQ3WGrMWEoPrWBLVMwWKegAY
         2mMi0y5GqgW+TlQHevyoefOSlbbMZkXX1uZ5BDdFb2ya9lw/UZ2k308UUSjw92MmnNIi
         shiVr19zlRMOuuBVitvfLo8oQI6IkPIv1sZvPoet0iQNelK7esjENvY27ntr+GpSWe/q
         2l79iyFZOeRtXAoSfbUGK7VWibvyLVQdykBeXD/zf5WCTTPDtnAu6YufcGSIUofF7Js2
         Jopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727081240; x=1727686040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLQTF5xjybPIoAvk2AufN1W0OK2/B6R1sbg3NDoXPnM=;
        b=QgSBmaArS9JvPgjMK2ESrlH5t5iDcu6tisuIjYwpDCzy1/j4ZkJu7tEypbdLOPEB/p
         krwsl6ZauaRagWec7T58oMfMfZDqIhz+agDbg+/MAVTYkDOCx8aUzz2vjZn/9RsOlNBd
         CqmN4RdfRHRz+TcTjQnX5ZI++ddL/lGwso88uSrLPXlUsqRDkT4Q1yXX2NhqQ7aQj/Lk
         ikSE0HawIK0yNsMzbDmRiAS2f8g9DwlkWlTzlg2mBO1szQbHOKUwLcbdeXeqXRFiuvX2
         n2NWAA3aeR51qIFNsguRLq2zNBlKDdLEF+Znq6j75b7q4eRreESIclNLAipxlr8qFaUD
         HDPA==
X-Forwarded-Encrypted: i=1; AJvYcCXnqHrkdLiHjyhm8MLuTEzo6IsIMkX/4JvbPEPPxECzamb8VNSYqLh9hv3NqfhMkc/I02vKxiDJRnQI1oEElN7R@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp+HePywYvcqUz16lDfWH+3zieaF3kl9AiOQtKpKm+QGPOEiZE
	WdUH6+qP7NZSjqCAeZJu/P4kOa5zoEfP2+kyMKCk1qi0bRMeOggHBd3QA+IxHlI=
X-Google-Smtp-Source: AGHT+IHEnqVwcg44UyMZCBAIpmq3OlmZDUa4QjYohKX8wYEmC1sFSZM9i7R4d3Cw5p1Z5AYHuZp3/A==
X-Received: by 2002:a05:6512:3f04:b0:52c:e1cd:39b7 with SMTP id 2adb3069b0e04-536acf6a527mr5153766e87.5.1727081239592;
        Mon, 23 Sep 2024 01:47:19 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061328b2esm1182128066b.194.2024.09.23.01.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 01:47:19 -0700 (PDT)
Message-ID: <c26e646d-5ebf-473e-91e2-db28fc01e35d@linaro.org>
Date: Mon, 23 Sep 2024 09:47:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] perf stat: Add --exclude-guest option
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
References: <20240905202426.2690105-1-namhyung@kernel.org>
 <20240905202426.2690105-5-namhyung@kernel.org>
 <b1002dc7-78bf-40ed-83af-12a50622fb76@linux.intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <b1002dc7-78bf-40ed-83af-12a50622fb76@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/09/2024 3:33 pm, Liang, Kan wrote:
> 
> 
> On 2024-09-05 4:24 p.m., Namhyung Kim wrote:
>> This option is to support the old behavior of setting exclude_guest by
>> default.  Now it doesn't set the bit so users want the old behavior can
>> use this option.
>>
>>    $ perf stat true
>>
>>     Performance counter stats for 'true':
>>
>>                  0.86 msec task-clock:u                     #    0.443 CPUs utilized
>>                     0      context-switches:u               #    0.000 /sec
>>                     0      cpu-migrations:u                 #    0.000 /sec
>>                    49      page-faults:u                    #   56.889 K/sec
>>                   ...
>>
>>    $ perf stat --exclude-guest true
>>
>>     Performance counter stats for 'true':
>>
>>                  0.79 msec task-clock:Hu                    #    0.490 CPUs utilized
>>                     0      context-switches:Hu              #    0.000 /sec
>>                     0      cpu-migrations:Hu                #    0.000 /sec
>>                    49      page-faults:Hu                   #   62.078 K/sec
>>                   ...
>>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>   tools/perf/Documentation/perf-stat.txt | 7 +++++++
>>   tools/perf/builtin-stat.c              | 2 ++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>> index 2bc06367248691dd..d28d8370a856598f 100644
>> --- a/tools/perf/Documentation/perf-stat.txt
>> +++ b/tools/perf/Documentation/perf-stat.txt
>> @@ -382,6 +382,13 @@ color the metric's computed value.
>>   Don't print output, warnings or messages. This is useful with perf stat
>>   record below to only write data to the perf.data file.
>>   
>> +--exclude-guest::
>> +Don't count event in the guest mode.  It was the old behavior but the
>> +default is changed to count guest events also.  Use this option if you
>> +want the old behavior (host only).  Note that this option needs to be
>> +before other events in case you added -e/--event option in the command
>> +line.
> 
> I'm not sure if we really need this option. I think it may bring more
> trouble than what we get.
> 
> The name of the "--exclude-guest" sounds like a replacement of the event
> modifier "H". But in fact, it's not. It should only affect the default.
> It doesn't set the "H" for any events.
> 
> Except for the perf kvm user, I don't think there are many users which
> care the exclude_guest. The behavior of the perf kvm is not changed. So
> the option seems not that important. If we really want an option to
> restore the old behavior, it's better to choose a better name and update
> the description.
> 
> Thanks,
> Kan

Do we not want to keep exclude_guest for record, but remove it for stat?

Because in record the addresses of guest samples don't make sense 
without extra work, but for stat you might want to see an overview of 
the whole system.

For Coresight tracing and SPE we would want to keep exclude_guest, 
otherwise you generate a load of extra trace that you can't make use of. 
Say you were doing PGO on your host you wouldn't be recompiling anything 
the guests were running.

If we do change the defaults isn't ':H' already enough to go back to the 
old behavior? I'm wondering why we need an argument when all the other 
exclude rules are done with the letter modifiers?

James

>> +
>>   STAT RECORD
>>   -----------
>>   Stores stat data into perf data file.
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index d8315dae930184ba..4d47675af5cc3094 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -2491,6 +2491,8 @@ int cmd_stat(int argc, const char **argv)
>>   		OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
>>   				"Configure all used events to run in user space.",
>>   				PARSE_OPT_EXCLUSIVE),
>> +		OPT_BOOLEAN(0, "exclude-guest", &exclude_HG_default,
>> +			"Don't count events in the guest mode"),
>>   		OPT_BOOLEAN(0, "percore-show-thread", &stat_config.percore_show_thread,
>>   			"Use with 'percore' event qualifier to show the event "
>>   			"counts of one hardware thread by sum up total hardware "

