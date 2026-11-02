Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614206;
	b=duDxBiWv4JfBrutg8iWAcRCX4OUUOOFHqPoo2mPXEp4H7ZcCTtYqDoDeu46kKx4bVBVj
	 CujI1BKeom+oRFBRmz4vRKzYmEfk2XtlAimJIZndKg06hbMgg6AkdzKU3vi0JvjS8wuer
	 bEYPpPl1pIf/jL7/fOuYOrs1Nr0x8zJ+UV9zlXWGfrjcP9/FKU3wUTLiOkc+xdBNpDjcs
	 WXGF+iRBcEP2jwunG+c5xnc8oCViAefApUxF63jg/ZNKhxT4/RD8W9fLYVH1kE3LlAVQR
	 6prADZ1bj4gm1esJkusSYwxI5gX9xnPZxl2I2eYMpWFHB0MEY1J/1LbihD4TYbo5leQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614206;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=kku90+qM041/ZsQ9tSwaVmVz4Dm8H3ilNwTawTrWwWg=;
	b=rfEVpSUGPoaMnSYYwt03WkTQk3oJwJkAkS6v2hxzVT+kdNN1QM8M2Fnzq32F5iKZSwfn
	 MHqSwP2gppqr9AVL13DpVKLXjlGtxgKB6IwFQ/wW22A7GioMocZ5sBQyv8WmYGw6tI3P3
	 rwxH5WY84pimuUmXs8DJsyh4H6Bc/d42OGAh+l1es+uJ+e4xb/N9uf6QUXWqWozm2nwnp
	 SZb0ntwowwTjAT0rJzdtjYW5NpzOnU6YWKhHLv5BhumFhSBmiEiElAFkPdqvT74kXegyC
	 Fy/iScAstFFGuS+iZgk+qU71PuLTfQYpZsLDxSEoteedDafWV6IXK/Xovf57bd7gYHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91193606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 10:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91193606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cc1cf48a39so731973137.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 02:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793614204; x=1794219004;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kku90+qM041/ZsQ9tSwaVmVz4Dm8H3ilNwTawTrWwWg=;
        b=Li/Z7g0LgZJSiGV+WpMf+4pvZ6K7n6VOLDStZ/VuHYrNyYiKwEnDJF5WPd10t494jZ
         AO4aXze2X7P94t38AeI3fgGH05eGEC4VliJVcRomuTSeGspdoQWXCrLJNFgdrrdM9KHW
         DyG+68Bu+/te9cVs5D3gggGrZ+ynDS2uZHaVYo8fIsgFFebKjbhYXOnQWWO9Pb2+pQjJ
         rLYv3lk8XbSZtC9Bak74fD5Kljq+iKG0JPbEzxwzd5ITxwH9yIjGSi8gEY/bQeZ6ns+f
         bvj95dHwzn9FZZUXy67UpkMIQMmiDNFZf+zH6K8tkcFbWZKDPKsOeY8yakR9oSOT/DuH
         NpxA==
X-Forwarded-Encrypted: i=1; AKwUvBwUVIp5hKtCweD4gYYjTilhRnsRzxBM/94XL5QMPKTAx/JGFbArbqrBMsCTWC4k7TJS9bNtVPX6n3crTaiQKpLp@vger.kernel.org
X-Gm-Message-State: APuU4Z9qEsrw7ABEMeBYX2vLi+Jo5D0O38Eh/8Qgo4+XrOkWcKbKnXq6
	tR2IXmhN9+roj0pfac6WZduqlleswnkU59qWej6B5HZrf2af4vkZ5IfJutnrEVvc
