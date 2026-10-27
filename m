Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123951;
	b=QmzspC7tOVH2B0T98BzUQXi8HyKQKS2HwEJRXFsyp+dSiMr4lWOarwxnTFVJHBJ2BXFW
	 vP9Yf/3l9Q9ENdg0WqeOjTCWBBFaYeDYhTnblXNZiwmSItb7I/5/R27WgFghHJwuB1pVI
	 MH0m3+oK7DCI+ttoCXVf3JFhe3Ig7qYRNon3pR7KNNKAm/oQDsxATgcNrOcuCNqJfHsun
	 PXHkQWdV0FRye6ca2WUI86d9JjABLJIxOrgSXUu2Mt2f7sHAvHde+8Wo6cIcN9ap1nb21
	 44f7liH9fLecnt5nK8W2k1JACOBVubttvnvtsflJ+iz1SvbfTp/bDswW6HlD70/KTOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123951;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=fqEatncjWzbD8qCOvR1GAojxwqzFkT/go8rbP5ITyo4=;
	b=fq8zfuF6u9Ryt28HyNDHWn/UKOkv9KCXiPWEjC0j5zjF4r9nki2+gH1Fi9PQGUQbgeWR
	 LkvluZx3LgOpA/MfADmf9R/fOKlSVXkbkmZpQHjDzPoLsQ270azy0TJMXrFrjhgbcn+C5
	 im7pPlk3kr6zJrGayoEZE7gUiQ/Q7XWzq7Pt14cxSeqXmEY8Bl675hy9L2Z8F2h8Qk69h
	 xCfUGtF+nvKJus+F4U95Evx4thSAnxIjbqfMQC6295CFjQNkG58j4zjuKbpexF76ZUgZp
	 YkH+AUiyDlrVeBMV3eCRdhdmK/XgqMnkj1kq3PMV/6rW+o3JBpTXY3A4H18FrFRw5Mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AZPRmbnT;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=M9ZOHcrm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F495606A31D
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F495606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AZPRmbnT;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=M9ZOHcrm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793123949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqEatncjWzbD8qCOvR1GAojxwqzFkT/go8rbP5ITyo4=;
	b=AZPRmbnTRgkv2iRdPV4bC+V3V14l7bwzuFUsp/TTSv+r/jZh9n/u7LN//eZu8NvV3opL1E
	oZg3mdXqbZNKyy/OTJiz+741xQy0OuwxyTj//I6nTO+Ivx6TheLck8GPi/zCieZhYv7xx9
	0/6IjdTxtqj6+y/Y+N92h5RUsOm+MsI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-VF_XK5u1OwmdbP5e6QDXnQ-1; Tue, 27 Oct 2026 13:59:07 -0400
X-MC-Unique: VF_XK5u1OwmdbP5e6QDXnQ-1
X-Mimecast-MFC-AGG-ID: VF_XK5u1OwmdbP5e6QDXnQ_1793123946
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so81476f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123946; cv=none;
        d=google.com; s=arc-20260327;
        b=qhhB3um8MBPRnKbp+XrYt5hC4YALPUuqaoPz28eRZPnR9m0y2zr29rhZubrARPrZwX
         86xKBgrcmoonBDegP5AsjkpFY7D8ZWskk2Dqng0K0peLj+iQKLKqjnyKC0ZMoDgnMsiH
         6PNkH/maZT6uq96h1JqEV5uvyRNGxtMqRTAn0l7Sx/pdWm9rZQRlEMd8kkzNk4Vt/ACw
         F7UNwvRWF58vfBSDFHscVvS8qbadFoCznS3tp0IMiBX/CmRaIRIcXEBbrwUEEyylDGap
         Oas79RDdfeihp2/LkejL5ZvVM8tetMuET6iY8GpxcRv6ldheo4pBSLL7LwEh9Ay/gy7p
         4GmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fqEatncjWzbD8qCOvR1GAojxwqzFkT/go8rbP5ITyo4=;
        fh=/3HOrmO+PMEoijG5e8i/2bZW1lb2D3GYpXiL5McqsW0=;
        b=sVhYsJxvd3uE9EUb720UZxNUaXO7nH8ltLBONdNIC9MyV4UzxfKZ514C+QMOWwuIWi
         BnLQd+87OTwPGTb6BWZmfw/JX3snsZUwmjAL+s10vwxSAL5dMH6y7NC35oAcKtfkagk8
         /ICMUGQiX6kOMtOGwYorVw5MfjBAc8wABEeQKcTQ+LtU+H0cVUtRZzrTR31K17olcleS
         80rspPxVeaRcfhuliyNT4zsk03BQnZNhC+VLvkFIvDMkNcI6hVuOV6TEuQNpF0eEsCRi
         rB+kn71m43+sj55d8eH0zUCK/8uUeG6mArgTZkBdO0v/OmVkDRPx+ThUWOmJE9Bvp9le
         rz9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793123946; x=1793728746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fqEatncjWzbD8qCOvR1GAojxwqzFkT/go8rbP5ITyo4=;
        b=M9ZOHcrmwj2xSsfKZXAWv2Tqo8s7CIkTIohJZGNzWuT6a+ewoS8eLwdtAHzYBRHI0H
         GZqIY8gM4nJw67vi20H7umNpAE3Go4iud6mB5gMcHcq2HHVzTZKNP9nrIq5DU5h8LPXS
         g6OMBREMNB3T0AnpZVrdfCHrtVhj1lj39rEM2pJ/WzaHRq9Jvg2qlb1nlcxCRDr6594Z
         +TIsxkeQ/fGKZRvlv5jU7kxLnefb+qWrhIYqhwNYKLN3Eidf3mwoFqMHNZeQYmdx8wvS
         4tv7dQVidc2peYAja5sKdIJU6GzhSqWBXugr5854Sli9P4PTXO2HcvhzNqaMYdGkh9Qd
         RS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123946; x=1793728746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqEatncjWzbD8qCOvR1GAojxwqzFkT/go8rbP5ITyo4=;
        b=rtPdE7GMMU+3geWOkP/lHDaObai4B8UhrZk/N05VTaHJ/ShdHpOhU3piaInymNoUW/
         mPEuSCnUmBgXX6TlNbMG0nvBU0JmoEmOnZFXfTJrVHvuj+JSRiNh1xydMQFV3YPLdkFN
         D1rAPEMaikY+TQvirqLbtcPS5yLZMXxw6+A2LM42nTchfgF5lpqKzhEoSuF19jqDDKd7
         Rr54K19rfAo0aCCMlcdlAufHLYr2dKUBf1utPNdPRSdEuk/yLu0tK8MOQ4J7LnqSvZWN
         JnwB0nf7MSWf81BJYCRAy2AqxjNKytMDv5KA6RUXGVYedU0k9+M4bonrhpFc+6tfcDvh
         3Ocw==
X-Forwarded-Encrypted: i=1; AKwUvBzOH53E1Gq8mWmQYz/bT39cW/nz8rYzjCjE6jwjL64YSS5CgamRgmWnGSHW8+9ezgp5W/0R820dM73mYdh4fAIW@vger.kernel.org
X-Gm-Message-State: AFq9FYJhDi1vKDGvsXEdSmL3tAQavLaqL7RmQsV9ND0rF+SrPpXXYlL1
	4xU5b3Q4KvlCEsHsgnClBDVNhKXQ1mQo7X3Sdoin3Ya+iXhV3uwc0KGsBAn4X8Dg2Ezc4qTCzAs
	w5MjXBydch5lAsGQIYpng5cPJOOSRySWUkEe5cCpz9nAgaDUH+BJuIx/P+Sl7HpKHfQ7OGwxgzJ
	/9JRgZWnD2kEDSQQWddf9cMxtTPAmhDqeoDEyXQQU2AYJB7w==
