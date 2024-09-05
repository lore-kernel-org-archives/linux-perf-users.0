Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97930199FC1
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543966; cv=none; b=qyeZOH4YLQDMiQR1FVuFb3HcRXtFFxC5OeoUuVeVOMvJ/RAejyMHEGqCTWHc3vr6Ud5junFGbD44k1aa5MWpOM/0BkUq1K58ey+jHsDxEr2q9kecM2fde11sjMNt/HwGyFitQ4oeeRRq83ZThCw4Z+cQ49EfWJUB13LNqh6Pbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543966; c=relaxed/simple;
	bh=W+3Gs/u0Q7aNzFD90Va26w8Z6M/QvYyngaXA843XeNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4weh/pmaP7J6TIyDWURc6cvSn1pCNCk3bfqukcSfFBZljj3PO2UAG4F41OtZ2WXPrcTqpay6AgIhA65Rm73U911jnZTUMLJbxHCVjcsSgmKfNiz/shDEmlp0G6WbiqDwi7AA/frlM6q5gD078q2sumNp5G9uQTAZE6MgNj+d60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kZnAQqgO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZnAQqgO"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so512114f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Sep 2024 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725543960; x=1726148760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zyz6pFyKS13jcngr5D+pVlHZ2kSZY/dQUD5D8I07IKI=;
        b=kZnAQqgOsMfz5mvmPPUMQl9MMWlJSHmsqrptRrnuNUueRDbHGzh/IP/puRVwVKt34p
         cFCh7wlUHGm9/HMqfMGrM5L/bJP4GVBWcF7xlsLK9d4bsYhbnngOpARZMd53b6eeaqjw
         W9th9xnQizzrlZdkM2owwGnEx9sml6rdbA9Z0ZyjA6XvCqfrC2hIUul0z7elqOIDMkE7
         dMuLT/qXvFzv6BKUsHdWVQyYV3X6zRvf0I9e2GoqYBCwCdQmvtxaTB7GiuCttun3x/+e
         OSXKQ0msPMXV2YI3LQs5ZsuOiaMEPY2vcx4o0xqlztLAMXxmeAfQJ+9twUj2uShK9jIB
         AwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543960; x=1726148760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyz6pFyKS13jcngr5D+pVlHZ2kSZY/dQUD5D8I07IKI=;
        b=Mz6FlHQv4uFIJWOkT+SuZT08OFaZhiXbW2DNFZ31F8J2Qc34l7fXK428vXQudv5Ffy
         tKIzB6dPgcRVNnrHNrFqdWjc9U/hgYyvhoQLU6i871WVpjP+jDHzGWkKl/EVsx7vQ8Vd
         /cpZcQHflFrdUavqlKM3pPLSw/H0T9Ancd05TaEID0rfyhcCWR+cirGNkX4l3WjDfk2B
         KFdrb/g0nj+7qYBJZODRmh/5ipC1Ha8e+r7M1/E3bRR4HfMXqs3AzOz5waOzI+dXAKTE
         qGbNFpaKVMFUdBCS/30Gag0UAKx5ECGpZ9+m33m5Uh6NQF3GA3kcFoNijQu+jwPgrztQ
         JqMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF48Qk6fCx3Qn2SIEpbQNDP/PVZVR/DLwjfH/tRCY2o6vZ0qY6mpqj+h9JZnA9HrO7CSV3MH0W2Eox8LFhKkgl@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFQiF5c4iGvtsYabpruaReQxFDF57OhVWIBMpRzomnGL2aVGt
	d+TiOQWDcvoL8r2UkZ1yQQlD3D9ajb8LFhb/1/46VMhSnuoRYvvFOG0eOzqYmCk=
