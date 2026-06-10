Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA23A7F45
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085105; cv=none; b=swFSA8Fwh26l8/mkl8n/Vh6rFzS9QtF5JT5M3ebbNR4MMFKBamBcOXvf8Zrq3iWg0kE+HulNQQLMEIIwB+tDCH1xq5EKEUJnypJLm6eQQdLoZFMCHxb7+1MYiYgj48woeFRXykgwoEfYmEdwtyAmDZ9LVlE2zgMGiRpAF3NOAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085105; c=relaxed/simple;
	bh=lh1Ikphh71kLsaqo+RB9uN5BRFBkU6LXv8hYNM0ga1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlaLuyR00SWYI+I0i0ijBJKEDF68wyuLxS97zZLPl8SnI//ty2vmvfZYyLd1cqVhTu8+fEXm5YUSAMzjYuhWkiLfvU0GdbVrG2vHBjMwLahx2G5jZxMgW132CvnVD7oYb8EaQSJuVsHZ0/KQwlfrE8fx3Oi4OIZiLRBk8xOu/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQ9hwr7+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQ9hwr7+"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-befd83e0521so1367808766b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781085102; x=1781689902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHbnGh+BqiBnA9Mcc53GSrSwcIKZVMjyTcPSIk+kGpc=;
        b=bQ9hwr7+u2FBzwf4UJkpEYrp5/HqFOUgWXM3+r3TTlZ4Y1WWDTW0J9TYr6PUGhV1Bc
         3MYDHT2LCivtTAMKuY0cQPfYZfFmPDVkaAoRXVcZhqhTRssubbNjOYxex4OoSh2haEVs
         sH0NWlwD+k3OjO+YszpfsdrJU3N47wQwkAZSvYozQpvEz10nm1s+EP2eUkw2EBGRRSRH
         ZjPt8wlV326wq9SXbFZ6DbLCL/C1Z2+pwiipgDmM9Upoo4M2OEyRQlKjQPAp5qqLjMkA
         dpAyKtx/lbbceoueS7ZJzpApbt0gbSFFKqsmwUwrjTT7r/+M6ayWZ9+5SfeDmhp4R/5c
         m42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781085102; x=1781689902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHbnGh+BqiBnA9Mcc53GSrSwcIKZVMjyTcPSIk+kGpc=;
        b=UO2vtBQmCk0GBNBV+PbdXEbXoPJASZjqdjXQtXiCC6RknT+QrljMjtZzMbQWE1Tu6Z
         dUXZBHZjDK5HjeQFln/2lciPlMCFabLb6PvcyVGE9kHWEQv23JxaFJReoobtpywe9ESp
         uNDuFL3epLQYWEGKR9DBujkC3J+GloxF2g+2gjIPrKG8hruJeZ1q0mTmlFw9E8eiqrXr
         zaZ4lD9MXqa10nl8cnJqu8jOI07ns6ymzv+8BwZ1F1sTvU1xMW16aiCneqfZjezpWOSI
         FcP485IajBnDQ4T36Boq0F0RLqxKlrxUHAC9yIId2iWlZiNCy7+ZulnbDstQZL4Hohf9
         7GHQ==
X-Gm-Message-State: AOJu0YyhkutbBXbmT0hXHX0+lrvkMsysk41mioLskdbiMJNbFaPW9jzn
	mFnDvy+AH1ZXwSnsW0GMGR+6C4F9KPljX9iyG7rjscw1Rdf6fKz4oXxVLsYDgJlYUJg=
X-Gm-Gg: Acq92OEj+CR03KDRpv1cL4hCvNxsowqucUUUR7+l31oodxHKcNAvx9LrY6kqBj8ryDb
	Rog7ECUjfoiYqX1oux9vVuEILKqHqAxveOxoA7s37GvzXUksU7HEaQlF5wJeEKjJBNozae1XISt
	kE1e/lXwd32p+RmrdGmiKSmyeflLFzHV4Ps2KnjK9XuPXThDTmQKvT92hiAzGtMJYciXKH5m+Qg
	sP3m8gUJkSDldaIAF7MKeAXpcn8Gly0XLtfdMWFEPM6xBxVGYzR0xNXeh4jvZkMZmaoVO4GX8TK
	CZbqbWdKTR3Mli/ddUxRS7VhUTpLveArdSkuYIcApO2fU1h92Z8yKqq1tubYonJPAtPYfFVa/PY
	eQsubTZ1ESB85z9A+RRfP/Tpi6HfkYQUQS/7rSrKnRK/IAIniV8YoZSRtOwxlbtck2ltcf2Cvcx
	HqGjn0OnVgVZTV2IYCwlDSkP7NnmCM8Me7cylQ91Y=
X-Received: by 2002:a17:907:8d8e:b0:bed:15ff:5fe2 with SMTP id a640c23a62f3a-bf3a8c05094mr1004109666b.17.1781085101938;
        Wed, 10 Jun 2026 02:51:41 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051d86f75sm1162420366b.21.2026.06.10.02.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 02:51:41 -0700 (PDT)
Message-ID: <321352cd-8c6b-4ada-b9e0-f58aaa7e0984@linaro.org>
Date: Wed, 10 Jun 2026 10:51:40 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/19] perf test cs-etm: Test process attribution
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260609-james-cs-context-tracking-fix-v4-4-44f9fb9e5c42@linaro.org>
 <20260609144127.210E31F00893@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260609144127.210E31F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/06/2026 3:41 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The test script hardcodes CPU 0 for recording and pinning, causing false test failures on systems where CPU 0 is offlined or lacks a CoreSight ETM.
> --
> 
> commit c50b8d82ea4d5dd7b4d85c01619bc432a03ea379
> Author: James Clark <james.clark@linaro.org>
> 
> perf test cs-etm: Test process attribution
> 
> This commit adds a test to verify that CoreSight context switch workload
> traces attribute symbols to the correct process when traced on a single CPU.
> 
>> diff --git a/tools/perf/tests/shell/coresight/context_switch_thread.sh b/tools/perf/tests/shell/coresight/context_switch_thread.sh
>> new file mode 100755
>> index 0000000000000..2b9c44b86c591
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/context_switch_thread.sh
> [ ... ]
>> +cf="$tmpdir/ctl"
>> +af="$tmpdir/ack"
>> +mkfifo "$cf" "$af"
>> +
>> +# Pin to one CPU so the two threads alternate running but record into the same
>> +# trace buffer. Start disabled and use the control FIFO to only record the
>> +# workload and not startup.
>> +perf record -o "$tmpdir/data" -e cs_etm/timestamp=0/u -C 0 -D -1 --control fifo:"$cf","$af" -- \
>> +	taskset --cpu-list 0 perf test --record-ctl fifo:"$cf","$af" \
>> +	-w context_switch_loop > /dev/null 2>&1
> 
> [Severity: Medium]
> Will this test fail on systems where CPU 0 lacks a CoreSight ETM or is
> currently offlined?
> 
> On some ARM architectures, ETMs are not guaranteed to be present on all CPUs.
> Could we dynamically discover a CPU with an ETM via the sysfs event_source
> devices instead of hardcoding CPU 0 for the record and taskset commands?
> 
> [ ... ]
> 

Not worth the complexity. If it becomes a problem we can add it.

