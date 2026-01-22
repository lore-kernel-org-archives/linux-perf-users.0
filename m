Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6025A2BD036
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097627; cv=pass; b=tHWR+RB5pgpDgEv1QiFA+yud4VvvaPjRdA9997e/zbvjFkwoeuEDHChoJp/wuUpb/QORdPaCdP/p0P/MmcuaxnqLMzJo7RtoM7d09DvkXALpTLSUs1ge64+bZkkaSwVm9INPniXh1c+8xO/cSkBx5Ffl87ogb6wwEfQRmHjzezY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097627; c=relaxed/simple;
	bh=FpJBjU4YZpNaIxCHIe1yIVRCNSbNaoLTUhhOcTb3Ccw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeI03DoJd1mwkxeGTonduunGsB43OxKxyDNuk8jvEY8/+eJPkKPrx156gUH5nFyMxqWYa+j7rVkYFSEnfZkaNqG7emOf0mBAOS2Lt6nXPKyhPDH9Sx9APfOfbqNJpYAJ+6hxQwT4NvEaCXW24STHku+JGANN0AgVY3QSdAVyUuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPlliIlS; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPlliIlS"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0d06cfa93so71615ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 08:00:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769097621; cv=none;
        d=google.com; s=arc-20240605;
        b=VbeSVgjM8CKCHhCs/9Zi09DmVMPP3qi+jMRIDWqVDg3T7jK9/LZAR8iNQCjsW+4I3P
         9CouYWm5lmio01vBQqGJS+J5+tkpv+Rijfc0vxfquOXmgyE3J6asuvijp/2rt/BCv1UW
         Hi9wZ+BYFcYz0ucqg6f1OvYAoLnqA+bkzx1UlzQ++RRBbZgHP7+MLnoETiINtFqwqVwB
         D+W9OVLEs8JUHVZqHlXuUetaro/t73KhbXUEyymkVvrM7JRzHMQcveI/MUYEbxt7+JEs
         G7m9MPnbRsxejhtCtSMLuYcGKBK51U/qtefk1hBLL4fXjtF2+2LhwgqGvoOc4GTAi8A4
         aFOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k+gcw1623lQHo2cfnTvIWFjPYSweoDjGuO09+tINKEw=;
        fh=/jv9R5lSzDeV08Hq/FAwu625v7AwVn3xGHyUFz3NLcI=;
        b=kkbftGoP9+o0XtxhIcpoPd72My7aR1QOiKgkaNPfgUXLIh70g+w1ul32Q4HBP6NR5p
         fwBaTSfwFCeUu5/5/oxHPKM6hyEFte7YRS8p7Lf5yFA5hUEQtCU+n/kS6iTQa9PxQane
         SF90hZqwMNqxCJem5xiLp0YOjiEA4j/kgnkAMD24t3wUemhZ9LQDWnEPkWk+DUMQsmwT
         StJWZvxCS0yCbh/D5EUzFe+k2xQTfgjFG0X4VJFj64vHgwk0IDgPXHRboljY5odcxMeu
         H8KfuESvGsQKWomv0lg55Bkt1IYbP0Yg1OEQ5ysqDVc0ikEH4AlqEKhGtvrea1knyeEV
         de7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769097621; x=1769702421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+gcw1623lQHo2cfnTvIWFjPYSweoDjGuO09+tINKEw=;
        b=nPlliIlSbdo5gp/aPrT1ApOF7jRNFgBaSRugsoYpirenLDIDTCy46YPKRfjp3+rjY8
         trU+jEf+bmnEvMEZqVc2lOy9s5/T3k0JLskTlJLB3f1grG+Q3W+Y9157dtoKUId9tx/b
         hWjkrNWbGDNo2i5vXyU35A32wNcUU/vbEHDyfD9X7N0Q9GcqYAJim3aVkmvigfGkDqGj
         BEVjHtr2L8/YGsyh1tAhossLAw9IJ6UKFNYia8FiPir3PYB09q+XBMc32YEYLP5l8hnz
         JDpwBfTav7RYPvX8e1Cv1h/s+F+X7P5Vnc+Xxm+h47HAnnlUEx6CEO20qzkDxXRKaaga
         lPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097621; x=1769702421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+gcw1623lQHo2cfnTvIWFjPYSweoDjGuO09+tINKEw=;
        b=lroQgV8UST0G9vby4WcS18rTPh2kM+JKsANjfpP5sVeLV/JcJMdTMd3R2cA8vOm+nr
         5hwHV2Axj0itApUnXa9EdP1SpxOXeJ80pNMPtfUwaMKk6jD5OCA3p1sOClBWh8N37kDK
         jFXI0RxRAb8Q0wLkZslsPRrWLa8M8aZgQciRsmJCeZ78QGZy8WVQvOMWUZyHo59ZZLi/
         T8HugE0dGtZlkHwBCyfoydANaw8sJA5pFagITCy/Y1LpPpSrHAYeFDuh9fNBElxT5GCJ
         ywmqCssLzuTsn194DO0ZTKD3XNtFyE6SfbOuHyq6NtYjuoE4P9o6l/sWbtk3ODyjpeXr
         Ty/g==
