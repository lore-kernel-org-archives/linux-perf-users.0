Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039250;
	b=v/WazmJplJ3L4vpeieD+kpCNdiR/GLH9KpyB+i2CUEJG89ei2BeIqp60xuFcBOyEbr1V
	 EEHSnz8USNQP/g9U4PcG4WUzdLOKcCQWUgEG8Ps3N3o1n7o0H+0BdHwPvmgj9lmJO5q3x
	 Ockbh9xLK0sz4dSCKC4PI/vHNUcp7fwlpvrH+Ka9ZXTuM6OKNU3abo5uZP2Kvgft1Wosv
	 g0jC5rUlf7DsUWqgMcRKlLs/lPRRwF196dgvaMIQxpJfWNNvKONyer1NUeXDoBFMUY3s7
	 KWMEtBsxmwuLBILMuFt4Ih9xyE4SeCFYrhqY+wrqdifG1iJfnIjSU4xAcoUV0ZVnpDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7JqbkVq7GYaMRNusjcdgx+xn2VDbTvxJSvG0a9bBTdI=;
	b=PLlMbVuNprsOc483NcByeojm5jN+hUDeeQBBkUQs0RG3v8Yja0U0fBBqnyWCt/dZ3kGb
	 0TJhl88Ln0APk1qNsZxjsj+nPncZIKUsJtKPRoYbLKwWwgB6VbBdb1sxEu722NjFp2IAm
	 xyl+1ZnfDR4HMUYtGRrp7tskBX0cGlgs63ZerTVbFZY0zOiW61fscBOmJoZYs5G90dz9d
	 +hXBUUP0FYVu22NjoyFS3nO8E5Ql+9WDU9Scp7MgMhi+kWh8pq9sNcJlUYr1Y1XkyJC8+
	 EpFStQlTnKiOP+0G1f9XNDgQqHRxUfRgFWUL+YoeakW6uSbRiZZNo2zBJF3paDjGauQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=q7ISm7uT;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E22F606A31D
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 18:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E22F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=q7ISm7uT
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dee593f18so2500934f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793039247; x=1793644047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JqbkVq7GYaMRNusjcdgx+xn2VDbTvxJSvG0a9bBTdI=;
        b=q7ISm7uTWLJdZjZWlv+QJ3l73hoyRwWYc4x/gMr2HIlSAZaUN8FZb2CJC6ArEYnz5P
         4dhMWq6Rr7x0LXYMzI9zBFbn07gKwewb5wFXt3Cg299nMl+ysNICiXwD2k3Kg/ZPmboW
         FW4BOiv5T8gWU9603oo0Hzonx/eWnCwbOOHK0rFDLV3mUsRzpd1LA1GHSlJI/UK42BWG
         djmalSJGEnOCSOAGI1AdzXuClSXMcZZLaWzqXkX+Gz4yDYX9XWP8NBQs33h8Gi4eM+gT
         DMzBAGmQ/PvKq6LopsJgCgBm88IeWXG0kKO8T7XIti93wr+b7LRx9BTGJicrWXYBaFwR
         ZOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039247; x=1793644047;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7JqbkVq7GYaMRNusjcdgx+xn2VDbTvxJSvG0a9bBTdI=;
        b=kvbvTxlO/HP2FA2M9bazXMexfauoBKS5lMJLWGz/LLCtYPv2SgEaDtnqa+o7R6bwEf
         mhj+UYLc38ATwJfkUimbj1T1QlOe292dc+U2bs8C7PWlOrOGc1oAXUqJHeLlngP/g3zH
         qSiEk901g3mVrJ5Ov1M2rQnn2vTRxyhPoCg8Ee/XPsdN1lR5UEw0AfZ7TfHEEI0tvywr
         bsweR2eKJaqRQR0qJHi/N+L7b2Ca3d1e5gtY/mds82hvmommhbFv+xcdlo43dzoN3Bn5
         pAmKadkxjM4g8rKuHUhL585JgXHjKYcytjKiWobLH7dxIbXd9GdxPt8DqY6CwB+K9Mk3
         LQBw==
