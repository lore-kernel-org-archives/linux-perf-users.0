Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C17F3DAAB8
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792345849; cv=pass; b=t8qflNTGr8VjN1FnrIYeSXziGcJbQp9fLu8sT/rlobRVbPCAvPrhvEbGk0+sd3o7wn/Bk8VMLCSJqcf8g8Bpgxk8jf0bpsaix4SZq+IOBec2ZaTTkrIaCv0DZEl0rNR5uegYkzO6JoO8E3+Py0Q5H6qjn6Ag2U1ATU72eplIfN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792345849; c=relaxed/simple;
	bh=WXv6UKA/9yuqwbZcgBBetRCfLJaa7efW2S21doIVN0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNGtkRz9HLg1D62MTawjTVGvEhIK6P6t31ElFofI9HrKobjiVqn4g+DS4d5tLclAg6YO1XruunQT23+V1CdWcoLSSOla3+Qo3/M5k8FoTMAn5NodTYWsrMEF40WbC314tVCuWJbtx6pkuUIlMV/alB4SM+Yr2aMfL48/7QmQLt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhdeuN19; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhdeuN19"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so2071694a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 10:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792345846; cv=none;
        d=google.com; s=arc-20260327;
        b=X6JjXxwayTCa3ra5TWJkxZE9soYws3ZDm6JjAUOgSe346g82PqyIToKXI9b6tiFBiG
         5d68TqT2fXBsr2+PjmxdUioXaQlR66VP85t5x9UxpUBU36k6zOuWXuFBoeu4gIu3eP9t
         vOxeGTjuvNbsK4QS2o8DE1zgWdKj0gfI/GEnlpAvZi9PF/pN11xMpe+iZLl9kUJBligb
         Qiz3GqAhUanaQ1PoOfWmDw8c/Ok1WyMnBP8g5cYM48I9k1V3/CUscloiATDlLaAcoeYT
         WGRSDje2WkUUTd0u1QYutGnxk1s63hohTluvlfElj0OYEXRMEqsYrIJ+yPOfp8sM8ul3
         kUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UQ7W9KldKYkaSyjjE5daJncD2A0RYd8lziVm00Ic5Mo=;
        fh=57Hb2vq0AQY4iwOWTm8DIkdsTrCInUrPF0B0Rja+S4w=;
        b=coaG90Jrw3LscH3PNUcu1Chagqvv+uBFH8SP0t9nHkNx0XKpiq33Ub43QO9X0CB19w
         C+EpQqprc1S+9ZRyV220NLqBInFEyzvctEv9J13lvPJa65gv5JswphpJer4mh48q+WeX
         J1sWRajWN4dOvN9x6nItrS706S8TUcd2RzgJbqrMRrEhrH6Bv8/6GBbTc2h2SzHdHNhR
         TPEB+S8gH8QKQ5HelCVj5ugbbfpwGDo9fQl6C/5OIwf4KVRoBGggSDEN56QDJe/wLfKY
         nL9WUjoBoR8RVTJIQH1P5KW5JbNUoaCy4meIlZPGLPq/T7OR4Ht4GuCkHx6mLObQ+huU
         /Y9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792345846; x=1792950646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UQ7W9KldKYkaSyjjE5daJncD2A0RYd8lziVm00Ic5Mo=;
        b=FhdeuN19hmZwMH6SNxPtLNo3n5D2G+4Yfk8Huc7HsCL/lffihO3nLDtCvzv0oZ2441
         TdntBLL9ZVXG4R8WrRtei/u+WNZ7J2tWzTacUrghbUOGqyhDTG/KVXSd0zg+pDil0R4c
         8WEQ/5gtEJE0TL7e/KKNp+SS+c5FM/evaMNldk3Mjnv95C2vGu8pkEWlXf0cnKsu6P/m
         IafNE5/+Zvx2QunzPM8UxMDNcVJouTGbMkg5D36W0e6eZKEv9yyEik6EeIV2DVqaLA1w
         gQMAuwY1GnCnmKkFi5dckgtqOoxlOgebmqMiGxvpVTO4qvk0eNfe/aoUCwjHaoePOthR
         qh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792345846; x=1792950646;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQ7W9KldKYkaSyjjE5daJncD2A0RYd8lziVm00Ic5Mo=;
        b=kLsza8klHIhvRxbTs+gebk0wTcUBk0jdlVz3LnVaZz5qdj8QObmUMkgAwuTiNs4wvJ
         QI9sZ3Q+kz+f56Pj8Mc3J35jnL6Y/pSKOXrnZxFUgQOiR3rsISJaeeLVmZhgoIN9VhZ4
         pHsxwYS7opihaD8HEYltAYNG0NprCmr4Z3h53GQi5bLgATLZBbw+GA+wXIoYDZ/WQcP5
         Oj1ZdKiNZtgI6hvGdig9M1Aoa/GCw33ziJM94xyU8miuWF1MvD6dpVlnv0nvSgoE3NqB
         HCzNJv9vngcLCzemn+bDST7i4FIMnsPTzVYO6WMg6Gu5dnIJCTFRRv3iqxzkRSvp+H3K
         /ROw==
