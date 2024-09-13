Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ABB1C175F
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Sep 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229337; cv=none; b=WLGMrAUWwrVEuiuDHy0alHB0fDmvFgZGIIbijDAoP0riydAsI8w37e3Dj24S1lW2FP+gKeXMyw2WewCVH1SKgUU0FO6AQpMn5i8Db9YW0aB8aE+5gEaru82MC7cDk6+++EvvIY0WOd83Y0s2oYWKUE/REbJi2lVAa5GK2txMTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229337; c=relaxed/simple;
	bh=DHls9ncs43N2cY+KBhoDz5LT8cdPXxKz8OG5NtYGIzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2bMV56m0wlDCzUy8eI0Raim/xJeYxudOtox59yrJO1fqcDEqwjRxj7F+4aDhJBVHLs2V04mh9hHFpLxy9+v7It5FAzRG3hTDupRokv3ou1/4uu6y1O/dLmy1tdNhZTXjp6dIsHBdDfUxZe+8OLMuoLu0MwZnJWGlXXflqxnu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LGZnmWIS; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGZnmWIS"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365b6bd901so2426770e87.2
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Sep 2024 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726229333; x=1726834133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfq+W44YecCwDojJhg+2LqlC6kM/7W6GIy5oGme1yFc=;
        b=LGZnmWIShFurSOPR3clYP2LLIziJY88g+HdgyuGYiN618/LUNjNH2ve57Fdyo6d8Pd
         8eQcs6EcqS5qY/MTOBFZPxPxZ5oCA04lLwrnbRvvgyLrKo9lQ7XrrpTHaerK96SrUjZ/
         FXfEW1wcl8xHFJX3tbx1W57YH0XWiiV5/0Iezkd7Ws6K/XtJrTHBBNjoWffF8sYlWyfz
         TUpwiGC1x+Uowh7LcGPVMCEsgq1MDU9EHgQq6peNSAjlL87tlgbLsfvPWtiI5Q2lr5tx
         l/AoM6exobtBi4joklN8z2Y3oUGgUGch9VmxtJEG+vcIiN51YmLMge+c87CalcMs0lSB
         duWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726229333; x=1726834133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfq+W44YecCwDojJhg+2LqlC6kM/7W6GIy5oGme1yFc=;
        b=xAnUvamdlcz/+pvUfbD3grUZPztJddafdBl10VLURj5A3MoGOaI9dYwoPt4IjncADs
         m2jMfsgKVFlH7kw5C3TOxSU61J7Vz0tPKxwgc8ju+70cdQokJ2+tUslBBK8/EKRw8Ng0
         BBFyYNJk0HxRIAJvD47IvFDc9oO1RIag8buY+AIlLAU46wCxxHQ6IPx4cXzv5MGofMPW
         E5KFMrVX68oKi4Lovva+VnidkdESMcj9W4/bXBpnl12xMvsy7T98A3ahQ7uxk89efa8w
         oO7NIG1KwikHDKwo/vUYHz+OIdyaGAnnhDg6Kb2B2FsS2QyiQFI303tpaHr+sqAkG9CZ
         wOgA==
X-Forwarded-Encrypted: i=1; AJvYcCVjbbT0oYxRIyDxUo1Vcew3TjQ/SVkG01QuztWjX6r8OLObMQ8hg/YMta+xlQPiN9BK+gTQuXJiDLW4mw7xQJT6@vger.kernel.org
X-Gm-Message-State: AOJu0YwQSUOXYYbXXwjiPMGOcXc6SmYZzVqr8cImVvbW6CvfKq77ddm0
	oTmgnxunZBrdpQBzsUJ9mmEOrkjKHYIP6nEQSfHSi0pKb7NykVdoZtSd8NFc6S4=
X-Google-Smtp-Source: AGHT+IG9DtgFArBOo022Muf8Kgfs3Z0aaLcxTYPJCojGCGGF/d87glnhK4hXOB6oeIn6TBebTBMaHA==
X-Received: by 2002:a05:6512:3b23:b0:52c:e086:7953 with SMTP id 2adb3069b0e04-53678fb1ddfmr3964807e87.4.1726229332734;
        Fri, 13 Sep 2024 05:08:52 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b179b29sm23367705e9.34.2024.09.13.05.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 05:08:52 -0700 (PDT)
Message-ID: <332e0654-df8c-44b1-8e55-398aeba37b08@linaro.org>
Date: Fri, 13 Sep 2024 13:09:06 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] perf cs-etm: Use new OpenCSD consistency checks
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, coresight@lists.linaro.org,
 scclevenger@os.amperecomputing.com
References: <20240912151143.1264483-1-james.clark@linaro.org>
 <20240912151143.1264483-3-james.clark@linaro.org>
 <cfad80e4-3ee8-4a55-9dee-41d0d0256c04@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <cfad80e4-3ee8-4a55-9dee-41d0d0256c04@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/09/2024 12:54, Leo Yan wrote:
> On 9/12/24 16:11, James Clark wrote:>
>>
>> Previously when the incorrect binary was used for decode, Perf would
>> silently continue to generate incorrect samples. With OpenCSD 1.5.4 we
>> can enable consistency checks that do a best effort to detect a mismatch
>> in the image. When one is detected a warning is printed and sample
>> generation stops until the trace resynchronizes with a good part of the
>> image.
>>
>> Reported-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> Closes: 
>> https://lore.kernel.org/all/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c 
>> b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> index b78ef0262135..b85a8837bddc 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> @@ -685,9 +685,14 @@ cs_etm_decoder__create_etm_decoder(struct 
>> cs_etm_decoder_params *d_params,
>>          }
>>
>>          if (d_params->operation == CS_ETM_OPERATION_DECODE) {
>> +               int decode_flags = OCSD_CREATE_FLG_FULL_DECODER;
>> +#ifdef OCSD_OPFLG_N_UNCOND_DIR_BR_CHK
>> +               decode_flags |= OCSD_OPFLG_N_UNCOND_DIR_BR_CHK | 
>> OCSD_OPFLG_CHK_RANGE_CONTINUE |
>> +                               ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK;
>> +#endif
> 
> Looks good to me.
> 
> Just one question: should the flag ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK be set
> according to ETM version? E.g. it should be only set for ETMv4 or this is
> fine for ETE as well.
> 
> Thanks,
> Leo
> 

I asked Mike the same question about ETMv3 and he said none of the flags 
overlap and it was ok to always pass them. So I assume the same applies 
to ETE as well.
