Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E13623ED5B
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148138; cv=none; b=D9RJqc50hJcL5R1gP8lRKdsMot23pjS9tP4mNrNYJcYIw2Se13tC5hRIfJUpadl1/2id+6bQKf69TNeE5+Cp4diPk+UaU5xhGUu/bqgE0fjO9gMj3nxh6rAf4c4yjWGpBCw9msrKVjHMhxyn7wx5DntGgi0efAIGOt6f6N//NIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148138; c=relaxed/simple;
	bh=eRMkAlvTEnwZ4qMUtrPf6xT4pGmVA/ofhMcO3oCKa+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=X39EnH0Y82UAtnBvVHtmK20DCGTI0cJhXCsc/h3GP2aQLeiGO779fRM60ImcBSTzmYal8NmcIFb8XNXAZbgjhA2JCHqvMnNV0qiHy8VupG3cSwFsdFUr5B0MscHGJ5DH8Ohb/VuKju2CytgVo/TlXXqcio/R0+qW4wM9W0wDq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P9Hhi/Je; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9Hhi/Je"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso6602792f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761148135; x=1761752935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nQKCc3o8CpOmEjXqvj1OmhWFZYzGoBkXsANUxN2NNQk=;
        b=P9Hhi/JenkLQTL1G0jBToMUqqDeoPxyEK4G0LWD1ba1kNMZO5JINY35oPSBo4/T/PB
         QpBRQF2k1BNLur3wm7UrxawXOKjxwxH0+VvMKRER/Z4wrvjSRffYMyOXLy1rEEujG81n
         c8glSKS2CIs38MRkDdxOeA7YAeSmCN+Q6kSOP+4xtnREj5FlMu3FlVz5ugZY1R/dVTlI
         rs/Ox0BVZvsOyUkOxyFlIosvrBBcZ+2SpscBihY+YtxPi29fcN8WZceDsnX8W7rIl+Vn
         CpDBhFsXboL+EQyBJb6U0ko5RXU2rgzcagwh5HZ+75rWIXetFjNkmdR57tsfBk3sMlIg
         sXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148135; x=1761752935;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQKCc3o8CpOmEjXqvj1OmhWFZYzGoBkXsANUxN2NNQk=;
        b=DQ+aKgKiYy21fx/NF/CyiCs4u+1OaMPurcr0SUgq4Z8MwJFroK6mq91T36D7DspjSh
         upp+gOF5itntiaf//MzAs8NKys6Dp+6zh9cabqLva6Pcd+xjTURpLl8dZpcbUIwVBKtW
         A53PYj3mPnZ6axL+BVHY8HI0VkcaZJdNzzfPZh1LGxyqt+gtiGaFeZ+TMHjGm7n+s0SH
         OkoP5aUzkFMaMKlG7kd4jrCSGz2muKvKT9YmZsPQIhERb0dWP/kh4LH1Rl9xYfmozFLB
         aOvPUO8dsvJvnVAz7EFeCCuIwB1iDJ4PcnPJWRu0SLZhHOXE6U1bsu3wVnqAEP8RYKhL
         FTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOOsk5fqOWjgkDGw9RXfr778AnqPeeFdoedRN+fpV96QginjQV/H9KSF/0Cfc3jYoDsjNz6y+Je21IMKxFNfUQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0H1nyEnV6jg41ZKPGJlbBjKKue7NtwXsmYPq4GwMzdUHaTHC
	iYguN2KFf3QVECU+dqHycq7Y8/zV+x+83K1KsQxMFn1Ze6vMzYyGLlhjoM439LDlGYE=
X-Gm-Gg: ASbGncucjOXy02B9JBzndUe4I9l9cLuHLKIM/iWSBimlOOXt8xtDlBMbXcuM29nQcNr
	jPkPLx/Ou5pWjzySRNiFbB9C3klWK74VHmnZ0p/vzT17t4lCfIM9t204tpui5zjarLMgOsMMj8S
	iWosj+dLbzSqFrZxzLwxgDMUrLwcyhTx2a4FP+xc8BaOfC4Ocxf9VI14z5FIISskSoYnaPsCOq6
	9e/JJm5WmHKHWyU/QeJhAxwhyzmIYoXffeBoukCqHn4XmuSaNvgOy9PrAX60csEkWMfFIxuTO9u
	EYBvqRgqn02RFVtdL5GbCJmDvv8BpOVsUPZnF6BNzWO2ZbTZfih36iawNTFJwkfibgDJ6SwURdy
	hTo7fV2oC2/CPy5hZ4vAhPzL9t4SHpWBuPMTNth5bYaCGosxqRG0W1XQNz6l6jnOXWip0mg1pv0
	RB8Z0Stg==
