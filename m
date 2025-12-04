Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C696398F90
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857348; cv=none; b=aswB8f/M6bau2G03QT9Kcn6ojbr79W7EJGvny3poHQnuPqBSG9Zqa+4w3Bj0KZneLbT232EHilYbntakcyuBji7dUrSPqcOrxC8e0IQX0O3CYWs4L33Vbi8Ry1d8udj33jcz891x8HpV2hKzoQbOeqfR0kkDmTqTg7ODag5nmVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857348; c=relaxed/simple;
	bh=PPN9ntVixLLghQlwTGocaD7TMXsSlTYP+h+h0LhL+Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=US//6ctW1KOq5K1dIfHO7zEGxxFJ7D7SB8zOAG6wXoCDSoc+Pky5LMo3KYaXa2mC3n3/u+6PjDut3L9YgQOZmk3MJvDGTCzSPnDeMCQ4SaObZpNPM41sj2nEdTOvqw4uyMPb0Igzv+T3/dsLlkfJ+TByeYdvOm5KfvWxAM+7QcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wj15Xawz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wj15Xawz"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42e2ce8681eso748947f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 06:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764857342; x=1765462142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K76Qia/ZXCjjiEWFg52fUrDZVdVaau3amc8W3Ejug+E=;
        b=wj15Xawzw1p9eA1tU881e1JXkWk46QEsDB/MvLRQuZp1uZNgXhanjHZyZPfF6gzWIo
         aENnej/+QBMJHEAVvqDwyUABa/9iB9hj2EH36RH+05C2ynQzeR1uenksCLVWJkRxHU9M
         9AFh6N7a2k7caA44uu21p4bP+Xs4ybLxaZeq6z9135wIjNxZN8JR8DblxCWxNlDmCzKS
         jIxAAnjez/QtZ771XmLNtiIOtn37Yk7VuOmUOlTecZkNnvy3dnqBthJHKo49csFVNvqI
         Ij7IOEr6XNOhzkzrgvwe2ep8c8Uy4e8fAms2UC7k0bqZIdp4y1LA6/iP/pZkD/jsorq9
         /P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764857342; x=1765462142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K76Qia/ZXCjjiEWFg52fUrDZVdVaau3amc8W3Ejug+E=;
        b=URO5yDYdCP0GXoAzWYVnjjg9awt/IjWN02GbMfbXtbdoR0KJSr52Ski1UohW0VnItO
         6c4IC6vyIn1jaA8ND5GXDAhXKiqQYSPENfXjwUSvjmlwEIfWL/PdKq/fdhM+mSsGUv85
         rknzaxTlKZzvyIBNAPLkVF6JKKAPeuxexhF07OzJZMKWyaRBfuU1U0I4h+kM3Vtp5/O/
         ubaLuNY9EYo/ORYMeYpztMj1Qfhw7YSKb5klcCxrQMsBROfGiwBNU2QuFMIPKYvFrrpL
         eavqgzC4AjDbwVgHCnVGLt8y3ZWRy1JeXWfSkHE9ln2h1ws4792EYGe1FIAtsOaYfNFY
         ISRA==
X-Forwarded-Encrypted: i=1; AJvYcCVZaYrmUJzh9VNsExBqUfmjW6ZWoT7dSxVNTm4XmTfAamK/dLYSwLIAIwDYnLBnObMCI4nIHv6DTDD5xNdZPrzq@vger.kernel.org
X-Gm-Message-State: AOJu0Yyco3D4XYZz0sxILlCjepUGbO8Apv8MbuVKHpQzOjPiYxy7kdlg
	nLP6QT43kH+tYXXtzjkHC65mmFx0BfvuEgcxYkmcmOjYgVOvUA5WS3vj5V+et5nHfIQ=
X-Gm-Gg: ASbGncvAoTBEP07xOzsnKc6pqBbuykgba9B2I8zHiI4SunsCICowjYLZBQlwrO+wtpn
	v5MuLCEq6odIzhJlpasLB6LaUDU+0SSW+PSCP9/8MGSkaUxHxuqLkKxgWLOs5bIcjBYOkQK1RpD
	mInqAPluBjVpnfvPyA+IItF6BUzuBwykU+36aaB9TCt+6zvL/inV6BWFdfpJJZ2+XuAGC+8mlm+
	Zy1X0D3814t6v58wXDpgDFPOlRGzt6Uz3q9TyrQO16jjDSvoiD0M113SWDGK8p3aGfCZCbYVurN
	CWVmhn2OxM082QwY5Um/stg3w95F7TlKGVeXBQq6s+M35w8g9C0/bN3xn6V8xnpBTQSlb4ZZj9w
	rdyLgRlmYFVI4N4nOMN3YN1p4knqDVAJaNGE3fWMD+b3+0QJI5VwQz0SZjcs7ZIV22diITT7m5p
	kXmkjitOjfOxz4biIQ
X-Google-Smtp-Source: AGHT+IE2K35j9CdlrIvdH8Bojq1tholsrKjYuSZd1hMIs3XjAOQLvnDBCIItIYw5O13dYS68vstw3Q==
X-Received: by 2002:a5d:490a:0:b0:42b:3366:6330 with SMTP id ffacd0b85a97d-42f731cf312mr4668252f8f.57.1764857341593;
        Thu, 04 Dec 2025 06:09:01 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe90f0sm3477398f8f.9.2025.12.04.06.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 06:09:01 -0800 (PST)
