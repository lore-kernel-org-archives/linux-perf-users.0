Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786420;
	b=Fs3V9V5LFfPHR6Wr4EFxeTzwj/0IxFIs/P2GNxDY+Kl5et/AWZZ7kSDa89LkFd1hO+lJ
	 y3BSv2nzQNqpA/oqtF+8d99lNMWrIP/8Q1UR4lQ84E6bzma5c7BKMpn9ztTEQEkuG2vHR
	 UxeU6mEgVPIpVl3zbbuk5xkAC6mxlo4kr+b8Tzs6VTTDAy+/1cDYLIEFPDZzwfBYZjDK5
	 1/v7OCVnWEOj3isHwxOPTW//VdJjXKd3Tb3zJf+aHfuSr3zkZPkZCKl/J1AYBBHu7qPTy
	 lw99EXv79aM2Uc4Ebt9JlCRGkFnOMjlK6u8gptLeGgnEWBfKER8ESes8Lrerfrnm7UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ouw4R6dZBkKkbWnVqlyAlihku2AypLtquktGWyU9qgM=;
	b=XQ+Vj/qY/Z0WLdrGRAzfCePMDMdtW4kLrx5+Zs/qjGRCjdJp1ig+TamQhCs9gIac6B1F
	 fBA3xQ1hsIos1qL8NrhaYhMZRuAuVNKw7r7fkjuDqDyXvVLwmVw8Rp3migqZgA8fevogN
	 Oy3+LzUFCGxtKdaLI7z3dfKoYncTv6hoPQqqTCS8yv8z4onC0nX1U2WFKpkoYOa4jEBgt
	 xPojgk1Ip0264AWNo1FsOta0AJAAN+IIEvECuSSuLn/F8/1QmAIrl7eqWMOFb1wNs3eTW
	 SmAkDcVJHKNWL7I/VfQNxRaywEJ+MqxZAViePjr0Wekhw3QFyL3GaqzWnNPQiMPxNJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="QBN/AIF+";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DCC606A32C
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 10:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8DCC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QBN/AIF+
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d05d51553so2846105e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 02:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793786418; x=1794391218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ouw4R6dZBkKkbWnVqlyAlihku2AypLtquktGWyU9qgM=;
        b=QBN/AIF+R3WdyZnxFG35XH0XNbW0L9ZjpVOOclvTOVQNERVzfFYB5tEumKOppRLJ+y
         NDgZjGPnl6RJryMJJwSfJHiK7IQ0BDOqL/ISZfXyG5A8B8bxWM9Ym1zAS5hOgbaSnG+0
         Kh5EekhYIEQ6+r+O59+1h4hfbtLD40VlbUrDfOHmp4jMkzhciKxCGYXgxVsmRDguWAnf
         7QxOm5Z1GSmUPkTMhCsiUyTCSoKntBcvwz+2GWWo2GQc0Z0DKbpbuVFCtfFOoO8CK4Yh
         gu++O+vPw5cqlnDSNvrqNzIcsa8QntOmbGQjQZfqSWzHO9anXkaWGKIi3+VJMKH+Y4h3
         mn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793786418; x=1794391218;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ouw4R6dZBkKkbWnVqlyAlihku2AypLtquktGWyU9qgM=;
        b=eOfRTKmNQhEwDAZCAU1CNMdoZepws+PanMByP7mmzjDH0QeXr52fj3kpBzLH/Dn+hM
         G+n7Pso1q/geOrmGd0hCDQmwmXtGWbWRwvsFKuPM11kZbTbxT9Zp6YbZNun5/Ai3w/dv
         D8V/cg+6igQspHEvxY6wZYeOIzvf8Go2PUT3mxTjYUrTOQmzrvGSvnm5sfYsbxM1GU5u
         LZFS04oJZCcR1mAjeUsgEmD9f2Cskxqt9HGsGXMyzCFjHzfyGutIPJPi3xfRHhbbBLi0
         us33lva9mfPMnvOhPWxh+I7fGpzvVpa+urG29esW5J0SCjawR7sSYHn6NAD3rsjdV5Zj
         LYfw==
