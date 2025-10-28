Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524A3081B0
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651059; cv=none; b=OKGyJJmwisziRwPcMZptZdimCnGlfLqHOgO0c1wi9eeTiI+8s3h83EyZxxVG/PKnhJ4L+RJ74yF+uJQnNo/tjjJrWGZ040brFh4cI+wP/R8XCM3Dw1TSU6Y5aO07LGCwJBs3H4PiMhGYPtk9EakBSF4ezz7u6GGw8ddGRG3Sz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651059; c=relaxed/simple;
	bh=8QU2GrBbd860WeDq06DbmVwU8RUw+T6KdFpwKfmYV9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exrZr150wZpR2Gt1y5gWV3CSlPB3GqG6S1BD6LFBnVYcTDRFd6iNrn83e/P/aJGFrtMUGaR7vaqw7anq9ZJerYjQ8yJlVjW2/wyzWMHiKC6ZBQkYCqV/uXuK65VjMIQqDlQy+M+wMb5ZrtPRur04FgPU7o+kucuEE5BcnXQyAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B++vlLdd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B++vlLdd"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4270a3464caso2883687f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761651056; x=1762255856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNOr8Q0SeNamqMGPBECAkcyAUl2z9vqdfxVAv1A4JW8=;
        b=B++vlLddnHn4RV5mF6VOTson2mymWFnxn3Sod7WasWCts4rdBM8FKW2mIU49RKL2C8
         bQEpqEPRR3UoayHpM7o97q50FZNNBiwjbkwyOquzTpA/YS2Megq0XGQY/D9XpSolJxYt
         0psk9BlAJRgzIxf8K8kRjsUn+mpzzM4D21PhE+HACh7nk15Lb/0pt5+uR3mCsfzYRV+Y
         DZklzMcOOsIkpNp8nddFCGvmBYDY+xjq++brOZ7IR8KebdQLNwUYsz/JJ1hn/lzjEo67
         MHiz215oIRgMvQIIMwWM9W0PMmJtShFeqCPhV6VJwSJKFKM+1qEbEKGRxSQtlGjrTeEh
         jFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651056; x=1762255856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNOr8Q0SeNamqMGPBECAkcyAUl2z9vqdfxVAv1A4JW8=;
        b=oz4vTN3DVPXGl3jcNpFOiDqGvAD9RYionctM5TiLPEh7UaCY5iEvBIextCQOMWFnmk
         2p/2MNEt86Aa64jWnhfUvtgrGhwMFzo+BJIN3Eu9jOSqUW9It94DQx1BE/s3Y+lxiNUC
         dBmJ1iOUUBfyLXptMtiXi7UhDbBc1sIXgcn9QEXMRdsR+DmY04FzL/L9O43Y7mjk3nli
         IoSXlmx3Ji52YZ/F78DKHcJ01ByAn5jplxWEM+x01GksBCNNsKfliUWBE4bL+JczPKaS
         MoKovTF3ocnPLIqoT3Y4M/+wamHVci7jQ9WMLUJOyZ6DqRbGb/obFY8aoCcbiVc0JoTe
         9zyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf63b/sZb3LGLzW7VyCW6PHV8D/tK0lSjgwuYvrjv9OGne0u3v0xA7vGP/yWAgsGmgUL1SCYLLwCncSdy6jCrK@vger.kernel.org
X-Gm-Message-State: AOJu0YyKulbNWwo2rUXAOqZ91rauoLdUU20rv1aW3YBzxHlox8vDoye9
	38rNle26jMhE5U9M7xcA70xwf/x/muy7WxczdDn0R3bpmvSjq5z35H30BPXeijnbw0Y=
