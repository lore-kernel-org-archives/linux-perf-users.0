Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2522392C4B
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483585; cv=none; b=jTzRHj4yju+dN1EKG/DEuQtvw0Cqr4ArzjW2lVwb5gR6oIt7OfrqyTU5BOXIuWlBlvS1dT3WOQEBxCaSnhIxbj1nJ3LqWe/Z+boc8Yutjc2Y9KjtzPxAHJYZb9iqKyvuJztXcifkxLahdYJRulOQQrJUkmGYyiEQto0NiDuRE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483585; c=relaxed/simple;
	bh=+RTtXfxyz/OM4N8LoIdbI0BRF1j9mNTINWXhLlFGt9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kE2BwAtwRm2QuvduTYXIiPZ31p1q1yaz49pJ1BSvn/NVrfDpE2tf4J4xitVwhny6DurUQ2VuGgvEAgF/c5QjNTmVbDrMyuBdQhkpfENAJoea2Y6IniNE2JCBWtwn0AAgzcleNCWKGdgeVP0MLbUFJzdNBII5zJDmziZ/TgV99VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H5e0HreA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5e0HreA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso16655865e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780483583; x=1781088383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tl+jgcSk0dHHiZncMXgwXjUu4Qjxd08EiAtrl4yNhBg=;
        b=H5e0HreAK+v4P9fBa8/js/9yA8o8p1A6Q7ND/ICLnf7uwb/vWBicZBNpnPl/tazKMO
         fQJL+inhdkXEInYck2WUwwnvAOo2qZgKsygZQzXsdmISUdFxh6QpzlUrDAVseZxGZNEm
         thomBoYHzBREf8ByMEi+lefGJ/JVkURu9YTHEOvCRkUpGeX0dl0l2v7xkGc9HG0mx/d3
         gQU53aA3j0f3Oq0lQMCxMV61yQf7oW4f51iepeE4wPFiBiijZt+Q8spBD3pQO2EodbdR
         fF4gT1k8TOrNoGGaXBHtWg4VSqBU7Z2B2dTsZGXNSUzziALOeN6Yx1yWyVslgjhNFNdw
         9dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780483583; x=1781088383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tl+jgcSk0dHHiZncMXgwXjUu4Qjxd08EiAtrl4yNhBg=;
        b=ghxwIBNAsb840krDdk3QVIEedaHA0NDTsGsqP9ScRr3auSTJpvJLCYgri70zWvmPDx
         RYjVXh7Xgkz8ROo/8OV5Dv9I5w5Q4bDQhLCRVrV05eJluZAXPK1zF74ljCx/azb5CU9y
         IirsCUQoLeGpm7pfS3b2LcB5B3a2xMovRlpSlgaAp6od2P1Uq0Yix+Cz1prdyUjlBDBJ
         MeqJbxvesbkyn7hoHyj/DpWzAi/ETkid4AX+QF/3d9Z1kexxHBuuLvLAXpqBP22YKXHr
         UmnsRCtHxoTJkJmMqAAFCQRU+7ahdx5PrWrfDVAMMvqU4xZVb+4wJMw54xuP6Xv0TbCG
         OOow==
X-Forwarded-Encrypted: i=1; AFNElJ+B9QgA7fC/iBOgcZtnFt8MvSsW+dyTRcs4600C21vbbMLjrPJTKpVtfFKbNXQ/BWUIyuqFC9OWIV6G63O+V2Af@vger.kernel.org
X-Gm-Message-State: AOJu0YxlnilkGELfghlchiagwtm7vpGevmdedIUvXQRAi/gwC6JfkXf6
	uY1PmalYyTN6RzUhS65cq/7C8HfcuER6Htj932kbq/hHrSPaFf0bkvv950g6JNqhFBk=
X-Gm-Gg: Acq92OHLfa5ZnBn2L3nW2O5FF/xYAc/b0vSIIxNgE2x0lGqz3FeLXt5Ms/BW1fzjzzb
	QIbhJZBJn67tZCrc+6JMwBK63aIRBBcIBUQJxQml6AgBCZCinPXZbLWWIH+kUajyhv+DZOznOSg
	vwzqcHQ+0J5nwEL7qmoCRd8V+uEkqN0/O7zzStsfd9gi25sptf+4uTxWhEirw9pDKTGbj/u0LBS
	JXi6TglU7vrZKrId+Mq2Ax+YTqzF4PkvrUKLKldREaa7FR2H0i9qbWf8KCSamQJNt23NklBdmR7
	3jK1lv4oFq/jiwzASEh+6unhDexpEPFEspzEQSX1CaFnu7jaJIGCy2LSJ7xh58B6AthaqJ/a8Es
	1M4PU0odSeDxNSx6g+cl4jZ8gO5D3LclNqbSo4Kac8kfQIA821dgtbmjLGYQVJr+N5bZJ0j1JB0
	4sja+wz26LirSc5QlFOj36Jcr0eANWv8FifGwFLv4=
X-Received: by 2002:a05:600c:4ec9:b0:490:b642:ce32 with SMTP id 5b1f17b1804b1-490b642cebcmr45646065e9.13.1780483583275;
        Wed, 03 Jun 2026 03:46:23 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b6150bfcsm96449955e9.3.2026.06.03.03.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 03:46:22 -0700 (PDT)
Message-ID: <37a3de27-7e86-46d0-b73f-8b9139586387@linaro.org>
Date: Wed, 3 Jun 2026 11:46:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] perf test: Add workload-ctl option
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-2-85b5ce6f55c6@linaro.org>
 <20260603104001.GP101133@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603104001.GP101133@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 11:40 am, Leo Yan wrote:
> On Tue, Jun 02, 2026 at 03:26:44PM +0100, James Clark wrote:
> 
> [...]
> 
>> --- a/tools/perf/Documentation/perf-test.txt
>> +++ b/tools/perf/Documentation/perf-test.txt
>> @@ -69,3 +69,9 @@ OPTIONS
>>   
>>   --list-workloads::
>>   	List the available workloads to use with -w/--workload.
>> +
>> +--workload-ctl=fifo:ctl-fifo[,ack-fifo]::
>> +	Write 'enable' to ctl-fifo before running the workload and 'disable'
>> +	before returning. If ack-fifo is provided, the workload runner waits for
>> +	an 'ack' response after each command. This scopes the recording to only
>> +	the workload if used with 'perf record -D 1 --control ...'.
> 
> This new option doesn't work on its own. I would spell out in explicit
> words that it needs to communicate with perf record session:
> 
>    "This option is used to communicate with a perf record session in
>    order to control the recording scope. When specifying this option,
>    the same FIFO path must be specified in the record session via:
> 
>      perf record -D 1 --control=fifo:ctl-fifo[,ack-fifo] ...
> 
>    The perf test sends 'enable' and 'disable' commands through ctl-fifo to
>    control event recording. If 'ack-fifo' is provided, the workload runner
>    waits for an 'ack' response after each command."
> 
> BTW, I'd say the naming "--record-ctl" might be more close to the
> purpose.
> 

Will do


> Thanks,
> Leo


