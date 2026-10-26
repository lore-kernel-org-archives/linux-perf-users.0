Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008263;
	b=0CYFbI3evIKSILqIIKJiK8BY4mZDaIPpZ/UEQKNwwM4OHE7P9qvfAL+7UWQBw+E+PCz1
	 TB6PdIOQtQ7NxgtrQ6+69ak9nXEe7yq+t/SFcIjqTRHKNEbxNhAu14eegU7i0Z+jUj0Cc
	 Ov0Gf8rnBsQa87vixl+PLyU/Z+WcsyburRjj6lfzf/LCzc9Dfcin+KXAmHYEx+9x+mu/N
	 vsuoAktXFcqluuBPCzau6O2U2iKlvnpftceCwVedAPIq7QKf08dzCJnXqzx1/38DlxZOY
	 wzPuehOu32FWxZS7ZT+5eZxr0jaf4RUNWk8GAKJ39Rtd7TgNbAMxXVNLYIdOUJ/TdQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WY39dyeqsgK86vcC/6EADKb5rGDw+mM3bQAPuS8Ym0k=;
	b=xdGkDcLDw03ySW4YuOYfm0lrfv4srKGWLMR140nt/HiR+ynj7WYJALtaizLqZ1eIDQsN
	 v+TihsZwg6SdgummZUSYjQ71zjq3HtsdMKcxshzcdd6R1BczwMPB8/ApM9IXzda2XRy3g
	 37jVLdaFcuq0jDS1n3IsMacn1bEkPzGT2akCvM5Vd+eUiX++ud+ffYMR/Yxmz+VxgRyKp
	 CANxYXfWuuKGX40GYMrlKA/Pf1GIFvjKFV1t0vsuDnpOR6sA4lUywi3JEqVwwFDo8fSG0
	 cYScU9IlOJx98VMnRs7TvDS6st4jS+1hLvzQJmU3ZA2C7cs1497GcU60r3KOeYR9lQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yGoSVEyI;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32C606A324
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 09:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C32C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yGoSVEyI
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2385474f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793008261; x=1793613061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WY39dyeqsgK86vcC/6EADKb5rGDw+mM3bQAPuS8Ym0k=;
        b=yGoSVEyId6A5oJxom0U6sRuPXhyhJ+tCjjveCV24rOOBxCBzkMZj34tMy2/GJOx8I5
         VpAg2uZ2TkNJWfrZlfsKnIlDqcYKmtdOIgbUaf/h5uiVT+wFkEhLVmXvVvz12zBi4Q6s
         1uC6yyrnh2OM/tmwelKv7OMiyxQMz9QB02BW63X1Lae8t2fopJe74OlVmc3UtgYDwo4V
         yn831Rgz1UoJp3u9MydmG0ONAPRcKY07MD5aZkHB+8mw9g7W8gqKngFLiAgpFa+6GNGs
         474yNNfmFuQxETpF/TbKTUKOGqroy+3CajJhIC0ynRwZg0mYxDVM3kb/M7FheKAV+x+P
         MJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008261; x=1793613061;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WY39dyeqsgK86vcC/6EADKb5rGDw+mM3bQAPuS8Ym0k=;
        b=DK8aICskvqTA9FsYX08igmFN4d84ND0CByeqpm99huJ4GDevhq9yXMQOnJ3fDU7Paj
         1v8p6WuO+WhCaUI/CYK2/gWSD+Dl7WjunOmyyv0RLTo+VYZ2Ud2gEj45QbPqFMy2VRFX
         0GTHsv2N2McQCHUQqzPGXtZnQ/nEuSUIsAe+r5eEhFkBn6me8o1R3WyddZ/bCi57Is1Q
         gZk+5rrTzAYKVPGDYQdB5SV8wWLOw4d0KJJschCPVZ5TS97sO/y6iY9ZnsO8J+p1cBXu
         cT1FgJIZ2acbowpfda0LCyaN3I5EpDxxm7B4/coMC9wbSAr/6ylXGHX+22kRzcKIwSa7
         qkhA==
X-Forwarded-Encrypted: i=1; AKwUvBxdTZ1xcMgBwVN+hNlG4NPBAQ+wqpUZYmhtnTSbuDVzgOatO7v5/Ouj3CasJajF0ANbM1z/2KAVoy4+zvVvujZG@vger.kernel.org
X-Gm-Message-State: AFq9FYI7YonlyR0s1ehTeq8GylSR4uDlXp7kv6+EQr/dzp2iH9hjreLv
	7qjVSRlkjSavZesnI0X9e9RNWd6USwFBhI1gioEHkaKQMxm3yg6glOdZrQaY4G15EMU=