X-Gm-Gg: AYBFou2czYSY0QQ3zeEsTg30BoQsn5+9l5m9Y2e/fbEwTEXdgUSDyjNLzlOK9wBJwoE
	6Yp4/h8Hx6cUQShUAsjC4zU/9NdWqwJ4baAucugZ4fP3+cNqPuvthLdihPVptI1Kz28Rfm6YwZt
	M9wCJHzyI0JpaRZr2QNg77SBR/94T7i9vfIa5z2IiNnI0GSH0mZCJJpgx1dgbMruf/I7nByqLmh
	j3JtaSuwpPwdZ9sKcW62nX6jn2B796BlrlJeyLHYez/mY8X36AmX7AUCKPg+RM/qPJW2fHTS1c8
	0c/DrURog/+F6YLZbYOsAJgNEdQ5UnOIPei0Q0McnnMep9/9BnLnuWRH44zoHZ0ZzvMgODkQfmc
	7selxR6cgxdfOO6I29xd2Pm8WqOvcWrP9aZQnAPboDboLd2bSeKqtFMIbjdBdR9YId1S0YjZYOb
	AAm34U2xHTsRgQ5HOFeX+Spy+NFgIQzj9h/P+V7pT5Wddb7O7SJGQgrUoMm/PoKH05kCKFMqUEr
	SsQtI0a2rjsH22eRqDY42fIHtc/LhfzEEwVyLPVcI3HP2kTO/iBNyA4+2TD7MnpeQfHSW/o6vf0
	hqLVahBNX78Xix8gGAnSilACT1dqpHW5rQfF+NOnb2zSGNOf5fvKeyGXieBbGFJOIg==
X-Received: by 2002:a05:6102:5126:b0:7cc:9f01:1378 with SMTP id ada2fe7eead31-7d07227aa1bmr3547681137.1.1793614204526;
        Mon, 02 Nov 2026 02:10:04 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee1d1b35sm11094958241.1.2026.11.02.02.10.03
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 02:10:04 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9851592ada1so581994241.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 02:10:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwSvcFYMHTDhCd3wyUu8jFXAXttnrfOz0/tkarQt+aZ6bnhjHHOIyzuIIFIi01ugzZ1+1jjXBTEjgUXo4QVkCNq@vger.kernel.org
X-Received: by 2002:a05:6102:3706:b0:7c3:9b0c:a75 with SMTP id
 ada2fe7eead31-7d0725ceb28mr3125663137.12.1793614203445; Mon, 02 Nov 2026
 02:10:03 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <fe117dd44728fe7c96f3e4b3ec88c6ca83c5da9b.1791880574.git.geert+renesas@glider.be>
In-Reply-To: <fe117dd44728fe7c96f3e4b3ec88c6ca83c5da9b.1791880574.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Nov 2026 11:09:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWhOu+1YU7z0WR=2M5OuGjdXmH6m5__F7TmhRGQx52jMg@mail.gmail.com>
X-Gm-Features: AclHuK8J4Hpof_2n20HSIIi8CLwkgCm2egqJasTQSM_ACF5dfMV0X89nwIyfFeA
Message-ID: <CAMuHMdWhOu+1YU7z0WR=2M5OuGjdXmH6m5__F7TmhRGQx52jMg@mail.gmail.com>
Subject: Re: [PATCH] perf/renesas: Remove remaining RISCV_ALTERNATIVE references
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor.dooley@microchip.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Oct 2026 at 10:39, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> As riscv always selects RISCV_ALTERNATIVE, the option was removed.
> However, a few references were left, making it impossible to enable
> RZ/Five support (ARCH_R9A07G043).
>
> Fix this by removing all remaining references.
>
> Fixes: b924210f542e13c7 ("riscv: remove RISCV_ALTERNATIVE Kconfig option")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> To be applied to riscv/for-next, or folded into the original commit.

As the broken commit is now in v7.4-rc1, this can no longer be fixed
in the original commit...

> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -117,7 +117,7 @@ config STARFIVE_STARLINK_PMU
>
>  config ANDES_CUSTOM_PMU
>         bool "Andes custom PMU support"
> -       depends on ARCH_RENESAS && RISCV_ALTERNATIVE && RISCV_PMU_SBI
> +       depends on ARCH_RENESAS && RISCV_PMU_SBI
>         default y
>         help
>           The Andes cores implement the PMU overflow extension very
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index a63df28df3b5e7c7..0b6876ef6dca228b 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -461,7 +461,6 @@ config ARCH_R9A07G043
>         bool "RISC-V Platform support for R9A07G043F (RZ/Five)"
>         depends on NONPORTABLE
>         depends on !DMA_DIRECT_REMAP
> -       depends on RISCV_ALTERNATIVE
>         depends on !RISCV_ISA_ZICBOM
>         depends on RISCV_SBI
>         select ARCH_RZG2L

... so I am queuing it in renesas-fixes for v7.4, unless someone
screams.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
