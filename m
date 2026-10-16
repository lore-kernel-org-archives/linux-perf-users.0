Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA734B1CEB
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158791; cv=none; b=O8FUJi+vtSgbZgXu1v/cnVORnBO4NNmn520tzhFVZ49h9Sgacog0lAARP3gWOnB3UbV6k5AU32ZeehLTq6GAy/smPdZrzGjGSeTqXcJsuNwm5QG8XXJJZEV8aKV7jx0R9iyPl9+pAFLWLd5yI9aIzGX8IRfc8qqc/iTj6zDilVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158791; c=relaxed/simple;
	bh=oNZoC/1XfNmiFXh0Vy39LTZxHGERleLuLCyxabvzoWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OyhQUTeBseAb9YgfOCjgmlJ2gwwp0LtpNNRa3PzIq1r0/2jyQoL3q73ID1p6tGnjNVls8z5jzq+GRV3O3Np6ECQ20kSTubjy9CtjaCLbRGYr64YrtvNBmkTsfo39w/2rPD/bvPldyPFH1pqzWp0VBPc8uon4hRlnbskStXUAoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B36rcz9t; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B36rcz9t"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a16bc2278aso46949695e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792158788; x=1792763588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5u1hd3MVH4854Wnbwnw1BZQepD7XiDLggdf6oqUpphg=;
        b=B36rcz9tosqcvMwRjZlWNJEugPuiP1/Vv11WHCTKzQPcBx2bck5/+9HD3aBgCFWR5b
         4OzHSE1LaWCQ0qNslA9cZVPTTK67KvuTW2gd3yF4qj74X8fUdcov9gd4GGmHxkN97xYV
         wyns4yjJkb6X+tl68GbxwUbzc7n29c09aJtEXCh/OkTUIjTFAXDIoLkAJBxqXqUH3PAw
         E1X08r1+HeeIJvHikozl7fZnl7FFkbjZED/R5m/dnDLnmB8oiQCm6mV6vom/pBV/PBo7
         htd09EEyBTxG9mkLKUjKakb9VzFW3Ts10uJe+uGGBetspL2Ve1gd8Ja6lgp8dnPEaWTd
         ZCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158788; x=1792763588;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5u1hd3MVH4854Wnbwnw1BZQepD7XiDLggdf6oqUpphg=;
        b=A7iM+RbY9Z0+xrNeWVVLQs0HUYMoX9dlrxgqao1CR0vG3MmF9+vhf7Ircgzq5Tw6kx
         N8hBVjXBxW3LrCByPPIHi96BysFpgk2RYpx3ncTSRz0gDiQ/lINmvbJJl8tyW3pIfAkq
         K4inxxCWqwquQLxJzLnNje6tQKtVqYWNuDP+rTRxZKvSqfoYJFKwEjRYoLLe4oox5CSB
         P8HMgYS2k62A+edg0NLOrZT8xhGmQaeO5h+Y4GvK7cw/WQaF7+4Mo8oVDPacrMvWqtQP
         qyY+hl45B1CGbtD6gNRM0hr9iPIpMXy/ErhBmvNMY7tafodBgBhKLy2yBDiFX7Opym0D
         S1fA==
X-Forwarded-Encrypted: i=1; AKwUvBwVLJn6KW/Pk27/WJpmPE4g8rLJ7Gh9sOkhl+XjTcp8bE+6BAmScHXvVwd64A3BVUhMQTVg6uk6qBDsjGsCCU49@vger.kernel.org
X-Gm-Message-State: AFq9FYJKE7PHDexJlbYvpTdia7DXr0k2OM6rJs+oun4o5YaPb83a0D5a
	ySgDNjRZ/cxFzveFzuMFH5M846xbSXyTNGgSbbPWkEKMnZwWVJqlIy8yRX/4EOA1v9U=
X-Gm-Gg: AYBFou0EbQtHFWMyNydMKbMc2+38yDADKiLSM9KVi+isI1qgCnvLmiwckbYmBSTxnYf
	S2NjdZnqsGwG0nOjlVPy/nSx3b5cnXA7CCbzOllQY6CKx4Da65OfjTKYxOnWNf9w/Xbd8vNF/2R
	SwLFRzvzAjMceZnm3EWpLgOdjguRAdrw8WIWBZwbPUtrfNHIH23gRuP2SGx3FiD348yZbYx9oSj
	jSK6UIjb3umdrY1O+w/K+k64+NVXMG58s+URLbmSG5qK5Pdu9/bDWP1OXiKBCtzn/bLjITY3Dnb
	fiYWCNbhf8w/rpU92j37MSfsHmL+xoBmWTXGmjVka4Jc/Z+3LgeqgaxRANkGy/BWmIraxh/U8+6
	ji+Dr/IyyI9UXCOYV1Y6ieeLxoAegHi/oS3RliynXFe5Vq3oiAb5yJBC4RqoHD+fEbLJl5z7f8B
	SwjUBaHriKK97Z+ppplfAGTt6o9Vqd71tC5vuDqj5HCDT8umQlMThinH/GM1QmrgyvqyfzhBTnt
	cU=
X-Received: by 2002:a05:600c:6388:b0:4a1:ac66:5ffe with SMTP id 5b1f17b1804b1-4a1ac666396mr241877715e9.15.1792158787676;
        Fri, 16 Oct 2026 06:53:07 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d0e2bb8dsm35630445e9.2.2026.10.16.06.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 06:53:06 -0700 (PDT)
