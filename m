Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6C267B07
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807397; cv=none; b=nMRIwTuTHbyRV4lJ2yTZ14Tvwdpy3cK1FNQ09EFM7oQOShB+uxdXWzbOiG+5lRUxywEkH3sxUa38yRu23cnqkeaezAeoRGFYp36BKXamzP4hpzSUXGflNj+v8yn9d+f2LjCbwVEn0+YSvSe6iS2FbDdDAXdeGxRiDDrzQBiuuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807397; c=relaxed/simple;
	bh=sSqjP4cvcawLrblfY9/wyy/hyoTTAKgpnyDa32+hyZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXBawjXLXfDNltDlgRiN7XPe4kU2Mtpi8DViNkEwGVOfUVZXNCTD79RJ6cgr6wYx0FM33F+/ElIaQzKhowDpHOI/mwiqjkbx5IPFn3+G/WJ/BUnypKYIkx/XeM9mfPXYdUykusVWPW+O0VfqPqXSKmaWw76b33g0XAbGSf7WnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pNVcdayR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNVcdayR"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-41174604d88so317622f8f.2
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758807393; x=1759412193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fx9sm2SG/XPK/zOHzWrJwHUPoT7scPpd+/H8+WI3Eu8=;
        b=pNVcdayR5oUrFeRDU0/+k/DMuwh1UJUitwxQmMWFRwZSDNsnTaJWymZtfYVKQrhkV6
         k9Dg9MQEKbDh9b69Mlxj+SgMSXAjFTzeNMiQtEjqTgiqyZFK1CIeKwi391y48eqAd1XX
         KBKW6cR4sRt2YNDrIAcyzvkWcUDp6Q5uJE5ZR9vxwgXFv9V5wLLWk04QRM3keo5OR+ZA
         AcBgkYL1uibz5EYT64nX75ZTqDx5zc9Rlqceuy6d8frJ9z4imWLf7KInh1uJ3KMaO1Ic
         L3yZMX9fPeTt9+L4aKZi1fse6voYFd6ApMJFlwX0JHdS0yTCstIQfLepl3qoTZct4rgc
         bzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807393; x=1759412193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fx9sm2SG/XPK/zOHzWrJwHUPoT7scPpd+/H8+WI3Eu8=;
        b=u/S64ynmC/JIcjntCFUPQS/Ll9pRloCEyvElleI+7tJKZS18+IYsmsLDgIDaAtWLa/
         N8q2NW1dgRho3y7s1CzsS5hI8w2Q423iCqr7Bkr0COeC//mH/t7KGcLWevV2R69Xg9qt
         IVCMJBqIQWMD2xY6it91UO5eRuBpUJQtdYQHom3EJy5Lkx1j8G3yhMvYBGgXahdQsdp2
         nn+zAgfTAPdRdG0WcpP2dK6S6kDkt17iDTwGebvBV9yrTkzWdYu7jbf2soSk8njS1Ba3
         sFbIefJaGYQnGYldUhsjhpSmmkuVRzBk8uBmyU8bUB4nv2qZznNt/ij0CaB5HxHJje3e
         g8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD7trOawOdeeQI7Kx22ev9qY0un5HGPFlxnlCpeAu8Nshm7MGwpBxIsS4astQu7xHuDOTAHdxj8KCzbFRA8GoS@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBlwI7kZ0h4MnZg9h07X/vJGE2+F8nBs4qTVyucsH5rIkGsm2
	1XIMQWxHCgWz5hs7s3qtJzqQqbqtZTFRfmxGC4pZ94IH5fjpzFnmLuycaPQ/ETbG7PI=
X-Gm-Gg: ASbGncvvbfG9z6j1sq3OXiLCtkSlU3OglwP+L7lhYRgzVse084GGENJ663GlKzdLeiX
	V008iHAKJDULdH24dfZs/LtIivkOS/6vvwFk579gzMW/APm/6ZhV72yf6/Ag02CvgxHNF6O57hn
	zVa25GnX8asAoDVx5FTpJe2Aw4MEqGQERvhRr5B+e947ygtblZLWyu3uhpbPl+caZAsKCYyymSz
	RQTRwHwgmBk2Ds6GxJJQzMWVQfL6Ziebmq6s4ipxxH6aDC3D4vc0kcMmPHbftSkSuXw13xJFbxI
	59TGODJ1ArEo7MuB7wmxqVIgNY9Q5sJA5JDx7dTsdgpNPCf8vK0wl8TWfl9sGo4bBoKfEFOHEp6
	lbxIdZfFEcNqsIlbRQg3c3Y3fxswi
X-Google-Smtp-Source: AGHT+IHR1VtsrqYdEOR5yfalGbybkOIcDKOqLqd1M8rHZFAAkkevuzTqFI72lGmxMsSzzCv1aIizeQ==
X-Received: by 2002:a05:6000:290b:b0:3ee:154e:4f9 with SMTP id ffacd0b85a97d-40e45a92e7emr3845371f8f.20.1758807392860;
        Thu, 25 Sep 2025 06:36:32 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb2eesm3203962f8f.12.2025.09.25.06.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 06:36:32 -0700 (PDT)
Message-ID: <4d5bf14a-0465-47b2-88c3-1bf85b008707@linaro.org>
Date: Thu, 25 Sep 2025 14:36:30 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/12] perf: Add perf_event_attr::config4
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>
References: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
 <20250901-james-perf-feat_spe_eft-v8-8-2e2738f24559@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250901-james-perf-feat_spe_eft-v8-8-2e2738f24559@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/09/2025 1:40 pm, James Clark wrote:
> Arm FEAT_SPE_FDS adds the ability to filter on the data source of a
> packet using another 64-bits of event filtering control. As the existing
> perf_event_attr::configN fields are all used up for SPE PMU, an
> additional field is needed. Add a new 'config4' field.
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   include/uapi/linux/perf_event.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 78a362b80027..0d0ed85ad8cb 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -382,6 +382,7 @@ enum perf_event_read_format {
>   #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
>   #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
>   #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
> +#define PERF_ATTR_SIZE_VER9			144	/* add: config4 */
>   
>   /*
>    * 'struct perf_event_attr' contains various attributes that define
> @@ -543,6 +544,7 @@ struct perf_event_attr {
>   	__u64	sig_data;
>   
>   	__u64	config3; /* extension of config2 */
> +	__u64	config4; /* extension of config3 */
>   };
>   
>   /*
> 


Hi Peter,

Did you get a chance to look at this? Patches 1-7 have been taken, just 
waiting on an ack to take this config4 change before taking the 
remaining ones.

Thanks
James

