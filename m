Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039123;
	b=iZvBckeoEys8CkgkVdtd3HGdJ7d5aAcECIJoFLNyl2FJGyurg10fU6JucxWjjHGwxwFW
	 xv3154ujYx0TQHS+Nc+k9JLDuAyLEVlYkvc2wXhUU7Zq8q74PkeQgi+9nTyZ0K/EoRAEU
	 GvFvxOk8zujCcXNGAddOEcfaiVs8suJMWh3H/PH5MZVJMkuvwNnSpeFO0K9p3ePhsk0Iw
	 tHyt8DZLBzHx0dLsI0Up2KBZGb6L/FFIEhc9R6KL3xXPWxn//DsSw2DRCayGP/BeAt/EX
	 sjQkqJYRQmLtAWpqbfFpW+I5Tgv0pu2SXr+rrJi4/XSAxUR+iqFrBTh62EgIJxIJTGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vdBCJ/vLKHby2bGb6OC+NMtqwV//jUE1DYJZoK8t+Oo=;
	b=koLJGxwxGbDXM2UhOjUNQGXzxES99CVcAp3+Oqd47+uuZOr/ppNC8+bznEDtIIqweS2E
	 1Ua0Fv3EVjTAurnvHmyMIKQjEv+8b0XP7JLKb7+DYDU5heT0SWnFyLaTqjoHnFK4hTCzI
	 yy9J1L87+Wu0bYk7tdYXRRQrF0wynbUpVj74JJwm92WALs8r2dCUsQuKnZ/BEK4Mn+YF6
	 1znsQ6BzdZ6tMFFQrnWsM8LCejbzxrcr5a36M5la3Sjj0OqsQ/vo5YSZWSX+J7ujiHWGo
	 P2uqUbxL0gowOXq1mQ2Qh8ln7oYTUiooiHNUL3uwZhyeA3USgv/zBQI/txyEY6d1GCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uqdoJbIH;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBDB606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 18:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DBDB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uqdoJbIH
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so15239025e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 11:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793039121; x=1793643921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdBCJ/vLKHby2bGb6OC+NMtqwV//jUE1DYJZoK8t+Oo=;
        b=uqdoJbIHCOeV5+pkDrrnEwqLxDTdGNxZovGcn3wqyFIL+kZ+hWgj9/E+mqmojnktyR
         UyNRGHcfzgnUjgag5bnd/m6E5nHT6UeEMXL14vUly8GFPgjLbsuzHvT1uRIypfmZicH9
         jzaTV5tIY2OEZQ/Fe5r5hcr9eqquKzUAi4u18Tq9AqEigV/7UAiGCb84SfQJrnYI/Oxp
         KB/ATw/+vKEhgdzPzcLvhcRQu0X5vcAgooHOqGmOHjx1yzRI35sqbH8YLPhmazmlYvqK
         nAjdoiLkUXbrZEbihG4AeRzk4fnK5SE0jJkGuyFcO22+lQn9V5nVlLtu5FKwZJMxRoYA
         ooNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039121; x=1793643921;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdBCJ/vLKHby2bGb6OC+NMtqwV//jUE1DYJZoK8t+Oo=;
        b=ooXsFhEYyDIhetsftZ8IQGAMW5qw4g5dIumSuSX/YDqmoheVZEa8aYVHvdG4LasC2l
         8Pg/Kq5+VJZ7LNeoO0alYGjmLw+uj5zOXYEz4ML48NcaJ2wb0O/QzD9GBr+0uBJv3zAQ
         jwD3amx3XLvpGN8+DyO0BzcQI0a8mmEq1o0ee2tgrJvkKE04AgY4sSFH+9v8c3rh5yPv
         qFbg/wv2lfWRZM3NO0pV3E5ZZ7LNFyCLc7FUx+4MZJi4ACByNyzuIStQH+OS3z1a9UxX
         sLVwS4w2iH3gEZc97f4uu17eDmWO/Jb9LlNJjImmhVT0qyocYOcAGSE7zjU0UTk+8mMj
         RwLg==
X-Forwarded-Encrypted: i=1; AKwUvBx31wMeMEbnNetnfiTz2ZLx4iT2IopZzHuNTodBTD/xp08cSmH4lrgZyLWp/WeCAsQkh5l4UqydcTMUediPEIn4@vger.kernel.org
X-Gm-Message-State: AFq9FYLBk2eXZFDLPdy6LVxlkXrEpd8RE1K3gb1vnrD2TyDHixGkrg3+
	+yJZLjOxEvicOiCD/dW4+3EKSQfz2CQUbuSvv9PLW3G7UtmAjTvGaek6mCDc7fp0GVw=
