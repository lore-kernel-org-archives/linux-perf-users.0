Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A323195B3F
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Jun 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679391; cv=none; b=UzzkdlsFY76iAjhJkj6IXCXrl9Ay90G4h2qBO5ne2JJKRVCr+wyaINkYcmqNYK6tfNd8JbI2GfHYWw2tKh6RtV69A668J+VJA2wxgqxXFhFJAdZ1L03eFGXP5ayVg1dufJ6my2TGmhvChKMgulK+oFq7Vl6O96c+hztLBprEkVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679391; c=relaxed/simple;
	bh=JLXrlUYX6pNa7+TkLZdnopmAVo/3lgIEulD0pUjnTOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyqICyqMwofbrcbztVilg8EiJec8eghfM7vJ9HnJaafnzs423kZOS5zcwfE0XvXrGP+TvrJdrGff6MLg6WqnT09KyBqawYbjTIqM2YmwPZHmF1/Z1AKzfvGG+3w/sLaTR6Mndy1QZxWHn5lyuK3YY9k/p/r4DS8acDR1YHfIRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDOWHnv5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDOWHnv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717679389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAHYIkXmWpAgqLjxdgi533Q2LTwoBpYrQt6BJq/kmN4=;
	b=HDOWHnv5q1khjrYHRhuMGdFzBkqTSSnTiHiMXflaZvwNrEJrIpfmIZNln1ykAxRfbx/XRt
	jHBsQsp51Ler4FyT7Evmi8zohCUK/uKe0wfgLkL3rCoTUoCOPQ9ZVpJDI0E6EkKpyJj0Gc
	2Jy6ntgbAVid90tie6RW8dAr0g63TTw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-cW2KgqnMNze4-wQeK1ycGA-1; Thu, 06 Jun 2024 09:09:46 -0400
X-MC-Unique: cW2KgqnMNze4-wQeK1ycGA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4210d151c5bso8401675e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jun 2024 06:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679385; x=1718284185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAHYIkXmWpAgqLjxdgi533Q2LTwoBpYrQt6BJq/kmN4=;
        b=ET1p4DMblBveuTv9nuBZ4+VS0XrZrQAsU/wUiC52HUNSpNnZHI7fkidXn6MIx/ER3t
         ztNwph6FVfMwdzWHCKgXvqa9iDPXUWpsVgi9NyidbjfmlJiykR+9XWMd6nFsgrdPifc8
         w8gGEQheCWYuV001WYrDrmlIWMKznGxeWuecAU72X2QcxctoPOgxhbrV18LKsl+0eAkz
         cKjxW/0H3gHotHMNxJRrlss2I/kIRGAMs0s1vrMYM/xLY2kqJpzNEvpvV0p118m96Qsj
         2oYpUS6TdMUrw08uDOZMy+Xc4iKCVs4wEtHfDW+7Xbt18VDIFco+jwcghi81ROyfWZBT
         EWgQ==
X-Gm-Message-State: AOJu0Yzm6/E+d1A0fXLH+e1/8d+FAdy7UuabqkmhdIctuI0SrdxSBv4J
	oPwGae4OeTnjGCntAInQN6yItBkUDgPfeODYgnaXtUHubetsnBwsze4/ZwHefyZY+F0/XRxtJO2
	1a4Qfi2gU4S/L6G1dJX8girYud0JGxkLoHFsTt42UpmxitTFcFsowrs4JSS5vvMUQYLE=
X-Received: by 2002:a05:600c:1d0f:b0:421:5329:227 with SMTP id 5b1f17b1804b1-42156351adfmr44045115e9.26.1717679385193;
        Thu, 06 Jun 2024 06:09:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIC0g+AMba8tEuog+JiMkiIVEJ0Hjy//crwXpAtGVqRtW87KSdcDqC3zcZ0OC1c3CR3MqLNQ==
X-Received: by 2002:a05:600c:1d0f:b0:421:5329:227 with SMTP id 5b1f17b1804b1-42156351adfmr44044905e9.26.1717679384771;
        Thu, 06 Jun 2024 06:09:44 -0700 (PDT)
Received: from [10.43.17.23] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc31adsm1533049f8f.92.2024.06.06.06.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 06:09:44 -0700 (PDT)
Message-ID: <6a33f2f6-fd69-4e90-8cd5-a73d393c20a1@redhat.com>
Date: Thu, 6 Jun 2024 15:09:43 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test stat_bpf_counter.sh: Remove comparison of
 separate runs
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
 mpetlan@redhat.com
