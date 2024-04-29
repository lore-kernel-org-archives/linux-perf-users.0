Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9919126F2C
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412506; cv=none; b=JsDTONr524z4vGFE8inQ+gVxJ58pDEQ3cU+S3B+l8w59Qjq1/12cA4Ur1h8xRyuj7x9UPwkqLTJwynJ/TakFRqGp5oKjWRm8DDEOhkbuL9Dat5smSbC5etoV+0+HuCwRasVugytSKRq1AttaF50xTPuZZClmKJ7NsN5FBnBJPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412506; c=relaxed/simple;
	bh=L3srICNZ8JI+jJ5xdpdatcPeFVLD+JRjtynT6KPWQwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttNA2hxDRtE3HcS8gsn03/9Cgc7xn/CtjjT9ZiloFMCDm9Mf7OhBhJ2O6dokh32E9ld7f6foTUD78fLurNvuS5HG+/tNgcCxZ3qBkOI3YAYNF7rC/r++P+TDeyZM/rCdmvbeLnXf6Zzro2Rvz0AA2QSwoQSmCWQNL/npRLZBbo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nrTcxYfc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nrTcxYfc"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ac16b59fbeso4075806a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714412504; x=1715017304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrFu2prq6bdsJ9xfjkBw/azXyVVdY+Tuvcz8oe4FnI=;
        b=nrTcxYfcR0t3aSRYhopkRqaKTLUxxt+ppXbvlRFqyuAksPWV7s6JQvULK70p6SeAEm
         59gHWkcJO159xgA2vUV8ntrn18FYE2xgehmKn42ys/vEvAbj9s4caL2RivPbAo6rRPgf
         a8lxzusI5PJAOoZaPsEJC/VxC8WgjHeLG8Yzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714412504; x=1715017304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtrFu2prq6bdsJ9xfjkBw/azXyVVdY+Tuvcz8oe4FnI=;
        b=KFiBNIK+lldVigCGMnSCaFgOUkv0mnkW+CW+cWYpj6B3g51cmbDfvhpwQoTMAZJQPZ
         wtNWPm4tC2/vI92a6Pu8f13tP9z9yK1/qnQoJaj3GJ0e8q2IPiSCWmLT9jy7ZukPzBph
         swrNeSSl+C9AEoTCoZqdX2VSqNBT95tI/vSCI1g5aE6+wnWIT6bsPne0iMz8y6XUm4bp
         D7FMKPS1gaUAiem3BySu3kRJvDe9OCbyhyEUvoZQXiO56pSeRXpRyv8+szGLHs8pVxop
         ovKCgFNnHUj0eMuB2683OEUewPH3M/gFQC1E5CycI3qZ7tKpbRQgsUhY5md2Ey/o1ttH
         brDg==
X-Forwarded-Encrypted: i=1; AJvYcCWCtZDZfc8m3hbcuV6C3WMJpqeLvCD0xknU+bsNHYQxNIzkEZj1Ly4ppbhnWzAO+ZqXqbjeU+eIncep3BXCTcOtQtEGrlrcopwrWrIjN+fH+g==
X-Gm-Message-State: AOJu0YwPovga/fZisg4ODjATSps1bJV9Sak0pBAmsSNuYLG2XMTW22RU
	ueIYh6ubLAD3jLG14PHgI2BTkYyjRcWmz4i/IV6fLZgZyY3mGHxUib0r0wPjtw==
X-Google-Smtp-Source: AGHT+IFATNf22dm2Wr01Vm5CDgIO7XF7i/x9IJ3rUpHw3Y+PYyfZIOmgFROcKdptZa50eHmABN+8kg==
X-Received: by 2002:a17:90b:3d86:b0:2ac:40c8:1ed3 with SMTP id pq6-20020a17090b3d8600b002ac40c81ed3mr10595967pjb.5.1714412504165;
        Mon, 29 Apr 2024 10:41:44 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090ad60300b002b233a9f1d2sm895829pju.42.2024.04.29.10.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:41:43 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:41:43 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] perf/x86/amd/uncore: Use kcalloc*() instead of
 kzalloc*()
Message-ID: <202404291039.E21F02B98@keescook>
References: <PAXPR02MB7248F46DEFA47E79677481B18B152@PAXPR02MB7248.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR02MB7248F46DEFA47E79677481B18B152@PAXPR02MB7248.eurprd02.prod.outlook.com>

On Sat, Apr 27, 2024 at 06:45:23PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe. However, using kcalloc*()
> is more appropriate [2] and improves readability. This patch has no
> effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> Changes in v3:
> - Update the commit message to better explain the changes.
> - Rebase against linux-next.
> 
> Changes in v2:
> - Add the "Reviewed-by:" tag.
> - Rebase against linux-next.
> 
> Previous versions:
> v1 -> https://lore.kernel.org/linux-hardening/20240116125813.3754-1-erick.archer@gmx.com
> v2 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237A07D73D6D15EBF72FD8D8B392@AS8PR02MB7237.eurprd02.prod.outlook.com
> 
> Hi,
> 
> This is a new try. In the v2 version Ingo explained that this change
> is nonsense since kzalloc() is a perfectly usable interface and there
> is no real overflow here.
> 
> Anyway, if we have the 2-factor form of the allocator, I think it is
> a good practice to use it.
> 
> In this version I have updated the commit message to explain that
> the code is obviusly safe in contrast with the last version where the
> impression was given that there was a real overlow bug.
> 
> I hope this patch can be applied this time.
> 
> Regards,
> Erick
> ---
>  arch/x86/events/amd/uncore.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 4ccb8fa483e6..61c0a2114183 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -479,8 +479,8 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
>  				goto fail;
>  
>  			curr->cpu = cpu;
> -			curr->events = kzalloc_node(sizeof(*curr->events) *
> -						    pmu->num_counters,
> +			curr->events = kcalloc_node(pmu->num_counters,
> +						    sizeof(*curr->events),
>  						    GFP_KERNEL, node);

As a general aside to the original code authors, looking at struct
amd_uncore_pmu, I see stuff that should likely be u32 instead of
"int". How is a negtaive num_counters ever sane?

struct amd_uncore_pmu {
	...
        int num_counters;
        int rdpmc_base;
        u32 msr_base;
        int group;
	...
};

-- 
Kees Cook
