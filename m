Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FC24A7F4
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030691; cv=none; b=AstIiSRhyg8tXv6I5VAn7IubtOdjeu9GgdgM2WIo1UrHEpL0VsFFA9xfaFCM/BgIWAnROrgXMLmF0DPaAK79e27qV4MPMaUSNI/72Vz5QDEEas0tcbgWDpKcgID8jYtj1xHUSNfoMuK1ifInZsoaVHvRkz0IkovoB2kXlRdn6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030691; c=relaxed/simple;
	bh=Mymtu6c0C6owoGK2o5u062xBZgN0jCylYAygNUv4Noc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EIW+TjadhVp6QkDDNwyL8jMTSb8qKtc8BR/WuVyhBNMtvVhrsEJYfn/2ZKCFuXUefM8vjeoy861nbEKwEzCcemme/pUzCg+uRAfglE9OrUqu4bKWOnwbgtHjSChV7CPbKPQ8g4zxITiyxoJsSsBi7XvpElDWzC48rvTNFInRdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+/I4Nwh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+/I4Nwh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737030687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2e2iP2sUAqfkOljiHRIdFl1aLlIvE3zStOPNmlVqVw=;
	b=N+/I4NwhaV/8/+D924ywAB87B/6qpcgSxlZuw1cMVnzpMqtIu01PGe3IAC1QBNNkd+m/hF
	mL7VoVCAdtHn/Yuovei5TT1zxJOoM5q8ZUAPjpgK9YGkdAwjYVycf9DNSIXv6VCIY2FnPK
	7rtcdrCOOXHiR8Kz9mWYlYqvbqUpZ7A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-fANclslbMU2mylVuUzdiyA-1; Thu, 16 Jan 2025 07:31:26 -0500
X-MC-Unique: fANclslbMU2mylVuUzdiyA-1
X-Mimecast-MFC-AGG-ID: fANclslbMU2mylVuUzdiyA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43628594d34so4179055e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 04:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737030684; x=1737635484;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2e2iP2sUAqfkOljiHRIdFl1aLlIvE3zStOPNmlVqVw=;
        b=k1t8GyPjcyj5mIezO8Kmc1bGkFWiadIh+SOs/fEuCPgUDUe0OT1s+yEqOqMq1V6yLW
         TT4bXK1EBKOBk7HXqV1TO75B/e+ENbqhpTyDz5TXndklY7MRCn0AcXUL47QDjkxZId8O
         KzB2VyoT7KUOOiTmBSmUs5vYjxid4xuaY6lCArt3YE7LmzUB29KkaxCRWA/HTOiN03aL
         o4iP3673sZWh1GbuzSQXutPdAcfjcUtr7IQ8pCIub4/UZORS3pvnFLj0kUs1xTjDrYIm
         W9hfbUpQljr+NaJAAlcV7XTSsyBI+u8OElXPxYsI1UbhOpDQvi8FF6VThEsWIwgzlJCQ
         ThIg==
X-Gm-Message-State: AOJu0YzLvHEgUwSQdHJnB88NjqpmH0o3zYR2v2CjHjIQCRWgLVxiBRrh
	FgwjmlNXX/EnDORzkvCypAVIYLqLWaGzLUcPXpn9xJBqjcwfC4H2/FMDGVEWrYfXsUipVb4M1HX
	WSepO8UXFgKVZqvf6mW0WovtvCBUUbHYtcReCp+FWtjlMiYzwSFOVJ2pv/Hk2lqky5mA4aULFas
	Mj8DlCLsWRt4KD3CbovtznJMaNKNN2xP14c/bvQAtMfB/0BNQLa6ZHqw==
X-Gm-Gg: ASbGncs5OTOfjgLootHQXd99vMhCN0mzYZA3I2n6huebTLf2J1v2WKTcYZAN0n3Fu9J
	qWUXewM8xSMNO5daiMlc6GR6dUCQ43wtyb9oTsZ+5TFpZhko7AYUMxLzZA1ZfSs4nYruEASgaSW
	edaV8+lUG6aj6IzZmW139ekcLlUaCU01/NCXgrf0K/9vVCTHStzbbt9MocwZ56sWHQ6Ay6JtWpr
	bnIIEJ0nVr5Id7ikBjmgqiAk2vBSgP1S+fUy8rmUHHqxt8m48e6TQhB39uzvjie5JKWHokWeyec
	4QOUXAp5iaM=
X-Received: by 2002:a05:600c:5115:b0:434:feb1:adae with SMTP id 5b1f17b1804b1-436e266e823mr288289745e9.3.1737030683943;
        Thu, 16 Jan 2025 04:31:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZ0IIFZaJGOkjxDEu+mX9L9N/O7lQNh2Woi0PEcaCzsx3V4fAcwsk26FTkHIqlRWyNd3Sq+A==
X-Received: by 2002:a05:600c:5115:b0:434:feb1:adae with SMTP id 5b1f17b1804b1-436e266e823mr288289365e9.3.1737030683440;
        Thu, 16 Jan 2025 04:31:23 -0800 (PST)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74bf061sm57274905e9.17.2025.01.16.04.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 04:31:23 -0800 (PST)