X-Gm-Gg: AYBFou3q7jmifGRifC9ORhhYnZQC/Ein7t2qafaC9OZGiu2ymJuemXZR2c1ksqqkCnD
	d5IoeK9yG833Fasrhms0f8vaiIxQs2yeuIGXiVzlMKe+F2+SaNvcK0rCU/1qW50FfMX6alvKlnS
	GsCMHOAWHUgQqzeI5PnIPGvUSi7BxV4qN6ipd+RhMPRaHapLPzcpJi1dwv8GLm2wNe+r3QmIxQn
	nR7jVfOjjrdD9RvV2XKJW+N574uu4Tp2d98fK/GJ8cmIf0BQoqzXX+1aL0Nx4IbHNOdcWu/cj8O
	TRtRPgYTBFYMJueiazErzy+qZHn3+Oecz6JdBWiBACtrFr3bexGHTkGCgNX532GEU6Xi0guUHua
	8md+axkz6Hu4ExTS5ec8SsQMycq/7/X1f683ZfW6SRe2GBE/Itkwh2rQVGB+xbatluix9kfbegX
	vf7E8sm5psQBHUhDHUqOiidtWXYrRRK8wTgCVat37gc8cUF6FkpDUuZ2VPSxW+gnR4EZ2AhKwwc
	qz+psLsi/lg5ib/syKuxhxSB2TALIKyJqdsOeNiW9RSeu6zxBgweDwp36x9IHaczCSOwPiRTaY/
	/2b6Ug==
X-Received: by 2002:adf:ec50:0:b0:48e:3b53:e100 with SMTP id ffacd0b85a97d-48e3eb9c57amr8289007f8f.56.1793008261337;
        Mon, 26 Oct 2026 02:51:01 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb90dsm14021561f8f.22.2026.10.26.02.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:51:00 -0700 (PDT)
Message-ID: <aaaaa762-e0cc-4894-aed9-b160a70e0ddc@linaro.org>
Date: Mon, 26 Oct 2026 09:50:59 +0000
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
Subject: Re: [PATCH v4 7/7] coresight: Add pmu_pulse/extout_pulse
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
 <02268c4958153f6d2e549e4bd7b93f11ed79fa90.1792989860.git.aaupov@fb.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <02268c4958153f6d2e549e4bd7b93f11ed79fa90.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/10/2026 05:48, Amir Ayupov wrote:
