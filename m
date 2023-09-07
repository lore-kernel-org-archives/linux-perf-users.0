Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631C6EC8744
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Sep 2023 16:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbjIGQgi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjIGQgQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Sep 2023 12:36:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F7F4EE9
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Sep 2023 09:23:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26fa19322b5so290863a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Sep 2023 09:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694103721; x=1694708521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCgeZHNY/DlNrnLkKkluN6xg5KeAlPieZsIE6jFbPVc=;
        b=OajGS8aKNUy+8BQZK+qZ4T5Qgw41TsCeKg3uoxUumIUZF6onFKK4NXqj4hdl5uDNj3
         R6z9T4paffqI5H1KKlzxmqlcqdDuiE63XjV0eizqSZO4J7dNlPCnmHonndQvgCzONAgJ
         1Kzm1fclGjJE3QTvBPTHVaM7DDmpYiuNwZEpS22wgVGYFTBJ2/0fDDOd30hDMFpiA95/
         V9ZpnqlTBcjfkSvyVNozwrPvuQ5WcBb1A6yEjasMq+o93Ku9riUh2mC1PBmDAKD/tn1N
         qOWjtWokYYYf8FpXaiZI0hRpQFtl19hsj6Xe6ZOjHpT5Uk5OsR0usb0SV/9G7pbABBca
         Ravw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103721; x=1694708521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCgeZHNY/DlNrnLkKkluN6xg5KeAlPieZsIE6jFbPVc=;
        b=O1sz7fLHyenyJ0toXulDorMvKqDI8++nnCvTGUbi5Zbc/zwvkDeIIcKuA5CoO4jQCC
         0PQnRtTsszodF4arGehSZa9Pw1vppRzwCOvw2r4F5uKjmqYV1+Dve8E+KBIW4VOO2jYp
         b/XIog8sIUWcx6x9lqBq2q1iZSnDs7FN6smEyv698P/ECnSD/QJAJcIozkrb2+wcZdKM
         pZ5TxXRNRci063mQrR+k3D4tlRdYsIxfPfyW61vOjCnNv1DoO15YUwwCxfJnV7XHmXQz
         XNCtygDvk6ZUnoXvC2aYxB/FQdvC93v3Hrh+ajGdQsPINfZtkBRTJIfZRnoa8A5rDoUr
         lNBA==
X-Gm-Message-State: AOJu0YyHfML5wfJ0OigAHIUioRw5Pq3uh/YQDofSY7lU6zr55II087vQ
        DfvrXv2iVlhRkVaC1QBBsrG7RQ+P/dqNoQSRPOfRSA==
X-Google-Smtp-Source: AGHT+IFZ8rAMkndFAe9nk36Eotx+d5nxbthNhzZ4DS5IlxlT8T8Od24Sm3zFo4dnTgB8luNvNyYScg==
X-Received: by 2002:a17:902:d48f:b0:1c0:cbaf:6939 with SMTP id c15-20020a170902d48f00b001c0cbaf6939mr21706846plg.3.1694082193128;
        Thu, 07 Sep 2023 03:23:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:ef65:d0f:73cf:bc3c? ([2a01:e0a:999:a3a0:ef65:d0f:73cf:bc3c])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902ed1300b001b9de39905asm12485964pld.59.2023.09.07.03.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 03:23:12 -0700 (PDT)
Message-ID: <ff6302ae-a114-4ef0-be87-a5fa34c3aab5@rivosinc.com>
Date:   Thu, 7 Sep 2023 12:22:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] irqchip/riscv-intc: Support large non-standard
 hwirq number
Content-Language: en-US
To:     Yu Chien Peter Lin <peterlin@andestech.com>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, atishp@atishpatra.org,
        anup@brainfault.org, prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     ajones@ventanamicro.com, heiko@sntech.de, samuel@sholland.org,
        geert+renesas@glider.be, n.shubin@yadro.com, dminus@andestech.com,
        ycliang@andestech.com, tim609@andestech.com, locus84@andestech.com,
        dylan@andestech.com
References: <20230907021635.1002738-1-peterlin@andestech.com>
 <20230907021635.1002738-3-peterlin@andestech.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230907021635.1002738-3-peterlin@andestech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 07/09/2023 04:16, Yu Chien Peter Lin wrote:
> Currently, the implementation of the RISC-V INTC driver uses the
> interrupt cause as hwirq and has a limitation of supporting a
> maximum of 64 hwirqs. However, according to the privileged spec,
> interrupt cause >= 16 are defined for platform use.
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
> [1] http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> ---
>  drivers/irqchip/irq-riscv-intc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> index 4adeee1bc391..76e1229c45de 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -24,8 +24,8 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
>  {
>  	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
>  
> -	if (unlikely(cause >= BITS_PER_LONG))
> -		panic("unexpected interrupt cause");
> +	if (!irq_find_mapping(intc_domain, cause))
> +		panic("unexpected interrupt cause: %ld", cause);

Hi Yu,

It seems like generic_handle_domain_irq() returns -EINVAL if provided
with NULL (which will happen if the interrupt does not have a mapping
due to __irq_resolve_mapping returning NULL) so maybe it is possible to
remove this check (since __irq_resolve_mapping() is also called by
generic_handle_domain_irq()) and panic if generic_handle_domain_irq()
returns -EINVAL ? That would avoid calling __irq_resolve_mapping() twice
for really rare cases.

Clément

>  
>  	generic_handle_domain_irq(intc_domain, cause);
>  }
> @@ -117,8 +117,8 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
>  {
>  	int rc;
>  
> -	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
> -					       &riscv_intc_domain_ops, NULL);
> +	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops,
> +					     NULL);
>  	if (!intc_domain) {
>  		pr_err("unable to add IRQ domain\n");
>  		return -ENXIO;
> @@ -132,8 +132,6 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
>  
>  	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
>  
> -	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> -
>  	return 0;
>  }
>  
