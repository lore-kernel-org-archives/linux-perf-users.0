Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793304778;
	b=fXrSMawl9rg4XyoWuKObc/uXIFISeb4n1A3WnMgC2xP/58+Bi0TvhNSzlDx7N0UOhFSz
	 Oe8wpWeUDSbmRrUh0V3fzWcfgL66OhvmuRTWN60BGGruYSdU8+6uHNhs5rTKaGeaet7Lf
	 D/MJPEunIQbPrwb1qtJBNPlQra1gnX6KL3T2Iciv8NmXp4l9N6Fzc8PPyDx//RQ8Qoqi9
	 AHZvQJZKmwL9PD1gzVPSqHLjhLIT018IimEFVQytWF9+EqYAE5jfzIvJwD8Adf8fCII/l
	 TFxteudbdlU38I1GZb+iTn4BdyFvpLrD/NTy2nG8jscwIHKbYcXU5DDtRL2zvOWBOIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8bWnlcqpeSxNOXcW7N0zFPyW3Tqj3tlZ/k1Vs+K85mM=;
	b=Wo+pH7RYZ1bXwn9nEft0Fncn1uYsXwHx/gF/FNEaF5fJJ7yp+PUz3C8a7lvZqlWoPKw3
	 jvvXjPjbkWhqCWcA42Ze7fKqkmHwYIl2JwBl7nuX9f/c8Tk2jlY4xSdkC0m3p2rEg4UC/
	 BuvjSK8I8Iuv41YU2p3kkkYlD5edD+oaHQlnn1kye32yzOdMGrdXHMDr8BXyN5UdHsfv0
	 5iHn3CV4MxyWRi6Sek2xw3hNtSGY6GMmpCAV9DJIP39M5Oei+VNv8seKurKFN3apFZfXF
	 QsNkPZsOEaCnlqIkJbf5rllg80EOFQakESE752dOvzIOgHGvR4g/BwDHcdHWycajwcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ecciuTBC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3CE606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 20:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF3CE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ecciuTBC
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5383c97c8cfso14651cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 13:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793304777; cv=none;
        d=google.com; s=arc-20260327;
        b=MgU9lzxdjM/VWm7ntpm+tWBDUz0yuxAQJ1GBUdjyq8N/XmG/fRY+eHvRJDEzYyDtVC
         Z+aTO5QzFeMgkAvNu79y5VPRiFTXyalW759rNE7Ylqv25jm3xv2EtnNGF0ySBhVaTsN1
         OotwsIgd0VlQfIt2OFBqCwrYSAoJG1yfUpxt7LvRyg9vGoX0cnakdLlFIEZeXaeKa/WT
         VSK+UlQSUXhytVJIy61fZwM7Z5AoxLUmjc52vRXPSLm5b69kNzXdo7IGcLxtZphYql1S
         qGqXoErFbbOtATj6Sa4ndjOdOsjXI4AFY9DOZo8cJsgGaEmCE4hs1Z5v4tmmtAvQqX6G
         UlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8bWnlcqpeSxNOXcW7N0zFPyW3Tqj3tlZ/k1Vs+K85mM=;
        fh=bOYYTiDVmVXY35rxa/dQDK0/kKzDkS1Fmy9ebI4U+tY=;
        b=jp4vRQ1IL8H1VAf/JKdDwEmQPs48xwn08z+qGUA14jepBlUYGbupv3h3UhzLkPx2bE
         avhB89M6AbQ3ijYzz4Hk1pEJRv+9y2yDUrJRZlfJrvGBfe/HgGJBb+UgAzsttUvc+Hp/
         UJBGN5+C56zLOLu3MQad68njy4BFTY8VaDcC1GLJF5g2zuTmIWqQ8kDTaKNznjBXJKgu
         Pcyyxjx7DCUqR7Z4YtLnlgS1fJV6SpHALPhz+h+1KdO7S9NfnsmEqHvJMuMwfCekXpzn
         Uqd211t1AFbLUnV2HWskoQ35FxKTGWj4I2pGri1rvOnBIckQ6/m2bTa7PH/PL9voW2aY
         l4oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793304777; x=1793909577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8bWnlcqpeSxNOXcW7N0zFPyW3Tqj3tlZ/k1Vs+K85mM=;
        b=ecciuTBCqVosdyC5vZpxUYD2sVTPc+IBA634hIVo2LP+m5WGZltDkR8OXGqSltutPL
         Q1xnmtM9qmFE7abAcqoMcltyKO7zlJiF8gU0T4VrEDBdaBPXePHwzw83gzUufxWCikRY
         TYLck7Swry0p26rMh6t0Fb4yyVcCWxCMUqnli/tcNu/6E0chnqAnSVDJuUhK7ihYpnaA
         nG1HzLpOMXT6oiRpKvIv45Dm9NU59XvHr0sx3jHZIi3+6cy2euRk4Ewn3Bnddaz8IRXr
         /U4awhDvQI1p7iCJSMoti1VsJXO4sBq27nLxn7nJB8S8tS7VdjJiUl1ZuLTEm763lc3V
         lb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793304777; x=1793909577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8bWnlcqpeSxNOXcW7N0zFPyW3Tqj3tlZ/k1Vs+K85mM=;
        b=0HlOFnihEPwC/cYV/wwWBeNIqg584qLKsNBjPKy+GXtpzj6/1VLT5IFxEcGEF4s7w+
         J4b0JVub6/leqZgCCjsPr45BbwgcbR12+O1M/LJG3U3A2X12s3A9QXd+USZxVwTcaDzO
         d3mf5f92NMhqQBnexTgB9wseAcjqn5c3yp3YbpFm1nFIpTMR/B77pqoqDGqXH8NpJpES
         xvXmKAcx4MsDoeaGhQc7s+U6K9/CU8FC/bzbaYkUfkff046m/bGz5utzIsAMOEmSzGa2
         Up+vC5FFJGoz5IWTgWXSLRQEu2JX1KAwYN8XrITagvxiStZ9tFW/0+0g8XJwD2dAeSP7
         JzSA==
