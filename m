Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007448;
	b=GPUF5jlLvuZTjQ0ma+ZfXXRZYyhXvw3O7jbECQPeLId9izTFzHzJPiT8wKYn6O8yHedT
	 at/Djyol/JNBFr9vm0hD6cAG6huGlkDSDUSYXVog6bsBD2exTMT5Vhert0eZuhNy+zM1U
	 jQmUVtgwm1H0Riu92Iek57hhTc2U48tPKdJavb1azR4hEUGsxNLK6oWsJzFDco2Ra+GRM
	 oIangymZNZFP6lacWmIrhhOAEHpnBtSq1aWROX7vsEqPyODwRNffaTjqtLyGy1v8oZO6q
	 lSPbUVVXfNlk7fUJs0WzsxAe6mG0Q2fe9lIWlI56uaQTzmhrurkClXqGCuNZZ6sxtaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=V0PxtI+uEAhVBAWQKpyvj24AYTBUji0RB6U5PTo7niU=;
	b=nxbESSzkDQbiA2zTrHG9LgKqFsPhNpBT+WNSg4iuOvMNTq+l6t9TzxCpIGJ0M+Z/MDoc
	 2tfqo5G26sj/JatfZhivaVMarnv9Q4zErfdToKnPi03jMx1p1JECzO1rktiK3htitpwNn
	 MIDXG7YLiQSwi0eS5rqhR8umjTLmaitlVHyjeQzTpDdtdMvqJDjkcEgDp5MqavRj4exBT
	 ApuB/6roWswM/Bxcr7GBX63nxqWEnUeLCsu5TxVot7Tcp/RHq6w2VWgx2K4yxNLTeV1UG
	 gDLdAQ3lBmP4K8/TlPqSm9tLaHIptMEk2tGt1c363Hb64DBoaJ7+bvuxNEUO7xHoxOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tLf+eDyC;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF962606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF962606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tLf+eDyC
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so15162515e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 02:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793007446; x=1793612246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0PxtI+uEAhVBAWQKpyvj24AYTBUji0RB6U5PTo7niU=;
        b=tLf+eDyCrqkusRn4LesJuB4DaDDh5/20b7Ue98qaLBaWiRTiOG0IbPjyJjMjTYiwLg
         dG08uCjck78bfH41rpV2uiyRlUzy2d5tv+1dehSR/g/AXAbVjTMOGtKej5MUjryp6PHO
         u8598BsZxuD0XuUcH+Gzv3Mc65o3jEZlmaDNhJbnM2vzwtb7cu3mPasSSql4UpYGJB9P
         hBR69WATa8I9YFSDMTLYtWkj06NsFAMep3lUE30OCPqLyZUc7r/JeCRXZZK7nRa5ypTK
         CcrNvxxovTAwTyHJqHq0DjWfwPKi+GhZBbnfsagbyd5p69+wW5WCVI5MHae6IxwsgaHj
         En+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007446; x=1793612246;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V0PxtI+uEAhVBAWQKpyvj24AYTBUji0RB6U5PTo7niU=;
        b=szZA1K8KH2hMrM2ut9IRjn4suCk+qt86ogmCPuAE/bOo8zIMUo00jd7jy0g704rLNr
         ZPXRY2XT/sqSvsrOAO8fdluPyu7ONhwz+GasuELbzdX6ggr6lJuB13iABlO3/KXziWpj
         x0ocWgIUg3quoUaItoJi7AlEXpYvNad+Yt1QQ2ShC0KBTkrs56eu19WaCuEsG6hzme7P
         Ok1578ToEdxzYpbECVcXsxdV1w9CL+v9TxdDM6k40vl9nMy6rGyNvgA6/saco0QaPqbM
         hYls/bjbqf6Rj20JlVYmqlT0/4JeU2dE7sBOWvudLmoaqEsxjrVOB7XfGIvBupxwXw6e
         +Mcg==
