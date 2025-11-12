Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EEC347BC3
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975897; cv=none; b=RniNvngvIuhjEdM/dTWyH5m1YBtT9NJ7IrX3N8xjmGpuhIIUIlVfj0uAAc+c/HsKLMr1NrJVrxXOxy5WoIAGw/B0mbQQSbXH0cPfR8Nss1/p3kEunWEHO1FS9D0teip1rbTqoli26oN2X6JBe24uUoe3Ld6NI/bI6izghynCgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975897; c=relaxed/simple;
	bh=2z30Onwslv/HKcZ2MyBEPI3V6h4LiyRU3iVn30ZBBiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsJt1gabM9yVQ0LvTHymNm7fxzrbBsvquM8dkTYuzW4XW3HTyhwypimeZ/kSBT+RxJn8TM6miSE+rRGA9jYF7bAhaxKu04hh7Mx0hJbDEitA8RwVRFG1y6SOFgY+l5hzcxSOLS6wc7E9zvWYN7rutr6cIwoyVZT+DV3TlvHsC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XI+dJR2B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XI+dJR2B"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-295c64cb951so25945ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 11:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975895; x=1763580695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcvUwP/777L/eN/ikRIeQAoirqn6cF5E9VLK5dHu84o=;
        b=XI+dJR2B/uhl/EcDhzNuv0JxL8HI8tLeFuMI4cd0YVx/XV82e7sYf3aLlwUzklIGWC
         RwO377HM9ThSo80U3843yMPz6UaoETJWPKslnD7b5wLaANRCdt87v7zZ85/o98KHB0tx
         unffjRMQXuUaGnEIP0CNms81TT7uLLIAt7kiGpEUHKTcWxJ1qJocYLtgza82Hyeqc69m
         lrgKVzuQPTWE39jxE/fC7HXpTKgi+CskkJ+ovHXcXKoPH6hc77k9I1K3c8Pvwu3E/Dkj
         PaXjnx/wVIgmrf+gi1MLhWdD5iaNW9hMq15qHvfy1sGfTDPbN6an+cJIgZnBgEyrh3yd
         bd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975895; x=1763580695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RcvUwP/777L/eN/ikRIeQAoirqn6cF5E9VLK5dHu84o=;
        b=N2PeseYzCIWCbRQU2nkT52wjUdCNBKzCmMImir76OHElcx4Lu2NtFjxNPVEuLe6rSa
         2vCtYO1ieQuug2ESTaIlKQtSrCYGMEjiSVC1XiaUSDDNXBSGC00nRgH2GV37g6qN5cVu
         c5SboZlC3910nv+8cgTOznM9ZD0UjzhnzcfmPXayDqfqdDHwMnAL7DmwhcokFdEQaoob
         OXH9bo4VJ60OGyLBo27j4G66pibb+VzmUbJGctaVZ3+sOeQv/nmJNIkUnu4C7Zml9Fmb
         zb5iYh6JDNw8tJ7M6sF/Vgl/NEuYSCVHSXuwqH+E1AG+3JvUUbsdo72q4xWJRkkp4CT0
         vqBA==
X-Gm-Message-State: AOJu0YzzZu7dkA01OTn0ziC/yeHP8epo3iOl6QJ65UQpHhU6xoksu8d4
	IwUv620qMvrtu3Dq1bi4tMDPwzs9fOi2U6qwg6Ewbz/+3lihUUg3HwIPRTsH0tIIcGFYRraoiR7
	kQz+cwppmXkoO6FbF2+z9C+HoMzUMs0rh7rpCDFQg
X-Gm-Gg: ASbGncsBWSH6zk/R3Qk6vfwqRyUVjvVT8GU0hf4wMUMKLH8tuJSOUA+yTT4lrl0QYep
	+UoPa1sLvm2mvEMeIKymAzGpKsPo/ZO8wNkqQDw7vdUhRXOHTYbgIFx5aEr5yzL/OV67INMseT/
	iDvAgnVhbAoshygdopmOtmNaYHOkL9eKJI2KE4oSRa29uYOOjVxd+8whLwYRGR6vYZouGkgDLpk
	IKLsKZMD2uR/VbFsSr/Feg9gHO8QapasdTN1cXTiJVczPV+ZV+hkqPXcFbcy+DHS3GFgkdu86LP
	v7DSG5GTP8x2bEbyZEbYkgYdQg==
X-Google-Smtp-Source: AGHT+IEnanRTpKm63zCv33Zb9RXdVcyIJoICIdpTLlTnSgpNWbSyREWjSVvWZ7Ny+8nzA7PjgTs9GzQPNFbYFlXOfLE=
X-Received: by 2002:a17:903:1251:b0:295:30bc:458e with SMTP id
 d9443c01a7336-2985b86993amr471875ad.3.1762975894761; Wed, 12 Nov 2025
 11:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031162637.1456191-1-irogers@google.com>
In-Reply-To: <20251031162637.1456191-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Nov 2025 11:31:22 -0800
X-Gm-Features: AWmQ_bkkiP1GXmQJX6oJj_AhVOQ03vFxJ4Fxk2Kf9lhezAqqgbeGmvhNAnlI74s
Message-ID: <CAP-5=fV1bobHM5bT8xU7sxZAFt03XNaXwTQVGj3hm9RyKsH3fw@mail.gmail.com>
Subject: Re: [PATCH v1] perf vendor power9 nest metrics: Correct unit from MB
 to MiB
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
	linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 9:26=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> 6.1e-5 is very close to 1/16384, where 16384 is 2^14, i.e. a power of
> 2. When units are in powers of 2 the IEC unit is MiB (mebibytes)
> rather than MB (megabytes) where the values are powers of 10. This
> patch corrects the unit for uniformity and because such units may be
> pattern matched against.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  .../perf/pmu-events/arch/powerpc/power9/nest_metrics.json | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json =
b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> index 7a5d1bf543f8..8d028a7c2777 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> @@ -29,25 +29,25 @@
>         "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + ne=
st_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
>         "MetricName" : "mcs01-read",
>         "MetricGroup" : "memory-bandwidth",
> -       "ScaleUnit": "6.1e-5MB"
> +       "ScaleUnit": "6.1e-5MiB"
>      },
>      {
>         "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + ne=
st_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
>         "MetricName" : "mcs23-read",
>         "MetricGroup" : "memory-bandwidth",
> -       "ScaleUnit": "6.1e-5MB"
> +       "ScaleUnit": "6.1e-5MiB"
>      },
>      {
>         "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + ne=
st_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
>         "MetricName" : "mcs01-write",
>         "MetricGroup" : "memory-bandwidth",
> -       "ScaleUnit": "6.1e-5MB"
> +       "ScaleUnit": "6.1e-5MiB"
>      },
>      {
>         "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + ne=
st_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
>         "MetricName" : "mcs23-write",
>         "MetricGroup" : "memory-bandwidth",
> -       "ScaleUnit": "6.1e-5MB"
> +       "ScaleUnit": "6.1e-5MiB"
>      },
>      {
>         "MetricExpr" : "nest_powerbus0_imc@PM_PB_CYC@",
> --
> 2.51.1.930.gacf6e81ea2-goog
>
