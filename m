Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50497F489
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402156; cv=none; b=aj7i5AQk5cNe6LcEZB9snoBOAx3MBlDO3FKUlMneW5ROsu8Z5kMk1Xlyf2ZIgTui5IrVTia/2fHrCKr0IurzyR5zyvfOfcCM2+uY7PxbuS6QZ2BgA7MZWMQ8+gUmU+6O5sfFdds0ZIlKRk2DVGxOpRwRzfKVBaXHHa2rnRwc5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402156; c=relaxed/simple;
	bh=qbx3g2uO4NtPZWIwOS5yFnSJoc348ZYf9636NTByQkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkPDOKgJoeY+ZMM9/AX3TANdQWjrMPMZTs80+C/k+VG4H7V15cbepaGRF+Zys24oo8epL70TsNIJYxIVo6kFyVlX5bMkAZLfjsNimXL7ClDBe9z3rT1n9kQFF9Kh3BejV2Wy3lGeYS3nfah/gFV2o93tN2Bw5IXi4h9AgC3Mne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0OvokBL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0OvokBL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714402153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ln/XYC+oZQnfVYR5P0D9/Emt3rXI9LSotRmevRcvOCg=;
	b=M0OvokBLX4zHmBL9JcCVUBYoq2I1og0I0hgH29M2+KKhdqWWTOeKj9UraXkY6XlYZu/DKa
	nBHlSBZecuJi932Gmwhjdja8jeVQ7aGH5WBKlNPPNeJCcb21Lt//rJaJDd3BlG5etyF15d
	HbKRezRfA02RbUwB4DWuXj/LaNDZ4OU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-BbDXR4lbNVa3KtV_UkS2iw-1; Mon, 29 Apr 2024 10:49:11 -0400
X-MC-Unique: BbDXR4lbNVa3KtV_UkS2iw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d855c0362bso36433121fa.3
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 07:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714402148; x=1715006948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ln/XYC+oZQnfVYR5P0D9/Emt3rXI9LSotRmevRcvOCg=;
        b=goh0b60mCRNlEdjkwhblrCkJ/TvLbpywkx/I/UO908ghvUnot8Fqa+FN4HVBTJH5aD
         ak1ELBKPWgrIWveapp0uuktTUU17Kva6gL59oyQZbyvhQFd97emnPrlKa3DYBTu3nXaq
         qw5hH+BuROeD2WgmIL9Ro1SFdCpGRMdDqaAjSYso7xYUz7kmntDzA+OWWnAfcWPJiG8T
         uQA4FbPf+xVLaha+n6Nn6Cq5V7nXiNyGgW/EBH0BMacwTJnXhw8nT6Iw5xKW2ch3PXf/
         CWYsQZIQkBX6OyTAKYTJve9VTBqzrZxeU0vzOP3bdvMxRgDS8DU4kETKmaYZAnWtmwoV
         vFhA==
X-Forwarded-Encrypted: i=1; AJvYcCXowf7QZDezo3rrFpxPt505pkfZbM/rGDe0gKTq7yJ8JWVkv3S1U3eCmdF5V4orCEvM1Fk0opft8RYVmt8J3A/lH6faOfmxQ1DlM4rlIbOqlQ==
X-Gm-Message-State: AOJu0YzNgio/5GeHhLbpqfxfj757pXKkn6LnYnYRski01RlNQ09jUDmF
	PFbTtcc/s4y6XVKRSw15MfEzx8TyKb0WpTjfCSkwkjy8fmS6Lkd8+uwzWfHKZ1850Ji3cYAWd4/
	C0wwRPBcwgS3mZXUbaICUYgTkbLjxe4B0zyPjcqiLLaiJUU2WhIYIinz7mTLkpwaO2bppGKrb5i
	jWCw==
X-Received: by 2002:a2e:b784:0:b0:2d6:f698:7ecf with SMTP id n4-20020a2eb784000000b002d6f6987ecfmr6551743ljo.9.1714402148486;
        Mon, 29 Apr 2024 07:49:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmc8CiffHQ8rr9HITicLFmdCuNdR9QemMlGJgkMoITet/yNpu8SIZA6hGAQ/I4C1coGiBGvQ==
X-Received: by 2002:a2e:b784:0:b0:2d6:f698:7ecf with SMTP id n4-20020a2eb784000000b002d6f6987ecfmr6551721ljo.9.1714402148125;
        Mon, 29 Apr 2024 07:49:08 -0700 (PDT)
