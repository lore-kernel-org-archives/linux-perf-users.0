Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B8434BA5A
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584077; cv=none; b=PWxGJ1bm1rfYzPmxbTi8N6FXaFzsmm6pJMZaXMmEW3PnFsqfR6ZA8bJiYkRV2WCZfS/BwGHKoTcIeV9OwK2Qdz/nYj79olZR7wyhcmxJLmBRKrb3Ak6RcuILG0gp4xSACDWC9nwZHXGNY+AhUSoGSr/PnFI3Lz6hEyIG0zdq+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584077; c=relaxed/simple;
	bh=bdh+jvWi+IctCgoCAG5UBckr/v78vOJjfxFS3qc2f8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWD/3yjT3gw3Op8F4/YIwOzY31ATciwa2QdjriDSf55nKjyQB7zWN78MwiYZIvTKX6xqa90iSPAqdazriHmF96mYcGQc0A2guf2RY668zcsRhbP9TaqyPDjpIt0sY2VIsf70b3G0LY91iWfSu4AYgcYIXynvP1/Gs+jVGlNtKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=fail smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwG5dQav; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwG5dQav"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-430fbb6012bso4785719f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 05:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766584073; x=1767188873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZ9XOcZCyBgM+Kp3skH4ygHvzivbR8hlBTIhx8919D4=;
        b=ZwG5dQav4YyISGjrGxFyut8kZ56h8L4VyrW1Keq/qVZ++Bx/Ogc6pdv2gO5Vq458PM
         97rEltfetkEDxgnanq6pOMlEEvWYkF8WERLznrT9CpRnP+HMjtsTlkiTxuku1Aco29sA
         z8Ofkvnf4HizKtEZiNTTJBlJk6IRlO0rCpb/l/hNvG0y1Jo46p5OsAKTXyV9Tp+ZCPpq
         WvrsktBDVtM+yMqGQapxN1QDRjx7/kF6Xprrmk7gUoyyKwQMiopZEPKu0vj2n0OPvhv0
         /zyP4ian+mvbzDOjDA4m7SJazwIfb3fO/WVWwSCSYPXh8kmtkbWr4C3/mCyClaqfdP58
         FPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766584073; x=1767188873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZ9XOcZCyBgM+Kp3skH4ygHvzivbR8hlBTIhx8919D4=;
        b=l5JtY2CMRh8NBzg1/eyQX4GEZxIc1JExunqXYqv0aLOLJWH9MZVtLFa/H6j0cZ+L1P
         Tnsdrkr3E0EbJyGJPy78zC0qy+x5GJn/TlDj7XKwC6h51SKk3tnMeZy3TaUXHxNxOrhX
         dbOKBQcZWaT4aXU2mGBZjJuKyJ7SVkngWeMH/+7737wAKlv4kWVWALBzJJK3lnvcG7Cf
         qpkoQXEa8V1zAYetvJyzt6m/bX09x+bm6K9yjdLl/akIBZJj6Spvh6LcFzuIyDzvjh8L
         ehHjtzXgsB+d0Ab/lFzHuA6IihZ19tqaTeBosKzKBChGmUfcvw2ePoVEeuAI/48KiiSC
         MXOg==
X-Forwarded-Encrypted: i=1; AJvYcCW9E8hcd0BSFLAPtrtRj4zxIhxS12wNrxL3bagEc+hxAOkcpP+e5SbFIO/x9dmzqW/6ppTUIN8gn9Fl84apVheo@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKo9BPJrSPrpog7iHiL5SDV52B17W7vQbOdrtORg0t46KYKhH
	4dnaN5bzxQYJ5D0ouDF9RofqgFdZmIBhghNXiM6aA6eLbC70q3ckiP75VWJzLHFKS7k=
