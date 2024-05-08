Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16EBA27
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164147; cv=none; b=YsPFBsrHPZGX9OF7XOyTyNWLTB4CAzG9e9tmXoWjN3sf1aoKjgTVBdDU8AgqsBZ8PkFKJEA9/Lisz5dBBrnxS+aBJbZYeKJCK0TWwWIsYcB+2n+MMWCG5cNYmN1YlELayYR+3yse88pYrZHiTLHg+EET2W+Uumpc6p75ZoJa99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164147; c=relaxed/simple;
	bh=EqhYpJCsWHUztP9X9UIkVZTWWnX8Y9CJSSn2Y9YzV0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJqpTV5d3Et5v0hhGMPoBJ2LWqvi23FdGfdDGCQn3t1dIZoGAqZT4ReNdtP9NB/SSGIaEoBCKroVGKUiKmYtmfOOtsVj1rxDBLUlUng4YjYlKxVaRTrxlbh9ZosPAdwKgXSsvEh7qewdQBFSYhSgNQHreDXHHhDiOvYNViUXX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2J+rHjg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2J+rHjg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715164144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldFKCG7HfG5b8PlY7DSZcKx/h/cT0etPrJBFc41eqQM=;
	b=b2J+rHjgSZYvb5mt+dS/bBrGNIV27Es/r0z1zyWEvDQtlerWYIyfoc++0z9cWCFAipRK7x
	6X5jPLdUhXcUpXiwN3owVTnEtpNYjDabo3wW+lkXcHutaqmEf9smOSBKgZl94Rknns2bmB
	B+S+AuBGQHs6N+4FM9kMRUSsF09aul4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-nrWnXKRKNj-D_1QAm7n3DQ-1; Wed, 08 May 2024 06:29:02 -0400
X-MC-Unique: nrWnXKRKNj-D_1QAm7n3DQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-418f5e7b9b2so14683375e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 03:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715164141; x=1715768941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldFKCG7HfG5b8PlY7DSZcKx/h/cT0etPrJBFc41eqQM=;
        b=mEVROM14AS2GhC/TMVP6bbL3C7JH3vF9WF6UmwS0gH6GEojijDCqC9ogeeDvBZ9WC2
         i4EEHzSe09KYT9eyjYC6i0Tnye6a2LIbmBCqT+LF5oEgHACuZyKyeyFHJpKoBuCd3WvJ
         lHgqy5nzVh4cQX/53ZV/UmVi+NqZaZ95V1h8uz+GWbCBion9Bb27QmKqJA2RHPa/qLeg
         b9hkcjNN1ouk3m2lUVLrRGb4fvMdHyqyTKPrJ1yl2XKWy51YE3AzY493JqfHdxUS8RaA
         FtU6pD4RLS7EpqK+pT/QWrbjQtZ2x9xq+SA1ohHZisB0OBrnxCO4wnV+lMMewo8lh/FP
         0qsg==
X-Gm-Message-State: AOJu0YxfQ3lsXFvZgfHOcdhr7q71QzFJ40PrioaHg/ksKUrlMsxOORnH
	5UYUTIyOP3fXoRbRefFRKe4q4J7IOQzVKoJmE2fmhCsaIMkwND3cWYhLXK5K+bHJOwC8T1vNtkD
	6nogTnlIubUXfbkdioxOkwHIxqTtNNm2xvzePQPcYdX0VFQ4hvKLllghFexBgY4t5UCA=
X-Received: by 2002:a7b:cd96:0:b0:41c:2313:fa53 with SMTP id 5b1f17b1804b1-41f71bcac72mr15300935e9.41.1715164141435;
        Wed, 08 May 2024 03:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjW+YfWyt/SjEIhFWhU7mVCXGL4XR3GxRNTwwWk/YlWTgC2ydSjNboSUehC8cwmpFGmPE0lg==
X-Received: by 2002:a7b:cd96:0:b0:41c:2313:fa53 with SMTP id 5b1f17b1804b1-41f71bcac72mr15300835e9.41.1715164141028;
        Wed, 08 May 2024 03:29:01 -0700 (PDT)
