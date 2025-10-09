Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5C155C88
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003149; cv=none; b=uCTauX4Jami/dUGKjN1DQUZZhmHCAGMBpJGLPbHBgTn4G8eeRISUJ8Vj5Qddz2Qv4IS5eC1FeSfBIRtFbXgwEMqy8aTYFvGUdyzyi80+TRN3bolySCSK06hUUIgSARBq6Dr35bf42EcwhCkUAOYs3dZJyEBxvet/29JqUJqnmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003149; c=relaxed/simple;
	bh=mLkK8BzxucfL9Fo0aRjtq+K0NhV/IjS3WSJEbfX1Bfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1dTaKyNw6mubaZ+vDkOyKH5MCS1vhw2dGuZv02ThdRMoPiDTp/qI6lAa/8iiBrik0ja+SoO599M07gZouTaFNQfz+AK1vPIUowZCeJ3tdK1aBuCCFb8Zta3EkhLDEjQhjd4lcXZToQzYsaVPJh5UhUjKYdQNkjfIqnJpmL7H7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VH0iGOCe; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VH0iGOCe"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee12807d97so855326f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760003146; x=1760607946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5exwWNyivwXxEPwEj99l0gvTi8WW71D4LDWKxhJVjg=;
        b=VH0iGOCeL5FYKpU6TrwBqeW7igzEIvKWA53mz8PqN755fyBD7uXTZjWoNJ7f9hrrEw
         wimGTLwjAGhbWteV7Jvnjnj9c3CimKwLjgf6X8MpGk1FPa1dzcrT8gjn/u2DSBHUzyFr
         KvSyiuQTxvSbclRj0XTx/taMIvtyFR4kfEda+iZ9hVnD/2c9FDJ4CxfgJDI7qEsReHuK
         i8d31tG2l98ad0OxG7nqZo90Ovi2stpDrhEkTRCjaXkFHFXK0p/kE+o/OAfD4B/9Yjqk
         C3i63LWywfJKWHrGamghcIWR/EWqUzl+93oZ++fFeKa9EKi31qLBVM0lGo5lPEX7y8pW
         DOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760003146; x=1760607946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5exwWNyivwXxEPwEj99l0gvTi8WW71D4LDWKxhJVjg=;
        b=JBnZxr53UyqwhixEblIbMwv+ZkaLJEOEN7LdHFCMNGf36fQzKi0HyElREzVbdjo6xD
         eRf6nkYw4Nkp68Nm4/aqsErX2RL//wQ9Ok0fqpcVgfMXiZiXT+rGmrvXLloedwhQmzYH
         65R156vqVCOzlKrHrPypPupiH3tJaaXmsu3szofo1aXnV3qBvwYE1nL7zombAHsohQdK
         CVYOfwN5OnXH0Hi/R49M58ernIIG/NldVRfT7ilts1GMXT0DyosmtrtINo+uBSMXdyiD
         bO8mJD1hHPYZMNliEC5A9yPvQUL5V0XjYsfljYQQYSv6eK4uI12wc61+0eQCG+QVbQ0e
         GiGA==
X-Forwarded-Encrypted: i=1; AJvYcCUsKy7K8IUFT59OtMj7+6QEW+dZ9TYT2njSKLqWOG/KSNjkRt7kpKsw2nRg/0AuzPxyeenhz95JPYbR86pC6w0w@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmoLpJ5HQwQ92TE69/TS0Q7Ldk5njDBZ10Zg2D6bs9Avr2QRb
	5JIbAIFUTpZvNiYALXze2zrtI16AMtH5nd88soYhlylZNbrX7QO/uE3Md4tdjYbyo9s=
