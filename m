Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C15145FF4;
	Mon, 29 Jul 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253990; cv=none; b=gDqukkK5WrCEjrqaRjXC/+y3DLDYUpcCGDrBklwNWudCv1muUEb65a7myDpkz0BGG6OpZuS2QveYkkadU6QWCpqCzBBdmtxIetFtKTtlWPa6I3YLfvsJCtNt7NWJaMwV1iB+Ohziy3otT9O4icT5t4sC2DbOowbZD7WU/s8WMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253990; c=relaxed/simple;
	bh=yrXMNIQDcaCRJBBcw3IGZYmgNI5Eh29OalpaMll8cmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2QiAeGqHdr5C7J15jqDUsVoMq9GOhkMojdHfx7afuKUF+F8FRWbrN2e6UWhK7TWkMmC3HGRzj8XAwqOVUsT6RvITjjyWuiF088B0aOz5/reNXhMXYno0h1wa8duTZlQKtkmOneeXbC7ze8iRGBnvVKoSkNygmyyo7P1360CiHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDUcL0lH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDUcL0lH"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc49c0aaffso17044075ad.3;
        Mon, 29 Jul 2024 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722253988; x=1722858788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=driDabc5YR9O3V8AePLG1eb33BfKH4QbWFbm00Sl1Q4=;
        b=TDUcL0lHrlmGUMb0UnrKpLGBk6GZpcXdwnWS4MQHVSHWIsy4yneY60h7yjKshhUoOF
         DlYBgRc6AvK1fId9mB/0y4vYAVkaVu4CVz6CPL0SKvZS9B6wNJMhH6qppELJ5S2ONxbO
         vWZbxytffbFrDzylgVfRkCIJjeBVtUunePILPL+K37jSuWhN5NkqZpXJLBAX9SEVgQ5m
         85QoD8rbYHBinWKdG/Pti9PaGRfg+tCaUxrPS4+BB8Cg/3RITFSUcKbVCdkX7JWNSYFx
         kbrN7gJ0Q5l7sEkTe9oL5JqSwWCC3rv7rx50fhYNSd8ISXRrh0le+VNIqAuFAv99eYro
         aPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253988; x=1722858788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=driDabc5YR9O3V8AePLG1eb33BfKH4QbWFbm00Sl1Q4=;
        b=BWd3yzp4q5ASG9SrCPQFSrC1wjetQRDHG/eVOSjXrtmOXNOqATiSlaIG55a9b7VBP9
         7tUm83dfjVZ0p6/YUqnTS8p5OT3HCdi/eQbpfN0j+v19V4Area/LujtYZ92zQKgbRsQH
         mbKVpnrChtBfyrFpbeJITr0F9KM+kEPnAaLdjnjH7c6+yhejh67fxc/bNJDxWdodJZ3c
         EJoX1+4cwsGRjxu66hDBBvMYktbOFf/ze6pAI0Rf/P61oOJUzLSX6pxQbOx6Hm1XYt57
         xPCpAeYTisAvkptYYS49n+JlwPOQOlBkI76mo2MarXiuHXrtnLKW3sT499+Cm6y6aiNr
         d56A==
X-Forwarded-Encrypted: i=1; AJvYcCUZhs17WICQdd20+k/N2kvKvtflVUFk0DjxX4kZzinNVb0snexCRT6+o193VYw9OjZCEU1Mke65nmPwDyRV3MXbtFTbHUAipEofVJLYEkYrUA==
X-Gm-Message-State: AOJu0Yx2wUhWOnOk8KH20gPL5KifPb0fyFlChER2TKh6kREyob+ue27A
	B0oM0tpSX40rX5a4eJRvevVhF1Dt8rSN2OV7KDVO77S+Hp4U0Zxf
X-Google-Smtp-Source: AGHT+IE3o0i++UeM/o9Ung1Ma2mnKjUsamfjgsc+YRf/ZunKVwF8Vl+eCWiC8LTXI5COK/UwVsw52g==
X-Received: by 2002:a17:903:1cd:b0:1fb:8a61:12b0 with SMTP id d9443c01a7336-1ff0492dea2mr45113225ad.54.1722253988157;
        Mon, 29 Jul 2024 04:53:08 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fe8af8sm81247875ad.290.2024.07.29.04.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 04:53:07 -0700 (PDT)
Message-ID: <b37610b7-f0a2-4556-bb2c-367440eb9bae@gmail.com>
Date: Mon, 29 Jul 2024 19:53:04 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/28] perf bench: Add epoll parallel epoll_wait benchmark
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
 <20181122033611.15890-20-acme@kernel.org>
Content-Language: en-US
From: Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <20181122033611.15890-20-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi guys,

On 11/22/18 11:36 AM, Arnaldo Carvalho de Melo wrote:
> +	/* default to the number of CPUs and leave one for the writer pthread */
> +	if (!nthreads)
> +		nthreads = cpu->nr - 1;

If there is only one CPU (e.g. a virtualized VM with only one vCPU),
what is the correct test model for epoll_wait benchmark ?

Is the behavior the same as using -t to explicitly specify 1:

	$ perf bench epoll wait -r 30 -t 1

or do we need:

     nthreads = max(perf_cpu_map__nr(cpu) - 1, 1);

?



