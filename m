Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D03168C33
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007517; cv=none; b=qcHXUGnKUS19OEEI3HYTkd93HNkGZdWoVsO62k4Xs9BcrmAfaZ40oRBEYVDtyvabD4grAunmVR9UJYzsC+DDIBdsMEwpSolebdVdD68RagJmpOo8zbkzxbmWqbVIUsiQtHHcOsUIysED7xhhcm83SvutvAUVfaRYAh2r/TAdVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007517; c=relaxed/simple;
	bh=MMkSd1XMIyMMdP07G3KaYGGyZglrQmbQc3wjVWIulQA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=huLN8vm6TWkvjAlxMNmTUOxWzaYnUkzubgXDaFe1IW0494BdD25bILSmoJi9Nyazmx5uau8H9rmxTEVEy1meASgp6ERYyw+P3DebbgJpgQ2hRRmGLzDbeIiveP4uMB5s7jLySr1YPd+XbgbmwK3JKgvh4ZI2/3V0q47ax3Q1zDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZxG5gGKK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZxG5gGKK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso13218515e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2024 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725007514; x=1725612314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FFvEi22aaFveU/v85aARXCtDR6noK8yhzMwhF2L+8zM=;
        b=ZxG5gGKKeXEvfp1TtqJg4/UpEb99YJC8pgdtS1kx1jxT7QMZgkHXOGkWgVxSksez8O
         93hHCcyllsouxykb/DMnKSrzP7HZGn/sMIFwXQtPc5TAkoMc8mxIN5wpIgnQIidfTbSa
         1E8/xhCWXUGnIXGbM7qesrfF/oLl5pLie/dtfNTAY94lRQeAd0YcOu8+H6JstC2jLUF6
         55/mNwszPZt1q2VvHL8S6m1HQk4mJ1wiUB9X1Dw4obni4BXg+HHT1UZg/zIn3tLs6E5g
         e9wXR4M2hiWtOtxcPYwb1AvlmkE5TYc4xIj4jD9rivwfT+i7+zhtd4zXGQjC0BwGMb19
         SrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725007514; x=1725612314;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFvEi22aaFveU/v85aARXCtDR6noK8yhzMwhF2L+8zM=;
        b=IbFRTG+fUw07rzQqU8AqngvlnWaHTTis0bxHhiZ4mk09h23y7kVXdfM6X8lPCOG2eH
         IdivIP0S+5M2Qgx4LN7v2FCL1opwprA/DfgtHbJa1zSWayxUqo9FGVy92mdCMVLFGxpK
         fvbU2WvG3jbn07/lTDtFdiT1cg9T0ER/LnEQP2+5e1zUu9HNKMZMfjUS4wGn3RZiQHIF
         pAx3yQuaAX1N+Z1PmTpe4WIrTkZuG8a7ZSWlEHSk6qsoKgo5T7O7oPuU0GoL8yiHcpTS
         NN1Grz1d2LKKc4ifbPd2ZeoAASW8bhBz1rIYeKVEi3HemSsYv+G7D/cMy1/StwWgS3t8
         hrGw==
X-Forwarded-Encrypted: i=1; AJvYcCVv3Kui7FxVVB4vEuwrS31fXmcInVRjM+nitnGCnFUKpb6iYZMEcorJGt98sTFrFsj8iRVbRDrfxxpuXvjAGpBo@vger.kernel.org
X-Gm-Message-State: AOJu0YwIxZeXJkv7zWnIKoBslH1/3xZcv4cHd0UMWWtCwzU9BTDRlHfX
	ii1ABf54XBgo8o7Xni2FhZYnEORDK50J/4fuk+K8hzQLxiE48tagRhc2T4hWOZGnFk5zO3UFIw9
	JnRA=
X-Google-Smtp-Source: AGHT+IHnzDSOe8kd9fvuLoVFjLC1R5c/WM+ttCvQdw8+ztum16kSwXDjQlWZTWhokM7kdzCwcNZT1g==
X-Received: by 2002:a05:600c:46c9:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-42bbb436e9amr10518395e9.25.1725007513329;
        Fri, 30 Aug 2024 01:45:13 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639d512sm71843875e9.18.2024.08.30.01.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:45:12 -0700 (PDT)
Message-ID: <b9a1f3fd-de17-492b-91c3-950131912f71@linaro.org>
Date: Fri, 30 Aug 2024 09:45:11 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] perf test: Add a test for default perf stat
 command
From: James Clark <james.clark@linaro.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
 kan.liang@linux.intel.com, ak@linux.intel.com,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Yang Jihong <yangjihong@bytedance.com>, Ze Gao <zegao2021@gmail.com>,
 Sun Haiyong <sunhaiyong@loongson.cn>, Jing Zhang
 <renyu.zj@linux.alibaba.com>, Yicong Yang <yangyicong@hisilicon.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240828140736.156703-1-james.clark@linaro.org>
 <20240828140736.156703-8-james.clark@linaro.org>
 <ZtFnbq_158fxttmW@google.com>
 <52de8df9-4554-4bc0-9735-fdbd197dbb7c@linaro.org>
Content-Language: en-US
In-Reply-To: <52de8df9-4554-4bc0-9735-fdbd197dbb7c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30/08/2024 9:29 am, James Clark wrote:
> 
> 
> On 30/08/2024 7:32 am, Namhyung Kim wrote:
>> Hello,
>>
>> On Wed, Aug 28, 2024 at 03:07:21PM +0100, James Clark wrote:
>>> Test that one cycles event is opened for each core PMU when "perf stat"
>>> is run without arguments.
>>>
>>> The event line can either be output as "pmu/cycles/" or just "cycles" if
>>> there is only one PMU. Include 2 spaces for padding in the one PMU case
>>> to avoid matching when the word cycles is included in metric
>>> descriptions.
>>>
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>>   tools/perf/tests/shell/stat.sh | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/tools/perf/tests/shell/stat.sh 
>>> b/tools/perf/tests/shell/stat.sh
>>> index 525d0c44fdc6..24ace1de71cc 100755
>>> --- a/tools/perf/tests/shell/stat.sh
>>> +++ b/tools/perf/tests/shell/stat.sh
>>> @@ -148,6 +148,26 @@ test_cputype() {
>>>     echo "cputype test [Success]"
>>>   }
>>> +test_hybrid() {
>>> +  # Test the default stat command on hybrid devices opens one cycles 
>>> event for
>>> +  # each CPU type.
>>> +  echo "hybrid test"
>>> +
>>> +  # Count the number of core PMUs
>>> +  pmus=$(ls /sys/bus/event_source/devices/*/cpus 2>/dev/null | wc -l)
>>
>> Is it working on non-hybrid systems?  I don't think they have cpus file
>> in the core PMU.
>>
>> Thanks,
>> Namhyung
>>
> 
> Good point I only tested on Arm non-hybrid. I can change it to assume 1 
> PMU for no cpus files?

Or maybe assume 1 if a /sys/bus/event_source/devices/cpu folder exists? 
Not sure which is best but either will work.
