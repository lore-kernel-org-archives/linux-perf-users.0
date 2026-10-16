Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D43B8934
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145928; cv=none; b=RPJbJbMO/H+TdhdtGZucJ8jknkt1d5AzsFzsh7/NY+cEhOk3mSkpO7Szc5Xwo9VjI0Un2DGV3eAEGMSZPRHjXi7r83ocimG+4Wv9jldrYE4atjVigZHYwwiydG+VIo1uA8aGAEKuICFRiUTyTAE0XK04n5cqSK+qzb+Bj50wbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145928; c=relaxed/simple;
	bh=6onorTA5PXcJrAXKR3Hn6zgV+Bfs5ZKHKp1+lfVDF7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XX+Lncy0FuGFk39WyQ+QZPC5hSATmuMpEkPqV6dqlosLycqXoTcDBrciF9v6mn3QND6kApJaBEHJebEOThEn6ujxXJU9G9gIMKfJZu9V7YcB1PC+jWhRZLy76kxyHEDV58in0mgI3CemSkuPWulZx9wf4XzdwospdjuiY7aocBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SKyfp8iR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKyfp8iR"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df8fe8513so1300279f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792145925; x=1792750725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+P33/sA4gGKMdrtPonMZZt7DDO16tTuj+Ea0EHreBIs=;
        b=SKyfp8iRYFSTgUUM+8FTFeiF9Dmp1OCI/z7Du0xtozwkPQz6r/cNwWnblugjdoPsBF
         eaNlr6UQci/ZPlQk3or9XlQeJGKM0ehopAr+88xljdDeIRtT3CPuyAYkyQceUTycK9pY
         CU/jB9E5gHOMBHGSbaWhmqBZnYkgWGKpohCY+2u8zjGlVdtVlEAHOQV1BWo8q6Rbfi2I
         H/IffGmIcXoGKrcgWg7IT4cgL22kb60XQLRMP3JqxwNoXstBFe4SKDJZpS+M31Rr23dW
         wa4m7vIX9rFzzMQTW7zqTFnkDIBw+BFgZwZeuM1NaiErLavZ+sl6M3EpGdTp8ZkXb4ip
         HEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792145925; x=1792750725;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+P33/sA4gGKMdrtPonMZZt7DDO16tTuj+Ea0EHreBIs=;
        b=J0MwNjzQ2LCUjI4qmiqkrm0YGlj2aaOHjNUi4mfqjJQc9S62umGj/yXXu5nLa75nN2
         sgSAEo39WyyYLPL/MxZdT01T3VpIXtmVLQCS4eO4JVtRz+UYK2ETaEo42HOagrKl8fLO
         l7Re4X08R9MPlEAMIGpJKobqkxyLoImMs0UlYj3kUwmVENEyhD7o6mQgRBxXQc/DAkzT
         xD85jcO+V2cdZKEw702HGdfnaHxkBa4SgB12pK7FSHSTXzhqMLVTMCO58W+Mt8yXtqPZ
         zqcOzorS3f0Iie4NODnd1218SipXwSwuHF4qxU1Cnx7eoc0sLL1tn0GfOcwd4cHLa5+n
         2Hsg==
X-Forwarded-Encrypted: i=1; AKwUvBzlW1lXROLkwGq4SdACZgpf5TjQCiJN+6lrxp8Tb28MXmnfky5PlwsisepZZoZTfTf8VFXwg+Y8HwB/c6YncYm9@vger.kernel.org
X-Gm-Message-State: AFq9FYL+64iE/l7j6uYwbQP1nTL+oY3gSxxZwRO+kXrtvk5mkqeSJP8t
	huSdCJTWhRialo0mpJXlSBfCvrXJm703GzVnq8L/CNXe63CdzUaaMQkPn8xNqnNSFMIKWJUf7UA
	+2DfIBHk=
X-Gm-Gg: AYBFou0hjNdQEXrWs5LTdiUuDAeztK1d/k7mpW/R+uIgbzQPbWLeDvyFbYtrsYGVFQL
	sBE6MZgOGPo+WHTgLnTkCpea5jEeES45KklG4SHOPblNvVZuqzDAYg+6o6/vgnT3kBjqbmqWI9+
	HxMRQD1hoTF2l2RBacSLCCafoaPPNettwSeLgvuiH2FTb/ooFFVrhFs7585hphfS9euQEDFZCLF
	YP6j7BBLSP3wflGM+Qq5iwxLGA6B4l/K8OJgDS8miD8bxm0rnaTLM9dRL7wfXEtdwu4ridYoJLe
	U206gU0HIlKBEbpuAI2cPx0TvKIaQCtmAm/oL/J+CPogu19C753lWD+ISmrQ0xYQooiR76wIlHC
	DQPJOVempJRETJYt2e30/HfJGgAJtUlYf6EW9Rqgxu9VRDmSoENKyTOdjgzBVLaoGmPtyhdTmgV
	HxvyyJS6f3edD29kKu5xvrUgyrRmUt1cIISuFYSbVYkMUsjdKtitk9S+DhNsNupf8WrpF/ifXTR
	oI=
X-Received: by 2002:adf:e195:0:b0:48b:123e:2f5c with SMTP id ffacd0b85a97d-48dbaaed96dmr43622879f8f.29.1792145925501;
        Fri, 16 Oct 2026 03:18:45 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfe4d2321sm3840867f8f.19.2026.10.16.03.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 03:18:45 -0700 (PDT)
Message-ID: <53999f08-bbfb-462e-8521-383aba65f2a9@linaro.org>
Date: Fri, 16 Oct 2026 11:18:44 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] perf: Order SPE and TRBE padding before publishing
 AUX head
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20261015-add_barriers_for_perf_aux_output_skip-v1-0-5847d0578859@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261015-add_barriers_for_perf_aux_output_skip-v1-0-5847d0578859@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/10/2026 16:51, Leo Yan wrote:
> SPE and TRBE write padding into their AUX buffers before advancing
> aux_head. Add the missing write barriers so that a userspace reader on
> another CPU cannot observe the new head before the padding stores
> become visible.
> 
> AUX producers must make their data visible before publishing aux_head.
> The required synchronization depends on the trace hardware and CPU
> memory model, so the barriers belong in the drivers rather than in
> perf_aux_output_skip() or perf_aux_output_end(). The TRBE change also
> covers padding inserted by the overwrite erratum workaround before
> perf_aux_output_end().
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Leo Yan (2):
>        perf: arm_spe: Order padding before publishing AUX head
>        coresight: trbe: Order padding before publishing AUX head
> 
>   drivers/hwtracing/coresight/coresight-trbe.c | 2 ++
>   drivers/perf/arm_spe_pmu.c                   | 5 ++++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> ---
> base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
> change-id: 20261015-add_barriers_for_perf_aux_output_skip-70356815b2bd
> 
> Best regards,

Reviewed-by: James Clark <james.clark@linaro.org>

