Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430601;
	b=JKGOqHTW4HjmRkg6uGkvfxXgUPH6OGtiVYgfivN0ApdSQDMms348kSywqGSbaJRkJ0Xp
	 IOE0lt/yQtVxswRxQ7pJlu+giw85Dudqs15SAXvNkMTwfyCzFXPMFv98muKqOlfXiuC5I
	 HY5s0Zk0OqKghu/QFC5B0IeUa4l+pz/j++9QFLzHobySd5UFY7Nyxj4xf4QWBNI/0DDCb
	 C/JliE9K9OLIFXF1N0o8X07yAMpA6yZaXLI1qqVX3Kb3O99DnCTPMDrvfoxdovqMGKHKv
	 1MHWMUjyMXKtKMUynUiIKij6mXvoLtojxSI9Z64nNJUstLvFcM0C1ZaOr5Hj2vMpvCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cOvkQnhbq0+fnTGNKO70Y/TnLhjhtLA41wQn07DNzu0=;
	b=qTr/R2/s+8nRyY8LD71q/rVvgL0hjPNKP7SI/r+1YN+8D3kSEcHR2YtwXc3ZYNhNr+0+
	 KOSfTnNMADnPS/FzKCAT7cpy+p6FrNyL9vJ375WWsDHQLzo+Jkx9OJwbDwjr/kgNfZFA/
	 VE8ugZxlCn6lsYb+tsBqv8GbbmpNTTW8/P2OFzRQeCh/PkZa1tMZO/4vRG4mg6A2mY1yo
	 aR9apWnOQ4ity1FPMM33AJZxzIljnp/YAj9kDzR+HberE2MYSbcMcsTFObg/8vpV4AvSA
	 VoWWKkAW492IRtqqsCuJqLLCFigYF1MI/mUO9tih0VB+UfBGBioY/B1I7xg2cJQAIsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xrJ3CVQS;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02C606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 17:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B02C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xrJ3CVQS
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1e1dade31so10647365e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792430599; x=1793035399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cOvkQnhbq0+fnTGNKO70Y/TnLhjhtLA41wQn07DNzu0=;
        b=xrJ3CVQSp123OrHRWakMwwLvRCPyALMdPVipV2UsJjCIoUTLR7morKTAk17lhHp6EO
         2DxdvTVRdC82uO9JgWxqroq4NbW+Lr/wBuyhfv5KU57y/dEEzWhlNxzmjDrzjvjIv51B
         vSxuCjn2AAls+yb4o3ajXqIegrWuRn20NPUhRIicbAYAiRS0zPYgovPKPESfcfL3yZ6c
         9UCKBgbkt9AgWODOWQg6mxsqqWdDjXXWEu4XNlT8LsVlAgP9l9EX/dWOQpZ37AEnLljk
         pXkT3rG6kFwU7Z0lPT/rCBg8MrH3TCDULMJl2iVxXlxezLooCY7+wjcpOK53ATfstfAI
         XhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430599; x=1793035399;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cOvkQnhbq0+fnTGNKO70Y/TnLhjhtLA41wQn07DNzu0=;
        b=YfQjcrD/EmuVN8pa+asZBvCeVlGxvbwV9elUzpz8tUU/5JxHv0MI8Sw6qu5ymNqxqO
         fCW003B+V80YHNRcyDJSGL8Z+/GgfGWeLWLrFNqNEqfDmwmWZGumQnNAVtzThTCy63dm
         7A4rItBajINY/rkLUnnvJBSvsYcKuxeAtlIj04y8KdquKmwZtd69hFk164bzG5ljlcm/
         TgLzdibOODK86NQmRdiwJnn7lOBP+2TQimyFvpzPxjbZIqQ2HFCDZth3VCmOFdTa896P
         vtU7TC5TLDscHovX/Y2MDCeeRsVFLhG2E5JNKniQpQugix71YZplzqhZUbes7El9/88i
         WF9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxEdqyh0laim9fLHcVCNBJ7MroYu9MqTSXo9Vm/9S4nQnAyqs5b9chGil2v27Z5AAnk380irwBlZLQ9+eUeiQkr@vger.kernel.org
X-Gm-Message-State: AFq9FYKVKzIgkWCvr7fEB9OBbfcurYidcf17X19uhJAYC3ZcslGYzU9/
	OGf3OgVfV+3QqB/JWbrXCtrR74cZD31Edgs9ufs4H7quizKFViSDROPDNiYz2HT7JN4=
