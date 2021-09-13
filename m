Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCA7C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Sep 2021 12:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0967260F58
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Sep 2021 12:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbhIMMUC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 08:20:02 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:46758 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhIMMUB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Sep 2021 08:20:01 -0400
Received: by mail-ot1-f43.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso12952734otr.13;
        Mon, 13 Sep 2021 05:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=yAANwLMWDLEO6I7ZRYD4RFaA1eZZfYg/uLblDuOz8Iw=;
        b=8OUPKotk8mlwlgzQ1SzI5dyOsPrCpUtirWXrHRJvIdOQdClNSe+2sWKeQ1S+mdZSHd
         s3lmiwBMJF7SoYflkd9X7C/7vuXWS/uKzmXro3WnQnCXZn6pdnfEWm/RwZaB8EvUffAZ
         1tF8BE5BeYD0zyX07AL/WK5YOn9VaunrN35JsjhguwKfou2a1zwfUiXXUx6DJeTSBlIu
         GmapSAJe4DTm2oNvVFYUxL6nGfxz1I88CztJLl3ICNJO69S2EB6+37jNHb8eHC4RMUeT
         gIQfC8aff/JvJGEcV/IIFdcqaY162Rr1AjNRCigFIXcw4c62fF8JTYohP6+V1US8IIHo
         /u6Q==
X-Gm-Message-State: AOAM533+MjEujcVSQv0Mph0znagcMuVUwRh0J4zZGgU1lTLBwLN8eivY
        XtMePgUtQ6MZ3UWksxszCA==
X-Google-Smtp-Source: ABdhPJzYnMEYkbxkurS4PpZO/QSrg41SFbZti1sBP50QH1OMY0W6b4aKzKiENjcLtUjXkbrnVoCMkg==
X-Received: by 2002:a9d:36d:: with SMTP id 100mr9346988otv.237.1631535525388;
        Mon, 13 Sep 2021 05:18:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h3sm1800959otu.7.2021.09.13.05.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 05:18:44 -0700 (PDT)
Received: (nullmailer pid 444714 invoked by uid 1000);
        Mon, 13 Sep 2021 12:18:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup.patel@wdc.com>, linux-doc@vger.kernel.org,
        Vincent Chen <vincent.chen@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>
In-Reply-To: <20210910192757.2309100-7-atish.patra@wdc.com>
References: <20210910192757.2309100-1-atish.patra@wdc.com> <20210910192757.2309100-7-atish.patra@wdc.com>
Subject: Re: [v3 06/10] dt-binding: pmu: Add RISC-V PMU DT bindings
Date:   Mon, 13 Sep 2021 07:18:43 -0500
Message-Id: <1631535523.169353.444713.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 10 Sep 2021 12:27:53 -0700, Atish Patra wrote:
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

See https://patchwork.ozlabs.org/patch/1526606

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

