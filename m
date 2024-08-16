Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4EE12E1E9
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798664; cv=none; b=ngKaBGQOefxGr552q8NY/iCwX/6tGXXIq+/4AsSfaVHElBlTczNSHtk1+/sr+CiSSbJ1xgJX3zEPtu0U1T0FRBUAKIqtAnATBf5jyJenw4qg10ddg1oSXLHSTF4eOGK9+RnQK84leX3ndDltiBe4sa6yXBr+DZWpwDfZMf08nlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798664; c=relaxed/simple;
	bh=fETSMc2hQRMfQ2Q133dwwdGv+eoSJjlO71/zUgfQKn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bd4EBsGS2S9dvIhbWi3SkdxkLMts1EyBkXz6ZypGvRrcORTpH2lIzDIiKv+R+FEHUTNEYW/DYjP1jCwQYacOcg2z0gKGyM3VDhgmzIEl8Q13NEUG7xt//qBmLQjNaK7HPFQRhD2k3EiY3GVvo2fA+4nf6gaEY6je5d1OtRzbWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rXn2nUSQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXn2nUSQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e3129851so12636145e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723798661; x=1724403461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pp9E1jzP/7LqcZV9OE83mHHXcT7BGqq4jDbXGUvR/tE=;
        b=rXn2nUSQqmqKpy1Z9/NPWXV4hYgLUVBwmHPzUrJrGWFZ1G7FaTZy3Hcaqba2GXuzEX
         ARJsHSGLBU9IDaAzSc+h4U7FFmQWslTYgHpEGt5pwFx1Wu8PpPuBZ1Chy5fE0ccl+Gi2
         L9TXW9P4BQucz++ASBpNaFhbF6VYrbossASXGxohtB5eIvnrJMbEOuFroxlYUd+Nk0dt
         /t79lgid2wLNv4mDtMYKsEl03qF1NPfS4FFKIOqV+fbrOlOZU09Kli3Wloid39uwF5Sb
         DUJ4bjrzo8M+WCsok2W4bM58CWb/ddxkpo1h6GZDKoI8lJMJxA4wiqVGHZ1kYfAT/o0b
         P0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798661; x=1724403461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pp9E1jzP/7LqcZV9OE83mHHXcT7BGqq4jDbXGUvR/tE=;
        b=PuTlTKEs9S8SxC2drpSPWrOjyFA7bQDCX2KSMGgwOMDHYJTayR0cOj5RrNE6HPpwnA
         zyyaswLVhvpG2/YbF28M50Ig7Cu+Sa2DfJn+tgzCImwAnctrBEQfsOczJxKO86msALI4
         g4NhZVHT4NtmiSEDz4cPZLSd3GpuegNSCd5E0/+J2g75L1isd0+3TjDaUkyGCxvSiGXa
         FMBM9MkoKUzt7RZBA5+P6mWjrMZTH5VPH0GFtyjAI8a2d9sB6aUcax0YWrzDxWoJ4goC
         eOOj8A+OcuGCBmbuIu/K79RuBImgvjjrd36h3wCZhTUPfGkxnjlqsHgHlgr4XQLq64Uc
         fnKg==
X-Forwarded-Encrypted: i=1; AJvYcCWPiAeCxObqZRpDJFaQRQEpI9ogGijweOnSGYc+LEU2M+kKv1D4A3T5gf3DAuFAskVeZANXP3VyjCmqMc/A4gfa/0gcw8zL4enAT8frREhqVA==
X-Gm-Message-State: AOJu0YzxoyuXr2NysX3ZnZP3IZmr/0vsmT93RBFzQ+LIf/ibZWLjILEg
	FNd+DRGfJBS5JA/v7tTtJFhbbuRHfsi0AGY4NoxCwWR98tTjZswlkNgYA2nqN7w=
X-Google-Smtp-Source: AGHT+IGz56bQpjBbGo0uOLNED6Eyr940dKNOhXmrjPU5vtmy0ylGk957l6Yh8SHw3K/Bcwg+P9nRjQ==
X-Received: by 2002:a05:600c:1f90:b0:426:6960:34b0 with SMTP id 5b1f17b1804b1-429ed7bab7fmr13192735e9.14.1723798660662;
        Fri, 16 Aug 2024 01:57:40 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed794640sm16916315e9.41.2024.08.16.01.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 01:57:40 -0700 (PDT)
Message-ID: <88cea92d-98ee-4a1e-8a44-a7c6a247ba2e@linaro.org>
Date: Fri, 16 Aug 2024 09:57:39 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Ian Rogers <irogers@google.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linux perf Profiling <linux-perf-users@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Clark <james.clark@arm.com>, "cc: Marc Zyngier" <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, Asahi Linux <asahi@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me>
 <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
 <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info>
 <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org> <ZrzeRM3ekLl9zp3z@x1>
 <348ea015-eccf-4f44-a332-a1d9d8baf81f@linaro.org> <Zr4eWd6HWLHDcpC9@x1>
 <Zr4kZTxgvD6bmi37@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Zr4kZTxgvD6bmi37@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/08/2024 4:53 pm, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 15, 2024 at 12:27:21PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Thu, Aug 15, 2024 at 04:15:41PM +0100, James Clark wrote:
>>> In one of your investigations here
>>> https://lore.kernel.org/lkml/Zld3dlJHjFMFG02v@x1/ comparing "cycles",
>>> "cpu-cycles" and "cpu_cycles" events on Arm you say only some of them open
>>> events on both core types. I wasn't able to reproduce that on
>>> perf-tools-next (27ac597c0e) or v6.9 (a38297e3fb) for perf record or stat. I
>>> guessed the 6.9 tag because you only mentioned it was on tip and it was 29th
>>> May. For me they all open exactly the same two legacy events with the
>>> extended type ID set.
>>>
>>> It looks like the behavior you see would be caused by either missing this
>>> kernel change:
>>>
>>>    5c81672865 ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability")
>>>     (v6.6 release)
> 
> What I have now is:
> 
> 6.1.92-15907-gf36fd2695db3
> 
> It was a bit older, but 6.1 ish as well, I'll try to either get a new
> kernel from Libre Computer or build one myself.
> 
> - Arnaldo
>

Thanks for the confirmation. In that case you may not even need to 
retest. I was only wondering if it was broken from v6.6 onwards, but 6.1 
not working is expected. And I'm certain that you'll find any later 
versions working.

>>> Or this userspace change, but unlikely as it was a fix for Apple M hardware:
>>>
>>>    25412c036 ("perf print-events: make is_event_supported() more robust")
>>>     (v6.9 release)
>>>
>>> Do you remember if you were using a new kernel or only testing a new Perf?
>>
>> I normally use the distro/SoC provided kernel, didn't I add the 'uname
>> -a' output in those investigations (/me slaps himself in the face
>> speculatively...)?
