Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8766C00140
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Aug 2022 14:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiHJO4f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Aug 2022 10:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHJO4e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Aug 2022 10:56:34 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CFE71BDD
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 07:56:32 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id q6-20020a05683033c600b0061d2f64df5dso10738226ott.13
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=4GbuXOlEIgZIiC7PpH0qrTBvd6QWDbyQ6vaZF7sexsQ=;
        b=hpXMEiNGklbVRkf+MRDxP1TGRgsEj2HpVJl7lSOTiu5nLpaY3SgmVkl9sp1jaMWoF3
         r/78PwQ29VbqGeYpQhm7qHm3rFAVyE2YBOjIoKbcci+RkifRfmhEzWwWwk7arStT3Ph6
         fKTjBP4IN14bwCT+nvGoXM96gc5DLLAwwc+8MJ8cDpKPEgTrK10JNBsP+zzggPMwaiEd
         UbFt/ncJ1Uw8qnD8UrLJt4rKdyIVOL/25JeEz3ecfqQC4+7cGdOmuOIkUqnvILVFqXUl
         d3BBmWsyQ0AUAdyNQjclLKUzvffKAH05wwOlDU11yDfeIUz7OHYYbzMwW8F0zp/Y2BSK
         peIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=4GbuXOlEIgZIiC7PpH0qrTBvd6QWDbyQ6vaZF7sexsQ=;
        b=pzyIpDGLv9mgUB8IMamSJgfJOz6Ksoraqe1Ao8J0nO7WhX6DJMz9aUpWWBuIkn6K5/
         R2M1aKTQb9WrxsE366rcxGDjaU2K4vDvfT7jNnwIJJERn+Bfr25hPQMIBToriW9yHyqT
         ZAzD7U7m2Yq3Hb44eXfWjTi70LEXvcFB2WJzpLCBJyUUg8mhy53/lr2r5voLc8BQbJTa
         wHyHMalC7uAd0VGAvNG0dvsPDlaDtmdGVnrzL9Fzz+kY9/5oU362k5F82w+VkJvYA+vJ
         ll5Kow10jJj/52zbEJFJ+x4bnDFZNdIt1xkM2NBiwkRr8gkhf0PX1Pu1hUmFGWKGX1ru
         K1Tw==
X-Gm-Message-State: ACgBeo0qFseIvpd8cD4pWvZwRIqtYXeftKqIsDDd2Hn6grLF8WcMsWGS
        jFSOiY5CrBMS03uYPzYE2S1NTg==
X-Google-Smtp-Source: AA6agR4kZA4f01vweDzQnP9WztY2lHtLUggSPAycilMEg7RDztr4QxjSTsBBN+f5IFbU6igWGaNvZg==
X-Received: by 2002:a05:6830:3707:b0:636:913f:2313 with SMTP id bl7-20020a056830370700b00636913f2313mr10119497otb.290.1660143392087;
        Wed, 10 Aug 2022 07:56:32 -0700 (PDT)
Received: from [192.168.1.5] ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id z4-20020a0568301da400b00636df823125sm716106oti.26.2022.08.10.07.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:56:31 -0700 (PDT)
Message-ID: <18c8e9c74955c08fdbd631a35c51b30f3cff3cd3.camel@ventanamicro.com>
Subject: Re: [PATCH v5] perf arch events: riscv sbi firmware std event files
From:   Mayuresh Chitale <mchitale@ventanamicro.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux@yadro.com, Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?ISO-8859-1?Q?Jo=E3o_M=E1rio?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Kautuk Consul <kconsul@ventanamicro.com>
Date:   Wed, 10 Aug 2022 20:26:18 +0530
In-Reply-To: <20220628114625.166665-4-nikita.shubin@maquefel.me>
References: <20220628114625.166665-1-nikita.shubin@maquefel.me>
         <20220628114625.166665-4-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 2022-06-28 at 14:45 +0300, Nikita Shubin wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
