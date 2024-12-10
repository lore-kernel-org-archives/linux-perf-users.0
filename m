Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C568A1B425E
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844059; cv=none; b=ccnsc/2uKFvILn3DQ2bvgW/INdto+jZWFLIqA1vRocPCmR32ot/m0fEl4exvNvsQlnYx84pfCap3h1gj7EyeSQKz5IYZCMh++uTcAJfS7BHPLGxcvUIiCSh3OIT7IXEHBtWj3hM7DV66EJYAknVMcLtMuDipgH0x9f+IYhcAPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844059; c=relaxed/simple;
	bh=wjRewe743jEnSGSEjQ+JwsiZj6kPnEhUutxxWRGLUCA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j4RUozpxxNlKscqeRpe0i9m/AQoVjccVgWCNYeQjYW4mc/1Ypxol0dd5NF+8E7wsrNKVXbXx3TAoV6nXkDxcIYXES+f4tX41V26FJmeq2M3f0aGd7IB5JEsK7NO9upaECVGHpEa/OjiGXKClyzN18CxmWoUfEYFUShG8qeXe7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYwiQQRF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYwiQQRF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733844056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lU14govZMtqIK1caNEYRkuRxXWh9YhK9AeHyGMwafew=;
	b=YYwiQQRF4ynBgNSlK5lHKfXvWSUo0GVq8/mqevdD/UsuFi4TmmDbr9Ly4whtddO7jXDO99
	tKuvnC5WR/Q2R6nNs5KDBjX4Tc+QKcWWh9Px/JYwi+ftPtaCAGaxQHq1DsxVmT4s1GmuZX
	reSN4QWRLaJUGVNyN1Oy22w9rk8lv/0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-D3U49-IQOdW9eFvfKnBftg-1; Tue, 10 Dec 2024 10:20:55 -0500
X-MC-Unique: D3U49-IQOdW9eFvfKnBftg-1
X-Mimecast-MFC-AGG-ID: D3U49-IQOdW9eFvfKnBftg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e27c5949so3416675f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 07:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733844054; x=1734448854;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lU14govZMtqIK1caNEYRkuRxXWh9YhK9AeHyGMwafew=;
        b=tQZ4Av+ZXDnBjswYdRzQAvxdg/eiIRMEW0+dRLjS9nL1WvXBr+1/cgAdiK/Gytpk/u
         ioZT5Yj6zx7lAwNw3DGxzY8Swz8bR06OlqCpxcMHiY0uT3ul/gWYycVb2PGb9VCYNX7a
         +ewqmIrobUtTitHi1RW7ZjltLGHdnKgYiUEOlzZ50Tr1Wv7W3ZqP7ZwJhlqNYHqNkvV9
         WYBEYuBQZanpMlAzQqqf5jAZ8qoT5MhIlFK9FAZQE4qMdfOsNcgyTdG7NATOAWeX5FNT
         psJa5IsvyfSSCxHFWjnEiZoNfXTIVFDmkbTnCrSGQHyAUxe/dmNImSecVV54oXQqxLSd
         z2pg==
X-Gm-Message-State: AOJu0YwKmFrhjanQ73bXb4z7bhK7WGnqsQlOJqMU1utlb4FpyA9Lk32Q
	A0OUPoQkH+/f0hujQhbP/s8WxhOcrQlI9J1GFJh9EdgLtP7mDmnk9heSHHX76qpeQzszBuESmJh
	dLjGJkvLQh9+Vp7QU4oNXyiL7DY2Xy1pWBMe6t+iHpVLL7sDUhyDeEf6bjeP9gS2NEijpwXqV0z
	9y8jVzo2eBKAFSQfAqYjABNMLZnP/lt2ha23FofxegRwUTT9W5uPQN+g==
X-Gm-Gg: ASbGncuOMEE2ydQgmIzxMq2dFOT7gh3bgihF662ie08QahH3PdlOgybW5r/Blw8ywn+
	niT5IQ7n88fx1Es8eyT42ElI17JXF//liT71viAV/r5NYflmj302Ar2FIc8Dq0ofRw6p9C+PtkW
	HsKMSNLGrMI/pEQo+8CWHMjMUisOFbzP1vMUlkEVLySA08PGijLXXuqN1Ir4LoNCyFnsU0qvFMC
	7JcEWGk5frKRt07MeYbD2DMwsAfnd8eab+sAIk7rZqftfZT2OcQkqtmU/UkMLdJFr6ylQmE/g57
	B/ei
X-Received: by 2002:a5d:64aa:0:b0:382:3efc:c6d8 with SMTP id ffacd0b85a97d-3862b33376dmr13659535f8f.12.1733844053967;
        Tue, 10 Dec 2024 07:20:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9sfp0IKBQPJXYXVR05+HPuHv/LChXjZe7LNEeYvfJ05OjpZCzEOoYw5o+PMlRnswpDzXpcA==
