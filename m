Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC6234976
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822904; cv=none; b=WcDziSXT5WmhFu7/250mYlbZsutrYkpiL5TNBx8acyjOAnF6LwHdBI3P3CIVD+xKHK9FKYMDXhDJ7ALVq7FCQWiFemAvmr3xe94LqM9HisgiaQe5lamBHLgzdFeOO+7w89Tucem2rfjEJHp+KVmw6Y57/1UD8ibRBb/hAtQZWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822904; c=relaxed/simple;
	bh=9cpD6fAAXTO3EiaUTVTFDO/MsvAErfOQlEts/GyWpPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pG1JlupLU7j+R96fXzb8t/JlR865zSdPZ8L8Ue3OLynghLf5mvY0zncjHQJXOvboRGm9U+Q3c77fT3woaQDpH0wKcOBUDxHkq4gP/jtqdk6Yobngc5PAX8LaruX9yffKXnIksTQ+Cv0GtKdZwI5UOe46hf5Vh2RdJ8fqDcVzimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B0sXbvlF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0sXbvlF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434e406a547so20752185e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 01:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733822898; x=1734427698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQY0749XmdnpP5wo7r46HLCgOEueMMj4Pm6338cdOC0=;
        b=B0sXbvlFEdB83urrVe/d/AKV8xeqRpwy89lZZwqR1AFiDGD+uGoj5XUrPw0bIIJnWO
         IprCGTx0lBmO7S1LZq0ZKz8OfMwdGIQ/cMixPKa8vLJs5Hpfzy3U/b12UbRBwH91YIIX
         UlhwVjLHrvsPB7/+0/oOxha4Dk7Bz8Jh5aFJYps+uYIOmAmsvO2hQilQhYCXKgDQ1ypC
         DR/f3ODUDi6Lf5eBFMjWk9R1nACnJxmdN9dleIb91jlmSdFYFrKKodkHb5BBdlBrIcuG
         C/NuSvZxlOf6E/btdP98OmI5VkAy//kIcsdWEi4nF3esTXnUsy77XYN+4mQM8gT8l+9V
         Gsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822898; x=1734427698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQY0749XmdnpP5wo7r46HLCgOEueMMj4Pm6338cdOC0=;
        b=uXVIscGcw6/yWEqPL9R+p5E2IkGJMDU0XswdM9mdVbbz1/BYKujShP4r42xkxcELEo
         cnuADUyYpYyuZuwBuqZA56yCAaJ+cZ+8ylWx6R8P5ElCxxhK9z/xQoVtSp7Iu0coYoHC
         zz8wMDewuc9xLK5JWeDcle/uwzQOXc/nN9KiYS/wQz0SvT/Veg86WFVQgIiFUK+cbRyw
         qajhnW54B9ZBEp5iAEM/AvlKJLSZtMvWkPfwHnb8mjYQs1WBmggOM5Oo418T6dzLu9p3
         N6OO+bM3gOPm141fIWXeUy/judLC5zwmpQ86xMk2LTdAMkQm3nEFadTuspnsdhdrkkhs
         XvSA==
X-Forwarded-Encrypted: i=1; AJvYcCUfN3z9mHbhwK77nN5bvfBSaN6Taogk3bYBBkUO5Ny7cdqia7jIdKDu8oAwsygUeHUak886gYgkLwf6UqmGMWoc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dpJ3r2+VJhpiZlGa9yYsMkkYwISvplz/kYBQeHXHRJJeN12f
	cawg74SMenzgWSCf1eSzIPUWQpJXqQoa7hIdcCQaahqp3qY+kQI4Xp4jbmv8UeA=
X-Gm-Gg: ASbGncvvSWPHDdPV99swhqK7s56bmsJz3jSqNm4vQ0CfJTua3Dpp57iMlpXMvQGj8JW
	pX1rxmuiKPdkZgybQuKAWyDEJnmFi5b1Edv85mRBQxadGC+Nl3YQDGgKq2RnlEoqiJM3jJE0I7m
	JL5a/TjN8/6Ws4Snr7iX+hkwsD7rv+zYsk7ceVjxLxU8nFjNpSOqc69alf1ZZTgorZ98kKS0yH0
	4O6bb39UQ+3jsX+qQS3KNH/JbMyw+kPC17J3ULl3s4y2/K8roz6B3UHYoFUGiCzzQ==
