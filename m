Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA991DFED
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Apr 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148370; cv=none; b=rmPx5eBk89UD24D8E58cT97SQiN9g1o4w5v7xtTYKanb5isiNc6snEfDN49mjkYGSx5Md/ZohmVPhgfBG80DqQKy2+XCQuxneNJR1TsJsduZOmomfGVeBNDVnSgxojp8Pv7bAkk0nEnS/CVq/ergxyqe6/r7TYfuef/Gv/xttlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148370; c=relaxed/simple;
	bh=4QFqX4QBtTqoCyMIO/8nv8uuWNRJi7BYyGqBUXQgakg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=II+hjiEaJVFkYCe3rcPKyvmL/lHzwBpbbf3EIE3QddmWrX13hkBzEsId8oZyKB0KK/H9kPmv7cXQoZO5634EZq5QwDTIZpB232gTyw+66UxEInIIZEi/1fXA55Lb9dLHx4W/sxcatt3DUzExjjgpjp2B5TaPuEgXiiQ643iYOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXG9p7UP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXG9p7UP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714148367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ez7yerILzbpqQkPHyDJaqbADBySTif5n7nWe5G1jFEY=;
	b=OXG9p7UPc9kACga7qhALqmMRyryEyKXKe2b2cqIXGTFUFrBHpz2oYDKxLVMCVlfPbzMPMT
	lVplfH7cFQkZqd7cLUY2jQ/TkodHaOkKxaQB7PMtC5UjCh53q63YRj9leTKe/z61a4Nzqg
	FRRY+95QhQRtKuqqgRjoFShsHrQIyLk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-bBpMLmD9NxaJ0cgfUCNAuw-1; Fri, 26 Apr 2024 12:19:26 -0400
X-MC-Unique: bBpMLmD9NxaJ0cgfUCNAuw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d883dab079so21670951fa.3
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Apr 2024 09:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714148365; x=1714753165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ez7yerILzbpqQkPHyDJaqbADBySTif5n7nWe5G1jFEY=;
        b=sI062XtqXXo3Bjgyt3dXibLLNfEquNaoa/z0d56/+eJbuQ38xNDJZOwLRSGAyJIAiK
         hfSFZHoYjuc5KmEzf027OXAbfxpvfFep6X3dTwd7kB/lXNOq+RjFq6d++gGRPDiJDx5s
         MYTE4l814+cV1iU1T9f1SbsLOXf0vwrXeOji0OM8ICX/MGuog2kehbOfw0rjbDo1T4PO
         gv/l8XG1J7P3NpHeWicFSvMfZAdaxWGjy699ErQZ6Bmdq9K5FDjO14wLLXhGwCEF23yo
         Y/3emCwD3TsUp/SJwScCZgotnBZy+w+ujpaKvlq8AVuGSMALIk1ucB0kGbMMLgnF6NV7
         rhkQ==
X-Gm-Message-State: AOJu0Yygk/qus7VjaeW00KkECr3ezRwyri3TIbKQmLVe2ja4/MAGmOVb
	k4NH6FgGnXncwurkpNdHuXaPNtOSPS++BBLB6P7IG2w7nFm8g1yCzcU7jGLxqHfpMAfGo1Lvdr4
	SKQ5aiEayAKPG4yRMN2LbnJiGdjD5epgpO8dBgRovA54dmF9xLY3erIYiwQ+g8N2oUcE=
X-Received: by 2002:a05:651c:1a13:b0:2df:7d44:d784 with SMTP id by19-20020a05651c1a1300b002df7d44d784mr1463270ljb.3.1714148364419;
        Fri, 26 Apr 2024 09:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgQbhSc+KMqnRx7iTeRtsXx/Kjb6r0W5/RYMbptHYh+otDizaZVQ8fTDYmGr+ZrLnsXrzWSA==
X-Received: by 2002:a05:651c:1a13:b0:2df:7d44:d784 with SMTP id by19-20020a05651c1a1300b002df7d44d784mr1463252ljb.3.1714148364030;
        Fri, 26 Apr 2024 09:19:24 -0700 (PDT)
Received: from [192.168.137.117] (2254069205.kn.vutbr.cz. [147.229.196.16])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b00416e2c8b290sm35431576wmo.1.2024.04.26.09.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 09:19:23 -0700 (PDT)
Message-ID: <f453ba56-b847-4555-8ca4-3fa68a22456b@redhat.com>
Date: Fri, 26 Apr 2024 18:19:22 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
 mpetlan@redhat.com
References: <20240409130240.13973-1-vmolnaro@redhat.com>
 <CAP-5=fVzs9832tK9nrxL++DZXwNV0eLmMwtd4ZNqkp4b512UHQ@mail.gmail.com>
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <CAP-5=fVzs9832tK9nrxL++DZXwNV0eLmMwtd4ZNqkp4b512UHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ian,

Thanks for looking at this, will check the problem with busy PMUs and add your proposition.

Best,
Veronika

On 4/16/24 17:03, Ian Rogers wrote:
> On Tue, Apr 9, 2024 at 6:03 AM <vmolnaro@redhat.com> wrote:
>>
>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>
>> With the MR a381bd3615de6 ('powerpc/hv-gpci: Fix the
>> H_GET_PERF_COUNTER_INFO hcall return value checks') the perf stat for
>> hv_gpci events without required permission set returns an error value
>> of -1 to differentiate the output from the unsupported events. The
>> stat_all_pmu test, however, exits immediately if any command exits with
>> a non-zero value due to 'set -e' option.
>>
>> Remove the 'set -e' option from the test and rework the test case to log
>> the status of the event for better maintainability. Instead of exiting
>> immediately after 'perf stat' ends with a non-zero value, check the
>> return value and output of the 'perf stat' command with appriopriate action.
> 
> nit: s/appriopriate/appropriate/
> 
> There was a similar issue with metric groups that should be on its way
> to landing:
> https://lore.kernel.org/lkml/20240403164818.3431325-1-irogers@google.com/
> 
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
> 
> nit: s/pemission/permission/
> 
>> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
>> +        echo "no permission to enable"
>> +    # return value 129 when trying to run 'perf stat' with a non-existent event
>> +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
>> +        echo "Fail: Bad event name"
>> +        echo "$stat_output"
>> +        exit 1
> 
> Something we've been seeing with parallel testing is getting busy
> PMUs. The error looks like:
> ```
> $ sudo bash -c "perf stat -e intel_bts// -a sleep 1; echo $?" & sudo
> bash -c "perf stat -e intel_bts// -a sleep 1; echo $?"
> [2] 953102
> Error:
> The sys_perf_event_open() syscall returned with 16 (Device or resource
> busy) for event (intel_bts//).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> 255
> 
> Performance counter stats for 'system wide':
> 
>     <not counted>      intel_bts//
>                         (0.00%)
> 
>       1.002334792 seconds time elapsed
> 
> 0
> [2]+  Done                    sudo bash -c "perf stat -e intel_bts//
> -a sleep 1; echo $?"
> ```
> 
> To avoid failing for this we probably need something like:
> ```
>    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q
> "Device or resource busy"; then
>        echo "device busy"
> ```
> It'd be great if you could add this.
> 
> Thanks,
> Ian
> 
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
>>
> 