X-Google-Smtp-Source: AGHT+IFTd/dMxVxNrn0Gfx4uaDg7GdrxMGlDnIH5uDcU5WJE9EgUPKodGXC7c7qsM7KrulA1ROAhhw==
X-Received: by 2002:a5d:45cc:0:b0:374:c4c4:efa5 with SMTP id ffacd0b85a97d-374c4c4f0e1mr9790437f8f.53.1725543959302;
        Thu, 05 Sep 2024 06:45:59 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-375348df4e8sm7708860f8f.115.2024.09.05.06.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 06:45:58 -0700 (PDT)
Message-ID: <21d05d38-a41b-44ac-a9ab-da7f749ea3f1@linaro.org>
Date: Thu, 5 Sep 2024 14:45:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/4] Adjust objdump start/end range per map pgoff
 parameter
To: Steve Clevenger <scclevenger@os.amperecomputing.com>, leo.yan@arm.com,
 mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1725493961.git.scclevenger@os.amperecomputing.com>
 <110501d82b12ea7909eb7d02899ef60ea42c7e19.1725493961.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <110501d82b12ea7909eb7d02899ef60ea42c7e19.1725493961.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/09/2024 1:11 am, Steve Clevenger wrote:
> Extract map_pgoff parameter from the dictionary, and adjust start/end
> range passed to objdump based on the value.
> 
> The start_addr/stop_addr address checks are changed to print a warning
> only if verbose == True. This script repeatedly sees a zero value passed
> in for
>       start_addr = cpu_data[str(cpu) + 'addr']
> 
> These zero values are not a new problem. The start_addr/stop_addr warning
> clutters the instruction trace output, hence this change.
> 
> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> ---
>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index 7aff02d84ffb..35a2ab60ca12 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -187,6 +187,7 @@ def process_event(param_dict):
>   	dso_start = get_optional(param_dict, "dso_map_start")
>   	dso_end = get_optional(param_dict, "dso_map_end")
>   	symbol = get_optional(param_dict, "symbol")
> +	map_pgoff = get_optional(param_dict, "map_pgoff")
>   
>   	cpu = sample["cpu"]
>   	ip = sample["ip"]
> @@ -249,11 +250,13 @@ def process_event(param_dict):
>   		return
>   
>   	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
> -		print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
> +		if (options.verbose == True):
> +			print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>   		return
>   
>   	if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
> -		print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
> +		if (options.verbose == True):
> +			print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))

What about skipping printing if the address is 0 rather than if it's not 
verbose? Seems like a zero is expected because that's for 
discontinuities, but other non zero addresses that don't match are a 
genuine issue.

And there is already an early exit for zero addresses above, maybe that 
just needs to be fixed to make it more general. But this one probably 
does need the verbosity change:

   # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
   if (start_addr == 0 and stop_addr == 4):
	print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
	return

Also minor nit, but I think this change in verbosity is a separate 
change to the change to add the map offset.

>   		return
>   
>   	if (options.objdump_name != None):
> @@ -262,13 +265,14 @@ def process_event(param_dict):
>   		# vm_start to zero.
>   		if (dso == "[kernel.kallsyms]" or dso_start == 0x400000):
>   			dso_vm_start = 0
> +			map_pgoff = 0
>   		else:
>   			dso_vm_start = int(dso_start)
>   
>   		dso_fname = get_dso_file_path(dso, dso_bid)
>   		if path.exists(dso_fname):
> -			print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
> +			print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr + map_pgoff)
>   		else:
> -			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
> +			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr + map_pgoff, stop_addr + map_pgoff))

I get this error here for this line:

   $ perf script -k vmlinux -s python:tools/perf/scripts/python/arm-cs\
      -trace-disasm.py -- -d -k vmlinux

   Traceback (most recent call last):
   File "tools/perf/scripts/python/arm-cs-trace-disasm.py", line 331, in
      process_event
   print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr
     + map_pgoff)
   TypeError: unsupported operand type(s) for +: 'int' and 'str'
   Fatal Python error: handler_call_die: problem in Python trace event
     handler
   Python runtime state: initialized

   Current thread 0x000075db4c249400 (most recent call first):
     <no Python frame>

   Extension modules: perf_trace_context, apt_pkg (total: 2)
   Aborted (core dumped)