X-Google-Smtp-Source: AGHT+IHOKlM9ZXbVarUrdxd9Z6TXrWDN7PTBigcURwaaklRyyWxBtRFHep1+wcz22TEjatLqlseBVg==
X-Received: by 2002:a5d:5886:0:b0:428:1475:6a17 with SMTP id ffacd0b85a97d-42814756be9mr12100399f8f.53.1761148134341;
        Wed, 22 Oct 2025 08:48:54 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3ae9sm25465267f8f.13.2025.10.22.08.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:48:53 -0700 (PDT)
Message-ID: <6cb692cf-cb7a-4d47-9694-e3db4478fa4c@linaro.org>
Date: Wed, 22 Oct 2025 16:48:52 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf cs-etm: Mute enumeration value warning
To: Leo Yan <leo.yan@arm.com>
References: <20251022142849.1537706-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251022142849.1537706-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/10/2025 3:28 pm, Leo Yan wrote:
> When the OpenCSD library introduces a new enumeration value (for example,
> in the v1.7.1 release), the perf build fails with an error:
> 
>    util/cs-etm-decoder/cs-etm-decoder.c:600:10: error: enumeration value 'OCSD_GEN_TRC_ELEM_ITMTRACE' not explicitly handled in switch [-Werror, -Wswitch-enum]
>      600 |         switch (elem->elem_type) {
> 	|                 ^~~~~~~~~~~~~~~
>    1 error generated.
> 
> Convert to if-else sentences to mute the enumeration value warning,
> which can avoid build failures whenever the lib is updated.
> 
> No functional change.
> 
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 44 +++++--------------
>   1 file changed, 11 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index b85a8837bddc..3050fe212666 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -588,6 +588,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>   				const ocsd_generic_trace_elem *elem)
>   {
>   	ocsd_datapath_resp_t resp = OCSD_RESP_CONT;
> +	ocsd_gen_trc_elem_t type;
>   	struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
>   	struct cs_etm_queue *etmq = decoder->data;
>   	struct cs_etm_packet_queue *packet_queue;
> @@ -597,52 +598,29 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>   	if (!packet_queue)
>   		return OCSD_RESP_FATAL_SYS_ERR;
>   
> -	switch (elem->elem_type) {
> -	case OCSD_GEN_TRC_ELEM_UNKNOWN:
> -		break;
> -	case OCSD_GEN_TRC_ELEM_EO_TRACE:
> -	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> -	case OCSD_GEN_TRC_ELEM_TRACE_ON:
> +	type = elem->elem_type;
> +
> +	if (type == OCSD_GEN_TRC_ELEM_EO_TRACE ||
> +	    type == OCSD_GEN_TRC_ELEM_NO_SYNC ||
> +	    type == OCSD_GEN_TRC_ELEM_TRACE_ON)
>   		resp = cs_etm_decoder__buffer_discontinuity(etmq, packet_queue,
>   							    trace_chan_id);
> -		break;
> -	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
> +	else if (type == OCSD_GEN_TRC_ELEM_INSTR_RANGE)
>   		resp = cs_etm_decoder__buffer_range(etmq, packet_queue, elem,
>   						    trace_chan_id);
> -		break;
> -	case OCSD_GEN_TRC_ELEM_EXCEPTION:
> +	else if (type == OCSD_GEN_TRC_ELEM_EXCEPTION)
>   		resp = cs_etm_decoder__buffer_exception(etmq, packet_queue, elem,
>   							trace_chan_id);
> -		break;
> -	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
> +	else if (type == OCSD_GEN_TRC_ELEM_EXCEPTION_RET)
>   		resp = cs_etm_decoder__buffer_exception_ret(etmq, packet_queue,
>   							    trace_chan_id);
> -		break;
> -	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
> +	else if (type == OCSD_GEN_TRC_ELEM_TIMESTAMP)
>   		resp = cs_etm_decoder__do_hard_timestamp(etmq, elem,
>   							 trace_chan_id,
>   							 indx);
> -		break;
> -	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
> +	else if (type == OCSD_GEN_TRC_ELEM_PE_CONTEXT)
>   		resp = cs_etm_decoder__set_tid(etmq, packet_queue,
>   					       elem, trace_chan_id);
> -		break;
> -	/* Unused packet types */
> -	case OCSD_GEN_TRC_ELEM_I_RANGE_NOPATH:
> -	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
> -	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
> -	case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
> -	case OCSD_GEN_TRC_ELEM_EVENT:
> -	case OCSD_GEN_TRC_ELEM_SWTRACE:
> -	case OCSD_GEN_TRC_ELEM_CUSTOM:
> -	case OCSD_GEN_TRC_ELEM_SYNC_MARKER:
> -	case OCSD_GEN_TRC_ELEM_MEMTRANS:
> -#if (OCSD_VER_NUM >= 0x010400)
> -	case OCSD_GEN_TRC_ELEM_INSTRUMENTATION:
> -#endif
> -	default:
> -		break;
> -	}
>   
>   	return resp;
>   }