X-Forwarded-Encrypted: i=1; AKwUvBy4bhOqc68h2yFjrPTGAOOR9KT3CurTLZooPmgmJ8RMDcuF2U3ERF6UswpZavhcg9D6G2A41cHOuwtDewA5G0Z4@vger.kernel.org
X-Gm-Message-State: AFq9FYK2zecqLFw1e6zC8SczLvpw45kgIy8RnpXMRh1uZGoYD1pM/rsJ
	CpO3RBLAq9giraQgiifPgrFrjCorb6pKhSvGbDYScvdBqFYzqzu2rwVr3sFMRnvyT98TIm535BJ
	9BZJhNHi5w4vW4hUmTvcJDDtD+xsYELM=
X-Gm-Gg: AYBFou3TU31EvDnNbXRdL7D7OtCZxy9M9X3x3hEXmYCrlSXV5UrMXA6D9Ipm4kOeFkW
	l4tOXUXPHYLIn8Ve6p8Hmo7GG7QoqrTm4yviwJt+utT/5hXTPF42rKeC3nxDfMp6EDFSEmDtyym
	r0P9QWWPLGBtla6whE0zmhNUv1FcIt+tqAMmhhQow6r4V1qgvxGO70mPzq/S2YovE006zxi4bBe
	zqFfFn761F3j6XGBf8jWW+7ffg+XH5SUGNK8xnyUSWFEjebLF5pySXYuw5ZkSNpHdTjFxl552qK
	KY1zd7TVU0B/W+ZXkPYgbqpuwEl/odfkrK6OwsfGIPRq3bV/k+nI+ehHoLm1QqCm8IzCu7HwrhJ
	/i93D5VkYmDLcQPzdwxIbNMS4BerQmU7JVCGOeKOflA==
X-Received: by 2002:a05:6402:4487:b0:6ac:a1e1:3f88 with SMTP id
 4fb4d7f45d1cf-6b3a814b026mr3327488a12.14.1792345846166; Sun, 18 Oct 2026
 10:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com> <20261018-alpha-perf-regs-v3-v3-5-52be85332c57@gmail.com>
