Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD91AA1F4
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121617; cv=none; b=SZ/3TuZPphxa6ghf+8DDISYCelGSSw3pKhGL7lc+NQquA7w77xvT7PyXxrWzSwcGL1/jO1zaYYHXUboCHwlV7OSKOAIv8T3mvigRr+IW+yZB5Ay5FbtOf5zNeJ/UKc+Q0JcYXHXtp4UsXbUkQw7+YOoh8Y6j2sFq9pt1YU5QTB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121617; c=relaxed/simple;
	bh=aWHBMOW8hyEe365SagMQZPNiGW5aSEvEFBlvvt4KhAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BH1FD7hsjNVDvc4Fu6uXY5LpcIzqxJ1m4U2X5dgBzAH9v3jASeNAKhLacNI/fDGyJsp31CoS0MJJWdN/v/Lnt1G7QyecRgLDhzvDVjMSY1NJ27Px34jld/JP77iwtUvkiztjrPD2xIURrhbsJxyNXl/Floe57CaJW5JcQcrPiJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-327f87275d4so6596567a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 08:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121615; x=1758726415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05Xx0KU64Po07Lz8pcNMpuzAdK+HLbLydsRr28mrazU=;
        b=vaPBrroO6tMq5Ri+8Fw4k9dsfei1w6/RtEEwYKztZWqwJkkQTbVX/67unIcsotDYWF
         c8of42GVUQvfX/yfJ29oHCdtfxLTB8PZZJZYOkFOKrzKRUxPImDP/hLdRalQDnUpCTu/
         VaU2yXkOPV55so2AZWg9TIaFAit3kBUv+rGtGlft+yPF7GTqf5NVPmoADJ/WFIXNaru0
         vVMVDXrhIgv6pbTzZJoCcWfN7eYXAzItc2JW+qL1ek7IfGoQTg1lBEyIUtkVx53Lddo2
         J+uF9CG5CjKe0UC3dRPYg4n7OKUHRiLvrbrYlHvcHH8KCXcpJTyTwc4kMcis1on2NGSZ
         EODg==
X-Forwarded-Encrypted: i=1; AJvYcCVrQUlej7PUXJ6fb9PxYU1vtBX8u4FZxmxzP48yp2Ya/hunaWOgyajshgEJ+LMziZiPVutbNGuA5yMzD9b6ZIT8@vger.kernel.org
X-Gm-Message-State: AOJu0YyW9l1G/WYY7fOyoXdeh9Eq7RbvMTXja7+fAv5D11O9pwnqU1Ex
	86RB5DQA5++06gd0uB8vYxJqSmBW81lrYs25H+II79EJYP48dRb85sBq95U2QOkGNfg=
X-Gm-Gg: ASbGncuhp+QYszzRsGx0w1M+V5V8hP01zseL2Z7Do0z3q6lepCdlsgqA4u9FlOMbeXD
	m3VwNaxte8lZgOd5j/u+YNU+VwN1OWhgp4qCqVZhexDPgD9GB5aVpJi/zD+pAow6pd8jeLJo4SJ
	ritUuJxW5acSvrfQMi3D+46uac8Cc72tXKvnBOQ1hm+h5BArWKx96hdOrzuzibk14S7H7zexzvJ
	H16BhAv7OaRCJv99uL9uX1OKQu8rVVa8aArzeqM8pl0JY3udqUzs5PgDAaMn/rIqpjyswX5euex
	GT+eaLWCRnghHNUl/ox4gg7M0qODc9Q4eau4Jm/BksZ+d5dhuWd27XcAVCn+e8RlY26i3eIbh2a
	SeCjbJWkyFw1nMGx1sHzxS/cULzMfuJyqDMP4fxPwgncCI+7k8nd8LJmDT9rW/WhtT+N52zEU8N
	0=
X-Google-Smtp-Source: AGHT+IGWgNOHEQr25IMa2Ciz87cP12O93fVoTScnfOI3wj9WvexYg22IyxgdX+v0U7lgSd/iVaaRXQ==
X-Received: by 2002:a17:90a:d2ce:b0:32b:dfdb:b276 with SMTP id 98e67ed59e1d1-32ee3fa2c58mr2935383a91.34.1758121614975;
        Wed, 17 Sep 2025 08:06:54 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3303ffa1531sm841269a91.4.2025.09.17.08.06.54
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 08:06:54 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b54dd647edcso2128206a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 08:06:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtPkt/zJMzJNtaRcy6tu4gmDN0a4wdnm7UfkgFNZ3YKJyNHUqq8sbiw4Q1WDG3Pcke6loOOP00tDH5CCCcnNNV@vger.kernel.org
X-Received: by 2002:a05:6122:829c:b0:539:3bb5:e4c8 with SMTP id
 71dfb90a1353d-54a60a7a014mr768825e0c.12.1758121126748; Wed, 17 Sep 2025
 07:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ecs5abp9.wl-kuninori.morimoto.gx@renesas.com> <875xdhabml.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <875xdhabml.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Sep 2025 16:58:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX=oJqJhXOm6w_65dJHRD3VZyJZUWfHzot5EuZtRB2tZw@mail.gmail.com>
X-Gm-Features: AS18NWDSUjkX-aOCFteBo5qpdwwTSUCRiYts8nug9t_TpQbYuJMfunN09RrdfOE
Message-ID: <CAMuHMdX=oJqJhXOm6w_65dJHRD3VZyJZUWfHzot5EuZtRB2tZw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: dts: renesas: R8A78000: Add initial
 Ironhide support
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

On Wed, 17 Sept 2025 at 07:31, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Hai Pham <hai.pham.ud@renesas.com>
>
> Add the initial support for Renesas X5H Ironhide board.
>
> Note: It is using "maxcpus" in bootargs to limit number of CPU, because
> SMP support is now under development. This limitation will be removed
> in the future.
>
> [Kuninori: tidyup for upstreaming]
>
> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> Signed-off-by: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Khanh Le <khanh.le.xr@renesas.com>
> Signed-off-by: Huy Bui <huy.bui.wm@renesas.com>
> Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for the update!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a78000-ironhide.dts
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the Ironhide board
> + *
> + * Copyright (C) 2025 Renesas Electronics Corp.
> + */
> +
> +/dts-v1/;
> +#include "r8a78000.dtsi"
> +
> +/ {
> +       model = "Renesas Ironhide board based on r8a78000";
> +       compatible = "renesas,ironhide", "renesas,r8a78000";
> +
> +       aliases {
> +               serial0 = &hscif0;
> +       };
> +
> +       chosen {
> +               /*
> +                * REMOVE-ME
> +                *
> +                * It works 1 CPU core only for now. This limitation will be
> +                * removed in future.
> +                */
> +               bootargs = "maxcpus=1";

I still don't fully understand why this is needed: without that line,
Ironhide boots fine, and only a single CPU is enabled.
None of the cpu node have an enable-method, so Linux does not try to
enable secondary CPUs anyway.  Even with the enable-method re-added
(like in your v2), Linux cannot enable secondary CPUs, as there is no
PSCI node.

What am I missing?

> +               stdout-path = "serial0:1843200n8";
> +       };

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
