Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701219;
	b=TycZqofsoluGLoY6R0mNLB5xttvxk/qPqjeC1UnD59nfpqP07fF+pQq2nSxlHdwHXwtM
	 BqPSj3aHvyRSfSdmdyZyUCrHoCXA4hRhbLjRthiJKeEEYuUpAY6nJTBpEyFRBixIfwOYX
	 NrNjHHbS8FJlJqfMFkJt5OAiPacwbFLo7L1Fm2NZuZ6BJXb6Bi08PMuxasDu/Rg4DilK1
	 fUiv5A77/KG7+egX3xZvwYnbakRtp993EDwGfHo3YDphtPxmjGsriQHCRKLixE0EPPmml
	 8W48Qs5SqcMDD4xwfBkTWkk28rpH4NkxG911lWeLzkAGcTHeO54R+hFYzuBU8uDmXQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TBcWjUGjb5VTLVVH3GK5ENa1hgDGV5BGChwYvbGOY8c=;
	b=slx/+RzsaIwdN5Rbro0hPe+gL0MfyBCm/BGFwatoFMqP0y1a8BxaolJ/q69UqCaKvoks
	 UcwVoLAkiV8Txkq+iyEtDQb4l6vzHjzh7VO5v7JYHsEikUyJPVLsUP3nmz4Z2CRbV+ly2
	 1IvKOsgy6O62BKsjkGL/raqfWsOtgwJZjMME3pZhQcpV168YKkuFaDl2HDzo+l8+An8T5
	 cx1zavjnbXS0kaogdCfWVPEW8xWw6bC/6+1zWggsOo8DPAPLPnG0YkqOCnQNcsU+yLZfP
	 DkEj6HOvipT0t1X/41XJxQZuvTJh9w4he6lxI0z3Ap5n+Lks38hl8VxpUqj0jWTNQsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="sdUnjK/6";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA55606A69D
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 13:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FA55606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sdUnjK/6
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb61185057so45273495e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 05:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795701217; x=1796306017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBcWjUGjb5VTLVVH3GK5ENa1hgDGV5BGChwYvbGOY8c=;
        b=sdUnjK/6Hk+QXhSGsBEgqNYHfGPVAHP1H4+xTTfrHhXfhYCEjfYE6GvuGIVsmQtB4u
         M+R6oNlPz9qdCpdn+NZEbVifJJw4mhY0jCOKcGRrM0/IhtDUZxx6ACFJm6XA4ZB5sakj
         Y7mgdRFDLlSIStQHzklOkmesduwg5tnLa8KMsd1IVr4j5dvvDWciTZGuejvAHrbNCOhx
         6u7+uUfEzWK1VpneCdRTVoCfnsXxm2dICIFFTZy+vh+eTSHDIxmkwSFKCEbCpa3A3doy
         Wz5PqzAO3vxsfTkba9+9xFkmz7JrQW3aXFhWgfCJQsvXdOB5ZXBt9YugZZgOo7hB6i7j
         zf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795701217; x=1796306017;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TBcWjUGjb5VTLVVH3GK5ENa1hgDGV5BGChwYvbGOY8c=;
        b=Jz3WI9WASBIbSJF3pLL2HeXkiMeyxekYHUlGs9li6xZQR9+HYFxo7dKGfRTpiYHIk5
         aJmPXuVqLVNCJKPnct8wDdgaLpuYtqkzp699DH0IzEjV/1OjMbWpKEriYZbQfQ7KUNHc
         7+pATKM0M9/ExdbWpAH3sJOfsSeSd1N/WzH2Vqj6YuAU1yXK4q9VrBtSUeStqLEZvYVH
         DDo+MepTh2G9f+q0qUR2aRddXf6nOGRCFAbL6lUwwDRjW3KC1e3dLw1/17r8HB3LD+4t
         +7Osokt/XNvand6rueEIsbJEeCNPcArwijZrkFMQBrMx8hD7ondPLIy2vgJUfH4TQMND
         4SkA==
X-Forwarded-Encrypted: i=1; AL+hErFDB1yEPRSY5CeqtONEZmQhXQw4qL4Ll1oFqcvWsvzktvWoD9pIW/dNh8MfeteNQ6O3LludqaPcDG9Is2HMv+8j@vger.kernel.org
X-Gm-Message-State: APuU4Z+nZvo0Ol85al7D0KstYfdmHeg2whX5fGb/sssiMHq0t7kiP6id
	U+gx1z/wA0IUV/Qkixb33kwseZRYi7Ge7E0OZBQYqG4HlGUNVgNrSbk0qSFWUBteA4o=