X-Gm-Gg: ASbGncsLJrJ6czPdfTHU34cC4yjUkWI4D1MVdJ6FwIffnbw3AHo1Yu8+nIT2gzhIBZW
	e5S8exC3aZH9Gd/ECQ7jwK+sIR+u+zT1OcA4KYxB2a0HHMcW7V/cUZBKlKmjm+rpvg9+ks8OYBF
	vUhTU6L1bsN5WPnLUJIH+3tm80jrgcM/sGlkBv+Aee4bajs0vn4YP5iSszG1Mb2Bi+69l+6AU0v
	6WUTNCtLujmlRH+0+VKtkHImyQx+5f0pGWLOdCd86MH/wHT8rJWy4HDgufYjmlWV559T/P6Zeva
	DQ0+Kp57WOxH6XkgqdpUl8Ds0Y6jRQJggTFhtfsHwoDjsDZxJTX0V3tA/AbYluA4Q8DrjLGqu4c
	+1zg+gvlVM9EpcOpn3MYwy8+SttGZ9hhkPpfiIFG3JooQwA6F5cICRVlDCxDQqHDogVGu20Yxzl
	/riP0s3g==
X-Google-Smtp-Source: AGHT+IHazDrvQ/kry22rCs2Cj3yRv1v3osQoKSlqpMuRhihPgjCbeUfSfLF9kLe+8/16GB53Eeu5fg==
X-Received: by 2002:a5d:64c6:0:b0:428:3cd7:a340 with SMTP id ffacd0b85a97d-429a7e760bdmr2772053f8f.35.1761651055853;
        Tue, 28 Oct 2025 04:30:55 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5678sm19629706f8f.22.2025.10.28.04.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:30:55 -0700 (PDT)
Message-ID: <f674d1eb-c492-4dec-a49c-8b40833741a4@linaro.org>
Date: Tue, 28 Oct 2025 11:30:53 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "perf test: Allow tolerance for leader sampling
 test"
To: Anubhav Shelat <ashelat@redhat.com>,
 Thomas Richter <tmricht@linux.ibm.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org, peterz@infradead.org,
 mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dapeng1.mi@linux.intel.com
References: <20251023132406.78359-2-ashelat@redhat.com>
 <5b02372a-f0be-4d3a-a875-c5ea65f2bafe@linux.ibm.com>
 <CA+G8Dh+DaVp1XVHm=Hh1aLP=5YOmChTRu4=nSUAwTKJO-a4LDw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CA+G8Dh+DaVp1XVHm=Hh1aLP=5YOmChTRu4=nSUAwTKJO-a4LDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/10/2025 6:21 pm, Anubhav Shelat wrote:
> The issue on arm is similar. Failing about half the time, with 1
> failing case. So maybe the same issue on arm.
> 
> Anubhav
> 

You mentioned on the other thread that it's failing "differently", can 
you expand on that? I'm wondering why you sent the revert patch then?

As I mentioned before I'm not seeing any issues. Can you share the 
kernel version that you tested on and your kernel config? And can you 
share the same outputs that I asked Thomas for below please.