X-Forwarded-Encrypted: i=1; AKwUvBxTj5rjsXFJ9PaKltbSgaRpK0wx/AOaIMoj8BQuce1khMk5pWulGVnXgiHcJmjopg62IQmuYpCWOVZzituH+6si@vger.kernel.org
X-Gm-Message-State: APuU4Z/yrcJjQxGNEvfe2kGwd/WgR/msbzeWa9yspp1l36cpt6y0hhUw
	rCrc8lNrZzl8pR2quT+ocXhWG/8JVaUsqpBg1QDBIb/FB6j8S01nmiz/cYljZ1KWw84=
X-Gm-Gg: AYBFou1Ev6bxlr0URfn1nhvc8jPUe9f6aC9C2+9kkqIz4AMtsXBV8xWo1YNkmP7cD1v
	ysT38p/3d65DmedhyL84tvxhg0NZlvSgUJ5m8MJPVx4fhvq1VBuq6Ug2RQEjT5pMBoOuMbflDE1
	jgbpATqNQOL3QmzVqDlDIysSnO632f+xDuoKA+NgnTsZdxa/AtTaOIQfg2Lt70vpuYyLhYP1NUE
	RE3WSOOXNE0cDEvJY7XeJf3twAl5MMndmMC878TJ3GixTXplryPwQeFluC4CQniVL2YxrfCJOpx
	6HQZyl07RzwkNRfGBKEd8RodrTqhAlAOAuSVtR7aMBRI6V9nIrA6Skx8zs4TbJEIC+JYxcARLne
	f8mrPb6kXgVe8D9NJh5l/UQ9pqobVJP3YmNZ9hWMxPSS8CUr253hx2I6fqfdnmrzBHySZCj5obX
	uTj9XvtubtyqsJfxedwaW92GS8lhJ+aZo/vcVU3y6z9QyoCMEqKGHgusd05JJ4NvcGZ2EoSxF08
	EpJv0Aa7xCbqdpOegZY7+H78vU7ExAUHrmUl13B4CuwEpj/6yASPQ9okT5HCAAPukYFGDtsZUYp
	9F6mww3+GQ28AT6KEMtvMvebCJtai0KOUekgrIzLsJgIIb5a+LA5tQ==
X-Received: by 2002:a05:600c:6215:b0:4aa:1527:659 with SMTP id 5b1f17b1804b1-4ac17a366c0mr369114715e9.17.1793786417915;
        Wed, 04 Nov 2026 02:00:17 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43a48adb7sm44505345e9.1.2026.11.04.02.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 02:00:16 -0800 (PST)
Message-ID: <c1e052c6-531b-4c1e-b671-b5a214ae24c4@linaro.org>
Date: Wed, 4 Nov 2026 10:00:15 +0000
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
Subject: Re: [PATCH] perf intel-bts: Free the old snapshot reference array
 after growing it
To: lirongqing <lirongqing@baidu.com>
References: <20261104022042.1894-1-lirongqing@baidu.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261104022042.1894-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/11/2026 02:20, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The snapshot reference array grows when a mapping index exceeds its
> capacity. Its old entries are copied into a new allocation, but the old
> array is abandoned when snapshot_refs is replaced.
> 
> Release the old array after copying it so expanding past sixteen
> mappings does not leak it.
> 
> Fixes: d0170af7004d ("perf tools: Add Intel BTS support")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   tools/perf/arch/x86/util/intel-bts.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> index d44d568..9403681 100644
> --- a/tools/perf/arch/x86/util/intel-bts.c
> +++ b/tools/perf/arch/x86/util/intel-bts.c
> @@ -299,6 +299,7 @@ static int intel_bts_alloc_snapshot_refs(struct intel_bts_recording *btsr,
>   
>   	memcpy(refs, btsr->snapshot_refs, cnt * sz);
>   
> +	free(btsr->snapshot_refs);
>   	btsr->snapshot_refs = refs;
>   	btsr->snapshot_ref_cnt = new_cnt;
>   

I made the same fix here [1] as well as turning BTS snapshots into the 
generic one. But that doesn't have a fixes tag, so maybe this patch is 
still useful.

Reviewed-by: James Clark <james.clark@linaro.org>

[1]: 
https://lore.kernel.org/all/20261102-james-cs-unformatted-per-thread-fix-v3-10-dbcb0c281b9b@linaro.org/
