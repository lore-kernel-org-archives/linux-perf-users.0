Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC406FC3
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Mar 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253568; cv=none; b=SMx5lJ/I/dq5Gd0S3Mf83YFSJXgSlWJHYwuJpQbj/Tyct0e6+UI3VVc6p6qmv1P4ar0YF4WNUIlZizQP0rqAq3S1dWpF3QgfPuf+nysmIJmPV6rYXIorLe27q69zibfFIaQHr9aYei9zcgLMmiiyX9q/44SiLfRbU0AzLJeMqa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253568; c=relaxed/simple;
	bh=UsS0FlnmHRnFVYQHpbg+FSEoy7pTfCmMG79P0Z2IZMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlnfTUYz1nbB6T/KSSdd0XeplvzJdxGBgYZq6aTidf2W0TZk0OlgXB2AuFUyw3PZ4fQUUEIesOvPr/YJxroShb2WxYm8uEJe3pyUkr/66zdvVlztNd8I7g8layqQcWSpbZ2MY7SvDPatYi3zcTV/6Y2Rak6g21QcmUQJrMSnsnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vbw71ygG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbw71ygG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394036c0efso2240345e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Mar 2025 01:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741253565; x=1741858365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8jLHb9XLeLkNd1V0M5mOG56gSst9YbUJm3BRxiuGvM=;
        b=vbw71ygGKDcGNUR6fX7e7p8+flTQyig+nYFwkNyn1gTCuIg574xYxcXPOBveHW/rD9
         7iS2YqH5IZglQ2w92CDwb8UWwTVe+OVqZSlt1Mzt0fEYXK9sQnf54Be48LJoarLVTMIm
         qt+mEzHh2efSBavykFgL3orNGwSVgzGu0qJBeFa0FTzumE+5Txn1aU/pMwn4/b7/lyK5
         uSFI+wUCDEmTvN50Naoanonj2S2bLz+Jt5fiuF6MLeh/ogU5uEvIIOQzAV+71NugtkWA
         XD4Bm4M4dNeZKqu/B1MqHEshJTw1v9eekIRVs6bCyOWDuxAhU5ZF8K1M9Fj8Iaghd1/s
         eOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253565; x=1741858365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8jLHb9XLeLkNd1V0M5mOG56gSst9YbUJm3BRxiuGvM=;
        b=s9WWEjEWrGnqtOtDoWqpKrvxbkcac5SkAFSscZr9iU/+IiWXTi0JhLJBNThFD2w3G4
         l8nF4kJxfjCGdOZSewUOqQapQoMgXIebJKtFqwlIpr6E3opy+o7CG9Ph9pfUZrFTPXx6
         DUXYx9ezCtZGSEI2MWKfJZxfO50QBBdh9MMt4WnYo3FghPur+mi/Yw4ZcWxJmALh4yt0
         UX8qCl8dGkZ7BqLtUlfcnom+Jm86Ft5VkK8FbLwqUhAWKn2hrhHf4fDRvm2u0oAVe0LN
         cq/sG2Bz1MJnsg/TgkzTjtqb6zGwnRa+3GFTwQNcJAxDzrfmiy6GXO8y5lvfCaL0fvcb
         q2FA==
X-Forwarded-Encrypted: i=1; AJvYcCX9BrmGQsluAI3JVzPe4GpbZAEWP76evX89nK+KdJX7lcRk/AqVjBTnaMqMuVdoUzxzR+lSOoOB7EF1JqCmbbq7@vger.kernel.org
X-Gm-Message-State: AOJu0YwqOMzDF9fHuQoaU1rdo2YEy1QGntm2h5C1y7Y9uiIKz2tzK95T
	1Qv8MiODoygnSklzru6ZVBJBxxm99gF561N93vUTeuMDrCSo4As/tBI4E6sEiMc=