X-Gm-Message-State: AOJu0YwfrMAfZrsf0bbq4LyIp6+KUh+kHaPxeTqUX2nAyQryPfyN8OQl
	tUmjViyl/MSrIRQjw1GE0ixuwedJWxNbomCZ4wgVPPrHhuOfbn/y/WLO6W8dy6qZ2NvsOAsLEvt
	0cdpbKJJhkg0J4BGxOiusH7+01GS+zN0HUGwpfwSp
X-Gm-Gg: AZuq6aJTjSpT5f/PLvOUn/VzZQJBRXsS5gAAbQKU093WHXbxBJ8AnsRlD62DaUpqRWJ
	Rfak9fz/Ktad5jbQuTTy/ZIrONE+2+R/rnCE8nXJMk3318pYvi+QGPtl2Rvrzsi/OwSMd1gVgqH
	Z9X9MleccypcrTV/p1d90QYB49Hg0pQDZeR4F7WJd1i/4REsim2Pt/AUQKdKXYDtljYv4lOtOIw
	pZolAsHb8wkteszV0vS9vAa4SS5jKGHlhy9TYtHJh8wmUbdkETKGAdAumWnw7/wdkjJC6nnIo52
	X6KikW3VQRpyAxy7fBxEExWFZhHqY+xxmcmrRc9jqJ6tqBo=
X-Received: by 2002:a17:903:120b:b0:26d:72f8:8cfa with SMTP id
 d9443c01a7336-2a7d67659c9mr2355425ad.13.1769097620474; Thu, 22 Jan 2026
 08:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9a7eaa4f2e50a4ab2d98781c52bce6f98568a888.1769069215.git.sandipan.das@amd.com>
In-Reply-To: <9a7eaa4f2e50a4ab2d98781c52bce6f98568a888.1769069215.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Jan 2026 08:00:09 -0800
X-Gm-Features: AZwV_Qhc0xAEoNE0zWyMtOvAikMxZo0_98iQoe24FizmlAQVi71aDp33NIfPBpw
Message-ID: <CAP-5=fWH+GT-wuw5e-0MQQanUNMqUGVD+V=y7vq2jN4xe_GEmQ@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events amd: Fix Zen 5 MAB allocation events
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suyash Mahar <smahar@meta.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 12:10=E2=80=AFAM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> The unit masks for PMCx041 vary across different generations of Zen
> processors. Fix the Zen 5 events based on PMCx041 as they incorrectly
> use the same unit masks as that of Zen 4.
>
> Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
> Reported-by: Suyash Mahar <smahar@meta.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/x86/amdzen5/load-store.json | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json b/too=
ls/perf/pmu-events/arch/x86/amdzen5/load-store.json
> index ff6627a77805..06bbaea15925 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
> @@ -70,19 +70,19 @@
>      "EventName": "ls_mab_alloc.load_store_allocations",
>      "EventCode": "0x41",
>      "BriefDescription": "Miss Address Buffer (MAB) entries allocated by =
a Load-Store (LS) pipe for load-store allocations.",
> -    "UMask": "0x3f"
> +    "UMask": "0x07"
>    },
>    {
>      "EventName": "ls_mab_alloc.hardware_prefetcher_allocations",
>      "EventCode": "0x41",
>      "BriefDescription": "Miss Address Buffer (MAB) entries allocated by =
a Load-Store (LS) pipe for hardware prefetcher allocations.",
> -    "UMask": "0x40"
> +    "UMask": "0x08"
>    },
>    {
>      "EventName": "ls_mab_alloc.all_allocations",
>      "EventCode": "0x41",
>      "BriefDescription": "Miss Address Buffer (MAB) entries allocated by =
a Load-Store (LS) pipe for all types of allocations.",
> -    "UMask": "0x7f"
> +    "UMask": "0x0f"
>    },
>    {
>      "EventName": "ls_dmnd_fills_from_sys.local_l2",
> --
> 2.43.0
>
