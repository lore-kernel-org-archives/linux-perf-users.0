Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969737F01B
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922132; cv=none; b=Zc5we/OzxyEyNvvcyfDJbJhrppNoh0PQrm8DZTyWyi0jXJv2Kl6YanZlxfXBzQj3ikL0VpQxS0l98b62A+QAKzIZ1gjuuJ81dkrUnioTLFpeGU8t122BLu5yrcn4SCffqPwtrJwjCWaaxmSPJ/s8UxVh+m42Nj4Wy5L5DYbYUZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922132; c=relaxed/simple;
	bh=BaQ2jXuMcGoJOce00H3TUeNdqWBLzzIkLMJPZg+dDrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrr+ng/v3NjwyrrOKzU6Hmnhx1j7Reo/fIXHhO/WdkcZ3ryFpE5oFY4PsyFTRfV1VXFWT7g0JE/wfDEfRsQNpnbFKArMI+ByYIkeDBHKIdHjc2nd5pp99rqsYONt5a/U9rNAHAs5oMsHWSLjsZkhedG9hPgFFa5n03z4Eo6UKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbHndoTO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbHndoTO"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68e5f7c1131so8010869a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780922130; x=1781526930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8oFATbLGkQWkwCipjQpmUUujF+3Rvcq+brYRvNSnEek=;
        b=JbHndoTOxCwsGia3iO4kObCyjpNAJsmeqWClSsV347R3h/l/81gYTdgzpDqnZXheMr
         ACMGyFl0DUQyZrwymGodz9cw9jHYwF2qRR8cF5iB9bYViT9lWViYQzwLOI+C8P8RCvOe
         BtMUM8TWqGg4eYJr/BEmWcKJEhMXM8VOOiS6/tOoquK+x8LQH7ILMoURim6NoxVRhNay
         iVZoriUsS7appwfljel6zvEtgh7KgiTZ04PXEmAh+JVvqkeMquaUvuUMKO42bFM+FISK
         Hp3V0sWzW2WJLRhR8P4NPUsDjMp1lGjpH3EJmr4jjYZMN8XFlOddxA2H/OTEC0clAAOr
         nJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922130; x=1781526930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oFATbLGkQWkwCipjQpmUUujF+3Rvcq+brYRvNSnEek=;
        b=bx9wwjr9hTGUA83GJbEzEWBNv0vXxmqHOzoEqu8vuv24JkCQ2IHyuj1NFh4LGZhutJ
         5BIKSuFb6yWPizkCOy2EhFYf7rkh62T9wrrbs06Y0OqbgFd/ypVjC9Hp9yd68JRG6+nS
         Mb5ek2Ti8fRi+rCsdVy4RDqc+qc7ogaPGXfY7DjIIZeOYmAsnZpEEn0I/dIOX0MgiF9y
         qeKK1qzpEy3ekbI9bX+YzFqSv0fZPKdq+FPGAfHvIbDmrFbjsPD0AEJZeVULs6KKCZLR
         s/LrsioZp+Lgm9jZhSum71ndWuiyMH2X5mQbwjmRJwjPLBBBtmDKXugDyitu6oIC2fyu
         jL3w==
X-Forwarded-Encrypted: i=1; AFNElJ/aJdm/UPHXeZnvOnRiopZ5kkGuxYclx1GBmJQIND16bLbE2R95TwJPKUlquXags6WJKfmvvmqHhrAwCm1QmUTJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1u9knZuoelGJxXxTpiB64/WIk40i6rFaZfEFu0yoje2Tad2M0
	+ug/vAFji9NtS77b0pgwDFuSQCNBsU1TABbVi3auZupsjA75I2TpfFoVU9LAHfKKOaM=
