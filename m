Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505709;
	b=4eIMPeK1ln6ij4B4J6POEQrZbEBel/oXUkPvkAoKUMyU24t4N5fKl8a+2tLnPRgEJTaO
	 M4Q/mUTEEikbXTKurMhzFOPn6UMne5Dfy+yFnFMDwXJl+LfDHmH/V99gdPQYnxY8YE68v
	 qrXrKBcgLuxz61iKPdvMg2dOEVO7T8c8s9akmwvm1TLBgg8zTWa7xhooFoEAvKphwMGk8
	 tmvMK7B2UY/y2c2GafHd/j4pOhcA39XRmXE9Djlz4AM6lcbDlQJUi2kz6fDiF303m665S
	 qryR25B2G5/R9n48FgNCP87wG0Z2dMj8i67yCUtfdGoRJUvNGNPa9g/w3UVAeACKoiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TDt+JfMyIatB2cuVyOJQlWyBeYbAwPRRdrD/q2KXZik=;
	b=uKx4tYDDeIYNjuByvAAXDsKbrHCiWXAf0i/c2VeNy0Cq9Wbrs4/vZCfAg5ppeqPMxbX7
	 /j1TLlgVC59gYsfkCi+0fttGunhK3SPmyIKLS4T4N2aFeVQHsteR8l/ZGJtJtgpu5biEh
	 +w7f1gI52UB+oSylUOW5vNA8IURGvKNmCAXNLO/EVqUoAIFL0DB9Gxd7b8Lm8UtAb7pGn
	 f4jlp5yuUH943NDKHkdlo5pzmIqA6Ah8B4TjREL3s8MmkNiXiK5LH4F6NPMl2k4dCjcJ0
	 1kjSExWTqkc3+PxoD9QkO4LWZrJ4grBDTKy01MhAFW1GyT0EeMcsHRgF6hB2Bbpz2XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kSGUdLXv;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B5606C8D3
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 310B5606C8D3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kSGUdLXv
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1f68a9855so4042215e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792505707; x=1793110507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TDt+JfMyIatB2cuVyOJQlWyBeYbAwPRRdrD/q2KXZik=;
        b=kSGUdLXv56CsYYQqoMEwLXdX2PTpSVghTbTPqBU2xBHAHRcblfZhae/Ep+ownzeE6l
         UVLVSJXNkO7jMVVBwOhzzB4MlDvkyvhl4MxODhaRCe5vMLQDHT4/qscmPp/trjWaS3dM
         OJYprIyyUPDJP2Ytc2+EMrGXREFaM+Hm4jlg8g0lszrxmFJM2nfaUCO1Gh9O5qlxuDmn
         z7wxNgMjR77l3OvVu9SYWt5Yj4IShWxONFS9c6w5vRcPZT9HmSFXO11W/gg9OWQrNyJR
         clt19/1cCtKI6xECLoqFuVLHQeiK3ePFwcSWe5kzr5w4MQ+L+P24+kMHI220hVfBcNO6
         4d5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505707; x=1793110507;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TDt+JfMyIatB2cuVyOJQlWyBeYbAwPRRdrD/q2KXZik=;
        b=nY8u4atvJfBF2reMXQy8EoD0ARy2Rzf2QwQkOzghSYUO4qMyvDRCw7YSaETlkK2lAb
         Ka1cPV/J4nWAbVdvCCM/J3dcJGyro+xbawdw0gDF5AfGtzwg/Rv4xw29jMJY0eFWar+b
         7p3aZlH7Dh5bray9u70AJ+WoDuU8z68xwqP3fKxAroJsFBtU6ZjxkGH7MNA0sta3GW6n
         VEHJAoeRQBOIpAfb5MIAtdfES8P6JwdzFqEQoQd7Gp2vgiYdR3Gcf9D8hPBU76ouVwNG
         SUKC4M+WMo3ToAj1KVY1diSfrU79xgTXoXYZlH9T5oOBJJ0DdeQplVugukOISk+f8CiD
         cIDw==
