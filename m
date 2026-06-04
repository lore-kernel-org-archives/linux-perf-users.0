Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5A259C80
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582277; cv=none; b=El7jFvMAfagV32bdYQV4MYE84Ya5XKIWG54MMvCLLdJ+SEo8lhmNH3hkjXR1DCQuwDEou+DXfMog6Fe1XPYLWomb+DdSHt1gaOAWZRK1CZiC33rGx7s16xD+DiOVnw+vI3Wt9Q+ajBHQZZZTqd0O2Q5mhpwD7IS9wvPTdSu08pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582277; c=relaxed/simple;
	bh=pdYEJyEE5hUScx0ZZPcgMLYKKedsy+OHqSRtwApowTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmkyiK5jDU4mWB3pk3WLodQpiyUJrN1XyrXQsTkc48FWkE4yNTn2/BSuQGxYhrbr+cbFiuVuivtDC4hUtk30ObxEWXaGETLX+Rs97ok7yVjwfjMSu21LiLw4Tlpq8xMBsMbCQ97G4SyNAU03s19z3IxlMzg9bL9hmx66z/U2nfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TWO3u7mB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWO3u7mB"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bec43ee8ff0so107065066b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 07:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780582274; x=1781187074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JK/Z+bri11S+Q2+9lEL+aRt2H6ClhQSz+SnP/5xTT/Q=;
        b=TWO3u7mBUn7M96Ft6Y5Mfqolun20S+epD6NXBzE2nqTJsEo4ChQ003PMdHZiajMh3y
         YUSlIzUjHebpgVnaSEnpRz392ZYwdbW0DQ7MSN1Dvw6gSjMGAB53ttjmikUnx6HZmOtq
         wBUCEfwnCiedMk6lQdL5L3QETTJu9TJdZWToVdAJeClGLcIsgWM7+XuCfYtTgZUHjSnI
         K0AaJI5ovO/2qPRD1fJbv/s0PO2T0U3yZQG3j3HQTKsrYopw94fIi8GzCWoC0dSv1xF7
         2Jlx6Hh4fXc4rO9gbirhLUedItVJgSjrFp6b9A++kS9P65iu4tGwDZPNVlIcXBv4I9ON
         cPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582274; x=1781187074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JK/Z+bri11S+Q2+9lEL+aRt2H6ClhQSz+SnP/5xTT/Q=;
        b=k3f+Dv0NBDzOfjqpixObRd7z4XUbXDp/XXidR8cmM4LBmaJIIGEi1NGsrgdRhQPsH8
         7wJpJ10J5bW7ENiqAVk0b/jvzlEcpGkJDw6oHZKl7VcImtcLm8Y29fRiHyttrlupuV+l
         GnFyrlamDr1NdyiXQSR2gUqy5USIbe7sD4d3Je6tCKVCjcqjNt2lvLOlojZzbOc+w7jp
         12qcgWlaxMI3NLuBX8hXdvAdgCGt7ksS5olmrGIE4wOttwP5Iiq2lMd4Cb2BiiweTAL1
         9XHOOwfTKOShjwfuAYuRAiFFiB+483cgBJksmNUwnmds6ADywbDoanqU8zNL919imHGK
         4HYg==
X-Forwarded-Encrypted: i=1; AFNElJ9BWAAjvoVcMoCyuv3rBbW2u8ZehduA/RIqYD2MjtCCxWGz/aRzxfasrhLvt3bFltKZ9uxxNJbdVO4p+94HBXpH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qYgLnpcL0UPqOpIGrbmc+O6mGJtjWIn1OnSbLgPPwyE1KpxZ
	akE8iPJFatcPB389rSyJtCR7wSl7SLMo0gJNgYB/XNAqHNs5Pt0fvH9P+HTSFYzFTxA=
