Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474FE16D31B
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006948; cv=none; b=SDgTWxfAFAM4JHx1EnCOLBROyRKpYPGfbTmRWnr+LRoq/oAGNix/0VrkmTGZwdJlPKK3azfpIqdAs9myIp4aI0y2O1VXsAUyKbZuwgZDNAUosjCiDv2XUT0aAGyyGmu8UvptZrEuzAS0hvsb6i6Fyw7UN9ahNaXC+pAv3NIfsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006948; c=relaxed/simple;
	bh=/yC4n1ZnnZ996SSJcD6Xr4o/5hyPYxr8s7D7HElsUME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5gqCYYnsZZ2voIVpCzjbqVx2PO+3mRjpWMu6jkZBUJd3EoS/a0YiDF/QsfYvf1n4gtGoNG7zxLheyYtwuv456SW7Rhi1arIYdakYafUA8/cQWyYdT40NT/QlONPnsFXlAjpRbNFEVRY5w3v3GxAFrZqcpclrW7NYoZNUCqwWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oydtrN2F; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oydtrN2F"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bb72a5e0bso12682175e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2024 01:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725006945; x=1725611745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDgErpkUKnQe50JSRwQXTxpchIY80U2OBlsTDwNP1cQ=;
        b=oydtrN2Fbx0E6NTowOJqvynwrKMlM/OA2frmvJo27ma4wUJMTfKAZSZqHa3ld+SWgs
         q5KpJjsLb7PHS8Y8j5LFO5sFrTb901ip/hy/rhx3bIdrBBlZkQP95Sn5RNTlvWl9iNYG
         cZR/IRbUdW6+oXaSBIm5WAKaare/nlMEwqtL5HoI8jRx0frb8R9C/dGHALL6ZWAWYIyZ
         GOGOECRohn0NnKZNv4Aiy13AmFqr2hDy7YuDpNkEERMpIl4rFI16xwV9/jPA6vYT1F7V
         zylIbjcvNOok7d/p6gukKCJqA111Qd0zNwcDk5JiTV+GVoSNpyb+CR7L+bMstgjUlmqp
         M5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006945; x=1725611745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDgErpkUKnQe50JSRwQXTxpchIY80U2OBlsTDwNP1cQ=;
        b=BTxVW4OYPOfqV+Zj+k8lCXWjeQ6cH8aXTh0Jh2ki5LQvRPtRuJnC+iO9rkqQvFe4kC
         1rhV1tHB2y9rhvJZnCKW/+6TvVg+CvGcrpTVIAOlp+On/wSxhvO2jd0EevACQWndKR/b
         BasPY4a2UFfLmCR1CvV3HOyaJ98NVoa69mS7W/i8PuY+q5CCL2eJkHcGhGsVU+yiUROM
         7tDCURFxnvhXtmGXllnzL78ijYtu+Rj0o6PWzRdflYsicrBNo3YschGoJ7MKmQSw1fU3
         MEvfL+O5hY2kviwUl2g8EF/aapxFWR0vV0KPQl4L7ZsIOp1Y3XX41o82usDGe+uXCsW5
         0UXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2hBJuftU+EBFW+Gld/hMxtjn7vxj35mFDPsTiTYtVDSDEaH0BQbJSQwpLsDeCQqAt6vhBd8ohWjhbNak8X9E3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7EZi6h17Zw4GcZgAscQS1P+Nx1KnpB4reiaozZsmOSqJZTHBY
	HtsgNRyGKxyQLKrAtn5I3R7UlvyVQOZnWVHM+qkwKZFSEKGp3U3RjMtfjZOX1RY=
X-Google-Smtp-Source: AGHT+IG2YQtB+es4bpO/DPjIWcCbaKmtKE3m6I0KAaWGTR3kPHJqRAnzrYl/zAokjrpuA+J7gIfXFQ==
X-Received: by 2002:a05:600c:4585:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-42bb01bfbdemr48151025e9.18.1725006943921;
        Fri, 30 Aug 2024 01:35:43 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb239sm39581435e9.5.2024.08.30.01.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:35:42 -0700 (PDT)
Message-ID: <18a60d79-e94d-4fe9-ba9e-867bed175a6a@linaro.org>
Date: Fri, 30 Aug 2024 09:35:41 +0100
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
>>> Thanks
>>> Suzuki
>>>
>>> [0] https://lkml.kernel.org/r/172433479466.350842.6920589600831615538.b4-ty@arm.com
>>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>> - Arnaldo
>>>
>>
>> Hi Arnaldo,
>>
>> I just checked and the tool patches still apply cleanly if you're able to
>> take them.
> 
> Sure.
> 
> - Arnaldo

