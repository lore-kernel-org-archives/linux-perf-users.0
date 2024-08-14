Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818B1B9B50
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653331; cv=none; b=Jvddb0lbIGnlgPiXJRURlQOn/WntGF/nN3oZhjp7e30/4qR/S+jNG9tcm5ZvSuXqacW0Tp+Jldgdj3ptYwjRZIOEmeMCaUKkzfmFGRCaB6PtZzcbJ64+3ByJrQbui5qZ1Nv/MeZznphjTZWAwlSe/d6M1Ucryv4hPqAUzLBQyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653331; c=relaxed/simple;
	bh=+tsdgmjbdq0o/C8pnuEUe+ljqlkUMnr5mQRdOuxwLIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmp3Njvci/MA7IaEDIj4WUCIHLNIOnW0BzaDyqpg9B0RalVs9KDREPsFg6tZ37MgNeoMaiIO96B8Hto6CdnCLQQciPy/+b6W85KoRxIh0fkHW4GbY2zohqMMhpGMSuqkIp+FlfX5C+PR64XsTmxqVY8PIW+3yIBs7SmLls0uQag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hr/sKNwo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hr/sKNwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723653328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnW8k9I8iciwzHkMhkuV8P9bvz8lm9rjV7UuxHwxlEU=;
	b=Hr/sKNwoQOMUenOcymduGpI97eUx0OwXHNfBNVNg6AcRVohR42rvXHPA99HBYEk2DU0+Wn
	xjiYNJb1v/kSNxv0SIOgVbWKiX2mIJg+QUb4XP6Qd4FdksCywwDWwmE5GybQ9ka0eP8+GF
	Kxjvfwg1tqFgjCzVYcuauY1+jtwcfyQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-dVEeBtP3Naa7K8ujiUe4_Q-1; Wed, 14 Aug 2024 12:35:26 -0400
X-MC-Unique: dVEeBtP3Naa7K8ujiUe4_Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4281ca9f4dbso53982225e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 09:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723653325; x=1724258125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnW8k9I8iciwzHkMhkuV8P9bvz8lm9rjV7UuxHwxlEU=;
        b=eorSGMWFjS3Vz6P/OAyQIxa6my6euv0a6u6Dp6QLXz/O5NiAnjHwy9yMtgnrxuTuNE
         voQAGrB6oYDstAANl76E52phwz43cqcOrWlaBWS1/WyHDTghkc/bPA9r3WMBqMVn+cnr
         ccyKXTfWLZAds7K4a6svu28vL/xC+vGLX6y/X1ufuTg8FjyoDtObEiHG/d/+R/mNvwOM
         PFKcdV/B1INEcL4TBsbyusgwD09/siOZbqO1a2G0WsN2mENy0mi8TB47iNiFq+RQDRBS
         LJLyvSG7Cjc6fmw+b9l6hmnZZNqnCfSBmdikZ0dI2GJneC/9WAH2wLk63VcQ3G/o47OJ
         VDMg==
X-Gm-Message-State: AOJu0Yy5ab/JicUWcg1+UIpqhf4aLdT4608PRhadPaaE4icCPCvcVRg+
	GYqQqiO1ei2KdDocKi6KiM5eyz3gamckLk+hcq0umKkKMQePYawu6UlK9n53gP0jDgFVczIRgcX
	QNJwS9fHH4tWnbq4MB3RRxVGVdokgyMW36xOS/pX+PMpGvREGAOaTGzLwyuBnaTV3/IA=
X-Received: by 2002:a05:600c:1d9a:b0:427:ff7a:794 with SMTP id 5b1f17b1804b1-429dd22f458mr25169235e9.4.1723653325432;
        Wed, 14 Aug 2024 09:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH21vZRKp65cCVKa96soljbjcMauLSgaJhP7SaQTejj4JqfSaVFAKITGNzwI9f9qrVqBWBstA==
X-Received: by 2002:a05:600c:1d9a:b0:427:ff7a:794 with SMTP id 5b1f17b1804b1-429dd22f458mr25168825e9.4.1723653324517;
        Wed, 14 Aug 2024 09:35:24 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5bfsm25210695e9.46.2024.08.14.09.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 09:35:24 -0700 (PDT)