X-Gm-Gg: AY/fxX7q+T31qjd6G/xDGrwAqe1VXR0YI/7RCqe0MbXrvb1n3t/W02A5NY6i4O7R64A
	V7w5yhsxA24Y0Pz/anMoz09CTLiHJnDFMvpBKq1zGYBD/IU1Fzkk3JoD688sQi4lsiUqs6qUWdO
	rpn8G9wSnZQXF9aenMYHUheqVjM5of8ZjuODtbkLxd96tJe0z+ilJyc/GImtD96Mt53PHF/9qHi
	oe1g68Low+SWPhVYNmXVbXKgbFH+j+yWnVRP5WImj8WL1lp5HmVfAUj7Up18BOCFdALI80Y935W
	DLRVEyiwFatDom9Gsaq9+jL+iokbNVQs+cpdLvpCM3Ej42xrz6ggagAAsxUH8TjCsCdT+vYnTCz
	3x5zgFA3UJsoc9GzKRNPIEux/SLKh/+Kkco6mM04eHIYOc1fzT1rpB3olZrTeb2pQ482pp3i2p8
	O9+5PsmNCBWu4nhn+V
X-Google-Smtp-Source: AGHT+IG7czlbZcFPRXBcMQ+MZTf8eT/RJM9CmkrjVuCt/AO6qzD6Bht165AcoKymHG1Y7XPrz0SD7w==
X-Received: by 2002:a05:6000:1843:b0:431:327:5dcc with SMTP id ffacd0b85a97d-4324e50ebcamr17859725f8f.43.1766584072706;
        Wed, 24 Dec 2025 05:47:52 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325d10cc48sm24595053f8f.16.2025.12.24.05.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 05:47:52 -0800 (PST)
Message-ID: <58e432e4-5825-4f2e-9aba-29be63eac56f@linaro.org>
Date: Wed, 24 Dec 2025 13:47:51 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] tools headers: Go back to include
 asm-generic/unistd.h for arm64
To: Leo Yan <leo.yan@arm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
 <20251222-perf_fix_syscall_header-v3-1-eb4a8b9dfe66@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251222-perf_fix_syscall_header-v3-1-eb4a8b9dfe66@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/12/2025 6:06 pm, Leo Yan wrote:
> The header unistd.h is included under Arm64's uAPI folder (see
> tools/arch/arm64/include/uapi/asm/), but it does not include its
> dependent header unistd_64.h.  The intention is for unistd_64.h to be
> generated dynamically using scripts/Makefile.asm-headers.
> 
> However, this dynamic approach causes problems because the header is not
> available early enough, even though it is widely included throughout
> tools.  Using the perf build as an example:
> 
>   1) Feature detection: Perf first runs feature tests.
> 
>      The BPF feature program test-bpf.c includes unistd.h.  Since
>      unistd_64.h has not been generated yet, the program fails to build,
>      and the BPF feature ends up being disabled.
> 
>   2) libperf build:
> 
>      The libperf Makefile later generates unistd_64.h on the fly, so
>      libperf itself builds successfully.
> 
>   3) Final perf build:
> 
>      Although the perf binary can build successfully using the generated
>      header, we never get a chance to build BPF skeleton programs,
>      because BPF support was already disabled earlier.
> 
> To fix the issue, it restores to include asm-generic/unistd.h.  This is

Would this prevent us from using any Arm64 specific syscalls in the 
future? I think that's a downside of this approach vs copying the 
generated output that should be noted here.

> consistent with other architectures and ensures the header is available

'Consistent' isn't accurate is it? x86 already has static copies of 
syscalls in tools/arch/x86/include/uapi/asm/unistd_32.h and 
tools/arch/x86/include/uapi/asm/unistd_64.h.

Maybe something more like "eventual consistency" is intended, if we plan 
to remove those x86 headers too? I'm still a bit lost about why Arm64 
copying the generated header is considered a special case when we 
already have these x86 ones.

> from the start.
> 
> Fixes: 22f72088ffe6 ("tools headers: Update the syscall table with the kernel sources")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/arch/arm64/include/uapi/asm/unistd.h | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
> index df36f23876e863ff0a9e88473d5339f7ab69516d..9306726337fe005e3cf3e1ffd38dc6356191fa95 100644
> --- a/tools/arch/arm64/include/uapi/asm/unistd.h
> +++ b/tools/arch/arm64/include/uapi/asm/unistd.h
> @@ -1,2 +1,24 @@
>   /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#include <asm/unistd_64.h>
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define __ARCH_WANT_RENAMEAT
> +#define __ARCH_WANT_NEW_STAT
> +#define __ARCH_WANT_SET_GET_RLIMIT
> +#define __ARCH_WANT_TIME32_SYSCALLS
> +#define __ARCH_WANT_MEMFD_SECRET
> +
> +#include <asm-generic/unistd.h>
> 

