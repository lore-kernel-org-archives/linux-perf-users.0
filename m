Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DD515B548
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577525; cv=none; b=WBy6NBF4WR3hKgep3sEP2Ggglp676nYLFUSUV1EEMo1yn12GzVsA9vUjW3l8SUfk+2CuKRhRX0M7dlfc0M833XzfEKOLtApgjIjszFIjGSIP+1msTKkdqbNWhPqzJS8A5Bx0qInMM6aQv1L80VSRohRlRS4BXag/SwW197BgAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577525; c=relaxed/simple;
	bh=nJllQ4tX0SOCR56ivDN3K2KFwOTmC1QN33BauiuW7fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzoHjgyUm6ZwwpAm4Qgy4M1LfkFI6O8VkhD3eWpAULiPpFbh3WO3YqZ18MYEa+uRsX/Eq9l1R5M2TPeyw/ttTMbH+NPpe8Ga8AKreops8jksCELUHb2uHVQ0LY/F1jF9kownTucHDrqi4qe9mg0pYvsd66vB9ndhwR/Opqwp3oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NVXF++nz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVXF++nz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so36067315e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 05:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726577522; x=1727182322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/DZmH3IPBvAUKzxMH+BXXhEULk3ZVQ5NNcmdHz+ZOE=;
        b=NVXF++nzlfFEQmSjfua14yhd5YPu+9Po+Tiv9sm4wok+YlDrHLarIKmNP2pA24zA2p
         j5XMhl+rWTw8diA2smXSZSPhANwNUUqDLE5Xq+9oiUfwUWtOukgEa+RjAjj48cSokak6
         RV8Vmncoh42v2cdKpZIJGSq/lf04VsiCmH2xyoh4EHDPRwz1J4uFsw/nAjLRoUtSTtQa
         N6xiCChyQb6PVmO0BvRDEKg+i/LGXDsinwq1mGuC+nj6cwFdoZWz/GpeYUJ2tFNfPh6u
         M8CqsDxgGY94K9n75SBotRyrQtFBisgtfmCU0Qev7f9N6J1LMdhumhOU4BKxKAQJH0Rx
         5ouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726577522; x=1727182322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/DZmH3IPBvAUKzxMH+BXXhEULk3ZVQ5NNcmdHz+ZOE=;
        b=UL2DzbGUTCX0YjYpdABwrpnDdhKGArica3B9QaAu9KEddBizYC/hIfJJ2fgGB+T9Fr
         mo1+rK1cuZeU0uSP/ixGiD1OWrFRtr6pE3tIbXoMdzL6zBv83oZwjyFth/fdr9JXoHxG
         97KFA8c/vlft/jRPcmLzQaUNfFObWNSpzN0v4WBdSR+vQYgUBb/fPav33U54QdToX+pv
         qvpqcVhZuQC/hxlfSWkJiInYzQjyKclrFRbYrtLz4AS2XVkgHAZTBL9osQatubtm/O21
         I88PPEGCSpp3mJ18b3vodEx0w6wNG+5SH4FDa8FiQCwoYC5hBGRlMK9ehVZNXK++Hk+G
         2A8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgbT78s+yfIpLmcyj7eM7PamRuefsdmYFw8daVZ8AOKtgA/f6khvAfNNuNcHY6UGyH5fVZZJKObbGsOaf3xeRT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QJHP7l+Sx+NodeT2BPJy3k8MRp7aSA60AYkyChSonbHJ9FFJ
	SrjXGZM4LSlYHihDZDLi5i82xx+ZXaMebv/Mwrg7FUYwf08QmytNZKFzNwmDp9g=
X-Google-Smtp-Source: AGHT+IHWVSho5aDiuekmvAxEtTVVK/xmx+SkdvXja8ZathtyF183fmohBM4nKX1aBpODkab86s5vkA==
X-Received: by 2002:a05:600c:1988:b0:428:10ec:e5ca with SMTP id 5b1f17b1804b1-42d9081bb2emr101759715e9.14.1726577521584;
        Tue, 17 Sep 2024 05:52:01 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e6c71c72fsm9586375e9.1.2024.09.17.05.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 05:52:00 -0700 (PDT)
Message-ID: <59c2cbb8-b24d-429f-b4fc-6a2560ce4e09@linaro.org>
Date: Tue, 17 Sep 2024 13:52:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/test: Speed up test case perf annotate basic tests
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com
References: <20240917085706.249691-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240917085706.249691-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/09/2024 09:57, Thomas Richter wrote:
> perf test 70 takes a long time. One culprit is the output of command
> perf annotate. Per default enabled are
>   - demangle symbol names
>   - interleave source code with assembly code.
> Disable demangle of symbols and abort the annotation
> after the first 250 lines.
> 
> This speeds up the test case considerable, for example
> on s390:
> 
> Output before:
>   # time  perf test 70
>   70: perf annotate basic tests             : Ok
>   .....
>   real   2m7.467s
>   user   1m26.869s
>   sys    0m34.086s
>   #
> 
>   Output after:
>   # time perf test 70
>   70: perf annotate basic tests             : Ok
> 
>   real   0m3.341s
>   user   0m1.606s
>   sys    0m0.362s
>   #
> 

Interesting that there is such a big difference, I only measured 4s vs 
14s without the patch.

Either way it's slightly faster now:

Reviewed-by: James Clark <james.clark@linaro.org>

