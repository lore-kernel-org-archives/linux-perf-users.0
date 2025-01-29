Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E21AD403
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149931; cv=none; b=InGeqkHp0qm2flQo1rGR4aD6F01HTosh9TtLRpT0oP/JdkngL6zYVIiXAOUg7gwS8WqBE2RAM+lCRl6DA5mG4Jn4DxQBrbdbDpM52fHbP68Kpgu7eP3wkoNu101/DNK1WkLWfP7n6cehr27MabXY0Va4t+JE1isJBZODt1T/JWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149931; c=relaxed/simple;
	bh=UIvTjmGAeW19eKImfstK97r9KLkLxx54y5jKLqkocKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=We+073y/mi7jHmXNwRksQbkngrUWKVW69U4ObcM4HxhSYiaaHvEM3sSQ8/sL4WDoq2fffkUxX5QtlRG5/x/EaVtcKCNRGQfjMCevGzi+iwOwIyABa2eY4sM8ejefKhsffS1oKgMJ31KlEDAMf0XV0/AdUlZ1tIJ34UIDgOwlMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cSQhzcsw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSQhzcsw"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385df53e559so4832676f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 03:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738149928; x=1738754728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHwtlIbThC/Ok7Z2PEl51cCmZDr0fuLcbeJ7oJmEgEc=;
        b=cSQhzcswXh1Wvf8klC/7+sDQDEupcbk3issNYu4vUfYJZCRV/X4jbbVBFik4cMkL9X
         vP8jwlmPg1EuxAt2ud9mKP8llsnNoDUW/5+4S10+I9IcSHsgjByK1RdD9qaIVYqX3sS4
         6aqNk1AgXLMNSuj0c/Vxxgzgy29D1CuveoR47F99zR9+ALC7GzMqOsQberzCKc4MhzlW
         s/XSymoZ3TbDeA56Sj1Q3C6yLMNU3g1y2ofhSaP8EW4RyoXLScR13yVZd+0mUXo/8qaU
         byauKlunx99ah8Jz+JFXujK8ufVtWWuJJdwytv2rpGjYacfiN8jn4KUydmUPz/g0OUCp
         K8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738149928; x=1738754728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHwtlIbThC/Ok7Z2PEl51cCmZDr0fuLcbeJ7oJmEgEc=;
        b=iiHKDaMwoeghYlgVogj2itlf6+heQip22K8wsrSZM9cdrKiR+dZOFw0FsagY1Sr/B8
         NAmEDwZSTJfOrwb9oovpV+hwAVn4GEwZHYdwvuxYi7RicpDdsaQ5GQmo3KriXnItBTor
         p6K5HzL+58KhgrAZ07llAKJHFWSzmIDRFi7H7EDNWRPwrB2pAXUCEyLndebzBy1rkZ4o
         fT6nZaAgHZ8SjPvws8cZvwYxVprcPLQqtTLZKBbuKczPOhQw9DBD2g3UN/KsD5faT67E
         /qYlajwwesN7vgPHUrEf2yY6+8rnMAgKxfQIQ+9aooU9apIPIwqkGabKM0NBdsj4HI2Z
         Xb+w==
X-Forwarded-Encrypted: i=1; AJvYcCXvwXPm3D57p4hlfT3RMCvAsidNlhiEmWh/ZlQtjc9EA4Hxl4VorvZ+5S+UG8kkij5YYUcGqaeOik5vUDJylyAd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0HmTjjv4fSiFLxXoH8Hg1CS2dlJvnDbnc3QLV6E3xP+Z3rb3
	tdzFPIPymLMOo+aEis9kd3qLZN+/vftP9/L2aQMJftyog8ONkT4vkdaHIMPOvRM=
X-Gm-Gg: ASbGncsZYx8hGyBvy4qSD/W63AjvDB4NizWEJfheRCnZugQ2VNiUzGenNiTocTIaYcs
	2gIjbTpXB9JaHzmOlmuZfJMfWfBTbmtIzn6ckeqDyRpawJGpqsldFUf1AkdjcjSEI9cIMhnyi7a
	qYm/PqacNMSBr4v3zvO5bMmE/i28O//jes7bMa5sXkSCe5ZSdWwKnKGigewToxwOlhEkbePCTqI
	fJJJrjPEZmLoDE8w5pnZ0fASk8mvH7eRJH+eVLLFPryWcvMHdeP3oSR2Zi2NkzXYnXouEbxhI9Z
	eKelEWlc6pJqpXb3U4xJkHLVGQ==
X-Google-Smtp-Source: AGHT+IH8V4JUB/LYBwmaeps3xFMGOWPHnXzvsxPPEsIMQ9yWrvyXvRXsW1GIlIhzii/9exlJhKKMjQ==
X-Received: by 2002:a05:6000:400e:b0:38a:3732:444d with SMTP id ffacd0b85a97d-38c5195c27dmr2379123f8f.23.1738149928191;
        Wed, 29 Jan 2025 03:25:28 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a176449sm16944923f8f.11.2025.01.29.03.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 03:25:27 -0800 (PST)
Message-ID: <1f7c3e78-8152-443f-a37b-38cacb733714@linaro.org>
Date: Wed, 29 Jan 2025 11:25:26 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v2] perf test: Skip perf test 114 perf record test
 subtest test_leader_sampling for s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
References: <20250129071134.4024430-1-tmricht@linux.ibm.com>
 <20250129071134.4024430-2-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250129071134.4024430-2-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/01/2025 7:11 am, Thomas Richter wrote:
> On s390 the event instructions can not be used for recording.
> This event is only supported by perf stat.
> 
> Omit subtest test_leader_sampling on s390.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>   tools/perf/tests/shell/record.sh | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 957ee10aff44..9e645eb09d9e 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -307,7 +307,8 @@ test_system_wide
>   test_workload
>   test_branch_counter
>   test_cgroup
> -test_leader_sampling
> +# On s390 event instructions can not be used for recording
> +[ $(uname -m) != s390x ] && test_leader_sampling
>   test_topdown_leader_sampling
>   test_precise_max
>   

I still think we should use the cycles event instead of skipping. My 
intention was to use the most commonly available event with 80fd0c1eac7 
("perf tests: Make leader sampling test work without branch event"), 
it's not important which event is used exactly

