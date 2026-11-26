Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701197;
	b=ocX0QUoJY4KNMq4urXllo0BBnvbYtyX/e43CIQ0XlxZUS7ejkDpDRRM4E/njNbInGPRP
	 1tlsqp8Mb9MLxDJaDFyTwg615bm9iyzY4+0EWe7aAQcWEefKiABAg7XxpKrOWY17dW/yc
	 2Tv1u3xs/8t215pzZTzucAtF9kTBq7h5/CTG6opUc0I/lS2Ppd2NkPUzymK1kjObbPmG5
	 pEGFr8El+ZP/XEet7eouNm/t8gFk+lP/1xWKQvfrSYnOl15ad9tyvopMRK/LU7ap40rDa
	 ZyqjLSZR0UgeuLfJMEi9/UG7C1z5QXpXWiQTqYzjP+xampreGcOSVcc2js2RlrrSckQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AU2h9lPdSzx4S/KR98PU1M8jqATUeMkcc+DImUKw4Bc=;
	b=OPAeqOJRfNVYwgf/513Gg/c9M5SqHS/ClJ04WID3mA8b3Zwn5udc7DKcAhft5ULtY9SD
	 YqhK48Gzxu0+UR2n/dSraZYMPtJbpzdMy/OhaUV/dXzDhH4WVGZ8pUTi0xpYIMibjDKV7
	 EgJzqF0Cm96Pj3Wvh+h6ibJYLjmURDJeRFM8moybevViAnUt7tcI+OKLmDnd89lYLPi9n
	 sXieD9lPc6ONTsvOXrgePKsiLTOKlq32icgThIZu165C387+uYWnX69X4n5M0V3JACddf
	 bi721u3Jhte2AsvjEWgsA3efYWQ+rd5wofDr6upFw2lfRb91HDyzh8910bgDZMXDQlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VkIP9xLb;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423CA606A33D
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 13:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 423CA606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VkIP9xLb
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a358881793so3705382f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 05:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795701195; x=1796305995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AU2h9lPdSzx4S/KR98PU1M8jqATUeMkcc+DImUKw4Bc=;
        b=VkIP9xLbrhFfOU5CgEzhM3QwmHcp5igdX1ivprss0A0HdKClrfnz7DSLV61dXSlk+A
         nzWxpzPBNG+4+OEVrt+HCLPzFGY5JSLe9N9GaghMtFeifoLHZqQcyuuREhL54ICIM0N5
         0ZiZa++LVPq0rPkxCGXVb3ToLDwiYHnZwgLW8alIu2HDPK0Xfky5m75u1GFgyei4k9Ru
         427/TOwqFDhPYKNgJtBD/wYKpdnDhZr1NSCb16shJ/GQ9r7PhTLukW9khA8thW3+iVFC
         RcFQvpcazns1g/gyMuEQO+WapzIUwK3eZanoQgZQCZzYd55N/BfFPpc2rBYScnfUERKF
         +RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795701195; x=1796305995;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AU2h9lPdSzx4S/KR98PU1M8jqATUeMkcc+DImUKw4Bc=;
        b=yVj+8ORcWsJmsX4fQw7vDty6rMSGns3vVDXArDNcqKnLUFKA8CyyauWlxrE6wo4Adv
         0MK1arqkMgQcKbuqc7VUts4/apXEMhRN+mw+nqbHFY/8UA49OylrGtttSF3nxjGXqDJF
         vcoZMwCCC3R9ipFyASlre3hZIHwoQSxcr0MzE+NcTk+lxP4YiBdACTsr9T/9heSN0SbE
         LtMgPJuXuMkyzQORNGAe2y97ZB2DW1/2wclTcD+AXw/qotkJiqriJ3kEjNEBFU1umtIR
         EBhzjP7iKuZG2T8rh30TEpq57POfrNBHns8qZeamUVg8KS8rAFfAR3KSRNps9rMUZIIW
         hy0Q==
X-Forwarded-Encrypted: i=1; AL+hErF3kxlEi8b4kXjskjeCBpRryW4iyhzzneMO+W4nM6f6FLmLu+kifwtvkqFQoUdqTnbRj7eD6wAhbbaQkNW+BSRT@vger.kernel.org
X-Gm-Message-State: APuU4Z9/32xDjldLipY+5If4tBJ7IlIglDU5cfzlP2zGa/10DuSKIVzB
	RqMaDsVlrYidrv+EH0V/FCdKTsnYOowsQ4cEWi8UiPEGlqr3iKkgRV4FMR+NswzsAsR8Y3T+Z1C
	d1w+3