X-Google-Smtp-Source: AGHT+IE1OR+5ynPPryvZBED0yzGQt613Egx5Eg+3YCCbzpHlaC1L0uvo0mPdmzEf/PZvugOU9oN4Vg==
X-Received: by 2002:a05:6000:4010:b0:382:30a5:c38e with SMTP id ffacd0b85a97d-386453ea68emr2656207f8f.31.1733822898202;
        Tue, 10 Dec 2024 01:28:18 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d2303sm188762075e9.3.2024.12.10.01.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:28:17 -0800 (PST)
Message-ID: <fd2eedf8-0eb3-4dbd-8cdd-a6f87f7e3ffc@linaro.org>
Date: Tue, 10 Dec 2024 09:28:16 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf evlist: Fix the warning logic about
 warn_user_request_cpu
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Chunxin Zang <spring.cxz@gmail.com>, Ian Rogers <irogers@google.com>,
 yangchen11@lixiang.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, zhouchunhua@lixiang.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 zangchunxin@lixiang.com
References: <20240318121150.1552888-1-spring.cxz@gmail.com>
 <Z1cB28q8r54L59zU@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Z1cB28q8r54L59zU@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/12/2024 2:42 pm, Arnaldo Carvalho de Melo wrote:
> On Mon, Mar 18, 2024 at 08:11:50PM +0800, Chunxin Zang wrote:
>> The old logic in evlist__warn_user_requested_cpus incorrectly output
>> the warning message when I run 'perf record -C xxx' command on my
>> context(the cpu has 8 performance-cores and 8 efficient-cores.).
>>
>> The old warning like this:
>>    # perf record -C 17
>>    WARNING: A requested CPU in '17' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'
>>    # perf record -C 14
>>    WARNING: A requested CPU in '14' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
>>    # perf record -C 14-17
>>    WARNING: A requested CPU in '15-16' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
>>    WARNING: A requested CPU in '15-16' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'
>>
>> After patching, the warning is as follows
>>    # perf record -C 17
>>    WARNING: A requested CPU '17' in '17' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
> 
> Looks wrong, i.e. I ask for CPU 17 and it says it is not in the range
> 16-23?
> 
> Ditto for the rest, no?
> 
> - Arnaldo
> 

Is this fix needed if we have 
https://lore.kernel.org/linux-perf-users/20241114160450.295844-1-james.clark@linaro.org/T/#t 
?

I think some of these warnings might not be shown in that case due to 
fixing the other issue.

>>    # perf record -C 14
>>    WARNING: A requested CPU '14' in '14' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'
>>    # perf record -C 15-18
>>    WARNING: A requested CPU '16-18' in '15-18' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
>>    WARNING: A requested CPU '15' in '15-18' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'
>>
>> Signed-off-by: Chunxin Zang <spring.cxz@gmail.com>
>> Reviewed-by: Chen Yang <yangchen11@lixiang.com>
>> ---
>>   tools/perf/util/evlist.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 55a300a0977b..82fee2e29966 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -2514,12 +2514,16 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
>>   
>>   		to_test = pmu && pmu->is_core ? pmu->cpus : cpu_map__online();
>>   		intersect = perf_cpu_map__intersect(to_test, user_requested_cpus);
>> -		if (!perf_cpu_map__equal(intersect, user_requested_cpus)) {
>> -			char buf[128];
>>   
>> -			cpu_map__snprint(to_test, buf, sizeof(buf));
>> -			pr_warning("WARNING: A requested CPU in '%s' is not supported by PMU '%s' (CPUs %s) for event '%s'\n",
>> -				cpu_list, pmu ? pmu->name : "cpu", buf, evsel__name(pos));
>> +		if (intersect && perf_cpu_map__is_subset(user_requested_cpus, intersect)) {
>> +			char buf_test[128];
>> +			char buf_intersect[128];
>> +
>> +			cpu_map__snprint(to_test, buf_test, sizeof(buf_test));
>> +			cpu_map__snprint(intersect, buf_intersect, sizeof(buf_intersect));
>> +			pr_warning("WARNING: A requested CPU '%s' in '%s' is not supported by "
>> +				   "PMU '%s' (CPUs %s) for event '%s'\n", buf_intersect, cpu_list,
>> +				   pmu ? pmu->name : "cpu", buf_test, evsel__name(pos));
>>   		}
>>   		perf_cpu_map__put(intersect);
>>   	}
>> -- 
>> 2.34.1
> 

