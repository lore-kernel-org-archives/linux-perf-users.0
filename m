Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616768;
	b=z7+AsVGuEZIcnmKqkkI5zJOfUf0QyPTDB0e0QxgWQfzfQK+XtQ/q8TNFVhmXSbJNJC4X
	 UteTcZOfjsJLtG88ncq3cajaBxxYz4+47wWjGern03LAqEC3dxqaLaBPCvPT5uK4EhiYk
	 vnfrLkneERVlY2EVXBk0FToVipA3YDqCgHtkiykHXCNlYe7SQslzDgceg7xOAc8R5VqO9
	 y5IxzdWHR9rbYejZNXsTVcCTOD7NBZkGK41iZLnh8wCf9Vc4S7GOF9Vicdw1L5S6Q0u2Q
	 ldG83Cs8Cv1CX4a1L0JZ12zgHvk2L/E37gzfGlJ5IrSCzRvVpUSFIUAsQWfOeL6U4YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=aCuf2/0TwlruUJtCBmDukdp2i6RsScdYK46g4uR5+0k=;
	b=GvYZYWe5ZKbzwRExFFT9erRN5Gv7t6TlTOcwIvfXC96WrdFBdNT8Cx+9ci1e4YUYFRBG
	 2B3XlYF9xu6X+Qb1I2r7HuoI5npDURGqIm+mXnjunkbZzdCEsoMKeQAgi7z4XR8Zr9MhH
	 QYVZrCBmMpeEJz5dQsGmN/PlOYw51qxtqcR/uPaXFKvK/RBFdI/k6ndcPLib1ah4+UlRe
	 e4BFincNjxd8FOhzz05MroFGq7FJPcSw7Kux5DY7czdlLoXFCoqg2LJyUN7m3jUTamEFY
	 1LAK4krcvDpymqVbRnfFiv232tDqjOK+bSuzzos6BhiJRcr73cDe52AI1oiLLHKbIeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ahKvGQaL;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A9E606A33D
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 10:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6A9E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ahKvGQaL
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so23997745e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 02:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793616766; x=1794221566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCuf2/0TwlruUJtCBmDukdp2i6RsScdYK46g4uR5+0k=;
        b=ahKvGQaLhep8VQSyrCBqupdIr4zq4e+un2GbyZ4qyD2MJmMeM8b0ULI40LG05a1nPp
         a83IHDs9C5WuYLafz70HqiFP5VZYaEmtUCXuyNmhIwumBDCtjvisnlgwYwrY1KW+Ew7F
         GQTkCPM00Y54VRg8/mwK1r/wacU1cf91cpqOqFy3gKfL2oZBWBYfNr9m4KOP1TM9upTD
         gI4PfE8Pv1XAtQRz72KQNxJWIlAtyxszvpwuSBsQVT69Btp4ESpLj0rCsutZO/xrhqRJ
         mt8Vkjq80CaM20po7sHpU1XCPqhIv2EkTItHqOvAYjdg+4UXQJ/yaZN+mTIqEa2d/4g6
         yRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616766; x=1794221566;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aCuf2/0TwlruUJtCBmDukdp2i6RsScdYK46g4uR5+0k=;
        b=HHHA40ruYzw7CUjyWVtEwN52kk46145bhw8EcyWH2qEgpmJkgMPOoCYRilveGdUurL
         sUtLqWpjA8vdVlbeR6NkuSLH2DTsp868QTKsX2i44pz2w3ae6Jl1BoclCQ5JVZuD53xR
         p8rz+uClc97nd08zd3sF1tXjjXgFD6BkVn5cTkrxwybxWstdfyk0JkBglKJZS3wSLWep
         jAMcr8NprvZ2CbzweOuhIc+5/K/WZm+vW6zQoP9MNGFwaFKtQWaXHdoGMsqHsy9Gsw4q
         ZV9sn7FVEK3yzoskTL1P/N6uHGBAUtBKmMkVApDqEp3204yTN1+TwWqlNfIuqJ/9oQGK
         yopg==
X-Forwarded-Encrypted: i=1; AKwUvBydAv57b+VJwIIyouR7RMeLABOJKnk/sfdSL+0a6WkJ3SRSXX94Tlc30Kax7gkbGZ9WnEUvjQWo1ziAMUzrz9e6@vger.kernel.org
X-Gm-Message-State: AFq9FYIV60N2ahTHCEXZdUOeyL1Yp8rWgSdlN9vyMTk81rt6M5s8bTQw
	of4WCwnRQvQn2uSfm0bhdrn8ea3V4Fhb1gdBT/N6LCUe6TVhxxSWiHTLIuyZQWUOe8A=
X-Gm-Gg: AYBFou2u4XCwIQTUpdx2Q2321nmggA1H8D/3BwNYDyltzxXhS8+boddXeYmTSUviiY7
	kVV5Yf+3+h1yKRCDZZLvJfnT8U/YwQHGuGr3HTm57itbSugCKn4moeq++KGOi1OH9XRBXrRlp7u
	UV6bTms8yR0ImTHGF9U8CBcYPDgv2L7lM7AcL/g8foOfFRR7J0HqHrejA3DMAH/XJctPKxuPf64
	5Zj7lfbOvPKjaop7RwyOMbfIOYzh6XOsssdN2xeb3+9koGGKA+dMhKtAoxqVFz41/XWN7j44pxV
	wS4RumH8bidM3ilFVimRlb8iHweIiQx3K1lXsDI4PgAOxHTuu5cJiA2Qo6iTskBXqdcOe/x6Kv5
	j8AlH88pYZLaTBsAz7fGvHblJAYA9JC71Gj/ZEvqzG4bKpDGMYLPBdJNbmMQTVDKg+2RUsqas96
	KSyBeB9TjIoRGTUG/L/0uWO1T4QVKOvGFlsYVjYRWc0pov+IX33A5i+5E1qbhpK7/RQfWwKom7v
	fpt7WRtzeOrpRYngAhubjKz4ENGixodilJgJY5qmrph+DDaXo4j6xrVxLnGg+7zeK0fYuzH06uU
	78C69ASJIJooXtZuqc3yr4EmEUkh/XUoX7M3cEhpJEb7oHV/CSJQnA==
X-Received: by 2002:a05:600c:a103:b0:4ae:63e9:36a9 with SMTP id 5b1f17b1804b1-4ae63e93a86mr89899655e9.14.1793616766051;
        Mon, 02 Nov 2026 02:52:46 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab61d8b9f4sm309082755e9.12.2026.11.02.02.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 02:52:45 -0800 (PST)
Message-ID: <71e154fe-0810-4292-a955-f0cbab2b7e96@linaro.org>
Date: Mon, 2 Nov 2026 10:52:44 +0000
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
Subject: Re: [PATCH][next] perf cs-etm: Fix spelling mistake "should't" ->
 "shouldn't"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Garry <john.garry@linux.dev>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org
References: <20261028183137.537812-1-colin.i.king@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261028183137.537812-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/10/2026 18:31, Colin Ian King wrote:
> There is a spelling mistake in a pr_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   tools/perf/util/cs-etm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index bdcf94813129..65bce2450549 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -434,7 +434,7 @@ static int cs_etm__map_unformatted_trace_ids(struct cs_etm_auxtrace *etm)
>   			continue;
>   
>   		if (!intlist__empty(etmq->traceid_list)) {
> -			pr_err("CS_ETM: Unformatted queue should't have trace ID\n");
> +			pr_err("CS_ETM: Unformatted queue shouldn't have trace ID\n");
>   			return -EINVAL;
>   		}
>   

Reviewed-by: James Clark <james.clark@linaro.org>