Message-ID: <43db2ca6-27be-416b-83f8-131676e5d444@linaro.org>
Date: Fri, 16 Oct 2026 14:53:03 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/25] coresight: perf: Extract AUX buffer update helper
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
 <20260915-arm_cs_support_aux_sample-v1-5-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-5-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:48, Leo Yan wrote:
> The pause and stop callbacks duplicate the sequence that updates a sink
> buffer and finishes the current AUX output transaction. Move the common
> sequence into etm_event_update_buffer() for a single implementation.
> 
> The helper first verifies that perf handle is active. It updates the
> buffer when PERF_EF_UPDATE is requested and otherwise ends the
> transaction without data. The pause callback can then start a new perf
> handle for resuming trace.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 89 ++++++++++--------------
>   1 file changed, 36 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index a45f69f39f175f3044322b25fe5413fb97154496..13d865ca86f1161b2e21174f096473c4829afc8c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -637,6 +637,38 @@ static void etm_event_start(struct perf_event *event, int flags)
>   	return;
>   }
>   
> +static void etm_event_update_buffer(struct perf_output_handle *handle,
> +				    struct etm_event_data *event_data,
> +				    struct coresight_device *sink,
> +				    int mode)
> +{
> +	unsigned long size;
> +
> +	/*
> +	 * Make sure the handle is still valid, as the sink may close it from
> +	 * the IRQ handler. E.g., the sink driver may fail to restart the
> +	 * handle during interrupt handling due to insufficient buffer space.
> +	 * The sink driver must serialize update_buffer() with IRQ handling,
> +	 * so this should return either a valid handle with a valid size
> +	 * (which may be 0), or no handle at all.
> +	 */
> +	if (!perf_get_aux(handle))
> +		return;
> +
> +	if (!sink_ops(sink)->update_buffer)
> +		goto out;
> +
> +	if (mode & PERF_EF_UPDATE) {
> +		size = sink_ops(sink)->update_buffer(sink, handle,
> +						     event_data->snk_config);
> +		perf_aux_output_end(handle, size);
> +		return;
> +	}
> +
> +out:
> +	perf_aux_output_end(handle, 0);
> +}
> +
>   static void etm_event_pause(struct coresight_path *path,
>   			    struct perf_event *event,
>   			    struct etm_ctxt *ctxt)
> @@ -644,7 +676,6 @@ static void etm_event_pause(struct coresight_path *path,
>   	struct perf_output_handle *handle = &ctxt->handle;
>   	struct coresight_device *source, *sink;
>   	struct etm_event_data *event_data;
> -	unsigned long size;
>   
>   	if (!path)
>   		return;
> @@ -669,27 +700,16 @@ static void etm_event_pause(struct coresight_path *path,
>   	if (WARN_ON_ONCE(handle->event != event))
>   		return;
>   
> -	if (!sink_ops(sink)->update_buffer)
> -		return;
> -
>   	event_data = READ_ONCE(ctxt->event_data);
> -	size = sink_ops(sink)->update_buffer(sink, handle,
> -					     event_data->snk_config);
> -	if (READ_ONCE(handle->event)) {
> -		if (!size)
> -			return;
> +	etm_event_update_buffer(handle, event_data, sink, PERF_EF_UPDATE);
>   
> -		perf_aux_output_end(handle, size);
> -		perf_aux_output_begin(handle, event);
> -	} else {
> -		WARN_ON_ONCE(size);
> -	}
> +	/* Prepare the handle for resuming trace */
> +	perf_aux_output_begin(handle, event);
>   }
>   
>   static void etm_event_stop(struct perf_event *event, int mode)
>   {
>   	int cpu = smp_processor_id();
> -	unsigned long size;
>   	struct coresight_device *source, *sink;
>   	struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
>   	struct perf_output_handle *handle = &ctxt->handle;
> @@ -742,45 +762,8 @@ static void etm_event_stop(struct perf_event *event, int mode)
>   	/* tell the core */
>   	event->hw.state = PERF_HES_STOPPED;
>   
> -	/*
> -	 * If the handle is not bound to an event anymore
> -	 * (e.g, the sink driver was unable to restart the
> -	 * handle due to lack of buffer space), we don't
> -	 * have to do anything here.
> -	 */
> -	if (!handle->event)
> -		goto out;
> -
> -	if (mode & PERF_EF_UPDATE) {
> -		if (WARN_ON_ONCE(handle->event != event))
> -			goto out;
> -
> -		/* update trace information */
> -		if (!sink_ops(sink)->update_buffer)
> -			goto out;
> +	etm_event_update_buffer(handle, event_data, sink, mode);
>   
> -		size = sink_ops(sink)->update_buffer(sink, handle,
> -					      event_data->snk_config);
> -		/*
> -		 * Make sure the handle is still valid as the
> -		 * sink could have closed it from an IRQ.
> -		 * The sink driver must handle the race with
> -		 * update_buffer() and IRQ. Thus either we
> -		 * should get a valid handle and valid size
> -		 * (which may be 0).
> -		 *
> -		 * But we should never get a non-zero size with
> -		 * an invalid handle.
> -		 */
> -		if (READ_ONCE(handle->event))
> -			perf_aux_output_end(handle, size);
> -		else
> -			WARN_ON(size);
> -	} else {
> -		perf_aux_output_end(handle, 0);
> -	}
> -
> -out:
>   	/* Disabling the path make its elements available to other sessions */
>   	coresight_disable_path(path);
>   }
> 
Reviewed-by: James Clark <james.clark@linaro.org>