Received: from [192.168.137.117] (2254069205.kn.vutbr.cz. [147.229.196.16])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d5007000000b0034e78c6ed43sm12501876wrt.110.2024.05.08.03.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 03:29:00 -0700 (PDT)
Message-ID: <0374bfb4-8da7-4711-ad0b-0ef57c15715b@redhat.com>
Date: Wed, 8 May 2024 12:28:59 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test stat_all_pmu.sh: Parse return value of perf
 stat
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com
References: <Zh6ZEGOfgcEfwha4@x1> <20240429110439.17362-1-vmolnaro@redhat.com>
 <ZjVIQa3JouJde7I1@x1>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <ZjVIQa3JouJde7I1@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 22:25, Arnaldo Carvalho de Melo wrote:
> On Mon, Apr 29, 2024 at 12:56:24PM +0200, vmolnaro@redhat.com wrote:
>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>
>> With the upstream MR !3916 of commit ad86d7ee43b22aa2 ('powerpc/hv-gpci:
>> Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
>> stat for hv_gpci events without required permission set returns an
>> error value of -1 to differentiate the output from the unsupported
>> events. The stat_all_pmu test was designed in a way, that if any
>> command exits with a non-zero value the test exits with an error
>> value without any information provided due to the 'set -e' option.
> 
> Is this v2 or v3? Kajol, can I have your tested-by?
> 
> Thanks,
> 
> - Arnaldo
>  
From my point of view it was v2 of the patch, but now I noticed that the a v2
was created when the commit hash was firstly fixed, so maybe its then a v3?

Sorry for confusion,
Veronika

>> Running stat_all_pmu test on powerpc machine with unsupported hv_gpci
>> event causes failure after the MR as the zero return value was required.
>> The issue propagated upstream as the list of the files that affected perf
>> did not cover the changed files and was updated after the issue was
>> discovered. It was caught by CKI testing where it was triaged to stop
>> blocking further MRs, as most of the powerpc machines do not support
>> some of the hv_gpci events.
>>
>> Remove the 'set -e' option from the test and rework the test case to log
>> the status of the event for better maintainability. Instead of exiting
>> immediately after 'perf stat' ends with a non-zero value, check the
>> return value and output of the 'perf stat' command with the appropriate action.
>>
>> Link to the MR !3916 of commit ad86d7ee43b22aa2:
>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
>>
>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>> ---
>> Fixed the issue with applying due to a fixed comment typo upstream and
>> added Ian's suggestion for the 'device busy' issue during parallel
>> testing.
>>
>>  tools/perf/tests/shell/stat_all_pmu.sh | 41 ++++++++++++++++++--------
>>  1 file changed, 29 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
>> index c77955419173..a75beddda4db 100755
>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
>> @@ -2,21 +2,38 @@
>>  # perf all PMU test
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> -set -e
>>  
>>  # Test all PMU events; however exclude parameterized ones (name contains '?')
>>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
>> -  echo "Testing $p"
>> -  result=$(perf stat -e "$p" true 2>&1)
>> -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
>> -    # We failed to see the event and it is supported. Possibly the workload was
>> -    # too small so retry with something longer.
>> -    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
>> -    if ! echo "$result" | grep -q "$p" ; then
>> -      echo "Event '$p' not printed in:"
>> -      echo "$result"
>> -      exit 1
>> +  echo -n "Testing event '$p' -- "
>> +  stat_output=$(perf stat -e "$p" true 2>&1)
>> +  stat_result=$?
>> +  if echo "$stat_output" | grep -q "$p"; then
>> +    # return value 0 if counters get printed either if the event is supported or not
>> +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
>> +        echo "supported"
>> +    elif [ $stat_result -eq 0 ]; then
>> +        echo "not supported"
>> +    # return value 255 when the required permission for the event is not set
>> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
>> +        echo "no permission to enable"
>> +    # return value 255 in case of resource busy during parallel testing of events
>> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "Device or resource busy"; then
>> +        echo "resource busy"
>> +    # return value 129 when trying to run 'perf stat' with a non-existent event
>> +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
>> +        echo "Fail: Bad event name"
>> +        echo "$stat_output"
>> +        exit 1
>> +    else
>> +        echo "Fail: Unknown return value $stat_result"
>> +        echo "$stat_output"
>> +        exit 1
>>      fi
>> +  else
>> +      echo "Fail: Event '$p' not printed in:"
>> +      echo "$stat_output"
>> +      exit 1
>>    fi
>>  done
>>  
>> -- 
>> 2.43.0
>>
> 