> 
> Firmware events are defined by "RISC-V Supervisor Binary Interface
> Specification", which means they should be always available as long
> as
> firmware supports >= 0.3.0 SBI.
> 
> Expose them to arch std events, so they can be reused by particular
> PMU bindings.
> 
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> ---
> v4->v5:
> - changed EventCode to ConfigCode, as 63 bit exceeds event code
> format
> ---
>  .../arch/riscv/riscv-sbi-firmware.json        | 134
> ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-sbi-
> firmware.json
> 
> diff --git a/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json 
> b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
> new file mode 100644
> index 000000000000..b9d305f1ada8
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
> @@ -0,0 +1,134 @@
> +[
> +  {
> +    "PublicDescription": "Misaligned load trap",
> +    "ConfigCode": "0x8000000000000000",
> +    "EventName": "FW_MISALIGNED_LOAD",
> +    "BriefDescription": "Misaligned load trap event"
> +  },
> +  {
> +    "PublicDescription": "Misaligned store trap",
> +    "ConfigCode": "0x8000000000000001",
> +    "EventName": "FW_MISALIGNED_STORE",
> +    "BriefDescription": "Misaligned store trap event"
> +  },
> +  {
> +    "PublicDescription": "Load access trap",
> +    "ConfigCode": "0x8000000000000002",
> +    "EventName": "FW_ACCESS_LOAD",
> +    "BriefDescription": "Load access trap event"
> +  },
> +  {
> +    "PublicDescription": "Store access trap",
> +    "ConfigCode": "0x8000000000000003",
> +    "EventName": "FW_ACCESS_STORE",
> +    "BriefDescription": "Store access trap event"
> +  },
> +  {
> +    "PublicDescription": "Illegal instruction trap",
> +    "ConfigCode": "0x8000000000000004",
> +    "EventName": "FW_ILLEGAL_INSN",
> +    "BriefDescription": "Illegal instruction trap event"
> +  },
> +  {
> +    "PublicDescription": "Set timer event",
> +    "ConfigCode": "0x8000000000000005",
> +    "EventName": "FW_SET_TIMER",
> +    "BriefDescription": "Set timer event"
> +  },
> +  {
> +    "PublicDescription": "Sent IPI to other HART event",
> +    "ConfigCode": "0x8000000000000006",
> +    "EventName": "FW_IPI_SENT",
> +    "BriefDescription": "Sent IPI to other HART event"
> +  },
> +  {
> +    "PublicDescription": "Received IPI from other HART event",
> +    "ConfigCode": "0x8000000000000007",
> +    "EventName": "FW_IPI_RECEIVED",
> +    "BriefDescription": "Received IPI from other HART event"
> +  },
> +  {
> +    "PublicDescription": "Sent FENCE.I request to other HART event",
> +    "ConfigCode": "0x8000000000000008",
> +    "EventName": "FW_FENCE_I_SENT",
> +    "BriefDescription": "Sent FENCE.I request to other HART event"
> +  },
> +  {
> +    "PublicDescription": "Received FENCE.I request from other HART
> event",
> +    "ConfigCode": "0x8000000000000009",
> +    "EventName": "FW_FENCE_I_RECEIVED",
> +    "BriefDescription": "Received FENCE.I request from other HART
> event"
> +  },
> +  {
> +    "PublicDescription": "Sent SFENCE.VMA request to other HART
> event",
> +    "ConfigCode": "0x80000000000000a",
> +    "EventName": "FW_SFENCE_VMA_SENT",
> +    "BriefDescription": "Sent SFENCE.VMA request to other HART
> event"
> +  },
> +  {
> +    "PublicDescription": "Received SFENCE.VMA request from other
> HART event",
> +    "ConfigCode": "0x800000000000000b",
> +    "EventName": "FW_SFENCE_VMA_RECEIVED",
> +    "BriefDescription": "Received SFENCE.VMA request from other HART
> event"
> +  },
> +  {
> +    "PublicDescription": "Sent SFENCE.VMA with ASID request to other
> HART event",
> +    "ConfigCode": "0x800000000000000c",
> +    "EventName": "FW_SFENCE_VMA_RECEIVED",
> +    "BriefDescription": "Sent SFENCE.VMA with ASID request to other
> HART event"
> +  },
> +  {
> +    "PublicDescription": "Received SFENCE.VMA with ASID request from
> other HART event",
> +    "ConfigCode": "0x800000000000000d",
> +    "EventName": "FW_SFENCE_VMA_ASID_RECEIVED",
> +    "BriefDescription": "Received SFENCE.VMA with ASID request from
> other HART event"
> +  },
> +  {
> +    "PublicDescription": "Sent HFENCE.GVMA request to other HART
> event",
> +    "ConfigCode": "0x800000000000000e",
> +    "EventName": "FW_HFENCE_GVMA_SENT",
> +    "BriefDescription": "Sent HFENCE.GVMA request to other HART
> event"
> +  },
> +  {
> +    "PublicDescription": "Received HFENCE.GVMA request from other
> HART event",
> +    "ConfigCode": "0x800000000000000f",
> +    "EventName": "FW_HFENCE_GVMA_RECEIVED",
> +    "BriefDescription": "Received HFENCE.GVMA request from other
> HART event"
> +  },
> +  {
> +    "PublicDescription": "Sent HFENCE.GVMA with VMID request to
> other HART event",
> +    "ConfigCode": "0x8000000000000010",
> +    "EventName": "FW_HFENCE_GVMA_VMID_SENT",
> +    "BriefDescription": "Sent HFENCE.GVMA with VMID request to other
> HART event"
> +  },
> +  {
> +    "PublicDescription": "Received HFENCE.GVMA with VMID request
> from other HART event",
> +    "ConfigCode": "0x8000000000000011",
> +    "EventName": "FW_HFENCE_GVMA_VMID_RECEIVED",
> +    "BriefDescription": "Received HFENCE.GVMA with VMID request from
> other HART event"
> +  },
> +  {
> +    "PublicDescription": "Sent HFENCE.VVMA request to other HART
> event",
> +    "ConfigCode": "0x8000000000000012",
> +    "EventName": "FW_HFENCE_VVMA_SENT",
> +    "BriefDescription": "Sent HFENCE.VVMA request to other HART
> event"
> +  },
> +  {
> +    "PublicDescription": "Received HFENCE.VVMA request from other
> HART event",
> +    "ConfigCode": "0x8000000000000013",
> +    "EventName": "FW_HFENCE_VVMA_RECEIVED",
> +    "BriefDescription": "Received HFENCE.VVMA request from other
> HART event"
> +  },
> +  {
> +    "PublicDescription": "Sent HFENCE.VVMA with ASID request to
> other HART event",
> +    "ConfigCode": "0x8000000000000014",
> +    "EventName": "FW_HFENCE_VVMA_ASID_SENT",
> +    "BriefDescription": "Sent HFENCE.VVMA with ASID request to other
> HART event"
> +  },
> +  {
> +    "PublicDescription": "Received HFENCE.VVMA with ASID request
> from other HART event",
> +    "ConfigCode": "0x8000000000000015",
> +    "EventName": "FW_HFENCE_VVMA_ASID_RECEIVED",
> +    "BriefDescription": "Received HFENCE.VVMA with ASID request from
> other HART event"
> +  }
> +]

When testing with perf using firmware events we saw this error: 
WARNING: event 'N/A' not valid (bits 59 of config '80000000000000a' not
supported by kernel)!

It looks it is due to a typo and applying the below patch resolved the
issue for us.

Tested-by: Kautuk Consul <kconsul@ventanamicro.com>

diff --git a/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
index b9d305f1ada8..a9939823b14b 100644
--- a/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
@@ -61,7 +61,7 @@
   },
   {
     "PublicDescription": "Sent SFENCE.VMA request to other HART
event",
-    "ConfigCode": "0x80000000000000a",
+    "ConfigCode": "0x800000000000000a",
     "EventName": "FW_SFENCE_VMA_SENT",
     "BriefDescription": "Sent SFENCE.VMA request to other HART event"
   },



