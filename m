Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8A5187DD
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682852; cv=none; b=ZJo/BAmwsgwgmCyNu+8ZagmvcW5RaSxdWaeKcmhRCOOxWy/2G1PtJ+R+kZKP6GFRNlanvhTs5ehRspuX+cL7ZrPojYXkwT9gSym+/GhAz6dUDHjKvSiMWninwjfR2UG0eEX4dnVtTAHl2Eq/bmnoINqkiwwdLJTbCG6tv3iNxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682852; c=relaxed/simple;
	bh=6sziIVdTu4ZPVOjNw6ZKDgiA/Sqd6hn3LEOmfZ9gpBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RI+bym300eB3yrS5rrDD3GFC/1BiQeCYZEUD87RZGPfkZwI7pfighnxE567bwgeKOPRMVrRQ4R7ga8YoJEzPs39NeExu6yRb6OC6Ej1Cpq7kqxvM4goteBiE80vNu1I+BrK/WezXIkCh+dm5rEa2cyzXjZIQ4OXmE90/B4EOknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cFnD2yCT; arc=none smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cFnD2yCT"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac768bda6aso3360433a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 04:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790682849; x=1791287649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c84a9eMo0Dm/JWepc2tnRlDWvnvh5DqhzAwWVPo2EM0=;
        b=cFnD2yCTEuYHI4SMsphhngDTAkQO+fRn0xwOYR9HOwfhj2woeS3yPUW9XdpqY9gvWn
         hdpjOrmmghQWOVHvU4AjJXnxvJKtht0IV6zyosG0wEYrGfzsPmsPHUm3sr2SZJTS7em9
         hKeE0v/tEJHr6ecjVVfOUQHpMxXHcpCaPs8e8/f8b3yB8UPdjJxY3MQOpNqD53M018gS
         vE+MF2t0pwylxnEARYETbgSh4FaFm/0fNSIccYrzWs1Tc/aqRB1tHN59gdb9EHPYu8Oj
         5ATCHWMvdKdEKr0qzXvZtCZoAL6DqyI+DIkHujznFeqAXU2hNlCcbITyAjKL3Qxm7rXI
         /ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790682849; x=1791287649;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c84a9eMo0Dm/JWepc2tnRlDWvnvh5DqhzAwWVPo2EM0=;
        b=0Bpsu1LX5nFbq/JAChK4N13d8dhCbZ1ujlrLMqs7rqSYhdOkECO6u3ryQlntFHT0sO
         lqGwxbtJ9McxnigPDRSJsOVcPQSeFxZuuexB62kPRIB6+4T+33iKNMZ5ndElfRkqdYq+
         CkRM69B4IgeMXkHVlymdwXEfFSGQFyiEOtOdKgtvYP3v+J7CviVPj+2hJM42ujIwsAXv
         C7Wdi/LaIrg1iypoEnhe0yi3mdPr38JaRTEQmtf8QIBgyWb+ecQRyGeOxZEGPmS1iV/C
         Z5Vd0S9Q0ugeGUxuaC+iOSImV74PLl4prxP/oLauoeGYYtYkNgMClDhja+X3STAja8r0
         hTOQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0A1q1ggfRTmw7HZyB9oJ7cKLcjOAb256g2WoV9b7r8sqW7F2nbOzH+FhMt1NqnA3PjQjZXTsjBofzwgSc7G+b@vger.kernel.org
X-Gm-Message-State: AFq9FYKpUrGabPpTpgnHiFWzSEXQVGH1dinORRqHPOmp5FVaTVggGHqP
	II/3HfJ6C328FTWU24Y2nkm2YWrOGKgV406eFre6l6gpGZ3TTfDQOiQkHbNbiUWqrT4=
X-Gm-Gg: AYBFou1s2JaAuDlKzY4uf/GL/+nRlOjXrARYWydDNyT9NUN0P5TFzWR9Ne9+3HKTO5N
	zL5CQlYGOYGCZA/Q9JO1Es/odrXBTCygCkvKHmwU6wL/hdjQvU36h7kHL76tyatJZv3F/7Y8p7+
	9GkSvcER5m4iP17tWO6vtqc2ck7dgwR18GKL1+N6v9oE7lRDU+1ethROioJ3rygGnOlA1SSkeHf
	j5DWqDCwkhsmEvAD4MMjeq3rqt/iuhN3dErtUI9P+KNa/jRPKFKe9+QS8o6lcI6qHobp0svNDuv
	8igdao1jMidrollKCvk0EaTq8oavlazQGVqgv74MiaBk7C461kEbMfFwwZQR8/TWvvN0MukYC7h
	8LQel+xFvZXCR9m71rnSmWBm7Rb4+88m0Wlv/zNqVglwf4/sF2/c5ypE5obHbjY/VX5pQbt4fMY
	krBzv4ZS7LHpoCuDQhqLWbfCRCbkXfpjeMlQeGYPuP8/QD8gj9W4KSOtBJpl8HDK/2RsG408UoS
	s8=
X-Received: by 2002:a05:6402:27cd:b0:6aa:f129:b193 with SMTP id 4fb4d7f45d1cf-6aaf129c2ebmr9300291a12.22.1790682848790;
        Tue, 29 Sep 2026 04:54:08 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6acb9048ebfsm707949a12.30.2026.09.29.04.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 04:54:07 -0700 (PDT)
Message-ID: <50a0338e-e395-407c-bccd-cfb90f113e58@linaro.org>
Date: Tue, 29 Sep 2026 12:54:06 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf arm-spe: Add Neoverse V3AE data source decoding
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kieran Hejmadi <kieran.hejmadi@arm.com>
References: <20260928-perf_arm_spe_add_neoverse_v3ae-v1-1-738c9ed12d31@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260928-perf_arm_spe_add_neoverse_v3ae-v1-1-738c9ed12d31@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/09/2026 17:12, Leo Yan wrote:
> Add all Neoverse V3AE revisions to the list so the common decoder can
> populate the memory source and snoop information.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 7805a1a98a89a2853ad02ee7751472eddb1054ed..8d95df23be6f654caee77e9d155af7ebf5129c91 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -626,6 +626,7 @@ static const struct midr_range common_ds_encoding_cpus[] = {
>   	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
>   	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
>   	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
> +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
>   	MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
>   	{},
>   };
> 
> ---
> base-commit: 0ae6fc78c5ce0dfd18d8712a50f0fd4602eff103
> change-id: 20260928-perf_arm_spe_add_neoverse_v3ae-917f280b2c7c
> 
> Best regards,

Reviewed-by: James Clark <james.clark@linaro.org>

