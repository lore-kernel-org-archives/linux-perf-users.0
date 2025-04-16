Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928621A0BDB
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Apr 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809503; cv=none; b=ialiviUDgYOJ+V0bih3qez8rRJYdXJfivwrM4Hzrhc8yBnHYR53x7mWOdA8oignDAQMhCFyvoGUewXZX3069vDch1n1WYPUik9WigbkLRh2YcuQiksiAMKMNYy0mvyfhBIAjY/SOgLaQe8mH0izaV9CKwea8jyo9zhSEFRsPIxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809503; c=relaxed/simple;
	bh=VnOmVdIWCnCv1Y47g0GAzATjL0V491d4IQ1Ral1ChpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JykSqiAzB/xzT9+xQrj7uxz7RLpdwfknCiI1sbhgoWmkmmuBsqBzZ5xindkgKURtBNEAE6RRJQuOCwLGFPRKYTEuR5i/MF26IPZ/1GqDtd2tueDvshTQ9oBdExlCR+9x1c1RPzD7gTByzfBa9kl8CIPlps3hM/Xv39fHtzQ1VV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xdNK2VZv; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdNK2VZv"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c0dfba946so4985348f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Apr 2025 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744809500; x=1745414300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWn9+73LuPrJPzYBaqm6TVjkazCmRiGrWcuRy0+t00U=;
        b=xdNK2VZvl3KqlaYtkWYpKiFVksp9nEGPH96j6foLgONiImtq8/bKBrjRVAKbArNncV
         kxwKnW1d3IC7rxKu9OgJ/N2ZW6+MPl5DWU4NccQWCO6UId0bY/YBAVk4Aqhy52srdwkO
         8eEliu/9TgQrmVtP0i2wamSCmCkoM7wAohZD0bB1Bu9atIvQ8d4MXxKHe/f7DNUMKtLz
         RA8Mxgd2Ba/PqEkBMUjyW74YPQDU3L3fxZo2f/MI0YqaAXbar2e+cXLO0JLfxXTE+ARl
         CERMQ/u0Rau20UdklgGYFGq8MrA3zM4SGOAkRDZtfx5BXgz4JH7Gx3Ro6Tqo+DDHSauI
         xidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744809500; x=1745414300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWn9+73LuPrJPzYBaqm6TVjkazCmRiGrWcuRy0+t00U=;
        b=TNYfyfwoCD00TrUaGMKBiXi+tm7pQccT1NEYj1HWae3yBM77JvnKj4WzB31tMVDAJt
         PDuvOf/6BgrJY7mfPszs3i2O/HTwib8OrqESAABRMCH/vvi5HtVM9Q+M7l8OXD01bnMC
         7KgF1FPPqbv0CEQc3/cAL7Ar4lEYp76OR3G7xSoQFxQ7GnBX/jYiS0ZT0HJPhaCk4dVf
         GJhojJJPQmHz7FMQY2WbScnq/z3aMNWj0C9WKvsOHadf5p2LNbFykL6PnXLYB95m+hd9
         rchiwAbXtpXjNj5b2BzVOpo1ngBBXWHWQsvEJFXwzyox7QEWzmnaE031kqA7ce1G4pqv
         qaSg==
X-Forwarded-Encrypted: i=1; AJvYcCWYlZepyub7cEk5ND3TcgneMhqiNihjpNQGeXUP3443GoqOksaIhitPfp/cgdtj92uCYzWIdzsunpf45hJlfDtz@vger.kernel.org
X-Gm-Message-State: AOJu0YzldShO8F8c62FNWh5PQA3jhj8ATLWWjz9sEMAhE9MvEOxn+xGW
	DTlbhLd9G3OzveAjPsNRrFQtncvi85DNqnOKLugdBdoKzn3jMQ/iIpE0+6flMYg=
X-Gm-Gg: ASbGncvw+J+TEnODpn+3tXsYzsEZDf7STIdtzRj5e4B8sZ4uEDeDnlYtWVqkqu8h1sw
	T9HXhALQzyUjJkbT7JL3sqYE9j5FpMdSjMd4adhNUmUBuHstihSLM6YRvyskARIdNZL7LtOZV+m
	Qr9LVncexUmKFR6tQDpEYeery5BYfVslLZzp8sJtTKa69LjJQU/h/vM5YBlDapUOM8w2A5BwHev
	jw1zsz0cTzGGlm+Wbd1P1kGnkRse02t84xNZ4qWmW8JLcxsKbJCrM2Mz643OX6kR8RVTm6ToBf9
	btmz58ZRJLcYs3KMAPKUvYKWrGlQjpQ53DmwsmOO8v8RukbM+2PMRA==
X-Google-Smtp-Source: AGHT+IFPmeeCHDegVrMeD81/94FGQ0WEJLqoFfiQo0Bs7FAdB3e7HEdNT5bOUrtUpFhR2QE18/iDAw==
X-Received: by 2002:a5d:5f82:0:b0:391:31f2:b998 with SMTP id ffacd0b85a97d-39ee5b12f0dmr1905115f8f.6.1744809499611;
        Wed, 16 Apr 2025 06:18:19 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae964025sm16881088f8f.6.2025.04.16.06.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 06:18:19 -0700 (PDT)
Message-ID: <e1b05184-91b1-43e6-80c3-b7a84b9d4d92@linaro.org>
Date: Wed, 16 Apr 2025 14:18:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: Add hisilicon pmu json events under its
 entry
To: Junhao He <hejunhao3@huawei.com>
Cc: linuxarm@huawei.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 leo.yan@arm.com, john.g.garry@oracle.com, will@kernel.org,
 mike.leach@linaro.org, yangyicong@hisilicon.com, jonathan.cameron@huawei.com
References: <20250416020216.3377959-1-hejunhao3@huawei.com>
 <20250416020216.3377959-3-hejunhao3@huawei.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250416020216.3377959-3-hejunhao3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/04/2025 3:02 am, Junhao He wrote:
> The all hisilicon pmu json events were missing to be listed there.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00ff21b955bc..bf9588a94919 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10474,6 +10474,7 @@ W:	http://www.hisilicon.com
>   F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
>   F:	Documentation/admin-guide/perf/hisi-pmu.rst
>   F:	drivers/perf/hisilicon
> +F:	tools/perf/pmu-events/arch/arm64/hisilicon/
>   
>   HISILICON PTT DRIVER
>   M:	Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: James Clark <james.clark@linaro.org>

