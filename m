Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F7A152165
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569293; cv=none; b=Xy0JmXMtfCM1SQdA5QSpfydBJ2NQBS/rizgxV+dBmFH1j2xklxChb+VrJcW49Jzb1BzJWl0l1BKEhZ/IT7mZsB5L3D9cnxgLHF0xl1+raNhASmuM59VKZlVwZFcr0sHOtZkOjKqBjfZnQtoVkRJMp8tr+9NXzI5XvrPrnjbGw1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569293; c=relaxed/simple;
	bh=7/3vPXDrQWMhs9icxfIhVsMHblmE8JCuuUC6wc2CeiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIhPitLzEyXajZvAQxMI/olmNnk2Z8i8eQ3m/n64KQc6pbDJWs1NFRxLlv++FAuAwF7lgF3d3DhrELqFSej1j/FLWaLoHx0j3TIKQXECNhewY4qnLWzapQr1sE5uEvmwyH6xkIbdxQ+tMqydX+skUZz0gAbxbzso+L0G8tWApt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ILOnHvid; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILOnHvid"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so54105235e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2024 03:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726569289; x=1727174089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lajiHp8pF3piHvYLQb6FYA0YAlImwOIzK66rOuQWis=;
        b=ILOnHvidhGH18+EDdsZLFVm9cHFxr29LqgOUwdaAHDEESf49nh8ZB8kSSNI6vSMSXZ
         80yqpR9J0Foz+3OU5RTYv/0BUkJgAbwr8YST4s9M7CCdFavRf4VtwSNLiS3l2t6mHtKZ
         yY3i/LvXQ2ZXpHozVoZWNa+P76L8oQKmwIS3eI9rNqz5urpnq3paYRoXss6ZtuyX4for
         uKUWdmF7F0Jg8YLzQUpHlNtDdhNGtto+yI7IKtUqCAJ7seJ5GkRsrcfBR/1ynOZbJi+j
         I2WU3CCRXekZygBghS+RJlPIQAgOOXoLcWdCyvXAnaVO6PaQwz6G1Pavy3zNurJaxF7V
         s4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569289; x=1727174089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lajiHp8pF3piHvYLQb6FYA0YAlImwOIzK66rOuQWis=;
        b=lUyiQgYJB1721EZVQLKVBCg8fIN7e48bq9QqArXGsi2zLjJbl4Omd+rywanHu1iRXX
         42TIQRXPfPcC1QVgy9xBzMk52QrH1Lav4TUUvFXe4oILlZJCaZZkhToXRoT23nkYJKMP
         ZUyKAoMTHvRcoaFqdN7ii89+GB4/FzjWNTGkwCxjrGy2vqgOz0JGwsgckw63SlV7wcgY
         +3ff+7slLUpTGorezro4xXpwvK2MNKrhxda3I8oSMr+HPSB/Rt4BLHn2ix2r7x48e9OH
         V8ImtrEIhH+py6EUfOYhBpIIRQ6YFm+2omS4+yFTekeRL8WHUYo70QmXpe1+1LdV/Yga
         nO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/Pcds9a/HxV8wM3JJpHM5xzVzLL2hWonbYnGh6UhfMDMSk3lpYaGmlw+kvzSUqGg9B+kfdYsjkoc7nGVUz7RN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn20/0s+HfLiKuVpS94vc2uZVgFNJKwXNf2xT+7j0gw0J6nbTe
	4c9DWM0BPTBwAiMuajmDJp6v0ZF+KrOpVKz4apAdQ5P2opr44zg70cZFL7eVveU=
X-Google-Smtp-Source: AGHT+IGTY3U2D3ATkqAlxhwKnfD0PwMT+SbB1VPzu7nsazWDiqfRvg8PRPw4ZwRCHyCLO4+1Gti3kg==
X-Received: by 2002:a05:600c:314e:b0:42c:bf94:f9ad with SMTP id 5b1f17b1804b1-42cdb5919fbmr131246545e9.34.1726569288794;
        Tue, 17 Sep 2024 03:34:48 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f99a4sm9100986f8f.57.2024.09.17.03.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 03:34:48 -0700 (PDT)
Message-ID: <95e39d9c-7f0e-447b-9b2d-aab5d36b933a@linaro.org>
Date: Tue, 17 Sep 2024 11:35:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] perf sched stats: Add record and rawdump support
To: Ravi Bangoria <ravi.bangoria@amd.com>, swapnil.sapkal@amd.com
Cc: yu.c.chen@intel.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, rostedt@goodmis.org,
 vincent.guittot@linaro.org, bristot@redhat.com, adrian.hunter@intel.com,
 james.clark@arm.com, kan.liang@linux.intel.com, gautham.shenoy@amd.com,
 kprateek.nayak@amd.com, juri.lelli@redhat.com, yangjihong@bytedance.com,
 void@manifault.com, tj@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
 ananth.narayan@amd.com, sandipan.das@amd.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, irogers@google.com
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
 <20240916164722.1838-3-ravi.bangoria@amd.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240916164722.1838-3-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/09/2024 17:47, Ravi Bangoria wrote:
> From: Swapnil Sapkal <swapnil.sapkal@amd.com>
> 
> Define new, perf tool only, sample types and their layouts. Add logic
> to parse /proc/schedstat, convert it to perf sample format and save
> samples to perf.data file with `perf sched stats record` command. Also
> add logic to read perf.data file, interpret schedstat samples and
> print rawdump of samples with `perf script -D`.
> 
> Note that, /proc/schedstat file output is standardized with version
> number. The patch supports v15 but older or newer version can be added
> easily.
> 
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---

[...]

> +int perf_event__synthesize_schedstat(const struct perf_tool *tool,
> +				     perf_event__handler_t process,
> +				     struct perf_cpu_map *user_requested_cpus)
> +{
> +	union perf_event *event = NULL;
> +	size_t line_len = 0;
> +	char *line = NULL;
> +	char bf[BUFSIZ];
> +	__u64 timestamp;
> +	__u16 version;
> +	struct io io;
> +	int ret = -1;
> +	int cpu = -1;
> +	char ch;
> +
> +	io.fd = open("/proc/schedstat", O_RDONLY, 0);

Other parts of the tool use procfs__mountpoint() for /proc. Although it 
can only be in one place so it doesn't actually make a difference for 
this one. Probably worth it for consistency though.

> +	if (io.fd < 0) {
> +		pr_err("Failed to open /proc/schedstat\n");

A hint about CONFIG_SCHEDSTAT would be useful here.