In-Reply-To: <20261018-alpha-perf-regs-v3-v3-5-52be85332c57@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 18 Oct 2026 19:50:34 +0200
X-Gm-Features: AclHuK-yU7tSzanPsDFTqgaSJETZpGEAojUlwTccllHoXkgRUI3VKv_elNnpC4I
Message-ID: <CA+=Fv5SFFGtWj_Y8Y1Qe_W1ooDom97VHMiBhfF7b17+FYHL=3Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alpha: fill in pc for software event samples
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sun, Oct 18, 2026 at 4:22=E2=80=AFPM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> Context switch and tracepoint events have no trap frame, so perf builds
> one with perf_fetch_caller_regs(). Alpha does not define
> perf_arch_fetch_caller_regs(), which leaves that pt_regs zeroed, and
> these samples report pc as 0.
>
> Record the caller's address as pc. The zero ps already marks the frame
> as kernel mode, and pt_regs has nowhere to keep sp, so pc is all that
> can be filled in.
>
> perf_fetch_caller_regs() gets that address from CALLER_ADDR0, which
> alpha defines as 0 when CONFIG_FRAME_POINTER is disabled. Finding the
> level zero return address does not need a frame pointer, so make
> alpha_ftrace_return_address0() available in both configurations. Only
> ftrace_return_address(n) still depends on frame pointers.
>
> Reported-by: Magnus Lindholm <linmag7@gmail.com>
> Suggested-by: Magnus Lindholm <linmag7@gmail.com>
> Closes: https://lore.kernel.org/all/CA%2B%3DFv5S8-Zk8-LUpZnWiBfTGSQXthepm=
Rc_-a9O%2BpEPmVW0mRA@mail.gmail.com/
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/asm/ftrace.h     | 5 ++---
>  arch/alpha/include/asm/perf_event.h | 7 +++++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/alpha/include/asm/ftrace.h b/arch/alpha/include/asm/ftr=
ace.h
> index 7ec44134c804..5b75a294a7c9 100644
> --- a/arch/alpha/include/asm/ftrace.h
> +++ b/arch/alpha/include/asm/ftrace.h
> @@ -2,8 +2,6 @@
>  #ifndef _ASM_ALPHA_FTRACE_H
>  #define _ASM_ALPHA_FTRACE_H
>
> -#ifdef CONFIG_FRAME_POINTER
> -
>  static void *alpha_ftrace_return_address0(void)
>         noinline notrace;
>  static void *alpha_ftrace_return_address0(void)
> @@ -13,6 +11,8 @@ static void *alpha_ftrace_return_address0(void)
>
>  #define ftrace_return_address0 alpha_ftrace_return_address0()
>
> +#ifdef CONFIG_FRAME_POINTER
> +
>  /*
>   * __builtin_return_address() requires a constant integer argument.
>   * Keep this as a macro so the value is seen at the callsite.
> @@ -21,7 +21,6 @@ static void *alpha_ftrace_return_address0(void)
>
>  #else  /* !CONFIG_FRAME_POINTER */
>
> -#define ftrace_return_address0 0UL
>  #define ftrace_return_address(n) ((void)(n), 0UL)
>
>  #endif /* CONFIG_FRAME_POINTER */
> diff --git a/arch/alpha/include/asm/perf_event.h b/arch/alpha/include/asm=
/perf_event.h
> index 5996e7a6757e..72536566014a 100644
> --- a/arch/alpha/include/asm/perf_event.h
> +++ b/arch/alpha/include/asm/perf_event.h
> @@ -1,4 +1,11 @@
>  #ifndef __ASM_ALPHA_PERF_EVENT_H
>  #define __ASM_ALPHA_PERF_EVENT_H
>
> +/*
> + * Software events have no trap frame, so perf_fetch_caller_regs() fills
> + * in a zeroed pt_regs. A zero ps already means kernel mode; only pc is
> + * missing.
> + */
> +#define perf_arch_fetch_caller_regs(regs, __ip)        ((regs)->pc =3D (=
__ip))
> +
>  #endif /* __ASM_ALPHA_PERF_EVENT_H */
>
> --
> 2.55.0
>

Tested on my AlphaServer ES40 with CONFIG_FRAME_POINTER disabled.
Context-switch and sched_switch samples report valid PCs, with
synthetic SP correctly remaining zero.

Tested-by: Magnus Lindholm <linmag7@gmail.com>

Thanks,
Magnus
