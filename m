Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2EA387346
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970146; cv=pass; b=rxc53gK9TUv7h9f7ItOywM/XCCUzdbLrN4jLFBRRbQS2eywSnBEUu3Qkoz0er+bRsfNgzIyxn86ICDtsY34IGqghAlbP1kh1pIHNe8iT643kKJ45HoMxNhowutIpvT4adrZYvxm6NiTjZNUXmCPGzhFyY2/RqwSz6TRKPIvxGFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970146; c=relaxed/simple;
	bh=WN/D2DKkPkAtwoVdUzfYLsH4nQOGe29u3pPkyYp+9Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuKn3HWzzIK75IuC+W0HhSzrht8F8I/ZnGxkw6MIkbGysHbDixTboplSsQYQmuZYpB+h/4DnjQC5V49IpDUuIX+0Pwge45P6NzqSSFimO6oSLPZGZzNaqgd8NPs3Yxp7tO7VUIGy+zoXCl8Y+KAI79Y9K1C2z9U43hCWv7YaY6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XESQWpec; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XESQWpec"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48b060ec084so2521942f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 02:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791970143; cv=none;
        d=google.com; s=arc-20260327;
        b=OXJMp4EmXkNhXxjRUf1sMHfWZ7J2w/VfVoGokJu6z0rueVrNSLSk7qgk49iLgc4IBn
         6P6GqLq+YdBsUpAZ9tRZd8Zb2tC4KPmXpxm/gw3LkJOIU93RctESo0KdadFRk6vBBj/Y
         oYDl1+1WjvQPesyJHQ5NRWM40XLg1xYja6WC2jMX+S9q8tkVsv/qJiWjmKYJ/J9h5f1e
         EYvcwey+gyjMgjSoSInUYsbsvNjEcyysxIF5R2apLQraTdyEGTTCEJrHuy8izqRu4Ot9
         1uX+sqUqaLOOCrLEai6FBJ1GZW4aTIOFlTXMT+wZ4ZLFzS7VwUxxcttQuFFy995vi3ps
         q6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UM4snv3HyBXCnT4o3yFHC4lEa74fiilyetDqdq6lntg=;
        fh=zb10hnEz5bqyS9o38ISB9NbEg5eVRAbYkN7pD9+kov8=;
        b=Z2PsVCbny2BMMxmzpgbjs3W0NWCiEMngldE6WFs749eU/fiq4kDuUzwjEghxinyFB7
         +WrLh3PFj3PSpEXCSzf5Pih5rEqs7lkoQ/wygGY49G6eYcsH3SFfRPrn4F75uq/d8A7M
         HBo6ly4A3xypjmuOJl+90VCS/jClRzsXDO15L0GTU9UW5tcfrwWK/FyMOBSwd8D/hrEw
         y3KWA93KneiHook84iixeRx//kPPTks2ugv43yHeUsI3mNXNPWP4MZo0C0TmEQmvymgB
         MR9qkxB0OqUquvs9ZnXdkuTuj4RHoiwCC9NsT/Vl0xrT+HKzDbqdqPZsvJyAuzrL785O
         9wRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791970143; x=1792574943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UM4snv3HyBXCnT4o3yFHC4lEa74fiilyetDqdq6lntg=;
        b=XESQWpecQ1oE77q85jd7V07GxvA9TIdihTc+fZdR/N0Eja6i+3XLI9t+PS+fwAdZi4
         nbjT9oOMPJ5vPjoYrvueGYNYn9i8ePRypPbpQUVKlFpKrsgy0Mj+ZIYqAnGuGz6GhzQ3
         T6gdr2ywAMG+lvUt7ahcYlRWlSFO9TxJKCDQc+SN8tv6iTJmPsFSVQkvRTiL47Jt95j8
         81psHBadDQeZPY7IJUTfFljPpV1yz01QLJAVj3LcCsNyQNejzSAxGtI5uQteoTD/U925
         Eia+Yb3Ip9bRbUSe0U6JRCdMbhcBcbzPqO20sTTjO++jQxJzavd8vC79w76SYUzRM6Wy
         NTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970143; x=1792574943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UM4snv3HyBXCnT4o3yFHC4lEa74fiilyetDqdq6lntg=;
        b=rmJJv1tNtHu4ROaVl2j+WjTfIR+8Zr1EzTH8wNKc2gX31b42v5yBzkZZgIP+GrJBKj
         eBzC1pe5G5SDLDwPwhyGvpMUD0o7n+OnnYUpAlVklcpgdLU3kbo4y1sELJSs6KF5XrQN
         W5PjnQmXxNbNebZl1irzXezK6nvYXFQI8kMtn2Km1d3kkiK48lCa+2kx2mjRZk9AlY8v
         dCoggm+0uHUI8F8Sokzg3nwJyI91UvUOl2AzecV4yp56YbkyGZK/t0+UVeTXE14T/AOS
         izPEg3ZV3unTcNsogkBu6CA1G8V/SV63jECsbtqO/d42hUdy1AcG0+UPx4NvU8AA8ZhB
         ujHw==
