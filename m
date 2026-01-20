Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F523F074B
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905038; cv=none; b=bQ3KH2P3yLBQCPppjkMWGFPDsA0WyDXMZ4FWAwoA9p/s7t1SetCzDQuq2/W6IEXYo9e11PA8MjDu6rZGLY8g+w9c4bbqTZHpfNVYcFX/MUODuQ0w2iXf1Kc5qSMr5kBH+lVaNHx1BqGaupaNuKrdPlqaxGsIAtzjUwT8JhxFVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905038; c=relaxed/simple;
	bh=+QlPmRUmjUTT2vQBuLtL9xyB/Rn0Y4EsVVcEiCiig1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYgPXeBTea+EmTukpEHssTV78e2NK9NxMErH7gKIyy45+aknIXKbDK7vHhRwgS7xc7oUajzCqu/h+9D1CFaQgazpcrqB+6Lnqe4aFhbhYK84jjcUh1WoSWA0GGwQDWw7urvokrTn5yhfjZnZL/5KbEQLCmwdv85FqFoKsFpEBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vSWte0FV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSWte0FV"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so32310855e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 02:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768905035; x=1769509835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZae7LTTeVVmKwoYCa2ULF7/qiJrsJL8H69g33drKkc=;
        b=vSWte0FVYrocYalKE3F60XpbIEAmGjV4P1abV8p+PEwoS58pRikKlwm22YBE2LHz9+
         AdSOO/ogaW/U86P7IEEFQGYcaMaRPLt6GrIv1xeSfIsnoxDyOT6PuhzPz1ElhDp3tCzl
         43P6wB1zyCxkCbsEWRlukVM6cHH1rqirVQfX26EGqRAr4/v+nU7bcV30e2K2XjaQ3nuQ
         RcpRy0l3lm3OMll9pRj+aaNpbxyfhMmmOb+LcCb9lxxE7LI684xsTIiDa8sVtjlPaeQJ
         LrRNExZul82RKzNQQ3MSWh6PttzdOF0z2TtkV4oXVFOE12VHtS+aFVwGgaVHsG9pyEqj
         g3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768905035; x=1769509835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZae7LTTeVVmKwoYCa2ULF7/qiJrsJL8H69g33drKkc=;
        b=CzizS+cCqz2DOWeNX8oqyimwUH5axWdIy1VSbac6ArUHIXABT/fN3RmCYcJsjFY8M8
         gCaGbte2bBSZVkWzBfu3zujeMXKpp0tkhXGnB4R4ra1O7ljz5QCjTJV8nqgWYXWLMner
         PnEHzUSSkBKP0EdI+/PQBgN35xoARSJ33BUiwVvARuTHTyFeyCZwNG5S6PKoSuGevVnZ
         4yIiOKrHQMGGMqLJ9E/PC2WXiMXA2T14BXBLhNvhAOp0OiUQ/5sdIZTFcmwQYZ6wr2Ff
         K4QjVAjaBGmYrxmC/L1SUVW2V4EXRMq/abLGKfNd8eZL7k1ypCXXGvwZ5N9WZ1f/hTv2
         NDgg==
X-Forwarded-Encrypted: i=1; AJvYcCUQNpLh5r7tlxHonDLwbq+deMD+XsTy87fyqDfSPB2YVjrP5ASkXeDoYfObCtTK59g4k7W54TrrU0DcmxXo00wZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZ5BeVzbXZc9wc/znui68zOdBDQ9Fl4Ap9BvC2dIzNVFP7xWT
	sHm8B0ejd2b58z9QBRuYLrVEsjS5cMgmnKQQECaR4aGijLwaR5QV2eo5ZVxY1JvV7ho=
