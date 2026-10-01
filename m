Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006A4FB9AA
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850860; cv=none; b=t72vaIXjIwZKQlTlQDvTLpcw3Io5Hstc9pF+JcEvyC98wtdJ88ADUmA4ctSdcxh9R7wGcgpnooxxMlra9pNLP/s11UiukQ/fQp//o6eeflk3W8bWUmdfNgNk1iyaAqrhh6mANsUYqZ+ZglDx2a+4x+G7C33AMdfXA5DI30b3/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850860; c=relaxed/simple;
	bh=VEfnYd8hTZyWgfCATX2hNdW7HMso3ZFyFWxEXtxRroY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RL/torUxW7gS7+cpptfOSRg3Y6MuDhKbgjhA4NkV3wC7OX3rzezI3iRTkJtOuL92iwhGbEESbEqLuwRqtFZpwEliYYrVHDNUtLFAr3GsbEXYg/n6mtKwe/v3QIj41TSx6poV6cINbEey6ihSmnBR0INgP5wuE+CHf7/d5M89xTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BIPnsqBz; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BIPnsqBz"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a1f611461so241063766b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 03:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790850853; x=1791455653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsEC2ObM81Hk4wNSJw0hwoJxDbidZYEWvF/d0koOBjc=;
        b=BIPnsqBza8eF3mRVs8mkgCTmAHmV4c9sy2pH25NOe5CILjR4HlEHvmmVqy1QYyQn2q
         +yRU1PXf/7yYdLJASXH4kqgCsnVosD73K9kg7LOMpJDN1JIDHQVUvPjp8TL4FFfcIPY+
         cm+qvJ8UUNCWVZFDBbMgkjQatlpjk921SkJ8OIS/QvNI43eye4YW7H+1kvUqnGLzemF7
         RQVkPYdJuRpXieIUXnsSzX9DE7VB5cHO5SQvLMoI0ASEZbePDgGFaiHfvioRntJdxBx7
         GJWDccOzd8ejgl4wFiL8ljqR8dAYEsHw79EaiZtum0uhVBCxxSXJ5y9gYWIKWMJjgG7n
         Cfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790850853; x=1791455653;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsEC2ObM81Hk4wNSJw0hwoJxDbidZYEWvF/d0koOBjc=;
        b=ZsznUdBbgkXXy8nF/tWquId7AsIflJ6boif7TIwzeoygBTDMjLswbegrNP5TJzaTUb
         xmR5Dw8xwErK7mR4EFpqAltBFX1KzAloIiaAK9hv3Jaa/siPqnKYfWN0CJ+t/V9rOVBm
         e4HtK0bPq9B/BGLvYMFWBQCP0bLyM+6abbErOfdciBl4cWwizhWLwYV7Bt7Po2rNiU3R
         EKk3fwgQ8Xem5NZ1KrNAqJYjbu+lQPAvKaq5nzLGRBGR60S68G2Scm2YeFAL8dxjtjn1
         pjrVCqO81nir92/h8NJSTYHYpA42rxuZv03WQ/m5DwlxuT1W9YmXC7y6ZTkq/cEyvnuO
         JSSg==
X-Forwarded-Encrypted: i=1; AKwUvBwrLNrRjbfSgrT6jX6doiDHodYSwriq77+ns2kmpLF7/utPGCwXDz/1rvitqR5R5wzqr0sI5yCfNpnPtESuMzsl@vger.kernel.org
X-Gm-Message-State: AFuF++muvvGPWzT2fpP6tsz5Z53do/RWmmFJn09/6hez3/4/J7zaVT8f
	lfWqNIENOle08ngc6cj6/fC+4AszaweTQjfC/QRRyiY/y1tWyQzN1Vf4ryyz2Aci+LM=
X-Gm-Gg: AYBFou2/GSqSu+q6b4YCeCW8vFBueISo4QxYDHLx38V0xgmwPphhZHmOokRyxgawXww
	HDnpDWotXhOQx56MOFdWyaNb+L8po4ByTX3xj6dkRq5mJAaenmzXU+92zxuOppsyeYUdBDUzCK3
	hNRUV3jmLT25hbKlCVlwkHCo5+zYV81lqkW8W2qwMP1650/TxyCxGSHzQ6QS8Qki8QzuxcX7zq8
	8LqZWElQBg5r+G681MeG7sFC7SlcFzOLa1yjiHp6AYZNw5XXfFk7jPcxqwN8zb72I6rYSVp8ps3
	PRKbN/9Z1Ey20I8+kjoSsG8GtcmMWj43Oy0ebu8R0fj6TcRLUT8rGhoKq4fkWsjngMppAzARBep
	oFHvwuRjbbd/UOA7NXwUkD22TBo67g+yVdEN5iVcVYEqZ7v5shP7ouxPLz2t35v/SJ/CVTLNuPc
	Jwq66xOPvG+rHjQTnaEEShv300ofd/ivV7RphynJiTR8uDw7+z43VM7TUVhvc/8fm//s/+lzV33
	II=
X-Received: by 2002:a17:907:7287:b0:c2d:d4dd:8b5 with SMTP id a640c23a62f3a-c2e33e610bdmr207503066b.19.1790850853125;
        Thu, 01 Oct 2026 03:34:13 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31a3eb32sm135974866b.3.2026.10.01.03.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 03:34:12 -0700 (PDT)
Message-ID: <dc7a2922-bee7-42d1-b4a0-7469cd06f4b5@linaro.org>
Date: Thu, 1 Oct 2026 11:34:11 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] perf: cs-etm: Don't add global v0 HW_IDs to
 unformatted queues
To: Leo Yan <leo.yan@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Suyash Mahar <smahar@meta.com>,
 Amir Ayupov <aaupov@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-1-9d532ddabcc3@linaro.org>
 <20260904164309.GZ8904@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260904164309.GZ8904@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2026 17:43, Leo Yan wrote:
> On Fri, Aug 21, 2026 at 10:50:29AM +0100, James Clark wrote:
>> In the case of mixed formatted and unformatted trace with v0 HW_IDs, or
>> no HW_IDs at all resulting in the cs_etm__map_trace_ids_metadata()
>> fallback, formatted queues will write their HW_IDs to unformatted
>> queues.
> 
> I understand a session can support multiple sinks, but I don't expect
> to mix up formatted and unformatted trace (see sinks_compatible()).
> 

But sinks_compatible() is only called multiple times for per-thread 
sessions. For per-CPU, userspace opens separate events per-CPU. If the 
user doesn't specify a sink then the default one is chosen which can be 
a different type for each CPU/path.

> For the mentioned fallback, I am also struggling to establish a case.
> Even AUX_OUTPUT_HW_ID records are absent randomly, I don't think this
> impacts the queue's format initalization, no?

The fallback uses the metadata only, without sink information, which is 
equivalent to v0 records. So it's just another way to trigger the same 
problem.

If you're using global v0 mappings, then we assume that all trace IDs 
are possible in all queues, which results in multiple decoders being 
created and triggers an error in OpenCSD once it sees that being 
combined with unformatted.