X-Gm-Gg: AYBFou1RRtEKqi9foAFXI+2ZOr18gT8wS4Hd6JfGnHT+dcfIhU9D4RvZTZZKMFZAYEW
	OvVfcz+zCs2zQEBXjVa2L98+1N6h3KWuHtlQYez+JTWBwKMd+uLQ0w+I3ghMlGsz8qc/xcXuafd
	qxzJRs2tZFEk05WPAxN5A/TtuyDkJPvyrinJ8XPWixxYQEVAD2HZeIntBSH/NfzU2mwqXALtg2H
	XkiDHeuxhlMFUi6fA==
X-Received: by 2002:a05:6000:40dc:b0:48e:b32:9d1c with SMTP id ffacd0b85a97d-48e5d2e7288mr591208f8f.19.1793123945854;
        Tue, 27 Oct 2026 10:59:05 -0700 (PDT)
X-Received: by 2002:a05:6000:40dc:b0:48e:b32:9d1c with SMTP id
 ffacd0b85a97d-48e5d2e7288mr591158f8f.19.1793123945294; Tue, 27 Oct 2026
 10:59:05 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com> <20260930063919.608911-2-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260930063919.608911-2-himanshu.chauhan@oss.qualcomm.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Tue, 27 Oct 2026 13:58:53 -0400
X-Gm-Features: AclHuK9DNwf0Nv2uq8boQccKHJoRO7KrZnA2xO_377JRV3ku74JkUvnqrW0qOr8
Message-ID: <CADRr4bczG1YpG0Z9nMzK=q8z0nXBrd8ALKsT8Pe-ZRmMf_dksQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] riscv: Introduce support for hardware break/watchpoints
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	alex@ghiti.fr, aou@eecs.berkeley.edu, palmer@dabbelt.com, pjw@kernel.org, 
	qingfang.deng@linux.dev, shuah@kernel.org, thecharlesjenkins@gmail.com, 
	cp0613@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:39=E2=80=AFAM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> RISC-V hardware breakpoint framework is built on top of perf subsystem
> and uses SBI debug trigger extension to install/uninstall/update/enable/d=
isable
> hardware triggers as specified in Sdtrig ISA extension.
>
> While handling breakpoints, trust the hardware record, (hit[0-1]) bits, w=
hen deciding
> if a trigger fired, and by clearing it once it's been read.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  arch/riscv/Kconfig                     |   2 +
>  arch/riscv/include/asm/hw_breakpoint.h | 312 +++++++++++
>  arch/riscv/include/asm/kdebug.h        |   3 +-
>  arch/riscv/kernel/Makefile             |   1 +
>  arch/riscv/kernel/hw_breakpoint.c      | 746 +++++++++++++++++++++++++
>  arch/riscv/kernel/traps.c              |   6 +
>  6 files changed, 1069 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
>  create mode 100644 arch/riscv/kernel/hw_breakpoint.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d6c2dbf8455c..17fa7d4f9729 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -174,6 +174,8 @@ config RISCV
>         select HAVE_FUNCTION_ARG_ACCESS_API
>         select HAVE_FUNCTION_ERROR_INJECTION
>         select HAVE_GCC_PLUGINS
> +       select HAVE_GENERIC_VDSO if MMU
The line above seems to be a rebasing artifact