X-Gm-Gg: AZFdTZcwWsNH2BLP4DtDNQNUNmWlEcq8Y67DZWg5BmdMK/4ACIdFE05FoI7B9Py7Npu
	ydK98Cq5EFI9TyYMSYj9jgoUOzu2WOtCnltZjeHyEUtSHrTtz/hDB1/grTfUIWfCJZO3QhekGfh
	6hChxuNM5UUxv5yNG1AnwmwDNcF4gTPQYw1xTFxJQAEprJnQr/jBEIes1e/qqqXI7Hd//NT3Fln
	o39p9kSZ3bdp+s7hc+1/S5qIcA4qwn4kRzqzTUz2IKlz7v6IdkUIPhxRZknXjLjUZfKg6yvJk7F
	5l9rVPXU3cCqlEos+hlAAyXsuTlYAzbGKMofIbqbWPmFc0w7gwE2P8t7wKm82JmzsZ7LuypxzPS
	EVBgKjlG+TzL2D6TQNI59bDrPhrecnbCXIwxrNPLuzKc/GKwLzT/iTPuZyHMJJkwWQnOzM3MD8b
	Jmz9xJXbMjt7SnJL/P+zT7cVc7DsG1titeWh949kTJ9w1x9Rg6ny5/lEMEueu00qmqg+2XR4KYk
	5669TGOq6rcOgZo4r4EaiwTLI0HTdbZ6cbxWPcHxgPktTZRSTO/MtsjUn0iCczIVdrI8Z7f82o/
	isfTgkKkk7tNB08Z9jW1fAk+dwvfiwyUIg==
X-Received: by 2002:a05:600c:3509:b0:4bb:76f6:d23a with SMTP id 5b1f17b1804b1-4bb88814d16mr459329395e9.21.1795701216766;
        Thu, 26 Nov 2026 05:53:36 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f148aasm240161275e9.0.2026.11.26.05.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:53:36 -0800 (PST)
Message-ID: <fbc63046-18e1-49cc-a031-d936ba148317@linaro.org>
Date: Thu, 26 Nov 2026 13:53:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf cs-etm: Check frontend instruction reads
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mike Leach <mike.leach@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Robert Walker <robert.walker@arm.com>
References: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com>
 <20261113-perf_fix_gcc15_failure-v1-3-eae592c5ff64@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261113-perf_fix_gcc15_failure-v1-3-eae592c5ff64@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/11/2026 10:54, Leo Yan wrote:
> Frontend instruction decoding needs a complete memory read rather than
> a byte count. Refactor cs_etm__frontend_mem_access() to return zero for
> a complete read and -EIO otherwise, while retaining the decoder memory
> callback's byte-count interface.
> 
> Propagate read errors through Thumb instruction size and address
> calculation. Skip samples whose addresses cannot be determined while
> preserving instruction period accounting, branch synthesis and packet
> processing.
> 
> Initialize the copied instruction length to zero, validate the size,
> and set the length only after reading all instruction bytes. Also check
> read errors before recognizing SVC instructions.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 75 +++++++++++++++++++++++++++++++-----------------
>   1 file changed, 48 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 312d4a734e84faa0d24c4ac1fee16f4dae4c2398..303e16a54445bc62ce1c7d0e4ffeb1819211fd40 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1218,13 +1218,16 @@ static u32 __cs_etm__mem_access(struct cs_etm_queue *etmq,
>   	return ret;
>   }
>   
> -static u32 cs_etm__frontend_mem_access(struct cs_etm_queue *etmq,
> +static int cs_etm__frontend_mem_access(struct cs_etm_queue *etmq,
>   				       struct cs_etm_traceid_queue *tidq,
>   				       struct cs_etm_packet *packet,
>   				       u64 address, size_t size, u8 *buffer)
>   {
> -	return __cs_etm__mem_access(etmq, address, size, buffer, 0, packet->el,
> -				    tidq->frontend_thread);
> +	if (__cs_etm__mem_access(etmq, address, size, buffer, 0, packet->el,
> +				 tidq->frontend_thread) != size)
> +		return -EIO;
> +
> +	return 0;
>   }
>   
>   static u32 cs_etm__decoder_mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
> @@ -1370,9 +1373,12 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
>   					 struct cs_etm_packet *packet, u64 addr)
>   {
>   	u8 instrBytes[2] = { 0 };
> +	int ret;
>   
> -	cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
> -				    ARRAY_SIZE(instrBytes), instrBytes);
> +	ret = cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
> +					  ARRAY_SIZE(instrBytes), instrBytes);
> +	if (ret)
> +		return ret;
>   	/*
>   	 * T32 instruction size is indicated by bits[15:11] of the first
>   	 * 16-bit word of the instruction: 0b11101, 0b11110 and 0b11111
> @@ -1429,7 +1435,11 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
>   		return addr + offset * 4;
>   
>   	while (offset) {
> -		addr += cs_etm__instr_size(etmq, tidq, packet, addr);
> +		int size = cs_etm__instr_size(etmq, tidq, packet, addr);
> +
> +		if (size < 0)
> +			return CS_ETM_INVAL_ADDR;
> +		addr += size;
>   		offset--;
>   	}
>   	return addr;
> @@ -1560,31 +1570,31 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
>   			      struct cs_etm_packet *packet,
>   			      struct perf_sample *sample)
>   {
> +	int size;
> +
> +	sample->insn_len = 0;
> +
>   	/*
>   	 * It's pointless to read instructions for the CS_ETM_DISCONTINUITY
>   	 * packet, so directly bail out with 'insn_len' = 0.
>   	 */
> -	if (packet->sample_type == CS_ETM_DISCONTINUITY) {
> -		sample->insn_len = 0;
> +	if (packet->sample_type == CS_ETM_DISCONTINUITY)
>   		return;
> -	}
>   
> -	sample->insn_len = cs_etm__instr_size(etmq, tidq, packet, sample->ip);
> +	size = cs_etm__instr_size(etmq, tidq, packet, sample->ip);
>   
>   	/*
>   	 * The instruction length should always fit within sample->insn,
>   	 * but check it to prevent an out-of-bounds write.
>   	 */
> -	if (sample->insn_len > sizeof(sample->insn)) {
> -		sample->insn_len = 0;
> +	if (size <= 0 || (size_t)size > sizeof(sample->insn))
>   		return;
> -	}
>   
> -	if (packet->sample_type == CS_ETM_EXCEPTION && !sample->insn_len)
> +	if (cs_etm__frontend_mem_access(etmq, tidq, packet, sample->ip,
> +					size, (void *)sample->insn))
>   		return;
>   
> -	cs_etm__frontend_mem_access(etmq, tidq, packet, sample->ip,
> -				    sample->insn_len, (void *)sample->insn);
> +	sample->insn_len = size;
>   }
>   
>   u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
> @@ -2011,11 +2021,13 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>   			 */
>   			addr = cs_etm__instr_addr(etmq, tidq, tidq->packet,
>   						  offset - 1);
> -			ret = cs_etm__synth_instruction_sample(
> -				etmq, tidq, tidq->packet, addr,
> -				etm->instructions_sample_period);
> -			if (ret)
> -				return ret;
> +			if (addr != CS_ETM_INVAL_ADDR) {
> +				ret = cs_etm__synth_instruction_sample(
> +					etmq, tidq, tidq->packet, addr,
> +					etm->instructions_sample_period);
> +				if (ret)
> +					return ret;
> +			}
>   
>   			offset += etm->instructions_sample_period;
>   			tidq->period_instructions -=
> @@ -2227,8 +2239,11 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
>   		 * so below only read 2 bytes as instruction size for T32.
>   		 */
>   		addr = ret_addr - 2;
> -		cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
> -					    sizeof(instr16), (u8 *)&instr16);
> +
> +		if (cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
> +						sizeof(instr16), (u8 *)&instr16))
> +			return false;
> +
>   		if ((instr16 & 0xFF00) == 0xDF00)
>   			return true;
>   
> @@ -2243,8 +2258,11 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
>   		 * +---------+---------+-------------------------+
>   		 */
>   		addr = ret_addr - 4;
> -		cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
> -					    sizeof(instr32), (u8 *)&instr32);
> +
> +		if (cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
> +						sizeof(instr32), (u8 *)&instr32))
> +			return false;
> +
>   		if ((instr32 & 0x0F000000) == 0x0F000000 &&
>   		    (instr32 & 0xF0000000) != 0xF0000000)
>   			return true;
> @@ -2260,8 +2278,11 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
>   		 * +-----------------------+---------+-----------+
>   		 */
>   		addr = ret_addr - 4;
> -		cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
> -					    sizeof(instr32), (u8 *)&instr32);
> +
> +		if (cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
> +						sizeof(instr32), (u8 *)&instr32))
> +			return false;
> +
>   		if ((instr32 & 0xFFE0001F) == 0xd4000001)
>   			return true;
>   
> 

Reviewed-by: James Clark <james.clark@linaro.org>