Message-ID: <a463ff35-9849-4a29-aede-c50e8d616226@redhat.com>
Date: Wed, 14 Aug 2024 18:35:23 +0200
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
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 kajoljain <kjain@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com,
 Ian Rogers <irogers@google.com>, Disha Goel <disgoel@linux.ibm.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <Zh6ZEGOfgcEfwha4@x1> <20240429110439.17362-1-vmolnaro@redhat.com>
 <ZjVIQa3JouJde7I1@x1> <ZroKjgWHYwPpvbau@x1>
 <e1435347-404e-4ff4-a4b1-c9338a60c8d3@linux.ibm.com> <Zrt4jZckGWIFH8n3@x1>
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <Zrt4jZckGWIFH8n3@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/24 17:15, Arnaldo Carvalho de Melo wrote:
> On Tue, Aug 13, 2024 at 01:21:14PM +0530, kajoljain wrote:
>>
>>
>> On 8/12/24 18:43, Arnaldo Carvalho de Melo wrote:
>>> On Fri, May 03, 2024 at 05:25:37PM -0300, Arnaldo Carvalho de Melo wrote:
>>>> On Mon, Apr 29, 2024 at 12:56:24PM +0200, vmolnaro@redhat.com wrote:
>>>>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>>>>
>>>>> With the upstream MR !3916 of commit ad86d7ee43b22aa2 ('powerpc/hv-gpci:
>>>>> Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
>>>>> stat for hv_gpci events without required permission set returns an
>>>>> error value of -1 to differentiate the output from the unsupported
>>>>> events. The stat_all_pmu test was designed in a way, that if any
>>>>> command exits with a non-zero value the test exits with an error
>>>>> value without any information provided due to the 'set -e' option.
>>>>
>>>> Is this v2 or v3? Kajol, can I have your tested-by?
>>>
>>> Oops, Kajol wasn't on the CC list, nor Ian, I'm adding them, maybe Kajol
>>> can test it on those machines and Ian, who wrote the test can take a
>>> look, also adding all the perf tools reviewers, as listed in
>>> MAINTAINERS.
>>>
>>> Thanks,
>>>
>>> - Arnaldo
>>>  
>> Hi Veronika,
>> I checked the patch, code wise patch looks fine to me. I also tested it
>> on powerpc system.
>>
>> Just have concern on your commit message, you added below text as part
>> of your commit message:
>>
>> It was caught by CKI testing where it was triaged to stop
>> blocking further MRs, as most of the powerpc machines do not support
>> some of the hv_gpci events.
>>
>> The hv-gpci events are supported in pseries system.
>> And for different power processors, we already have code to include only
>> supported event as part of perf list.
>>
>> If you are taking about parametrized events which are skipped in this
>> testcase, its not that those parametrized events are not supported.
>> Since testing proper values of the parameters is out of scope of this
>> script we are skipping those events.
>>
>> Can you remove that part from commit message? Rest looks fine to me.
> 
> Veronika, can you please address the reviewer's comment and send a v4
> patch, collecting the tags he provided?
> 
> Thanks,
> 
> - Arnaldo
>  
>> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
>> Tested-by: Kajol Jain <kjain@linux.ibm.com>
>>
>> Thanks,
>> Kajol Jain
>>
>>>>> Running stat_all_pmu test on powerpc machine with unsupported hv_gpci
>>>>> event causes failure after the MR as the zero return value was required.
>>>>> The issue propagated upstream as the list of the files that affected perf
>>>>> did not cover the changed files and was updated after the issue was
>>>>> discovered. It was caught by CKI testing where it was triaged to stop
>>>>> blocking further MRs, as most of the powerpc machines do not support
>>>>> some of the hv_gpci events.
>>>>>
>>>>> Remove the 'set -e' option from the test and rework the test case to log
>>>>> the status of the event for better maintainability. Instead of exiting
>>>>> immediately after 'perf stat' ends with a non-zero value, check the
>>>>> return value and output of the 'perf stat' command with the appropriate action.
>>>>>
>>>>> Link to the MR !3916 of commit ad86d7ee43b22aa2:
>>>>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
>>>>>
>>>>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>>>>> ---
>>>>> Fixed the issue with applying due to a fixed comment typo upstream and
>>>>> added Ian's suggestion for the 'device busy' issue during parallel
>>>>> testing.
>>>>>
>>>>>  tools/perf/tests/shell/stat_all_pmu.sh | 41 ++++++++++++++++++--------
>>>>>  1 file changed, 29 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
>>>>> index c77955419173..a75beddda4db 100755
>>>>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
>>>>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
>>>>> @@ -2,21 +2,38 @@
>>>>>  # perf all PMU test
>>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>>  
>>>>> -set -e
>>>>>  
>>>>>  # Test all PMU events; however exclude parameterized ones (name contains '?')
>>>>>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
>>>>> -  echo "Testing $p"
>>>>> -  result=$(perf stat -e "$p" true 2>&1)
>>>>> -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
>>>>> -    # We failed to see the event and it is supported. Possibly the workload was
>>>>> -    # too small so retry with something longer.
>>>>> -    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
>>>>> -    if ! echo "$result" | grep -q "$p" ; then
>>>>> -      echo "Event '$p' not printed in:"
>>>>> -      echo "$result"
>>>>> -      exit 1
>>>>> +  echo -n "Testing event '$p' -- "
>>>>> +  stat_output=$(perf stat -e "$p" true 2>&1)
>>>>> +  stat_result=$?
>>>>> +  if echo "$stat_output" | grep -q "$p"; then
>>>>> +    # return value 0 if counters get printed either if the event is supported or not
>>>>> +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
>>>>> +        echo "supported"
>>>>> +    elif [ $stat_result -eq 0 ]; then
>>>>> +        echo "not supported"
>>>>> +    # return value 255 when the required permission for the event is not set
>>>>> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
>>>>> +        echo "no permission to enable"
>>>>> +    # return value 255 in case of resource busy during parallel testing of events
>>>>> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "Device or resource busy"; then
>>>>> +        echo "resource busy"
>>>>> +    # return value 129 when trying to run 'perf stat' with a non-existent event
>>>>> +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
>>>>> +        echo "Fail: Bad event name"
>>>>> +        echo "$stat_output"
>>>>> +        exit 1
>>>>> +    else
>>>>> +        echo "Fail: Unknown return value $stat_result"
>>>>> +        echo "$stat_output"
>>>>> +        exit 1
>>>>>      fi
>>>>> +  else
>>>>> +      echo "Fail: Event '$p' not printed in:"
>>>>> +      echo "$stat_output"
>>>>> +      exit 1
>>>>>    fi
>>>>>  done
>>>>>  
>>>>> -- 
>>>>> 2.43.0
>>>>>
>>>
> 

Looking at it, the issue wasn't with the unsupported hv-gpci events, but
the ones without permissions to retrieve information from their partitions
as mentioned in the first part of the commit message.

Will rework the commit message and re-send the patch.

Thanks,
-Veronika