X-Forwarded-Encrypted: i=1; AKwUvByeNUwo0fcujO5uPqCQe5BRWg2dnmn7DUB4h7scwXgXQgcDMDJjWZGcTyGGIcS63cp2QEMqnFyqnWHu456Zl9lj@vger.kernel.org
X-Gm-Message-State: AFq9FYLesjNSsgU83hjsNe1V/y5mbWABvqXjR8VErDqjCM56gw35741b
	HoDpLX2lVgMm49G7OYxehgcMsTtofqInsRNgQwPWvCnhmhQZiMDLjC2pGxJSIjEZ1hk=
X-Gm-Gg: AYBFou3UqEhWmIVln2VwyyNUJzhRRbzNjT7yOpbgTYCdVlUSv3N++fPQKRm+uN2Jn99
	d+do5bjEU1dN+NniB+/RSi+kS7x/MaXOIkeaadyvJcAVkGUZGD8vmGT3j72merOV7yuhrUNDDdd
	z62KbXlxHFaP7qzCAjCH5dPhTN2TC6IkUlgnLJm/t5Z2SU9XcVEIR1cKdDfXuMPd0E78/AnV75g
	+UvXWr0kOzqJW3CjVHfOvfy9aDOQF36b0cu23oz6rswjHp/G1bik64XwO9QOFamQd1BQo4/fgXa
	+hHu/9Exr9FUvYIcOZ62shwG9LLlOiS01N+u8e66zUQjgo8hzc6Vum82ckieo1VDlB64sm+jZzI
	1yh2OTM4MB8kzFwVub4ssX/o0ZNe6FhBqhSAxDxmitGSr1tUjXgtMolsX9PAlbvoZTCSitj8VeZ
	cWBWmig85tDCaV44RE52Yr/YAVuU+J73z0QriQzUjAbBMQUpv4dp8kyu7H9ZQuiH1NW4q1HF762
	jbk1OyK/djdJYJb1gHBiSItZ8mxdzzJEp2XPrNWf6x5MlOOani0fi3aVmXF
X-Received: by 2002:a5d:5d10:0:b0:48d:e62f:db70 with SMTP id ffacd0b85a97d-48e3eb9c239mr14221106f8f.48.1793039247581;
        Mon, 26 Oct 2026 11:27:27 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f36asm18177958f8f.1.2026.10.26.11.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:27:27 -0700 (PDT)
Message-ID: <297198e4-3179-4de6-b5c4-ede4faa92ebf@linaro.org>
Date: Mon, 26 Oct 2026 18:27:25 +0000
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
Subject: Re: [PATCH] perf print_insn: Include sys/types.h for ssize_t
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
References: <20261026174535.3157580-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261026174535.3157580-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/10/2026 17:45, Florian Fainelli wrote:
> print_insn.h declares fprintf_insn_asm() with an ssize_t return type but
> does not include the header defining that type. This causes builds where
> stdio.h does not provide ssize_t to fail when compiling util/print_insn.c:
> 
>    util/print_insn.h:21:1: error: unknown type name 'ssize_t'
> 
> Include sys/types.h so the header provides its own dependency for ssize_t.
> 
> Fixes: 218c200f677d ("perf script: Consolidate capstone print functions")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>   tools/perf/util/print_insn.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
> index cefa5c5f246e..3de9438af9cd 100644
> --- a/tools/perf/util/print_insn.h
> +++ b/tools/perf/util/print_insn.h
> @@ -4,6 +4,7 @@
>   
>   #include <stddef.h>
>   #include <stdio.h>
> +#include <sys/types.h>
>   
>   #include <linux/types.h>
>   

Reviewed-by: James Clark <james.clark@linaro.org>