X-Forwarded-Encrypted: i=1; AKwUvByQrW5GdSTRk6CQ7uZrVHNc5kIqAB05eZzGWQZa24yY5Ia6L8gcwmhz9n757gwxTIK2QGL/8BK6e87nvNgCWjfu@vger.kernel.org
X-Gm-Message-State: AFq9FYIWrOzQb/pzefcgFjuqXaabR5eiUodwUkUu68poNb6zM0J2nUp7
	OEb0nnRL0nMsZdh2zY3EfMZF1c6u+/iwvHcSymNTFdqp+WNUu8tsf37fq3kWzdI0aw4a3wOyhHf
	gUkX/lUicBwqTvpZMVSmM2mCU/2aYuHA=
X-Gm-Gg: AYBFou3u++Jaq4SG+b/Y7nAXMYjpumk/my/7lVatwkTSYyWmKzHR7QVXw36ssxigBRt
	E6ap6NxErVR1v0b05pXn/a2rP6Pr4c3YNsnxSrqnAfbqafBDmYOSdRY0PbZA+IV10K4aeOm1V6K
	rZ4XYvR6BTAB2lC1r0Rpe+XATV4da4tW1rZD/0XUIo0BD3zL268xxYHsSrtEYMegBGJhX5qVBxb
	No8Gxrd7iNdbRG58oKd+8LQ7AvKzjbs+QnonC9qI90xPrqFLEGpwX9IQY0kYjW0hRXY98AWDK/n
	DPYqbftS7jiKMmCPNw3PBfCemCnRQjUYpDwN2kVi8II7mLjgLqZd09excroAKhdyZwixRT5CyLc
	mz4qCWT2zR+1os9UnEKuhVaafwBhHgHkIGw15xy04Ys8=
X-Received: by 2002:a05:6000:41db:b0:487:1c89:f158 with SMTP id
 ffacd0b85a97d-48dca3433dfmr21443506f8f.14.1791970143295; Wed, 14 Oct 2026
 02:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe117dd44728fe7c96f3e4b3ec88c6ca83c5da9b.1791880574.git.geert+renesas@glider.be>
In-Reply-To: <fe117dd44728fe7c96f3e4b3ec88c6ca83c5da9b.1791880574.git.geert+renesas@glider.be>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 14 Oct 2026 10:28:36 +0100
X-Gm-Features: AclHuK_hpJt3R0zDHjAZL75ikzTNtzzFWfnolY7PI7Bi35zqbWZzmjfcVJRiUWc
Message-ID: <CA+V-a8tpVEqJTKr4JS2aEcgr6yXzmh8j==x=+54o-rAyBwLrRQ@mail.gmail.com>
Subject: Re: [PATCH] perf/renesas: Remove remaining RISCV_ALTERNATIVE references
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Conor Dooley <conor.dooley@microchip.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 9:40=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> As riscv always selects RISCV_ALTERNATIVE, the option was removed.
> However, a few references were left, making it impossible to enable
> RZ/Five support (ARCH_R9A07G043).
>
> Fix this by removing all remaining references.
>
> Fixes: b924210f542e13c7 ("riscv: remove RISCV_ALTERNATIVE Kconfig option"=
)
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> To be applied to riscv/for-next, or folded into the original commit.
> ---
>  drivers/perf/Kconfig        | 2 +-
>  drivers/soc/renesas/Kconfig | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 245e7bb763b9947a..8cef4bdef76aecab 100644
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
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
