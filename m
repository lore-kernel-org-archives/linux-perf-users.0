Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C75449EB8
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311496; cv=pass; b=IguARLyDY19sEpCA1dzbdpMQ1Yhm7aeunmJnJ2KyjeLAIjDnf9TAokJDFIypMZfjc96bm+cL6mUNkbWXRoLFblEOvfJql0mJO5wonOwJieSnqpjvIT11ZkMt8qAzdhMU3/nOi+pZS3cr5E1EgEoepskF397DfgNKrCLJi+KQZRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311496; c=relaxed/simple;
	bh=m9LovGZRm71Kz/26siQRqDNvtYfWBfw9Tv7L/BOcLq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsAt6foMq08KKmZUk+pHbFbxo8vpviaTYXVrH0T+cjC8aPokxpUwVC2OczrGorhQW6JyZCbuu5pRhV3yVctx6UhoqV/7i1CVtDHF5KXcPp872vfkgxaMQ18uxY52JbiK/u+vbP1WdoiKOtDPSzZw0csUpyBYQkLAWGqWrnQIx3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbB1coky; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbB1coky"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-87ab6e5f91eso7028027b3.2
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 01:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792311489; cv=none;
        d=google.com; s=arc-20260327;
        b=nfxPy/1nyRxNknbFgSDxrP85JFcnu+fhztnV49leWHp+4REg+qY+wvi5HWRN0v5/dF
         IuB462Fm55BXOzwlegAnyvcaIEiVMkPpyUhksRuHSnxzCSkKUZ0PngZlw7CDQRSVp2VR
         YKUbjoVtTYTg6fAOHWUUkOIQxLMajpN23/xMqP8XlTmzMEIQYdyGtcVbHMoXD+iSdd9l
         rX/WPpGPOcYZw3Hl+Tak9e1b7jClVYAqAUKousGhLtuf1cpmOgpY401BzCxqB/X1y4jH
         ZNhcmPyQhz8JuOWm+jKCByUTex/vddYvAef4gItGaLfzvCCVO8TVcJpWz2lZCY52KuaI
         HUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZKQD7f8VncSnmQVt+FYovLRzFClXdtIOZ4L3tv3n0X0=;
        fh=Qq+KP1SjnPtcc6fUGMYbj9qrRM0otgMoarulayPYCh0=;
        b=Ec3eXf7k5g7fi5Qa/Juy5TrUxiyvnZWepn2XiGrfh5o5fjQ39QWqP9OMl4MEq2lyln
         ZD63ffYT4b3DW2fU3xKbA07vCpSrgD1OKMRWJOaXiDe48FhLcf6hPzujHbE8k4HCZ2KJ
         EsFBrk5sipoxr+JFq5fui28DZVFY3zfEhNxNNQ1znQj+BmWu5IdKge4dwK9R/8L//E/L
         5fe7h0sislmJ+sKOIbkbUrKc1jUxJAGWpQeLdDDaIHZKcB2b3BvYFcmmgY4uGE5LVLif
         r+mRHR6t/TYwq6eklvD7c8yBRrdKhzcufQu7mBSVsT18Wigs1V1RjX+i20gJLmWsGW/j
         Bk0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792311489; x=1792916289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZKQD7f8VncSnmQVt+FYovLRzFClXdtIOZ4L3tv3n0X0=;
        b=BbB1cokyERZfK0hTfxQTtmwmvtFW/q2hmlF+irPUC/MDzL2O0/Pxenl+uXX7ayPMsA
         oaqNS4//XDbeIKgq7EspM7Z+rZb2/O4hklyewBfMvczfAsMmNUDKiIWKgPPK1bPM8ej3
         cBccKYLiMgbI4sEQ1r8LJL9amuuzd9RLa7YiZpyi7sZ6q9hAf/1VyMCSuMzeVThNBtj6
         o9os4L3gEcv1FtYdqfqARbnb1Uc1d1C2MCkE/VdCDEfe9Fe/qDYRjMz71OScZt75ayF4
         Edsop6C0EVZ3cXRB/6B3repVPVdKU6zgXKiT+dqYVaQv+ddpeUSqoumW8mO2C3HoaTrB
         HTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792311489; x=1792916289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZKQD7f8VncSnmQVt+FYovLRzFClXdtIOZ4L3tv3n0X0=;
        b=YLW6ZSP/LzOhygqoHBm1z2xNOeSNm8YMYsHRt66aobSRUGA5rmJCdv2Q7DyB6IXmoo
         rwVWM5cOQNYx7YUB6Y2TLNXEDDmT7aSQEs7U+kvvdizfHv/0eR3JNxWSVjNe46ePvGCe
         5OtbbfyFYoA8z2R2chgcaYB8oLIDDirbprvm4p16E0yqTp/RGgPRWkPRTdloXXk9UiFq
         7p+5dBj19+o6UH8mgWedPAD0hGp9qRCv03Jzh+8O1NmyRcEAnFJ/cxIdlT7rQXuZ8wig
         zThj1nVTc7VP+bC1fA1JyjOC1UEq+UrqF8JHKnGhB0euMARVPcoQQXnGZrB6yKQQdCBR
         o70g==
