Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835429B204
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572765; cv=none; b=Lm6bRkK7aMa4g9XGcau65c/RTPhDDjRl2yS70FvU6dX42UFACM06b756T1m7Qm8m73kX+W3WBN26Ggi2FGTNmKONzvOqm9ZEOqssWgDlWIMtFpfKLEqb6w4I9mnGe6XjSFDYXLBZ0RQ3aZKtFiQ7boMliXvVeiHgm3WNtweFDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572765; c=relaxed/simple;
	bh=VI0rFppBVuytS3W6RrIkZ3jnHk9shm0DV6259lw8U74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9ZrHc6nCw/jC0yq+zz1/D20YQRPPBGqYYlo+6BvaZ1R84gc1W/V1VmS7AuOlgbnqQly3oklj1aa1396np7bICDy5OctZwa3SZIMPFjf3QNftgs2IVOHZXOJaei3yDwk4n+t1z0GyhELGbGK7CCrf79tnib8Nd1y6icJDFZtJqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pzUSw0EA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pzUSw0EA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso4654895e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 02:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766572760; x=1767177560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGutQ2IGqRhDM/icPB6/HEUq7E7+JBO991L3mBxgxLw=;
        b=pzUSw0EAwObRK4jroovErFM89XOQdEI5/t0rHNLrUi1XLAO8hV2No/RcJR1nImLd+4
         IRQFP41Zaaxtm5V0LW+qbsnnqDaswoQWU8bGMFshgA0RdMFJ48cGkNzmnGtKmULW83Lv
         5MxpJCVJVOpbta5PWkmepJPPSi/SriiTrz5wYB4YbR/QlAxGqIuZLSxFE+/nefblTAfv
         m3Wa7nyL4BGRCBvMasaB0DEB+nfxkcsUC5jMV4ZLzOYm+RxY3N2/VPBVaWrD8I+d6Gcc
         9F6RGdu9nWzzYAKg/9T5KPQ1aHmDIOoHlX7NAky6iEwoou7kv8x0+NImEnSKXC3KKiLv
         cw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766572760; x=1767177560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGutQ2IGqRhDM/icPB6/HEUq7E7+JBO991L3mBxgxLw=;
        b=hv3tzXMkJwRnq3oRBo7dCOuc6fRVKglezYv4BjLFa2KnZjsYUo6R54daCrh+QegVEV
         VJW83pi2ryTJvYTMMuZnCROGfOUmpJqvdhCD915U8gRMYPkSL+QoUTemMSF1Na+FoLMz
         ioyDTCEXobARIty6x7SpCH4mx3Vh6GyJudjJWIS/7EuE8fasfp3SatiLgDSQJj4yrcqt
         gc1ZZICHP0o5xKqcDRIx77qzDT7yp9W/mOywIAxxKilAkHga9qSEtwPeIgnicA5+Zref
         KJqE8CBqbDl7+cTGSlPDmOYhPBlw8B0V78OMUfrYgHUYgKBVX8HxZI2OOTmncBra2W7E
         S67A==
X-Gm-Message-State: AOJu0Yx/YiZd/Or0svuMj0mMt8Wql4w+/Z/M2vR+LQWvBjQJ29MVwfUM
	KryubU6KpLncIU39IVr0Lm9fh5AFIfNmMF9oIWw559AJ26vRZLexndyvmIJ50A3CUhFCpoTLzPL
	8ohTDZRM=
X-Gm-Gg: AY/fxX4WZZCfwtcnHI9Xq8LKm544Z79C9JXa6NSQgvKgqz23eEkXzfK+U8TVM7ruMeq
	o3GjF/zQbnM9BgQD+U/+1sVS26weNEhmWyuddUWXMuS7vg0d7OtK9qqucCmpczVqNtw+1/x7Q8V
	DDWKsKaVhQRB3rYKk6J9rsdrxSwO78YufPPkCumxJGDzvO62ZqbRQGz8Gz1EGQX1lcfPfQmiBDf
	0fGI2SNRYRKSTGlPpKp+wbCGmEyCwoVIMJPwpoaP0jDJHcQbRMy0vEMeHD/NRobf7EkVdXvGHza
	V79Nol/Ln5r1YkES3AXHD15OXFtvcfoo0p7a1gNegKsSdDkWfiPFdPcGb4UN3JL9aCZ6aPRgX8k
	RewrsG+1sEXkk71mVyDf3FvioHIAv0OsYQLliKPzzhOH0Lg566WtRpRq9dPtkHBIaC3Kw95kvDr
	K0KOSgeyus+of85i2U
