Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE4A25BEE1
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Oct 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054989; cv=none; b=RNyAsWUL0UlDaE7BOx6UyG6GIr0vrOu5G0ZVCJGg309ib1gbga/DoGYRYNHob2dvZCiPHYq96vyVg2lH7BUN6dTz3rMg/FGGY2tT7VWQi9RQIOWbzF2EkXc/E8SPliMln/7WY/PVsBphzyKB6xiTs3dMvkvWzVy1mCdUT0SHUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054989; c=relaxed/simple;
	bh=1tI47LilJz0LTQhKkkRNDAAgdtyxYGXBPiVxjWz4Qzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMZXtiPEkmHQAdwdAZbVF2Q75HScEIPXLwYNeBlp/mi2UX25JgP3ks4a4hU3WgYDUScyjDB09mR0VNGHViSfpvCYN3Utrb7LrK0113ze+lMdv8GX0vFJCcU5svpDy2K6B0WdfM3O16fpvaycyJX8SVKmKq4RCDNJlQ7LSZOF9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YLZptD3k; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLZptD3k"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so53452515e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Oct 2025 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761054986; x=1761659786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7mUzjaKTsWvab8967NYueHb3kzfIltPZrtuhl7WWYQ=;
        b=YLZptD3kMby1/D3JvdWyyfE6PdpbiEY3RXux7VdHLXnhvR+JOEHhurV04+KBm0n14s
         rFcJl2yDXdX+31NgbjZST+85RQ62zANghVBa39QVexP3xJWw0Szj1YcntgMN54ZtTmAy
         usmtdchJjawVXpIoW6TuEB9oyQazfSYpqwn5h1ByvD8A7EK3I6joBE/P+tLK8S+YJWKv
         t/c4VvmqdCckbKfE0gnPxkCeLjElv1ZwSKAPsGUlMieJ3N0m9LgcUWNlm0wHR223gNas
         Z3nbKEb51hI2Tj0im0FJm2yCEEPn7OaIejEEZ8fSsjxQ1ZNKkQmghQYjUp8Ij+p5pRXA
         HQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054986; x=1761659786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7mUzjaKTsWvab8967NYueHb3kzfIltPZrtuhl7WWYQ=;
        b=w53o7WD75okaQao3uC7ne4NWpWZZeUmHFZya3ym4SyPmq72xAHDB+DAhxhlwkl5Zaq
         rAgLmmCAXkATvkY2/w9s9K2qfNmVjupVaQ+qXlPIM1DYxeaVCNDAcOD7ldW2l5oxa/Kh
         kRa0G+R2F1cclDgHNpYFrMnK0qtaEj48YWVmkXrxfjNWhpuVtUUB0AK4+vrgCJhW47ES
         OeF1uGoK1g0KfR6k7w3llKmoh36Ty03H1KZ8+WH65ebzl7wGiYPS/s0TPWwzGdOOD8v9
         UH8PvLmwGb2rs2jc/MZa4lPIg14pNy7kzutMShW/YxY+RS2RbbxdbKmlpZOj+4zxMdD1
         hg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwj4uN4gpjZCe0W2qnkFCVJ8ZKsljwlcanzix9Oids9mSGdvqlIxJDFE+tnOwUx8C22vlpB8NXzfkA9asS9nsd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ol00igK2H0IE31rDVGqddAG4OGSmov8tlpGIKTWJ/rL/hai4
	qH2/qVHOE/guRlvIgGiyVm3jYQcPwQJe76ws/FQ3YORMT9NauqFSzjj+kJ+KMSyyhJU=
X-Gm-Gg: ASbGncuFE4kY+kxsejOipC60CLkACMXQGv8WDQg0WtQejaxgI+yeyRdoB02Z9KlTZBn
	DO0mxPPWzhTtP9kvdWggrEU4dVNV+LwZzcvjZ4moWkCk0QENGBVSpLawA5gg9H5S00RfExlnvmj
	a9fcZWO0BPpvKTrqQwGN+wBl0dxu/taTsErBQW7+IdAUTN5oDXL8tVz0ZjjgyvujFduWwIkhZNe
	CTxfhraK7/rk9e8QGdR3s7PKqgx8BeJICgSJcQaxV15WMHnIvNuZKER2ojHOiN6wtgWDzG0G9P/
	b18H3Fu5sHAucc3UEQQwS6og0T6hjZTTSxpvO6ubI1UnzmSEvi/pztp3UaMRam0HRaB+FyLPHlu
	SD0h/GNUfjTUdcT0sCzydHR0D/t5HCPovlCLwkIICOug5LAKPxr1nsnmu9y+sB2ThJ904+YP5w/
	4QdUZf/b9O3SJjKs0S
X-Google-Smtp-Source: AGHT+IEb1H3ulA1oy86fPg5f6/ZN58UzoPvfyonUAjv57eqjyMVYWPMETrF6iJBsZ3aFzdD6CZxkfw==
X-Received: by 2002:a05:600c:a214:b0:471:ff3:a7fe with SMTP id 5b1f17b1804b1-471179123b8mr86323045e9.19.1761054985605;
        Tue, 21 Oct 2025 06:56:25 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496c2c9dasm17383885e9.4.2025.10.21.06.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:56:25 -0700 (PDT)
Message-ID: <aac9daf9-126b-4c55-8d29-8e456b305cc8@linaro.org>
Date: Tue, 21 Oct 2025 14:56:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf tools annotate: Align the symbol_annotate
 return code
To: Tianyou Li <tianyou.li@intel.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria
 <ravi.bangoria@amd.com>, wangyang.guo@intel.com, pan.deng@intel.com,
 zhiguo.zhou@intel.com, jiebin.sun@intel.com, thomas.falcon@intel.com,
 dapeng1.mi@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <aPW2iiNeheOxDGw8@google.com>
 <20251020073005.957524-2-tianyou.li@intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251020073005.957524-2-tianyou.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/10/2025 8:30 am, Tianyou Li wrote:
> Return error code from the symbol_annotate previously checks the
> evsel__get_arch from '<0', now to '!=0'.
> 
> Suggested-by: James Clark <james.clark@linaro.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> ---
>   tools/perf/util/annotate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 39d6594850f1..859e802a1e5e 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1021,7 +1021,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
>   	int err, nr;
>   
>   	err = evsel__get_arch(evsel, &arch);
> -	if (err < 0)
> +	if (err)
>   		return err;
>   
>   	if (parch)

Reviewed-by: James Clark <james.clark@linaro.org>

