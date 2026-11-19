Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795063544;
	b=5E2sOc6ZjfuTtQeUjDxjpg70QyyIycpsFtc9RV1pb71LnzFpd+oyb+YcnbpmbYtRK77m
	 EVmxkGwgKiwzysmPZuyReH6NuSdifBKtW30ESo/xq0DuXyOXdvBf66/jFdJqliXY36M3E
	 2oTu8rg1lxvAhGWlugQpkJtY+UGg3TgoKw3kyxkBym+SYmCuxmR4SvvKc7S3nl/ta3kdt
	 Dz08+7zrHZsxrtx//e2LnJyXSTqok8Paxi0145C0n1dY+v9cf47Kb8tdUQ1Mcuev0+45Y
	 pJi11nV1CfQg/ahHZN4OW8MCSoRmvQNqle7t8M6v0TS/je0Nk4aqlxWxIqznRlDp/qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795063544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LkI7Sy95lBvfbQtMVCxtNAxq0Xj/HDOqrG1KSqd25kM=;
	b=hbTRnWOg5zR6W4ZPeagUnLTbkVMFxQ8VmDpFhDfiHDYokgR+DDMWOUIJdB/FeexV8wJO
	 rjeMKdDqe57QhQqUW5vRdyJi3kLaD/w6Rk+olimol3rL4IixyBlKM+ND7IHwhYV1zDRpt
	 x5w6LGQQKUpYQSgVnvRvdDyK9aVc4XjwdHyuCLiyo4/JCpEfVIutccwJ19lcL+nOjZHWD
	 Qau/P6FkuC1FJgcLNC0JrUQ8Glnl4Hwwq57NkxGP66g3Ak782/jLjB4OK84hzPJkXYndQ
	 bJFvWxfmBg+S8gVvNmhJtkRRstQNxSMGb2gBJgnIAIGLA2vXhqbPP8HQ4RkaHEn2X5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pt3Czxvu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC5606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 04:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ECC5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pt3Czxvu
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so12480515e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 20:45:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795063542; cv=none;
        d=google.com; s=arc-20260327;
        b=UoAEifCdZsLN587xfcsx5eWqN4jnW3crNFPhI0rgqnJS+NgpfbKtvUyCNEGO3UU3R5
         qdNuMLwdJdGLK/4IWyuQOI4zNTlZsI1ZhaURowgGLSCAbTmDJCGnRqHomfjqvKl+DnG5
         L/lpI6UVcCQipUGBvC1B4ZAWXY6N96mieQ5xIBvkKZF4d3huIeIawtCpOcShX3hMktnS
         O5J3XZqYaIpOG75JDNuwGasWvplXnAgwDlKO60bmZgdEbcSo5GpRRdNe58jjA6aCB4vW
         tDmvcCNxQ3ijy/sE0ZixfpIhOve0N9LdAkS9VfIJ2RxL33vTvs/3u4ZjgxiBWNiyBpn2
         oLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LkI7Sy95lBvfbQtMVCxtNAxq0Xj/HDOqrG1KSqd25kM=;
        fh=M+oIFa8ZDwn/ppTaQzgBAjqZvWBpmKT/uN2ex5uGQUo=;
        b=qP7UIUb/6PM1yzK2PufFQem1BSKOQ1B91bF9PWvxGlF/u94AXpRMoeZ5MPa6yVjUS/
         rWkhKMkSOm912n4hh74cB5LSlpujrdPo20bcaXPYdWlyi7iyrc0acGUGv4yMQvIf5lO1
         geVMiz/Et8fqX9bUMz1v5JUYex1HNS31JqXXxlajD6KTGaGP22n0Hyv4sEvJWRge/z+k
         f9i9+51H8p5a1QnkvlsWP7NKjQScuW9qRqE1IlZABUSTB404cmQtYmINwK0Qq6qUHPgD
         BsjR38yYXzCOJEjhNxLhRQiqgdimwhLR8SDZHAzBLfrFolafO8q8pfEpIU/ib2x+DlYP
         zs2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795063542; x=1795668342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LkI7Sy95lBvfbQtMVCxtNAxq0Xj/HDOqrG1KSqd25kM=;
        b=pt3CzxvuyBsOj1wsoXny9gI/xTJXqfh4On2chU/g8Il2ASxQE6OOanVQU2Ab1ubqdO
         lSGjIPvG/YGH5Sv93h5GKiVHjBVfey6dv+l+Xije0UBQUE4CgSM4XETUlFx0YstaQuDl
         AO3F2ObgGyZSZ0gJw31Fyh3++MuTQ2Vo1YXgsXYC66IhdTeqcPodMyGn5ggtrKWommLt
         OTPb2TQSfKO5R8JFPPyu0h6Yto6YneLZvl3m898mlMpuMX6h+bulfV7OTFKDFQJ+Gm91
         XcbnlBbDKsDw0UiYS68R2RXi4OHqt/lTEju39vskepOkvOc2HvDR4d/RGe3UH5Ze+Ugc
         3FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795063542; x=1795668342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkI7Sy95lBvfbQtMVCxtNAxq0Xj/HDOqrG1KSqd25kM=;
        b=pGIUOM77+EoeMtL3H+zrzt+MfvAELCdsZyAjzeMscF2GfCxoU3zogkxqy3FPc/qIBf
         0xr7waA44UWeDqbmV0rjOPVJsSsgd8x8EX4z4zx/F3uw3z+aWllqpukCuXt7E98Upt9b
         1aPdf8CaoZSt5J4pG+LY/uF0nRoL3BTp7xe/70sSO9w1sik3xtyWQkEPkXyh7W700Nzk
         E8yPHPsSrWj/BHUUPtI+sbKw+840sdjPaif8QMcvl7/jypqUoT7q869YlujzF9oIeI9Q
         zQt6XxHFWZjFeCDWqcOc7y+xtUqUOtRZxIJsoBWIwCkOjxJcL0wzBIiEtbqTRJCCv6PE
         jZ/w==