X-Google-Smtp-Source: AGHT+IFQ103e73Q2R5Ks+IXqNJmyiaQpuAwsAFcVAjsgAPiSP9fcuHPznYjPiqI5FhyPnwLt3xlftQ==
X-Received: by 2002:a05:600c:45cf:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-47d1954986fmr154574865e9.4.1766572760198;
        Wed, 24 Dec 2025 02:39:20 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3ad0c60sm140832025e9.5.2025.12.24.02.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 02:39:19 -0800 (PST)
Message-ID: <51b38c17-4cb7-467b-8606-fae51f629802@linaro.org>
Date: Wed, 24 Dec 2025 10:39:18 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf jit: close agent in Agent_OnLoad()
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, yuzhuo@google.com
References: <20251224035625.1532794-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251224035625.1532794-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/12/2025 3:56 am, Haoxiang Li wrote:
> close agent on error paths in Agent_OnLoad().
> 
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>   tools/perf/jvmti/libjvmti.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index 82514e6532b8..fd7efae40102 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -355,7 +355,7 @@ Agent_OnLoad(JavaVM *jvm, char *options, void *reserved __maybe_unused)
>   	ret = (*jvm)->GetEnv(jvm, (void *)&jvmti, JVMTI_VERSION_1);
>   	if (ret != JNI_OK) {
>   		warnx("jvmti: jvmti version 1 not supported");
> -		return -1;
> +		goto close_agent;
>   	}
>   
>   	/*
> @@ -368,7 +368,7 @@ Agent_OnLoad(JavaVM *jvm, char *options, void *reserved __maybe_unused)
>   	ret = (*jvmti)->AddCapabilities(jvmti, &caps1);
>   	if (ret != JVMTI_ERROR_NONE) {
>   		print_error(jvmti, "AddCapabilities", ret);
> -		return -1;
> +		goto close_agent;
>   	}
>   	ret = (*jvmti)->GetJLocationFormat(jvmti, &format);
>           if (ret == JVMTI_ERROR_NONE && format == JVMTI_JLOCATION_JVMBCI) {
> @@ -390,23 +390,27 @@ Agent_OnLoad(JavaVM *jvm, char *options, void *reserved __maybe_unused)
>   	ret = (*jvmti)->SetEventCallbacks(jvmti, &cb, sizeof(cb));
>   	if (ret != JVMTI_ERROR_NONE) {
>   		print_error(jvmti, "SetEventCallbacks", ret);
> -		return -1;
> +		goto close_agent;
>   	}
>   
>   	ret = (*jvmti)->SetEventNotificationMode(jvmti, JVMTI_ENABLE,
>   			JVMTI_EVENT_COMPILED_METHOD_LOAD, NULL);
>   	if (ret != JVMTI_ERROR_NONE) {
>   		print_error(jvmti, "SetEventNotificationMode(METHOD_LOAD)", ret);
> -		return -1;
> +		goto close_agent;
>   	}
>   
>   	ret = (*jvmti)->SetEventNotificationMode(jvmti, JVMTI_ENABLE,
>   			JVMTI_EVENT_DYNAMIC_CODE_GENERATED, NULL);
>   	if (ret != JVMTI_ERROR_NONE) {
>   		print_error(jvmti, "SetEventNotificationMode(CODE_GENERATED)", ret);
> -		return -1;
> +		goto close_agent;
>   	}
>   	return 0;
> +
> +close_agent:
> +	jvmti_close(jvmti_agent);

Does this actually do anything? jvmti_close() is already called in 
Agent_OnUnload().

The commit message is lacking any details about how this was found or 
what the effect is.

> +	return -1;
>   }
>   
>   JNIEXPORT void JNICALL

