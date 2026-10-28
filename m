Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180055;
	b=Kun6WDOe7TYyxXNDBpy2wORKPUbLNMtJZRHvtXO2ivN2jEcr41j+I1bx+OM2h1MSLmD8
	 kIWXOOs7qannSP85JtZyOsXntm/Oi9rGXWWCdCu416hnnIRCfqRfCDgzx4JuvCx4Nqtns
	 G8/NbnClDJGG2DKyKaxQiSNpR5UF/Cl6fznR72cBeGdN3WNl42yLGLWR6BzRzKqeN0iUC
	 5T6B831AETJ/XRzZC0Rbx13Wo327vD2jvRVSaj7NRrqMTKjcVXpnDXyIdll/UN0EtH0Bx
	 tiN0cJTjFwd1j2jPhITRCKtIdzj0BkEhfs7hmGyiIRSAsEPP+K8M2U1WGr5F5E8EDIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wzc/Ffo0vqG/MgUj08JNChf0oI7bYubi6RLcl90iG6M=;
	b=piMiDAC6CgTURmoQmHFiFBqfjg47gKHqUeZ31eZLB06Mv+a/BYFO/hCT25m0aQqIKNaK
	 6FM7YPLeCoKa1jC2kZx4fxCWPZvAJEkswEWSjMi/ryqz0xUeN/FNeGIxikBI5XuRmXm5R
	 ABxD+visge6Gjzh8+74THUwqx/8wVlo6Lg/+e+5sOrdo5GibpndYP/jHeeOJa9jOVGsxX
	 +Z95UyyIfNkoMJmOOMHVyiYNSj5/OAjjlW91rauvfUxhjqrR7+Agrx41AspuevAzvkGTX
	 W+wRtUa5qdE5wanqkzwlcoqhxHpK36ysyifDT/lcYxfhkE7whz8dIxs2BHRVEf+NAKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JFMi6Pew;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C377606A327
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 09:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C377606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JFMi6Pew
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso5262825e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793180053; x=1793784853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzc/Ffo0vqG/MgUj08JNChf0oI7bYubi6RLcl90iG6M=;
        b=JFMi6PewLs4m7EkPiGNa9NFLqMO+qkGvD6PonyxMzEM8Lg/kP2qaoBSSl8VaRNfsjU
         rumokr17dWGBjAiQMZnhSvsl0CRTb+wdatuJfZuvAlzYpu/n4vSgxORHs5LQmvlH1OvD
         wPCcyC4NLLAxLuxmQtrUiq5iwIdzP/5Aq8KCgooZMysQThNYvOw6QSRooFv4pavQhfak
         odYISejloTYjojBSEOoljgcwwpjXc3CxT3iFWHLgB81ynzQjOMvbNbUDuxGugrBbREvj
         UyvWHePdisQ3v4q6baIVqK2Nx4pTJfJp/7BwlUuAIjPM4ksHYEn/NDgZ4WccajACrwZM
         TP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180053; x=1793784853;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzc/Ffo0vqG/MgUj08JNChf0oI7bYubi6RLcl90iG6M=;
        b=UFyBpWbAK0xnpKxa/mIvM2RpRcp/ckSgX1kehMwCnjc6TkDCO6z4AGdXo7P7kkr+aY
         pR27N1ghrlLEu+SqEmk+IFcJOdHb8WKKQ9lKYmins/jj/Hzea1VapjIhZm4XXe/oEOfm
         S8Msuf+fZWCITTYYQwJF8idNZHWfWJiBLPZM4DpRBZm7BRKj5AAj4CvVlorCFMScaD2C
         NIZMe2ei4179G4jslUvOf4Ho+M3qFEiT4AdqEk7WHgEQ+Fi3J8/gc2G4Z2IlDw6BGb1u
         REBrHXj/kQOE0HgmK1NaqIKXDe3BaLs5MGWy9HaGntvlwRjxNaP2dvd9k5dLsjxFTkO9
         6MNg==
