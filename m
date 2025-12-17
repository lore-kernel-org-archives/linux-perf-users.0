Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4FD3570B7
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976663; cv=none; b=I4ORSxLzAXhTwbxzikF0VI70iw6whIkfMHU/LXZyZAzZuLB5Ln3rtdyqC0okklW2UzcIb0ztjs5CGuA49Jt8MbW/T8U68iyHkKb+fGZXvY4Dx2X0d/7k2TrHTzyD6u5VXffpmxtGHcwXONxbi0W+Bl4WsFvvRMGqML8jF+xnXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976663; c=relaxed/simple;
	bh=qGQxU62+x0dePQsba82U2Svos9iPtNYInKF4edY1zv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMKHs41sxbgEyX+lFitJfmezzKfCB50HMBmKKcklDVmQ8kuPrGYLOiZyIwttxXl6uanDwW5qlrDaP8gi+kc2Dc/Z2E3lige+pgVJtMPzwLza13NeD+AwBZieh/lxHHo5OFbtmQbxxS+cX7xifU4wtc4xfsOwoiXwVpQP3Wvlt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CwMJzAyK; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwMJzAyK"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6496a094ae1so8584164a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 05:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765976660; x=1766581460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lg5EJXpAA9utd0pptP7MP3ENW1wq93Zt+Sw/KpsYXp0=;
        b=CwMJzAyKL4INn8yOfaMKaKu0w7qa/n/bfYp3gXl3pwR7mDqH5FFfrhQbwZ6shZUSD7
         JsBk7FpbtYi6+BvL5gUc9A11weYT63HqT6zTlbEsUKNYJpQz/hflhBMsm6DJ0/hfxDQD
         HE0pIR55pa7zBuTNfXEOG+tOOvxbvUI7xLjWbCI7Rj3qXsmy+NO2Ow6sO7PGAKrmsCqc
         xfD/pqTcdfeOMbnNjr7orkRosbcGR5KsfXwqvK+mJcF8zdCmLirkSaKYHHdLKMabb2M2
         M0yJZ+s0oWoLfVnw+e/gb37zobE983bMkNvicq+h1LryVDRmnfPTwL0HAyRKrOtYr9b3
         zPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765976660; x=1766581460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lg5EJXpAA9utd0pptP7MP3ENW1wq93Zt+Sw/KpsYXp0=;
        b=ZY1gKASNAmeHC36UDPDze2EiKkPWYqYF30mjMh+OSslXGMsgUIV6zGvJEpWxupOl35
         zwFCXjdxb9GGP2z8Ye4ho0X9RE4rF3c5fFcROws0QyjLn54NxDDB1bydMVsSBz5VowQ6
         SgHHDXOTJBDedC6XqnpEbCk4FiAEs5HFEmJC+p6XTngo+kofuDSOmfbSXkKB+XmCtIMc
         C2nSm5l0ApDiEaoOC7y4ivK07vEEyCXWNToHu9kKmwWSeAO4QpFJ5qlH6KBznhIQBg0i
         D77eXOOV3z8gDdnbuKDv3yF/n0ad5+a0BREtUJYw8BUJHZURyxd0n0C5u2XLKRHpBTwP
         zqng==
X-Forwarded-Encrypted: i=1; AJvYcCX1MY4Mx3DAbsdg6EL4mle5TW3iClRVtZ85YIK64Zh2DDfs1Y4MvljtOCW/uXDVdh2oJlMFPhcaE22q20LGlyPk@vger.kernel.org
X-Gm-Message-State: AOJu0YzL7sWktKmqdMbU5W1s5+tttxlAm/TOr6eitB+VXz2qzDyuXaCG
	MsWWfFDUVnAepflKgAz9U0hpFVw1uAic8EgJ+gxClPWrBZqYqF88AOUKiGAQl+stlpGKQQ7NJlX
	7tUbNfh3htveC
