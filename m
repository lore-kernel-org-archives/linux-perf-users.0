Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D923E16BB
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503094; cv=none; b=YonW7dpg0dd/lDM/1MP0w6QB31V+PeUfhvMkk8atXpW+2LwCsQkfQP5zwqjdQrZWvNmijKiDluMheyOjkAHjdBCbdehC/e28H076JJEnE5Rb5sp3pBn9dC1tMsTejo9Ht1rJdUdZVe+8tWz9vmVF22S2cIdFVgHwcU4HA6j8BOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503094; c=relaxed/simple;
	bh=QrEgHVX4ffhJFB1JpGLYul4XC04Y8ZkjwVyIj8YGu7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFFj/xEw9qwhVos9dZAtVwzZezAZIbamn+ywgGdtnP3jefTvmEOBT9pqTi/jYVZC1lOY8bHxI4YksJtzH/t/zSsCcCLrv4lQodCtPj4nNVB38C1+hh+Clp7hdcpBR00OJvMMDtEQXpUuebDV3AUE+x364VSd4kd5Flx/I1vGcmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HnwoYy5F; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnwoYy5F"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so14512805e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 09:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780503091; x=1781107891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqzEpLZhbsJNsiLYofbVYCw/MWIHevffPJ5dCvGAQKM=;
        b=HnwoYy5Fg9t2UDJoe2h2ZC745TCjvslE/umYeI2vMJ3Gi8KInFQDaoqLNQUs74Qrey
         S1KOG6Vi3//1duL95lMu67C2BvuLRl/cl0CQr/ZkjZ3XRutSEgGRnsOpeBSDK8xZNVuO
         RA9go2/HB+OdMR1NAzIzfRUEw0DLuh4d2aV02dUFti5V3aasOn/zHA5ol2/17e7b3iqF
         3Pyigr0GUr/Kk0lqWOhVRh5Vdew1o/XaJ/lCG8lhqe3Gy75B0pnhsOy41eRx/j+WxGJc
         LUHmcuQK8CrA1xXuqzvrw8Ka97GIukRdiE7zXueG5W24Ef4pwa4SABv6XWKJpUnmeU0j
         jpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780503091; x=1781107891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqzEpLZhbsJNsiLYofbVYCw/MWIHevffPJ5dCvGAQKM=;
        b=ltK8H3RjOw3Vyx8hYBbG12+vY9mN+c57/nR4UXke+DApZCJsdWBY4f92G33SHHuTTM
         t8zyy9hFZZmSDtADgT0jEYS1wrMRpU9kUeHO8FZ6Qe1EZ6klRdzs8q9tcar0z93mT/ce
         /E3xs2knYW2LqUP3U2+OxCMLAAcDK2ECStnOE+7/KhHaEZfN/35MWFmpbq4VIcjN7thT
         kfrODMRQwWUFTN/j9dOC33tkcPlZ/Ov+XoOpFbE4Mh/4lULrg6N8HynARmP20O5CUNYk
         je3zb61RRQq+Bvsb3qlFfcZPex3rI3XfDFL9EIFwqljUPuiPYZ6mNWoj99j6w7o5QZ6E
         /Lmg==
X-Forwarded-Encrypted: i=1; AFNElJ8nUnBxHLRU0RNzejHQKklmPIJ5hrjg76YFW8btQXy6dvWnTC4DDQi58Z1njOIj1+HWCxYHURq8yxPwxe+blS80@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2Pb7+4206Rr9hnG0TJT4YJslrlFdzJrytGEvurH0AVlEz1Lc
	YxwYljGS5IXkjpD28U9KOnAnCjIW1qWRroTN1757l4II+/MTlPwfmfdsLbNlqzcKhSg=
X-Gm-Gg: Acq92OEIF2lw+pTsr+ioeG4pn9Id/CI/IpzWf7J4B72sK4lSQP1nomXpRkAxjibShnu
	J6ttxRNg8o+5Ewarlz9p2+F8FgXOFRT6MtgMIrCHyt/x8k8t+oqEJnjJWuFpDTOgrABITNYWVpU
	245rR92FHmDLG8Phe/siWyZ+DlrDA1rgv6zbDxkMTaU7GXDRRUp3UzuxTZ5LW2tsbJs8d0MgDfu
	vR0FgvsfdQpk3oW8cze96H+eOQNgCrlux8xNs44rJbQ/TrMyDCCHnCmhXfr4QGrOVNvDCeEZQoQ
	8Q5PGTCd451YPsETl+Xie86DHD+d1awa/PKSuCKNPwRukXVIwYWirKATEbi4lgQY4c2u1AZtQQ9
	wHeIKYKjWlMuzw4ln14FxR6eEw+v0qOYrp0CjxEwNNhhWe3udC0vL/qyNo9JDnT+b5I5qWBS1k9
	UjWYaFQRvVpp4imf2pkBE7z9wau9WBBt3q/K6vvIS3yHszg2DoUQ==
X-Received: by 2002:a05:600c:3e0a:b0:490:b4cb:3845 with SMTP id 5b1f17b1804b1-490b5d48800mr79915015e9.0.1780503091650;
        Wed, 03 Jun 2026 09:11:31 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc412sm9011742f8f.4.2026.06.03.09.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 09:11:31 -0700 (PDT)
Message-ID: <882922c0-042a-4108-bc2f-cec443d0db9f@linaro.org>
Date: Wed, 3 Jun 2026 17:11:30 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/18] perf test cs-etm: Replace memcpy test with raw
 dump stress test
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-8-85b5ce6f55c6@linaro.org>
 <20260603143622.GX101133@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603143622.GX101133@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 3:36 pm, Leo Yan wrote:
> On Tue, Jun 02, 2026 at 03:26:50PM +0100, James Clark wrote:
> 
> [...]
> 
>> +# Use exit snapshot to record 2M of trace to make about 80MB of raw dump data.
>> +echo "Recording..."
>> +perf record -e cs_etm/timestamp=0/u -m,2M -Se -o "$tmpdir/data" -- \
>> +	perf test -w brstack 20000 > /dev/null 2>&1
> 
> ...
> 
>> +size=$(stat -c%s "$tmpdir/rawdump")
>> +if [ $size -gt $((50 * 1024 * 1024)) ]; then
>> +	echo "PASS: Raw dump file is larger than 50MB"
>> +	cleanup
>> +	exit 0
>> +fi
> 
> I am not sure how we can map 2MiB trace data to 50MiB+ raw dump.  This

Why not? Decoding it is roughly equal to decompressing it, and with that 
amount of trace the small differences in compressibility average out and 
you do get the same amount every time. I think if we got less than half 
the amount expected then it would be worth investigating.

> is not to verify perf stuffs but just expect how verbose output from
> decoder.
> 
> Can we simply verify the trace data is ~2MiB with the command:
> 
>    perf report -D | grep ". ... CoreSight .* Trace data: size .* bytes"
> 
> We might relax the check as the trace size >= 90% * 2MiB
> 
> Thanks,
> Leo

That would work, but that wouldn't be as thorough. The first thing it 
prints is " CoreSight .* Trace data: size .* bytes". If it stops working 
half way through or prints nothing then the test will still pass.

The reason I wanted to add a stress test is because all of the other 
tests have been reduced to just a few kb of trace so we have nothing 
that opens a file with a more reasonable amount of data.

I suppose with your suggestion we'd still check the exit code, but 
that's about it.

