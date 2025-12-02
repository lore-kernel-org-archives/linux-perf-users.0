Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8414212548
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672054; cv=none; b=gWQjWktMv+PQeVYZokjyLGbFYxoAidisfORMLa/ewlQekgzgpBWyiTp1Eup7xQodXlTVr5GSHDeq9CNlfSdpHC2xdZaGpjC9zrr5m3bvTb74qZlpP4A3mbRPDJHleSEQbZQPU90MVpp4tjMZZlrjsE7kCvdgJZmiaGpanoK+Rgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672054; c=relaxed/simple;
	bh=PBKsInVvpd9PdpiPDAdwcyqFmktaB7feF/0sAPP48zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeVq7XXgRoVPGzK3XxitpALAWR+l7+0dGmCSpQsqu101sDY4mrPXhyWPzRg5rM0ETqhTkLQ6hLrS1/0HXU3NszuTjlUfGOW5Osps9c15a+lnneI3efJ1LAu7vK/pQe0irZ+SH0MWI+kyHC+n3D7kX8+ZdPuC9uze4Mm8PhqvwJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rGjrzL2+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGjrzL2+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779d47be12so42976945e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 02:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764672051; x=1765276851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=th2ta/uFhCmWYoXsGiqxNYGiQhfkxRr8VyWDSYszkyk=;
        b=rGjrzL2+NnrlvX+5mzCN++oEz5agqiiWzzdmQDvXfVmumC8bvoBPM7ekYBSZLkfW/g
         j2Py8JMnLLEQeiTG4emY0maVtaA4uTLjyGZWO/d0LhP/Zlegxm2Q6YYjGqKb0BwS4N8M
         ybUy0HDSKGwok7YyMdneqUqdEMMiONE2uSYGW/30ZaMiQ1uSkReqFlLThZZp+uaQz9fQ
         EX6lyRD2ep1RO9gFs8nU7FyseuWRXyhajMhQG9ZBk4hp84iSSk5Ns8nBhQLIsqpxeUrw
         HQ5X0SwNmd/9hs07WM0ehspr2Cw7+dSYKXo3ywus65gU2bpAlxVZKIi9ylnsjvD5bZeA
         y9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764672051; x=1765276851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=th2ta/uFhCmWYoXsGiqxNYGiQhfkxRr8VyWDSYszkyk=;
        b=nD92b7FYQFHAsVgbpvRtPMHMbDI/SW6svuMHO/yXRPJiAvgbRzidBQXb9h08PYdr5P
         YV0CNG9XeMCblzqddxkST+jStTzwGfzY5CCV8DdYjNcx42SwTm7l3H/ZN2jF1O3KDuKf
         wcJr4jrgL0Ckys9Rr4/mjuaXjRUbDoEgL8Nxx60ovfAYFc+EYG6YfJxx81Aovsl6K50+
         kL6zO3sC3KwUgJqBoaYA9vqynVmFHX7lIhK74iBNIrXxJfHYZ0ydXss73NdJGFVl2sL6
         eh+hI4Oilp7WotMCnHxhrPpOdkP/59KcaDP0kf7FFthzHKt8QnguAo17rFABC9usFLWG
         9rjA==
X-Forwarded-Encrypted: i=1; AJvYcCWKD0FoLee1+4LL55Fez3vdO7tG0q0lnUbq+gTjZQ1TJU6DiUnjL42NtTtXS4RXS5ZdwIoXvLxeGV95yF/8oJEG@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6nnh/RKfnHFD98LXhasURe7mxjPeqtU9MBs+4dgoy2OO6m73
	sfV12qfdi9nW11D8IXy62zKzuLRFse3tM6Dy03gcfY5YXzVXhyALWg4Nnaz2QZmvCvg=
X-Gm-Gg: ASbGnct5zFOM9PWvsJj8WYs64USPe8krt955QrXBj/+8PIMb/DxwQW3iLCI6r8z5ML4
	3xzg8lNdsepCEwUuikJ+vVifWbLQsjPnGlza+7p3pDXZf/b7btQhAaAJY9iB/Abt69XVBt9alNK
	sPibOQn/dmI3cIPr82EjHiTsKsbd6jVja2rBYQguRPb6YfqXLsOlLKpjpePlyaRiaE2T2K4JoxB
	CBlogOZ27qkXUSB4KsocKB1/OaIiLh5eYtpCBRVl8ASco7uMoeux1xFlnlbzxm+8eu79o5XBY6p
	zFwbUYnP8Wu0Qn07xHAapOP8i55xS02qhFfs+VFGX9ulCOln5X+hQcDZ7639/0w5BGDlLOen+eM
	Q7oPtAPASr0r1ODLW5PK1gKNikaXxDGZEKRM/PwZ5LZzifBJ3e9g1EgamgAC9GTKvN4Vf2N6zmP
	41pVFAVMhIW9qEA+if
X-Google-Smtp-Source: AGHT+IFIZZL3ELzhmY7ZxQvV+EVEfV64j2iIUcHf0FIxZBYlBnLylq8S3u+BdSmD7CbXWktYV2cbug==
X-Received: by 2002:a05:600c:3b09:b0:471:13fa:1b84 with SMTP id 5b1f17b1804b1-477c0185bc8mr473893265e9.12.1764672051209;
        Tue, 02 Dec 2025 02:40:51 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791116c3c0sm291934395e9.8.2025.12.02.02.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 02:40:50 -0800 (PST)
Message-ID: <978dd9b1-1cb0-4338-95fa-575a858cea80@linaro.org>
Date: Tue, 2 Dec 2025 10:40:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] perf tools: Track all user changed config bits
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
 <20251201-james-perf-config-bits-v1-1-22ecbbf8007c@linaro.org>
 <20251202101556.GR724103@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251202101556.GR724103@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/12/2025 10:15 am, Leo Yan wrote:
> On Mon, Dec 01, 2025 at 04:41:04PM +0000, Coresight ML wrote:
> 
> [...]
> 
>> +#define ADD_CONFIG_CHG(format_type, term_type, new_term)		\
>> +{									\
>> +	struct parse_events_term *term;					\
>> +	u64 bits = 0;							\
>> +	int type;							\
>> +									\
>> +	list_for_each_entry(term, &head_config->terms, list) {		\
>> +		if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {  \
>> +			type = perf_pmu__format_type(pmu, term->config);\
>> +			if (type != format_type)			\
>> +				continue;				\
>> +			bits |= perf_pmu__format_bits(pmu, term->config); \
>> +		} else if (term->type_term == term_type) {		\
>> +			bits = ~(u64)0;					\
>> +		}							\
>> +	}								\
>> +									\
>> +	if (bits)							\
>> +		ADD_CONFIG_TERM_VAL(new_term, cfg_chg, bits, false);	\
>> +	return 0;							\
> 
> Nitpick: "return 0" is not needed here.  Otherwise:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

I think it's worse than not needed, it makes it stop collecting the 
changes after the first one.

It was annoying that this had to be a macro instead of a function 
because ADD_CONFIG_TERM_VAL constructs the #define name of the first 
argument.

It's probably worth putting in some effort to make ADD_CONFIG_CHG() a 
function to avoid problems like this and maybe add a test.