> Add ETMv4 configuration 'pmu_pulse' with 'extout_pulse' feature which
> requires an ETE whose PMU counts its external outputs
> (CS_CFG_MATCH_CAP_TRCEXTOUT): event 1 selects the always-true
> resource and drives TRCEXTOUT1 PMU event which pulses on every cycle
> while the trace unit is enabled.
> 
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> Reviewed-by: Daniel Pereira <danielmaraboo@gmail.com>
> ---
>   .../trace/coresight/coresight-config.rst      |  5 ++
>   .../trace/coresight/coresight-perf.rst        | 15 +++++
>   drivers/hwtracing/coresight/Makefile          |  1 +
>   .../coresight/coresight-cfg-pmu-pulse.c       | 55 +++++++++++++++++++
>   .../coresight/coresight-cfg-preload.c         |  2 +
>   .../coresight/coresight-cfg-preload.h         |  2 +
>   6 files changed, 80 insertions(+)
>   create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c
> 
> diff --git a/Documentation/trace/coresight/coresight-config.rst b/Documentation/trace/coresight/coresight-config.rst
> index 6d5ffa6f73471..3eed728bf0de1 100644
> --- a/Documentation/trace/coresight/coresight-config.rst
> +++ b/Documentation/trace/coresight/coresight-config.rst
> @@ -129,6 +129,11 @@ The following steps take place in the operation of a configuration.
>   
>   5) At the end of the perf session, the configuration will be disabled.
>   
> +The built-in 'pmu_pulse' configuration pulses ETM external output 1 for a PMU
> +event to count. It only pulses while the ETM is enabled, so combined with AUX
> +pause and resume the PMU event can time each trace window (see
> +coresight-perf.rst).
> +
>   
>   Viewing Configurations and Features
>   ===================================
> diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
> index 0a77741a431ef..6770a455c6b59 100644
> --- a/Documentation/trace/coresight/coresight-perf.rst
> +++ b/Documentation/trace/coresight/coresight-perf.rst
> @@ -109,6 +109,21 @@ Example for triggering AUX pause and resume with PMU event::
>           -e cycles/aux-action=pause,period=10000000/ \
>           -e cycles/aux-action=resume,period=1050000/ -- sleep 1
>   
> +ETM-timed pause events
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +The built-in ``pmu_pulse`` configuration pulses ETM external output 1 on every
> +cycle of allowed trace, and a PMU event counting that output pauses trace after
> +``N`` pulses, here 1000 cycles::
> +
> +  perf record -a -e cs_etm/pmu_pulse,aux-action=start-paused/u \
> +    -e cycles/aux-action=resume,period=10000000/u \
> +    -e trcextout1/aux-action=pause,period=1000/u \
> +    -- sleep 1
> +
> +Each window is about ``N`` traced cycles plus the pause interrupt latency.
> +The configuration only loads on an ETE whose PMU counts its external outputs.
> +
>   Perf test - Verify kernel and userspace perf CoreSight work
>   -----------------------------------------------------------
>   
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index ab16d06783a57..568e797ac5a17 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
>   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
>   		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
>   		coresight-cfg-preload.o coresight-cfg-afdo.o coresight-cfg-pstop.o \
> +		coresight-cfg-pmu-pulse.o \
>   		coresight-syscfg-configfs.o coresight-trace-id.o
>   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c b/drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c
> new file mode 100644
> index 0000000000000..61472154dd02a
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Pulse ETM external output 1 on every traced cycle for a PMU event to count.
> + * Based on coresight-cfg-afdo.c
> + */
> +
> +#include "coresight-config.h"
> +
> +/* ETMv4 includes and features */
> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
> +#include "coresight-etm4x-cfg.h"
> +
> +/*
> + * extout_pulse feature: event 1 selects the always-true resource, so ETM
> + * external output 1 pulses on every cycle while the trace unit is enabled. A
> + * PMU event counting that output (TRCEXTOUT1), for example with
> + * aux-action=pause, then fires after as many traced cycles as its sample
> + * period. Event 0 is avoided because it is the trace unit trigger, and the
> + * TRBE driver treats a detected trigger as fatal.
> + */
> +static struct cscfg_regval_desc extout_pulse_regs[] = {
> +	/* event 1: resource selector 1 (always true), drives external output 1 */
> +	{
> +		.type = CS_CFG_REG_TYPE_STD | CS_CFG_REG_TYPE_VAL_MASK,
> +		.offset = TRCEVENTCTL0R,
> +		.val32 = 0x0100,
> +		.mask32 = 0xff00,
> +	},
> +	/* end of regs */
> +};
> +
> +struct cscfg_feature_desc extout_pulse_etm4x = {
> +	.name = "extout_pulse",
> +	.description = "Pulse external output 1 on every traced cycle.\n",
> +	.match_flags = CS_CFG_MATCH_CLASS_SRC_ETM4 | CS_CFG_MATCH_CAP_TRCEXTOUT,
> +	.nr_regs = ARRAY_SIZE(extout_pulse_regs),
> +	.regs_desc = extout_pulse_regs,
> +};
> +
> +/* create a pmu_pulse configuration */
> +
> +static const char *pmu_pulse_ref_names[] = {
> +	"extout_pulse",
> +};
> +
> +struct cscfg_config_desc pmu_pulse_etm4x = {
> +	.name = "pmu_pulse",
> +	.description = "Pulse ETM external output 1 on every traced cycle for the PMU\n"
> +	"to count as TRCEXTOUT1\n",
> +	.nr_feat_refs = ARRAY_SIZE(pmu_pulse_ref_names),
> +	.feat_ref_names = pmu_pulse_ref_names,
> +};
> +
> +/* end of ETM4x configurations */
> +#endif	/* IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X) */
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.c b/drivers/hwtracing/coresight/coresight-cfg-preload.c
> index 4980e68483c5b..a9a60a1c40845 100644
> --- a/drivers/hwtracing/coresight/coresight-cfg-preload.c
> +++ b/drivers/hwtracing/coresight/coresight-cfg-preload.c
> @@ -14,6 +14,7 @@ static struct cscfg_feature_desc *preload_feats[] = {
>   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>   	&strobe_etm4x,
>   	&gen_etrig_etm4x,
> +	&extout_pulse_etm4x,
>   #endif
>   	NULL
>   };
> @@ -22,6 +23,7 @@ static struct cscfg_config_desc *preload_cfgs[] = {
>   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>   	&afdo_etm4x,
>   	&pstop_etm4x,
> +	&pmu_pulse_etm4x,
>   #endif
>   	NULL
>   };
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.h b/drivers/hwtracing/coresight/coresight-cfg-preload.h
> index 291ba530a6a52..0058627f65ae5 100644
> --- a/drivers/hwtracing/coresight/coresight-cfg-preload.h
> +++ b/drivers/hwtracing/coresight/coresight-cfg-preload.h
> @@ -12,4 +12,6 @@ extern struct cscfg_feature_desc strobe_etm4x;
>   extern struct cscfg_config_desc afdo_etm4x;
>   extern struct cscfg_feature_desc gen_etrig_etm4x;
>   extern struct cscfg_config_desc pstop_etm4x;
> +extern struct cscfg_feature_desc extout_pulse_etm4x;
> +extern struct cscfg_config_desc pmu_pulse_etm4x;
>   #endif

Reviewed-by: James Clark <james.clark@linaro.org>