X-Gm-Gg: AYBFou3T76RDQ6RKCEx0ktLYCQ3SqzIgj9muab/uzs6aGgk9Sy7qiLJ6AS9hzAiSPLg
	a1txOtBzL+SBe8jietq3rOJJLSJ6N/hO7tU4LCzksHh/Wg7Hu0RxeUKxktOSEKsg8ZsMsQxGQB6
	ERvJBG5JgRpH16T2XxzU4OY4BwheRIKYrgpWBPDX2gndA0xlCxlGCtL2QquxNCaJfhkk28Uqtz+
	kNyHjLjcGhIxavgrQhE7PzEV1XzrBEC2jOHVI5gVxUnbwGrd/eJ6ERl3ucOGfetMCbc1XiV8Jhu
	6J+EITSkGu2eWAI9FMcxZIPDIi6IUJdbNOhwi0nhorO9QoG5y0Cd/Lavm8XJQPW1WiD6aX9jGwx
	UNXv6WtxY8aW9U8KIOFczxjLatbX4se8f/bVXNigrDAjqDBbfiMptUAd1b6FTxgpc3bgAxtESsD
	F45EZBDW0tpnQyuxr28MSl1CRLAA6UAMmXjejIEpmEpi5cq7W2sUYS2OpYhnZmVUfecMlkQxW79
	oc=
X-Received: by 2002:a05:600d:4447:20b0:4a1:d483:559b with SMTP id 5b1f17b1804b1-4a1d7612bbdmr129179715e9.24.1792430598956;
        Mon, 19 Oct 2026 10:23:18 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d838dd6sm184529f8f.58.2026.10.19.10.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 10:23:18 -0700 (PDT)
Message-ID: <21f58af0-fa3f-41c5-ab03-216c60fbe2f1@linaro.org>
Date: Mon, 19 Oct 2026 18:23:16 +0100
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
Subject: Re: [PATCH 0/6] perf jevents: Add NVIDIA Tegra410 uncore PMU events
 and metrics
To: Besar Wicaksono <bwicaksono@nvidia.com>, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com, mochs@nvidia.com,
 rajjoshi@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com,
 john.garry@linux.dev, will@kernel.org, mike.leach@arm.com,
 leo.yan@linux.dev, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com, ctshao@google.com
References: <20261019164241.403644-1-bwicaksono@nvidia.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261019164241.403644-1-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/10/2026 17:42, Besar Wicaksono wrote:
> Add event aliases and derived metrics for the NVIDIA Tegra410 uncore
> PMUs.
> 
> The series covers the UCF, PCIe, PCIe target, CPU memory latency, and
> chip-to-chip interconnect PMUs. It provides symbolic names for the raw
> event encodings and metrics for bandwidth, frequency, and average read
> latency.
> 
> Patch 1 fixes a jevents ordering problem found with this layout: the
> uncore events live in arch/arm64/nvidia/t410/sys/, next to the T410 core
> events, and without the fix jevents puts the core tlb.json (which sorts
> after "sys") into the sys table, so its events are lost from perf list
> and perf stat.
> 
> Besar Wicaksono (6):
>    perf jevents: Process model files before sys subdirectories
>    perf jevents: Add support for NVIDIA Tegra410 UCF PMU aliasing
>    perf jevents: Add support for NVIDIA Tegra410 PCIE PMU aliasing
>    perf jevents: Add support for NVIDIA Tegra410 PCIE-TGT PMU aliasing
>    perf jevents: Add support for NVIDIA Tegra410 CPU Memory Latency PMU
>      aliasing
>    perf jevents: Add support for NVIDIA Tegra410 C2C PMU aliasing
> 
>   .../arm64/nvidia/t410/sys/uncore-cpu_mem.json |  48 ++
>   .../arm64/nvidia/t410/sys/uncore-nvclink.json |  75 ++
>   .../arm64/nvidia/t410/sys/uncore-nvdlink.json |  48 ++
>   .../nvidia/t410/sys/uncore-nvlink_c2c.json    | 129 ++++
>   .../arm64/nvidia/t410/sys/uncore-pcie.json    | 247 +++++++
>   .../nvidia/t410/sys/uncore-pcie_tgt.json      |  93 +++
>   .../arm64/nvidia/t410/sys/uncore-ucf.json     | 693 ++++++++++++++++++
>   tools/perf/pmu-events/jevents.py              |   4 +-
>   8 files changed, 1336 insertions(+), 1 deletion(-)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-cpu_mem.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvclink.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvdlink.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-nvlink_c2c.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-pcie_tgt.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/sys/uncore-ucf.json
> 

Reviewed-by: James Clark <james.clark@linaro.org>
