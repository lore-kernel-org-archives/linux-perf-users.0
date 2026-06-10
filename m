Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB33A5E94
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085079; cv=none; b=t1iwvpGU278Jag685mbmRVsGcCUDyXYcJHYHkH8vHFeoCrYFgWqleH18lF+B/CI1vpOJEbc9AyldsgKgcwEV9jR5qvsQ23JM+Yc+yrvu1olDq5A1seDrwCArYDb0SpiidBBnPnpwKxAMKYSWY3zoNyuTJ1O2KIn5Jz1Uobyay1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085079; c=relaxed/simple;
	bh=pKA7DpH46SjVAcJNqrwdZ4g9oy71Af6s+blMUhkRXPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P58lpjl59cSlfwu08J4KgS8b0Uxw8qoTcMZQmarCbTAbuKKeoABjgjMO/TUFKWq5bn9ENUxqiqClBfiH02BZ42p/7t1NVI5AnSnNmJt73fasK4TQljQNdNr/Gw0Sv7aYc9t88CmEREmZrCp/xk00SjRNtkPlvxAEpzcWan1XXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFBOuyYL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFBOuyYL"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bf1141c26ecso816267166b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 02:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781085077; x=1781689877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VE3z35ezp2x26/gLg2UFK03+neYzzdYMzs/N6bRl8v0=;
        b=VFBOuyYLjmN5yJpQNeXgXPZBawKk/7s1w07qNajDyEC+3st3bq5fRXFjZirxaukHZB
         A696o0vtWlXDpDuCAnES/qHv3m5udgpgJDBLhh5m8nM8Nw+kvicbDTmVA2DlLevX0ztg
         hWTu+Z5gvEedysryAekSFJ7LMjauVilhxKdLEjhtYifsDQLp/58gaVtu/waZ5ZFctRaQ
         pgPjDVskse1lSC8gtOmSLkowKSojUD1XKfVDtCST096BvlR5bEYjRUSCOZtM1XnEta4Y
         NlkITB6d28M2p5P0UVcGso3RtlkGjzqoAN/Qqi4FK7sv0Wx49Uj6e6ms3DN3oOGOIRDZ
         l2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781085077; x=1781689877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VE3z35ezp2x26/gLg2UFK03+neYzzdYMzs/N6bRl8v0=;
        b=ou6PS5PiNHYFBbJJ/EXvz05HfNwkDZtkCWrrnKE5geTKQDpc/Pw2DVDuNMXnTShtw7
         81s4jpjNKV/qxH21KG8gmlm6fk+ZQNWR/OcJG9y1fBae5RlnRrg2t4T4cHXOVT3g6igY
         6niUskeXqePQUYrcaDkHjbPznNQO+2Rq7pVxEIxb6BxBpj4Hlh3JPmRmySik0SWDDsRP
         4umpt8BB5c6VD3yuSEu+iW05+ZEE3YCLD97R7ejsTg7l+u/KLJFGwUR6eVKya+DOaNhd
         mHNy2CIkJvuBmUIjcGwwnQffQRSy5K8hZQwzA6DkQz70onVGZ9/nF/Oeuk2b0+XI4O06
         wzVw==
X-Gm-Message-State: AOJu0YwqvAoEKAgwKnn6/LSFCsBMzj8WeQ12is12HfowMqQ2QuDLU92h
	C2iad8IgEjrRZChy665zFLkHRtJi4I2CRsVB4wMjE9WgYIfXDdzs37el8N8dwdNGsCt1y5izEIk
	dfXLsECQ=
X-Gm-Gg: Acq92OGYakpYKqGGzwmFH3TUIAEMwZ57RXyb3X+gYytfem8GnXWhVaZ62LOqOC5XsAs
	Y+ZtD0WUF3GP+lAY7/rJD1ibk8vS0nn9Ixke6Dd7ZSpwL6POfdWhDcK53uNWWebI3o0pr/ISMdM
	HTlw9CTx4yCbxcdOH6N5oTWOIHappFkcHrTblxHqCWqQ0+kwdsDvymrLpP4BzouUqvXCangYXLW
	8JuydOyFV5jcIf8mSsou7vrlYEhYJ3WcEFlL/qBPe68U63vlC6qiE+Qor9EPBxd2M7akBlZTDE7
	TV5RMSqPyDFi/Sb27RKjpEIJ9eRYJZ1+LCcMxIIOC0x0LEhxsq7Of3mmksy5ZF82PE7fOyvMYL+
	W421k2q2UqUnmc5llw7IJ/aceuTDVtboyW7hXPp3NtSGYJqFT+pqVpY1o8WX303i71tTI4i65r6
	nONCE1fFfrO8phP9lskdyskYoCQTXRFi8XDmD6IgJVW+FcU714Fw==
X-Received: by 2002:a17:907:3f14:b0:bed:a7d7:82c8 with SMTP id a640c23a62f3a-bf3737eebd6mr1303429866b.37.1781085076640;
        Wed, 10 Jun 2026 02:51:16 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0517721e5sm1176091666b.9.2026.06.10.02.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 02:51:16 -0700 (PDT)
Message-ID: <be7c5ecc-3fe4-4eff-a850-132a2be89753@linaro.org>
Date: Wed, 10 Jun 2026 10:51:15 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/19] perf test: Add workload-ctl option
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260609-james-cs-context-tracking-fix-v4-2-44f9fb9e5c42@linaro.org>
 <20260609144018.2D77E1F00893@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260609144018.2D77E1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/06/2026 3:40 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit message claims to add a `--workload-ctl` option, but the implementation actually adds a `--record-ctl` option.
> --
> 
> commit be5e10b3228f286fe50c54ca1ba231a4a933afc1
> Author: James Clark <james.clark@linaro.org>
> 
> perf test: Add workload-ctl option
> 
> This commit adds an option to 'perf test' to open a named FIFO and send
> enable and disable commands before and after invoking a builtin workload.
> This allows syncing with a 'perf record' session to limit the recording
> scope.
> 
>> perf test: Add workload-ctl option
>>
>> Add a --workload-ctl=fifo:ctl-fifo[,ack-fifo] option for 'perf test
>> -w'.
> 
> [Severity: Medium]
> This isn't a bug in the code, but there is a mismatch between the commit
> message and the implemented option. The commit title and message specify
> '--workload-ctl', but the documentation and code implement '--record-ctl'.
> 
> Could the commit message be updated to match the implementation, or should
> the option be renamed to '--workload-ctl' in the code?
> 

Will fix.

>> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
>> --- a/tools/perf/tests/builtin-test.c
>> +++ b/tools/perf/tests/builtin-test.c
> [ ... ]
>> @@ -1486,6 +1664,8 @@ int cmd_test(int argc, const char **argv)
>>   	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
>>   		     "Run each test the given number of times, default 1"),
>>   	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
>> +	OPT_STRING(0, "record-ctl", &workload_control, "fifo:ctl-fifo[,ack-fifo]",
>> +		   "Write enable to the fifo just before running the workload and disable after, with optional ack from ack-fifo"),
> 
> [Severity: Medium]
> This is where the option is defined as "record-ctl" in cmd_test() instead
> of the promised "workload-ctl". Does this option name need to be updated?
> 

