Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8439021C
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643816; cv=none; b=tn6FRKoy01DysIjeN/Uouz7m9KaQJevzKqiKix+b3FtXhIOTwpPOqaUFCsfzF+gJ7MjoloRakhtyFSTayXsccgoKBjIGpY8Y6j5uryNMj0gE5zgI3KllBuVEMcPSOrC3SDamywAge9iO+g6zZGvhK3Z/XR/OAX74QK5AQXEHMxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643816; c=relaxed/simple;
	bh=Vyjb6+0DIOpIGUoZQY1e/3zvaf1QVV5DjcYtUgOiJUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cskgaOdR8hsxjHfKKCtv+c9EsIStA36HbiF8yLI7otjL9eI4lqErM9diLtjD8ANdu/wITNG04hk7sgT07lMP0yfWBiQyp2XrFHD6ojft3vZTXmfNwfeuTAOZ1WWsdAhfqYpbqXGGd+//qhreuFfZE3ejpqrGKeGnIiuXlCOpG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O4DSWyIP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4DSWyIP"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so13237109a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784643813; x=1785248613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uzQVXz3Vu5cQYnBTWDcGHmTfA/LK3pSTe6SHrggSaWw=;
        b=O4DSWyIPY8/MDLtAKpZBBonDRPHo3emnVMWZSzMvF7TI4X6D4syAnV2xUdzdRAg/tI
         bnl15+JeU7THxxu2qlXh8blEsED5lDXrAVv408kWhSZehUnawVFNOsIP3q1uLS7EtibF
         2QsphoaeFX+/epWv4pgpNNubTnXAYBCwG/eKCflaB5jv9Qu2QV+kXKIpjpFB9saIea35
         vWK1HjmnRyioLmGASaAGh00NFmC5jFlgKZfPRuhTffY7lCUNUIekeHXGZOlL3jFAc083
         F9czLcCFIK93QtbYZ+eFf7tf8EmoqR0Ut0oZSBcKrzXxt71ncmcjP8Fz10cJyMJJhEPl
         3nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784643813; x=1785248613;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uzQVXz3Vu5cQYnBTWDcGHmTfA/LK3pSTe6SHrggSaWw=;
        b=CICnJaGjqV+OOXjoNBP8knCAe7xMtZzZkkhtcgQSnZ9SFrj0vkdJIQTP1fHhHhpqVa
         gy7V9McMsCv58YaJcGQPeSP/O0FEfQJ6HZ8kBc9PNy+5oKMbF7fTSGR2L/SIrZ71bsOm
         z6KJDOqXSjKFRm12Rdd/Fk3+LoqkyEzS+tav8fqOLGO4HuPxUA8Htmk640BaR+Kz1B0i
         YGBP3flAI/uYWEg8Lft0F/NC/Uu93capL3WfffIinEY6oO/QGGcgYDB+QrtjwANhtfXZ
         e22qG4ZGvxD+SvahJ+Kn2lb4RikoeRLTYkagQIexP2w8d8UUZinKstGyOr2oOf2+zpwN
         3Zgg==
X-Forwarded-Encrypted: i=1; AHgh+RpHLoRJEyXvFlWZ3uLxqwcF9Ih8oPVZuv0U9oWnKlJhoqZFA8HP+n1wJmgvF0Skqymnrntl6iUaIxOz6drLRgTb@vger.kernel.org
X-Gm-Message-State: AOJu0YyPy8iKAZD7ikA/rlrr4phP8ZiZ2s+/9IJy/x1NOJSTJUcdwakS
	Au0CXFxyCmIbPLCWxySFURy8p1HVBUDKXg8d60rM4htl467JgW9g1chZxsq2z5cnyp8=
X-Gm-Gg: AR+sD11Hm3hANEYRrY9rSPgOQC3R3lTXHaokrBF6485lVZLHXJqmq5PvOiFJDHgl87P
	ON5esjYhx5+oytUmCrZzpmWlL5t8FWwfR6907Vgl+p92CP1GlQdeHP2OczhsfGO8PDa4PYQZcy0
	941Tn5WHdLRB4JyB+9kMFSBYLk9nDcumJlPbLhOaZ4YaRAf5OERkDen6amyp6/ELLBkqMhrPfle
	zaoH7EVgOaC6Tbjk/aqd3zx9a6LFtUwWZ/WH8LzonT0zYP01OLpd/V6W7Zmyf+cPAP3nbrTMphG
	NriJak+R72pHb6A+HgOwUWKfcPky8DHTlO93yEkQUf5zyFwfj5mFUuCmz4if7CJNmWwP+3PIltf
	7f1INg1OLa+PWp8m4nsbsGSgea+itsipD6R4K+NVBbo+TuKaem8RzQU4VZvqrJU78kYLR5zdzxH
	JMDUht2w75rdPXXtUiPg==