X-Forwarded-Encrypted: i=1; AKwUvBz84CGuieGeOu7v3uW5CsYuZILygRKz3usVI01FemedRdHNYrHLtmK224I7461u/hUXm5Ye6oV1BPf/ikzvEznL@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+jubYAkpf8q1a9E1LaYS5ggBEttVs/AB/KC5YbHYu94Acij2r
	hI9UC0n7MxHjTsL2B5zC02kcY3Ch0hSadkwH/KejgOO+z0syE0RPyM4iAidkM+1A1b4=
X-Gm-Gg: AYBFou1UrmMJ3eBHuDT0Wbbr/6t9a3L3l5DUcyH6HUkkokJcekkKJ/Yjx8xZii9iEbw
	SfHPfPcGNyh9yAckPX3F4dOdw+uC/VcaViivv2HMd0IRYSNOqft2Csn7It9DA1iGBHN5i5CmdB+
	w+4ld0r8JWhX6ZKCvRM9TuZOZ9+0CC24CapaJu863CrIwmofnkAk9j5l6hb9RZSu4SfwJMChk+4
	zvj7sSkHSFsKPBILQm39fyk2bU/LHbCtoH7R2hWaK97Rk71d/Q4Oo0sF/HFf2u82QgxrJ3d3BCd
	0hkUGyEfeGzNK6jmv3tej5oi60xGGPCGi2IS9Eq3kUD0Z3Hsvk6VzenkA6A7oxCFEZAHe+w1rZP
	oiHlL6FVX0CnUzF69iRyZSEoYRF99mFdukBIIGdVgJQGn5wE16hD8+YUVrd633rLo2bCs0LXzuU
	71DWUx9Plf7V5gaKdV65YdsOTATUcdikiYuy0BimBwD9NgePUNVoCEvZvK5M/rM2n9ghhFVYEcd
	UkkXIuBMJamWJbg60ehUnPJRNpQ9UevxqxSiEKg+jXlvEuxHj/MNLb+Aluh
X-Received: by 2002:a05:600d:82f1:b0:4a1:fa21:fd90 with SMTP id 5b1f17b1804b1-4a1fa22013amr20185225e9.9.1792505707365;
        Tue, 20 Oct 2026 07:15:07 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d569d4sm76416965e9.10.2026.10.20.07.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 07:15:06 -0700 (PDT)
Message-ID: <6c0d378e-8186-4e81-a2e7-7277fbd1cf93@linaro.org>
Date: Tue, 20 Oct 2026 15:15:05 +0100
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
Subject: Re: [PATCH 18/25] perf cs-etm: Unify timeless buffer decoding
To: Leo Yan <leo.yan@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
 <20260915-arm_cs_support_aux_sample-v1-18-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-18-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:49, Leo Yan wrote:
> Per-thread and per-CPU timeless decoding use separate loops for the same
> buffer processing. Per-thread mode already collects packets in a single
> trace ID queue, so both modes can share the queue iteration.
> 
> Use cs_etm__run_timeless_decoder() for both modes, keeping the thread
> selection in the caller. Propagate packet processing and end-of-block
> errors through the common decoding path.

This is very similar to what I've done for the JIT patches. So if we've 
decided to base these patches of that one then this one won't be 
required or will look quite different. So I'll wait for the next version 
before reviewing in much more detail. The kernel changes look good though.

> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 68 ++++++++++++------------------------------------
>   1 file changed, 16 insertions(+), 52 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index baa962085dba5226d9729a0ee8039374d5fcb1a0..1a53431161e995ba6b3cfdc86e338ed26e675774 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2681,47 +2681,9 @@ static void cs_etm__clear_all_traceid_queues(struct cs_etm_queue *etmq)
>   	}
>   }
>   
> -static int cs_etm__run_per_thread_timeless_decoder(struct cs_etm_queue *etmq)
> +static int cs_etm__run_timeless_decoder(struct cs_etm_queue *etmq)
>   {
> -	int err = 0;
> -	struct cs_etm_traceid_queue *tidq;
> -
> -	tidq = cs_etm__etmq_get_traceid_queue(etmq, CS_ETM_PER_THREAD_TRACEID);
> -	if (!tidq)
> -		return -EINVAL;
> -
> -	/* Go through each buffer in the queue and decode them one by one */
> -	while (1) {
> -		err = cs_etm__get_data_block(etmq);
> -		if (err <= 0)
> -			return err;
> -
> -		/* Run trace decoder until buffer consumed or end of trace */
> -		do {
> -			err = cs_etm__decode_data_block(etmq);
> -			if (err)
> -				return err;
> -
> -			/*
> -			 * Process each packet in this chunk, nothing to do if
> -			 * an error occurs other than hoping the next one will
> -			 * be better.
> -			 */
> -			err = cs_etm__process_traceid_queue(etmq, tidq);
> -
> -		} while (etmq->buf_len);
> -
> -		if (err == 0)
> -			/* Flush any remaining branch stack entries */
> -			err = cs_etm__end_block(etmq, tidq);
> -	}
> -
> -	return err;
> -}
> -
> -static int cs_etm__run_per_cpu_timeless_decoder(struct cs_etm_queue *etmq)
> -{
> -	int idx, err = 0;
> +	int idx, err;
>   	struct cs_etm_traceid_queue *tidq;
>   	struct int_node *inode;
>   
> @@ -2731,23 +2693,23 @@ static int cs_etm__run_per_cpu_timeless_decoder(struct cs_etm_queue *etmq)
>   		if (err <= 0)
>   			return err;
>   
> -		/* Run trace decoder until buffer consumed or end of trace */
> +		/* Run trace decoder until the input buffer is consumed. */
>   		do {
>   			err = cs_etm__decode_data_block(etmq);
>   			if (err)
>   				return err;
>   
>   			/*
> -			 * cs_etm__run_per_thread_timeless_decoder() runs on a
> -			 * single traceID queue because each TID has a separate
> -			 * buffer. But here in per-cpu mode we need to iterate
> -			 * over each channel instead.
> +			 * Per-thread decoding uses a single traceID queue;
> +			 * formatted per-CPU buffers can contain several.
>   			 */
>   			intlist__for_each_entry(inode,
>   						etmq->traceid_queues_list) {
>   				idx = (int)(intptr_t)inode->priv;
>   				tidq = etmq->traceid_queues[idx];
> -				cs_etm__process_traceid_queue(etmq, tidq);
> +				err = cs_etm__process_traceid_queue(etmq, tidq);
> +				if (err)
> +					return err;
>   			}
>   		} while (etmq->buf_len);
>   
> @@ -2760,8 +2722,6 @@ static int cs_etm__run_per_cpu_timeless_decoder(struct cs_etm_queue *etmq)
>   				return err;
>   		}
>   	}
> -
> -	return err;
>   }
>   
>   static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
> @@ -2774,6 +2734,7 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>   		struct auxtrace_queue *queue = &etm->queues.queue_array[i];
>   		struct cs_etm_queue *etmq = queue->priv;
>   		struct cs_etm_traceid_queue *tidq;
> +		int err;
>   
>   		if (!etmq)
>   			continue;
> @@ -2785,10 +2746,13 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>   			if (!tidq)
>   				continue;
>   
> -			if (tid == -1 || thread__tid(tidq->frontend_thread) == tid)
> -				cs_etm__run_per_thread_timeless_decoder(etmq);
> -		} else
> -			cs_etm__run_per_cpu_timeless_decoder(etmq);
> +			if (tid != -1 && thread__tid(tidq->frontend_thread) != tid)
> +				continue;
> +		}
> +
> +		err = cs_etm__run_timeless_decoder(etmq);
> +		if (err)
> +			return err;
>   	}
>   
>   	return 0;
> 

