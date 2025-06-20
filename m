Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E08632B
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410861; cv=none; b=W6DZ21sIY71UGmaw5Spf1G/FvJkBkUJYtNrnO7KtZp8F4odeECK53olCfDPygVtfsMd1jX55CMZSTELxdVSXOqIT2ST1lKw2Y7jAfyIoK0SfQaKlElL6gwJJgf3ye5XjgePPE/2MQnvi0qwKl020TlfOcZDyb5fcNCmcNAKgZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410861; c=relaxed/simple;
	bh=6JQhvJalxPVuJ0BnHyAK8SD62QRtStxgHN38B931quw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxCtmao4iu80Q5QsJgzlq95LcO2JbwYRIb03KkYdIz672A5l7RN2Bt64547eFqBbuUN089bm4ksseYvHBxgrRwYsDIcpahyzt+bRNGKcGNL2lKiLR15n7BX4bbWeY/ZPNnJCjzmkepqTigXi7elVf0d5Qm+14AV/m0jalZ7Xcik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v3iCoryz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3iCoryz"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54700a463so908319f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 02:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750410858; x=1751015658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkG74FvNfOLpNfRvSKYgtkPO/d1EcdAB8iHKOo6KSN0=;
        b=v3iCoryzgjVFUD3DaRa/b6Cl2lbJvvhPt2pIrc35Y1vJE4QsquZFC0oCqz4OEBQYZu
         Mjemo/Lf5zhMJh+Vzm1k78xRVmY05QOY1dKxIQrGKKW/Fe9iOHNFrx8fWQNRDUbZjc2/
         ng/w49S3NRe6Ay/OsGCHiRnOUnhKmGYQgaYejXlXlBf/+ZeDAY7XUTLx/1Pb9reg0+lW
         WGaa43o+8oz+NM8X+JRFotyENAqmGP/BRTw1AmP5xi8UIiPE936pC1VauO0zT0rClI+S
         2I8rjNqANuBoSaC6xQKERTiOvLTbYIN7IupLnEDv+RA6dEfOXbTAK3XMUgj1lUZpix/+
         /6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750410858; x=1751015658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkG74FvNfOLpNfRvSKYgtkPO/d1EcdAB8iHKOo6KSN0=;
        b=gxvDY/5n0av5vvdffA5ggD6b1rrJKlMxMgid7oH8Q6OAxT857AAjSjZaGdk2zei2rH
         /0GzJZEVW9ZpIlfg9i0s3OIJJFDQj7G2OENCJWdQ8a8tMLIGORviiom/LoK3+hMExt4D
         GOO8PxBs6Y0R59/dprgJhywhYoblQYMqLa5CwRl6/vu1UaWCE4iTk7eYZ9ITYS7xaQg/
         EG0GDroA0rHqzBQLS9WCYMV1Gui+WDlLmWln7Hms81adPmX4H2Ebfby4HOlSA/Wm+xUY
         E+zlHmorv4LFX5R7Mf6G0TlggTiB6fnTT9uSBIiy06zxGgdGLNzmN2OdFsxQxDKcMjQT
         Hx5w==
X-Forwarded-Encrypted: i=1; AJvYcCVEKgAyzAm6DtRIv5amEJrkr6EfRCv+jcIo+WoK/Gx8Z4FLLZ8JSItlCFOolvQSMykGcM/WoL7tzPQnWy2LbUnl@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlgSpuIyACbT0AIp1wgRAJjLn4FptH9xabU2bf03rHkkgJ8xX
	Gmsx8gpysQdrUfVqhIRPF5dCcLk9n0vRN5wJ0mwjHHb0ClTkWW4U7v8z3hLtygU5f/RRrWl2lP7
	7ZKii
