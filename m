Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E02C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 20:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B02610F8
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 20:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhJ1UUN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhJ1UUM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 16:20:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33016C061745
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Oct 2021 13:17:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s13so5083985wrb.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Oct 2021 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QQHy5W4NO/yZkhM4CUJlGj83LWvnUyD366Fk7aGMOq0=;
        b=foANG7O14U8sEI7ZM6z8LKCSBA21HEfZaM4bwrYibqI9I+7AD56u4y1BdbkLifkfVm
         AtrE9CrJTCU7T7u4SCamS3G6CjOUp3rL8f0+28Dkc9RLyFf0l2vYnDOr9ygVQ7W/mPrj
         2o7df8IPsKQ93pXnjmkq6AwYNd07iCu+J47pHl9u4Eu1X/2nB8cBwipHprKsa9rSAn1k
         Bm8Kgr7VTpiTm6K2fVsmoqlcJ5P8f8oJl2IGsGtlif97mpifCBf0ivhNGe7qyLv7Qiz6
         IW52nn/EIWvuVa+ztbwucd0BMpjBYLEWf+wPytCIr7ZTRHpEsHECm8xY9y9NxFEKuGIR
         QrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQHy5W4NO/yZkhM4CUJlGj83LWvnUyD366Fk7aGMOq0=;
        b=4BlHt8nyAWjoGakHe+1Ee9babcUc3RXsnlYq4/R/AiMtqSmfBO2UFGj5/0b3o0/9ZO
         7GajIqY4uuD8TKwQOvGc+LMlCmAY9s/3BIubJu0BjramjX7Ad0LD4Q4t9/psvrqYhGG9
         5sHz637vAHSNzSQDDb42pMxEz8EpNiE4HlsfR/XWC+tCAMgpR1cqULkuspaoyi7DCQQE
         /5l2aJ/Hi9CdBXhKu0ZyTfTfrbGD2Xijmom+9E55ElUBCF1bL5aAVuGbvF9TTx21AP59
         U/lWi9S6YdI17Ay7tAq3U8LV8tyoYQiDGmt4JDKBWUMRVfspUbl/vj60aXrY5OByRGAt
         kQfw==
X-Gm-Message-State: AOAM531YFZOCoqBpywfUYMIGagFhS+eZ14vrrlCQ1hnBULQ/GhZtpWN+
        gRJWwARf8y2zVsdcn0Q9mrQKng==
X-Google-Smtp-Source: ABdhPJwQ1VglxMGcOdndU0OUSIqA7uD0zPYkNbvW3Po5Rb8V6zwfdp3UJXnb4kkrEEhK65pslhw79g==
X-Received: by 2002:a5d:4f85:: with SMTP id d5mr8741341wru.247.1635452263729;
        Thu, 28 Oct 2021 13:17:43 -0700 (PDT)
Received: from Jessicas-MacBook-Pro.local (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id t8sm3835979wrx.47.2021.10.28.13.17.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Oct 2021 13:17:43 -0700 (PDT)
Received: by Jessicas-MacBook-Pro.local (Postfix, from userid 501)
        id D60A89279738; Thu, 28 Oct 2021 21:17:42 +0100 (BST)
Date:   Thu, 28 Oct 2021 21:17:42 +0100
From:   Jessica Clarke <jrtc27@jrtc27.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        devicetree@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [v4 06/11] dt-binding: pmu: Add RISC-V PMU DT bindings
Message-ID: <YXsFZmRwpQAWhSw0@Jessicas-MacBook-Pro.local>
References: <20211025195350.242914-1-atish.patra@wdc.com>
 <20211025195350.242914-7-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025195350.242914-7-atish.patra@wdc.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 25, 2021 at 12:53:45PM -0700, Atish Patra wrote:
> This patch adds the DT bindings for RISC-V PMU driver. It also defines
> the interrupt related properties to allow counter overflow interrupt.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  .../devicetree/bindings/perf/riscv,pmu.yaml   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> new file mode 100644
> index 000000000000..497caad63f16
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pmu/riscv,pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V PMU
> +
> +maintainers:
> +  - Atish Patra <atish.patra@wdc.com>
> +
> +description:
> +  The "Sscofpmf" extension allows the RISC-V PMU counters to overflow and
> +  generate a local interrupt so that event sampling can be done from user-space.
> +  The above said ISA extension is an optional extension to maintain backward
> +  compatibility and will be included in privilege specification v1.12 . That's
> +  why the interrupt property is marked as optional. The platforms with sscofpmf
> +  extension should add this property to enable event sampling.
> +  The device tree node with the compatible string is mandatory for any platform
> +  that wants to use pmu counter start/stop methods using SBI PMU extension.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - riscv,pmu

This is conflating the Sscofpmf extension with the SBI PMU interface;
the former is what the hardware supports, the latter is what the
firmware exposes. The SBI interface exists today and does not require
overflow interrupts to be supported, so there needs to be a distinction
between that case and the case where Sscofpmf is supported in both
hardware and the SBI implementation, which probably means having a
second compatible string for that case that also includes the generic
SBI PMU interface as a fallback compatible string.

Secondly, I do not think this is the right name for this. The riscv,pmu
compatible string (or anything of that nature) should be reserved for
*hardware* that provides usable performance monitoring features to an
OS. This is not that, this is the SBI interface that requires an OS to
make firmware calls for any starting, stopping or configuring of a
counter, which results in an even greater probe effect than is already
present with frameworks like FreeBSD's HWPMC or Linux's perf (I don't
know how the two compare on that front, but I imagine Linux is similar
to FreeBSD). This should have SBI in the name so that it doesn't get in
the way of real performance monitoring support once the architecture is
finally mature enough to have S-mode-configurable counters and a
standardised set of common events like pretty much every other
architecture.

Also I do not like the use of PMU, since that is Arm's terminology,
whereas RISC-V uses HPM, but you've already defined the SBI interface as
being PMU so I guess that ship has sailed.

Jess

> +
> +    description:
> +      Should be "riscv,pmu".
> +
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 4095
> +
> +additionalProperties: false
> +
> +required:
> +  - None
> +optional:
> +  - compatible
> +  - interrupts-extended
> +
> +examples:
> +  - |
> +    pmu {
> +      compatible = "riscv,pmu";
> +      interrupts-extended = <&cpu0intc 13>,
> +                            <&cpu1intc 13>,
> +                            <&cpu2intc 13>,
> +                            <&cpu3intc 13>;
> +    };
> +...
> -- 
> 2.31.1