X-Received: by 2002:a05:6402:44da:b0:69a:af38:2fc0 with SMTP id 4fb4d7f45d1cf-69e652ddde8mr5595284a12.20.1784643813011;
        Tue, 21 Jul 2026 07:23:33 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e700055a8sm5846338a12.28.2026.07.21.07.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 07:23:32 -0700 (PDT)
Message-ID: <b12b6ece-16d3-483b-a1bf-30d41c6a252f@linaro.org>
Date: Tue, 21 Jul 2026 15:23:31 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf cs-etm: Avoid truncating AUX buffer sizes to int
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, Suyash Mahar <smahar@meta.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20260720-perf_cs_etm_fix_big_size-v1-1-97ded24636b1@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260720-perf_cs_etm_fix_big_size-v1-1-97ded24636b1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/07/2026 11:01 am, Leo Yan wrote:
> cs_etm__get_trace() returns an int, but it used to return etmq->buf_len
> on success. That value comes from auxtrace_buffer::size, which is a
> size_t. For a large AUX trace block, returning the byte count through an
> int can overflow and make a valid buffer look like a negative error.
> 
> The callers do not need the actual byte count from cs_etm__get_trace().
> The buffer length is already stored in the etmq->buf_len. The callers
> only need to distinguish three states:
> 
>    < 0: error
>    = 0: no more AUX buffers
>    > 0: data is available
> 
> Make cs_etm__get_trace() return 0 for all non-error cases and use
> etmq->buf_len to indicate whether a new buffer was found. Then make
> cs_etm__get_data_block() return 1 whenever data is available, instead of
> returning the buffer length.
> 
> Also refactor cs_etm__get_data_block() to make its return value
> semantics clearer.
> 
> Reported-by: Suyash Mahar <smahar@meta.com>
> Fixes: 8224531cf5a1 ("perf cs-etm: Modularize auxtrace_buffer fetch function")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/util/cs-etm.c | 46 ++++++++++++++++++++++++++--------------------
>   1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 95e3ec1171acc8442d8539a72a26a1a5a53a2f37..114b3cd2da495e54e78df8fbd707898312f95079 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1467,8 +1467,7 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
>   	etmq->buf_used = 0;
>   	etmq->buf_len = aux_buffer->size;
>   	etmq->buf = aux_buffer->data;
> -
> -	return etmq->buf_len;
> +	return 0;
>   }
>   
>   /*
> @@ -2151,26 +2150,33 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
>   {
>   	int ret;
>   
> -	if (!etmq->buf_len) {
> -		ret = cs_etm__get_trace(etmq);
> -		if (ret <= 0)
> -			return ret;
> -		/*
> -		 * We cannot assume consecutive blocks in the data file
> -		 * are contiguous, reset the decoder to force re-sync.
> -		 */
> -		ret = cs_etm_decoder__reset(etmq->decoder);
> -		if (ret)
> -			return ret;
> +	/* The current block is not finished */
> +	if (etmq->buf_len)
> +		return 1;
>   
> -		/*
> -		 * Since the decoder is reset, this causes a global trace
> -		 * discontinuity. Flush all thread stacks.
> -		 */
> -		cs_etm__flush_all_stack(etmq);
> -	}
> +	ret = cs_etm__get_trace(etmq);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* No more buffer to read */
> +	if (!etmq->buf_len)
> +		return 0;
> +
> +	/*
> +	 * We cannot assume consecutive blocks in the data file
> +	 * are contiguous, reset the decoder to force re-sync.
> +	 */
> +	ret = cs_etm_decoder__reset(etmq->decoder);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Since the decoder is reset, this causes a global trace
> +	 * discontinuity. Flush all thread stacks.
> +	 */
> +	cs_etm__flush_all_stack(etmq);
>   
> -	return etmq->buf_len;
> +	return 1;
>   }
>   
>   static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
> 
> ---
> base-commit: e01c7bd5b1eece254bcbf282db066b12c4815d21
> change-id: 20260720-perf_cs_etm_fix_big_size-ec5608f767df
> 
> Best regards,

