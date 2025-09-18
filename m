Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD322320F
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189237; cv=none; b=pylvGmwYuVx5lde3XYn46J3eGAVDhjDAUTtkyPHV8ty1POZrRNpFkN9Hn1L8JmDgTniaIXxNmBHNPZG5dSEUPPhCq+hHmRQdXSK9RZbO28CC9rX/RpOlrbbZuavDYN8YN5GQ4HMO/ZD6jCh/ajkSU2/jJLe3tYEkPjONziedZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189237; c=relaxed/simple;
	bh=tJj9rQD66s1ZsqtyiQYDVNQ/XIehZY5bWaCYzk/MGHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/FTV0X076Z1oWvg6tM8JKR6Mmg9hjepsb7NU6YV33wuHR3/Y2efVF8ZD7j1XTuwzhQSgFfP//NJr8r/S3dBDSXdN5UbHHZhyTh8JdqaNB+nAvLeCoBOkyGC6Z4b4g11K2OLPYcYAFyaVBmpRg22IJ4jSRIvkMTQb/VSUg+Qpjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8b32453d838so519476241.2
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 02:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189232; x=1758794032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAV6+U9ykOwvp8+2HatYYts2BEiZRGxqVQPDnpRww3U=;
        b=s1xIcPx+333I8PlqtwpHuDCvzNVZnBKiff0SWvw0RaFzbF0aaHtNJiE+rdiBJPRxzZ
         kSqlRUL/AWKvv2VV6nLAd64e925wAndsToz2H7BacIa/v7P6aANhZFtJVk6MUCRThvLl
         msQlTLLjegC2B4ioEW225V3z5h15iZyYZPW9AYPg3i5Q8U9eCOUooXGwTpv1Xi7mANsd
         6rCnO9HTBKV7+xGqgUxlsRlBQn1mYLKO0svURQyRMvBeSJhXFta6r8jpXqidt5o8JlOh
         b5nhzfzDWGmQqNuBt++Za62D8jjH4iDbGsUws84ige3SpwhogH0kYe7L4w4dhGqu5UqU
         +BYA==
X-Forwarded-Encrypted: i=1; AJvYcCVg8yw1U2TMYW45/Oi0qnK0lG+LOm/celqoekPwdw4iFc6evagcnwTw1IAP/+o4GtuqnH45FkMqR9t9pB2YPX5+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vfkdm2JGlK+5FXJOj6zHaQC3wAMVGq7detMPUKYmS94HdFsm
	Y7jLxcQN4R+fzwJB/5BukJULEWIXqvFkRWnvXvAQ8GYDssmQA1Pcq6zU03FnU98s
X-Gm-Gg: ASbGncvOcgQjztESxGHMoSHY/oYRP+ayFy/3v5FsrcGCBLPFriTjXWeRNZmpNG7bmjV
	wL0eHEG6lp7toXzCeSbdF7pNynnBHAHY9RF1p4O/5Xj5qmZ+NcVv8SLTljUkBulwdtNbYRLFriJ
	1D3xKNdAd74w9L2crUQFEwv/41vcyvtZVPZNtLpVmhp6HVunCS38kr84K6yLIckveZJxcxXFFiu
	fUHR2kWffkmVkyUSKpaSXQIOn1xHlaWwv5taYH4MBpFNwGdoncvfMA3F7m1T31T5k/xwOaDtgAY
	7XV+m1JqvrrREcLqV/XQl5QrK1JLh5GZ8pXBan/X2GZMJUcUnYnHrLQ96332+Cvf+RsBFRf0ZDO
	x1185ZTTmHVECdFm1fmItWo326Kv3LgYLvmw1C7yoz8XiduDPheo8E9S+vDBzd3uZdjpyRTlEFW
	Sf5agLcyHJCKVmzQ==
