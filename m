Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430D2E8882
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802089; cv=none; b=A+UdeO2xTjV7qnIcq3fY2Rb6w1fe6J05KgHq5fBcyRQnBhO7guFD03LYR3ljsSIF0wsIhHHAn2Ik8JOfwt1GyQfJ07rbLizCtNKnfXWysz3krGB8uLuBE8PPB29nmjnGeZHKA0JTKiGOEs8ZCW8mQz/XCBvbuKjqLuisBXbCUlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802089; c=relaxed/simple;
	bh=9vXHwpFBLID5YqZonK+Nr6AaGb+ZbZcd5/Z+RsS8dJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rp+Tc33FaskorLFVnMLKeOXO/Wi6IhLzMdY8XPm/QVM5oc7OhDC3FnImH8RNS0S9Yl8LM+WsZq9hH90catYQXu0Ip2Dw0hvZdGkjf7oL3Y4ULRQ1o+XA1PwU4dh3lJC/+yMqWKeRpAO2kD9o/CavVTjs9jgSijGIu/vVgpKhZwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qprj06Qm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qprj06Qm"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439c5b40f60so2674827f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 05:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772802086; x=1773406886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZPTd9XqPxo27WQA3KpO9Gn9NiuPxcGYqc9Rn0MTrsQ=;
        b=qprj06QmHJ01KGSCd+hr1XK6CHozSiNMhKFb7CIsfJi7ePeXKY1fAS8AR4OtWEmy1S
         QIWlerJgo86FDQJHuFaU0M+OxCFnFWB/ZUEGVlWy9GsLg7HDfuTgSWni2zGbuPRfuUw+
         eoIZEyya4xoP7mvCPbZzIGVhA14ZS5Ry1aFc1cfscRHpWMW7s/UR4/A/vNSZxOY/iZf5
         g6mtJPG8hRU81tx6ZvaqLgEhzzu/YZk9zyoFrEVpUbJHtgIj8Ko4RxkxHuut9Pq2Tfm5
         wbM7UQk3OuDOB2fehZ2Af/qfavwAelUMPp+FCYSvamV922Ed02cHJacYn4Mwv/NzXElH
         5GJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772802086; x=1773406886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZPTd9XqPxo27WQA3KpO9Gn9NiuPxcGYqc9Rn0MTrsQ=;
        b=QqSvTyKUAywV+NiYfh/e75juEqPGmuA/CJybAwil3/flumWEZg9WvC0NdbAcvj6/Fd
         2C0LaBkfT0+xKJEwD+xdBdI+LJw1lLy8fCNqr0C1OMo63NVH+vOtWFI9xuA7jeN+AV5k
         tIj7CYBFc+0dIEi1ar4uALGAsGyuY/iSTjV2FeeeRb2Mj6aKC69TvOquso3HwaW7wzl1
         vTCWrtp9bMqlMfy3oYohO678OxHp3OSIUuPptumJFCIuMr878SainLBZg9WLKMJ5YAPm
         0c8Ef9Eh6paVAtQPY9w7Sz5Fu4yynPnGu8ocuLVEOnWnR41pEARpjj3MvqePiYRb3qPk
         vyZg==
X-Forwarded-Encrypted: i=1; AJvYcCXMci3MkBdN53Hv0xx0B+xJCLAIZ6a1C9rDUOsDW352P2YBDsCoshrTNrGtq49wrWFjPdz5BZvhoiXEwC2/F80j@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqwlQJx69mP9PIiFWEfZ24iRvcBwIB6m+XUg2E0hm0PixkfTY
	w7Z7woIx5hGC9m1ZDuTJBdNOSVmPYWEPOF+5LGqm84BxLmDWUJlNux+i2QMrPMHVyF0=
X-Gm-Gg: ATEYQzx+sktITx721c3Mdxba3dM9jIGPev8zB4lsioWBylDHl4+e7xYUgViWZpBVgoe
	Qf9kZSoJBgjQ7IWXAo1fMvFNUCWp51xmyj8myIodZiLAq2v6e4czk3bwMTf9Tg4zrO1tk50Cabr
	RkfIyyJKkwCRJ9ng0oYr0HMr6m95c8ki6ze7uhsBw3W7t7QzLVhRBo6h6rtNVjVncDvJnJo2MBs
	q3iUpFAjHy7Z35hF8felam5W4KtSRbFZ1EOpkAf3+GfpF//P8lUXS6GlWMZHNysOH8fhQcIOqiW
	F4UCy6vnTJoHOBu3KA/gxoz9fn/1QWi7MhsQqzqBORjGO2ZFZ0Tgmr6WImYNsYIHv7Ixa8OJyXg
	7TLdZGdURuptYCfMB6hqjVUXqrTbajP8Llkgfw8bETXLVNFEAgWa6dKM8dIMd7u5/eJTaymLJ0F
	CGq/SbjC18nCUXA4GDrmOJr8WGwKoP
X-Received: by 2002:a05:6000:2913:b0:439:af0e:57a8 with SMTP id ffacd0b85a97d-439da669bcdmr3404575f8f.33.1772802086227;
        Fri, 06 Mar 2026 05:01:26 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3a20fsm4090161f8f.28.2026.03.06.05.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 05:01:25 -0800 (PST)
Message-ID: <0be8ed2c-9305-49e6-a315-bdfc15af70d6@linaro.org>
Date: Fri, 6 Mar 2026 13:01:24 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf cs-etm: Finish removal of ETM_OPT_*
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260306-james-perf-remove-etm_opt-v1-0-03c662380361@linaro.org>
 <20260306-james-perf-remove-etm_opt-v1-1-03c662380361@linaro.org>
 <20260306122729.GL1098637@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260306122729.GL1098637@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/2026 12:27 pm, Leo Yan wrote:
> On Fri, Mar 06, 2026 at 11:24:45AM +0000, Coresight ML wrote:
> 
> [...]
> 
>> -static int cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm)
>> +static void cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm,
>> +					    u64 *metadata)
> 
> nitpick: here it can avoid a new argument "metadata", directly retrieve
> from etm->metadata[0].  Otherwise, LGTM.

Oh yeah, I thought it wasn't assigned yet but it is.

