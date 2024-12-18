Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5718858A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516471; cv=none; b=Bt8TI6IdVkrfD7v/j1/vLsC+RtVJQajmrwPtcvj/spVhpk0no8WGbU86mH3Z1pGBeiY/m50RG69UExvU3v76KdIWswyFQ2cJUNl91Ku+Qd11bCtbmlHfslSqw6eju7P3JTy/UBuHR/U50WZRVphE2IqiRZxE9c0nYkHa4/YUWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516471; c=relaxed/simple;
	bh=EpOaBBpI2gBsXs78FbOMCk5NItVWAikaDlLzqWmHknY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NepVfdPtkj0erMTMRiFRBnMIkzwksTR7l9V8ZoeBlvOTboLasFSvdRzyqqQkPsW1YSBBdvHw+tamEDX7/KUUFEuWafBngVtIhM6YtUCP/LDHnNpWiXBHNdEItlBuNzYw+SzjGv5WdhTmotbpZy6QNFqO74Xj/29kU2bhSkVWsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fK61+wwn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fK61+wwn"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43624b2d453so68738665e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 02:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734516468; x=1735121268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9P17ieee9B5SlwZSInMZgc5AL5v6w0qOBx6blK3MkC8=;
        b=fK61+wwnjMKKqIRMlYijdPFT2/2FDPUJ1+dYtcqecA0XYsAQIqIHcPgRYTme2nMzea
         HUYiILhc399bG6BHkxlV1TSVhnWdFXjAsRbO3kga1d8jmwvm5eVYltdW5Rf3kxj9F3CN
         tXvlubL6bYkaEnvQ5LR+MX8YaqaFO4dSgiAloGzgLYC7gWE18SPq56KV63Y6fAxbQuPN
         4boT+1G2LWCvNGoWJfbOlzW+qtf2nNlVEXzRirRggmmip/MtYz9aeS2E/e0wEQSqwX0r
         +7g6lcaxcji10wXtaX92J+pIE6EiX8IePuVbJD2OINeK8mE5IBk49lQotbiKZOnArQOh
         Sj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734516468; x=1735121268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9P17ieee9B5SlwZSInMZgc5AL5v6w0qOBx6blK3MkC8=;
        b=TqtxFzIRu/EW8hXxdyHHribOs2UmmV5I0yOoslWsb7dcIJQjTEGgb6nzW7k0PY7w8w
         8ZlBQqihpYVDU6Rui/YzkLLUIJMQ/RLm1LOB6hx10ZoyFIcqRc1sGmcBdTSGd43TOw4t
         krltXMpBx+ZLCag+5kE8HUmy8Ma20IDHKdUbzVjajGXIBUj4Rsjrb8y4FJOHkHlL7IcF
         +trDsN+9RXgBcc+DwfpUn21aZ6HRqneG32CDzX8U5FOMTpSgpC3Sg9bbpHgS3JwgCivp
         5LEaFxcnimUBMoUqfAjaAFWSSkDF5RINcXCCMh70fyB8qnmJEHWzVAlROnG2yfXJxJd0
         2/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXHsceWXmexJmVcNtEum2Kd/2OUJA3Iq53SaXiIo7Hq8JHBAasWEAwUKNZgrBDDDYW+ROtj9Pd78VThj9uckJtI@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLJgUo3YJHcJiimgr/NegBFANur4Xm69fwhjQhS+YHiAKWfAS
	bpn1RAFm3tL4DsPP0q4l8769ovJVHryFY8YnKjRTzrcd9MOdYPHN0F3rpOySc1CRUjH+r1udoBm
	g
X-Gm-Gg: ASbGncv07100U9mhY9UDYmnSJFQSvGW1kpJmCbMwBahSHtGg1MUjFIVYrNX+88bZrJm
	en+PfQgKOY8eFWha5u3NgtkAIgIETBOdATrBGrQ+6vQ1/oGL8XmDEeNfKbHsgEY0Eg/85AokHFm
	Me7SuLBw/dCWgLpmP6pZ6997J0+RikHWuxv5Kkjo8V0wzaJa7woe7df9jA4eTjI6liCaVc322+9
	Lv+XfLcF4YDv3TxTwDX4sUezkSW+gObnl5zI3QSxR3fhwbSNMRIYBdGYzOjp90gRlQ=
