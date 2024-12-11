Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78465236FBE
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911085; cv=none; b=ns5vi8X6wjAAtdgSS2mmikutQmn2HNSrPz+R+YcCcYH7VRhuDUq7dE8fzprz5lyfC0fwqnO6zwGGMeFygN1F8JtqU/ADM50Sdfi+h1WNeUeQ5kLC01YpIEDM8SzVd4oCXL2DYxTZhm9So9kTpIk2Lx31Eywz8rZkvhyiktVqZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911085; c=relaxed/simple;
	bh=hb10IRqDEB3bAd6YS4FDT3teoGsks7yB4MJQiDSV2mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=kjr6ESckDmd0LU9ywjTf6p7XUidsHnIErHIlwyeygeAlFLHwXtjIpUK4Ot5rcsOXWSHGtFBru/JCR90IotIYO9kLGopq0TF/57NOyvKUrcrdyveA5t3aGw563FlZeKzhPbBII7MGPCAsmB51ZEqis67UvyO9NI63BiIZlG0hI40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l1Cojbxx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1Cojbxx"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso9006825e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 01:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733911082; x=1734515882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tciY6+uBVxS9wS+R1/VFJQBrmgOsGnFvaLr4XYlcAbM=;
        b=l1CojbxxX8p1hseAOj2Yeqg1Ardqttds6KVeIVxiuHP4yBES2AclWfGgGV3cuO+3As
         RHFQxjZn3bIal8TyTEAYHlVf6o4p4P5JtWWK6XNVaAwbrRk0lFuv9UuA6/C/1yJfexyr
         qUeaN30++I0GE5tsTcw+fQg+FYqZlsRhp4QkRpZSWinFY67kxC/sDlnQUvsZW4VZrX63
         fhBytDLrTVWDcmFzObUW6D5SVLYlO7/hiqWWm/beyyC5SOgFAHR48v2g1V5ZlW3PztxX
         f+e7CtlupPQ/2YJnZmHig4eIHFWYqHSVHs3ZxGVbkxKyfKCF2QdkybBk1Cv+h9rQ77Qw
         odEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911082; x=1734515882;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tciY6+uBVxS9wS+R1/VFJQBrmgOsGnFvaLr4XYlcAbM=;
        b=jfKliW0uXm3FGsaretcy6oqEPCsaeFz3bmS74lXWpT3Anb4kEdRgT4nFrPpHScY4B2
         FlSMHzTo5jEsjR8GQ45k9pLNOGTHOs5w3f/sQCmuufPZTIbM0+pQtlRxpaon6jUYf+yR
         7F/4mE6dSHqLGhq4Nv20sdLNCdEVm3KfJUUPAqLLPvDONrxkvtPRWJ0vvHt20UXTVLj7
         uKMIHnX8vcBWRf16HRwHICV3blP7zj8J4uH+2qP3Kkmq6M+wLu4uER53PSNfo3gjHpmN
         XM4BhIFd3nO64Eb+RhP897fFxEFLDZI6l50FF1KcGaJD+H3u5FB7Y+3ACbKcEUFdYscD
         9Hrw==
X-Forwarded-Encrypted: i=1; AJvYcCWEWtmo7/K3jOjxjJx2+il7bGKw0GBkV/+kOf4rOBn2OC83uB23YnwXKF6GWf057ebNP0IhsNX0xnrYKOLUiZaf@vger.kernel.org
X-Gm-Message-State: AOJu0YybVTU7YjwZj4QYSafgix03mfvmwo9aISN9vYdJ5rsB0Hd3625y
	mP3ildroHBQG+NJ2/cOkrnQ0tqdtHYSdmEbY9ez28t9KCIrMvFI6JM28SU+5aDjwmoDNQ9h5d3r
	A
X-Gm-Gg: ASbGncui2VddUgG5AM9J+iZ6Y7BwTAw4zGTe9kZelZFPS6gF69xSeHybLprgu/G8Gc2
	q9T1JsLOJyOFdewo7yH8I3ulGd3HSiHLJC7DEQVYMmx5FBx5ejwBhav27IDpAOrbEbXsOJQjFbj
	P0gKYmQOG9cA+Li82u/vZ4jXt9/DTl5GBKM2zAYKagnrblBMkjBCnLsO16p1PrKRBheEQfodpWb
	lfnNCWxfFZqEPCtNiec7PUABn73QX1sB0Vo3+n0s/kEnsPBARFpPQTAsTy4W1uHJw==
X-Google-Smtp-Source: AGHT+IEqpF1I20Q/eEs3dVdKFEOXVx9vJrnzLjJoaCFt3LKT8qvifeskFJfoMTfYbt9FbaUwAwk2zQ==
X-Received: by 2002:a05:600c:4e47:b0:434:f5c0:3288 with SMTP id 5b1f17b1804b1-4361c43dc3dmr14271985e9.29.1733911081849;
        Wed, 11 Dec 2024 01:58:01 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f587sm911405f8f.11.2024.12.11.01.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 01:58:01 -0800 (PST)
Message-ID: <6f441be9-7731-45dd-a131-39cc2e34dc1a@linaro.org>
Date: Wed, 11 Dec 2024 09:58:00 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf inject: Fix use without initialization of local
 variables
To: Ian Rogers <irogers@google.com>
References: <20241211060831.806539-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241211060831.806539-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/2024 6:08 am, Ian Rogers wrote:
> Local variables were missing initialization and command line
> processing didn't provide default values.
> 
> Fixes: 64eed019f3fc ("perf inject: Lazy build-id mmap2 event insertion")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/builtin-inject.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index d6989195a061..11e49cafa3af 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2367,10 +2367,10 @@ int cmd_inject(int argc, const char **argv)
>   	};
>   	int ret;
>   	const char *known_build_ids = NULL;
> -	bool build_ids;
> -	bool build_id_all;
> -	bool mmap2_build_ids;
> -	bool mmap2_build_id_all;
> +	bool build_ids = false;
> +	bool build_id_all = false;
> +	bool mmap2_build_ids = false;
> +	bool mmap2_build_id_all = false;
>   
>   	struct option options[] = {
>   		OPT_BOOLEAN('b', "build-ids", &build_ids,

Reviewed-by: James Clark <james.clark@linaro.org>