X-Forwarded-Encrypted: i=1; AKwUvBzIty4MtzoQE+M5vS23aXO7Aw8paRlR3P3LtG+cRuTygZLY4tW/ARxB5oCbBLrSSFAcqYjkBDdMFJlt1/+YKZFS@vger.kernel.org
X-Gm-Message-State: AFq9FYIOChgHbQOULLh7OtcUqeGtkoG7JgyIWZV9d7NXaMD+lNWT9Xia
	7OxJEz79VGTOBsgDzFS++dJRzTSYZNzGcvnasTsDVlzx/4BGUBghKKbmjzz5mLFIBiM=
X-Gm-Gg: AYBFou2UL8ysJOW4isd5GHjgNqxqF1ptQj3Uqobkg5yyYU+Uwbf68kdjNK8ywF3sstU
	sh0pI/v/WOWabhpvZGdqr48DJHhyfoapzTnSjkktFL20Rj1dmdQBNq07bSmuY4fF5ucL6MUuGYN
	u5eQuYyDHTBraa8aFsexp2CUobY4PJYaTHRyXKO3nFMidQIKFJMa7ERPhy8roZKbAmrbgUNzcrN
	3X9o2CfozsIPpsidjE9QD1UTkN4Qp/zdsQ7DFHlIgMZkx6aGaJTMS7mmOMTb2WmiBTu8S5KlQ9A
	fEn+yWifvmfKj+2GtmnBpt7vB6u8Y0BvA2xvpa0PXVf/gKsIzg8708zh10QxYggQ/d0CRMGg4Uv
	IgJRz+SQ8DLP63EOL9a+tjRmKGr21FoUwtokLPafEaBGhh6PBVUqxapApfEv7i+LU43nTPoyugW
	r3MRpypElzvUx3fo9z+tA6Nub6tTceGL4sdvsnCuMpalgKHcAeHg3H7YoKpsrvh/psVJUyvBYpF
	HU9YL2iDJT/tP9+bWozueXKiUKOfzkCrkKqntfRzRUoSRP7guvPYJIQXAkBKMGqatPieIJIcBMj
	+womWTNv+WMwwhjB3zzFrtCBT2/JJONXiQ==
X-Received: by 2002:a05:600c:198d:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4a9616a2b27mr37340455e9.0.1793180053599;
        Wed, 28 Oct 2026 02:34:13 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97c42b3c1sm34895995e9.6.2026.10.28.02.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 02:34:13 -0700 (PDT)
Message-ID: <51b9f3f6-e053-4d9e-886e-2c8929014a36@linaro.org>
Date: Wed, 28 Oct 2026 09:34:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] perf off-cpu: Use the CPU map index for the
 bpf-output file descriptor
To: Ian Rogers <irogers@google.com>
References: <20261027170415.2815859-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ankur Arora <ankur.a.arora@oracle.com>, Howard Chu <howardchu95@gmail.com>,
 Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261027170415.2815859-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/10/2026 17:04, Ian Rogers wrote:
> When populating the offcpu_output BPF perf event array, the file
> descriptor of the bpf-output event was looked up using the CPU number
> rather than the index within the evsel's CPU map. These differ when
> CPUs are offline or a subset of CPUs is used, leading to the wrong, or
> an out-of-bounds, file descriptor being used. Index the file
> descriptor array using the CPU map index.
> 
> Fixes: 282c195906c7 ("perf record --off-cpu: Preparation of off-cpu BPF program")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/bpf_off_cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index c4639f6a5776..ff8935688b43 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -95,7 +95,7 @@ static void off_cpu_start(void *arg)
>   		int cpu_nr = pcpu.cpu;
>   
>   		err = bpf_map__update_elem(skel->maps.offcpu_output, &cpu_nr, sizeof(int),
> -					   xyarray__entry(evsel->core.fd, cpu_nr, 0),
> +					   xyarray__entry(evsel->core.fd, i, 0),
>   					   sizeof(int), BPF_ANY);
>   		if (err) {
>   			pr_err("Failed to update perf event map for direct off-cpu dumping\n");


Reviewed-by: James Clark <james.clark@linaro.org>

