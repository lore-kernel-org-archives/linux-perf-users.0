Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5E216E30
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744961; cv=none; b=lm5UQZq/vsBkZj7K1te3fJGxC45J7P9M1DMD+svy63AUJ1BSSp7DAzRemrKNSHRtHSEz0Rx/2X77Tkc8zAmgnnWUoygLSm75ATXB1EPUZwfPVWU7mIGj74xwr7gMBJCOc+KudmJAwWerO/M6JhevolIPCg0I29SA6p4RBMGQimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744961; c=relaxed/simple;
	bh=tbukh0cajN7SyxccaE9cZMphzdrKFiU6tTMHpT3cuuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Uubb02qP1b3/aTJa8Q/HUkZ+VXCc6cpHExCb+yF9VFr5+B+ZPJwqrXUYT+a7unGhRSoH3MVzjTHQj8FhVK2tRyEBVBzhj0WurSF8pd1rTxjS6k4XAt1VfR8j6wvAKKf8aWc1yP6H7dBqdHYTVuXf4UTX40LJTQafEjNBYyNr6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WNYJ7UQO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNYJ7UQO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434fe0a8cceso3249545e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 03:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733744958; x=1734349758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1yk6+BiAdoM4boWjpdnnb0XRpYiLDHEajJSbnU4mVyE=;
        b=WNYJ7UQO3ONdenXOZHJzbF09E0vHmNoh73Kckf1pFJfSKkr3XjeyERzKHHXWsYvbCe
         GFlpVaWGxyuXxj6lbr4EHoUGKVsJ2hDp3VuqSFCOZprnijVOxcACDeIIdSxHWHBR27fV
         50nJbs4uKIVMKDtAy2sdZzhpQlakzwqsouphrkv9qqJ7XhAQTUa31EqWSo4GGByl171L
         kcJnYbGo1FIO96F+7KkiIsXuMb8ysL6fOme9X+czX21Xtpast/bkY+uxqNtACr0/elJN
         w4Bebg5p0qXqlnkvWMWaMyk1oOhRC4eRV1vMcF7EX0ZCPonjNzeIIEIVmK2m+Q3YQpaH
         qGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733744958; x=1734349758;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yk6+BiAdoM4boWjpdnnb0XRpYiLDHEajJSbnU4mVyE=;
        b=KFfUtu+GQVee1QvTTXIGHrLIbqRJrASbUQd74jJJzyjhVIW+CyGO0O0pJ7VgpqJhyt
         +ZIX6OE6UtvLRUEWIc7FhX8VolHQWQkaMH+DOmTyUbxkmDUqD8c455vnasMDgaUo2a/A
         nNvrVYvRgdNAv5lgF/JpckZ8dj2vUxc0FFtCkfVn/rJtRnfBLqqZpd5T2JDVzHa4ddbN
         5UETCookti3Q5nqM/++PhZUF7G1kmIKzqHLir7t1M23Xs4BOMEOPogOWF5moh4E2CcK3
         LrEJHDTnvCTyvyAtfD+lJnyx+6FVxi/MzI2Wo45WWTHAtIbcvauA3jrESs6HTtqv68c6
         OejA==
X-Gm-Message-State: AOJu0Yzk8W9nx+phYCYfF8f+SY+8C6ahtU09OnSJ//E/K8ecrqBlozcR
	B1y3EydzpQEgLjS9SXHGuTgy2ymxr+VtcwIh+hDMdV0pJV7Ff9/plJhUJC5Nl2o=
X-Gm-Gg: ASbGncu+rNOcqLHNtiGOtal6oQm3Vwk8BMTohSID/e8MajxgK3ARwfgd0Z7pm00D7yJ
	UZ1IiupDM6x1Njmw0q+pe4g93S5MR0XrMPwqf7AuOuzqvRQqA19wuHUHlJ8wMWwwpVX8UTn8gV9
	MG/xXoSSXU7AD8pE11dNGvUtA9XjUl544jmJew2vuh04uh7ybEs19VGZfNo+V56l5X2qUt9eJFv
	zo8ZisfME3FTD8y/NUL310zOcyD82dHu+VKiuWcjoezqC/aKKRjpxD6EJaoQQ==
X-Google-Smtp-Source: AGHT+IEAZnAolC1VRIxQlwnoGITQf7rUB4/OAbY0LvCQlZN+3lKtSAGpFGEfUof30OGA2wiivpZDBA==
X-Received: by 2002:a05:600c:3115:b0:434:9df4:5485 with SMTP id 5b1f17b1804b1-434dded2c07mr90244855e9.32.1733744958402;
        Mon, 09 Dec 2024 03:49:18 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f9da4cd0sm29735245e9.26.2024.12.09.03.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 03:49:18 -0800 (PST)
Message-ID: <9e9a550c-0017-40b0-af14-99f3c926290c@linaro.org>
Date: Mon, 9 Dec 2024 11:49:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf string: Avoid undefined NULL+1
To: Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <20241120065224.286813-1-irogers@google.com>
Content-Language: en-US
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241120065224.286813-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/11/2024 6:52 am, Ian Rogers wrote:
> While the value NULL+1 is never used it triggers a ubsan
> warning. Restructure and comment the loop to avoid this.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/string.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
> index 308fc7ec88cc..c0e927bbadf6 100644
> --- a/tools/perf/util/string.c
> +++ b/tools/perf/util/string.c
> @@ -254,11 +254,20 @@ char *strpbrk_esc(char *str, const char *stopset)
>   
>   	do {
>   		ptr = strpbrk(str, stopset);
> -		if (ptr == str ||
> -		    (ptr == str + 1 && *(ptr - 1) != '\\'))
> +		if (!ptr) {
> +			/* stopset not in str. */
>   			break;
> +		}
> +		if (ptr == str) {
> +			/* stopset character is first in str. */
> +			break;
> +		}
> +		if (ptr == str + 1 && str[0] != '\\') {
> +			/* stopset chacter is second and wasn't preceded by a '\'. */
> +			break;
> +		}
>   		str = ptr + 1;
> -	} while (ptr && *(ptr - 1) == '\\' && *(ptr - 2) != '\\');
> +	} while (ptr[-1] == '\\' && ptr[-2] != '\\');
>   
>   	return ptr;
>   }

Reviewed-by: James Clark <james.clark@linaro.org>


