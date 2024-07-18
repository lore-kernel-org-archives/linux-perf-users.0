Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79C13B588
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313043; cv=none; b=OFx34x8i79V5QDKzXCuqG7HLfVJR79dQVHH40YWosNbpfjxcC0oiBmyIjuj/mrVcwIFKo1npHcB+xNm72+ncL6ewXgM6GuzRBckE2ol4OdqdLe/t53AmkTV13PFd+BSy5+72nzMfclaPJcnrd7981RvlUpWcLl9P1VfqnVvHnsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313043; c=relaxed/simple;
	bh=n+PSSMI6nv/YfKu3UdJHQRKmZ2cGqYsPVsZRJpNlM1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tn2cWDyTx69Ln3KrHguKcu77PKxawSwHdOz/2OPRqTeD08UNC+5rwHoseXvrwlSudb36rgIZ/qzdqYDRrzmRKYZdmxpsomMRfnZEJbMkHJJRTNMsYPKYWuTUmHQPT1C9rE4p0CQiYdsrHZNdT456OtPhznqLGsxO0F4AYlKCjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IyQACnWm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IyQACnWm"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-368663d7f80so200164f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721313039; x=1721917839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dj5LMN7WC5hyXsTa12aKoD9fUdmkTYmEKmHMU1kkuso=;
        b=IyQACnWmJG4BZu48o1A45H6J4GXda6KCo8xDqkW6VdX/lX7cM0He7KJlgmLt6wnf1A
         YMWEajXNAaXAh5geda+2HHhSyie7Lq/fZGQE0pfQWHk0ApWkUyhQ7nmD340tyGEXFlFU
         ofHE6uYKck8AzshCxGpL8xZW4mJaxMpvF6LjtVMbSGZuGvOs8p31wfp6b6JVDXybzhoJ
         aY9KLNhFaYwG6nWIAiyHe3kco6Zh0hBZBBiK7iqaKIuW/Y10rCjbsjNLJL+TbfaPaRhG
         1w183P7gMVK4DvtNKEEJcUdQb5GnipbP94HldRsRXFQuLjVAFyTktEThhAQNR/bliMjX
         63cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721313039; x=1721917839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dj5LMN7WC5hyXsTa12aKoD9fUdmkTYmEKmHMU1kkuso=;
        b=n/ALw9zGEmDMJcaSjzh5ca0foz6o9E1DTAkqkl9q3j74pbE+06PpJfe4qUZ+VnXXEs
         0ocDYwMLyLK7oO1mkaSJIR+SI7nbnrNFcGTJ7odgkGBaHmUE7RHo7G3tUOgvRO0pxV7v
         CUr8RbMDQ+7ZTW8h0xPqaYE16fJiAPry2+8klwyNoZcJI9MNXRi5xDT/u3i4WQ7vkjqa
         ROvgPhDcWcRNAP03FU/JCdjdAyKANJn3sGHpx3tHVNhfsDxQpvmvZZuzPPq6ufmcNSbT
         rtT3ihP7u/Tj7iZz5OloorgdhaHjxE0RgCfpT5kGE067h7OGpsIY+U/CwHPMwyZIElJm
         SyHw==
X-Forwarded-Encrypted: i=1; AJvYcCWMOox7qTjQJyOnNJzBz2ex3CQbKy7JI9xpESWByCOLy0Q0Ec7bGknCmDfb8oZRKnrT+3QraUHSm7QvmwYEMsBX8FMpaCLkfMJ8BXU0fqOmpg==
X-Gm-Message-State: AOJu0YxQzX1MFoD4VDH3/1ilZp1j/Ho7CDVFUPalDvixAN+TyXQThEHV
	nt/omNSrB1HeUd1fQuFlAYUCSDWDA5I7pOco0RtCYRW9cIPB440cOg+cjCk5VJc=
X-Google-Smtp-Source: AGHT+IFOP3RQsHFhOPvwxIOpDtZEM5OEE0sT4/N57Q5DPMChPXAGM5Y2JTMoio0KQUCNU0jXohhDbg==
X-Received: by 2002:adf:fe50:0:b0:367:9748:ee7f with SMTP id ffacd0b85a97d-368317c3bcfmr3783240f8f.65.1721313038912;
        Thu, 18 Jul 2024 07:30:38 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36868da687asm517286f8f.38.2024.07.18.07.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 07:30:38 -0700 (PDT)
Message-ID: <f1561c30-8b77-4ba5-964f-012b1e11cd2b@linaro.org>
Date: Thu, 18 Jul 2024 15:30:36 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/17] perf: cs-etm: Print queue number in raw trace
 dump
