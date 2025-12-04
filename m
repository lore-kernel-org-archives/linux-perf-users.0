Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB21397
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764845735; cv=none; b=Oclmrpj8tSQ4xPspiQzjHGu3N0MnX+RdsJD2EtP/YRq+g3Tq+Tek+ALGfvZBeJZ56NsMpAILeuHJs5f32C05VmyZJVVZaYjTHoUaTsYakxwqEqrzxxs46gV9E49RQ0YCL5aKBa+2xCDy1tIWs1pc5WkP48X1/QJ2K540joY2Wbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764845735; c=relaxed/simple;
	bh=KfNAxcWsFDZtg0VgvwB9Evx0NV6h4p3bl4zs5YSIaR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLvpQ8mrfYydXXNJzeRsVX9GZmKRZE/qU+UvfpsyP+JJV0OJLUFVu++CaPVZ3qL4Y2Dp4rieQu5zDn3fvb4fXG4s0RWxFpHW6B/1ugZ5RQWUdL9uuFPH6YrfTeQFtdDHr7JL+EN8718UFlXco/L9gZ5NBPpNf9kThd9UDI3W/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZrRQpNeL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrRQpNeL"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso1150877a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 02:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764845732; x=1765450532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUsSSlUcY7wQnlMDz+NJbRcKuFysd8RLpXnuMwJEeMI=;
        b=ZrRQpNeL2XRZKfb3aUPl7s+E29JnOz6u0NwPyHjqwzk6gWRKJxf3oBBfT4douEvDwR
         hmosBOp0OQMApUvrrV0YKTaiTH/PY5lHGcrsxB8UeAWGFx7BWkv6t3T+1VobE7t7fspe
         ST+sZ2EkshlY7Y2nc7D5zntcdBeoSCL8kFQjeI7fRk6VXvJOBoUUcAj7Yw/Fz+2RhbSV
         hDFgSuUKTP1xwh5DY55O/T4hqBTVqpR1vGoZbtXoU+KpX75fGbyox9q0N2A4w22Atw0W
         T0tY+T47BBCny3Fn8fp1cwcjaHDrdwvxTX9hsES4OHj4D6rHyA9RVDoZw7lv2ZxYHeTq
         kPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764845732; x=1765450532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUsSSlUcY7wQnlMDz+NJbRcKuFysd8RLpXnuMwJEeMI=;
        b=s+dNdZiXCaoU31sPsxJijOtfdzdR7SP6Ujl+fNKiEpogdT3/e11tOdLMNvr0Rdz91Q
         hH6rIS6yBlpWW4t6gLtjDSCjFha1Fh+znU0UUbwNDnb2vNTEH6F2BJ3RmzOzPOJeQP2I
         k6UgtQMZcJXf+irJnNGVZQl256VUJQikBExCF7emhevdRB+v7E40qaEGsrhgB7iYDqQA
         6hKPhaC9jKrQHTEkPgK09M8Tg2PCDEb2sC5tgY7Z6d4jacWPypCLuypmsr+78ZO/1GFP
         P/cBoEQvr4wZkb6GLE9tTNE7I1l04NCmW4C9YDIHw4T8YMQQFGEEpjDmyrwJDtSOkyx7
         h3Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXh8tY3Kga3BDp8eW6vyCAYoLtVTS8pVBkF8BVDI01slUC/71hatSW5vUvsdFT2MOy6M9sD00KIe3Zb9xfvfZmQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2KcjBFtrTQzy9c7qJlU/GskhP10mwtqgRQtDkLxpPKBozUJ7b
	lFBr941VpfI2+NtjLJ9Rg/RtLpaNAgAwbwnLdbxruuQijkVrIljOxCsNUmqWJBfh+Og=
X-Gm-Gg: ASbGncsJaiItFtqLpH4ldwDGgC94+C6xMrwr0pB/aotCQbmRVHQW1IxpazZruars8cU
	pf+Wm/bEzEjIf/faaKt7f7kQSQyiP+aVnuxVsSEiUtzsbMdLoLvROfK4esBgAfEVv9ex4ssshRF
	O+bM9v5a8+5JuVdtXSpo1Mrcav9nY8rxwJfyd5KxEaN+MRfnHIThWUrSJyyEdY3N0WG9PWijPu0
	IoD7MKGwChNiFR/eKI3j2E+uNql0Z2aBvhLc+t/l6ZgDeRCfMUi/mayUvORC0TOAVeeSu7ugDhe
	QjjzRidzDeg160cPl6kcSGt2kAfu1fo/UeQXXk/vycqh1gWWSWLpC9G+pKvn8iedqStJZPUOKnz
	JOzKfvFMdm12UnUlWCFM5o3dH0xplAou1LV8m/j1rxUSEK+eNDO6Jl1q8+LVMmo7ugyRT7fnw+i
	MkCmfd5R2B0Cp3aH9U2xa/UQJ2I5k=