Message-ID: <857538e7-cac2-4871-9711-4c434420df8a@linaro.org>
Date: Thu, 4 Dec 2025 14:08:59 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] perf cs-etm: Don't hard code config attribute when
 configuring the event
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
 <20251201-james-perf-config-bits-v1-6-22ecbbf8007c@linaro.org>
 <20251202121528.GX724103@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251202121528.GX724103@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/12/2025 12:15 pm, Leo Yan wrote:
> On Mon, Dec 01, 2025 at 04:41:09PM +0000, Coresight ML wrote:
> 
> [...]
> 
>> @@ -103,13 +103,20 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
>>   				      struct perf_cpu cpu)
>>   {
>>   	int err;
>> -	__u64 val;
>> -	u64 contextid = evsel->core.attr.config &
>> -		(perf_pmu__format_bits(cs_etm_pmu, "contextid") |
>> -		 perf_pmu__format_bits(cs_etm_pmu, "contextid1") |
>> -		 perf_pmu__format_bits(cs_etm_pmu, "contextid2"));
>> +	u64 ctxt, ctxt1, ctxt2;
>> +	__u64 trcidr2;
>>   
>> -	if (!contextid)
>> +	err = evsel__get_config_val(cs_etm_pmu, evsel, "contextid", &ctxt);
>> +	if (err)
>> +		return err;
>> +	err = evsel__get_config_val(cs_etm_pmu, evsel, "contextid1", &ctxt1);
>> +	if (err)
>> +		return err;
>> +	err = evsel__get_config_val(cs_etm_pmu, evsel, "contextid2", &ctxt2);
>> +	if (err)
>> +		return err;
> 
> Seems to me, this is not right.  The current code checks any context
> ID setting but it can tolerate if missing "contexid[*]" format.
> 
> After calling evsel__get_config_val(), if any "contextid[*]" format is
> missed, it returns error and will diretly bail out.  As a result,
> cs_etm_validate_context_id() will always return error.
> 

Missed by the driver or the user? evsel__get_config_val() only returns 
an error when "contextid" isn't published by the driver, not when the 
user doesn't supply one of those options. The actual user supplied value 
is in the out param, not the return value.

Having said that, this does make it an error if the driver did stop 
publishing one, which might be too inflexible and is a new behavior. I 
can change to it ignore the errors instead.

>> +
>> +	if (!ctxt && !ctxt1 && !ctxt2)
>>   		return 0;
>>   
>>   	/* Not supported in etmv3 */
>> @@ -120,12 +127,11 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
>>   	}
>>   
>>   	/* Get a handle on TRCIDR2 */
>> -	err = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR2], &val);
>> +	err = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR2], &trcidr2);
>>   	if (err)
>>   		return err;
>>   
>> -	if (contextid &
>> -	    perf_pmu__format_bits(cs_etm_pmu, "contextid1")) {
>> +	if (ctxt1) {
>>   		/*
>>   		 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID
>>   		 * tracing is supported:
>> @@ -133,15 +139,14 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
>>   		 *  0b00100 Maximum of 32-bit Context ID size.
>>   		 *  All other values are reserved.
>>   		 */
>> -		if (BMVAL(val, 5, 9) != 0x4) {
>> +		if (BMVAL(trcidr2, 5, 9) != 0x4) {
>>   			pr_err("%s: CONTEXTIDR_EL1 isn't supported, disable with %s/contextid1=0/\n",
>>   			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
>>   			return -EINVAL;
>>   		}
>>   	}
>>   
>> -	if (contextid &
>> -	    perf_pmu__format_bits(cs_etm_pmu, "contextid2")) {
>> +	if (ctxt2) {
>>   		/*
>>   		 * TRCIDR2.VMIDOPT[30:29] != 0 and
>>   		 * TRCIDR2.VMIDSIZE[14:10] == 0b00100 (32bit virtual contextid)
>> @@ -149,7 +154,7 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
>>   		 * virtual context id is < 32bit.
>>   		 * Any value of VMIDSIZE >= 4 (i.e, > 32bit) is fine for us.
>>   		 */
>> -		if (!BMVAL(val, 29, 30) || BMVAL(val, 10, 14) < 4) {
>> +		if (!BMVAL(trcidr2, 29, 30) || BMVAL(trcidr2, 10, 14) < 4) {
>>   			pr_err("%s: CONTEXTIDR_EL2 isn't supported, disable with %s/contextid2=0/\n",
>>   			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
>>   			return -EINVAL;
>> @@ -163,10 +168,14 @@ static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *
>>   				     struct perf_cpu cpu)
>>   {
>>   	int err;
>> -	__u64 val;
>> +	u64 val;
>> +	__u64 trcidr0;
>>   
>> -	if (!(evsel->core.attr.config &
>> -	      perf_pmu__format_bits(cs_etm_pmu, "timestamp")))
>> +	err = evsel__get_config_val(cs_etm_pmu, evsel, "timestamp", &val);
>> +	if (err)
>> +		return err;
>> +
>> +	if (!val)
>>   		return 0;
> 
> Similiar issue here.  The current code returns 0 if not find "timestamp"
> format.  With this change, it returns error instead.
> 
> Thanks,
> Leo

