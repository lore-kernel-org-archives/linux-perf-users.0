Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9660E23BD0C
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Mar 2025 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773759; cv=none; b=HN9r9Ya3cMD+A3K8Jx45DV8+kdooIox52/2I7pG00CmUWLjNp+YnHW5rJEBkzuTeY/EfFTqqAqmBgYxrBQx/7ugVi7KqziSLqr405z+2UII2ufsDrydAGOnvPON2kfZMK4kk3wvETB39yT/+aeH7oT4WRVtRQl+R/0KkgFplHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773759; c=relaxed/simple;
	bh=kjWvjaQQHnF7eoPYtX5uf54kvFANSjafAEnJ7s0W104=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJ7fQo69RE6z7wrlAwSfDf6Ye+5xOFXsc8gwVTSmaLRwKSOSz7ysz0DDx+SXTvOdk6bDAZMdoNlKPf/ejqGJx0RXguMejy/43DWf3PGSAwKEalEuveG8GUkq24P6uMz5C1TTVVt4ExNZo3szjCXYdhHaXxwNZ8nNVwNz2SD5I2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qqns4Kwp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qqns4Kwp"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0618746bso9750945e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Mar 2025 03:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741773756; x=1742378556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pUHKQpxTCLmGn74czB9zdVmL8GuztD+1m1BAWrqdpyw=;
        b=Qqns4Kwpx88PkRN131RElQbAYioRhFwayWd6xeAXl2oqzzLlpJngKu3hsPpo8viYbe
         NgZ0tgSgHkw9RyMXBfHxExqlWbUtWY+/kADiMxz7EOKc1SIvgA8bZFSvodLZp2nR4ccu
         pxxNXklFUkAAa/hGSH3qFFMq/bHTTtDx0kfbiZRteJfMjoJRZCb6WGO/w5OVj6CuBzLw
         mFD2Kj2bG+ktvBcj19DRkKwbO2XEAkaEt0V7E0aejaGkkgXTngRjppG6/8PIVwjCMtkn
         IwjC4pAZQyrQa2PTL9KWv93c7xCyPhKnXePObd5rPxbOem/FnvsG9s4d+1fMdOyoSkzi
         IQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741773756; x=1742378556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUHKQpxTCLmGn74czB9zdVmL8GuztD+1m1BAWrqdpyw=;
        b=smgnS2hCu6ISoxWQKEiyF1AhDSsZ72yZ+Pstwxgfi+ZJ2Xx13FcCtd4o4kYs4SfLaa
         AhFtc3VhY8NyXpRUfPY7o9tv/RY+YEAFPBSdC7PHEw7dkWOc2Pt9Shb9B1QKPJxRABun
         hR+S/ZIH857x92ww05gPZom6pdiMLiFUymilnYdAwQdwaMG8gC4Z8Z1AS1lYNE6uEo9L
         D9w023FfoM54Nb+fVmTd1LcvIjm7DYMELSrk58B56w3svEIyheQ8X97IYrK9ernTDbs8
         hADu1AbKB+HNXaLxEcypNOd3+E0F2oNEDxfDaQ6ERiUl6mZgaVuH8k6xpt+pbdueIAuU
         a5uw==
X-Forwarded-Encrypted: i=1; AJvYcCXkrlpLFmezJcDtIYQU5LtXUCl5eJUeXrSd4BcnJnOVN0whrzMZnV76MOo0W++j8N8rBO0tNICWpmq8ZcgwgE+j@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMHaZcTqajp2obZd/C+y3UNQFx23jUd+p18e+KSUf+lEe2990
	BiCO/IxipuyGlzeKkt9UlIaUywFzyhzQXrQz4e1nx+W7fwdkHrpUtl5URPVTQAU=
X-Gm-Gg: ASbGncsZIBi+LXh5QwFdJXXxEaPuaxwOM4zzXWDsdGbvinHPnA/ktOoDKJXVkFEXzkA
	g/WnNtbjcawfWsjLYsmKEj2zAGjicQmfDwalmO3v2kf+1kvjpRbR8/wREVIi8YTV2HTiyPVgyNH
	N1ALE5WXxlXqDkiTgRFlYHb8LtJmqJFRoRUbkKMrQcy0x/BER2ArTPUnblkFhYnRfvr0hjR5a8Z
	7peW6xX7OaPKE0Vpnr9ED0VUvWAK6BZTIu3JNXWruH1ip7BF6fsZ8VpjWVVhas7NnnRiDFVeLtv
	blYt3KkXiA/hhQSwNxVH7/CR6l4WHQB9N3xMxStKmI376Dq2QwgZKQ==
X-Google-Smtp-Source: AGHT+IHsfLVyBWcJIJmx03S34iaHHCTkfZVaBtu1xexwTvJTh2AWPtnReHSIE67a3DSyc4chYw5jdw==
X-Received: by 2002:a5d:5f8f:0:b0:391:2e0f:efec with SMTP id ffacd0b85a97d-39132d1faebmr14844096f8f.7.1741773755863;
        Wed, 12 Mar 2025 03:02:35 -0700 (PDT)
Received: from [192.168.1.247] ([209.198.129.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c015d2bsm20073216f8f.43.2025.03.12.03.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 03:02:35 -0700 (PDT)
Message-ID: <6b43a3e5-b76f-45fc-bb2a-6c47a0a7c511@linaro.org>
Date: Wed, 12 Mar 2025 10:02:33 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf script: Fix typo in branch event mask
To: Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Graham Woodward
 <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com
References: <20250312075636.429127-1-yujie.liu@intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250312075636.429127-1-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/03/2025 7:56 am, Yujie Liu wrote:
> BRACH -> BRANCH
> 
> Fixes: 88b1473135e4 ("perf script: Separate events from branch types")
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>   tools/perf/util/event.h                 | 2 +-
>   tools/perf/util/trace-event-scripting.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index c7f4b4b841ca..664bf39567ce 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -91,7 +91,7 @@ enum {
>   	PERF_IP_FLAG_VMENTRY		|\
>   	PERF_IP_FLAG_VMEXIT)
>   
> -#define PERF_IP_FLAG_BRACH_EVENT_MASK	\
> +#define PERF_IP_FLAG_BRANCH_EVENT_MASK	\
>   	(PERF_IP_FLAG_BRANCH_MISS |	\
>   	 PERF_IP_FLAG_NOT_TAKEN)
>   
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
> index 29cc467be14a..72abb28b7b5a 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -347,7 +347,7 @@ static int sample_flags_to_name(u32 flags, char *str, size_t size)
>   
>   	flags &= ~(PERF_IP_FLAG_TRACE_BEGIN | PERF_IP_FLAG_TRACE_END);
>   
> -	types = flags & ~PERF_IP_FLAG_BRACH_EVENT_MASK;
> +	types = flags & ~PERF_IP_FLAG_BRANCH_EVENT_MASK;
>   	for (i = 0; sample_flags[i].name; i++) {
>   		if (sample_flags[i].flags != types)
>   			continue;
> @@ -359,7 +359,7 @@ static int sample_flags_to_name(u32 flags, char *str, size_t size)
>   		break;
>   	}
>   
> -	events = flags & PERF_IP_FLAG_BRACH_EVENT_MASK;
> +	events = flags & PERF_IP_FLAG_BRANCH_EVENT_MASK;
>   	for (i = 0; branch_events[i].name; i++) {
>   		if (!(branch_events[i].flags & events))
>   			continue;
> 
> base-commit: b10f74308e1305275e69ddde711ec817cc69e306

Reviewed-by: James Clark <james.clark@linaro.org>

