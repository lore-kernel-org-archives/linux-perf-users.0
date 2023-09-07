Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECBAEC8738
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Sep 2023 16:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjIGQMX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbjIGQLy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Sep 2023 12:11:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7FF5191
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Sep 2023 09:08:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so1561771a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Sep 2023 09:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1694102855; x=1694707655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlqiYu4W6Rw8b3OUfLdEXFPD32dWiZ3Dy4bMwhxUd4E=;
        b=R5nbxaCY0U5N2JyuXc6I0PKh9fDThBO39VuHSRgw+fllMrpN2IQJViUBz4L9PffrfY
         Knc4QLbNNePSW6LdSwv6cSQIuZd6yTtH0ixjBthF6HCW4k0fV4ak3uPLJHrhRaLXXPpW
         zXA7KwK2AZ497J6eLOVhCslSp1IMe2P9VWGQb0ILfRp5p37yOaEQ7KoJCTNEBkbKL15U
         zu2VWLsVQDxNv7JwfOdKZ5whhpP+GUDmqGlzaR7A7TbVsC2ff85T2LjI+Entj5tpAk7U
         LmdlvqYKe43guk3hFDimb32od0IOnTUJIl0SVTOXO+K7MvO66toXX9q4TU4RLk8mP4t8
         DjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102855; x=1694707655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlqiYu4W6Rw8b3OUfLdEXFPD32dWiZ3Dy4bMwhxUd4E=;
        b=jNU5fHNpg0KVopcvaR03KY+QGHuIlCBFTo2+7wOLVDp7EiDVqDNqAgcVgII8tUMBxB
         F/7Z10LU+SqnZ3nkwlI0m4hzpmLDx1CI7LuFhK8rDrjWkUp0taTjFkbnb7iep3TWSKQo
         51qaDxPRRlkZZ/2zifYWQWBEzGl/axdq3Fr5tp/KwOjtkeYvkdXl1Jtc021T6nV1XKZK
         HUGH0hGJIBGxNi/564ocw1I4iae3JW+T/ucBDXo59fDGxJkI76Ckim0lNXzPrbn+0kUC
         3N417n0ItqSSn/LD9yfukIxfSlfAwfX4K8CvAfggTKvnUK1eu9Fr/Y8RHbk9jh1EIPji
         hcog==
X-Gm-Message-State: AOJu0Yx6KFoXQYxKgivcbuceMojMkbvQzzaLtRHbqkb9mokuemZqkvQ8
        VzX6QOATh7cO42CwwpYwC6hbvYhWkW7o+AFiSKty9abZNX1KhSD17Vf4Tg==
X-Google-Smtp-Source: AGHT+IFZKvLvDrcUUt1AdJGgmJG9It2BwH1JwdrdkbJnayvU4ppYimD21mX/yyhLW9K0tMnO6jb+LUunyIXhKsgJQIw=
X-Received: by 2002:a05:6512:706:b0:4f8:62a6:8b2 with SMTP id
 b6-20020a056512070600b004f862a608b2mr4812176lfs.46.1694092023638; Thu, 07 Sep
 2023 06:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230907021635.1002738-1-peterlin@andestech.com> <20230907021635.1002738-3-peterlin@andestech.com>
In-Reply-To: <20230907021635.1002738-3-peterlin@andestech.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 7 Sep 2023 18:36:52 +0530
Message-ID: <CAAhSdy0iy_7-XaE0s97J8jUESUzV-4BMsxsJ8QFNDyHgtv63ZA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] irqchip/riscv-intc: Support large non-standard
 hwirq number
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, atishp@atishpatra.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, ajones@ventanamicro.com,
        heiko@sntech.de, samuel@sholland.org, geert+renesas@glider.be,
        n.shubin@yadro.com, dminus@andestech.com, ycliang@andestech.com,
        tim609@andestech.com, locus84@andestech.com, dylan@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 7, 2023 at 7:48=E2=80=AFAM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> Currently, the implementation of the RISC-V INTC driver uses the
> interrupt cause as hwirq and has a limitation of supporting a
> maximum of 64 hwirqs. However, according to the privileged spec,
> interrupt cause >=3D 16 are defined for platform use.
>
> This limitation prevents us from fully utilizing the available
> local interrupt sources. Additionally, the hwirqs used on RISC-V
> are sparse, with only interrupt numbers 1, 5 and 9 (plus Sscofpmf
> or T-Head's PMU irq) being currently used for supervisor mode.
>
> The patch switches to using irq_domain_create_tree() which
> creates the radix tree map, allowing us to handle a larger
> number of hwirqs.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
>
> ---
> There are 3 hwirqs of local interrupt source exceed 64 defined in
> AX45MP datasheet [1] Table 56: AX45MP-1C scause Value After Trap:
> - 256+16 Slave port ECC error interrupt (S-mode)
> - 256+17 Bus write transaction error interrupt (S-mode)
> - 256+18 Performance monitor overflow interrupt(S-mode)
>
> [1] http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Data=
sheet.pdf
> ---
>  drivers/irqchip/irq-riscv-intc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index 4adeee1bc391..76e1229c45de 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -24,8 +24,8 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *r=
egs)
>  {
>         unsigned long cause =3D regs->cause & ~CAUSE_IRQ_FLAG;
>
> -       if (unlikely(cause >=3D BITS_PER_LONG))
> -               panic("unexpected interrupt cause");
> +       if (!irq_find_mapping(intc_domain, cause))
> +               panic("unexpected interrupt cause: %ld", cause);

Checking irq_find_mapping() is redundant here instead check the return
value of generic_handle_domain_irq() and print warning on error.

>
>         generic_handle_domain_irq(intc_domain, cause);
>  }
> @@ -117,8 +117,8 @@ static int __init riscv_intc_init_common(struct fwnod=
e_handle *fn)
>  {
>         int rc;
>
> -       intc_domain =3D irq_domain_create_linear(fn, BITS_PER_LONG,
> -                                              &riscv_intc_domain_ops, NU=
LL);
> +       intc_domain =3D irq_domain_create_tree(fn, &riscv_intc_domain_ops=
,
> +                                            NULL);

This is incomplete because you have additional customization on-top-of
vanilla RISC-V INTC.

I suggest to do the following:
1) Define an enum of types of INTC (such as generic, andestech, etc)
2) Define new compatible string "andestec,cpu-intc" for you custom INTC
    and pass that information to riscv_intc_init_common()
3) Extend riscv_intc_domain_map() to use custom andestech_intc_chip
    for the custom local irqs. The andestech_intc_chip will provide andes
    specific mask/unmask mechanism.

>         if (!intc_domain) {
>                 pr_err("unable to add IRQ domain\n");
>                 return -ENXIO;
> @@ -132,8 +132,6 @@ static int __init riscv_intc_init_common(struct fwnod=
e_handle *fn)
>
>         riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
>
> -       pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> -
>         return 0;
>  }
>
> --
> 2.34.1
>

Regards,
Anup
