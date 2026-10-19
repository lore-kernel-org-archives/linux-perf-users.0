Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C54E06D9
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410856; cv=none; b=lUqW/0+j4ywNvbMntBK/ekgaDuJ5rpPEEtqJ/AOw30VwRBlZ0aybBTV4vd2GzjzZEPI711E85CB3qed99GtFZGzaIEMca1ZTMwUWkiiEoy/xVoaAM2VkDbi2x0mCnEjqxGYkthYCfnnCjqHgJgnxp4wa5Fkzf50wA4SD+FEiK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410856; c=relaxed/simple;
	bh=IBXBdxbYHimkoMM+XMeqTFEe7fU69XJjeKdcPHeecxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxadIzfxLj7Si54BWKFbJcPvDn1/OFY4Vfks0sHhtM5zFj2v9NkSJqwqudUsvdk2xnF9Cd5+YfKNyzhlcGC7DL1qWwBlNWJtb+m3jNFh23XzPCJiYg3iRyW/xUx2Rh7Gl56yQ4cEMYuEvYQFghvWDKk6cjRY29wDdzukdstIifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v3a4OZW3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3a4OZW3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b060ec084so1333192f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 04:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792410853; x=1793015653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Oq/GPmuBLsTY8Av2UJYLNH0P0AYmxlI1V5awo5gufM=;
        b=v3a4OZW3YYdFyZp1UYK50eE6m7aYc5DxJeSc8VkvI0U8qORmQ7Iw0EVlJfuN/NrJXK
         /DmODUK4xoH+1iXLS+jlBgffTuNFa4dyfnDmL0kYlVKC7BKgDrixTd4zXeyGG/bIixOL
         1k2AHlKR/aLmGdAH3z2OhqjJ7IGI4VjR/9Y+MBK70V2K9NSj3p6Hs/Jm8cvj6o03YO9x
         6KMHyKXtj+jgDE0jrcgJPSWgVjNxfXF7cuBAXPJMaBupxiz1hTNWESJ1UIsOBl7KhmVz
         BJMidgkKDRA7TNJQTiFKCI/gmAi92VYCg6SPcqqM7LfoPBmRIC0rTtb6pKOE1bJ+3zRi
         qa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792410853; x=1793015653;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Oq/GPmuBLsTY8Av2UJYLNH0P0AYmxlI1V5awo5gufM=;
        b=cB/lG/uQLGVXnrVN8/0S9uDyC4sWBstN3tabmlyEd5OWeem1wUpj/1y5GwXLGr48eO
         afV1zyXKQEu48plZJXXMlW6dl+nddXw8yy06nm+ZHqWCc7Ljnj+ANyzBNqHX20gPJshY
         Y81yQwZzDrPiUmdqhiY8hQOAVUkw4IhBemA7XstpUfgh0zbEbtauHQJPb+HD0BAzLuQZ
         Jbk1OrsOKkMMQ9Ga+Hbav7NasUbxbJVb9NDLcdBFP6bw2tpWIY6CLdW+dGa9n9hPDVMn
         duFWy4MTxGe57JH8Uqwc4Hyzrf/fbhgWN47WGhiY3rksb/FOmn0QudZ8F0Q7jQVjGl1d
         JzNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwni0G26/EDYx6tVpu0vkqW9p7AxG7B4was4O32DJlqU5S/2Z+ZME29Avd/TgHYMFqbR897t7TaMFnG6GgX2bwO@vger.kernel.org
X-Gm-Message-State: AFq9FYKwiJ/a4gFQ1UWgdjau/o3rclmnrgPD8a6JpxfyPZibE2F9K4nM
	EKvpOy4Q3ntRaKjgF8LWUeESciyrVFyX4jxCDjAGpK4WStShKH19/ppTpZkf6+f7iiU=