> +       select HAVE_HW_BREAKPOINT if PERF_EVENTS
>         select HAVE_IRQ_TIME_ACCOUNTING
>         select HAVE_KERNEL_BZIP2 if !EFI_ZBOOT
>         select HAVE_KERNEL_GZIP if !EFI_ZBOOT
> diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/=
asm/hw_breakpoint.h
> new file mode 100644
> index 000000000000..a165bb9636de
> --- /dev/null
> +++ b/arch/riscv/include/asm/hw_breakpoint.h
> @@ -0,0 +1,312 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2026 Qualcomm Technologies, Inc.
> + */
> +
> +#ifndef __RISCV_HW_BREAKPOINT_H
> +#define __RISCV_HW_BREAKPOINT_H
> +
> +struct task_struct;
> +
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +
> +#include <uapi/linux/hw_breakpoint.h>
> +
> +/* Maximum number of hardware breakpoints supported */
> +#define RISCV_HW_BP_NUM_MAX 32
> +
> +#if __riscv_xlen =3D=3D 64
> +#define cpu_to_le cpu_to_le64
> +#define le_to_cpu le64_to_cpu
> +#elif __riscv_xlen =3D=3D 32
> +#define cpu_to_le cpu_to_le32
> +#define le_to_cpu le32_to_cpu
> +#else
> +#error "Unexpected __riscv_xlen"
> +#endif
> +
> +#define CLEAR_DBTR_BIT(_target, _bit)  ((_target) &=3D ~BIT(_bit))
> +#define SET_DBTR_BIT(_target, _bit)    ((_target) |=3D BIT(_bit))
> +
> +#define RISCV_DBTR_EXEC                BIT(0)
> +#define RISCV_DBTR_LOAD                BIT(1)
> +#define RISCV_DBTR_STORE       BIT(2)
> +#define RISCV_DBTR_LDST                (RISCV_DBTR_LOAD | RISCV_DBTR_STO=
RE)
> +
> +enum {
> +       RISCV_DBTR_TRIG_NONE =3D 0,
> +       RISCV_DBTR_TRIG_LEGACY,
> +       RISCV_DBTR_TRIG_MCONTROL,
> +       RISCV_DBTR_TRIG_ICOUNT,
> +       RISCV_DBTR_TRIG_ITRIGGER,
> +       RISCV_DBTR_TRIG_ETRIGGER,
> +       RISCV_DBTR_TRIG_MCONTROL6,
> +};
> +
> +/* Trigger Data 1 */
> +#define RISCV_DBTR_TDATA1_DATA_BIT     0
> +#if __riscv_xlen =3D=3D 64
> +#define RISCV_DBTR_TDATA1_DMODE_BIT    59
> +#define RISCV_DBTR_TDATA1_TYPE_BIT     60
> +#elif __riscv_xlen =3D=3D 32
> +#define RISCV_DBTR_TDATA1_DMODE_BIT    27
> +#define RISCV_DBTR_TDATA1_TYPE_BIT     28
> +#else
> +#error "Unknown __riscv_xlen"
> +#endif
> +
> +#if __riscv_xlen =3D=3D 64
> +#define RISCV_DBTR_TDATA1_DATA_BIT_MASK                GENMASK(58, RISCV=
_DBTR_TDATA1_DATA_BIT)
> +#elif __riscv_xlen =3D=3D 32
> +#define RISCV_DBTR_TDATA1_DATA_BIT_MASK                GENMASK(26, RISCV=
_DBTR_TDATA1_DATA_BIT)
> +#else
> +#error "Unknown __riscv_xlen"
> +#endif
> +#define RISCV_DBTR_TDATA1_DMODE_BIT_MASK       BIT(RISCV_DBTR_TDATA1_DMO=
DE_BIT)
> +#define RISCV_DBTR_TDATA1_TYPE_BIT_MASK                \
> +       GENMASK(RISCV_DBTR_TDATA1_TYPE_BIT + 3, RISCV_DBTR_TDATA1_TYPE_BI=
T)
> +
> +/* MC - Match Control Type Register */
> +#define RISCV_DBTR_MC_LOAD_BIT         0
> +#define RISCV_DBTR_MC_STORE_BIT                1
> +#define RISCV_DBTR_MC_EXEC_BIT         2
> +#define RISCV_DBTR_MC_U_BIT            3
> +#define RISCV_DBTR_MC_S_BIT            4
> +#define RISCV_DBTR_MC_RES2_BIT         5
> +#define RISCV_DBTR_MC_M_BIT            6
> +#define RISCV_DBTR_MC_MATCH_BIT                7
> +#define RISCV_DBTR_MC_CHAIN_BIT                11
> +#define RISCV_DBTR_MC_ACTION_BIT       12
> +#define RISCV_DBTR_MC_SIZELO_BIT       16
> +#define RISCV_DBTR_MC_TIMING_BIT       18
> +#define RISCV_DBTR_MC_SELECT_BIT       19
> +#define RISCV_DBTR_MC_HIT_BIT          20
> +#if __riscv_xlen >=3D 64
> +#define RISCV_DBTR_MC_SIZEHI_BIT       21
> +#endif
> +#if __riscv_xlen =3D=3D 64
> +#define RISCV_DBTR_MC_MASKMAX_BIT      53
> +#define RISCV_DBTR_MC_DMODE_BIT                59
> +#define RISCV_DBTR_MC_TYPE_BIT         60
> +#elif __riscv_xlen =3D=3D 32
> +#define RISCV_DBTR_MC_MASKMAX_BIT      21
> +#define RISCV_DBTR_MC_DMODE_BIT                27
> +#define RISCV_DBTR_MC_TYPE_BIT         28
> +#else
> +#error "Unknown riscv xlen"
> +#endif
> +
> +#define RISCV_DBTR_MC_LOAD_BIT_MASK    BIT(RISCV_DBTR_MC_LOAD_BIT)
> +#define RISCV_DBTR_MC_STORE_BIT_MASK   BIT(RISCV_DBTR_MC_STORE_BIT)
> +#define RISCV_DBTR_MC_EXEC_BIT_MASK    BIT(RISCV_DBTR_MC_EXEC_BIT)
> +#define RISCV_DBTR_MC_U_BIT_MASK       BIT(RISCV_DBTR_MC_U_BIT)
> +#define RISCV_DBTR_MC_S_BIT_MASK       BIT(RISCV_DBTR_MC_S_BIT)
> +#define RISCV_DBTR_MC_RES2_BIT_MASK    BIT(RISCV_DBTR_MC_RES2_BIT)
> +#define RISCV_DBTR_MC_M_BIT_MASK       BIT(RISCV_DBTR_MC_M_BIT)
> +#define RISCV_DBTR_MC_MATCH_BIT_MASK   \
> +       GENMASK(RISCV_DBTR_MC_MATCH_BIT + 3, RISCV_DBTR_MC_MATCH_BIT)
> +#define RISCV_DBTR_MC_CHAIN_BIT_MASK   BIT(RISCV_DBTR_MC_CHAIN_BIT)
> +#define RISCV_DBTR_MC_ACTION_BIT_MASK  \
> +       GENMASK(RISCV_DBTR_MC_ACTION_BIT + 3, RISCV_DBTR_MC_ACTION_BIT)
> +#define RISCV_DBTR_MC_SIZELO_BIT_MASK  \
> +       GENMASK(RISCV_DBTR_MC_SIZELO_BIT + 1, RISCV_DBTR_MC_SIZELO_BIT)
> +#define RISCV_DBTR_MC_TIMING_BIT_MASK  BIT(RISCV_DBTR_MC_TIMING_BIT)
> +#define RISCV_DBTR_MC_SELECT_BIT_MASK  BIT(RISCV_DBTR_MC_SELECT_BIT)
> +#define RISCV_DBTR_MC_HIT_BIT_MASK     BIT(RISCV_DBTR_MC_HIT_BIT)
> +#if __riscv_xlen >=3D 64
> +#define RISCV_DBTR_MC_SIZEHI_BIT_MASK  \
> +       GENMASK(RISCV_DBTR_MC_SIZEHI_BIT + 1, RISCV_DBTR_MC_SIZEHI_BIT)
> +#endif
> +#define RISCV_DBTR_MC_MASKMAX_BIT_MASK \
> +       GENMASK(RISCV_DBTR_MC_MASKMAX_BIT + 5, RISCV_DBTR_MC_MASKMAX_BIT)
> +#define RISCV_DBTR_MC_DMODE_BIT_MASK   BIT(RISCV_DBTR_MC_DMODE_BIT)
> +#define RISCV_DBTR_MC_TYPE_BIT_MASK    GENMASK(RISCV_DBTR_MC_TYPE_BIT + =
3, RISCV_DBTR_MC_TYPE_BIT)
> +
> +/* MC6 - Match Control 6 Type Register */
> +#define RISCV_DBTR_MC6_LOAD_BIT                0
> +#define RISCV_DBTR_MC6_STORE_BIT       1
> +#define RISCV_DBTR_MC6_EXEC_BIT                2
> +#define RISCV_DBTR_MC6_U_BIT           3
> +#define RISCV_DBTR_MC6_S_BIT           4
> +#define RISCV_DBTR_MC6_RES2_BIT                5
> +#define RISCV_DBTR_MC6_M_BIT           6
> +#define RISCV_DBTR_MC6_MATCH_BIT       7
> +#define RISCV_DBTR_MC6_CHAIN_BIT       11
> +#define RISCV_DBTR_MC6_ACTION_BIT      12
> +#define RISCV_DBTR_MC6_SIZE_BIT                16
> +#define RISCV_DBTR_MC6_TIMING_BIT      20
> +#define RISCV_DBTR_MC6_SELECT_BIT      21
> +#define RISCV_DBTR_MC6_HIT_BIT         22
> +#define RISCV_DBTR_MC6_VU_BIT          23
> +#define RISCV_DBTR_MC6_VS_BIT          24
> +#if __riscv_xlen =3D=3D 64
> +#define RISCV_DBTR_MC6_DMODE_BIT       59
> +#define RISCV_DBTR_MC6_TYPE_BIT                60
> +#elif __riscv_xlen =3D=3D 32
> +#define RISCV_DBTR_MC6_DMODE_BIT       27
> +#define RISCV_DBTR_MC6_TYPE_BIT                28
> +#else
> +#error "Unknown riscv xlen"
> +#endif
> +
> +#define RISCV_DBTR_MC6_LOAD_BIT_MASK   BIT(RISCV_DBTR_MC6_LOAD_BIT)
> +#define RISCV_DBTR_MC6_STORE_BIT_MASK  BIT(RISCV_DBTR_MC6_STORE_BIT)
> +#define RISCV_DBTR_MC6_EXEC_BIT_MASK   BIT(RISCV_DBTR_MC6_EXEC_BIT)
> +#define RISCV_DBTR_MC6_U_BIT_MASK      BIT(RISCV_DBTR_MC6_U_BIT)
> +#define RISCV_DBTR_MC6_S_BIT_MASK      BIT(RISCV_DBTR_MC6_S_BIT)
> +#define RISCV_DBTR_MC6_RES2_BIT_MASK   BIT(RISCV_DBTR_MC6_RES2_BIT)
> +#define RISCV_DBTR_MC6_M_BIT_MASK      BIT(RISCV_DBTR_MC6_M_BIT)
> +#define RISCV_DBTR_MC6_MATCH_BIT_MASK  \
> +       GENMASK(RISCV_DBTR_MC6_MATCH_BIT + 3, RISCV_DBTR_MC6_MATCH_BIT)
> +#define RISCV_DBTR_MC6_CHAIN_BIT_MASK  BIT(RISCV_DBTR_MC6_CHAIN_BIT)
> +#define RISCV_DBTR_MC6_ACTION_BIT_MASK \
> +       GENMASK(RISCV_DBTR_MC6_ACTION_BIT + 3, RISCV_DBTR_MC6_ACTION_BIT)
> +#define RISCV_DBTR_MC6_SIZE_BIT_MASK   \
> +       GENMASK(RISCV_DBTR_MC6_SIZE_BIT + 3, RISCV_DBTR_MC6_SIZE_BIT)
> +#define RISCV_DBTR_MC6_TIMING_BIT_MASK BIT(RISCV_DBTR_MC6_TIMING_BIT)
> +#define RISCV_DBTR_MC6_SELECT_BIT_MASK BIT(RISCV_DBTR_MC6_SELECT_BIT)
> +#define RISCV_DBTR_MC6_HIT_BIT_MASK    BIT(RISCV_DBTR_MC6_HIT_BIT)
> +#define RISCV_DBTR_MC6_VU_BIT_MASK     BIT(RISCV_DBTR_MC6_VU_BIT)
> +#define RISCV_DBTR_MC6_VS_BIT_MASK     BIT(RISCV_DBTR_MC6_VS_BIT)
> +#define RISCV_DBTR_MC6_DMODE_BIT_MASK  BIT(RISCV_DBTR_MC6_DMODE_BIT)
> +#define RISCV_DBTR_MC6_TYPE_BIT_MASK   \
> +       GENMASK(RISCV_DBTR_MC6_TYPE_BIT + 3, RISCV_DBTR_MC6_TYPE_BIT)
> +
> +/*
> + * mcontrol6 hit1:hit0 (ratified Debug spec v1.0). RISCV_DBTR_MC6_HIT_BI=
T
> + * above is hit0 (bit 22); hit1 (bit 25) is not adjacent to it but combi=
nes
> + * with it into a single 2-bit field, hit1 as MSB.
> + */
> +#define RISCV_DBTR_MC6_HIT1_BIT                25
> +#define RISCV_DBTR_MC6_HIT1_BIT_MASK           BIT(RISCV_DBTR_MC6_HIT1_B=
IT)
> +
> +#define RISCV_DBTR_MC6_HIT_FALSE       0       /* trigger did not fire *=
/
> +#define RISCV_DBTR_MC6_HIT_BEFORE      1       /* fired before the instr=
uction */
> +#define RISCV_DBTR_MC6_HIT_AFTER       2       /* fired after, epc has m=
oved past */
> +#define RISCV_DBTR_MC6_HIT_IMM_AFTER   3       /* fired immediately afte=
r */
> +
> +#define RISCV_DBTR_MC6_GET_HIT(_t1)                                    \
> +       ({                                                              \
> +               typeof(_t1) __t1 =3D (_t1);                              =
 \
> +               (((__t1) & RISCV_DBTR_MC6_HIT1_BIT_MASK) ? 2 : 0) |     \
> +                       (((__t1) & RISCV_DBTR_MC6_HIT_BIT_MASK) ? 1 : 0);=
 \
> +       })
> +
> +#define RISCV_DBTR_MC6_CLEAR_HIT(_t1)                                  \
> +       ((_t1) &=3D ~(RISCV_DBTR_MC6_HIT1_BIT_MASK | RISCV_DBTR_MC6_HIT_B=
IT_MASK))
> +
> +#define RISCV_DBTR_SET_TDATA1_TYPE(_t1, _type)                         \
> +       ({                                                              \
> +               typeof(_t1) (td1t1) =3D (_t1);                           =
 \
> +               (td1t1) &=3D ~RISCV_DBTR_TDATA1_TYPE_BIT_MASK;           =
 \
> +               (td1t1) |=3D (((unsigned long)(_type)                    =
 \
> +                            << RISCV_DBTR_TDATA1_TYPE_BIT)             \
> +                           & RISCV_DBTR_TDATA1_TYPE_BIT_MASK);         \
> +               (td1t1);                                                \
> +       })
> +
> +#define RISCV_DBTR_SET_MC_TYPE(_t1, _type)                             \
> +       ({                                                              \
> +               typeof(_t1) (mct1) =3D (_t1);                            =
 \
> +               (mct1) &=3D ~RISCV_DBTR_MC_TYPE_BIT_MASK;                =
 \
> +               (mct1) |=3D (((unsigned long)(_type)                     =
 \
> +                           << RISCV_DBTR_MC_TYPE_BIT)                  \
> +                          & RISCV_DBTR_MC_TYPE_BIT_MASK);              \
> +               (mct1);                                                 \
> +       })
> +
> +#define RISCV_DBTR_SET_MC6_TYPE(_t1, _type)                            \
> +       ({                                                              \
> +               typeof(_t1) (mc6t1) =3D (_t1);                           =
 \
> +               (mc6t1) &=3D ~RISCV_DBTR_MC6_TYPE_BIT_MASK;              =
 \
> +               (mc6t1) |=3D (((unsigned long)(_type)                    =
 \
> +                            << RISCV_DBTR_MC6_TYPE_BIT)                \
> +                           & RISCV_DBTR_MC6_TYPE_BIT_MASK);            \
> +               (mc6t1);                                                \
> +       })
> +
> +#define RISCV_DBTR_SET_MC_EXEC_BIT(_t1)                        \
> +       SET_DBTR_BIT(_t1, RISCV_DBTR_MC_EXEC_BIT)
> +
> +#define RISCV_DBTR_SET_MC_LOAD_BIT(_t1)                        \
> +       SET_DBTR_BIT(_t1, RISCV_DBTR_MC_LOAD_BIT)
> +
> +#define RISCV_DBTR_SET_MC_STORE_BIT(_t1)               \
> +       SET_DBTR_BIT(_t1, RISCV_DBTR_MC_STORE_BIT)
> +
> +#define RISCV_DBTR_SET_MC_SIZELO(_t1, _val)                            \
> +       ({                                                              \
> +               typeof(_t1) (mcslt1) =3D (_t1);                          =
 \
> +               mcslt1 &=3D ~RISCV_DBTR_MC_SIZELO_BIT_MASK;              =
 \
> +               mcslt1 |=3D (((_val) << RISCV_DBTR_MC_SIZELO_BIT)        =
 \
> +                          & RISCV_DBTR_MC_SIZELO_BIT_MASK);            \
> +               (mcslt1);                                               \
> +       })
> +
> +#if __riscv_xlen >=3D 64
> +#define RISCV_DBTR_SET_MC_SIZEHI(_t1, _val)                            \
> +       ({                                                              \
> +               typeof(_t1) (mcsht1) =3D (_t1);                          =
 \
> +               mcsht1 &=3D ~RISCV_DBTR_MC_SIZEHI_BIT_MASK;              =
 \
> +               mcsht1 |=3D (((_val) << RISCV_DBTR_MC_SIZEHI_BIT)        =
 \
> +                          & RISCV_DBTR_MC_SIZEHI_BIT_MASK);            \
> +               (mcsht1);                                               \
> +       })
> +#else
> +/* SIZEHI does not exist in the rv32 mcontrol layout; nothing to set. */
> +#define RISCV_DBTR_SET_MC_SIZEHI(_t1, _val) ((void)(_val), (_t1))
> +#endif
> +
> +#define RISCV_DBTR_SET_MC6_EXEC_BIT(_t1)               \
> +       SET_DBTR_BIT(_t1, RISCV_DBTR_MC6_EXEC_BIT)
> +
> +#define RISCV_DBTR_SET_MC6_LOAD_BIT(_t1)               \
> +       SET_DBTR_BIT(_t1, RISCV_DBTR_MC6_LOAD_BIT)
> +
> +#define RISCV_DBTR_SET_MC6_STORE_BIT(_t1)              \
> +       SET_DBTR_BIT(_t1, RISCV_DBTR_MC6_STORE_BIT)
> +
> +#define RISCV_DBTR_SET_MC6_SIZE(_t1, _val)                             \
> +       ({                                                              \
> +               typeof(_t1) (mc6szt1) =3D (_t1);                         =
 \
> +               (mc6szt1) &=3D ~RISCV_DBTR_MC6_SIZE_BIT_MASK;            =
 \
> +               (mc6szt1) |=3D (((_val) << RISCV_DBTR_MC6_SIZE_BIT)      =
 \
> +                             & RISCV_DBTR_MC6_SIZE_BIT_MASK);          \
> +               (mc6szt1);                                              \
> +       })

