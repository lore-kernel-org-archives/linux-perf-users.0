Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B42DF124
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187551; cv=none; b=EUiSdJ4eUPgCeftzfFdGIQhPkUatVXp+67EEh/UbhOrSpv1VZPka2Bfr+ddu5yg7gA4ySzCAGrPsHPOJdiC3fUAzQsaTywnFUXrXQ76s9Jcr05qhPB6vxAStMC//4qFBxwIXXX2VH0EHCl+97ATfgL2qr5Zw1bcBxkZM5gz9Hzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187551; c=relaxed/simple;
	bh=onHsAQTWsUyBs5IX1LlfYCWKBjpstcoF4upDP17pgA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhaMVAiOJhIIP4PYHVi4khda16JJ8xCThYf4OFj6eMLqvOFKLouByV1n6ec8X7KQAX/6AVV4Ed1qaCWFRkkO0nk3vGTdebkpnNYgX1V/zcyd1r5IZD7VdIUSu5dTxfuRHF9zhKRoVTsMnBDprNuiBroLYtIqQsgRoLyZLn28psM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-4240111d446so7733115ab.3
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 02:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187549; x=1758792349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIPAGga4FOA5RTuOCxh82ZFvj8TL8c2aRMORyqNz1+U=;
        b=HGdyZ59szpbmUkEhVVsVqeGcdqvTXdhf/Rj19oniUDHIHUOtmstTwfY1PErsB0j4os
         CiJiIi064lAKcbi+PU+wUy3P/ucvggvA4LsF/CBEKgmj8b2zB/HP1cJ7PS5DT/D8NpGz
         pvhV3QciynZ/85VocvDjqa9JaBv4JeDWqURo93KQHEllCM7rqNcbfDhQUnCjqkZy/zjw
         hM0qMYb8mNbrdDTUA1fpQTq+LG7fBzsB6iOr7ceOuGoyAOF60hfRZA+QqiJTn8HWPUrM
         l0MAi1m/hr4kRjVQkQWPvtMhEt30MZ1hK2JP2KBui+4BglpgkwxQSAe99HsRqsqLJizB
         DO+g==
X-Forwarded-Encrypted: i=1; AJvYcCWT3V/QytOXBx5u4kIQkoCJbeHzdcDys30Ss52RUcZb109I1rmtI8Pl410OsAn8k3TZvZqmpVNyQ0zwBp8gPTiI@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMnNwRvfZlkfEjSwAx4seR/VY0aC0Y0HE0UZG9TjIu2LSldCD
	mh9IXQBD5VT2EQALuU2J4ZioUI+iVSL35ggJiSlNgYB9p81d7yzJVAEuXrUvdDm4
X-Gm-Gg: ASbGncuS4Fda968awGAtctIJ1U7DQR0IPqcpOB6SMM69rjTiACkQerNXRfTSn4r6SW1
	kMSyt8wcY4DruihitqA9Bl882sCnVtduOWAHCjcr+jOJwg7l+9Zk+3yz29TSWNZLcS9Mf2WJNpr
	hlx/E/YIfDgPvhnH+MiHh2HjjwQqOfN4TWokteN/3UsPMZ0BrhSun2npJVH+cPFG3zrGdUXc9ne
	+Wl9Yz2/8MkEpCumYHOKz5f6WvwScxdttY4A0B7E9JKPOfsIZwCYtXi3FEaZIXg/hmDlEZvdbSz
	0HgPbj/ILRErLuYWHRGz8aZRfxFGDO24Io0cNEcuSvz5ikCJMjitA7/AJV5QF53Rw/Ee8JaLhEz
	pv+UvX8m5GFjHiGK1/fiTk8nmXbILjftOV4DalXp9GOR5WijH3r57JJjmm0p3YkR5ZF3R9h4+I2
	vQyZSk7Rw=
X-Google-Smtp-Source: AGHT+IFJf0eu4Btrp1e1p59x36W1HzdwyzA8HX6huLLxL69Q3H5bbfiA4MGVDfQbtt0bQg1tomaOOA==
X-Received: by 2002:a05:6e02:2508:b0:411:7b83:c9f2 with SMTP id e9e14a558f8ab-4241a5297a3mr67916255ab.17.1758187549046;
        Thu, 18 Sep 2025 02:25:49 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d53e58134sm735774173.62.2025.09.18.02.25.48
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:25:48 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-424117c229aso7710735ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 02:25:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWT08CjNESngPU1K8cySPeuV02Lh49ikbY+uBL9+TKvq8Iw78q999HrCx8oLDX0jJIy7qjHT77JXbmCx+UdejqW@vger.kernel.org
X-Received: by 2002:a05:6102:26cf:b0:4fb:de9e:6d87 with SMTP id
 ada2fe7eead31-56d5376a64emr1999299137.11.1758187210414; Thu, 18 Sep 2025
 02:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ms6snut0.wl-kuninori.morimoto.gx@renesas.com> <87ldmcnup1.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ldmcnup1.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Sep 2025 11:19:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+59oaCo5oOqTLhQMDV=SJhvBu-gGr4vUzyyPxEEBJpw@mail.gmail.com>
X-Gm-Features: AS18NWB4Q9Ufki8ANAbzyQzmxL_5lVd8LQK2sw8BXyMmuM4p3Xg-lO7FkssDvz4
Message-ID: <CAMuHMdV+59oaCo5oOqTLhQMDV=SJhvBu-gGr4vUzyyPxEEBJpw@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: serial: sh-sci: don't required
 "reset" for r8a78000
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Leo Yan <leo.yan@linux.dev>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Namhyung Kim <namhyung@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Will Deacon <will@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Thu, 18 Sept 2025 at 08:25, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> commit 6ac1d6047372 ("dt-bindings: serial: sh-sci: Document r8a78000
> bindings") added r8a78000 DT bindings for Renesas serial, and it sets
> "resets" as "required", but it is not mandatory, because driver doesn't
> use it. Remove it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> I'm not sure this is acceptable. This is optional patch.
> If it was acceptable, I think we can remove "resets" from required not only for X5H...

The question is not "Does the driver use the reset signal?", but
"Does the hardware have a reset signal?".

According to Table 12.1 "Reset Categories and Reset Source" and Note 2,
the Module Controller takes care of Software Module Reset.  However,
I couldn't find information about the individual module resets in the
documentation for the Module Controller.

> --- a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
> @@ -126,7 +126,6 @@ if:
>            - renesas,rcar-gen2-hscif
>            - renesas,rcar-gen3-hscif
>            - renesas,rcar-gen4-hscif
> -          - renesas,rcar-gen5-hscif
>  then:
>    required:
>      - resets

> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -181,7 +181,6 @@ allOf:
>                - renesas,rcar-gen2-scif
>                - renesas,rcar-gen3-scif
>                - renesas,rcar-gen4-scif
> -              - renesas,rcar-gen5-scif
>                - renesas,scif-r9a07g044
>                - renesas,scif-r9a09g057
>      then:

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