X-Gm-Gg: Acq92OHwj7KWuT0or2yarV3xJ7Gy2WpZur5TJokhAuAHN/RD45mjJ9xXmEmBRrcDYlz
	5yl8wFFTrrdt/YBI+AcUfYF19od4TWipvmdNlTndg3xUpBamagSNUtmJj/9zIKAckuJAMmSWcb9
	20fX/d+g8RHgw2zO4/kpye28dwVQJi1lClZ7IvOa3fMEMaWX2yl1/+6s8ERW4AbSZgVRr697wPV
	ljhUWh+VOUEhifp1DngVVg2OKC6hKXo54RlJ9naa2s54bhSm9il7gZOBoNwJAcqZrqUpUUho5iu
	W/88jgYWD3p0JbpDOIUqNG0G6qdeLJevT/ax1RzjAn48B4/qIi3raVqhgFPb12QEQNiSJnIekz3
	fKsJUegWTJ0WxCH8D9097L9oNTn8XhMBGh06260rKRbmfMbB+Td42Fg8lqDuC2KkPPcKclMUpyI
	2Z5FAO17a2Cmg3rUaZWSf3qx6C0ZJncOlnaB7ITu0=
X-Received: by 2002:a17:907:da3:b0:bed:afd6:9e07 with SMTP id a640c23a62f3a-bf370a64028mr736875166b.14.1780922129881;
        Mon, 08 Jun 2026 05:35:29 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e04a89sm862864566b.41.2026.06.08.05.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 05:35:26 -0700 (PDT)
Message-ID: <b122283d-f3a7-4174-8c13-2ae9f6d1e79b@linaro.org>
Date: Mon, 8 Jun 2026 13:35:24 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] perf cs-etm: Filter synthesized branch samples
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linux.dev>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>,
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
 <20260526-b4-arm_cs_callchain_support_v1-v6-6-f9f49f53c9dd@arm.com>
 <fbe0a097-ced7-44c6-ada1-01c3e9c1d7e7@linaro.org>
 <20260608112834.GM101133@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260608112834.GM101133@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/06/2026 12:28 pm, Leo Yan wrote:
> On Thu, Jun 04, 2026 at 03:42:32PM +0100, James Clark wrote:
> 
> [...]
> 
>>> @@ -3442,6 +3447,16 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>>>    		etm->synth_opts.thread_stack = session->itrace_synth_opts->thread_stack;
>>>    	}
>>> +	if (etm->synth_opts.calls)
>>> +		etm->branches_filter |= PERF_IP_FLAG_CALL |
>>> +					PERF_IP_FLAG_TRACE_BEGIN |
>>> +					PERF_IP_FLAG_TRACE_END;
>>> +
>>> +	if (etm->synth_opts.returns)
>>> +		etm->branches_filter |= PERF_IP_FLAG_RETURN |
>>> +					PERF_IP_FLAG_TRACE_BEGIN |
>>> +					PERF_IP_FLAG_TRACE_END;
>>> +
>>
>> This changes the default "perf script" output quite significantly and will
>> possibly break people's workflows. synth_opts.calls is true by default but
>> synth_opts.returns is false so we lose all the returns that we used to have.
>> Not sure if the new behavior is more consistent with other tools so we can
>> justify changing it? Personally I think including returns by default made
>> more sense, and it's a more literal representation of the flow.
> 
> Makes sense. I will add below chunk to enable return events for default
> option:
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index ab3aa76dddb3..bd9eb794cc07 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3541,6 +3541,14 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>                                  session->itrace_synth_opts->default_no_sample);
>                  etm->synth_opts.callchain = false;
>                  etm->synth_opts.thread_stack = session->itrace_synth_opts->thread_stack;
> +
> +               /*
> +                * By default, only call events are enabled but no return
> +                * events. Enable return events to better represent the
> +                * execution flow.
> +                */
> +               if (etm->synth_opts.calls)
> +                       etm->synth_opts.returns = true;
>          }
> 
>>
>> itrace.txt says the default is "all events i.e. the same as
>> --itrace=iybxwpe", but I thought the default was branches? At least for
>> Coresight it is, so I'm a bit confused.
> 
> "--itrace=iybxwpe" would be used for "perf report" command, the doc also
> mentions "--itrace=ce" for "perf script" specific.
> 
> Thanks,
> Leo

Ah I missed that. In that case maybe it makes sense to break it and 
treat it as a bug fix. 'c' is quite clearly documented as calls only, 
and the workaround you suggested above makes it impossible to get only 
calls so it makes separate options for call and return a bit useless.

