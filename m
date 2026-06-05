Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E2E3B27CA
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670098; cv=none; b=HCLf/R0FU+VXzGN2ItGXDgkJrXUZm+SpzZt6gATT5ZWiwkRX6qGgmUOwjU2K+QH+DDal6Mv67oUbp/sLwCyxnQtBJzqcGoX6LJBfjzgaT1AyEok+mCg71KFtyz9oXXsz+3mbkFvmu/svQWvSnN80f3sLHX+j/HRxK3WMVPOIf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670098; c=relaxed/simple;
	bh=BBPXkhlCYUnSkpoUBur8i9YxzhRupV2fA4FOufbiOO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plcF9AOKumswc+OKKOxpTrRAyb5d/vKk14BZa239XOPwhoXsOKp5r8W3bVyw4Z8ZYNogSV4u5o56ffU4epVCHRxx6jCDHlJgpd8/uF2aPAKLwQeQ7fGmX83fVY5l+tlnPYNwrHlf/tEYkRfs4UqiRCK2KGTllDoeGOCJlRuaaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzmlSzxN; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzmlSzxN"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69d7cdd3b8eso882789eaf.2
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780670096; x=1781274896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLdwiJHSU4Q+4eyeFL1u0Q7e2dgaSzumZAqy9rI3RQg=;
        b=SzmlSzxNkxFprYPRq8Zjojp8oDsoLbJzNAA9sIHC+z8lYOmzIjSo6SFFw6PzugMSd9
         VUKZXkGtw6Zlv8ctI8Q8BPJdXoQlZYhdaKY1C16aavBMbL0OO7l+s1f3L6gx830bIjo6
         Z7Mu94TFq+IHPanM3W1FqujWuvfeUHKhPF8ot07WTLl4uonIta+TBFJtERUgB8aQDvx/
         gz3E8aL+6+ThcnJy0vrJGcWqQII8HcvpuIxIxpKkOuqfT5Q1xlbxPr13GJ02bKP86jUW
         /NlGmJ3ZXZPN7fFbZYzCAouKxW0N6Hwi6QBVN8DtxiId7pBJsAz/gqBIa2/S07cZ6laQ
         Tcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670096; x=1781274896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLdwiJHSU4Q+4eyeFL1u0Q7e2dgaSzumZAqy9rI3RQg=;
        b=mrZE64YWiwU9UlvT4Tm4HBXggjbHrBhzn8ShzS4o9cc14MDfJIv1LblDhobGTLtQ8r
         /KOXYsCm8JvAIeFD1u5F/BTb0QMUi3vvuNiicogv0fDwEKKXuPV6svb1Vcxyqfnp6Dz5
         YJT6qcEKtkRt2zH/gUna23RLKTv/41AaHMr1g2RlxsFPin2nh260H3OzxhmLQes1PS5j
         oD8ogfLod4JtgFuSKPLfqOqiypKze1FqiUXNca5O174lEOMw3TEuavSdiybSuAR6zYNB
         HYJIw+M4ovsmuY7OojOpMz6XMlckyLz6pkgMi7zowLDZE5BmHpNsHxY/rF5Qkoec2Fzt
         wPcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ztcOKxb/P9wqvU2Sehxh0EBgP7WLlQr6W1A2fFbq02Wdbf9G8//tjEaA9kq84SQX+membilFzOe/VD7a4HAr6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3XDe+qZIfYNsy53qtYt00iagBtaXcfP/aSCPZLHBvKUbXXl1J
	TDnDMX/b9PI+8E7I3imiuwKNGYNc2TkHl6+qITKBMOhIgHubCjqz4wmw
X-Gm-Gg: Acq92OE8CaHqbhFVutFCv0qCJZKtyqq+LQh5jgDxOZKAu8+m8Gyrt2U1g0gvcuA7dKc
	f5cncOhEVTUmp1xHbKQqeeQ7yE/Xi6zd6EMANQVz2GXQZj6YDgJZA/ACqyUNaD65ldwdnQSefVr
	Wlb53FYi0jsYs5sWd2uaFt299kqyWyR3e9p9cpCVzobfvFOc7SvqYifb+CHvdLOkXFv/nKP9gdC
	oWvoBsMs2whjXQVwcUkXlhoCmgf9zOaKdy2NEgIkKoPKv7v9FSu+BlT7ZD9c7cq62dFZG4Qud/A
	9uvZDtUIk6EN9HlGvfGiTkiNh9O+5N22o1GcgtfoFO7aE29cc1M9W4tB55fj3w85O8JrV0NEYHO
	xt0ujkGHKY1XLmOVO5gXz6P8styBUv1NX0cgsgd+zMAZuG/QSBimyyzoEDCG9F1CVb3LldW1BVc
	gdrhnFLgzwHfsudBwqN8VwkhpMuswYdFhJDswriFaR9ocir7cJjqbMCs6IShah3dyw85vsWHXEM
	Rl1ao/YJ2IUTUeJq7Y1zdQpf8nD
X-Received: by 2002:a05:6820:4de8:b0:69d:fccf:90c4 with SMTP id 006d021491bc7-69e68b7d97fmr2028321eaf.23.1780670096499;
        Fri, 05 Jun 2026 07:34:56 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:856a:da39:d9b3:fb8f? ([2601:282:1e02:1040:856a:da39:d9b3:fb8f])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-440d9509e0esm7909565fac.14.2026.06.05.07.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 07:34:55 -0700 (PDT)
Message-ID: <b30d8432-3512-4053-93d6-77f2be96a796@gmail.com>
Date: Fri, 5 Jun 2026 08:34:53 -0600
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] perf sched: Cap max_cpu at MAX_CPUS in timehist
 sample processing
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@redhat.com>, sashiko-bot <sashiko-bot@kernel.org>,
 "Claude Opus 4.6" <noreply@anthropic.com>
References: <20260605121515.1725549-1-acme@kernel.org>
 <20260605121515.1725549-5-acme@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260605121515.1725549-5-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/26 6:15 AM, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf_timehist__process_sample() updates sched->max_cpu from the
> sample CPU without bounds checking.  Later code uses max_cpu + 1 as
> an iteration count over arrays allocated with MAX_CPUS entries
> (curr_thread, cpu_last_switched).  A recording with CPU IDs >= MAX_CPUS
> causes out-of-bounds array accesses.
> 
> Also cap the env->nr_cpus_online initialization of max_cpu in
> perf_sched__timehist(), which could exceed MAX_CPUS on very large
> systems.
> 
> Add bounds checks before both max_cpu updates, matching the pattern
> already used in map_switch_event().
> 
> Fixes: 49394a2a24c7 ("perf sched timehist: Introduce timehist command")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: David Ahern <dsahern@gmail.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-sched.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

LGTM

Reviewed-by: David Ahern <dsahern@kernel.org>


