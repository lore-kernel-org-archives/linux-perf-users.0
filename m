Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C23C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 15:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B05161247
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 15:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhINPwV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:52:21 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39707 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbhINPvy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Sep 2021 11:51:54 -0400
Received: by mail-ot1-f53.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so19086814otf.6;
        Tue, 14 Sep 2021 08:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rnTeP9MXgZMY0ccObwY7v7BGqeBnLTs9n9kuMAleLtU=;
        b=uMrQXwPkwZQI4u+fgY8x57N5Sf+XGFPy3a8dSWB+Q9NcZRmI6ihQh2yirR+Kw1z8wb
         S8foRUr6DmH56Gf9Al9phiQ8tmlTb6RdYCeYhQeM1ENspC71mqbXTPVweD9wvJhfJckZ
         oYy9Di6Yiy2kJ9eGCVAqN0tYECNV7FxYYEGu3tbVCEtkm9FOa3Cd0zCHlfpd6RYdbwgl
         MdzjbEH4v9mdLQcBKOF6cKLjlYfiYkdocHc+Pto+rsMuey9sxsI3/Qe5zzgaIZT85UzM
         8BrVvb+kFknkVNqmqiDNx9wa8cKiDgEuJQulv2HGZ5z0Ddkg0wXoeMy/Kt5Gj8lKN2Zn
         dMnA==
X-Gm-Message-State: AOAM531M2yFKqmvqKmA147eth7VylNoymW4pLD4038jkFlI6qi70G2Bu
        xEJkvsG1hW/4035MUTneUQ==
X-Google-Smtp-Source: ABdhPJyt6EAx6ms2TgwhAmHferJKtGDUssDln1uxGGEcAReE4RxZo6WxwJ5mhvyQn7pkyGrkHd3kuw==
X-Received: by 2002:a05:6830:4124:: with SMTP id w36mr15592836ott.72.1631634636081;
        Tue, 14 Sep 2021 08:50:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a13sm2726549oos.4.2021.09.14.08.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:50:35 -0700 (PDT)
Received: (nullmailer pid 3462681 invoked by uid 1000);
        Tue, 14 Sep 2021 15:50:33 -0000
Date:   Tue, 14 Sep 2021 10:50:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, devicetree@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [v3 06/10] dt-binding: pmu: Add RISC-V PMU DT bindings
Message-ID: <YUDEyYQvjCo83h5B@robh.at.kernel.org>
References: <20210910192757.2309100-1-atish.patra@wdc.com>
 <20210910192757.2309100-7-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910192757.2309100-7-atish.patra@wdc.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 10, 2021 at 12:27:53PM -0700, Atish Patra wrote:
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
> +
> +    description:
> +      Should be "riscv,pmu".

The schema already says this.

Just 'pmu' isn't very specific. No version to attach here?

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

Besides 'optional' not being the in vocabulary, 'compatible' is never 
optional.

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
> 
> 