X-Gm-Gg: AY/fxX6Kr8xAEW5GbSUEQahhp4qyYyrnvnz4kmIZkIIpjwBeHcG7+cRuQFbIMsEqhMx
	+EaEqn8uwkDFphJnNR4+8a18LiPtlkRBi3n8jEXTtGcwumpi+zjZ9ZB/1RWgi3MS3un8wlBCO/+
	Z0PIP4a12QBMosyeX3aqFCYnXliohCDloTFEuCi9e6jii9shk5GQ0xuGqd+tanqdd9t37boN0br
	VX7G2T5KurM7SEBvnCbp2ZvADxXWEDkxObhWXsiklAGhN1nL77lOAEoT4hlk2idgIMXHqBSAMw7
	XHgwcbQ8FkiTD4FBg3/v5KrVxSw8pBTpRFEEJ9iqU7HRcp8OxqyUfPWKO+FwyaaXe0GW6LK4czq
	VTl2EmVSxqLoc02VlzQhwaFWC/mp0WAsrM/PhRY7TE/zl/qq90eETWLN3yGZuyKVavQRmhF6CAK
	Bw4GUtpgMfVu0xlls3
X-Received: by 2002:a05:600c:4e15:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-4801eb181a8mr190615255e9.34.1768905034899;
        Tue, 20 Jan 2026 02:30:34 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996e2d8sm28686617f8f.28.2026.01.20.02.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 02:30:34 -0800 (PST)
Message-ID: <436fd905-f54c-473a-8bc6-93245761ebe4@linaro.org>
Date: Tue, 20 Jan 2026 10:30:33 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] tools build: Fix arm64 unistd.h dependency
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260108-perf_fix_syscall_header-v4-0-5d45d18bc491@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260108-perf_fix_syscall_header-v4-0-5d45d18bc491@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/01/2026 9:43 am, Leo Yan wrote:
> The perf build includes arm64's unistd.h, but its dependent header
> unistd_64.h is missing.
> 
> As suggested by Arnd in [1]:
> 
>    "I would suggest using the same method across all architectures:
>     either we figure out how to use the generated headers on all of them
>     (including x86, which uses yet another method), or we just stick with
>     the old asm-generic/unistd.h copy and use that on arm64 as well."
> 
> A dynamic approach (e.g., make headers_install) may be explored later to
> generate headers for tools, but that will need consensus from the tools
> maintainers.  In the meantime, this series provides a quick fix by using
> the asm-generic/unistd.h copy for arm64.
> 

BPF feature detection is fixed on Arm with this change. And the make 
headers_install idea sounds good for later.

Reviewed-by: James Clark <james.clark@linaro.org>

> [1] https://lore.kernel.org/linux-arm-kernel/20251222173653.GF9788@e132581.arm.com/T/#m69a051aae5e53a65f9b10e1d13f67b3e92f4bbc7
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Changes in v4:
> - Updated commit log in patch 01 to avoid confusion (James).
> - Link to v3: https://lore.kernel.org/r/20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com
> 
> Changes in v3:
> - Changed to include asm-generic/unistd.h copy (Arnd).
> - Removed check due to divergence between the kernel and tools.
> - Link to v2: https://lore.kernel.org/r/20251210-perf_fix_syscall_header-v2-0-b18b6016e0ea@arm.com
> 
> Changes in v2:
> - Added a consistency check (Ian).
> - Rebased on the latest perf-tools-next.
> - Link to v1: https://lore.kernel.org/r/20251204-perf_fix_syscall_header-v1-0-b8e27f74ed6a@arm.com
> 
> ---
> Leo Yan (3):
>        tools headers: Go back to include asm-generic/unistd.h for arm64
>        Revert "perf tools: Fix arm64 build by generating unistd_64.h"
>        tools headers: Don't check arm64's unistd.h
> 
>   tools/arch/arm64/include/uapi/asm/unistd.h | 24 +++++++++++++++++++++++-
>   tools/lib/perf/Makefile                    | 14 ++------------
>   tools/perf/Makefile.config                 |  1 -
>   tools/perf/check-headers.sh                |  1 -
>   4 files changed, 25 insertions(+), 15 deletions(-)
> ---
> base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
> change-id: 20251203-perf_fix_syscall_header-e280fa931d44
> 
> Best regards,