X-Forwarded-Encrypted: i=1; AKwUvBz4zuO015hx2DYyNcaOgqpt5xSzTG2/ijxWjGvAg4sSv7hN1wTaPhdYftehagfqfAyr7QpAicNjehvypz5hompo@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5mGZhLHbfaqzOEY7dwSfEPVt8KEedhBj7U2O9qS8P5fF7vj5c
	bYU848OTIE/rmjRTMWyhCmrVp0d5sjPn1u72kuzB6965+kTQDDOPU4hII0NhIQ60s2M=
X-Gm-Gg: AYBFou1G+WxJ6bQkAAeqdwZ6hi17OTcdFJNHXAVKRAR8yjahllIdMWDyRgnO2ptFP+b
	avI+F05rQuA4ajF2P4PRnMOEWzzg+4RKtSJbUOE79AeMYWgLZe4xuG1jZuksjnmNiBKCkpcoDLi
	z0YbCjEDF5m36AC55aCRBgz4eXJM0R6LEkIF+XhSDYErAK7WpKQ/5FEFptSavKhnoXREovxrWiv
	fMiFve+NBWjy3tEStQxp5r3CeZPAxGAVogHlYq+0XpzgtO10E1GuKRD7a9/fJy+pDnHhv7K0P0x
	jcE8dn7cK7+4qBUyLNqYJgScVdGkKQtLjxPuTVBvYUovex9tvGooEcUhbMc5yFPADJ9LeuDsEB/
	Uiz9yZmIQwqSB6SY3fGno2/vrRvc/nDDy2bqLIPMKprfby3Pj+uC/oiD4a1ehDvxfa95Gf9bgcq
	egAuM3DKH2fB09TDaKPBW/6JxdUOI7smEhHIveIx5t/W+S26V8H0XYAozi6PB+FcQQBRXNuL6Lg
	UT5mmaFIpO9dk1GbjUYi572Z3w6c9H7VtadRXm4U2PtW64w8lt+GNEQ8dMK
X-Received: by 2002:a05:600c:4704:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4a35acbd575mr121663115e9.16.1793007446278;
        Mon, 26 Oct 2026 02:37:26 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm15638434f8f.21.2026.10.26.02.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:37:25 -0700 (PDT)