I think all the bit field macros specific to DBTR should go in hw_breakpoin=
t.c.
I also think that we should omit the unused macros and simplify their
readability.
we can do that by omitting clearing/setting versions and just creating
the values in
the function with ORs. There is also already generic versions of these macr=
os in
include/linux/bitfield.h so i would change the macros above to use FIELD_MO=
DIFY
and FIELD_* if you do think the extra checks are necessary.

In my version I also simplified the macro code feel free to take it
https://github.com/Mr-Bossman/linux/commit/d04552102c20542ce54eb4302c899195=
90c6081c

> +
> +struct arch_hw_breakpoint {
> +       unsigned long address;
> +       unsigned long len;
> +       unsigned int type;
> +
> +       /* Trigger configuration data */
> +       unsigned long tdata1;
> +       unsigned long tdata2;
> +       unsigned long tdata3;
> +};
> +
> +struct perf_event_attr;
> +struct notifier_block;
> +struct perf_event;
> +struct pt_regs;
> +
> +int hw_breakpoint_slots(int type);
> +int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
> +int hw_breakpoint_arch_parse(struct perf_event *bp,
> +                            const struct perf_event_attr *attr,
> +                            struct arch_hw_breakpoint *hw);
> +int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> +                                   unsigned long val, void *data);
> +
> +void arch_enable_hw_breakpoint(struct perf_event *bp);
> +void arch_update_hw_breakpoint(struct perf_event *bp);
> +void arch_disable_hw_breakpoint(struct perf_event *bp);
> +int arch_install_hw_breakpoint(struct perf_event *bp);
> +void arch_uninstall_hw_breakpoint(struct perf_event *bp);
> +void hw_breakpoint_pmu_read(struct perf_event *bp);
> +
> +#else
> +
> +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> +#endif /* __RISCV_HW_BREAKPOINT_H */
> diff --git a/arch/riscv/include/asm/kdebug.h b/arch/riscv/include/asm/kde=
bug.h
> index 85ac00411f6e..53e989781aa1 100644
> --- a/arch/riscv/include/asm/kdebug.h
> +++ b/arch/riscv/include/asm/kdebug.h
> @@ -6,7 +6,8 @@
>  enum die_val {
>         DIE_UNUSED,
>         DIE_TRAP,
> -       DIE_OOPS
> +       DIE_OOPS,
> +       DIE_DEBUG
>  };
>
>  #endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index ebe1c3588177..a4197c3c36e8 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)        +=3D mcount-dyn.o
>
>  obj-$(CONFIG_PERF_EVENTS)      +=3D perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)   +=3D perf_regs.o
> +obj-$(CONFIG_HAVE_HW_BREAKPOINT)       +=3D hw_breakpoint.o
>  obj-$(CONFIG_RISCV_SBI)                +=3D sbi.o sbi_ecall.o
>  ifeq ($(CONFIG_RISCV_SBI), y)
>  obj-$(CONFIG_SMP)              +=3D sbi-ipi.o
> diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_bre=
akpoint.c
> new file mode 100644
> index 000000000000..c2ab5e6008e7
> --- /dev/null
> +++ b/arch/riscv/kernel/hw_breakpoint.c
> @@ -0,0 +1,746 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Qualcomm Technologies, Inc.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/hw_breakpoint.h>
> +#include <linux/perf_event.h>
> +#include <linux/spinlock.h>
> +#include <linux/percpu.h>
> +#include <linux/kdebug.h>
> +#include <linux/bitops.h>
> +#include <linux/cpu.h>
> +#include <linux/cpuhotplug.h>
> +
> +#include <asm/sbi.h>
> +
> +/* Registered per-cpu bp/wp */
> +static DEFINE_PER_CPU(struct perf_event *, pcpu_hw_bp_events[RISCV_HW_BP=
_NUM_MAX]);
> +static DEFINE_PER_CPU(unsigned long, ecall_lock_flags);
> +static DEFINE_PER_CPU(raw_spinlock_t, ecall_lock);
> +
> +/* Per-cpu shared memory between S and M mode */
> +static union sbi_dbtr_shmem_entry __percpu *sbi_dbtr_shmem;
> +
> +/* number of debug triggers on this cpu . */
> +static int dbtr_total_num __ro_after_init;
> +static int dbtr_type __ro_after_init;
> +static int dbtr_init __ro_after_init;
> +
> +#define MEM_HI(_m)             (0UL)
> +#define MEM_LO(_m)             ((unsigned long)(_m))
> +
> +static int arch_smp_setup_sbi_shmem(unsigned int cpu)
> +{
> +       union sbi_dbtr_shmem_entry *dbtr_shmem;
> +       phys_addr_t shmem_pa;
> +       struct sbiret ret;
> +
> +       dbtr_shmem =3D per_cpu_ptr(sbi_dbtr_shmem, cpu);
> +
> +       shmem_pa =3D per_cpu_ptr_to_phys(dbtr_shmem);
> +
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
> +                       MEM_LO(shmem_pa), MEM_HI(shmem_pa), 0, 0, 0, 0);
> +
> +       if (ret.error) {
> +               pr_warn("%s: failed to setup shared memory. error: %ld\n"=
,
> +                       __func__, ret.error);
> +               return sbi_err_map_linux_errno(ret.error);
> +       }
> +
> +       pr_info("CPU %d: HW Breakpoint shared memory registered.\n", cpu)=
;
> +
> +       return 0;
> +}
> +
> +static int arch_smp_teardown_sbi_shmem(unsigned int cpu)
> +{
> +       struct sbiret ret;
> +
> +       /* Disable shared memory */
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
> +                       SBI_SHMEM_DISABLE, SBI_SHMEM_DISABLE, 0, 0, 0, 0)=
;
> +
> +       if (ret.error)
> +               pr_warn("%s: failed to disable shared memory. error: %ld\=
n",
> +                       __func__, ret.error);
> +       else
> +               pr_info("CPU %d: HW Breakpoint shared memory disabled.\n"=
, cpu);
> +
> +       return 0;
> +}
> +
> +static void init_sbi_dbtr(void)
> +{
> +       unsigned long tdata1;
> +       struct sbiret ret;
> +
> +       if (sbi_probe_extension(SBI_EXT_DBTR) <=3D 0) {
> +               pr_warn("SBI_EXT_DBTR is not supported\n");
> +               dbtr_total_num =3D 0;
> +               goto done;
> +       }
> +
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> +                       0, 0, 0, 0, 0, 0);
> +       if (ret.error) {
> +               pr_warn("Failed to detect triggers\n");
> +               dbtr_total_num =3D 0;
> +               goto done;
> +       }
> +
> +       tdata1 =3D 0;
> +       tdata1 =3D RISCV_DBTR_SET_TDATA1_TYPE(tdata1, RISCV_DBTR_TRIG_MCO=
NTROL6);
> +
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> +                       tdata1, 0, 0, 0, 0, 0);
> +       if (ret.error) {
> +               pr_warn("Failed to detect mcontrol6 triggers\n");
> +       } else if (!ret.value) {
> +               pr_warn("Type 6 triggers not available\n");
> +       } else {
> +               dbtr_total_num =3D min_t(unsigned long, ret.value,
> +                                      RISCV_HW_BP_NUM_MAX);
> +               dbtr_type =3D RISCV_DBTR_TRIG_MCONTROL6;
> +               pr_warn("Mcontrol6 trigger available.\n");
> +               goto done;
> +       }
> +
> +       /* fallback to type 2 triggers if type 6 is not available */
> +
> +       tdata1 =3D 0;
> +       tdata1 =3D RISCV_DBTR_SET_TDATA1_TYPE(tdata1, RISCV_DBTR_TRIG_MCO=
NTROL);
> +
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> +                       tdata1, 0, 0, 0, 0, 0);
> +       if (ret.error) {
> +               pr_warn("Failed to detect mcontrol triggers\n");
> +       } else if (!ret.value) {
> +               pr_warn("Type 2 triggers not available\n");
> +       } else {
> +               dbtr_total_num =3D min_t(unsigned long, ret.value,
> +                                      RISCV_HW_BP_NUM_MAX);
> +               dbtr_type =3D RISCV_DBTR_TRIG_MCONTROL;
> +               goto done;
> +       }
> +
> +done:
> +       dbtr_init =3D 1;
> +}
> +
> +int hw_breakpoint_slots(int type)
> +{
> +       /*
> +        * We can be called early, so don't rely on
> +        * static variables being initialised.
> +        */
> +
> +       if (!dbtr_init)
> +               init_sbi_dbtr();

dbtr_init should be attomic.
I would put the following in init_sbi_dbtr.
/*
* Called by hw_breakpoint_slots and arch_hw_breakpoint_init.
* Only proceed if this is the first CPU to reach this code.
*/
if (test_and_set_bit(0, &dbtr_init))
return;

> +
> +       return dbtr_total_num;
> +}
> +
> +int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
> +{
> +       unsigned int len;
> +       unsigned long va;
> +
> +       va =3D hw->address;
> +       len =3D hw->len;
> +
> +       return (va >=3D TASK_SIZE) && ((va + len - 1) >=3D TASK_SIZE);
> +}
> +
> +static int rv_init_mcontrol_trigger(const struct perf_event_attr *attr,
> +                                   struct arch_hw_breakpoint *hw)
> +{
> +       switch (attr->bp_type) {
> +       case HW_BREAKPOINT_X:
> +               hw->type =3D RISCV_DBTR_EXEC;
> +               RISCV_DBTR_SET_MC_EXEC_BIT(hw->tdata1);
> +               break;
> +       case HW_BREAKPOINT_R:
> +               hw->type =3D RISCV_DBTR_LOAD;
> +               RISCV_DBTR_SET_MC_LOAD_BIT(hw->tdata1);
> +               break;
> +       case HW_BREAKPOINT_W:
> +               hw->type =3D RISCV_DBTR_STORE;
> +               RISCV_DBTR_SET_MC_STORE_BIT(hw->tdata1);
> +               break;
> +       case HW_BREAKPOINT_RW:
> +               hw->type =3D RISCV_DBTR_LDST;
> +               RISCV_DBTR_SET_MC_LOAD_BIT(hw->tdata1);
> +               RISCV_DBTR_SET_MC_STORE_BIT(hw->tdata1);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (attr->bp_type =3D=3D HW_BREAKPOINT_X) {
> +               /*
> +                * Userspace debuggers can request execute breakpoints wi=
th
> +                * bp_len =3D=3D 2 for compressed/non-aligned instruction
> +                * addresses. Program execute triggers with "match any si=
ze"
> +                * to avoid missing valid instruction fetches.
> +                */
> +               hw->len =3D 0;
> +               hw->tdata1 =3D RISCV_DBTR_SET_MC_SIZELO(hw->tdata1, 0);
> +               hw->tdata1 =3D RISCV_DBTR_SET_MC_SIZEHI(hw->tdata1, 0);
> +       } else {
> +               switch (attr->bp_len) {
> +               case HW_BREAKPOINT_LEN_1:
> +                       hw->len =3D 1;
> +                       hw->tdata1 =3D RISCV_DBTR_SET_MC_SIZELO(hw->tdata=
1, 1);
> +                       break;
> +               case HW_BREAKPOINT_LEN_2:
> +                       hw->len =3D 2;
> +                       hw->tdata1 =3D RISCV_DBTR_SET_MC_SIZELO(hw->tdata=
1, 2);
> +                       break;
> +               case HW_BREAKPOINT_LEN_4:
> +                       hw->len =3D 4;
> +                       hw->tdata1 =3D RISCV_DBTR_SET_MC_SIZELO(hw->tdata=
1, 3);
> +                       break;
> +#if __riscv_xlen >=3D 64
> +               case HW_BREAKPOINT_LEN_8:
> +                       hw->len =3D 8;
> +                       hw->tdata1 =3D RISCV_DBTR_SET_MC_SIZELO(hw->tdata=
1, 1);
> +                       hw->tdata1 =3D RISCV_DBTR_SET_MC_SIZEHI(hw->tdata=
1, 1);
> +                       break;
> +#endif
> +               /* Set to match any size */
> +               default:
> +                       hw->len =3D 0;
> +                       hw->tdata1 =3D RISCV_DBTR_SET_MC_SIZELO(hw->tdata=
1, 0);
> +                       hw->tdata1 =3D RISCV_DBTR_SET_MC_SIZEHI(hw->tdata=
1, 0);
> +                       break;
> +               }
> +       }
> +
> +       hw->tdata1 =3D RISCV_DBTR_SET_MC_TYPE(hw->tdata1, RISCV_DBTR_TRIG=
_MCONTROL);
> +
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_DMODE_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_TIMING_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_SELECT_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_ACTION_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_CHAIN_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_MATCH_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_M_BIT);
> +
> +       /*
> +        * Match only the trigger's actual privilege-mode target. Setting
> +        * both bits makes the kernel's own S-mode uaccess (e.g. SUM-enab=
led
> +        * loads in strncpy_from_user()) spuriously fire a user-space wat=
ch.
> +        */
> +       if (arch_check_bp_in_kernelspace(hw))
> +               SET_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_S_BIT);
> +       else
> +               SET_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_U_BIT);
> +
> +       return 0;
> +}
> +
> +static int rv_init_mcontrol6_trigger(const struct perf_event_attr *attr,
> +                                    struct arch_hw_breakpoint *hw)
> +{
> +       switch (attr->bp_type) {
> +       case HW_BREAKPOINT_X:
> +               hw->type =3D RISCV_DBTR_EXEC;
> +               RISCV_DBTR_SET_MC6_EXEC_BIT(hw->tdata1);
> +               break;
> +       case HW_BREAKPOINT_R:
> +               hw->type =3D RISCV_DBTR_LOAD;
> +               RISCV_DBTR_SET_MC6_LOAD_BIT(hw->tdata1);
> +               break;
> +       case HW_BREAKPOINT_W:
> +               hw->type =3D RISCV_DBTR_STORE;
> +               RISCV_DBTR_SET_MC6_STORE_BIT(hw->tdata1);
> +               break;
> +       case HW_BREAKPOINT_RW:
> +               hw->type =3D RISCV_DBTR_LDST;
> +               RISCV_DBTR_SET_MC6_STORE_BIT(hw->tdata1);
> +               RISCV_DBTR_SET_MC6_LOAD_BIT(hw->tdata1);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (attr->bp_type =3D=3D HW_BREAKPOINT_X) {
> +               /* See rv_init_mcontrol_trigger() for rationale. */
> +               hw->len =3D 0;
> +               hw->tdata1 =3D RISCV_DBTR_SET_MC6_SIZE(hw->tdata1, 0);
> +       } else {
> +               switch (attr->bp_len) {
> +               case HW_BREAKPOINT_LEN_1:
> +                       hw->len =3D 1;
> +                       hw->tdata1 =3D RISCV_DBTR_SET_MC6_SIZE(hw->tdata1=
, 1);
> +                       break;
> +               case HW_BREAKPOINT_LEN_2:
> +                       hw->len =3D 2;
> +                       hw->tdata1 =3D RISCV_DBTR_SET_MC6_SIZE(hw->tdata1=
, 2);
> +                       break;
> +               case HW_BREAKPOINT_LEN_4:
> +                       hw->len =3D 4;
> +                       hw->tdata1 =3D RISCV_DBTR_SET_MC6_SIZE(hw->tdata1=
, 3);
> +                       break;
> +#if __riscv_xlen >=3D 64
> +               case HW_BREAKPOINT_LEN_8:
> +                       hw->len =3D 8;
> +                       hw->tdata1 =3D RISCV_DBTR_SET_MC6_SIZE(hw->tdata1=
, 5);
> +                       break;
> +#endif
> +               /* Set to match any size */
> +               default:
> +                       hw->len =3D 0;
> +                       hw->tdata1 =3D RISCV_DBTR_SET_MC6_SIZE(hw->tdata1=
, 0);
> +               }
> +       }
> +
> +       hw->tdata1 =3D RISCV_DBTR_SET_MC6_TYPE(hw->tdata1, RISCV_DBTR_TRI=
G_MCONTROL6);
> +
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_DMODE_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_TIMING_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_SELECT_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_ACTION_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_CHAIN_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_MATCH_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_M_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_VS_BIT);
> +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_VU_BIT);
> +
> +       /* See rv_init_mcontrol_trigger() for rationale. */
> +       if (arch_check_bp_in_kernelspace(hw))
> +               SET_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_S_BIT);
> +       else
> +               SET_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_U_BIT);
> +
> +       return 0;
> +}
> +
> +int hw_breakpoint_arch_parse(struct perf_event *bp,
> +                            const struct perf_event_attr *attr,
> +                            struct arch_hw_breakpoint *hw)
> +{
> +       int ret;
> +
> +       /* Breakpoint address */
> +       hw->address =3D attr->bp_addr;
> +       hw->tdata2 =3D attr->bp_addr;
> +       hw->tdata3 =3D 0x0;
> +
> +       switch (dbtr_type) {
> +       case RISCV_DBTR_TRIG_MCONTROL:
> +               ret =3D rv_init_mcontrol_trigger(attr, hw);
> +               break;
> +       case RISCV_DBTR_TRIG_MCONTROL6:
> +               ret =3D rv_init_mcontrol6_trigger(attr, hw);
> +               break;
> +       default:
> +               pr_warn("Unsupported trigger type\n");
> +               ret =3D -EOPNOTSUPP;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +/*
> + * Read mcontrol6's hit1:hit0 field for trigger @idx. If either bit is s=
et,
> + * clear it in hardware (the Debug spec requires the trigger user to do
> + * this; hardware only ever sets it). Returns the RISCV_DBTR_MC6_HIT_*
> + * value read (RISCV_DBTR_MC6_HIT_FALSE if unimplemented or unfired).
> + */
> +static unsigned int mc6_read_and_clear_hit(int idx)
> +{
> +       union sbi_dbtr_shmem_entry *shmem =3D this_cpu_ptr(sbi_dbtr_shmem=
);
> +       struct sbi_dbtr_data_msg *xmit;
> +       unsigned long tdata1, tdata2, tdata3;
> +       struct sbiret ret;
> +       unsigned int hit;
> +
> +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> +                             *this_cpu_ptr(&ecall_lock_flags));
> +
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_READ, idx, 1, 0=
, 0, 0, 0);
> +       if (ret.error) {
> +               pr_warn("Failed to read trigger %d. error: %ld\n", idx, r=
et.error);
> +               hit =3D RISCV_DBTR_MC6_HIT_FALSE;
> +               goto out;
> +       }
> +
> +       tdata1 =3D le_to_cpu(shmem->data.tdata1);
> +       hit =3D RISCV_DBTR_MC6_GET_HIT(tdata1);
> +       if (hit =3D=3D RISCV_DBTR_MC6_HIT_FALSE)
> +               goto out;
> +
> +       tdata2 =3D le_to_cpu(shmem->data.tdata2);
> +       tdata3 =3D le_to_cpu(shmem->data.tdata3);
> +       RISCV_DBTR_MC6_CLEAR_HIT(tdata1);
> +
> +       xmit =3D &shmem->data;
> +       xmit->tdata1 =3D cpu_to_le(tdata1);
> +       xmit->tdata2 =3D cpu_to_le(tdata2);
> +       xmit->tdata3 =3D cpu_to_le(tdata3);
> +
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UPDATE, idx, 1,=
 0, 0, 0, 0);
