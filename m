Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECCE1E0E11
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Oct 2024 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498285; cv=none; b=tyZ+PsAA0W7SLTmtcrRgSwXnaInr2xAmxb7SriiReXCYtN7WueTEOS5M5dU1UCxaourgNDFUDnt1bbTeuVEesIsI7jxUpL6lSLdf+TxXTt4O2O8EdvDXx1RIDWBhLeRckl2hErp4OeALtyiPqJDoouinUiBkDEy9o7f4OBmlBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498285; c=relaxed/simple;
	bh=Ou2p3DdsJDTxeC21wWk0uoZwVL2HA6zxt1bnh4k8tHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvfOiM6l33XW+fqGFMkXfpVHAFxbWowNVoKJ4mlI/YLDUqb3yvwi5SMsBEz3bqnJr5m53uDn/qL43ZFZ+HIk5pHeAGujd0jdup5ZMgvY3xl77hgg/O0JgliQ5XTzBWXQZJIquAMoJDQH+k7uoatc8Xg3Pp2nSOdD84BhVPlsl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSwBVUVx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSwBVUVx"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so4610978a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Oct 2024 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729498281; x=1730103081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCypqz++1+bKOXfbjNAZskehde2MtPKa6tzi3WQaYiI=;
        b=WSwBVUVx8q6Zinqq8/5oe4Gbla9RUyXow4wHqw0KL70QFmdT0+5oj/E4i1nbA9FUBO
         s7nGvBMYHubwf2FP7+XRE54/3V1iH8DCjR65KPqQqAFrqI41n2RHkwlIOWAZx5gHxsla
         iyTzu9riXQyYZfzDQKNZS6/LV1EV+jCEktnp10/oaZcAjpleF4sJ3N6LNtLFz9PIc/8t
         A1E9iw5ohTm8E91iu4/9mUG6zJ7cuLzM6aLQCxeBlZsaFxkiC5aD4v0gbRXXRxsiJaWx
         kNp2lDsSMZFfDNPDXIzCkk5BgOUQlq9huyLLkg5p8jlBm5l2px9OP2hdPfZ25tpABrex
         zLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498281; x=1730103081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCypqz++1+bKOXfbjNAZskehde2MtPKa6tzi3WQaYiI=;
        b=T4Iu13XoLXEYe28SIUlBdfsGYj1F6fSfwHB7VJ3yZnv83aM9VpD5LehQkR4QYuff+h
         qYdRkD6jiYnklfden83uGXwvvWvAItBNkBSV3XJImFOV71S/hXVZW3bXJ42ejAelsMSz
         A5mKm/+XuhmBosdhykQ5pq0wbSNAW+XY18yr1oVeMoihI2c7dVwQK56L75QPgqyhbdVT
         kxwu1Q0XAebwrNKLVziHx60/9puv3iPfIL3qQ/T6hfkhARrtFxAzUCzO5UsjpHp8KzR4
         +n7vxcWsJDW+WXS81hznJm91ldRQkbmi6+a44XlbcivPvCgvub389f7ZAUc+xyetB4lI
         6anw==
X-Forwarded-Encrypted: i=1; AJvYcCXM9EWvqUv3SN4cPXpwqLF/dH1sr+TK9Q08C2svHrTZm+Bd2xfFJV+jM//YSFDQrSs0EFMJgVk7ZLL3yMJODNsi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7IaLqYri1IYAR/+JHlEM1bkh/GTPn3XQJfQSUIle0rLBT0Ezq
	hgcE/xz7kJdGV+wFBYixof+1xJ4T2b9UGYMPgDTFwDtdBVLs8y+FuVLpSVOYH5k=
X-Google-Smtp-Source: AGHT+IH3Kset7YK4tOEJjljVdnmxSfw7aCq/ZTMRUTaAXcJ8Q/fYGB3ILhxg/5A2uLZZWvdaBo+ygw==
X-Received: by 2002:a17:907:2cc6:b0:a9a:1565:1051 with SMTP id a640c23a62f3a-a9a69969fbfmr1126644466b.10.1729498281298;
        Mon, 21 Oct 2024 01:11:21 -0700 (PDT)
Received: from [192.168.68.136] ([209.198.129.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6255sm175790566b.19.2024.10.21.01.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 01:11:20 -0700 (PDT)
Message-ID: <c6691700-4aa2-4d10-97df-2dacb6bf7fc0@linaro.org>
Date: Mon, 21 Oct 2024 09:11:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3 v3] Expose the 'perf test -w' workloads functionality
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20241020021842.1752770-1-acme@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241020021842.1752770-1-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/10/2024 3:18 am, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi,
> 
>          I noticed that the 'perf test -w' code wasn't well exposed, so
> add a '--list-workloads' option to list the existing workloads and document it
> in the 'perf test' man page.
> 
> - Arnaldo
> 
> v3:
> 
> - Fixup references to --list-workloads in a patch subject (Namhyumg)
> 
> - Fixup references to --list-workloads in the 'perf test' man page (James)
> 
> - Add an entry for --list-workloads in the 'perf test' man page.
> 
> v2:
> 
> - Use --list-workloads, as suggested by James Clark.
> 
> - Add info in the man page about the parameters the built-in workloads
>    accept.
> 
> Arnaldo Carvalho de Melo (3):
>    perf test: Introduce workloads__for_each()
>    perf test: Introduce --list-workloads to list the available workloads
>    perf test: Document the -w/--workload option
> 
>   tools/perf/Documentation/perf-test.txt | 17 ++++++++++++++++
>   tools/perf/tests/builtin-test.c        | 27 ++++++++++++++++++++++----
>   2 files changed, 40 insertions(+), 4 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

