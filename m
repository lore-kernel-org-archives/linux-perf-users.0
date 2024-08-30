Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674116DC18
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2024 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007032; cv=none; b=LUWdpihx4/W9KW3mt/HNM5gA7UMIc3kMzje9d9vNLJ5q0ybu4t37z4wFfBVA3Y4sx6f/kIw7MKC75HfrxUbQs51LzctwLUcY+rasdRjkVDt9vzZdAFrl0wd15D6ian1CYwVW85wON/E/ozxnZ9PU/VjKOEQE/x1s5i4DD757pkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007032; c=relaxed/simple;
	bh=zfa1T1gdUZwq4rVhGcFaFYQTRXA6gMGAhbYQ7XxE2Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwX3A25o9TJUnbYjlNXOXVIG2i/W5mjmZ+0lhzSHnTM6gKImoJUqw8DecynYP0XtvjFXmSWOeVVZDADLWW1ilkdTpzBVKH59CVbqCwOQwL+AswfD/e6+wAu9ooZqaRUKsulrxo3F+Y9GxITDOMYsCR2nmocwZ7RTgFnCNlH7BCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vsMU/Vh+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsMU/Vh+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428e1915e18so12939685e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2024 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725007029; x=1725611829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q97qi+NPXZmdP6linxr81NHdFxQIXiFaev92ohLiISM=;
        b=vsMU/Vh+e+FP7zLZwvp4XnY2PxkHqiXZsoFf/4aiib16i52d+NzoVYuMTR0jIdVEV9
         7lLN48gz5TOldcRKu5qYeAFg3XV6d9L407he39iBOx3ZtTeQM7FyK/LIjpeZAC6LN+Li
         WY+cnkh/a9AXHIbBpHJrYJhkJ9MQyDZ+aUG1JBQqEocB7FoxeLWMIcixmi6FIe0fZ+eH
         xx/YUA/mM+vDPBBRpNbXYkUBMQLWlGJXGPo0gPBNpoaKOpk38UE9+z4o4jvhenqW+mpn
         gOcA6pktaOTDVLQjU16oxerwr3YOyushhH8PwqwUTuZ2vyH1w5CtME5yIAF/ZBBM0Aj7
         E8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725007029; x=1725611829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q97qi+NPXZmdP6linxr81NHdFxQIXiFaev92ohLiISM=;
        b=My+JUKIEyBIThPPYWrIpM/uyTDXmIgJnbiTn3XYVi+SQzpQpniW0972CreJ3KuS9e8
         oQAOqnfud3DMmBfBliD3RIEDIANdbeEZt3aoISEm5WNK9QEUekU/AciTqHAy22zTZBBe
         ddVi7hgUNN+Qhzv1JtlIYQUUZWBHX3/YWwDZr1o5hfmANoHrXCvREJvUusm92mgG+Lng
         CQXBqBZ1RqA/mwGTAb6yvA9UCoF2Oa6IWoHtZaSbxGLyOGwZPQE751sLE+pK4jxRyJYt
         4IU3arvaAhVCEeEum8YF7ICdyPCHucEM/Y1On4SfAZinJIYP1LmTS05ZiJw8pgxSGXvH
         e2wA==
X-Forwarded-Encrypted: i=1; AJvYcCVuFdNpg0vim+FHA+5xssixMXuECiK49ang4vP395oeQKm5mOdwnjGXuXVZDAwNTwR43NwXXyseY3HT8xWxxPTP@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7FJjuBh/onCiVlwuUQ3Yn6A22NLc0nSvROLnvQkyFWlusfA4
	tviBY/CKKWShzxi2/0aEGSfrbh5B6wln723Ou/vcnhIn/EJCKeEbgnWxBSUs2gk=
X-Google-Smtp-Source: AGHT+IHg1jJiD58wDqMuaJqk1HwadfKudlUpN9Y4ONSFOCiQ/xd759tBR9XHQjM3McI2u6NEnVce5g==
X-Received: by 2002:a05:600c:3154:b0:42b:a9bb:924a with SMTP id 5b1f17b1804b1-42bb27a0dfcmr41442705e9.23.1725007028293;
        Fri, 30 Aug 2024 01:37:08 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb3efsm39328495e9.6.2024.08.30.01.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:37:07 -0700 (PDT)
Message-ID: <8afae0a6-5322-47a8-a189-68629ea1991f@linaro.org>
Date: Fri, 30 Aug 2024 09:37:06 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/17] coresight: Use per-sink trace ID maps for Perf
 sessions
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: coresight@lists.linaro.org, gankulkarni@os.amperecomputing.com,
 mike.leach@linaro.org, leo.yan@linux.dev, anshuman.khandual@arm.com,
 James Clark <james.clark@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20240722101202.26915-1-james.clark@linaro.org>
 <ZqOwGWcYosGe9ru4@x1> <6476a228-847b-4804-9229-c11a881663c7@arm.com>
 <ZqOzio8Oco9ZFsDm@x1> <8068c8ff-a8ce-4bcd-bb19-2c25b45cf6f3@arm.com>
 <ZqO3gPcCCVh1r5WM@x1> <aab886f3-ebbf-4853-b26b-5cf70c801683@arm.com>
 <7b96894c-f5df-473b-be50-ee118ce3cfaf@linaro.org> <ZtCUUsJNj9Z1CRLK@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZtCUUsJNj9Z1CRLK@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/08/2024 4:31 pm, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 29, 2024 at 10:05:02AM +0100, James Clark wrote:
>>
>>
>> On 22/08/2024 3:35 pm, Suzuki K Poulose wrote:
>>> Hi Arnaldo,
>>>
>>> On 26/07/2024 15:49, Arnaldo Carvalho de Melo wrote:
>>>> On Fri, Jul 26, 2024 at 03:38:13PM +0100, Suzuki K Poulose wrote:
>>>>> On 26/07/2024 15:32, Arnaldo Carvalho de Melo wrote:
>>>>>> On Fri, Jul 26, 2024 at 03:26:04PM +0100, Suzuki K Poulose wrote:
>>>>>>> On 26/07/2024 15:18, Arnaldo Carvalho de Melo wrote:
>>>>>>>> On Mon, Jul 22, 2024 at 11:11:42AM +0100, James Clark wrote:
>>>>>>>>> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
>>>>>>>>> as long as there are fewer than that many ETMs
>>>>>>>>> connected to each sink.
>>>>>>>>
>>>>>>>> Hey, may I take the tools part, i.e. patches 0-7 and
>>>>>>>> someone on the ARM
>>>>>>>> kernel team pick the driver bits?
>>>>
>>>>>>> I plan to pick the kernel driver bits for v6.12
>>>>
>>>>>> Perhaps it is better for me to wait for that?
>>>>
>>>>> Yes, please.
>>>>
>>>> Please let me know when you do so so that I can merge the tooling bits.
>>>
>>> I have now merged the driver changes to coresight/next, they will be
>>> sent to Greg for v6.12. [0]
>>>
>>> You may go ahead and merge the tool bits.
> 
> I'm taking this as an Acked-by: Suzuki, ok?
> 

Suzuki is out of office at the moment and can't email but he said it was 
ok for the acked-by.

Thanks
James