> On Fri, Oct 24, 2025 at 9:40 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> On 10/23/25 15:24, Anubhav Shelat wrote:
>>> This reverts commit 1c5721ca89a1c8ae71082d3a102b39fd1ec0a205.
>>>
>>> The throttling bug has been fixed in 9734e25fbf5a perf: Fix the throttle
>>> logic for a group. So this commit can be reverted.
>>>
>>> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
>>> ---
>>>   tools/perf/tests/shell/record.sh | 33 ++++++--------------------------
>>>   1 file changed, 6 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>>> index 0f5841c479e7..13e0d6ef66c9 100755
>>> --- a/tools/perf/tests/shell/record.sh
>>> +++ b/tools/perf/tests/shell/record.sh
>>> @@ -267,43 +267,22 @@ test_leader_sampling() {
>>>       err=1
>>>       return
>>>     fi
>>> -  perf script -i "${perfdata}" | grep brstack > $script_output
>>> -  # Check if the two instruction counts are equal in each record.
>>> -  # However, the throttling code doesn't consider event grouping. During throttling, only the
>>> -  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
>>> -  # let's set the tolerance rate to 80%.
>>> -  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
>>>     index=0
>>> -  valid_counts=0
>>> -  invalid_counts=0
>>> -  tolerance_rate=0.8
>>> +  perf script -i "${perfdata}" | grep brstack > "${script_output}"
>>>     while IFS= read -r line
>>>     do
>>> +    # Check if the two instruction counts are equal in each record
>>>       cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
>>>       if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
>>>       then
>>> -      invalid_counts=$(($invalid_counts+1))
>>> -    else
>>> -      valid_counts=$(($valid_counts+1))
>>> +      echo "Leader sampling [Failed inconsistent cycles count]"
>>> +      err=1
>>> +      return
>>>       fi
>>>       index=$(($index+1))
>>>       prev_cycles=$cycles
>>>     done < "${script_output}"
>>> -  total_counts=$(bc <<< "$invalid_counts+$valid_counts")
>>> -  if (( $(bc <<< "$total_counts <= 0") ))
>>> -  then
>>> -    echo "Leader sampling [No sample generated]"
>>> -    err=1
>>> -    return
>>> -  fi
>>> -  isok=$(bc <<< "scale=2; if (($invalid_counts/$total_counts) < (1-$tolerance_rate)) { 0 } else { 1 };")
>>> -  if [ $isok -eq 1 ]
>>> -  then
>>> -     echo "Leader sampling [Failed inconsistent cycles count]"
>>> -     err=1
>>> -  else
>>> -    echo "Basic leader sampling test [Success]"
>>> -  fi
>>> +  echo "Basic leader sampling test [Success]"
>>>   }
>>>
>>>   test_topdown_leader_sampling() {
>>
>> I disagree here. Reverting this patch cause the test case to fail very often on s390.
>> The test fails about every 2nd run, because the is one run-away value out of many.
>> Here is an example:

I suppose that depends on what the reason for the failure is. I don't 
think we've gotten to the bottom of that yet. It's ok to have a test 
failure if the actual behaviour doesn't match the intented behaviour.

At the moment it looks like we're trying to hide some defect with a 
tolerance value. This makes the test less useful, and it also wastes 
developer time when the tolerance value will inevitably be increased and 
increased with more and more investigations until it tests nothing. Not 
having any tolerance to begin with will make this less likely to happen.

>>
>> # ./perf record -e "{cycles,cycles}:Su" -- perf test -w brstack
>> [ perf record: Woken up 2 times to write data ]
>> [ perf record: Captured and wrote 0.015 MB perf.data (74 samples) ]
>> [root@b83lp65 perf]# perf script | grep brstack
>>              perf  136408 340637.903395:    1377000 cycles:           1171606 brstack_foo+0x1e (/root/linux/tools/perf/perf)
>>              perf  136408 340637.903396:    1377000 cycles:           1171664 brstack_bench+0x24 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.903396:    1377000 cycles:           11716d4 brstack_bench+0x94 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.903397:    1377000 cycles:           11716d4 brstack_bench+0x94 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.903398:    1377000 cycles:           11716e8 brstack_bench+0xa8 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.903398:    1377000 cycles:           1171606 brstack_foo+0x1e (/root/linux/tools/perf/perf)
>>              perf  136408 340637.903399:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910844:    1377000 cycles:           11716e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910844:   39843371 cycles:           11716e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910845:    1377000 cycles:           1171632 brstack_foo+0x4a (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910846:    1377000 cycles:           1171692 brstack_bench+0x52 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910847:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910847:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910848:    1377000 cycles:           1171598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910848:    1377000 cycles:           11715e8 brstack_foo+0x0 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910849:    1377000 cycles:           11717ae brstack+0x86 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910850:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910850:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910851:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910851:    1377000 cycles:           117159e brstack_bar+0x6 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910852:    1377000 cycles:           1171598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910853:    1377000 cycles:           117179e brstack+0x76 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910853:    1377000 cycles:           1171606 brstack_foo+0x1e (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910854:    1377000 cycles:           11716d4 brstack_bench+0x94 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910855:    1377000 cycles:           1171612 brstack_foo+0x2a (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910855:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910856:    1377000 cycles:           1171598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910856:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136408 340637.910857:    1377000 cycles:           1171632 brstack_foo+0x4a (/root/linux/tools/perf/perf)
>> .... many more lines with identical cycles value.
>>
>> I have contacted our hardware/firmware team, but have not gotten a response back.
>> I still think this has to do with s390 LPAR running under hyperviser control and I do not know what
>> happens when the hipervisor kicks in.
>>
>> I agree with James Clark that this should be handled transperently by the hipervisor, that means
>> stopping the LPAR should stop the CPU measurement unit, before giving control to a different lpar.
>>
>> But what happens when the hipervisor just kicks in and returns to the same LPAR again? Or does
>> some admin work on behalf of this LPAR. As long as I can not answer this question, I would like
>> to keep some ratio to handle run-away values.
>>
>> As said before, this happens in roughly 50% of the runs...
>>
>> Here is a run where the test succeeds without a run-away value:
>>
>> # ./perf record -e "{cycles,cycles}:Su" -- perf test -w brstack
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.015 MB perf.data (70 samples) ]
>> # perf script | grep brstack
>>              perf  136455 341212.430466:    1377000 cycles:           117159e brstack_bar+0x6 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430467:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430468:    1377000 cycles:           1171612 brstack_foo+0x2a (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430468:    1377000 cycles:           1171656 brstack_bench+0x16 (/root/linux/tools/perf/perf)

I'm a bit confused how the instruction pointers and timestamps are 
different. Shouldn't the counters be part of a single sample?

Which kernel version is this exactly?

Can you skip the grep, we only care about the samples and not what 
process it happened to be in so that might be hiding something. And can 
you share the raw dump of a sample (perf report -D). One sample that has 
the matching counts and one that doesn't.

Mine look like this, although I can't share one that doesn't match 
because I can't reproduce it:

0 1381669508860 0x24b20 [0x70]: PERF_RECORD_SAMPLE(IP, 0x2): 1136/1136: 
0xaaaac8f51588 period: 414710 addr: 0
... sample_read:
.... group nr 2
..... id 0000000000000336, value 00000000000f38f0, lost 0
..... id 0000000000000337, value 00000000000f38f0, lost 0
  ... thread: stress:1136
  ...... dso: /usr/bin/stress
  ... thread: stress:1136
  ...... dso: /usr/bin/stress


>>              perf  136455 341212.430469:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430469:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430470:    1377000 cycles:           11715e8 brstack_foo+0x0 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430471:    1377000 cycles:           11716c6 brstack_bench+0x86 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430471:    1377000 cycles:           1171622 brstack_foo+0x3a (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430472:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430472:    1377000 cycles:           1171692 brstack_bench+0x52 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430473:    1377000 cycles:           117170c brstack_bench+0xcc (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430474:    1377000 cycles:           11716e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430474:    1377000 cycles:           117169a brstack_bench+0x5a (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430475:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430475:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430476:    1377000 cycles:           11716e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430476:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430477:    1377000 cycles:           11715e8 brstack_foo+0x0 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430478:    1377000 cycles:           117170c brstack_bench+0xcc (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430478:    1377000 cycles:           117170c brstack_bench+0xcc (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430479:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430479:    1377000 cycles:           1171598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430480:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430481:    1377000 cycles:           11715fc brstack_foo+0x14 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430481:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430482:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430482:    1377000 cycles:           1171664 brstack_bench+0x24 (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430483:    1377000 cycles:           117170c brstack_bench+0xcc (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430484:    1377000 cycles:           117170c brstack_bench+0xcc (/root/linux/tools/perf/perf)
>>              perf  136455 341212.430484:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>> #
>>
>> So please let this code in otherwise we need an s390 specific check for success.

This might be an option if there is something in the hardware that 
prevents the counts from being the same. But because they are the same 
99% of the time it seems like it has the capability and it's just a bug 
somewhere.

James

>>
>> Thanks a lot
>> --
>> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
>> --
>> IBM Deutschland Research & Development GmbH
>>
>> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>>
>> Geschäftsführung: David Faller
>>
>> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
>>
> 

