Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100214B086
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895340; cv=none; b=cCR+gxBYNTDtJTGKtWh42Dx1dAJdoF3qCIRhOYLci1DE6Cadgn+IitG7mpBQoUq2tWtDUTwleO2P/feBAwRk6oTewAwvDSbVJfkluG3w402TMwfJgg2wjPsHlcQv0aoaYAvAwkptD0Xn1I2mdiEUFJOxthAUb4VZ2Cr12n9qmqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895340; c=relaxed/simple;
	bh=pVNVqOflLAb4pwR+4Zax7LKAmGo6qLEEWAyT6kznvU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6ivS5XFlZ0X00SVH1fXm/SRoo6di2BbdF8hgypu1UDxrc2g1x3Ql6wG3nctNagPNlV6EAQITtGMv28qRfLfODzpjuPmGGFWmo9gda/bTkNq+Vkh88dB3xj8ihPCtPFhuUeSsuzgFG4LByO9eajt5af0uMX9Vck0mbzbgFMpmNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BwRhPvrf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwRhPvrf"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so2501911f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728895337; x=1729500137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5QCLd+bM7rU2Jtjbpmv+0KusX3a8Gfz+6gEAH9B8n6A=;
        b=BwRhPvrfgy5Wf0pWwU4G+lGeKQsBYTaPacoSduBe2CZajXxVaqRcSL5EC6qIm2lbeP
         bW4E6F2Zaz2sCUWDwhwCXZTwyg+2DQZLtklJ95fVtgYJ7yNtkaycxdu1MpijBtfO5Z5i
         s0f0+QTpXKeC+xC+cWhfSr1jqwJAHBpMFYtQTYJIaTK6iDTvHRPtHBl8pEUuR8AvuEYQ
         Iv8JjYOxqys9Cu9jnmsImcgOZPbKp9/3dGHaSAn1lceiUEHGHgA1/jed0fIk2vDDiUQU
         c2j+4y6JW00YMjIAV9BVG2qmkUyOaZws73UmAZWHhO1OHOAS9PSgiZxMGblPgVzJpMzb
         /BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895337; x=1729500137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QCLd+bM7rU2Jtjbpmv+0KusX3a8Gfz+6gEAH9B8n6A=;
        b=k2iCoy/rldXpz7YtDVsCHHdywmy9zIKM2j1BjiSKW5JipjCCHKFnWZzixji7qjShwR
         wcHFB0j7aSSSGRH8UWvQ8IG5d5W064kcWfTbLpb52if2YX5QHDBWcsJic6M6gYzTXboa
         rWZIxkX0ep+f2ZDKk5pBUHJC7R6JH3zoUd33w2aX7HdblN68c9SCnzl4mqEAd/EK3CP3
         xnM2lFc6++0O9LcY9B59m8W3vTUZdxgBsuCdb7TfIFHCzio77KLI9Tof6wSF4E8Oqg3A
         daJHes66j2IYlh9xTKn7zMIGTIPDgJgk8S0+N2HbVpyWneARkI3CV+yWB1Nq1cIEM1+b
         L8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyei3ylZxnvfXuyEn4B1oamWCYm9EmxAVT6ykH/bjx4gmjF+7J14h2GMqmJBcw2vp7JJrP4ug14A9IT7Otsep+@vger.kernel.org
X-Gm-Message-State: AOJu0YyjtxZEeERiBvRVkQDpmYsQYM+dYAU/QKJJUTXm9DD9EoyRCF/V
	OOKb6MYEDXs6tbhAv+QUFTSYBw7Ww30LhyplCBSP6ps8eS5mLdFNctx6Q08tp+ReoV1MmMMLFrB
	HZgE=
X-Google-Smtp-Source: AGHT+IGOuUg1J6dHW8l3Gs80tJozrKGUmiq++4D3EjN95hL8PqbfNmH3UyP0hJyAinA1FIatqAVsyA==
X-Received: by 2002:adf:f98a:0:b0:37d:39aa:b9f4 with SMTP id ffacd0b85a97d-37d551d416emr7300405f8f.26.1728895337023;
        Mon, 14 Oct 2024 01:42:17 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6ebe2csm10757089f8f.65.2024.10.14.01.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 01:42:16 -0700 (PDT)
Message-ID: <ca386344-cd1e-4667-b21e-318680f6cff3@linaro.org>
Date: Mon, 14 Oct 2024 09:42:15 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Document the 'perf test -w' workloads
 functionality
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20241011171449.1362979-1-acme@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241011171449.1362979-1-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2024 6:14 pm, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi,
> 
>          I noticed that the 'perf test -w' code wasn't well exposed, so
> add a '-w --list' option to list the existing workloads and document it
> in the 'perf test' man page.
> 
> - Arnaldo
> 
> v2:
> 
> - Use --list-workloads, as suggesed by James Clark.
> 
> - Add info in the man page about the parameters the built-in workloads
>    accept.
> 
> Arnaldo Carvalho de Melo (3):
>    perf test: Introduce workloads__for_each()
>    perf test: Introduce '-w --list' to list the available workloads
>    perf test: Document the -w/--workload option
> 
>   tools/perf/Documentation/perf-test.txt | 14 +++++++++++++
>   tools/perf/tests/builtin-test.c        | 27 ++++++++++++++++++++++----
>   2 files changed, 37 insertions(+), 4 deletions(-)
> 

With the fix for the comment on patch 3:

Reviewed-by: James Clark <james.clark@linaro.org>