X-Gm-Gg: AYBFou0/gbXh/Q3ddfZnWBnQhSHqJm4Rd8LKfCPdASqrEQj7J08PEN56Vo9elW9iFk8
	JVy4DgHMdsFxFznglSq2EFqCaWYGhmgO1QagyYLRzJTej4/e/q0h/6xChSI6MlTM+rSsJmGMcz8
	z9mi120UXAgpkcSXgLXyAG24aZymznMgnBY3+cYMsYZz0sDve4rABht4qZia5mUQaEyLWwbIXIy
	XScRbmbk610sWj25rcnBmqcw4RDDNZ5+xgIThOflIqdLAvSIMOfDsTUjSquAOSvFvAQI0UPkPPG
	RVdKsY7QecLvtYGdbnLUaXgignHy8zxorb4OIxBP/AsHEk5GimSKpS1ZZv4haPGzw8wmOwYy/nS
	V6e8PgBZYhyWURVpNqa0pEyJwsooGb1yAjY62KXk3ULJm/3D1QDRB6O29EbL1CCmhohqTw1CmoH
	3Gfv2dQ44qIGuVn3kPjzNoO8t8vSGtWR55MbDYw8yzst6uF7bIdLWvpCbTe12aQ2ajdJTy+znZW
	8yWmdzgCdanp3WMXVklYxFvVmzk6F+KPiuP8A2OqKh2A7wEo6il4Bit76sf
X-Received: by 2002:a05:600c:8184:b0:4a1:ac66:6059 with SMTP id 5b1f17b1804b1-4a35aca6b82mr129661965e9.26.1793039120991;
        Mon, 26 Oct 2026 11:25:20 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0a9cafsm223451635e9.5.2026.10.26.11.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:25:20 -0700 (PDT)
Message-ID: <440f4ac1-28a3-42a1-a030-7a47b04c0d14@linaro.org>
Date: Mon, 26 Oct 2026 18:25:19 +0000
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
Subject: Re: [PATCH] perf parse-events: Include errno.h before kernel headers
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>,
 Faisal Bukhari <faisalbukhari523@gmail.com>,
 Qinxin Xia <xiaqinxin@huawei.com>, Thomas Falcon <thomas.falcon@intel.com>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
References: <20261026174814.3158229-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261026174814.3158229-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/10/2026 17:48, Florian Fainelli wrote:
> Building perf against uClibc fails in config_term_common():
> 
>    util/parse-events.c:954:30: error: 'ERANGE' undeclared
> 
> The kernel headers included before errno.h pull in asm/errno.h. uClibc's
> bits/errno.h undefines EDOM, EILSEQ and ERANGE before including
> linux/errno.h, but the kernel header include guards prevent these macros
> from being defined again.
> 
> Include errno.h before the kernel headers so ERANGE remains defined.
> 
> Fixes: 6b9c0261b3fb ("perf record: Add ratio-to-prev term")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>   tools/perf/util/parse-events.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index cc7ad331a49f..efb46ba9ba22 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1,10 +1,10 @@
>   // SPDX-License-Identifier: GPL-2.0
> +#include <errno.h>
>   #include <linux/hw_breakpoint.h>
>   #include <linux/err.h>
>   #include <linux/list_sort.h>
>   #include <linux/zalloc.h>
>   #include <dirent.h>
> -#include <errno.h>
>   #include <sys/ioctl.h>
>   #include <sys/param.h>
>   #include "cpumap.h"

This seems like a bug in uClibc, if it undefs something but then 
includes a header to re-define it that it expects hasn't already been 
included. But I suppose even if you fixed it we'd still need some kind 
of workaround for older versions.

There's another workaround that is slightly less fragile and doesn't 
have to be applied every time linux/err.h is included in this order. If 
you change the asm/errno.h include in tools/include/linux/err.h to 
errno.h then the libc one will always be processed first. It probably 
makes sense for the userspace copy of the header to use a libc errno anyway.

But maybe it's just as hacky as this fix.

Either way:

Reviewed-by: James Clark <james.clark@linaro.org>
