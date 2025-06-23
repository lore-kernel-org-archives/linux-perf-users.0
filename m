Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85B14A0B7
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688742; cv=none; b=ZiGU6rK5sKnLVTvpQ4RqCx/iWpPWjsjfvqsM1rzxWUElHm+h0JyheyYQ3uZd6wCEle3+RDYM9lfGT46B04gb54fPn9X8IBtOnePkFdg0dEr693xwaKtJKSJJRyKiW0mwoy7rbtTSOmqWCu16vfdHEe+MthsuR+GLG79twDLDAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688742; c=relaxed/simple;
	bh=ZOylaSExX6bxI6/3mkgSRwIpzn42/3g3PVYobaI80Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrcASeQZn06s1MDO+2xWPBVsd2PGNcxzN1+YmNL9WKUnU88mrXlhuswfP4AMg9A70sybmSKO4YUMVVEcmBnz3phnpuGKv2sLvgJ1aDhOA+U8GH3NsJoKAB/q8vdx1SEGkfQc7ayHBJ46+F4T2adD1T2kQwBEoTNXN2tYNdUS9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tm/rghvJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tm/rghvJ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453643020bdso25679815e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750688738; x=1751293538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFaRN824DNzc5ho5YXjMqXfkcXGJEHp+nqEbSX571J4=;
        b=Tm/rghvJhA7E44gTSw2hCN0hw1B2dtAtMwHLfGHQli7t6W62v+2VVT4fziBUAlZMZA
         8NnVmMW50gBIWqWdi6h27SOhAdIOm1ayPfFJPlmz1z6YGjPwJB/hfnLoaVz74nVjPzpu
         OUB7p7FEe4fEoHVs6ChqoyQaMBnV9aPZMQpYhVs0L3z+gnnaTol09jibR3bQcsR3hNwY
         SSrDVgqlocmie2gsWS8g7SDgER0Xw8UCHq/Yfvbi7zl58poe6+LK/pmwT23GuPVIGiA/
         hql+RtY6QkheT3zkqw9f0J0Hs1h/azPU3WgOp04MkT2skAW3OqkwNnq97ZOPcHiXJUqL
         cshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688738; x=1751293538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFaRN824DNzc5ho5YXjMqXfkcXGJEHp+nqEbSX571J4=;
        b=bNH6+LMDKlqv7z0RjJGXmpJq0dkRkrJoOUEqpTeYuVPWH7SRAt7oUoXpMP7q5WnilZ
         zANKWJ66T1cP56gM0CKNOgUSaG3Qxga7wiRonqmPgQkBR5q1+jEWcAJpqWdkvHslB+YS
         oEHBobdwvV8ztJqoyzbCcUzzeuSn9GZRipvZry/EGwdSMXp/f/0+5yfyoKqEy6V7Gm2q
         qFMNPXt/yaPkRwQP7jGmCnz0pw5JSaowjnP/B+D+RC6pXUTmPBhGdu6dKjERI554C7jO
         JpBduy7rHlnVe75C1HiWR1DCmHQVLH9EQhzOFV/IOn2dFfh+nHN+iPZp0lvkO7iLmxe5
         cNgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU1IpTRJrMy8uESrUgZiwkhDKyXfRf1jjq+HBPXahnq6dcHByJZy6r4kcr40qsgTkViYbNviv2kvQKlHTgEMN/@vger.kernel.org
X-Gm-Message-State: AOJu0YyD8F6rHGm43CiXSAY9DpI/0/19yu+W2mBGRHHRNOGoKcp8RWSJ
	RfMn9Wm+o6J/SmjoshWjsrqFwfOQaXW/iaruovTNBXNE+jh15f9nG3vaZxGJisMG+ps=
X-Gm-Gg: ASbGnctIw8SjERxHe3/Ft7WuFuk6QMZY7Kv/rj1NooNwJN/F8Mq71zCEkQ8oLUkSW5r
	/PZuAhZbOaz2wzMhns6sE3aT8gbJGKRx88qqKV/SfjxeFhN9XKByiQJpyPEISBVgZ/I03MJFzDy
	WFzBZK1vLuaJIOYVCEVWtHSeV5iRUkaIx1x5y8yOJ+bbLWFu4PCjMUKYdN0zFvNp8dfQivvlpu9
	4dcUBlK3PK5DoFkbD7toadjz/0wCFFo6YUcQHe92Y0U5X3mMACRAEJqPc7wXFjgijPYaWcmHKhF
	f8aS+3mjss9OckHlQwyg92LQDxazry6QekKFF+v66EdkyCJAPlKYu2SGx3U5k19EiKA=
X-Google-Smtp-Source: AGHT+IFbV041MBa6DxqFZHMj/fwt4D0fHbMWQlNqFSp1Iy9GJKZn1sduAOiBG1dNgfsqCVqpZhLAMg==
X-Received: by 2002:a05:600c:4fc5:b0:442:e03b:58a9 with SMTP id 5b1f17b1804b1-453659edd23mr107191965e9.25.1750688738238;
        Mon, 23 Jun 2025 07:25:38 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45372252583sm48026365e9.5.2025.06.23.07.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 07:25:37 -0700 (PDT)
Message-ID: <82dc85fd-127a-463e-b295-509bf35346e0@linaro.org>
Date: Mon, 23 Jun 2025 15:25:36 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf tools build process cleanups and extra hints
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Chun-Tse Shao
 <ctshao@google.com>, Heiko Carstens <hca@linux.ibm.com>,
 Jakub Brnak <jbrnak@redhat.com>, Junhao He <hejunhao3@huawei.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Stephane Eranian
 <eranian@google.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Thomas Falcon <thomas.falcon@intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>
References: <20250620212435.93846-1-acme@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250620212435.93846-1-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/06/2025 10:24 pm, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi,
> 
> 	Some simple cleanups and extra hints for the build process,
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (3):
>    perf build: Suggest java-latest-openjdk-devel instead of old 1.8.0 one
>    perf build: Add the libpfm devel fedora package name to the hint
>    perf build: The bfd features are opt-in, stop testing for them by default
> 
>   tools/build/feature/test-all.c | 19 -------------------
>   tools/perf/Makefile.config     |  9 +++++++--
>   2 files changed, 7 insertions(+), 21 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