Message-ID: <8f62887e-f3c5-4b43-8c77-897564dc971e@redhat.com>
Date: Thu, 16 Jan 2025 13:31:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Correctly check 'perf stat'
 result
From: Veronika Molnarova <vmolnaro@redhat.com>
To: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
 irogers@google.com
Cc: mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 kan.liang@linux.intel.com, qzhao@redhat.com
References: <20241122231233.79509-1-vmolnaro@redhat.com>
 <1eeb7a39-8c75-4bc3-8be6-d3d1fc0e1a61@redhat.com>
Content-Language: en-US
In-Reply-To: <1eeb7a39-8c75-4bc3-8be6-d3d1fc0e1a61@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/10/24 16:20, Veronika Molnarova wrote:
> 
> 
> On 11/23/24 00:12, vmolnaro@redhat.com wrote:
>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>
>> Test case "stat_all_pmu.sh" is not correctly checking 'perf stat' output
>> due to a poor design. Firstly, having the 'set -e' option with a trap
>> catching the sigexit causes the shell to exit immediately if 'perf stat' ends
>> with any non-zero value, which is then caught by the trap reporting an
>> unexpected signal. This causes events that should be parsed by the if-else
>> statement to be caught by the trap handler and are reported as errors:
>>
>>     $ perf test -vv "perf all pmu"
>>     Testing i915/actual-frequency/
>>     Unexpected signal in main
>>     Error:
>>     Access to performance monitoring and observability operations is limited.
>>
>> Secondly, the if-else branches are not exclusive as the checking if the
>> event is present in the output log covers also the "<not supported>"
>> events, which should be accepted, and also the "Bad name events", which
>> should be rejected.
>>
>> Remove the "set -e" option from the test case, correctly parse the
>> "perf stat" output log and check its return value. Add the missing
>> outputs for the 'perf stat' result and also add logs messages to
>> report the branch that parsed the event for more info.
> 
> Hi Ian,
> 
> is there anything that I am missing? If so would be great to know the idea
> of your patch. This issue is getting quite old so would be great to get a proper
> fix together.
> 
> Thanks,
> Veronika

Hello,

just wanted to ping the patch. Would be great to sort it out and close the issue.

Thanks,
Veronika

>>
>> Fixes: 7e73ea40295620e7 ("perf test: Ignore security failures in all PMU test")
>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>> ---
>>  tools/perf/tests/shell/stat_all_pmu.sh | 48 ++++++++++++++++++--------
>>  1 file changed, 34 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
>> index 8b148b300be1131e..9c466c0efa857fc2 100755
>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
>> @@ -2,7 +2,6 @@
>>  # perf all PMU test (exclusive)
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> -set -e
>>  err=0
>>  result=""
>>  
>> @@ -16,34 +15,55 @@ trap trap_cleanup EXIT TERM INT
>>  # Test all PMU events; however exclude parameterized ones (name contains '?')
>>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g')
>>  do
>> -  echo "Testing $p"
>> -  result=$(perf stat -e "$p" true 2>&1)
>> -  if echo "$result" | grep -q "$p"
>> +  echo -n "Testing $p -- "
>> +  output=$(perf stat -e "$p" true 2>&1)
>> +  stat_result=$?
>> +  if echo "$output" | grep -q "$p"
>>    then
>>      # Event seen in output.
>> -    continue
>> -  fi
>> -  if echo "$result" | grep -q "<not supported>"
>> -  then
>> -    # Event not supported, so ignore.
>> -    continue
>> +    if [ $stat_result -eq 0 ] && ! echo "$output" | grep -q "<not supported>"
>> +    then
>> +      # Event supported.
>> +      echo "supported"
>> +      continue
>> +    elif echo "$output" | grep -q "<not supported>"
>> +    then
>> +      # Event not supported, so ignore.
>> +      echo "not supported"
>> +      continue
>> +    elif echo "$output" | grep -q "No permission to enable"
>> +    then
>> +      # No permissions, so ignore.
>> +      echo "no permission to enable"
>> +      continue
>> +    elif echo "$output" | grep -q "Bad event name"
>> +    then
>> +      # Non-existent event.
>> +      echo "Error: Bad event name"
>> +      echo "$output"
>> +      err=1
>> +      continue
>> +    fi
>>    fi
>> -  if echo "$result" | grep -q "Access to performance monitoring and observability operations is limited."
>> +
>> +  if echo "$output" | grep -q "Access to performance monitoring and observability operations is limited."
>>    then
>>      # Access is limited, so ignore.
>> +    echo "access limited"
>>      continue
>>    fi
>>  
>>    # We failed to see the event and it is supported. Possibly the workload was
>>    # too small so retry with something longer.
>> -  result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
>> -  if echo "$result" | grep -q "$p"
>> +  output=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
>> +  if echo "$output" | grep -q "$p"
>>    then
>>      # Event seen in output.
>> +    echo "supported"
>>      continue
>>    fi
>>    echo "Error: event '$p' not printed in:"
>> -  echo "$result"
>> +  echo "$output"
>>    err=1
>>  done
>>  