X-Gm-Gg: ASbGnctuSoWEKYMWhdU/+qnkjQnkiI1z6MABNpbXbCUNnZJmSj2z3+1g46NIIGzs4C+
	nJHhkCB+p964PTCbyJEUB/ua9fG6z6vype33dZtSpXCiv6c7R574Hdo8r+6VL5PMitL3vDAOsaW
	tGCWt049VDKeIZtcrJbAqPCjq3MfMuVAEVfrACEon4TqEi5b2u4TRQOBqUdSAULY8Iyh/pAZNyu
	nzCAIF/3LAbrwFXejKNLyCDNeugJRahytp9WuwcEgzKxJRZLE79JDF2Smxviec7GsuDJo69s23D
	sohISB1NrcTyVv0ilmnJ6dXeVbzOSECMq3XNA3kLPbupLWWOUNI+77tfvXFOafnAei4=
X-Google-Smtp-Source: AGHT+IFKL0Lwu/AoRawLPYKXiHmyoNk4t+vpv6fI8ZcV2OBtE6y1UF0PxzrsPMtN5VlkolXwQudCag==
X-Received: by 2002:a05:6000:385:b0:3a4:eee4:f73a with SMTP id ffacd0b85a97d-3a6d27e1f37mr1340801f8f.22.1750410857643;
        Fri, 20 Jun 2025 02:14:17 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f1ac5asm1566405f8f.33.2025.06.20.02.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 02:14:17 -0700 (PDT)
Message-ID: <5d44e8b6-ad48-415a-aed6-4c59fcc228b8@linaro.org>
Date: Fri, 20 Jun 2025 10:14:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/headers: Document PERF_PMU_CAP capability flags
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, Jonathan Corbet <corbet@lwn.net>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20250618-perf-pmu-cap-docs-v1-1-0d34387d6e47@collabora.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250618-perf-pmu-cap-docs-v1-1-0d34387d6e47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/06/2025 8:08 pm, Nicolas Frattaroli wrote:
> Over the years, capability flags for perf PMUs were introduced in a
> piecemeal fashion whenever a new driver needed to signal to the perf
> core some limitation or special feature.
> 
> Since one more undocumented flag that can have its meaning inferred from
> the commit message and implementation never seems that bad, it's
> understandable that this resulted in a total of 11 undocumented
> capability flags, which authors of new perf PMU drivers are expected to
> set correctly for their particular device.
> 
> Since I am in the process of becoming such an author of a new perf
> driver, it feels proper to pay it forward by documenting all
> PERF_PMU_CAP_ constants, so that no future person has to go through an
> hour or two of git blame + reading perf core code to figure out which
> capability flags are right for them.
> 
> Add comments in kernel-doc format that describes each flag. This follows
> the somewhat verbose "Object-like macro documentation" format, and can
> be verified with
> 
> 	./scripts/kernel-doc -v -none include/linux/perf_event.h
> 
> The current in-tree kernel documentation does not include a page on the
> perf subsystem, but once it does, these comments should render as proper
> documentation annotation. Until then, they'll also be quite useful for
> anyone looking at the header file.
> 

Reviewed-by: James Clark <james.clark@linaro.org>

> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> There may be more perf documentation patches in the future, but right
> now I'm focused on getting a minimally viable driver for the hardware
> I'm working on going. Documenting these seemed to have a fairly good
> effort-to-future-payoff ratio though.
> 
> I Cc'd Corbet in case he has any input on the verbosity of the
> kernel-doc syntax here, maybe I'm missing something and all of these
> could be in a single /* comment */, but as it is in this patch doesn't
> seem too awful to me either.
> ---
>   include/linux/perf_event.h | 74 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 74 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index ec9d96025683958e909bb2463439dc69634f4ceb..7d749fd5225be12543df6e475277563bf16c05b1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -294,16 +294,90 @@ struct perf_event_pmu_context;
>   /**
>    * pmu::capabilities flags
>    */
> +
> +/**
> + * define PERF_PMU_CAP_NO_INTERRUPT - \
> + *    PMU is incapable of generating hardware interrupts
> + */
>   #define PERF_PMU_CAP_NO_INTERRUPT	0x0001
> +/**
> + * define PERF_PMU_CAP_NO_NMI - \
> + *    PMU is guaranteed to not generate non-maskable interrupts
> + */
>   #define PERF_PMU_CAP_NO_NMI		0x0002
> +/**
> + * define PERF_PMU_CAP_AUX_NO_SG - \
> + *    PMU does not support using scatter-gather as the output
> + *
> + * The PERF_PMU_CAP_AUX_NO_SG flag indicates that the PMU does not support
> + * scatter-gather for its output buffer, and needs a larger contiguous buffer
> + * to output to.
> + */
>   #define PERF_PMU_CAP_AUX_NO_SG		0x0004
> +/**
> + * define PERF_PMU_CAP_EXTENDED_REGS - \
> + *    PMU is capable of sampling extended registers
> + *
> + * Some architectures have a concept of extended registers, e.g. XMM0 on x86
> + * or VG on arm64. If the PMU is capable of sampling these registers, then the
> + * flag PERF_PMU_CAP_EXTENDED_REGS should be set.
> + */
>   #define PERF_PMU_CAP_EXTENDED_REGS	0x0008
> +/**
> + * define PERF_PMU_CAP_EXCLUSIVE - \
> + *    PMU can only have one scheduled event at a time
> + *
> + * Certain PMU hardware cannot track several events at the same time. Such
> + * hardware must set PERF_PMU_CAP_EXCLUSIVE in order to avoid conflicts.
> + */
>   #define PERF_PMU_CAP_EXCLUSIVE		0x0010
> +/**
> + * define PERF_PMU_CAP_ITRACE - PMU traces instructions
> + *
> + * Some PMU hardware does instruction tracing, in that it traces execution of
> + * each instruction. Setting this capability flag makes the perf core generate
> + * a %PERF_RECORD_ITRACE_START event, recording the profiled task's PID and TID,
> + * to allow tools to properly decode such traces.
> + */
>   #define PERF_PMU_CAP_ITRACE		0x0020
> +/**
> + * define PERF_PMU_CAP_NO_EXCLUDE - \
> + *    PMU is incapable of excluding events based on context
> + *
> + * Some PMU hardware will count events regardless of context, including e.g.
> + * idle, kernel and guest. Drivers for such hardware should set the
> + * PERF_PMU_CAP_NO_EXCLUDE flag to explicitly advertise that they're unable to
> + * help themselves, so that the perf core can reject requests to exclude events
> + * based on context.
> + */
>   #define PERF_PMU_CAP_NO_EXCLUDE		0x0040
> +/**
> + * define PERF_PMU_CAP_AUX_OUTPUT - PMU non-AUX events generate AUX data
> + *
> + * Drivers for PMU hardware that supports non-AUX events which generate data for
> + * AUX events should set PERF_PMU_CAP_AUX_OUTPUT. This flag tells the perf core
> + * to schedule non-AUX events together with AUX events, so that this data isn't
> + * lost.
> + */
>   #define PERF_PMU_CAP_AUX_OUTPUT		0x0080
> +/**
> + * define PERF_PMU_CAP_EXTENDED_HW_TYPE - \
> + *    PMU supports PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
> + */
>   #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
> +/**
> + * define PERF_PMU_CAP_AUX_PAUSE - \
> + *    PMU can pause and resume AUX area traces based on events
> + */
>   #define PERF_PMU_CAP_AUX_PAUSE		0x0200
> +/**
> + * define PERF_PMU_CAP_AUX_PREFER_LARGE - PMU prefers contiguous output buffers
> + *
> + * The PERF_PMU_CAP_AUX_PREFER_LARGE capability flag is a less strict variant of
> + * %PERF_PMU_CAP_AUX_NO_SG. PMU drivers for hardware that doesn't strictly
> + * require contiguous output buffers, but find the benefits outweigh the
> + * downside of increased memory fragmentation, may set this capability flag.
> + */
>   #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
>   
>   /**
> 
> ---
> base-commit: 31d56636e10e92ced06ead14b7541867f955e41d
> change-id: 20250618-perf-pmu-cap-docs-a13e4ae939ac
> 
> Best regards,