X-Google-Smtp-Source: AGHT+IHC2RZ1yHVWgEcKRYnXsTSt7w3TIR3YVn7d27iergCOQv1IMX81+xjenYwudQOzwGcr5LlErg==
X-Received: by 2002:a05:600c:3b14:b0:434:fec5:4ed1 with SMTP id 5b1f17b1804b1-436553fe571mr14370955e9.26.1734516467662;
        Wed, 18 Dec 2024 02:07:47 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80613a9sm13518151f8f.101.2024.12.18.02.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 02:07:47 -0800 (PST)
Message-ID: <8c15786c-47b6-47ff-b1dc-ecbf32d582fb@linaro.org>
Date: Wed, 18 Dec 2024 10:07:45 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] perf docs: arm_spe: Document new discard mode
To: Ian Rogers <irogers@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Graham Woodward <graham.woodward@arm.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241217115610.371755-1-james.clark@linaro.org>
 <20241217115610.371755-6-james.clark@linaro.org>
 <CAP-5=fU7RNzvzxBcAQy3RT9Ge3YtqPhDonupNWS7Wgb8HGQkGg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fU7RNzvzxBcAQy3RT9Ge3YtqPhDonupNWS7Wgb8HGQkGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/12/2024 12:54 am, Ian Rogers wrote:
> On Tue, Dec 17, 2024 at 3:56 AM James Clark <james.clark@linaro.org> wrote:
>>
>> Document the flag, hint what it's used for and give an example with
>> other useful options to get minimal output.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/Documentation/perf-arm-spe.txt | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
>> index de2b0b479249..588eead438bc 100644
>> --- a/tools/perf/Documentation/perf-arm-spe.txt
>> +++ b/tools/perf/Documentation/perf-arm-spe.txt
>> @@ -150,6 +150,7 @@ arm_spe/load_filter=1,min_latency=10/'
>>     pct_enable=1        - collect physical timestamp instead of virtual timestamp (PMSCR.PCT) - requires privilege
>>     store_filter=1      - collect stores only (PMSFCR.ST)
>>     ts_enable=1         - enable timestamping with value of generic timer (PMSCR.TS)
>> +  discard=1           - enable SPE PMU events but don't collect sample data - see 'Discard mode' (PMBLIMITR.FM = DISCARD)
>>
>>   +++*+++ Latency is the total latency from the point at which sampling started on that instruction, rather
>>   than only the execution latency.
>> @@ -220,6 +221,16 @@ Common errors
>>
>>      Increase sampling interval (see above)
>>
>> +Discard mode
>> +~~~~~~~~~~~~
>> +
>> +SPE PMU events can be used without the overhead of collecting sample data if
>> +discard mode is supported (optional from Armv8.6). First run a system wide SPE
>> +session (or on the core of interest) using options to minimize output. Then run
>> +perf stat:
>> +
>> +  perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
>> +  perf stat -e SAMPLE_FEED_LD
> 
> Perhaps clarify this should be an ARM SPE event? It seems strange to
> have one perf command affect a later one, the purpose of things like
> event multiplexing is to hide the hardware limits. I'd prefer if the
> last bit was like:
> ```
> Then run perf stat with an SPE event on the same PMU:
> 
> perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
> perf stat -e arm_spe/SAMPLE_FEED_LD/
> ``
> 
> Thanks,
> Ian

Hi Ian,

Confusingly this isn't an SPE event, it is a normal PMU event. The fact 
that one Perf command affects the other is because these events only 
count when SPE is enabled. When it's enabled it has an effect on a 
per-core level which is why in the example I made it simpler by enabling 
SPE system wide.

SPE is an exclusive PMU like Coresight and some others so it can't be 
affected by multiplexing or anything like that. The SAMPLE_FEED_LD PMU 
would be, but as long as SPE stays enabled it will count the right thing 
regardless of multiplexing.

THanks
James



