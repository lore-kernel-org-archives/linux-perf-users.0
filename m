Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE921B19F
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714986; cv=none; b=eencfMVtTEhr8jPGgrOi8FIcD6nbnsrZ44u6bL+fmMHGrne4x9izLb8WQNL5Y+Cj/1k2/67AnH9M5qev24cIAQo8A7tgFDDXCDclBj71aIA9WW4GGdXp+bREoTfkH/vbJIrle2TeklfJXXye5ZbnTrM6ez/ZAPKb6KSoHssSe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714986; c=relaxed/simple;
	bh=n8b41AHa3RgNdF/44j6nDwaehIKPuCDpJKbuVqrYhMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2NUP+kmp2R4FL+eVEd3i661hMuTwgUxUSUJR/fWEgiTjRugfH0MwCOMnKlRe144Tzn1x/u6F1n2Bbp0dNfC5sbZWLsMNYAn99UzJOxivm1Hk/oqpLcuKFPialxVqUuu7pEzfnPDQ72wTp6PxOnfu38GL+qtzZ6MxWMoq4PvOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SWNDpO6k; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SWNDpO6k"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43635796b48so14051985e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 09:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734714983; x=1735319783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWkEtC1JATIn6qXREPnlwjqS9TBnknDlIdxobBNl7k8=;
        b=SWNDpO6kjfc13QEy+DaVPFtG+/svjShiF8OBVB2GZ9+9J0wyz5/qtc/4NCukD5rPHp
         Ajskx6/S5egx+vtacpmYtBmYuLdfdP0DaapNpL098850cY+wNTuL+mcjE+vHsQZmbN4V
         2UF6MGwuoT3mE2vPQC4guK8iEd3xfVNePh5FkAbPt2ARzHFWcVZCVBcQOWYyMkEwqPLE
         CuigiHBIKPxgBWD9+M6T07GL+gET+ZW0OiyOaZ8zzftMHVc6eH/8Mr6DQHoVnZquErEM
         2yjdUjd9Td7gO6K4GBn3XUWbgLR5RTL2uyAnPKANjL/YLJlqL5UHd7rK+4Q3YlgIkUDO
         VIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734714983; x=1735319783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWkEtC1JATIn6qXREPnlwjqS9TBnknDlIdxobBNl7k8=;
        b=XGakIuEhhN7I4vD+t3DxsEup6/vM/Lbb4d3A0CjUmzmpLX8fvgKZfQ2GapLyD1p7BO
         drN8Le6hC/1CJR1sk5o+35GdzgYHuFx9zzzDy6EK/axW89Vq2sOZlO8Dtn7hpuJCjUHH
         vwxwY613A1CHHAsXLWldnQBYvKak/zTbCc7lwJ061wr0/ID007w3BcVjKfk0wndAJZ9m
         PSyF2CIloGFjcHer5ck1ixLVGyrQWwK5x41kg+MnAGvyJoUrDbMc2SzHb199MjeunXDt
         GX8sGRPVydSxPXD3BuxjRqfQ8cf/edNz32cpfAZ0pnHUefY2tPFjX2lDcULGafv4+SKp
         iL7g==
X-Forwarded-Encrypted: i=1; AJvYcCWJZNtZ0pcSAOdlvVDEuRrY1X1eu5f1S8poJffc62AMlB/YThJvf9iXQDrImNWhU+fgNflFMujF+DFRjkPuarJk@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkpjG8cRj6NgLyhQ6/DdInlh81tQqXGRMWVp79Dk01gCYU0z1
	Zhdy52EojpWoyOG8jP2C75NPP8J8x+nEXtwjLeVoGrLPGRMyzlJMYgvvuUaPlhg=
X-Gm-Gg: ASbGncvOsDAl8ownm4V7qPk+T0ZGyxVA4Lu2oezYzD4rrGr/9HGaqA+rUOtvf2eyZnM
	ID+re+dcP8qhMY+2CY9OYHVshMPdse88OJanoku3cxqFmV0PMdh9qW6JVtyoZLANscSP88XhbW0
	wyu1eqgWQTy3JL9zDvgJCKJa+WPy5tYY9/HBsYRrm53Sy85lBKYoa2yiTchYkfZTG/VqSOIjGgy
	dib8IOri3RqPAPtCAET4flJs2livWiv5VFsRYsQPU0rGEGmcOpdFNo7I/HT2mnBSBA=
X-Google-Smtp-Source: AGHT+IGn2bSuOD+eQ1Kw77ReARBTW+Z43faAGpGgYHNzLywWOzDLSMMRJx0svPo2NgeJxp9j9ds7vQ==
X-Received: by 2002:a05:600c:746:b0:436:185f:dfae with SMTP id 5b1f17b1804b1-4365c770940mr76361555e9.6.1734714983179;
        Fri, 20 Dec 2024 09:16:23 -0800 (PST)
Received: from [192.168.68.163] ([145.224.65.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c4bbsm50677985e9.32.2024.12.20.09.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 09:16:22 -0800 (PST)
Message-ID: <c98e8399-1471-4d38-b314-4fbcb8dcb27d@linaro.org>
Date: Fri, 20 Dec 2024 17:16:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm-spe: Fix null-ptr-deref in
 arm_spe__alloc_metadata()
To: Nihar Chaithanya <niharchaithanya@gmail.com>, Leo Yan <leo.yan@arm.com>
Cc: skhan@linuxfoundation.org, john.g.garry@oracle.com, will@kernel.org,
 mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 graham.woodward@arm.com, bwicaksono@nvidia.com,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241220145659.66066-1-niharchaithanya@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241220145659.66066-1-niharchaithanya@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/12/2024 2:57 pm, Nihar Chaithanya wrote:
> When metadata is allocated using arm_spe__alloc_metadata(), if the
> metadata version is 1, metadata is returned as NULL. This value
> is dereferenced later in arm_spe__free_metadata() and it can cause
> null-ptr-deref.
> 
> Modify the NULL check for metadata to return -EINVAL even when
> metadata_ver == 1.
> 

Hi Nihar,

I don't think this is the right fix. Doesn't that mean we can't open 
files with V1 anymore? Did you test opening an old SPE file on a new 
version of Perf? I actually thought I tested this before but maybe not 
if there's a NULL deref.

Seems like the correct fix is to not dereference anything if metadata is 
NULL, or make a fake placeholder one.


> This issue was reported by Coverity scan [1].
> [1] https://scan5.scan.coverity.com/#/project-view/63616/10063?selectedIssue=1636359
> 

Is this supposed to be publicly accessible? It goes to a login page for me.

> Closes: https://scan5.scan.coverity.com/#/project-view/63616/10063?selectedIssue=1636359
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>

Probably needs a fixes: tag too for the commit that introduced the issue.

Thanks
James

> ---
>   tools/perf/util/arm-spe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index dbf13f47879c..55827d8ce133 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -1497,7 +1497,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>   
>   	metadata = arm_spe__alloc_metadata(auxtrace_info, &metadata_ver,
>   					   &nr_cpu);
> -	if (!metadata && metadata_ver != 1) {
> +	if (!metadata) {
>   		pr_err("Failed to parse Arm SPE metadata.\n");
>   		return -EINVAL;
>   	}

