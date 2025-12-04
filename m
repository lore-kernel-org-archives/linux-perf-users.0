Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA61331A42
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764845745; cv=none; b=pCspTfIEeghDnhf3e+YLuSA8YblTDXMqXlzyT29DPyjE0UHo2r0hSjfSHZFxnVTFFOdlbUkQ/qrVLgO6Zn73+lx4jnu7z/HRrtQxbxVXYNSQUpcZA7oH/n3JuT7caxLVNWyLCZorGxPdl52YdAnXNXm8fZxXDN1ntWmE5Ftjx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764845745; c=relaxed/simple;
	bh=SgJNoLR6K3fNtJPZOlFwZxsl2xtwua+Et9HkEmnnc8E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XdR4Lm3pyHHOr3Ofda+qcL+gmD9V6pypfmcDEmcdLQq6YI7JHv8Fdtj30fwiFGfGA2U/zXG5wP4zthr9ooLyI2IsCckmXCGa3v2HqCQrXKrgepQzgsbgmz2m6/GHQCUl3h7TDK9OPlFzOMWRTZ2zVhIIyZ72bZSfx0GKg6g9K50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M2JhWHiD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2JhWHiD"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so535208f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 02:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764845739; x=1765450539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7MK1DoZ8jdaWVf6WB3pp5Ox5xAT5z0hNR1E+xIMlTlc=;
        b=M2JhWHiDN90koGFzrh5dCJd4POstAJv7UXshzK0bLd0R9lqGOTyUCOUKGJWW+LCSCB
         EELX7nC19dA/HRBkWgBYxBwN9AsWqiL+/KXL/dHyaeT7a7psrvRvb/v9/YTD2rGU9NYL
         hdsD2tCzxW2dccYDU63g8+FiWZurSblHDMMhaswDCWoIrgXOzrkSch04A1HLtvQ758fQ
         63RshHBv5ysHYD7KA7Df0tMnFLgauF2QKG8BXFCZ+qGHOQyryGoz/baQUHoADWbW/vD3
         3NGSKwmgvewDyVdjLMA7dsZZuFFlCW1Q1m/5UKjsKiNj5m4GDWW4/+UIkzBmCv7Et60P
         xhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764845739; x=1765450539;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MK1DoZ8jdaWVf6WB3pp5Ox5xAT5z0hNR1E+xIMlTlc=;
        b=nFF8Hzutm2QBTYflDi8w56hzwpS3LV8VU3rW+gCyouqagsELyxv9jokQJety8r6BcI
         EB9fqVZzyWwTGGc6/soURD1xgl4D/gIMgx5Tym5wlBtQUGjjZzfdEyG6DYmkkt5ATcjY
         Trv/C6YItVLMUw28DmHw6JpGlO3PvBQKQDIkB3c/QsPY5JiLCVf7dDIWedSQmrPuP52L
         XGXuzNfhsWUNZN32QokaORrv+FIfyv4zA5ENU+jzTCsXgdX0kzqudCRcXbscyMOtZcMF
         iDNovrbfHdGhD8Xci+19kFo7UCCakyiCZsfIeYcTS1TyYDDffQJnCrKFwOYt5khJMvyo
         Q3rA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5JwH3508vxwSL51cjHx6twFZ9afUWJ58fmT1eTbKGG0pcDsCUosgvYbS+85e64uuMom+j5UV3nf6unP04bvT@vger.kernel.org
X-Gm-Message-State: AOJu0YySC/p8jq3hYTANll614pkAPYJp2J0RiD8yAaHUFSjwdA7lC8jD
	dDLmJQcNOZ4bsGiPvmz32o2yqCd6I+A9lxp+R7LCFwBdMBIbADUGqMy/12yMS6jEwbc=
