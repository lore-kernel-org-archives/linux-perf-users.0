Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD016C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 18:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BC16103C
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 18:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbhJZSF7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Oct 2021 14:05:59 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:34325 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhJZSF4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Oct 2021 14:05:56 -0400
Received: by mail-oo1-f53.google.com with SMTP id e200-20020a4a55d1000000b002b8bedf08cdso20111oob.1;
        Tue, 26 Oct 2021 11:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=MYaZzPsql9ylVu0bAh9A9jNKkz/9F195FCssTtA7QOA=;
        b=JUfXGx3EViPKkTdGgMQ3vPDtoa3DGa7nvXdiGoYkSOhw0apf6LLE/Xi4RODT91w9PZ
         LFkrzq/8zYMM/6FD2sOdYJFW6erD8HTaa6dZJ8BXkVzBqIsEMvO6Ci1cIZHgyXAWJKtr
         ekKvZ4ZgBArkYs01q54yRcET3jmRvDZPbzwjy8kP/WEpCVlydLKnEoFQXr4Z8UQuJVty
         puacuzAlHmQT0WDfubdmcteafLyGhGy3Ld28DQ5dRS3ox+Gl4UaNFTHC77f2l0irzuI5
         CZCpr1a506SuvbbMUZgHwQ6tzCcKdGqSSLSHiCyrd3mFbokBR6qegCirt/IKYr7LU4Cf
         Nq7g==
X-Gm-Message-State: AOAM533JL8CzJhnHW6EI49WElouhjzMm/I2ng/Dc3GkQ1E3nYo9sQFvH
        CzD5J9DSegrnxqwMeXIMbQ==
X-Google-Smtp-Source: ABdhPJxjWOBTKuVo96eUaTsi5lRNizXIavvqz64LU5NRPwTjcl0iUd+GSv9jSGpt9Yt4n83bnz5g1Q==
X-Received: by 2002:a4a:b109:: with SMTP id a9mr18430444ooo.73.1635271411807;
        Tue, 26 Oct 2021 11:03:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a13sm4761104oiy.9.2021.10.26.11.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:03:31 -0700 (PDT)
Received: (nullmailer pid 2939410 invoked by uid 1000);
        Tue, 26 Oct 2021 18:03:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-kernel@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-doc@vger.kernel.org, Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
        Vincent Chen <vincent.chen@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
In-Reply-To: <20211025195350.242914-7-atish.patra@wdc.com>
References: <20211025195350.242914-1-atish.patra@wdc.com> <20211025195350.242914-7-atish.patra@wdc.com>
Subject: Re: [v4 06/11] dt-binding: pmu: Add RISC-V PMU DT bindings
Date:   Tue, 26 Oct 2021 13:03:29 -0500
Message-Id: <1635271409.185787.2939409.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 25 Oct 2021 12:53:45 -0700, Atish Patra wrote:
> This patch adds the DT bindings for RISC-V PMU driver. It also defines
> the interrupt related properties to allow counter overflow interrupt.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  .../devicetree/bindings/perf/riscv,pmu.yaml   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/perf/riscv,pmu.yaml: 'optional' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'patternProperties', 'properties', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
./Documentation/devicetree/bindings/perf/riscv,pmu.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/perf/riscv,pmu.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/perf/riscv,pmu.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/perf/riscv,pmu.yaml
Documentation/devicetree/bindings/perf/riscv,pmu.example.dt.yaml:0:0: /example-0/pmu: failed to match any schema with compatible: ['riscv,pmu']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1545970

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

