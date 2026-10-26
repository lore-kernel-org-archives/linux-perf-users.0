Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008047;
	b=ArI2FLn6amxyzkLLg2NUyV6saOmG4S/qIQn+hmnl8GBB4XoWjjq0UTgRtcmm3V8vo0Ws
	 tESVVvwysqZuL1xtniPtJeBuSK4BMViMY0Dhej1mIDb9CWJ7HnYEhWBustQ1Pfv2uf/By
	 NOve3r3Oblb9Idq2t6EoFwF1yyGQJsOg+GNhmekBGTwfXUeUB1f5bRypvvZYOHuoG79BO
	 6I9Ywwm/LKm6d+KcovqSzNBhZFhoRBDyzwUNM/9G0RNCZjWELNwJt6A4hl1y6hiA98C0/
	 N/mGmwdVtiUvt3xhCkuMyn5mWfKSrgbyhqvBWQuxxrkX3zmp5BdUyzqYlV8Lh2pXZDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hzbelKKDEnxgjYmpghnUkffEydiu9Idn1aqDCjEpGss=;
	b=KvdVdpGOlCnX/E+PXWszFX1lAZ+3TqrB1tWb9YDLHg2tRQBhdqoLmQ3seyKtF0r1YBjP
	 70vtNeVAd3wxTuyuaVoOrV9GftdCbS1h79+Cit1rsOQCepSijaBQwL2NpyuASvWTIfShb
	 anpmle+UHJbr0EV6Hehw5oR14enIrfVC+JsgyhTxA4M9UHl8fyF5Aa9DBik9sQah8xpul
	 BNAW/ibnoSZf26mmfnoF6Iecf4f49M9m3FLgQfp92JNbEv4hGbV7nxVYUn2V8oNBrSyiz
	 4zrtq6nwbvpJegXPXYeY501per8sJMV5CKRYs+08zw0Z3cYilFB5hv5i1Aj9RxJ2NwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M992lOYS;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB3606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96EB3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M992lOYS
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so15272565e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 02:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793008045; x=1793612845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hzbelKKDEnxgjYmpghnUkffEydiu9Idn1aqDCjEpGss=;
        b=M992lOYSaABSOVMKdr2ZnYdUWuP6nHzizODH7Ue7QDD1DtjeUwM1r+OfJX8hMDnvPI
         vHAhCvo1kkduLiqPajhyaFKGrQ/6onGWw1ZY7PI8Nn7YWq2lf4qY/QN3ih3l9fS88ANf
         bINCev0L4VqNNRSny/Sw46vO6TXRaXufHzU9iYG5ggC9xmQj56mO8h32pjwqiLtojCDG
         V+MfRt7yI9Dk1RsKdlXf+5toDiuoGmoNrCzffXvCVYqyKZiqDrRbrUQt5wIb715jBR/Z
         6GihGXNfDvxRd0Yf2rTzTJR6LZSrBeiMViiepFVglMEnEyt2fPqwRVwawEgL9sNN9jhf
         m8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008045; x=1793612845;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzbelKKDEnxgjYmpghnUkffEydiu9Idn1aqDCjEpGss=;
        b=QpJFLo1MfBooczjvN71GCsF87kgi5+Ekxh0ZNdRK7mbYDG9VdTxHau/GdMrdnxGQup
         Yeaptlw4ftMND8Ynw/P/iKcdWHgktLMGOYAJRvKT1ZugewnsUCNiTFx3T95pmzR/M8T2
         Ii4i26QRWkO+o146I+dS7m2/9UcNX6CnNsifnGlym20wv4froTE8i7JGPtgy5r9cuDmh
         ActLqEcdcFG18n5oTbnsT78+lQ0XbaY1yUlPTSitMACUCI97or2SjAAmnt3Kb6ckeGUc
         X8OKKq3LCWoD0ymoqEoRgDINkKkt0Vh5/r6BeO3+AWiHVqEsW9UM3OV27zUNEfgS3mFh
         V2xQ==
X-Forwarded-Encrypted: i=1; AKwUvBxag6FjhsInWhMIqHqYYOrRWZcuF3fkSjZZ6Lvkqr5BbnSLSQx+ThJUBz79gjvXLtsKjJmnHLWq/eAU1UNdFfGd@vger.kernel.org
X-Gm-Message-State: AFq9FYLQuwu8Y75LoF9hc1QHJnSX8CmAVLQnmxBUpFLrIOskjmtKpuOz
	MJWCQkEtFFhZw4oEYoNNPK3t+D0624Zw2Hg31j1YPRike1eH0ZmM4buIeJMP+HXl6Mg=