X-Gm-Gg: ASbGnctVYTV2yGytlskMVWA8uYCG4y4tbzziudhYMynYLKDab+sEvpSZczYknxAsd03
	uY+tV+93/qHMY7ExZZn9H7oilKgIizVl0mpziOYINbYHDP3FBS5mGJvkMKSWSEx5vKlUDyAGaiJ
	WRwIazOyoao3/heFfMVgcn2d72v5aoBqMG/BxEkYO1gecdTVSvJ0plAMrHKUhOxcmFp+sD8nt9x
	FXsCj2QW/Til6Hme85Zh9K3VpqQhPYLEbViNPPGerFLCHImBd4x/SjhfSkadoYlZqC2UvnUSUud
	j3NhaQihmGz/Hkk6MLDl9k+9q0bKzpvgbhC7HbyCxcD/KKiNhv3vUg==
X-Google-Smtp-Source: AGHT+IH9QNZRukaghEgEGZYND9m5AIVeLbN9y67lK4LiB7hdnUt2gHh3F53IatBFd0ysdQ2ADR89Lw==
X-Received: by 2002:a05:6000:154c:b0:391:275a:273f with SMTP id ffacd0b85a97d-391275a2a0dmr2505803f8f.4.1741253564880;
        Thu, 06 Mar 2025 01:32:44 -0800 (PST)
Received: from [192.168.1.247] ([145.224.67.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102b62sm1410454f8f.84.2025.03.06.01.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:32:44 -0800 (PST)
Message-ID: <204e94a7-24e1-4dc2-b6ee-8527510a275b@linaro.org>
Date: Thu, 6 Mar 2025 09:32:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf/arm_cspmu: Add PMEVFILT2R support
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org
Cc: mark.rutland@arm.com, bwicaksono@nvidia.com,
 ilkka@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <cover.1741190362.git.robin.murphy@arm.com>
 <b11be3f23a72bc27088b115099c8fe865b70babc.1741190362.git.robin.murphy@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <b11be3f23a72bc27088b115099c8fe865b70babc.1741190362.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 4:10 pm, Robin Murphy wrote:
> Architecturally we have two filters for each regular event counter,
> so add generic support for the second one too.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/perf/arm_cspmu/arm_cspmu.c | 7 +++++--
>   drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 053bb7920df6..efa9b229e701 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -183,6 +183,7 @@ arm_cspmu_event_attr_is_visible(struct kobject *kobj,
>   static struct attribute *arm_cspmu_format_attrs[] = {
>   	ARM_CSPMU_FORMAT_EVENT_ATTR,
>   	ARM_CSPMU_FORMAT_FILTER_ATTR,
> +	ARM_CSPMU_FORMAT_FILTER2_ATTR,
>   	NULL,
>   };
>   
> @@ -767,9 +768,11 @@ static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
>   				    const struct perf_event *event)
>   {
>   	u32 filter = event->attr.config1 & ARM_CSPMU_FILTER_MASK;
> -	u32 offset = PMEVFILTR + (4 * hwc->idx);
> +	u32 filter2 = event->attr.config2 & ARM_CSPMU_FILTER_MASK;
> +	u32 offset = 4 * event->hw.idx;
>   
> -	writel(filter, cspmu->base0 + offset);
> +	writel(filter, cspmu->base0 + PMEVFILTR + offset);
> +	writel(filter2, cspmu->base0 + PMEVFILT2R + offset);
>   }
>   
>   static void arm_cspmu_set_cc_filter(struct arm_cspmu *cspmu,
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index d59040d6a7e3..19684b76bd96 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -47,6 +47,8 @@
>   /* Default filter format */
>   #define ARM_CSPMU_FORMAT_FILTER_ATTR	\
>   	ARM_CSPMU_FORMAT_ATTR(filter, "config1:0-31")
> +#define ARM_CSPMU_FORMAT_FILTER2_ATTR	\
> +	ARM_CSPMU_FORMAT_ATTR(filter2, "config2:0-31")
>   
>   /*
>    * This is the default event number for cycle count, if supported, since the
> @@ -72,6 +74,7 @@
>   #define PMEVCNTR_HI			0x4
>   #define PMEVTYPER			0x400
>   #define PMCCFILTR			0x47C
> +#define PMEVFILT2R			0x800
>   #define PMEVFILTR			0xA00
>   #define PMCNTENSET			0xC00
>   #define PMCNTENCLR			0xC20

Reviewed-by: James Clark <james.clark@linaro.org>

Minor comment that the doc linked at the beginning of the file "ARM IHI 
0091 A.a-00bet0" doesn't have PMEVFILT2R, you need the latest version 
for that.