X-Gm-Gg: AZFdTZc9KCmAX8X4myUi5rWSjNJFlHF091RHTXhkDqHGxE4oJcEzLmoESkmOp39Ca4B
	NnoOCWHirhe3YXXkBlohiVI/9bkbeE7vWjA1FIstZM4k+RWJVwPK+baCOPNqPtTL7XCtFSGc4xz
	oTn4eyvlhA3W7MC882bEQavMX+W1s1JtzKJbBvIJdW7bI9cakzJL0RSp9PJz14RjO3V53booigL
	GdkA+QpfKUxZOWXyJ/UK7+5fRSWOyoLXDLRetWuLORNjYz1h5ThwkTEVKtes8oTuKNhd139uoYT
	/sRQtIKBy7QFI5L1nMj/gU/NFDXynK7qGSGju+XaLpceGyjCrtuNl3HzjxuI/pCSy4RRymHNkyF
	lwFeO+87roRC6k4APe8uKVq47PxVSjGWYxetfyB2pLwyDbGLB6axGPhSSrx9PEOmnORRNiHkDD9
	BAZxrqP/z5GvwXYQ8evDUvPBmguCK+x3Z54DlACXSNZFu/KbrC8wnZTDDySeaVf34AkQAbNpWii
	TlvJlnl8UbVagzSCTa7X2XpQrw4O7qUAoDjSQMUKWdJGz4Jn2hB1hYw6UI9bbY7BJN78ChAIqxs
	R7FqfI5+jFoCKehcrDTDwBcWqtaU6jBoXAazCTmu6ZxaQCcvp5cA9xY=
X-Received: by 2002:a05:6000:4812:b0:4aa:8da8:4bbc with SMTP id ffacd0b85a97d-4abb5702827mr38115253f8f.36.1795701195608;
        Thu, 26 Nov 2026 05:53:15 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm39382253f8f.47.2026.11.26.05.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:53:15 -0800 (PST)
Message-ID: <acb7a0f9-610e-40db-b38d-26e63fa5818a@linaro.org>
Date: Thu, 26 Nov 2026 13:53:13 +0000
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
Subject: Re: [PATCH 2/3] perf cs-etm: Use the packet instruction size for
 stack events
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mike Leach <mike.leach@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Robert Walker <robert.walker@arm.com>
References: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com>
 <20261113-perf_fix_gcc15_failure-v1-2-eae592c5ff64@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261113-perf_fix_gcc15_failure-v1-2-eae592c5ff64@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/11/2026 10:54, Leo Yan wrote:
> cs_etm__add_stack_event() uses the last executed instruction of the
> previous packet as the branch source. The decoder already records this
> instruction's size in last_instr_size, including for T32 instructions.
> 
> Use the recorded size directly instead of reading instruction memory
> again. This removes an unnecessary read and the dependency on DSO data
> when updating the thread stack.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 25f12bd110934a204d79244f45317085b7a81666..312d4a734e84faa0d24c4ac1fee16f4dae4c2398 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1626,7 +1626,6 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
>   {
>   	struct cs_etm_auxtrace *etm = etmq->etm;
>   	u64 from, to;
> -	int size;
>   
>   	if (!etm->synth_opts.branches && !etm->synth_opts.instructions)
>   		return;
> @@ -1638,11 +1637,10 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
>   		from = cs_etm__last_executed_instr(tidq->prev_packet);
>   		to = cs_etm__first_executed_instr(tidq->packet);
>   
> -		size = cs_etm__instr_size(etmq, tidq, tidq->prev_packet, from);
> -
>   		/* Enable callchain so thread stack entry can be allocated */
>   		thread_stack__event(tidq->frontend_thread, tidq->prev_packet->cpu,
> -				    tidq->prev_packet->flags, from, to, size,
> +				    tidq->prev_packet->flags, from, to,
> +				    tidq->prev_packet->last_instr_size,
>   				    etmq->buffer->buffer_nr + 1,
>   				    etmq->etm->use_callchain,
>   				    tidq->br_stack_sz, 0);
> 

Reviewed-by: James Clark <james.clark@linaro.org>