X-Forwarded-Encrypted: i=1; AKwUvByFLNgiikXjL8/mC/2x+Jkqpm57z5B3+LqPFXqgWJTdE6lzLUQU7ZJJ34x6WbH0gd+W3yIO9I6reOF2pjNRkDna@vger.kernel.org
X-Gm-Message-State: AFq9FYJB3R0DChGBAxEtt7mkUBE4Xlbk7l1eesHEtM/fmeF4F6QsISt/
	YjfnLGPoolMv5+zxFntKwBsIklo8k/95GIIZ/5MZvr6FY2SX4RcB7mGub2UFRzqt6IDQZtvm+xa
	qd6hLHA3SOYYnXXrHtYYzPN1x3aw25mOGRMJnbvVK
X-Gm-Gg: AYBFou1MeSMuLMmhrZ6qj06CnkxptwOasgSrhDdbFPI7/demBBR0M2r6zdE6vQcdnp3
	ATu1w2GqyHKDqgMf+YVobeY58hdSoHgDkdObLAUyEMWKpujXVdFgl6t1roi0BrJZpKs80T+VCs4
	2F7dO4HjFtq/QJkjlqFWjE4ujUw3eEpfdR3AR3LNfsK4L6wHcBlaq2o8hzyhuqZGURkY5uXfC3W
	Hl0InkAfXqkp0TBUpbnExHP3AIbyB6dPBN6GG4vrzpO7BBYhQY80h+nHPUyZ0Yrnx71WNhFVNO0
	NHC2Jxmj0kjatGbiziZca6/zM+VJKmLRvQTOSHtgIVhq74O8FAXLJkHaLMJPij/g5TYj0zWhykn
	vYYFJAyUZAN35nF3+awRaOaVqfJvGTVzhiBSB21xX63WsU0NxhSHYbsW66865jwOIi7I=
X-Received: by 2002:a05:622a:418b:b0:530:e335:4ef with SMTP id
 d75a77b69052e-54129c3a014mr30493781cf.2.1793304775935; Thu, 29 Oct 2026
 13:12:55 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-perf-tools-next-v1-0-a75a2b64a15e@akamai.com>
In-Reply-To: <20261029-perf-tools-next-v1-0-a75a2b64a15e@akamai.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Oct 2026 13:12:44 -0700
X-Gm-Features: AclHuK_VHX_q_V8G3T6Pzc6cduP2r3fHbp2JuReLyIFbTTF9f_ewsz7fsH6vG9s
Message-ID: <CAP-5=fU=rb5f0X0ArWj3JRZDwrwM2Q341RPG-UJmYX2tUSpUbw@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf jevents: Add IOMMU PTW & device entry metrics
To: jlefkowi@akamai.com, Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ben Chaney <bchaney@akamai.com>, Matt Pelland <mpelland@akamai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:06=E2=80=AFPM Jacob Lefkowitz via B4 Relay
<devnull+jlefkowi.akamai.com@kernel.org> wrote:
>
> Adds AMD specific metrics for the IOMMU with respect to page table
> walks and device table entires. The metrics cover ratios, rates, and
> percentages with respect to any event which might be triggered during
> a page table walk or device table entry lookup.
>
> The metrics target Zen 2+ processors and use the standard amd_iommu
> PMU events. They have been tested with a benchmark C program that
> purposefully thrashed the TLB as well as with 'sleep 10'; both of
> which work as expected.

Cool, perhaps consider contributing them as test workloads:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/workloads

> The changes are split into two patches:
> 1. perf jevents: add iommu page table walk metrics
> 2. perf jevents: add amd specific device table entry metrics
>
> The specific metris added are:
> - lpm_iommu_dte_miss_rate
> - lpm_iommu_dte_lookups
> - lpm_iommu_ptw_reads_per_tlb_miss
> - lpm_iommu_ptw_nested_read_ratio
> - lpm_iommu_ptw_guest_read_ratio
> - lpm_iommu_trans_per_sec

This is great! +Ravi Bangoria who may know of errata around the PMU,
etc. There were some Sashiko nits, but I expect to add reviewed-by
once those are addressed.

Thanks,
Ian

> Signed-off-by: Jacob Lefkowitz <jlefkowi@akamai.com>
> ---
> Jacob Lefkowitz (2):
>       perf jevents: add iommu page table walk metrics
>       perf jevents: add amd specific device table entry metrics
>
>  tools/perf/pmu-events/amd_metrics.py | 81 ++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 80 insertions(+), 1 deletion(-)
> ---
> base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
> change-id: 20261028-perf-tools-next-8fd1d433316a
>
> Best regards,
> --
> Jacob Lefkowitz <jlefkowi@akamai.com>
>
>
