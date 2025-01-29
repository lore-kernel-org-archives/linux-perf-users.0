Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE71AF0AE
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738144668; cv=none; b=lXGrPg8IWsDT6uSaa6gvBilcjD3MEVJRZDsqYcu24ajLZjFy+jObAOgHgDPX/ivxKBHmUx+Dw1gxxsdPanQZeV2bvqFPlS+sAI0uWUbTADoxWlWXRdFbzkSn0OxuYkxU9AP/or0Spjef+wZyG5hB8MV+F6CbpiH9CUo9Iga+dhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738144668; c=relaxed/simple;
	bh=sF3a3MmpJkmKfa7YDAal0Qfevb6ndMAhSaQSz5xFZ28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFfbcAhehADdfswI8FMKfJZVZ4hwLBNSn1jJ9rhKLwu+uV3pkGY6Bg0+Wo7QB+JKUg1ddbMH1nr2/Z0IBI+T/89bbxFDvAnIUEJLLNYpcFYZfM+mdE8e0RfUuIgLJ1KHsJZXvU7zGcJwfemI9HYFaH1uaRbBcgJV5fS4PTntDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kgCf9mzi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgCf9mzi"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so5835066f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 01:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738144665; x=1738749465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Va/4yn7qxN3lyHQJiuwRq4M3qGKIKzwIp7KlwTmp0Ic=;
        b=kgCf9mzie3Cq1gSa90c89Q1+8Yr+Q7+Q7LKtdRCW8qoLol+izw2yZzb0AhXFBsDIzc
         96E1o66K1a94gpP2Gv0w833ZCT0yGo8s9TCRgfZoTajPnEg++IDDq+fFkVeNoCK+pY1O
         /CYkearO+2h/HfNYfyjOdNDBda3nAh6xP8HzhKrfwCFfj72IJ7g5cTJVWeTDEG3hJaQ7
         d2UdXv5oKUkje3QyhjwrYE86mOMaEbwv0Fg02EJ8h54rxX19e/hNXaEJkb6tB6KXyyhv
         smowb47SVtJy6dCsqqwVE0tIpkE19K5SX0t3QlR72vz4jbDG1O9ADgcsA3CgIa4FPnqK
         iziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738144665; x=1738749465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Va/4yn7qxN3lyHQJiuwRq4M3qGKIKzwIp7KlwTmp0Ic=;
        b=BpGjch+JoVL3GbVAr6jleJSj3LKUUUNGyIWREXUWjCeUYcKad4jqQT7xAiTUFFL2nW
         MztgtrOJa+JTVCfkCLLgIw20MwpuTKu+NSX5wUMpuTWvtGbpHzAFvj8P+7e7+k0Eehr2
         IkdyTQ7sl22Qm07M81WUEX10rIswdBALklRsOIrawSGiABYxa96dgGF0wjJH+OpC/3T4
         bSrgBFfw9W4WrckN2NfVgHKjiw33p8tTpwO0eABmw91ixWEbigv2AAJM2gmVggO/tJwu
         B/u7V/gqzyPH7cFvIAF/cA0lUqI+koVKkJQfEyCcmeNn9/RdLgHw+0GViIkmhAOXDQbD
         7Jrw==
X-Forwarded-Encrypted: i=1; AJvYcCU7VkTeY5nO0e6cQzSK0bqrSOpshvKmptCzS4TdZw+1D1zwwkSNnhJXcvea8GoTSQmmAAkByfI8KIM8w7vb943F@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSeVQ3BiUdnLpyU5RK6XSbZwRmaKMBqNVsgnmtT7CY1iaMG4v
	e85n5XSwzkn5DEBwCqvRRfFwScYw3SlrAHLE7e7AMcbDQbMt5jpzDn/CJazmG+4da4Z0d1JuErm
	E
X-Gm-Gg: ASbGnctbxge769CmbgJDbabC7+4A+deSpx5bE8lF0G1QqU8vdDWVradInqnQCK6Q4pJ
	RqNPuBhK3QKWH+AG5gHxdoCv3CqXfR5ARn7aGUTvPxi5lNKyBvgWAl+5jKrsGcSdIwYNU6eaaA6
	aSbNzN9R3FCZ2L6Z6ZEI2Fwx1G0rwO4YUqEQ2hMYsCIfFXC6e5qZTZPiKowYvdZcc1ZylLlWIgz
	/lXdm+krPczKj+RnSeHZh8hxH0KYqGSXyXvcf+THEX0INuqPPTyigf/mryeIc5I7eZDF0f82eDU
	EYrYVMIGae9H0tRgXY/i8IC/kQ==
X-Google-Smtp-Source: AGHT+IEE5KvaQHYRNzVduRzwiae+l/7H1l5j+DNWtteY/sILo2Y9A2ZVezD9oiMi4FtJ41HFK50iww==
X-Received: by 2002:a5d:5986:0:b0:385:ec6e:e87a with SMTP id ffacd0b85a97d-38c520904ebmr1920880f8f.43.1738144664649;
        Wed, 29 Jan 2025 01:57:44 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb062sm16536495f8f.71.2025.01.29.01.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 01:57:44 -0800 (PST)
Message-ID: <30865b2c-c58d-4974-9a88-dc13b8ad1195@linaro.org>
Date: Wed, 29 Jan 2025 09:57:42 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] perf test: Fix perf test 114 perf record test
 subtest precise_max for s390
To: Thomas Richter <tmricht@linux.ibm.com>, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org
References: <20250129071134.4024430-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250129071134.4024430-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Is this a v2 of "[PATCH] perf test: Fix perf test 114 perf record test 
for s390"? Or maybe the v2 is a typo?

On 29/01/2025 7:11 am, Thomas Richter wrote:
> On s390 the event instructions can not be used for recording.
> This event is only supported by perf stat.
> 
> Change the event instruction to cycles for subtest test_precise_max
> as suggested by James Clark.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: James Clark <james.clark@linaro.org>
> ---
>   tools/perf/tests/shell/record.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 0fc7a909ae9b..957ee10aff44 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -287,9 +287,9 @@ test_precise_max() {
>       return
>     fi
>     # On AMD, cycles and instructions events are treated differently
> -  if ! perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/null
> +  if ! perf record -o "${perfdata}" -e "cycles:P" true 2> /dev/null

I'm not sure if this is the right fix. Doesn't this make the test test 
cycles:P twice now?

I think the fix is to first test if cycles can be sampled, then test 
cycles:P. Then test if instructions can be sampled, then test 
instructions:P.

At the moment it checks the events with perf stat, and it checks them 
both at the same time. Obviously that doesn't work if an event works for 
perf stat but not perf record. And checking them both at the same time 
doesn't allow for one existing and not the other.

>     then
> -    echo "precise_max attribute [Failed instructions:P event]"
> +    echo "precise_max attribute [Failed cycles:P event]"
>       err=1
>       return
>     fi

