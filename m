Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180311;
	b=gDtu6s5uB2tHepH71hWA4LDWLcdLlP9gpb8IivsTW+HVSZbqXckCgk7wpst9La6gSAc6
	 1i0B+Kjqzrt1RPg8iSWAWwdpE479DbBk+uEcBvuez/hvCtyhHuR7HPP00GDDM8FT2jtRX
	 XVJV0W83u04iEzp6UJEQiRdKbEgQWV5wZr4Et0/U25eIEmjsby5Jt8kq5TzMrajBEtulS
	 jXLfWS1wAknzPr6Le4x8X+95osvB0OlYq5+YISJTrY7szBZT6UlOHputTqb6IbXc997Aq
	 ABuq4Ri6eqfqoxXyfREBxmaa6lcHXXwj9F67tSHN045+n4nxbWKAcrTJHLFMBn6igpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=pzUmwNzwamyMVOA6MAa5bFlqwFID1JSnlpUPYtQh5+I=;
	b=PSw8odxFEEYgcxRLUhWd+3cvHnY/25UX9TrN2fxdhACyOozg0yAs4q6pRnG2qhVq1r3a
	 12h32vt/v/C2LRk0msdnym3dvnCgTk1mEX3SO240Ycyquq96zh4hIVLnURpp96PDkYnZV
	 fM9I/NVNYzrMbJdGivRWsxZzUuqdr4Y59ZrNhwLYO8iDjWkGI17pgdFG1zdwZ4u2lEtKM
	 aAy9QRK9KosIftM0papbc9NIAQ7DeD0ssJZsIV1uxFTTcNs0alNtXtXjzDGJr4d8SxeQO
	 xIyBmSFlJpW4RHxdE5fpnDlZ92fAWarmVb2f58N3bVtqeG+7XU3GNfudKxF2TJY2CLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="px198/PW";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605EC606A31D
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 09:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 605EC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=px198/PW
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso7514255e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793180310; x=1793785110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pzUmwNzwamyMVOA6MAa5bFlqwFID1JSnlpUPYtQh5+I=;
        b=px198/PWpqiPIx8ytXkwsSbiuXzKqx9E8mO1xgR5CVTiCae/63ysQ6DDuOzgjIoXkz
         7gAbPY/AIRYo6NOUedPy2tE2taSO1QtzfS3FYWOmwzJAdFY4d9Xqx1IEZeh40Xdfrqcy
         u800PidSOgsYIZPxSFGEt+zNzczp9WENRdMrB8Np1w+sC9Mk/FPQjVBEHU4kh9QpBiyh
         3Vb26fQbhmMzz+f0Psg8pvN0/qjJj+fH+TeTtY6TpJh1lzp3LajYUgET48cMsB7SYOJr
         nhLN6stWREYjE8UWBew0RNsBZAwWumrlrLfXrpVDL42mp29limr+baqIrQLc5r9zXNC4
         FkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180310; x=1793785110;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pzUmwNzwamyMVOA6MAa5bFlqwFID1JSnlpUPYtQh5+I=;
        b=CbA/3C2S5Sqk27OY2d3fqbsBVmqELgw1gDgoZVHjFXWw1zVFILkEJRlLXhgCHiUAeU
         j7fHdSMTIPGXXr8nUhsl7tbFWyaMldWm6m4oNUO3EqzVpeR87aF3dceawetlCoG+3gmP
         G4In8LwZioFQy8D15sVt5iM8UCOJ8cg1nAKlzHqTXkyRmYm9gAqiO9ixal7ZkUtqfRQS
         XzoF35TTFKXWKEDjjXFhgFgGjejmGz55cqsN9MM2uKe3ErkBoirmO8D/4wWBmLleszbj
         LA4QGbBxaWgtrfl1DsLYXBqAqBk4SlYN3gcVY3LTKQSPiWnW9I61/pGmj5JkYqIuGvqy
         wuTQ==
X-Gm-Message-State: AFq9FYL/iQraxolzZdgJ39ERgZcaO+mYddHD/x3MHsWxzKe3nk2bni7s
	TxFhhjUz67+asmkaeRHdZWAQlLF8MCWMibuG+hA2+YaMVQRpZQRKhLtK+IDXldq3bjE=
