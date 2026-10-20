Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502639;
	b=3ftZO50tXLV+dA/9FW5rfmxsQvh+k55Ppbuc/b4BgqWo7wQVhsasaaW9QFv/xbUmQHzD
	 YMn0k2frsS8/cigyEfnT5VXwgXhNeOk+DAXBWM4OLJo/fQlvAWeZM+UDw4aslQbdumceJ
	 UCKTrqSwp/1ixtPwEBf3/Pea7z3JNj0r+VzufBcKrZLIWAkn0+uz4OCZFV9nkOh2xvXCP
	 O59A+1qox2nkuwRo5GFBNxSucj+buzS9EHLOCpcMS93LN5CqRPbQhXCiTl0aXpLSG5X6H
	 nJPR6PNleAtBj4CTx/I3PWMoLNQSzz4gPn8OmcoQVKBSqnpymXsOKIPGYL06Ypqp/8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=T2uaYBqUftcRpD2L16JDkdO6wqmonuMoZFfOWWQv7Gg=;
	b=zgJujyk7Dz4KESNsP+PSfObmky546d9Ve7XbkvhizkXIa+1hveZUcWsZogoJKVWZyrdf
	 ocFYetRHlrC8MEetDkbi2JbL8njd89CyqhGqqN0wGoNH46LowXhaTJwdUOwbqSMtsYyp6
	 dOdrQzAm4dTn2lvvmY6YwcohXZqPdwOvY3Wph/avD1It/V5OpeHFnpHx7l8X7tWggbQ3N
	 sbEg3FwRq4AfvmefPJsVYqri8yEILMR3U8OdFunC+ikD7XooodcjPNv5AE00+kA3X5fH0
	 PeMZvjOsNQgHcNvIH5cXx28TMsPLVBpAxHD+hIlB3MMLeconh5SjbVs7M1rkkUS85iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TUnDbbJ6;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1D606A337
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 13:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63E1D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TUnDbbJ6
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1efc90e7cso4369675e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 06:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792502637; x=1793107437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2uaYBqUftcRpD2L16JDkdO6wqmonuMoZFfOWWQv7Gg=;
        b=TUnDbbJ6pu9r+QN0gnuvY663hk4hHY1RCA0GjoO0As/x+/jReLTgoosYhEFRmvbuXD
         Z1v81IluqYPJElSH8ZndEpfUjKZCAouMKjQSVHdbkG8Y/CQQ+9nvFs3P4an/XEwcTGvw
         qaJ4J9pJsiRD+lta+FH+4wZTFrpXpW6neGfqi06aJcBw2dHjdnN3GdX/86+t5puH2yQD
         TX9uX8X30tRzlS3ibC0wc86fm9SuGmbHKvHQOYmeMb7y8ctBpA7wjUAmWZgUhdMRjv1T
         +yg6+zhbeOv/Z9dP3EHqBRLwoU49JaqaKm+F5TlgieBy2hhIHOp/fgqvVkVEKgM8gXMY
         Gt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502637; x=1793107437;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T2uaYBqUftcRpD2L16JDkdO6wqmonuMoZFfOWWQv7Gg=;
        b=wCc1I7tK7eJ0bZKmJ3TOy0tOlWM3WrOM4dV3iHp8MdYmDAK7r5s04TxGwNyU8Q87Nr
         efsEYn0ZVbLVdAPmG4edlDgNRAixZSw7TZUflZiab8zFfndK8Js2xxZZhizLezz5cQYN
         HxuD6azxIt8uBo9xcdDC88XwnJqC+CCl40j58Bkipl5KAv2iFqRnJyMcNmni4fpqIPvq
         mgd0+1EIkhXDfifwJsIOTkKR/egv7M9CJJEMEW5GtYIIS/CriJYL3ztB3w1cpyl2bbmK
         LxBIxs7UoGvt1TewdVX373KC4clKpbBzaQxIj0yZbjUGeoKf15YvHCiodgbmz6VyfAJ8
         ytaw==