X-Forwarded-Encrypted: i=1; AKwUvBwWIb71QWfFP8JFl776OvL9qEemLasoWshk4hLEOEIpr1Le6ulF9FehbYCQGy0YWIEjCVcM7bd05lCKtJ6Vyh9B@vger.kernel.org
X-Gm-Message-State: AFq9FYK3VJE/yTVwAxkupp91C/CsuoW+PDS7yIgz80cPPCKimi3cQAOh
	wWfZzBV57SwvoMmP0vWHkpWsX147/FZUjRsQfLAkWLOR6rB1mWojvOVs8ZbSX8Mp4KQYNKu7Wzg
	Rj+xF6GsniQhRjlslLUfW0td2C3Eldp4=
X-Gm-Gg: AYBFou3wuKmCxTqeJOGGi7E6r06/7ONvXfNuMbHHF8UZ6dwfd54oVINjkhdjeslkc5N
	HszmAmlJsBdYlx0ElYMMP34aKSfia28zzw+RFHe+c5ltoRvVJO7cPRMH4dHs9PbqqxSHY8bEqqI
	is3eKj+LrdTg59s2If1EWWM+q4qRxfuFzalCMXdzmVS1kMg0bIarXrqmDdAA+WGa34Uo/fBTJiH
	yQDrfSrdnxySMmkr7Syt1zGqsbrPBNkwh3Row+n5PQDkXLVKgp8RfGqqPUzJexM0GE8HAjDZFEm
	pH7hxwAqoBry+kG09XYldy2Vm6PVJKMD8B1CRFyMtggBGTopQPWpv9Y0zWy9CCJZIVxxVi2bf1y
	KY/woIZqBRQmf4R3i4yi7FoBcnywUzCN/stV0V5RoDfPzyI1SAhuX
X-Received: by 2002:a05:690c:f13:b0:8b0:89bc:92b4 with SMTP id
 00721157ae682-8b0f21bbb4bmr16206517b3.51.1792311488622; Sun, 18 Oct 2026
 01:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com> <20261016-alpha-perf-regs-v3-v2-5-17654742226a@gmail.com>
In-Reply-To: <20261016-alpha-perf-regs-v3-v2-5-17654742226a@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 18 Oct 2026 10:17:54 +0200
X-Gm-Features: AclHuK_OPAh6roFXb_L2yR4ZCbLp7NUjn97i4r3orTmSL6OpqXmOnn6fpLIEIiY
Message-ID: <CA+=Fv5Rmwd6pjs_MBo01Zvqo3CwufefqZvPCJeEvK60Ona0tJg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] alpha: fill in pc for software event samples
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sat, Oct 17, 2026 at 3:56=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
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
> Reported-by: Magnus Lindholm <linmag7@gmail.com>
> Closes: https://lore.kernel.org/all/CA%2B%3DFv5S8-Zk8-LUpZnWiBfTGSQXthepm=
Rc_-a9O%2BpEPmVW0mRA@mail.gmail.com/
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/asm/perf_event.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
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

Thanks, this looks good to me.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