X-Google-Smtp-Source: AGHT+IH9eZeHgrtK4zIfmHN92s9EGl6K6bcn0arW/nLawd4YKa57oZdjOu1ErRsqdKA2H2lrtf4f/Q==
X-Received: by 2002:a05:6102:6c1:b0:527:8b63:78fb with SMTP id ada2fe7eead31-56d6ec7297dmr2114749137.34.1758189232489;
        Thu, 18 Sep 2025 02:53:52 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-57a02676a73sm485853137.11.2025.09.18.02.53.51
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:53:51 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5570a77eabcso565678137.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 02:53:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxoQkSbWeGuf1/0hTDimVGymA6rkIvmkaO9CbDnWcGufUCJRvnaUjvW7vfM5MY34489NRGXWgzqpmkIbdHTzLw@vger.kernel.org
X-Received: by 2002:a05:6102:f96:b0:524:5653:81aa with SMTP id
 ada2fe7eead31-56d6a96ba24mr1974782137.27.1758189231483; Thu, 18 Sep 2025
 02:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ms6snut0.wl-kuninori.morimoto.gx@renesas.com> <87ecs4nult.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ecs4nult.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Sep 2025 11:53:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU6KkM4+0tDzxNLQhWzBMs02vx=DTQ95D_-u+YYAcNgRg@mail.gmail.com>
X-Gm-Features: AS18NWC_4v91tXzLLOBSlDGTfgVal7mv5u3w5QpZG0TVZ1CRDcwzHECf6Dh9qXk
Message-ID: <CAMuHMdU6KkM4+0tDzxNLQhWzBMs02vx=DTQ95D_-u+YYAcNgRg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] arm64: dts: renesas: Add R8A78000 X5H DTs
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

On Thu, 18 Sept 2025 at 08:27, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Hai Pham <hai.pham.ud@renesas.com>
>
> Add initial DT support for R8A78000 (R-Car X5H) SoC.
>
> [Kuninori: tidyup for upstreaming]
>
> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> Signed-off-by: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
> Signed-off-by: Minh Le <minh.le.aj@renesas.com>
> Signed-off-by: Huy Bui <huy.bui.wm@renesas.com>
> Signed-off-by: Khanh Le <khanh.le.xr@renesas.com>
> Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi

> +       extalr_clk: extalr-clk {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* clock-frequency must be set on board */
> +       };
> +
> +       /*
> +        * In the early phase, there is no clock control support,
> +        * so assume that the clocks are enabled by default.
> +        * Therefore, dummy clocks are used.
> +        */
> +       dummy_clk_sgasyncd4: dummy-clk-sgasyncd4 {

Please keep nodes sorted (alphabetically, by node name).

> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <266660000>;
> +       };
> +
> +       dummy_clk_sgasyncd16: dummy-clk-sgasyncd16 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <66666000>;
> +       };

> +       soc: soc {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               prr: chipid@189e0044 {
> +                       compatible = "renesas,prr";
> +                       reg = <0 0x189e0044 0 4>;
> +               };
> +
> +               /*
> +                * The ARM GIC-720AE - View 1
> +                *
> +                * see
> +                *      r19uh0244ej0052-r-carx5h.pdf
> +                *      - attachments: 002_R-CarX5H_Address_Map_r0p51.xlsx
> +                *       - sheet [RT]
> +                *        - line 619
> +                */
> +               gic: interrupt-controller@39000000 {
> +                       compatible = "arm,gic-v3";
> +                       #interrupt-cells = <3>;
> +                       #address-cells = <0>;
> +                       interrupt-controller;
> +                       reg = <0 0x39000000 0 0x20000>,

The DT bindings say the first region should be GICD (no mention of
GICM), so shouldn't the size be 0x10000?
See Table 21.9 "GIC-720AE Base address".

> +                             <0 0x39080000 0 0x800000>;
> +                       interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               scif0: serial@c0700000 {
> +                       compatible = "renesas,scif-r8a78000", "renesas,rcar-gen5-scif", "renesas,scif";

Some lines are getting a bit long, but that is not something I cannot
fix while applying...

> +                       reg = <0 0xc0700000 0 0x40>;
> +                       interrupts = <GIC_SPI 4074 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
> +                       clock-names = "fck", "brg_int", "scif_clk";
> +                       status = "disabled";
> +               };

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
