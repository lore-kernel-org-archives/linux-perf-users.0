Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC713CA9C
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738077355; cv=none; b=LQsb5ZgGTFLwBrmcMqvjAlGydoQNTpkAv7+N9siJXQrsP6qGPhsPNhLKal6ZXVYXXx/iSTqLhFQL2QGra6pi7XU4TvGbz5nmszERkTeIdKLyXvMYFrnRwzKui8Cl66cLeCln1R4LD9mfafJsNoeLIH/z/LG/je6i0euG66R5z0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738077355; c=relaxed/simple;
	bh=K2Hx99CcFI9dIj7GC+57+fOXGnUZN65FfLITcyiDqnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r66zAd2YD0fnR8UxY/yfhLe6ntkmo7+Vks+ayiG1AqqLEimVq8uU9aW4aUW9dnOpaTWXqexK3XAtr0V8+VfCARK6EL1ADH1om87JXl6Lu3bQOXD+BYvbNOBD6LQESiwwHrhYwACksLS85FxCU+spCEExVF5UkXHWxHXdBL70a18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R5KNFlWM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5KNFlWM"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso4892254f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 07:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738077351; x=1738682151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywYHuxnMna7xm4ppsrDWpokktXITsnMjE2rChUegtoI=;
        b=R5KNFlWMpApfZjttCJI2aC17HqZ1YgQnQsaTOkYRwBMdsXz0kioaL0nV3DJUTqNhb+
         h6YKJKUob5Ce7Diy5TtYlrGgllAidAlS6AjPy/ZljzZ5nsjWVAk52Pe3G6FTOjg8Cbee
         vdzmh9EgT4PLVNZYiL8XGcc+wrQ701Erl7ZkG1Q7RiJHPdpSxwsOYHDubOmq2W8v5Sb3
         i6nRCl2UBx/FDQegBzLm0egspC04n7Xg09jvlmnIC1C+wSnygQUe+l04FIcQhZz1W38f
         LzvPJv9CDjclugbrw3uq1lvxs9/97NhXNkzHxXfySRucWNxZsVTleBVNFYSqDgoZ38d1
         Elxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738077351; x=1738682151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywYHuxnMna7xm4ppsrDWpokktXITsnMjE2rChUegtoI=;
        b=rS6zM80f0ICk9j/uhFw/CKTSRwbjyO7XC8bqNaKbCNrdnWCIV1BZqHSFOBzC/Z8l29
         ZmkT3IDQNgmk9rUwFyOKhBixsWhJ6EuVyOjoYJII4AmONC5pDsBFNnG/z+j8Vfkcnw6F
         msXbxzuDCtxDy1j8sO1hHf9yUHER+iYX622iprsJviKna0w1x0cVOIzUD4iE4YT3rhjo
         Cy3jRpAodFdNpA4HB0TycmWXiyuovGhSXgUbJuzxhmUtweM5zJk3oavURjdkr93dTCO+
         mY9TXP7yMbtJD0fO4paMOTaCYQEDZ66S8kWk81Qq1Yg+hRYjKrbYCh1rC0M6mmgTZ9ZM
         U9HA==
X-Forwarded-Encrypted: i=1; AJvYcCVLFVV1+ph8eYvue84qUKPi9WUiwU7VOvyoU4tn2AEGLo4kCu08pce/DfsR84c9haoJIuaME60ozNnXGgHEh0Hh@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVLRbldZXFLRqOQxWYQ8OCOjQO0rK7t1z+1ZFsEPCCgtnRYPm
	VwzgNSjIFv5kXJ31w6pheAwNssy/vitJGo83tsplgS6qkogbjaQtUrKSNAwGKFs=
X-Gm-Gg: ASbGncsocP9L0NmRT0li7UoGAjgP/l1XWJOtI4OvQ2YW1F7eFqWMcYdRyEwKYH5R3n9
	mFj4Z207SDAiWGJ5ACkXR2yD1w83cv7eDZy25OcE218V9Ylqwq7iCwWOXTLcpu/5zjUN23ADCAE
	9wGPlYfKG0gUX3+BLlwjI+VGxQm4lIVAGi5xwAjlp8s+F/k9cC7WIk1CIHw5RtAkt1f0PiGyLhZ
	8FSVgdWkl+y3johMmUiQn6H06EVx4hxuGKYSNsNN79cSm0is1nhptfZuprseGuhXS+shg1EuDdv
	NPuLH4afzNnGWMJe3Yxn8/7pvw==
X-Google-Smtp-Source: AGHT+IH4z6kGurXATCKEu5ud/q+c2m93fPVTD9d33Dd3DLAcC3xY+W/ex14qigV92/YLPqqKXzLolQ==
X-Received: by 2002:adf:f504:0:b0:38a:888c:a727 with SMTP id ffacd0b85a97d-38bf566f958mr36476931f8f.25.1738077351579;
        Tue, 28 Jan 2025 07:15:51 -0800 (PST)
Received: from [192.168.68.163] ([145.224.65.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bbb39sm14505781f8f.65.2025.01.28.07.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 07:15:51 -0800 (PST)
Message-ID: <2ca00f73-0746-403b-ab5a-344182ba8b80@linaro.org>
Date: Tue, 28 Jan 2025 15:15:50 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Fix perf test 114 perf record test for s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
References: <20250128150307.1129522-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250128150307.1129522-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/01/2025 3:03 pm, Thomas Richter wrote:
> On s390 the event instructions can not be used for recording.
> This event is only supported by perf stat.
> Skip all tests which use perf record -e instruction ....
> 
> Cc: James Clark <james.clark@linaro.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>   tools/perf/tests/shell/record.sh | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 0fc7a909ae9b..297d0e459875 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -287,11 +287,15 @@ test_precise_max() {
>       return
>     fi
>     # On AMD, cycles and instructions events are treated differently
> -  if ! perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/null
> +  # On s390 event instructions can not be used for recording
> +  if [ $(uname -m) != s390x ]
>     then
> -    echo "precise_max attribute [Failed instructions:P event]"
> -    err=1
> -    return
> +    if ! perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/null
> +    then
> +      echo "precise_max attribute [Failed instructions:P event]"
> +      err=1
> +      return
> +    fi
>     fi
>     echo "precise_max attribute test [Success]"
>   }
> @@ -307,7 +311,8 @@ test_system_wide
>   test_workload
>   test_branch_counter
>   test_cgroup
> -test_leader_sampling
> +# On s390 event instructions can not be used for recording
> +[ $(uname -m) != s390x ] && test_leader_sampling

Is this a fix for 180fd0c1eac7 ("perf tests: Make leader sampling test 
work without branch event")? If so sorry for the breakage.

Can you change it to cycles instead of instructions? The actual event 
didn't seem to be important for the test. I see there is a perf record 
-e cycles for test_precise_max() so I'm assuming that works for s390 as 
it isn't conditional.


>   test_topdown_leader_sampling
>   test_precise_max
>   