X-Gm-Gg: AYBFou15GrNwiDt84xwAPGp65sta7+IE5LwKTPa4iUrORKkJZXNds4apAMptAq/66Ro
	GSV+7S+6hFNhf79qcsIzNoJmwancYlYYA+GXuDI4OWq+qoesQGWO81Of+OR92zvFhC1lEJOTlN1
	CR0IzurtvA4TQyfgu5V9Cje4stzhhMydcNKN/kLtWduPPPra9o7pXTd9ejCrthH42+eYvbCOBvx
	ivGZRIy2NAiSbt1kFzzrO22qqAq+myb8NOcyvavRzYvZeaYruXstPdwEuDgDjq3cfoRCD6r1S5E
	7Vv80DHsB4qa3C1mFZUzcil75MST6Np0OtajdShPFGRsb4Kb+46auQleKEye5OwxoeZqVuFH/8w
	2kxWoeyoUQ8GmG/UglEjatatUNuRTvFhqHis6Ty85OtJ/WmrwqYTh1LxKcwzafKI1T+xHDW6qCJ
	0ZPV6NAJOIibZOM4OlAj5qD5iA+Wp9fbsVzr7wNRQTN11JexDeN1JRme+VzOPW6sHcPT1XdQt5s
	XE=
X-Received: by 2002:a05:6000:2dc8:b0:48c:4d32:ccf8 with SMTP id ffacd0b85a97d-48e07bbe524mr14711381f8f.16.1792410853522;
        Mon, 19 Oct 2026 04:54:13 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4978sm21216127f8f.21.2026.10.19.04.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 04:54:12 -0700 (PDT)
Message-ID: <aadce723-2a51-4d57-8d16-03a101d1a93f@linaro.org>
Date: Mon, 19 Oct 2026 12:54:11 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/25] coresight: trbe: Track per-CPU sink interrupt
 handling
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
 <20260915-arm_cs_support_aux_sample-v1-12-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-12-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:48, Leo Yan wrote:
> A sampling NMI can interrupt TRBE while it is using the active AUX
> handle or buffer. Circular buffer mode avoids wrap interrupts but can
> still generate fault interrupts.
> 
> Add an in_interrupt flag to per-CPU sinks and set it around the TRBE IRQ
> handler. Compiler barriers keep AUX buffer accesses between the flag
> updates. This lets NMI callbacks detect when they have interrupted sink
> handling before modifying its state.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 17 ++++++++++++++++-
>   include/linux/coresight.h                    |  2 ++
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index ab3c5c7d27f3d272b07eade1e6452559808b196c..8eb625d3fc99db57a18e35ef59ef814dacf20a09 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1185,7 +1185,7 @@ static u64 cpu_prohibit_trace(void)
>   	return trfcr;
>   }
>   
> -static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
> +static irqreturn_t __arm_trbe_irq_handler(int irq, void *dev)
>   {
>   	struct perf_output_handle **handle_ptr = dev;
>   	struct perf_output_handle *handle = *handle_ptr;
> @@ -1249,6 +1249,21 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>   	return IRQ_HANDLED;
>   }
>   
> +static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
> +{
> +	struct coresight_device *csdev = coresight_get_percpu_sink(smp_processor_id());
> +	irqreturn_t ret;
> +
> +	/* Circular Buffer mode can still interrupt on a fault. */
> +	WRITE_ONCE(csdev->in_interrupt, true);
> +	barrier();
> +	ret = __arm_trbe_irq_handler(irq, dev);
> +	barrier();
> +	WRITE_ONCE(csdev->in_interrupt, false);
> +
> +	return ret;
> +}
> +
>   static int arm_trbe_save(struct coresight_device *csdev)
>   {
>   	struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index ddf18c970e343041787424c2019f2b5dd49154c2..8830c30be0df53a22525ef4fc3c7e41a0ec6fd90 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -275,6 +275,7 @@ struct coresight_trace_id_map {
>    *		when a source has been selected and a path is enabled from
>    *		source to that sink. A sink can also become enabled but not
>    *		activated if it's used via Perf.
> + * @in_interrupt: Per-CPU sink interrupt handler is running.
>    * @ea:		Device attribute for sink representation under PMU directory.
>    * @def_sink:	cached reference to default sink found for this device.
>    * @nr_links:   number of sysfs links created to other components from this
> @@ -299,6 +300,7 @@ struct coresight_device {
>   	bool orphan;
>   	/* sink specific fields */
>   	bool sysfs_sink_activated;
> +	bool in_interrupt;
>   	struct dev_ext_attribute *ea;
>   	struct coresight_device *def_sink;
>   	struct coresight_trace_id_map perf_sink_id_map;
> 
Reviewed-by: James Clark <james.clark@linaro.org>