X-Received: by 2002:a5d:64aa:0:b0:382:3efc:c6d8 with SMTP id ffacd0b85a97d-3862b33376dmr13659497f8f.12.1733844053521;
        Tue, 10 Dec 2024 07:20:53 -0800 (PST)
Received: from [10.43.17.72] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f44eaac7sm92216045e9.42.2024.12.10.07.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 07:20:53 -0800 (PST)
Message-ID: <1eeb7a39-8c75-4bc3-8be6-d3d1fc0e1a61@redhat.com>
Date: Tue, 10 Dec 2024 16:20:52 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Correctly check 'perf stat'
 result
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
To: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
 irogers@google.com
Cc: mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 kan.liang@linux.intel.com, qzhao@redhat.com
References: <20241122231233.79509-1-vmolnaro@redhat.com>
In-Reply-To: <20241122231233.79509-1-vmolnaro@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/23/24 00:12, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Test case "stat_all_pmu.sh" is not correctly checking 'perf stat' output
> due to a poor design. Firstly, having the 'set -e' option with a trap
> catching the sigexit causes the shell to exit immediately if 'perf stat' ends
> with any non-zero value, which is then caught by the trap reporting an
> unexpected signal. This causes events that should be parsed by the if-else
> statement to be caught by the trap handler and are reported as errors:
> 
>     $ perf test -vv "perf all pmu"
>     Testing i915/actual-frequency/
>     Unexpected signal in main
>     Error:
>     Access to performance monitoring and observability operations is limited.
> 
> Secondly, the if-else branches are not exclusive as the checking if the
> event is present in the output log covers also the "<not supported>"
> events, which should be accepted, and also the "Bad name events", which
> should be rejected.
> 
> Remove the "set -e" option from the test case, correctly parse the
> "perf stat" output log and check its return value. Add the missing
> outputs for the 'perf stat' result and also add logs messages to
> report the branch that parsed the event for more info.

Hi Ian,

is there anything that I am missing? If so would be great to know the idea
of your patch. This issue is getting quite old so would be great to get a proper
fix together.

Thanks,
Veronika
> 
> Fixes: 7e73ea40295620e7 ("perf test: Ignore security failures in all PMU test")
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
>  tools/perf/tests/shell/stat_all_pmu.sh | 48 ++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> index 8b148b300be1131e..9c466c0efa857fc2 100755
> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> @@ -2,7 +2,6 @@
>  # perf all PMU test (exclusive)
>  # SPDX-License-Identifier: GPL-2.0
>  
> -set -e
>  err=0
>  result=""
>  
> @@ -16,34 +15,55 @@ trap trap_cleanup EXIT TERM INT
>  # Test all PMU events; however exclude parameterized ones (name contains '?')
>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g')
>  do
> -  echo "Testing $p"
> -  result=$(perf stat -e "$p" true 2>&1)
> -  if echo "$result" | grep -q "$p"
> +  echo -n "Testing $p -- "
> +  output=$(perf stat -e "$p" true 2>&1)
> +  stat_result=$?
> +  if echo "$output" | grep -q "$p"
>    then
>      # Event seen in output.
> -    continue
> -  fi
> -  if echo "$result" | grep -q "<not supported>"
> -  then
> -    # Event not supported, so ignore.
> -    continue
> +    if [ $stat_result -eq 0 ] && ! echo "$output" | grep -q "<not supported>"
> +    then
> +      # Event supported.
> +      echo "supported"
> +      continue
> +    elif echo "$output" | grep -q "<not supported>"
> +    then
> +      # Event not supported, so ignore.
> +      echo "not supported"
> +      continue
> +    elif echo "$output" | grep -q "No permission to enable"
> +    then
> +      # No permissions, so ignore.
> +      echo "no permission to enable"
> +      continue
> +    elif echo "$output" | grep -q "Bad event name"
> +    then
> +      # Non-existent event.
> +      echo "Error: Bad event name"
> +      echo "$output"
> +      err=1
> +      continue
> +    fi
>    fi
> -  if echo "$result" | grep -q "Access to performance monitoring and observability operations is limited."
> +
> +  if echo "$output" | grep -q "Access to performance monitoring and observability operations is limited."
>    then
>      # Access is limited, so ignore.
> +    echo "access limited"
>      continue
>    fi
>  
>    # We failed to see the event and it is supported. Possibly the workload was
>    # too small so retry with something longer.
> -  result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> -  if echo "$result" | grep -q "$p"
> +  output=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> +  if echo "$output" | grep -q "$p"
>    then
>      # Event seen in output.
> +    echo "supported"
>      continue
>    fi
>    echo "Error: event '$p' not printed in:"
> -  echo "$result"
> +  echo "$output"
>    err=1
>  done
>  

