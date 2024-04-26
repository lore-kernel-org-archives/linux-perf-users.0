Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E248469D
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Apr 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149062; cv=none; b=Hf3YU1HjMrlJobQ/V27kBRu4KROOD5Mg1uJXL0SL69QMHW2lXUmud/PRifk+HHjfIQyx2g/DVRZJ68hojamemXIt2hKRMi3JJgEY/q699J0kJWozzdItA4yrtV38OBw69nS/uKBxr6xRGN/Etrou35kKukTe8E42rP1FCU3EBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149062; c=relaxed/simple;
	bh=/8k54WJjLXl0Ohgcov1tDkRVE3ju+AV5WfFnQsTwUMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWS17C14OZZ2k6Uo/S5pciZCV8aUcOegfajxxOE/EBxHxXHaDvPEBHiX8rA75sU5ALM+Rd+fwofV+26PAlP6vrFkoP9fAM/O2Cun7kZntQ8wSzgFZ+CeJcWDFkoFVaq326dASwCLTym3o7gZyDe5PavPzBpuAgYy1wCsfXTudio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RA2lkBGW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA2lkBGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714149059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpjTUxc+qWA0Y4qZUddNdAIcrkox+wko/HZ0g50xBTo=;
	b=RA2lkBGWZ7AUOkBufWCWAIrjS6d6gsUzXrFFHL+S4/inFPLZSsI3uw2iDGma1DC3vRvhUC
	QPI1/NAMRTZsvRn47t8wxlS4JD+Doi522V6AdZ2CIJBTE+MrGYk3PEH7Xh/72Ku5VW6Spv
	qxeGe6twMd+NfiE4bgviJ0v6K2mbgT8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-HFDYv_hEMzitHBGdRgohJA-1; Fri, 26 Apr 2024 12:30:57 -0400
X-MC-Unique: HFDYv_hEMzitHBGdRgohJA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343e54fc19bso1239871f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Apr 2024 09:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714149056; x=1714753856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpjTUxc+qWA0Y4qZUddNdAIcrkox+wko/HZ0g50xBTo=;
        b=ORCzxi3/hoi8d3CKZCnRQTJrOJJoOXUJx//gLDkl2kat8vKnfRXvxpewRY7lLr3Qsk
         WwRYSYmG8wt8Lp2ND30Zgw9DvovD58BS6o6Oqg19Pehn/PAN3s5tyiU18t9IBLng+HlH
         704tL3UddVq+cd87d9Je+ybI0NeV9I1F9oKvjYTWzUEHgijJm532wG+Tk2XikNfqBlpP
         pTkppf9f1P4jCo6VQMdUUR6GFOI5be2Apl/6QmBasCdWUu5slvdmogLL8cp+nFaWUqL9
         w6DL6AlNykqNFYG88pqFYNcuXftnvaLjcS3zuNOCnf+7KvsO2yGZHJ+djXlDpR+cAn7T
         u9pw==
X-Forwarded-Encrypted: i=1; AJvYcCW0rt041wbsLPPdbEqo9aGZ/Tw5+LaLzHqxINlQjliwy8zWNn0w2P3vHoQG6Wfvy/6muFIfKhvx4YmswJNUjCKzPiI8SkjiAX+3D+ZZbbkcHw==
X-Gm-Message-State: AOJu0YzHcQSVLhwT7q3eh2B1mcUYB/0N7cwbPUmQoPDwtz1FLDDMv8ZT
	b0F3xAb+u8pf/ShDkH+SKEaoF/ij0HXiBT/sWi1kfmfTUBWh42lmqZVb/5UpqliEY8iIIXJx0m/
	PDRPVHH+NzChKm/nairfKIdixTp5977hjdo982HGR/9fxXcJUo3pE+q2RdCAySY6OaUja/0/OBX
	Iibw==
X-Received: by 2002:a5d:68ca:0:b0:343:a6fc:b2e8 with SMTP id p10-20020a5d68ca000000b00343a6fcb2e8mr62718wrw.26.1714149056089;
        Fri, 26 Apr 2024 09:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmjsoBTMU6pCcdTt3oPFA1D/zUO5nyuIvI1Qw7CNBBKnvS7pzGg9gU9XshdIHt96lcgDf9mw==
X-Received: by 2002:a5d:68ca:0:b0:343:a6fc:b2e8 with SMTP id p10-20020a5d68ca000000b00343a6fcb2e8mr62698wrw.26.1714149055734;
        Fri, 26 Apr 2024 09:30:55 -0700 (PDT)