References: <20240604153111.105548-1-vmolnaro@redhat.com>
 <Zl-x8uob6NT3HlfT@google.com>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <Zl-x8uob6NT3HlfT@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/24 02:31, Namhyung Kim wrote:
> On Tue, Jun 04, 2024 at 05:31:11PM +0200, vmolnaro@redhat.com wrote:
>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>
>> The test has been failing for some time when two separate runs of
>> perf benchmarks are recorded and the counts of the samples are compared,
>> while once the recording was done with option --bpf-counters and once
>> without it. It is expected that the count of the samples should within
>> a certain range, firstly the difference should have been within 10%,
>> which was then later raised to 20%. However, the test case keeps failing
>> on certain architectures as recording the same benchmark can provide
>> completely different counts samples based on the current load of the
>> system.
>>
>> Sampling two separate runs on intel-eaglestream-spr-13 of "perf stat
>> --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t":
>>
>>  Performance counter stats for 'perf bench sched messaging -g 1 -l 100 -t':
>>
>>          396782898      cycles
>>
>>        0.010051983 seconds time elapsed
>>
>>        0.008664000 seconds user
>>        0.097058000 seconds sys
>>
>>  Performance counter stats for 'perf bench sched messaging -g 1 -l 100 -t':
>>
>>         1431133032      cycles
>>
>>        0.021803714 seconds time elapsed
>>
>>        0.023377000 seconds user
>>        0.349918000 seconds sys
>>
>> , which is ranging from 400mil to 1400mil samples.
>>
>> From the testing point of view, it does not make sense to compare two
>> separate runs against each other when the conditions may change
>> significantly. Remove the comparison of two separate runs and check only
>> whether the stating works as expected for the --bpf-counters option. Compare
>> the samples count only when the samples are recorded simultaneously
>> ensuring the same conditions.
> 
> Hmm.. but having a test which checks if the output is sane can be
> useful.  If it's a problem of dynamic changes in cpu cycles, maybe
> we can use 'instructions' event instead (probably with :u) to get
> more stable values?
> 
> Thanks,
> Namhyung
> 

Well but isn't it better to check the sanity of the output if the counters are recorded
for a load with the same conditions as has been added in patch d9bd1d4
"perf test bpf-counters: Add test for BPF event modifier" utilizing the event modifiers: 
perf stat --no-big-num -e cycles/name=base_cycles/,cycles/name=bpf_cycles/b -- $workload?
Comparing two separate runs is more based on the stability of the workload than the
bpf-counters option, which then causes the issue of defining the threshold of what values
are still within the sane range.

But you are right that another possible fix for this issue is to change the workload or the
event to get some more stable values, which could be comparable.

Thanks,
Veronika

>>
>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>> ---
>>  tools/perf/tests/shell/stat_bpf_counters.sh | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
>> index 61f8149d854e..873b576836c6 100755
>> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
>> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
>> @@ -6,19 +6,19 @@ set -e
>>  
>>  workload="perf bench sched messaging -g 1 -l 100 -t"
>>  
>> -# check whether $2 is within +/- 20% of $1
>> +# check whether $2 is within +/- 10% of $1
>>  compare_number()
>>  {
>>  	first_num=$1
>>  	second_num=$2
>>  
>> -	# upper bound is first_num * 120%
>> -	upper=$(expr $first_num + $first_num / 5 )
>> -	# lower bound is first_num * 80%
>> -	lower=$(expr $first_num - $first_num / 5 )
>> +	# upper bound is first_num * 110%
>> +	upper=$(expr $first_num + $first_num / 10 )
>> +	# lower bound is first_num * 90%
>> +	lower=$(expr $first_num - $first_num / 10 )
>>  
>>  	if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
>> -		echo "The difference between $first_num and $second_num are greater than 20%."
>> +		echo "The difference between $first_num and $second_num are greater than 10%."
>>  		exit 1
>>  	fi
>>  }
>> @@ -44,7 +44,6 @@ test_bpf_counters()
>>  	base_cycles=$(perf stat --no-big-num -e cycles -- $workload 2>&1 | awk '/cycles/ {print $1}')
>>  	bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- $workload  2>&1 | awk '/cycles/ {print $1}')
>>  	check_counts $base_cycles $bpf_cycles
>> -	compare_number $base_cycles $bpf_cycles
>>  	echo "[Success]"
>>  }
>>  
>> -- 
>> 2.43.0
>>
> 