X-Google-Smtp-Source: AGHT+IENHvhi6pXKaJ+5f7nedg49gxJBxX0xpyd3BktUKwCryE/FZ4iNGolJufGPapWBjNh9KBoiMA==
X-Received: by 2002:a05:6402:1d4e:b0:647:a570:b74b with SMTP id 4fb4d7f45d1cf-647abd99511mr2072101a12.14.1764845732199;
        Thu, 04 Dec 2025 02:55:32 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b412dd8csm976684a12.33.2025.12.04.02.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 02:55:31 -0800 (PST)
Message-ID: <6661f623-0b27-429d-92ee-785caf04e682@linaro.org>
Date: Thu, 4 Dec 2025 10:55:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] perf tools: apply evsel__set_config_if_unset() to all
 config fields
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-2-22ecbbf8007c@linaro.org>
 <20251202111403.GS724103@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251202111403.GS724103@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/12/2025 11:14 am, Leo Yan wrote:
> On Mon, Dec 01, 2025 at 04:41:05PM +0000, Coresight ML wrote:
> 
> [...]
> 
>>   void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
>>   				const char *config_name, u64 val)
>>   {
>>   	u64 user_bits = 0, bits;
>> -	struct evsel_config_term *term = evsel__get_config_term(evsel, USR_CHG_CONFIG);
>> +	struct evsel_config_term *term;
>> +	struct perf_pmu_format *format = pmu_find_format(&pmu->format, config_name);
>> +	__u64 *vp;
> 
> Should check (format == NULL) here and bail out for a unknown config name?
> 

Good point, yes I'll return without any errors. It will be slightly 
inconsistent with the other config functions that return an error if 
it's not found, but it's consistent with the existing function which is 
a nop in that case.

>> +
>> +	switch (format->value) {
>> +	case PERF_PMU_FORMAT_VALUE_CONFIG:
>> +		term = evsel__get_config_term(evsel, USR_CHG_CONFIG);
>> +		vp = &evsel->core.attr.config;
>> +		break;
>> +	case PERF_PMU_FORMAT_VALUE_CONFIG1:
>> +		term = evsel__get_config_term(evsel, USR_CHG_CONFIG1);
>> +		vp = &evsel->core.attr.config1;
>> +		break;
>> +	case PERF_PMU_FORMAT_VALUE_CONFIG2:
>> +		term = evsel__get_config_term(evsel, USR_CHG_CONFIG2);
>> +		vp = &evsel->core.attr.config2;
>> +		break;
>> +	case PERF_PMU_FORMAT_VALUE_CONFIG3:
>> +		term = evsel__get_config_term(evsel, USR_CHG_CONFIG3);
>> +		vp = &evsel->core.attr.config3;
>> +		break;
>> +	case PERF_PMU_FORMAT_VALUE_CONFIG4:
>> +		term = evsel__get_config_term(evsel, USR_CHG_CONFIG4);
>> +		vp = &evsel->core.attr.config4;
>> +		break;
>> +	default:
>> +		pr_err("Unknown format value: %d\n", format->value);
>> +		return;
>> +	}
>>   
>>   	if (term)
>>   		user_bits = term->val.cfg_chg;
>> @@ -1396,20 +1436,8 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
>>   		return;
>>   
>>   	/* Otherwise replace it */
>> -	evsel->core.attr.config &= ~bits;
>> -	evsel->core.attr.config |= field_prep(bits, val);
>> -}
>> -
>> -static struct perf_pmu_format *
>> -pmu_find_format(const struct list_head *formats, const char *name)
>> -{
>> -	struct perf_pmu_format *format;
>> -
>> -	list_for_each_entry(format, formats, list)
>> -		if (!strcmp(format->name, name))
>> -			return format;
>> -
>> -	return NULL;
>> +	*vp &= ~bits;
>> +	*vp |= FIELD_PREP(bits, val);
>>   }