Received: from [192.168.137.117] (2254069205.kn.vutbr.cz. [147.229.196.16])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b0034c61e211a5sm1651726wrt.63.2024.04.26.09.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 09:30:55 -0700 (PDT)
Message-ID: <0db3b460-2520-4dbb-8864-458b3139566f@redhat.com>
Date: Fri, 26 Apr 2024 18:30:52 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Content-Language: en-US
To: kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 acme@kernel.org, acme@redhat.com
Cc: mpetlan@redhat.com
References: <ZhgpWkUAto8nzvle@x1> <20240415094220.11639-1-vmolnaro@redhat.com>
 <89dfc623-e583-437f-812f-d2a40dc42611@linux.ibm.com>
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <89dfc623-e583-437f-812f-d2a40dc42611@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jain,

Thanks for letting me know, there was just some typo fixed in the comment upstream,
which caused it to fail. Will fix the patch, also add Ian's suggestion and 
resend it shortly.

Thanks,
Veronika

On 4/23/24 10:01, kajoljain wrote:
> Hi Veronika,
>    I was trying to test this patch. But I am not able to apply this
> patch cleanly on both upstream and acme's tmp.perf-tools-next branch.
> 
> error: patch failed: tools/perf/tests/shell/stat_all_pmu.sh:2
> error: tools/perf/tests/shell/stat_all_pmu.sh: patch does not apply
> 
> Can you check that part, but since its simple change I added it manually
> and could test the patch.
> 
> Patch looks fine to me. I tested it by disabling hv-gpci events in HMC
> 
> Without patch changes:
> 
> localhost:/dev/shm/linux/tools/perf # ./perf test 95 -vv
>  95: perf all PMU test:
> --- start ---
> test child forked, pid 2234
> ---
> Testing cpu/stalled-cycles-frontend/
> Testing
> hv_gpci/system_hypervisor_times_time_spent_managing_partitions_over_entitlement/
> ---- end(-1) ----
>  95: perf all PMU test                                               :
> FAILED!
> 
> with patch changes:
> 
> Testing event
> 'hv_gpci/system_hypervisor_times_time_spent_managing_partitions_over_entitlement/'
> -- no permission to enable
> Testing event
> 'hv_gpci/system_hypervisor_times_time_spent_on_system_management/' -- no
> permission to enable
> Testing event
> 'hv_gpci/system_hypervisor_times_time_spent_processing_virtual_processor_timers/'
> -- no permission to enable
> Testing event
> 'hv_gpci/system_hypervisor_times_time_spent_to_dispatch_virtual_processors/'
> -- no permission to enable
> Testing event
> 'hv_gpci/system_tlbie_count_and_time_time_spent_issuing_tlbies/' -- no
> permission to enable
> Testing event
> 'hv_gpci/system_tlbie_count_and_time_tlbie_instructions_issued/' -- no
> permission to enable
> Testing event 'pm_br_mpred_cmpl' -- supported
> 
> On 4/15/24 15:12, vmolnaro@redhat.com wrote:
>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>
>> With the upstream MR !3916 of commit a381bd3615de6 ('powerpc/hv-gpci:
>> Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
>> stat for hv_gpci events without required permission set returns an
>> error value of -1 to differentiate the output from the unsupported
>> events. The stat_all_pmu test was designed in a way, that if any
>> command exits with a non-zero value the test exits with an error
>> value without any information provided due to the 'set -e' option.
>>
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
>> Link to the MR !3916 of commit a381bd3615de6:
>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
>>
>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>> ---
>>  tools/perf/tests/shell/stat_all_pmu.sh | 36 ++++++++++++++++++--------
>>  1 file changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
>> index c77955419173..d9f0d2100baa 100755
>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
>> @@ -2,21 +2,35 @@
>>  # perf all PMU test
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> -set -e
> 
> It will create extra blank line can you remove that. Also make sure to
> test the patch with checkpatch script to avoid any format issue.
> 
> Thanks,
> Kajol Jain
> 
>>  
>>  # Test all PMU events; however exclude parametrized ones (name contains '?')
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
>> +    # return value 0 if counters gets printed either if the event is supported or not
>> +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
>> +        echo "supported"
>> +    elif [ $stat_result -eq 0 ]; then
>> +        echo "not supported"
>> +    # return value 255 when the required pemission for the event is not set
>> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
>> +        echo "no permission to enable"
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
> 