> +       if (ret.error)
> +               pr_warn("Failed to clear hit bits on trigger %d. error: %=
ld\n",
> +                       idx, ret.error);
> +
> +out:
> +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> +                                  *this_cpu_ptr(&ecall_lock_flags));
> +       return hit;
> +}
> +
> +/*
> + * HW Breakpoint/watchpoint handler
> + */
> +static int hw_breakpoint_handler(struct die_args *args)
> +{
> +       int ret =3D NOTIFY_DONE;
> +       struct arch_hw_breakpoint *bp;
> +       struct perf_event *event;
> +       int i;
> +
> +       for (i =3D 0; i < dbtr_total_num; i++) {
> +               event =3D this_cpu_read(pcpu_hw_bp_events[i]);
> +               if (!event)
> +                       continue;
> +
> +               bp =3D counter_arch_bp(event);
> +               switch (bp->type) {
> +               /* Breakpoint */
> +               case HW_BREAKPOINT_X:
> +               {
> +                       bool hit =3D bp->address =3D=3D args->regs->epc;
> +
> +                       if (!hit && dbtr_type =3D=3D RISCV_DBTR_TRIG_MCON=
TROL6)
> +                               hit =3D mc6_read_and_clear_hit(i) !=3D RI=
SCV_DBTR_MC6_HIT_FALSE;
> +
> +                       if (hit) {
> +                               perf_bp_event(event, args->regs);
> +                               ret =3D NOTIFY_STOP;
> +                       }
> +                       break;
> +               }
> +
> +               /* Watchpoint */
> +               case HW_BREAKPOINT_W:
> +               case HW_BREAKPOINT_R:
> +               case HW_BREAKPOINT_RW:
> +               {
> +                       unsigned long stval =3D args->regs->badaddr;
> +                       unsigned long bp_start =3D bp->address;
> +                       unsigned long bp_len =3D bp->len ?: 1;
> +                       unsigned long bp_end =3D bp_start + bp_len - 1;
> +                       unsigned long stval_end =3D stval + sizeof(long) =
- 1;
> +                       bool hit =3D false;
> +
> +                       if (bp_end < bp_start)
> +                               bp_end =3D ~0UL;
> +                       if (stval_end < stval)
> +                               stval_end =3D ~0UL;
> +
> +                       /*
> +                        * Prefer tdata1.hit from SBI trigger readout whe=
never
> +                        * possible. Fall back to address-based matching =
if HIT
> +                        * isn't observed/supported.
> +                        */
> +                       if (dbtr_type =3D=3D RISCV_DBTR_TRIG_MCONTROL) {
> +                               unsigned long tdata1;
> +                               struct sbiret sret;
> +                               union sbi_dbtr_shmem_entry *shmem;
> +
> +                               raw_spin_lock_irqsave(this_cpu_ptr(&ecall=
_lock),
> +                                                     *this_cpu_ptr(&ecal=
l_lock_flags));
> +                               shmem =3D this_cpu_ptr(sbi_dbtr_shmem);
> +                               sret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_=
DBTR_TRIG_READ,
> +                                                i, 1, 0, 0, 0, 0);
> +                               if (!sret.error) {
> +                                       tdata1 =3D le_to_cpu(shmem->data.=
tdata1);
> +                                       hit =3D !!(tdata1 & RISCV_DBTR_MC=
_HIT_BIT_MASK);
> +                               }
> +                               raw_spin_unlock_irqrestore(this_cpu_ptr(&=
ecall_lock),
> +                                                          *this_cpu_ptr(=
&ecall_lock_flags));
> +                       } else if (dbtr_type =3D=3D RISCV_DBTR_TRIG_MCONT=
ROL6) {
> +                               hit =3D mc6_read_and_clear_hit(i) !=3D RI=
SCV_DBTR_MC6_HIT_FALSE;
> +                       }
> +
> +                       /*
> +                        * Sdtrig may report STVAL as the lowest accessed
> +                        * address while the watchpoint can match a highe=
r byte
> +                        * in the same access.
> +                        */
> +                       if (hit ||
> +                           (stval >=3D bp_start && stval <=3D bp_end) ||
> +                           (bp_start >=3D stval && bp_start <=3D stval_e=
nd)) {

I think that using `abs_diff` here would be much less confusing.
like so
if (abs_diff(bp_start, stval) < bp->len)

Thanks,
Jesse Taube

> +                               perf_bp_event(event, args->regs);
> +                               ret =3D NOTIFY_STOP;
> +                       }
> +                       break;
> +               }
> +
> +               default:
> +                       pr_warn("Unknown type: %u\n", bp->type);
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> +                                   unsigned long val, void *data)
> +{
> +       if (val !=3D DIE_DEBUG)
> +               return NOTIFY_DONE;
> +
> +       return hw_breakpoint_handler(data);
> +}
> +
> +/* atomic: counter->ctx->lock is held */
> +int arch_install_hw_breakpoint(struct perf_event *event)
> +{
> +       struct arch_hw_breakpoint *bp =3D counter_arch_bp(event);
> +       union sbi_dbtr_shmem_entry *shmem =3D this_cpu_ptr(sbi_dbtr_shmem=
);
> +       struct sbi_dbtr_data_msg *xmit;
> +       struct sbi_dbtr_id_msg *recv;
> +       struct perf_event **slot;
> +       unsigned long idx;
> +       struct sbiret ret;
> +       int err =3D 0;
> +
> +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> +                             *this_cpu_ptr(&ecall_lock_flags));
> +
> +       xmit =3D &shmem->data;
> +       recv =3D &shmem->id;
> +       xmit->tdata1 =3D cpu_to_le(bp->tdata1);
> +       xmit->tdata2 =3D cpu_to_le(bp->tdata2);
> +       xmit->tdata3 =3D cpu_to_le(bp->tdata3);
> +
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_INSTALL,
> +                       1, 0, 0, 0, 0, 0);
> +
> +       if (ret.error) {
> +               pr_warn("Failed to install trigger\n");
> +               err =3D sbi_err_map_linux_errno(ret.error);
> +               goto done;
> +       }
> +
> +       idx =3D le_to_cpu(recv->idx);
> +       if (idx >=3D dbtr_total_num) {
> +               pr_warn("Invalid trigger index %lu\n", idx);
> +               err =3D -EINVAL;
> +               goto done;
> +       }
> +
> +       slot =3D this_cpu_ptr(&pcpu_hw_bp_events[idx]);
> +       if (*slot) {
> +               pr_warn("Slot %lu is in use\n", idx);
> +               err =3D -EBUSY;
> +               goto done;
> +       }
> +
> +       /* Save the event - to be looked up in handler */
> +       *slot =3D event;
> +
> +done:
> +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> +                                  *this_cpu_ptr(&ecall_lock_flags));
> +       return err;
> +}
> +
> +/* atomic: counter->ctx->lock is held */
> +void arch_uninstall_hw_breakpoint(struct perf_event *event)
> +{
> +       struct sbiret ret;
> +       int i;
> +
> +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> +                             *this_cpu_ptr(&ecall_lock_flags));
> +
> +       for (i =3D 0; i < dbtr_total_num; i++) {
> +               struct perf_event **slot =3D this_cpu_ptr(&pcpu_hw_bp_eve=
nts[i]);
> +
> +               if (*slot =3D=3D event) {
> +                       *slot =3D NULL;
> +                       break;
> +               }
> +       }
> +
> +       if (i =3D=3D dbtr_total_num) {
> +               pr_warn("Breakpoint not installed.\n");
> +               goto out;
> +       }
> +
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UNINSTALL,
> +                       i, 1, 0, 0, 0, 0);
> +
> +       if (ret.error) {
> +               pr_warn("Failed to uninstall trigger %d.\n", i);
> +               goto out;
> +       }
> +
> + out:
> +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> +                                  *this_cpu_ptr(&ecall_lock_flags));
> +}
> +
> +void arch_enable_hw_breakpoint(struct perf_event *event)
> +{
> +       struct sbiret ret;
> +       int i;
> +       struct perf_event **slot;
> +
> +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> +                             *this_cpu_ptr(&ecall_lock_flags));
> +
> +       for (i =3D 0; i < dbtr_total_num; i++) {
> +               slot =3D this_cpu_ptr(&pcpu_hw_bp_events[i]);
> +
> +               if (*slot =3D=3D event)
> +                       break;
> +       }
> +
> +       if (i =3D=3D dbtr_total_num) {
> +               pr_warn("Breakpoint not installed.\n");
> +               goto out;
> +       }
> +
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_ENABLE,
> +                       i, 1, 0, 0, 0, 0);
> +
> +       if (ret.error) {
> +               pr_warn("Failed to install trigger %d\n", i);
> +               goto out;
> +       }
> +
> + out:
> +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> +                                  *this_cpu_ptr(&ecall_lock_flags));
> +}
> +EXPORT_SYMBOL_GPL(arch_enable_hw_breakpoint);
> +
> +void arch_update_hw_breakpoint(struct perf_event *event)
> +{
> +       struct arch_hw_breakpoint *bp =3D counter_arch_bp(event);
> +       union sbi_dbtr_shmem_entry *shmem =3D this_cpu_ptr(sbi_dbtr_shmem=
);
> +       struct sbi_dbtr_data_msg *xmit;
> +       struct sbi_dbtr_id_msg *id;
> +       struct perf_event **slot;
> +       struct sbiret ret;
> +       int i;
> +
> +       for (i =3D 0; i < dbtr_total_num; i++) {
> +               slot =3D this_cpu_ptr(&pcpu_hw_bp_events[i]);
> +
> +               if (*slot =3D=3D event)
> +                       break;
> +       }
> +
> +       if (i =3D=3D dbtr_total_num) {
> +               pr_warn("Breakpoint not installed.\n");
> +               return;
> +       }
> +
> +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> +                             *this_cpu_ptr(&ecall_lock_flags));
> +
> +       id =3D &shmem->id;
> +       xmit =3D &shmem->data;
> +       id->idx =3D cpu_to_le(i);
> +       xmit->tdata1 =3D cpu_to_le(bp->tdata1);
> +       xmit->tdata2 =3D cpu_to_le(bp->tdata2);
> +       xmit->tdata3 =3D cpu_to_le(bp->tdata3);
> +
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UPDATE,
> +                       1, 0, 0, 0, 0, 0);
> +       if (ret.error)
> +               pr_warn("Failed to update trigger %d.\n", i);
> +
> +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> +                                  *this_cpu_ptr(&ecall_lock_flags));
> +}
> +EXPORT_SYMBOL_GPL(arch_update_hw_breakpoint);
> +
> +void arch_disable_hw_breakpoint(struct perf_event *event)
> +{
> +       struct perf_event **slot;
> +       struct sbiret ret;
> +       int i;
> +
> +       for (i =3D 0; i < dbtr_total_num; i++) {
> +               slot =3D this_cpu_ptr(&pcpu_hw_bp_events[i]);
> +
> +               if (*slot =3D=3D event)
> +                       break;
> +       }
> +
> +       if (i =3D=3D dbtr_total_num) {
> +               pr_warn("Breakpoint not installed.\n");
> +               return;
> +       }
> +
> +       ret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_DISABLE,
> +                       i, 1, 0, 0, 0, 0);
> +
> +       if (ret.error) {
> +               pr_warn("Failed to uninstall trigger %d.\n", i);
> +               return;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(arch_disable_hw_breakpoint);
> +
> +void hw_breakpoint_pmu_read(struct perf_event *bp) { }
> +
> +void flush_ptrace_hw_breakpoint(struct task_struct *tsk) { }
> +
> +static int __init arch_hw_breakpoint_init(void)
> +{
> +       unsigned int cpu;
> +       int rc =3D 0;
> +
> +       for_each_possible_cpu(cpu)
> +               raw_spin_lock_init(&per_cpu(ecall_lock, cpu));
> +
> +       if (!dbtr_init)
> +               init_sbi_dbtr();
> +
> +       if (dbtr_total_num) {
> +               pr_info("Total number of type %d triggers: %u\n",
> +                       dbtr_type, dbtr_total_num);
> +       } else {
> +               pr_info("No hardware triggers available\n");
> +               goto out;
> +       }
> +
> +       /* Allocate per-cpu shared memory */
> +       sbi_dbtr_shmem =3D __alloc_percpu(sizeof(*sbi_dbtr_shmem) * dbtr_=
total_num,
> +                                       PAGE_SIZE);
> +
> +       if (!sbi_dbtr_shmem) {
> +               pr_warn("Failed to allocate shared memory.\n");
> +               rc =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       /* Hotplug handler to register/unregister shared memory with SBI =
*/
> +       rc =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +                              "riscv/hw_breakpoint:prepare",
> +                              arch_smp_setup_sbi_shmem,
> +                              arch_smp_teardown_sbi_shmem);
> +
> +       if (rc < 0) {
> +               pr_warn("Failed to setup CPU hotplug state\n");
> +               free_percpu(sbi_dbtr_shmem);
> +               return rc;
> +       }
> + out:
> +       return rc;
> +}
> +arch_initcall(arch_hw_breakpoint_init);
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f8292adda099..1b9ccc0b6b8d 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -287,6 +287,12 @@ void handle_break(struct pt_regs *regs)
>         if (probe_breakpoint_handler(regs))
>                 return;
>
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +       if (notify_die(DIE_DEBUG, "EBREAK", regs, 0, regs->cause, SIGTRAP=
)
> +           =3D=3D NOTIFY_STOP)
> +               return;
> +#endif
> +
>         current->thread.bad_cause =3D regs->cause;
>
>         if (user_mode(regs))
> --
> 2.43.0
>