To: Mike Leach <mike.leach@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com,
 gankulkarni@os.amperecomputing.com, leo.yan@linux.dev,
 anshuman.khandual@arm.com,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
References: <20240712102029.3697965-1-james.clark@linaro.org>
 <20240712102029.3697965-8-james.clark@linaro.org>
 <CAJ9a7VjH+3LFJvSHkKUD_hJjxnpk3zyJ3ohFL6J6rgyquqyj=Q@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAJ9a7VjH+3LFJvSHkKUD_hJjxnpk3zyJ3ohFL6J6rgyquqyj=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/07/2024 2:25 pm, Mike Leach wrote:
> Hi James
> 
> On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>>
>> From: James Clark <james.clark@arm.com>
>>
>> Now that we have overlapping trace IDs it's also useful to know what the
>> queue number is to be able to distinguish the source of the trace so
>> print it inline.
>>
> 
> Not sure queue number is meaningful to anyone other than someone
> debugging the etm decode in perf. Perhaps cpu number?

It's more than just for debugging Perf, anyone who was previously 
reading the raw trace would probably have grepped for, or be looking at 
the "ID:" field. Now that doesn't identify trace from a single source 
anymore, due to the overlapping IDs. Same applies if you want to process 
the output in some way per-line.

With ETE technically it is CPU number, but I didn't want to name it like 
that because it's overloaded: With ETM it's the "collection CPU" which 
would be too misleading to label as CPU, and in per-thread mode it's 
always 0 and not a CPU at all.

Although I suppose it's already labeled as CPU on the 
PERF_RECORD_AUXTRACE output, and this just duplicates that so it should 
be called CPU. Maybe it is ok to drop this one  because the info already 
exists in the PERF_RECORD_AUXTRACE output.

> 
> Moreover - other additional debugging in the trace output is
> controlled with build options.
> See:-
> Makefile.config ->  ifdef CSTRACE_RAW,
> thence:-
> #ifdef CS_DEBUG_RAW in cs-etm-decoder.c
> 
> which adds in the raw byte data from the trace dump.
> 
> Could we make this addtional info dependent on either the standard
> DEBUG macro, or an additional build macro.
> 
> 

What about behind the verbose argument to Perf?

> 
>> Signed-off-by: James Clark <james.clark@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 4 ++--
>>   tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 2 +-
>>   tools/perf/util/cs-etm.c                        | 7 ++++---
>>   3 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> index d49c3e9c7c21..b78ef0262135 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> @@ -41,7 +41,7 @@ const u32 INSTR_PER_NS = 10;
>>
>>   struct cs_etm_decoder {
>>          void *data;
>> -       void (*packet_printer)(const char *msg);
>> +       void (*packet_printer)(const char *msg, void *data);
>>          bool suppress_printing;
>>          dcd_tree_handle_t dcd_tree;
>>          cs_etm_mem_cb_type mem_access;
>> @@ -202,7 +202,7 @@ static void cs_etm_decoder__print_str_cb(const void *p_context,
>>          const struct cs_etm_decoder *decoder = p_context;
>>
>>          if (p_context && str_len && !decoder->suppress_printing)
>> -               decoder->packet_printer(msg);
>> +               decoder->packet_printer(msg, decoder->data);
>>   }
>>
>>   static int
>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>> index 272c2efe78ee..12c782fa6db2 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>> @@ -60,7 +60,7 @@ struct cs_etm_trace_params {
>>
>>   struct cs_etm_decoder_params {
>>          int operation;
>> -       void (*packet_printer)(const char *msg);
>> +       void (*packet_printer)(const char *msg, void *data);
>>          cs_etm_mem_cb_type mem_acc_cb;
>>          bool formatted;
>>          bool fsyncs;
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 87e983da19be..49fadf46f42b 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -762,15 +762,16 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>>          }
>>   }
>>
>> -static void cs_etm__packet_dump(const char *pkt_string)
>> +static void cs_etm__packet_dump(const char *pkt_string, void *data)
>>   {
>>          const char *color = PERF_COLOR_BLUE;
>>          int len = strlen(pkt_string);
>> +       struct cs_etm_queue *etmq = data;
>>
>>          if (len && (pkt_string[len-1] == '\n'))
>> -               color_fprintf(stdout, color, "  %s", pkt_string);
>> +               color_fprintf(stdout, color, "  Qnr:%d; %s", etmq->queue_nr, pkt_string);
>>          else
>> -               color_fprintf(stdout, color, "  %s\n", pkt_string);
>> +               color_fprintf(stdout, color, "  Qnr:%d; %s\n", etmq->queue_nr, pkt_string);
>>
>>          fflush(stdout);
>>   }
>> --
>> 2.34.1
>>
> 
> Mike
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