X-Forwarded-Encrypted: i=1; AL+hErF5mQdjyt3umY6cfl796IEsRdzzgFT/4tusBh0mHTdvNaEe1RcBWrjKL4LsBWbnjBzf1OOAnBV3Fl/o9rWJKgoZ@vger.kernel.org
X-Gm-Message-State: APuU4Z8opbRh6+e/rGOw+EiV3IGB976qRVRpmKy0pn/B2prKbP83BxKW
	akkIv4b+aMganbhE33JxY9irqi31pVnfYEKX+d27BNx0TOiFU+ijdIzELAuN6RCN9cc3+mqLIbX
	z5Hf33vkzutrCrJHG52e3BrllluhzRS0=
X-Gm-Gg: AYBFou3482u/yZHDkmP10pADtwJeumx4Ovz8pjRkvCQEVkdJUcibhT2j09ApOtba7MZ
	S6z0iLhh/43pySCA9Wpa4mNoOLvRmvura7CqUjjEwgL5fkBeMw39nL8PfiJBrXrMcC10XhtQ2o8
	kfKr3WlNX/lfEEpRsjL4QkA9FgH+g6GYilONHYQXFisWbcqgvH+Ho/XJQE7JzcqdVUmrjaK2l6V
	byFYPCBy4Fl+eaIaBfIcJh2Y/uuq3w+Q5g1P8iFEdNWqxA+A1RZbO07eSTJGqWvrzxXMADX/GGH
	9K7SQlpY9HNX/UPCwh5SDxffzPOFjDZFGwAyqCPGu3oRds6Nw/oZQ2Iq2duEqFNYLOm5rcI01O6
	PFYVzcFjpZqQck54DEJT0Nmnv4eFN2ANFi60IXjOk/oXgy4F2pX/ZBCtOZglWLou1H3lZsyJS4W
	pVP6Bl1/rJTmN5dBD7xg==
X-Received: by 2002:a05:600c:8b5c:b0:4a2:397:73f6 with SMTP id
 5b1f17b1804b1-4bb7da13a97mr99793645e9.8.1795063542301; Wed, 18 Nov 2026
 20:45:42 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119000112.2377949-1-andrii@kernel.org> <20261119000112.2377949-2-andrii@kernel.org>
 <DMYSXNCMOF26.38XGLPOW4K29X@gmail.com>
In-Reply-To: <DMYSXNCMOF26.38XGLPOW4K29X@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 18 Nov 2026 20:45:30 -0800
X-Gm-Features: Aa3M54ru9v9e2z-jn0buLdaQZSqjE5mLeJ2k6xUEdsRdwJ_B7hJSsTaDWvpbQxk
Message-ID: <CAEf4BzbcPkqX+YncZ+3ysFnXmJWaAUyZiF9BkhbTW27h7MxPxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] arm64: perf: Don't report the caller
 twice in caller-regs callchains
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, 
	will@kernel.org, mark.rutland@arm.com, linux-perf-users@vger.kernel.org, 
	peterz@infradead.org, jolsa@kernel.org, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 5:38=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 18, 2026 at 04:01 PM Andrii Nakryiko <andrii@kernel.org> wrot=
e:
> > Do the same on arm64. Set pstate to PSR_MODE_EL1t, which exceptions
> > taken from the kernel never have (the kernel runs in EL1h, or EL2h
> > with VHE), and skip the leaf regs->pc in perf_callchain_kernel() for
> > regs with that mode. The unwind still starts from regs, with the frame
> > record at x29 walked by the unwinder.
>
> my bot thinks the following will be a more accurate fix...
>
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm=
/perf_event.h
> index ee45b4e..7c5ab65 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -13,11 +13,12 @@
>  #define perf_arch_bpf_user_pt_regs(regs) &regs->user_regs
>  #endif
>
> +/* PSR_MODE_EL1t marks these regs for kunwind_stack_walk() */
>  #define perf_arch_fetch_caller_regs(regs, __ip) { \
>         (regs)->pc =3D (__ip);    \
>         (regs)->regs[29] =3D (unsigned long) __builtin_frame_address(0); =
\
>         (regs)->sp =3D current_stack_pointer; \
> -       (regs)->pstate =3D PSR_MODE_EL1h; \
> +       (regs)->pstate =3D PSR_MODE_EL1t; \
>  }
>
>  #endif
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
> index 3ebcf8c..de394ff 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -357,6 +357,13 @@ kunwind_stack_walk(kunwind_consume_fn consume_state,
>                 if (task !=3D current)
>                         return -EINVAL;
>                 kunwind_init_from_regs(&state, regs);
> +               /*
> +                * With perf_arch_fetch_caller_regs() the PC is a copy of=
 the
> +                * LR in the frame record at FP. Start from that record.
> +                */
> +               if (processor_mode(regs) =3D=3D PSR_MODE_EL1t &&
> +                   kunwind_next(&state))
> +                       return -EINVAL;

if arm folks approve, I'm all for this fix deeper in the generic
unwinder code, smaller and cleaner change, thanks!

>         } else if (task =3D=3D current) {
>                 kunwind_init_from_caller(&state);
>         } else {
>
