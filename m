Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974319AD48
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771742; cv=none; b=AzZHq7xgGWbvjL8X4/9EYLmFM3JivsDq3NphyANRQV/2csnuk8CWtfswMIpL2pK2mQE7F6FEyD9IbRH6CTKzFXlKHP5sEUS1DxhS224Tz6MLxF0g4kk9/f2l7MXC+e+K+rnwFbG78r78uds2WFZpaZ+CzeqpPti9uP91SusosEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771742; c=relaxed/simple;
	bh=EUva7MJQRyw9IDmeKpmiWTPXAvrzSFWCMB0KEr+1fWU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qiCuCOqMrLeg0mGLmUv0HEHyRNy0FGJNDLPqJdkR6TkCmiiedyOeFaJKHTu6fVMltBD3dNSnF7QCqdNNYz5+wLasC9ySvpyMExP/OvHmH/smtEhM8ldmS8+yzvtmiIYjegLN+J37G6hj4kRgUEHUOWlMwcI6k6+0pAVbBxwdJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOKspbsQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOKspbsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727771739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQQZkarnsN+ow7wUUCgTyrgoTfIFo9JQyF1gSGw1inQ=;
	b=NOKspbsQj75YrVNCvyIxn7NrkJY3y/W0z0VjSo9qeSLub6WQZO5XjGf3sMIzd5NSHYiwaQ
	ouEGiz4emtCDViR2IWKuoZUwoiD2c1h85tojH5g9FZVk6LnBgM3YGh0sdWm4whUdNabzeA
	tYwcf3b3n0NV6eH/2u/XmCiakTQDBwU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-s7NWO6hOPyKDnc0LGyb-uQ-1; Tue, 01 Oct 2024 04:35:37 -0400
X-MC-Unique: s7NWO6hOPyKDnc0LGyb-uQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb050acc3so28279675e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 01:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727771735; x=1728376535;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQQZkarnsN+ow7wUUCgTyrgoTfIFo9JQyF1gSGw1inQ=;
        b=Vxth+DPztRcVUtUhWI88/bC3PsvaMtKhaQVzbUjKkWiX5f+Ek+2y5RX6hbB+cvebzA
         Dos9OY2NF3cDF1pd/dcg765TQWJmno8ZtqS1+0j+T1h1QIUBf+Rec+SLbWMhXorQHIxe
         ynFmLhE7HZ99nw/xqFXAuPa98I9OT16/76vq8mbjWy+LNLRR3uyCDpyhVk2Z0467jNKa
         CLw3b5VVF7J7NCmh6IOLaq3F0PvXKnckYfji8xH0RhPMUw6I7oWWKjVcvkh4EEe1mWlf
         SdsgKalx9dhweC8ETbUS0C8yHz0BUWCED1uZX0njXVpa+MjPmivPUnpnwg7TW2KVtpsD
         uC6A==
X-Gm-Message-State: AOJu0YwS2AvEHCL4Oo+xaQ3SNVJqm18xisuRSGh51CpeVDdd0lgR2EvH
	NuIXzB4jVOSFkb6NTNU00BLh+zQbErWfBWHBQy83jic29DkcYOM7by1C8uI+Z/TXF3chNhOQbEm
	T8gFuDQZFKoEsC3QQvsTM1bxwW8m+hKWbbPoA9cbu2FeAgakIN2BiybL/qhhAcSrq1z2JQ/6Frw
	mliFJkUNG/w1slPynFEhQkTJqcqPj2wFkH7KdT9Gy7vUiP9k0jrMSLhA==
X-Received: by 2002:a05:600c:4fd1:b0:42c:b98d:b993 with SMTP id 5b1f17b1804b1-42f713119famr12624795e9.2.1727771734745;
        Tue, 01 Oct 2024 01:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJoxww95NKNQzG8VBvBIpVETYibpRhqKPLv2xuUGU7t7UIpu6UpFgs8Fj2x4uLDw5+BceuwA==