X-Gm-Gg: ASbGncsJVCjIx5Tj3693RSgAjZbUKOymhsb0tDrv76SB5qzOFWqTsMsb0NP2/wZAxBn
	OIdcO6163uZN6/CpTDXVidasZ8GKRZnIWJ0H8WlFPQj5/DXG2kyhTNixYfAnQfmfe///f0JoAeK
	AQcepCK20m5HQ+oaidg8dHCRf3Q6ytS+ClT35v59wxa9kbDzyN5gONF6OcuRL51v3YdFkbXK7Yf
	WQxZoNPPGXv5X0mLIwVumE0pcRBWz33DvLHEkfec83dhIw4tJ665YcT85WrEa8gOSKQ2K4CTI/M
	aP2BpP9SkInL9nqqI9tlBWbjE+hsS+bfk94zERmCzN9jHOb3nqVYszQ8dTOtwBjyr7EnRSs455Q
	cqt67vNrECkGNy8pOy0VwloPvBNpXB3qI0HRm6fKrTU3zktpTPEqcyOrW5s3Ox+URkz8=
X-Google-Smtp-Source: AGHT+IEuXY7MXWFObfOK+QblA+xufcpRh5i/X3Iuc1VjgyYalpax2gpUt647nv9NMhwLnsjpZk83TQ==
X-Received: by 2002:a05:6000:2484:b0:3ec:2529:b4e5 with SMTP id ffacd0b85a97d-4266e8f8008mr4842482f8f.38.1760003146040;
        Thu, 09 Oct 2025 02:45:46 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf1841aasm37389825e9.18.2025.10.09.02.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:45:45 -0700 (PDT)
Message-ID: <07902090-801d-456d-bcaf-5f3b2254564d@linaro.org>
Date: Thu, 9 Oct 2025 10:45:44 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/25] perf arm_spe: Expose length for SVE and SME
 operations
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
 <20250929-perf_support_arm_spev1-3-v1-17-1150b3c83857@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250929-perf_support_arm_spev1-3-v1-17-1150b3c83857@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/09/2025 5:37 pm, Leo Yan wrote:
> Record length for SVE and SME operations into records.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 3 +++
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 9e02b2bdd1177193996d071dd88f969e25b1ad86..82e3053131db62603553bd092388879ce9a9bcd4 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -220,6 +220,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>   						decoder->record.op |= ARM_SPE_OP_ATOMIC;
>   				} else if (SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(payload)) {
>   					decoder->record.op |= ARM_SPE_OP_SVE;
> +					decoder->record.length = SPE_OP_PKG_SVE_EVL(payload);
>   					if (payload & SPE_OP_PKT_SVE_PRED)
>   						decoder->record.op |= ARM_SPE_OP_PRED;
>   					if (payload & SPE_OP_PKT_SVE_SG)
> @@ -239,12 +240,14 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>   				decoder->record.op |= ARM_SPE_OP_OTHER;
>   				if (SPE_OP_PKT_OTHER_SUBCLASS_SVE(payload)) {
>   					decoder->record.op |= ARM_SPE_OP_SVE | ARM_SPE_OP_DP;
> +					decoder->record.length = SPE_OP_PKG_SVE_EVL(payload);
>   					if (payload & SPE_OP_PKT_OTHER_FP)
>   						decoder->record.op |= ARM_SPE_OP_FP;
>   					if (payload & SPE_OP_PKT_SVE_PRED)
>   						decoder->record.op |= ARM_SPE_OP_PRED;
>   				} else if (SPE_OP_PKT_OTHER_SUBCLASS_SME(payload)) {
>   					decoder->record.op |= ARM_SPE_OP_SME;
> +					decoder->record.length = SPE_OP_PKG_SME_ETS(payload);

These are all assigned but never read. I'm not sure if that's a mistake 
or they're just there for completeness. I don't think there's much point 
in going for completeness unless it actually makes it all the way to the 
user though. It would be better to leave it out and finish it another time.

>   					if (payload & SPE_OP_PKT_OTHER_FP)
>   						decoder->record.op |= ARM_SPE_OP_FP;
>   				} else if (SPE_OP_PKT_OTHER_SUBCLASS_OTHER(payload)) {
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index d4574268cf793efe154f252b3e2af9c721bada97..b9288cd774bea2534d9991213c942dcbaf2a7232 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -122,6 +122,7 @@ struct arm_spe_record {
>   	u64 phys_addr;
>   	u64 context_id;
>   	u16 source;
> +	u32 length;
>   };
>   
>   struct arm_spe_insn;
> 

