Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931434DCE4
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604295; cv=none; b=R6nLTVlDcorGpsiT6u+o/TqMAmw96PesYBZysGyfVMW4EBSr6DU2AP6ek87MZ7GhahnDug6lw3qk8hOvfEBHTq4fwoyBfdg4KlwoccyVQgVhK84UhOBou22yixvRHSeDfhC07PI0jFCMQeoDV21cGFMwo6o704iI6bGZeIw/ST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604295; c=relaxed/simple;
	bh=K8TUer++txNK49pf0t5CLX+2korH0/JmLbO3bjePm3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKDTZyY+sWZUXh5irZbzYQ7LOOjwajEWsJvtlDllWTxxeqkO7gHwsVCrIdWu2CkpeBH16HJkvhB+DnjOmYCB8eof31y90Q1KxiNSE3QhLbEDoouAU6lCbIg578+UG/S4R/yMEmfUW1b0lBh23wk46+QKs7UVj9b6GOKgcHYEqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d/y/nvWl; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/y/nvWl"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-726ee1a6af3so9603616d6.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757604293; x=1758209093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zo+AxuGslDkd5fbnQiWxgtbbd7E4IX0SMnEbBhI36a4=;
        b=d/y/nvWlZe/JfZGDbdVurhybO1o60kIVAtvFSbt6EWLIhTUOrNmf5gH6clv0sv8M75
         vqI8/wPxjoBpkYSYGcUciyhMdvJ9YAL6IA8aakCpEO9zyYpKooibBWHH4k/+4eHZtdvk
         jod9tvF+uq+vnoD+ZwTWghkdAD9vAo6/kfVAk2S5WUn+04INuCpeoZn7sn6b3JYl38S+
         ZxUW32AsXPus96PdK7iNHMSF2jxhHKsUK+JJtVV/32nC8LsfaAdlTYc5A69POaJIEJc/
         pkEV7KF5qBeo+z72rc6X47+zelhG/EAzVitXI3wtKarUvY+u2T0u/uXlSEvub6L9lfJ+
         n8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604293; x=1758209093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zo+AxuGslDkd5fbnQiWxgtbbd7E4IX0SMnEbBhI36a4=;
        b=i4R4DUhhOLYRMM3B+Y2+xUV4gpkByf8IJMxUwXCxqRY0dyIsFj8UqEje9YTKDVda+r
         jIq7TSqwVAnbsxMcUWYyxRnXGFO5G1F0XfD+hVFDtrcbCuChnQsSzhlJmFGiL41pKgOu
         x2AkJAC2hvdn5wzEB/DmfOyjJWLslhz0ef+koJ6SIc2PJGZN7C3TuTWydMGcua3xuMq4
         nxxwNCXcK6qxdjv1m4+++VtUNspldtahZtUgThOTlaqlczNMaPAkE77TUFysiyXmeRxx
         pHdwMYAZjTMLF7G8NeOhn4Geo/C8ghCVAYX96Td1xyYGfANAhZ8S1I6ebJW/Yt39ie9G
         i0gA==
X-Forwarded-Encrypted: i=1; AJvYcCULK+eWnxAVqOzC3xusD16+4FosyKVsmA99V1olF1lOkKNvXto0ffG0LLnIgabKQPGo1JtjuV0FtxRuvPATzNDH@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+RsGM0c3J78xfu+I09kSM855eaAzeHb9PgbDufQJgQbTo4nv
	2iGh5WoGAMptkcZMWDRvexdoDDet8qLVkuNwhwNaXop8jo8oOAawNnK5oP0tr/r9jlg=
X-Gm-Gg: ASbGncvxKIuuoaUn1WxPFAmXQdPWpEsW18rj7/98YEySEIlmr6J4yRqmmSsWq6ZdY37
	0uEoQq/5Zfhce8mO/fbTLZhharkesPz6VseHZCtTSAHpt+U/o2NJOUzR0+Ex5SxAHFlJzO8qo17
	2XzLBLWIte4X4QlyZiJKqCFCJ5vzuAU1wh/qdocIQrYpMi7QJh7lYSIIwlYH85rtfuJi/fYyF4T
	VPhHpR12q9HNH8O0LgKXCKGVi4BjrOBMT1edL/jYc7DPsAZGk2LJfG8rOGFw3KrhK9FcnzlWfyM
	2fEVmf9Pit+72jSNYTRHqli8SR4xJ3ig7wZz9gWRvwrJKN72eUWsfJCYbnt6ja7ZA0QP9U2Hgl6
	uXOMZXNbeM108449G4zK+8hjhwfs=
X-Google-Smtp-Source: AGHT+IE9tYO8ouJst9OcD7maW1rdkSEF6jg7RSes/lxL3wo97/ZLhXjCjQhjWkuTW0RobiHij/g4Tw==
X-Received: by 2002:a05:6214:c4f:b0:714:6e57:5517 with SMTP id 6a1803df08f44-7394040cd65mr236155426d6.55.1757604292596;
        Thu, 11 Sep 2025 08:24:52 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b642265bsm12389066d6.27.2025.09.11.08.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:24:52 -0700 (PDT)
Message-ID: <c818c25b-eab5-42a3-88f1-e190fc303ddc@linaro.org>
Date: Thu, 11 Sep 2025 16:24:49 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] perf arm_spe: Correct setting remote access
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, German Gomez
 <german.gomez@arm.com>, Ali Saidi <alisaidi@amazon.com>
References: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
 <20250731-arm_spe_support_hitm_overhead_v1_public-v4-3-58e5677a412b@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-3-58e5677a412b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/07/2025 2:25 pm, Leo Yan wrote:
> Set the mem_remote field for a remote access to appropriately represent
> the event.
> 
> Fixes: a89dbc9b988f ("perf arm-spe: Set sample's data source field")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 8942fa598a84fb70f8c66649395bfbedcd42d380..8ecf7142dcd8705c13c27e0cbacd69647dc4fd22 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -839,7 +839,7 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>   	}
>   
>   	if (record->type & ARM_SPE_REMOTE_ACCESS)
> -		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
>   }
>   
>   static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
> 

Reviewed-by: James Clark <james.clark@linaro.org>