X-Gm-Gg: AYBFou3qXYak9gF1Q2SH85ntGWVXfcFQcuMpcjWszA491elFqKaEb4chPAVU3GgPsA8
	keTNRXQ6jbkgSzs4eBJfej97blkg59f6WsvevQ/178du+EcfjkF1Ts1OSGWq/ow6FTskbMdM3P3
	ZAdyu1NEJ3tMBm5MdVnX5sGqr77XsY+9cJhFNWyncWAPxvtnsSXMr8mJO4veYK3J34QeKUuaWa7
	FD9i2ds936Ps/87potPDttFvfeALN5Ady0NtmR+Onk/oZ/0DmPRHHU8/yOrsjnG5q2D0ODBivWD
	LCsMStAHB99CKXhOTXUWLqPsJI146Q8X5icaBIYD/7e7xN20CpKjjqRgPOIynoxsN1ZHPbjcr0B
	m2KCngxoJpDx7j3+bn7xggV8YL8z4sv3ZmiBkZHL8OQyUqRX2hlXvFGKtBI92Sl2cS+bvHWpt4k
	OvmZdnEczDD0pqTG/xtfDQiUeFAYzrUtuY6At7BymmhcSUWkJhR/Qlj5qFPF+pXwpUgV82ibqLJ
	DFK/v5gIfwJfak+B6On06BFFQCbCdjfmF/gBq3W00PcfQdiMyd5K2sDE1Ij8al4teq1MyJzc8o+
	C8lcwIc9mdjjHJPy5SWw4bC94eMixwZRBA==
X-Received: by 2002:a05:600c:6089:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4a967ca24ecmr34100865e9.32.1793180309742;
        Wed, 28 Oct 2026 02:38:29 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97c42b3c1sm35187485e9.6.2026.10.28.02.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 02:38:29 -0700 (PDT)
Message-ID: <97df111f-edf4-4ce6-8ccd-9cccc730006c@linaro.org>
Date: Wed, 28 Oct 2026 09:38:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/core: Return errors from
 perf_report_aux_output_id()
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Mike Leach <mike.leach@arm.com>,
 Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20261001-james-cs-retry-hw_id-v1-0-4d45ab46cde7@linaro.org>
 <20261001-james-cs-retry-hw_id-v1-1-4d45ab46cde7@linaro.org>
 <254599ef-ace5-423b-bc31-56150909d96f@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <254599ef-ace5-423b-bc31-56150909d96f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/10/2026 16:46, Suzuki K Poulose wrote:
> Hi Peter, Arnaldo, Mark, Ingo et al
> 
> 
> 
> On 01/10/2026 15:21, James Clark wrote:
>> It's useful to know if this failed or not so a retry can be attempted
>> later. Return the error code or success.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   include/linux/perf_event.h | 2 +-
>>   kernel/events/core.c       | 6 ++++--
>>   2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 48d851fbd8ea..01d318a4de50 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1896,7 +1896,7 @@ static inline struct fasync_struct 
>> **perf_event_fasync(struct perf_event *event)
>>   }
>>   extern void perf_event_addr_filters_sync(struct perf_event *event);
>> -extern void perf_report_aux_output_id(struct perf_event *event, u64 
>> hw_id);
>> +extern int perf_report_aux_output_id(struct perf_event *event, u64 
>> hw_id);
> 
> This looks a trivial change with minor impact. Are you happy for me to
> pull this via the coresight tree ? Please could I have an Ack on this ?
> 
> 
> Cheers
> Suzuki

Gentle ping, thanks.

>>   extern int perf_output_begin(struct perf_output_handle *handle,
>>                    struct perf_sample_data *data,
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index d7f3e2c2ecb1..232da3b6f393 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -10563,7 +10563,7 @@ static void perf_log_itrace_start(struct 
>> perf_event *event)
>>       perf_output_end(&handle);
>>   }
>> -void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
>> +int perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
>>   {
>>       struct perf_output_handle handle;
>>       struct perf_sample_data sample;
>> @@ -10585,12 +10585,14 @@ void perf_report_aux_output_id(struct 
>> perf_event *event, u64 hw_id)
>>       ret = perf_output_begin(&handle, &sample, event, rec.header.size);
>>       if (ret)
>> -        return;
>> +        return ret;
>>       perf_output_put(&handle, rec);
>>       perf_event__output_id_sample(event, &handle, &sample);
>>       perf_output_end(&handle);
>> +
>> +    return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
>>
> 