X-Gm-Gg: AY/fxX5B5a4W1aQWKhVS2Nou9b8MBGp6IwPoCYFYMnuslWnLe9Svo2Umr28GxgaDo01
	Z8oYFq3JYIAJGN9XCSe4t4Lato8oCbATo/tBYjfC2Di0bicdAtWsuzDPDLfIpGZ388YfnzDAnvC
	NVXmvcJ0W6mnvztjssKRp/0fV5Si1UyLUHKtMaIeB5GjexqCB/mp58QRl7o85ipluZLzRNXVYKu
	uUlFJP+Qs9sQvC6KHExDz0RECZrFFVyIEHJnfTk7rmQCpngEJseo1/Mp9I8oQcSwdR2SaZc/8rD
	dmwCuGhhGYXLpMMQ4Yhz6oHmRaQ/pB508wrJEWG4Sj4I8VruiXj/lRbrqsBO4aU9zIqPYr1IUux
	G+KHfid4HFHCfTj98vm6PRhNm/53Mn3hW7J38S1xbnu6vhRmjGh++WC4BJiccKlM2hPbbtVX27M
	TTK3XiV+m1sIiMnl7wfWJ0
X-Google-Smtp-Source: AGHT+IG95t5H22OntY/pbbfLfqnWUuWsZzWWeJEZxTk0mNkyBKWTErkKlpkixDlnPtBCqr0giOInVw==
X-Received: by 2002:a05:6402:3551:b0:647:a24f:dcff with SMTP id 4fb4d7f45d1cf-6499b11801amr18376323a12.5.1765976659679;
        Wed, 17 Dec 2025 05:04:19 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f56adecsm2303474a12.27.2025.12.17.05.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 05:04:19 -0800 (PST)
Message-ID: <b2b0e592-b758-4551-85f3-9fe36cf4dff5@linaro.org>
Date: Wed, 17 Dec 2025 15:04:17 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] tools build: Fix arm64's unistd_64.h dependency
To: Leo Yan <leo.yan@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20251210-perf_fix_syscall_header-v2-0-b18b6016e0ea@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251210-perf_fix_syscall_header-v2-0-b18b6016e0ea@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/2025 16:44, Leo Yan wrote:
> Arm64's unistd.h is included in the tools build, but its dependent
> header unistd_64.h is missing.  This results in only a partial set of UAPI
> headers being available, forcing tools to generate unistd_64.h dynamically.
> 
> Because unistd.h is widely used across the tools directory, relying on a
> dynamically generated header is fragile, especially when a tool builds in
> multiple stages, each of which may include unistd.h.
> 
> This series addresses the issue by adding a generated unistd_64.h
> directly to the tools tree, ensuring the header is available from the
> start and eliminating build failures due to header dependency.
> 
> This series has been tested with Arm64 cross-compilation and confirmed
> that the BPF feature is enabled in perf.  It also verifies libperf
> in-source builds with applying this series.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Changes in v2:
> - Added a consistency check (Ian).
> - Rebased on the latest perf-tools-next.
> - Link to v1: https://lore.kernel.org/r/20251204-perf_fix_syscall_header-v1-0-b8e27f74ed6a@arm.com
> 
> ---
> Leo Yan (3):
>        tools headers: Add arm64's unistd_64.h
>        Revert "perf tools: Fix arm64 build by generating unistd_64.h"
>        tools headers: Verify arm64's unistd_64.h
> 
>   tools/arch/arm64/include/uapi/asm/unistd_64.h | 335 ++++++++++++++++++++++++++
>   tools/lib/perf/Makefile                       |  14 +-
>   tools/perf/Makefile.config                    |   1 -
>   tools/perf/check-headers.sh                   |   9 +
>   4 files changed, 346 insertions(+), 13 deletions(-)
> ---
> base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821
> change-id: 20251203-perf_fix_syscall_header-e280fa931d44
> 
> Best regards,

Reviewed-by: James Clark <james.clark@linaro.org>