Message-ID: <84e1c5ed-cb93-45b6-8cf1-6c6778efe412@linaro.org>
Date: Mon, 26 Oct 2026 09:37:24 +0000
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
Subject: Re: [PATCH v4 1/7] coresight: etm4x: Fix event count decoding
To: Amir Ayupov <aaupov@fb.com>, Leo Yan <leo.yan@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Daniel Pereira <danielmaraboo@gmail.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <4d45171946cf41751215e8c1cd9a8b14d38d3159.1792989860.git.aaupov@fb.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <4d45171946cf41751215e8c1cd9a8b14d38d3159.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/10/2026 05:48, Amir Ayupov wrote:
> From: Leo Yan <leo.yan@arm.com>
> 
> TRCIDR0.NUMEVENT normally encodes the number of events minus one.
>  From ETMv4.3 onwards, including ETE, a zero TRCIDR4.NUMRSPAIR instead
> means that no events are implemented and NUMEVENT is zero. The sysfs
> event controls currently interpret this combination as one event and
> allow writes to unsupported event fields.
> 
> Decode NUMEVENT after NUMRSPAIR and store the actual number of events
> in nr_event. Use the decoded resource count so that older ETM versions,
> where a zero NUMRSPAIR represents one resource pair, still report at
> least one event. Update both sysfs event controls to use the actual
> count and clear their event fields when no events are implemented.
> 
> Also correct the instruction event enable mask for the single-event
> case to use INSTEN[0]. The existing mask uses INSTEN[1], preventing
> event 0 from being enabled.
> 
> This change depends on the recent driver refactoring. With no reported
> failures, it is not intended for stable backporting.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   .../coresight/coresight-etm4x-core.c          | 13 +++++++--
>   .../coresight/coresight-etm4x-sysfs.c         | 29 ++++++++++---------
>   2 files changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index e21be6468e954..af017bd8a5477 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1451,8 +1451,6 @@ static void etm4_init_arch_data(void *info)
>   	caps->trccci = !!(etmidr0 & TRCIDR0_TRCCCI);
>   	/* RETSTACK, bit[9] Return stack bit */
>   	caps->retstack = !!(etmidr0 & TRCIDR0_RETSTACK);
> -	/* NUMEVENT, bits[11:10] Number of events field */
> -	caps->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0);
>   	/* QSUPP, bits[16:15] Q element support field */
>   	caps->q_support = FIELD_GET(TRCIDR0_QSUPP_MASK, etmidr0);
>   	if (caps->q_support)
> @@ -1519,6 +1517,17 @@ static void etm4_init_arch_data(void *info)
>   	caps->nr_resource = FIELD_GET(TRCIDR4_NUMRSPAIR_MASK, etmidr4);
>   	if ((drvdata->arch < ETM_ARCH_V4_3) || (caps->nr_resource > 0))
>   		caps->nr_resource += 1;
> +
> +	/*
> +	 * NUMEVENT encodes the number of events minus one. From ETMv4.3,
> +	 * including ETE, NUMRSPAIR == 0 means no events are implemented.
> +	 * nr_resource already accounts for the pre-ETMv4.3 encoding.
> +	 */
> +	if (caps->nr_resource)
> +		caps->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0) + 1;
> +	else
> +		caps->nr_event = 0;
> +
>   	/*
>   	 * NUMSSCC, bits[23:20] the number of single-shot
>   	 * comparator control for tracing. Read any status regs as these
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index db9e603f97ba8..fb38f0102290a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -513,19 +513,22 @@ static ssize_t event_store(struct device *dev,
>   
>   	raw_spin_lock(&drvdata->spinlock);
>   	switch (caps->nr_event) {
> -	case 0x0:
> +	case 0:
> +		sysfs_config->eventctrl0 = 0;
> +		break;
> +	case 1:
>   		/* EVENT0, bits[7:0] */
>   		sysfs_config->eventctrl0 = val & 0xFF;
>   		break;
> -	case 0x1:
> -		 /* EVENT1, bits[15:8] */
> +	case 2:
> +		/* EVENT1, bits[15:8] */
>   		sysfs_config->eventctrl0 = val & 0xFFFF;
>   		break;
> -	case 0x2:
> +	case 3:
>   		/* EVENT2, bits[23:16] */
>   		sysfs_config->eventctrl0 = val & 0xFFFFFF;
>   		break;
> -	case 0x3:
> +	case 4:
>   		/* EVENT3, bits[31:24] */
>   		sysfs_config->eventctrl0 = val;
>   		break;
> @@ -565,22 +568,22 @@ static ssize_t event_instren_store(struct device *dev,
>   	/* start by clearing all instruction event enable bits */
>   	sysfs_config->eventctrl1 &= ~TRCEVENTCTL1R_INSTEN_MASK;
>   	switch (caps->nr_event) {
> -	case 0x0:
> -		/* generate Event element for event 1 */
> -		sysfs_config->eventctrl1 |= val & TRCEVENTCTL1R_INSTEN_1;
> +	case 1:
> +		/* generate Event element for event 0 */
> +		sysfs_config->eventctrl1 |= val & TRCEVENTCTL1R_INSTEN_0;
>   		break;
> -	case 0x1:
> -		/* generate Event element for event 1 and 2 */
> +	case 2:
> +		/* generate Event element for events 0 and 1 */
>   		sysfs_config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
>   						   TRCEVENTCTL1R_INSTEN_1);
>   		break;
> -	case 0x2:
> -		/* generate Event element for event 1, 2 and 3 */
> +	case 3:
> +		/* generate Event element for events 0, 1 and 2 */
>   		sysfs_config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
>   					     TRCEVENTCTL1R_INSTEN_1 |
>   					     TRCEVENTCTL1R_INSTEN_2);
>   		break;
> -	case 0x3:
> +	case 4:
>   		/* generate Event element for all 4 events */
>   		sysfs_config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
>   					     TRCEVENTCTL1R_INSTEN_1 |

Reviewed-by: James Clark <james.clark@linaro.org>