X-Forwarded-Encrypted: i=1; AKwUvBzqnK5tCKwl+rMc2lHCGeFht3ehUiawUbtoeHkHJq+SThLfQG1OazLJUSraSc9CAKWyUIe0amm2++W9nDXrDLoG@vger.kernel.org
X-Gm-Message-State: AFq9FYJTCZZ3Z7kbgXlFq59bQ4y7Czr1pa/zMiGF83iCC2joQ9ThhzfM
	QWWnd/qrlA3ZogwHktTfnhJnzkH7UEiiPdIzapHIArGmYF7N2rKAkHasWwYUQ6bbvkI=
X-Gm-Gg: AYBFou038kzOweBVR3vVEbrAxhz9ex7ar/nF3x9/4w1da9fXfpTqSMhkE/x4H5e7LJd
	XaDcWmp+0PjDxdCGkEMAVe0iDjv7On+tBJqRYXRL8kvJ8+D6+ZckoZS5APGpr26AVjOo6Mg50+E
	WL70gvC4qsZWKCjD0sLBY7P6p3hspO9zv7DK9mNF7CoQ5fZP+3mZpHh2FuoZPN7esf+SQ03fnNt
	DmFaRszYshkSY9JuyuwU6Xv0NMM/F+BFNAOlbP9QlCWdLA3cyVasSjR4SME9u+BwZrZpJ3OcS9Y
	TL6deU34LH2qBFf3JUazPuB8Xw8bzk/v1jx1wC4IloSmbjD3sy5zvP3yh8TUZQsl5xFgrfS63Fs
	KfFGE6RUump22+ltuPMv1pGa4DcrpVLH6xxC128sQ8wgcxi9w9nkDXMlmwUZ6LnuTO58Yeflghr
	BV4uhO9rtn6M0lfa7fQ/qSD9TV8vPwb+LmoXowkLbwYlUKm7OV/wv5Za8BvyvcWIXEs37AXzRw+
	EZwnEyhUAY8Tjc=
X-Received: by 2002:a05:600c:638e:b0:4a1:a7f8:c124 with SMTP id 5b1f17b1804b1-4a1f4d7afcdmr43701515e9.7.1792502636695;
        Tue, 20 Oct 2026 06:23:56 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ce2b8bsm74994275e9.15.2026.10.20.06.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 06:23:56 -0700 (PDT)
Message-ID: <69dcbd3f-25bd-465e-a173-2729095f2dda@linaro.org>
Date: Tue, 20 Oct 2026 14:23:54 +0100
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
Subject: Re: [PATCH 17/25] perf cs-etm: Allow history collection for samples
 with zero IP
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
 <20260915-arm_cs_support_aux_sample-v1-17-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-17-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:49, Leo Yan wrote:
> Perf clears the IP of a user-only PMU sample when its interrupt skids
> into the kernel. The timestamp and TID remain valid, but the zero-IP
> check prevents --itrace=L from attaching decoded branch history.
> 
> Remove the IP check and keep matching samples to trace by time and
> thread.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 00407a80933e1c0b76260aed5894dece50b9aecd..baa962085dba5226d9729a0ee8039374d5fcb1a0 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3097,6 +3097,8 @@ static int cs_etm__br_stack_init(struct cs_etm_auxtrace *etm,
>   /*
>    * Add decoded branch history to an existing sample. The sample keeps its own
>    * ip, callchain and event identity; only an absent branch stack is filled in.
> + * A user-only PMU sample can have a zero IP when the interrupt skids into
> + * the kernel; its thread and trace window still identify valid history.
>    */
>   static int cs_etm__process_sample(struct cs_etm_auxtrace *etm,
>   				  struct perf_session *session,
> @@ -3107,7 +3109,7 @@ static int cs_etm__process_sample(struct cs_etm_auxtrace *etm,
>   	int err;
>   
>   	if (!etm->synth_opts.add_last_branch || sample->branch_stack ||
> -	    !sample->ip || !sample->time || sample->time == (u64)-1)
> +	    !sample->time || sample->time == (u64)-1)
>   		return 0;
>   
>   	/* Adding branch history to existing samples supports the host only */
> 

Looks like we can fix this up in Amir's patch that introduced it when I 
post it as part of the JIT stuff. Then this commit can be dropped.