X-Gm-Gg: AYBFou0zp99H7XQtVkAzqMVun+RysrVtLZWwxIpDA75nKZnKYFBvynAPPzf/j7FQFGS
	LGwhIb6QpwE2d92ZQKrL8NGzrg75x1Kyq2BUCO5wD2Ovj1Tc2OoIlLeivt68n9+k5g4cdc4w5Il
	vRW7oR7HJzgmBxYw6gFLQI9RokMC5OFTP8vgAUa1cifi1MRov6LC3efylGYO254xfUmOcJNvxyD
	FdEf+XzplmeRbjtj0DQdDhOyd+1ty1MBPWRoKAm/V67AbnC6hubXdnzbvy/3tu2l7+vKmvapuXZ
	4MzlxtrGANyDkyMQx5e5td8A6z5sLhScRhVgB4DS++BqC+oClbgu0vB5QukmBiOuhpRWh//fZD2
	8ldHrpV3dfKqLazVdvxrKL46AnTlrf9gIE86R0pSv6dNPZE9o9L1R06chib9muZFhy/Ml2ne6PL
	4dCTe0VvB1YhXDjdYxW/IE2bFeY1G3Q533VFBwt/tSdqhE+5tMH8NCI1/BUSoaxXkdruv41Rrjk
	535DNMr92kdrRt/IiGi3fJXIGCuXeL1xtX4/bXyb37tX5nuKscaaYOmbR8y
X-Received: by 2002:a05:600c:3114:b0:4a3:5a55:f454 with SMTP id 5b1f17b1804b1-4a35acc772dmr113068865e9.19.1793008045005;
        Mon, 26 Oct 2026 02:47:25 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb40733sm12061897f8f.0.2026.10.26.02.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:47:24 -0700 (PDT)
Message-ID: <f5060f7e-71cb-4e9b-a757-51943070b083@linaro.org>
Date: Mon, 26 Oct 2026 09:47:23 +0000
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
Subject: Re: [PATCH v4 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
To: Amir Ayupov <aaupov@fb.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Daniel Pereira <danielmaraboo@gmail.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <23ffe461b8d7b04f78118154dfc9ea1d2a14978a.1792989860.git.aaupov@fb.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <23ffe461b8d7b04f78118154dfc9ea1d2a14978a.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/10/2026 05:48, Amir Ayupov wrote:
> Drivers outside the PMU driver may need to know whether the local CPU's
> PMU implements a common event before relying on it, for example a trace
> unit driver checking that the PMU counts its external outputs as
> TRCEXTOUTn.
> 
> Add pmuv3_event_implemented() to the arm64 asm/arm_pmuv3.h, next to
> read_pmceid0() and read_pmceid1(). It reads PMCEID0/1 on the calling CPU:
> events 0x0000-0x003f are reported in bits [31:0], and the common events
> from ARMV8_PMUV3_EXT_COMMON_EVENT_BASE in bits [63:32] from PMUv3p1. Move
> ARMV8_PMUV3_EXT_COMMON_EVENT_BASE next to the event numbers in
> linux/perf/arm_pmuv3.h so it is available without CONFIG_ARM_PMU.
> 
> Suggested-by: James Clark <james.clark@linaro.org>
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> ---
>   arch/arm64/include/asm/arm_pmuv3.h | 19 +++++++++++++++++++
>   include/linux/perf/arm_pmu.h       |  1 -
>   include/linux/perf/arm_pmuv3.h     |  3 +++
>   3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
> index 8a777dec8d88a..acd62c4f16743 100644
> --- a/arch/arm64/include/asm/arm_pmuv3.h
> +++ b/arch/arm64/include/asm/arm_pmuv3.h
> @@ -173,6 +173,25 @@ static inline bool pmuv3_implemented(int pmuver)
>   		 pmuver == ID_AA64DFR0_EL1_PMUVer_NI);
>   }
>   
> +/*
> + * Whether this CPU's PMU implements a common event, as reported by
> + * PMCEID{0,1}: events 0x0000-0x003f in bits [31:0], and from PMUv3p1 events
> + * 0x4000-0x403f in bits [63:32], which read as zero before PMUv3p1.
> + * Must run on the CPU whose PMU is queried.
> + */
> +static inline bool pmuv3_event_implemented(u16 event)
> +{
> +	bool ext = event >= ARMV8_PMUV3_EXT_COMMON_EVENT_BASE;
> +	u16 id = ext ? event - ARMV8_PMUV3_EXT_COMMON_EVENT_BASE : event;
> +	u64 pmceid;
> +
> +	if (id >= 64 || !pmuv3_implemented(read_pmuver()))
> +		return false;
> +
> +	pmceid = id < 32 ? read_pmceid0() : read_pmceid1();
> +	return pmceid & BIT_ULL(id % 32 + (ext ? 32 : 0));
> +}
> +
>   static inline bool is_pmuv3p4(int pmuver)
>   {
>   	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4;
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 02d2c7f45b527..792283d29d7b5 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -124,7 +124,6 @@ struct arm_pmu {
>   	u64		reg_brbidr;
>   #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
>   	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
> -#define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
>   	DECLARE_BITMAP(pmceid_ext_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
>   
>   	/* Only to be used by ACPI probing code */
> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
> index d698efba28a27..c21f185a283d6 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h
> @@ -78,6 +78,9 @@
>   #define ARMV8_PMUV3_PERFCTR_STALL_SLOT_FRONTEND			0x003E
>   #define ARMV8_PMUV3_PERFCTR_STALL_SLOT				0x003F
>   
> +/* Base of the common events reported in PMCEID{0,1}[63:32] from PMUv3p1 */
> +#define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE			0x4000
> +
>   /* Statistical profiling extension microarchitectural events */
>   #define ARMV8_SPE_PERFCTR_SAMPLE_POP				0x4000
>   #define ARMV8_SPE_PERFCTR_SAMPLE_FEED				0x4001

Reviewed-by: James Clark <james.clark@linaro.org>