X-Received: by 2002:a05:600c:4fd1:b0:42c:b98d:b993 with SMTP id 5b1f17b1804b1-42f713119famr12624575e9.2.1727771734373;
        Tue, 01 Oct 2024 01:35:34 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e138f4sm126372685e9.34.2024.10.01.01.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 01:35:34 -0700 (PDT)
Message-ID: <dd62147b-e9b5-4281-b547-fef46082e4f2@redhat.com>
Date: Tue, 1 Oct 2024 10:35:33 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
To: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Cc: kjain@linux.ibm.com, mpetlan@redhat.com, rstoyano@redhat.com,
 mark.rutland@arm.com, jolsa@kernel.org, alexander.shishkin@linux.intel.com,
 adrian.hunter@intel.com
References: <20240814170146.20678-1-vmolnaro@redhat.com>
In-Reply-To: <20240814170146.20678-1-vmolnaro@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/24 19:01, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> With the upstream MR !3916 of commit ad86d7ee43b22aa2 ('powerpc/hv-gpci:
> Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
> stat for hv_gpci events without required permission set returns an
> error value of -1 to differentiate the output from the unsupported
> events. The stat_all_pmu test was designed in a way, that if any
> command exits with a non-zero value the test exits with an error
> value without any information provided due to the 'set -e' option.
> 
> The issue propagated upstream as the list of the files that affected perf
> did not cover the changed files and was updated after the issue was
> discovered. It was caught by CKI testing where it was triaged to stop
> blocking further MRs, as most of the powerpc machines have some of
> the hv_gpci events without the required permissions.
> 
> Remove the 'set -e' option from the test and rework the test case to log
> the status of the event for better maintainability. Instead of exiting
> immediately after 'perf stat' ends with a non-zero value, check the
> return value and output of the 'perf stat' command with the appropriate action.
> 
> Link to the MR !3916 of commit ad86d7ee43b22aa2:
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Radostin Stoyanov <rstoyano@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
> v2: Fix commit hash
> v3: Add 'device busy' for parallel testing
> v4: Change commit message

Is this version of the commit viable?

Thanks,
Veronika
> ---
>  tools/perf/tests/shell/stat_all_pmu.sh | 41 ++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> index c77955419173..a75beddda4db 100755
> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> @@ -2,21 +2,38 @@
>  # perf all PMU test
>  # SPDX-License-Identifier: GPL-2.0
>  
> -set -e
>  
>  # Test all PMU events; however exclude parameterized ones (name contains '?')
>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
> -  echo "Testing $p"
> -  result=$(perf stat -e "$p" true 2>&1)
> -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
> -    # We failed to see the event and it is supported. Possibly the workload was
> -    # too small so retry with something longer.
> -    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> -    if ! echo "$result" | grep -q "$p" ; then
> -      echo "Event '$p' not printed in:"
> -      echo "$result"
> -      exit 1
> +  echo -n "Testing event '$p' -- "
> +  stat_output=$(perf stat -e "$p" true 2>&1)
> +  stat_result=$?
> +  if echo "$stat_output" | grep -q "$p"; then
> +    # return value 0 if counters get printed either if the event is supported or not
> +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
> +        echo "supported"
> +    elif [ $stat_result -eq 0 ]; then
> +        echo "not supported"
> +    # return value 255 when the required permission for the event is not set
> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
> +        echo "no permission to enable"
> +    # return value 255 in case of resource busy during parallel testing of events
> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "Device or resource busy"; then
> +        echo "resource busy"
> +    # return value 129 when trying to run 'perf stat' with a non-existent event
> +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
> +        echo "Fail: Bad event name"
> +        echo "$stat_output"
> +        exit 1
> +    else
> +        echo "Fail: Unknown return value $stat_result"
> +        echo "$stat_output"
> +        exit 1
>      fi
> +  else
> +      echo "Fail: Event '$p' not printed in:"
> +      echo "$stat_output"
> +      exit 1
>    fi
>  done
>  