Received: from [192.168.1.27] (adsl-dyn164.78-99-35.t-com.sk. [78.99.35.164])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b00349ff2e0345sm29841286wrn.70.2024.04.29.07.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 07:49:07 -0700 (PDT)
Message-ID: <ce24cf21-422f-45fe-838e-1e36858b93be@redhat.com>
Date: Mon, 29 Apr 2024 16:49:06 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Be more tolerant of metricgroup failures
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240403164818.3431325-1-irogers@google.com>
 <CAGa8GX5MhP3FUhafN5QivHaE3Fg+p5MgvTq3SW6MQy4NeZ1sYQ@mail.gmail.com>
 <CAP-5=fU_EvN-bSjwbWMP8R+WyG-jeAQ1p4ziyejy2FCH0kgYig@mail.gmail.com>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <CAP-5=fU_EvN-bSjwbWMP8R+WyG-jeAQ1p4ziyejy2FCH0kgYig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/22/24 17:42, Ian Rogers wrote:
> On Mon, Apr 22, 2024 at 4:51 AM Veronika Molnarova <vmolnaro@redhat.com> wrote:
>>
>> Hi Ian,
>>
>> On Wed, Apr 3, 2024 at 6:48 PM Ian Rogers <irogers@google.com> wrote:
>>>
>>> Previously "set -e" meant any non-zero exit code from perf stat would
>>> cause a test failure. As a non-zero exit happens when there aren't
>>> sufficient permissions, check for this case and make the exit code
>>> 2/skip for it.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  .../perf/tests/shell/stat_all_metricgroups.sh | 28 +++++++++++++++----
>>>  1 file changed, 22 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
>>> index 55ef9c9ded2d..d6db192b9f18 100755
>>> --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
>>> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
>>> @@ -1,9 +1,7 @@
>>> -#!/bin/sh
>>> +#!/bin/bash
>>>  # perf all metricgroups test
>>>  # SPDX-License-Identifier: GPL-2.0
>>>
>>> -set -e
>>> -
>>>  ParanoidAndNotRoot()
>>>  {
>>>    [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
>>> @@ -14,11 +12,29 @@ if ParanoidAndNotRoot 0
>>>  then
>>>    system_wide_flag=""
>>>  fi
>>> -
>>> +err=0
>>>  for m in $(perf list --raw-dump metricgroups)
>>>  do
>>>    echo "Testing $m"
>>> -  perf stat -M "$m" $system_wide_flag sleep 0.01
>>> +  result=$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
>>> +  result_err=$?
>>> +  if [[ $result_err -gt 0 ]]
>>> +  then
>>> +    if [[ "$result" =~ \
>>> +          "Access to performance monitoring and observability operations is limited" ]]
>>> +    then
>>> +      echo "Permission failure"
>>> +      echo $result
>>> +      if [[ $err -eq 0 ]]
>>> +      then
>>> +        err=2 # Skip
>>> +      fi
>>> +    else
>>> +      echo "Metric group $m failed"
>>> +      echo $result
>>> +      err=1 # Fail
>>> +    fi
>>> +  fi
>>>  done
>>>
>>> -exit 0
>>> +exit $err
>>> --
>>> 2.44.0.478.gd926399ef9-goog
>>>
>>>
>>
>> The patch looks good and thanks for taking care of it.
>>
>> Just wanted to check what is the desired outcome for metric groups
>> with events that are invalid in per-thread mode causing the test to fail.
>>
>> ```
>> $ ./stat_all_metricgroups.sh
>> Testing smi
>> Metric group smi failed
>> Error: Invalid event (msr/smi/u) in per-thread mode, enable system wide with '-a'.
>> ```
>>
>> Wouldn't it be better if in these cases the test would result in skip instead of fail?
> 
> Hi Veronika,
> 
> I agree that fail isn't best here. I'm wondering:
> 
>  - why doesn't msr/smi/ support per-thread mode? Can't we save/restore
> the count on a context switch? The implementation is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/events/msr.c?h=perf-tools-next#n234
> There's clearly something going on as pperf appears to have other restrictions:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/events/msr.c?h=perf-tools-next#n115
> I'm wondering if aggregation is working right if these counters are
> more than per hyperthread (I'm guessing why the restrictions exist).
> 

Hi Ian,

I am not really sure why the msr/smi/ does not support per-thread mode but
I encountered multiple instances of events that aren't supported in per-thread
mode during testing. Generally, we cannot be sure that there won't be such event,
whether the msr/smi event should be able to handle per-thread mode is another
question.

Thanks for checking it out and would be great if you could add it to v2.

Thanks,
Veronika 

>  - the tool error message is doing pretty good. In the test I guess we
> can spot the per-thread error and turn the fail to a skip. It's a
> shame to bucket things as skip, but it seems easier than listing
> metrics in the test or spotting particular events.
> 
> I can do a v2 to add this.
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Veronika
>>
> 