X-Gm-Gg: ASbGncvqKSxu8Fd09z6KTLv86xp6MnDebjUk/zmG19eoSC6qjz7mx2pqCywclmhYzDn
	srYTcr/U7Gf8z4BDWcyzI0AKV8T3NkDjrTLgFLsOHXmRG5Q6HobmMYhIB6wSBOJf8gSdI6dDVVF
	FKahSaU9yk3pNKKqtKccbTV1589dZ9wOISdgS+Lmj9drMcP4w8w2ek4cs0jwrxe9y9CXTSMCr4L
	v0ydqpbTZlJ8dE92tx6JEELHYF1VRcssUPvPpsX9xCZCDIJ+JT9RJfxAHtPxh9lbdAZRnXQDhIK
	0qaJxl7UmRRRjEqOGa7keilhH3LyEmPxjp78MiKNWYe4wDQ3lasx3o/bib+m1wKwAX0z2VB8egk
	uTh7j+KOAk9KERdsh2uDhx7mFlWgjx7hJ+8aNCxdDjTPYyppuAO/D3T4MBpOMxlVfCVWteXYYX0
	ZuEdzYVReb5M7cGnjoYh4jxFIjSlk=
X-Google-Smtp-Source: AGHT+IF/hw6YXo0ND/050KonkHRNTrdsi5Huu1bqezplzyoJWuA2V3KAYQIym/bIYa2FHGR7FnQb1A==
X-Received: by 2002:a05:6000:4029:b0:429:b8e2:1064 with SMTP id ffacd0b85a97d-42f731c3147mr5483314f8f.47.1764845739098;
        Thu, 04 Dec 2025 02:55:39 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbff320sm2520602f8f.18.2025.12.04.02.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 02:55:38 -0800 (PST)
Message-ID: <96c54895-cebe-4247-86e6-d41b8be0dd40@linaro.org>
Date: Thu, 4 Dec 2025 10:55:37 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] perf cs-etm: Don't use hard coded config bits when
 setting up ETMCR
From: James Clark <james.clark@linaro.org>
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
 <20251201-james-perf-config-bits-v1-4-22ecbbf8007c@linaro.org>
 <20251202114300.GV724103@e132581.arm.com>
 <53b24702-eb3b-4e08-bca3-70402eaf4db5@linaro.org>
Content-Language: en-US
In-Reply-To: <53b24702-eb3b-4e08-bca3-70402eaf4db5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/12/2025 11:53 am, James Clark wrote:
> 
> 
> On 02/12/2025 11:43 am, Leo Yan wrote:
>> On Mon, Dec 01, 2025 at 04:41:07PM +0000, Coresight ML wrote:
>>
>> [...]
>>
>>> @@ -746,7 +779,7 @@ static void cs_etm_get_metadata(struct perf_cpu 
>>> cpu, u32 *offset,
>>>       case CS_ETMV3:
>>>           magic = __perf_cs_etmv3_magic;
>>>           /* Get configuration register */
>>> -        info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
>>> +        info->priv[*offset + CS_ETM_ETMCR] = cs_etm_guess_etmcr(itr);
>>
>> I still think cs_etm_get_config() is better than cs_etm_guess_etmcr().
>>
>> For ETMv3, we directly pass CONFIG to the kernel, and after validation
>> in the dirver, then the value will be set to ETMCR.  If we already know
>> the config value is consistent between user space and kernel, why

One other note is that since moving the timestamp field, this is no 
longer true either. The value in attr.config isn't directly put into ETMCR.

>> introduce a redundant "guess" operation here?
>>
>> Thanks,
>> Leo
> 
> Because userspace doesn't always come up with the same value as the 
> driver. For example right now in ETM3, ETMCR_RETURN_STACK isn't set 
> depending on certain conditions that userspace doesn't know about.  ETM4 
> has the same for TRCCONFIGR_RS and maybe some others. In the future, 
> other versions of the driver could do different things as long as we 
> don't break decoding.
> 
> I didn't want the function name to imply it was doing something it 
> wasn't as that confused me a little bit. It's definitely not "getting" 
> the value. Maybe "guess" isn't the best it could be, but it's not far off.
> 

