Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA76C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 18:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841BC61002
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 18:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbhJZTAM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Oct 2021 15:00:12 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39436 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhJZTAL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Oct 2021 15:00:11 -0400
Received: by mail-ot1-f45.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so57018ote.6;
        Tue, 26 Oct 2021 11:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yXb5tcc4h5n8tVs/+ZyUdUiPi8sa74ADcNZ1YwYZr1s=;
        b=A/qSHwluftK0AAMBAeo4Janw8W+YWllhlyoh8yrbBG5GHPwX6pWd4cgWsy5/ND7FAo
         SBfm9IGo0SEDAf6lZZghSvuk0eIR1/NjrgUYyqWCOttOmvps3JMYyMs6dli57QXVd/br
         CVkoWvEDJ7OhGV83QmjmpUO2N9FOXqIsCs9ghoev865OWeAOJY37ERSoKVIKNaTLS12E
         coJTfWdxIb8tVgFetDK9N8e4612gbZn/lYMf/DmnAu8XhL4z3pcnXwTWSEZCRgTSN4k9
         UKjcDZlCHewhrlfECPl/O23zFxZ5lXKL86EAkb1Vbh+DzHe6B1InakJ75o/dRZGJw80A
         Htnw==
X-Gm-Message-State: AOAM533F+mcZdjpZnUG4ajl1Ba0QItufX/HeFyAiyvB5FjQGt+0N65CB
        ZqZpt9Z161mk7nq6loxKSw==
X-Google-Smtp-Source: ABdhPJwEJfXe5iZi4Vv8sIh0PxJX00V4HchBP4pLf1W0FS/HoJN7GA+G5Fl71yFEWjMyw/vG8nFccQ==
X-Received: by 2002:a9d:57c9:: with SMTP id q9mr2845956oti.281.1635274667337;
        Tue, 26 Oct 2021 11:57:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k26sm596627otp.42.2021.10.26.11.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:57:46 -0700 (PDT)
Received: (nullmailer pid 3030040 invoked by uid 1000);
        Tue, 26 Oct 2021 18:57:45 -0000
Date:   Tue, 26 Oct 2021 13:57:45 -0500
From:   Rob Herring <robh@kernel.org>
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
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [v4 06/11] dt-binding: pmu: Add RISC-V PMU DT bindings
Message-ID: <YXhPqfpXh1VZN07T@robh.at.kernel.org>
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

Only 1 version? Every implementation detail is discoverable in other 
ways?

> +
> +    description:
> +      Should be "riscv,pmu".

Don't write free form text of what the schema says.

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

No a json-schema keyword.

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
> 
> 