X-Gm-Gg: Acq92OEtOfTb7DVLOMWPiPk8mXKBfenFW6J2Sg1ipN3hNiIj03J41Kt8Tp/4OEz3lNc
	CPCHX9rXqqOM6j9vNY2qH+nYtdDLQDctYZ03DJ2FYrW4VtgjIbr0wIwW+ZCPCeAuOiVCJiZEY9b
	MpE0WVieDQxhP2vdCF4XQl59uRru4WB0nIFGGJRVZ/MIHjlIBuRL3Qq2akorfTPGt/1KbZgA8My
	X+CY7AD2dbusyPqU4zlxvN9cqOsG5saMyMiNOuwQ3rxD2aUz7pKb0H96jrSoihfMUykimo9wDD9
	S0Pxfd1+FoT0xZ1iuC7wZBuGfKwPqA1+37tDxj8jRLH2TuzxSFejnfvDESPoVC42ymzQEIs2dYr
	uqJvEZrLkuhX9ls3B2UptJ2WrY7fyn0uewfN1zP7yoTA9qMCzK3nVZI3u6K/7XgxFX2wn1wnALt
	n2mHHQ8Dbl++jKkikZ1x9xV46Wk+Cn4tB9aDnk5wQ=
X-Received: by 2002:a17:906:8a74:b0:bed:83ee:9224 with SMTP id a640c23a62f3a-bf1d1b8ad87mr130727066b.8.1780582273741;
        Thu, 04 Jun 2026 07:11:13 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05208e897sm307332366b.25.2026.06.04.07.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:11:13 -0700 (PDT)
Message-ID: <02fe627c-9a98-4de2-9bf4-6ce35bb470db@linaro.org>
Date: Thu, 4 Jun 2026 15:11:12 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] perf cs-etm: Refactor instruction size handling
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
 <20260526-b4-arm_cs_callchain_support_v1-v6-2-f9f49f53c9dd@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-2-f9f49f53c9dd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/05/2026 5:59 pm, Leo Yan wrote:
> From: Leo Yan <leo.yan@linaro.org>
> 
> This patch introduces a new function cs_etm__instr_size() to calculate
> the instruction size based on ISA type and instruction address.
> 
> Given the trace data can be MB and most likely that will be A64/A32 on
> a lot of platforms, cs_etm__instr_addr() keeps a single ISA type check
> for A64/A32 and executes an optimized calculation (addr + offset * 4).
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 44 +++++++++++++++++++++++---------------------
>   1 file changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index ab79d08f5a6095448470e2c3ec85ff3db2fb5634..5bff8811d61e423463b7bd4e20d599d5b5307a1a 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1347,6 +1347,17 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
>   	return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
>   }
>   
> +static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
> +				     u8 trace_chan_id,
> +				     enum cs_etm_isa isa, u64 addr)
> +{
> +	if (isa == CS_ETM_ISA_T32)
> +		return cs_etm__t32_instr_size(etmq, trace_chan_id, addr);
> +
> +	/* Otherwise, 4-byte instruction size for A32/A64 */
> +	return 4;
> +}
> +
>   static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
>   {
>   	/*
> @@ -1375,19 +1386,18 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
>   				     const struct cs_etm_packet *packet,
>   				     u64 offset)
>   {
> -	if (packet->isa == CS_ETM_ISA_T32) {
> -		u64 addr = packet->start_addr;
> +	u64 addr = packet->start_addr;
>   
> -		while (offset) {
> -			addr += cs_etm__t32_instr_size(etmq,
> -						       trace_chan_id, addr);
> -			offset--;
> -		}
> -		return addr;
> -	}
> +	/* 4-byte instruction size for A32/A64 */
> +	if (packet->isa == CS_ETM_ISA_A64 || packet->isa == CS_ETM_ISA_A32)
> +		return addr + offset * 4;
>   
> -	/* Assume a 4 byte instruction size (A32/A64) */
> -	return packet->start_addr + offset * 4;
> +	while (offset) {
> +		addr += cs_etm__instr_size(etmq, trace_chan_id,
> +					   packet->isa, addr);
> +		offset--;
> +	}
> +	return addr;
>   }
>   
>   static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
> @@ -1540,16 +1550,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
>   		return;
>   	}
>   
> -	/*
> -	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
> -	 * cs_etm__t32_instr_size().
> -	 */
> -	if (packet->isa == CS_ETM_ISA_T32)
> -		sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
> -							  sample->ip);
> -	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
> -	else
> -		sample->insn_len = 4;
> +	sample->insn_len = cs_etm__instr_size(etmq, trace_chan_id,
> +					      packet->isa, sample->ip);
>   
>   	cs_etm__mem_access(etmq, trace_chan_id, sample->ip, sample->insn_len,
>   			   (void *)sample->insn, 0);
> 

Reviewed-by: James Clark <james.clark@linaro.org>

