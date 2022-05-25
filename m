Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79B2C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 May 2022 12:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiEYM63 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 May 2022 08:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiEYM62 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 May 2022 08:58:28 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7828EA0051
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 05:58:27 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id q1so7294506uao.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 May 2022 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlfGy88ZCD4lOyKadsaMaTpiuM8NkVCXt/blXBLLSuM=;
        b=WHFRS+3QBk6oxN3FURojB0WbB+U5Yk4Tva5DSe1TmlglfwC6xSB79PK/twKoeeqJ1Y
         gQflcIaHygkWIFezpZLWDfiOFK22NGlWiFbkUz+Yj9mUz4IxO5AgavlQVUh0kzFDtPAK
         a+B3yfQtzc9NgH4DISF44l9SiUYBu3GDdx9ixgMeH5sxMf8Yvs+zgemvkbfX2vO6ONo0
         r+YOZWI+r7OSj8wrgAO+9rps8TxuTpl3N6RfXJGU/gnwbeyBYfnPaB5nXonXH+0eXJS9
         D5Hdo1CY2iAnRhw5CeM976/rMLav8uhQr3sPxmOyPXwcb6ZJDQ9mbfgXWWb9SebA8+Lx
         HtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlfGy88ZCD4lOyKadsaMaTpiuM8NkVCXt/blXBLLSuM=;
        b=A8aAaYHN1rSZq3aKAuiKifjQOmncMfDCpqHnEfN+LA8gRAaRUHboJh9NaCCknj7vN5
         CbyEj/X8JZrxlosAlTBn7HA3NiFG6DZ4XabRyifFVWAA+H8X+3hhB7E/n4tr6vU1kFci
         GRS2Yl8LRvU9o5tRqdC7HqKzZ9prBdOwNgXdGFc9usePPGVlnb2A8QuQyQtMqNLuiUKB
         H/Tm63K5qGFHN+WdPhmRUEUlpBq08hwXYJHU8fTtmr39nTSER30MJVwjvwWXHKodzk0E
         CDiQO2FbuR021ztBPM68HKSPmxY0TaNG5Bx3RiqBsebVv0Hsfj3C0Xq94a/PGJZhUknx
         ehiQ==
X-Gm-Message-State: AOAM530aqj/NGcjuCFQSAfVJoFG6ZQ+UVxYdEZWFzYMnww7bGszWJxQ/
        +DLH8NOhwPNIdM25YXFqSMFtaLw2FoCuIknSE13U5Q==
X-Google-Smtp-Source: ABdhPJzfhaqn9oVCwhK40BxeJIQuF35mF5wePsIFZ0TXRA5Q0PqzCtwusZwnQpv5NWrM7h8rgrwcPPg78uDjv8XYTps=
X-Received: by 2002:ab0:310b:0:b0:368:c7b0:5a6c with SMTP id
 e11-20020ab0310b000000b00368c7b05a6cmr10054921ual.108.1653483506483; Wed, 25
 May 2022 05:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220525093938.4101-1-ravi.bangoria@amd.com> <20220525093938.4101-5-ravi.bangoria@amd.com>
In-Reply-To: <20220525093938.4101-5-ravi.bangoria@amd.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 25 May 2022 15:58:15 +0300
Message-ID: <CABPqkBQ-4vpG_d-u-Q-pTQ_wDg_HhqNNC3dSLFE6MS5Bp3qTDw@mail.gmail.com>
Subject: Re: [PATCH 04/13] perf/x86/amd: Support PERF_SAMPLE_WEIGHT using IBS OP_DATA3[IbsDcMissLat]
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, jmario@redhat.com,
        leo.yan@linaro.org, alisaidi@amazon.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 25, 2022 at 12:42 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> IBS Op data3 provides data cache miss latency which can be passed as
> sample->weight along with perf_mem_data_src. Note that sample->weight
> will be populated only when PERF_SAMPLE_DATA_SRC is also set, although
> both sample types are independent.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 6626caeed6a1..5a6e278713f4 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -738,6 +738,12 @@ static void perf_ibs_get_mem_lvl(struct perf_event *event, u64 op_data2,
>                 return;
>         }
>
> +       /* Load latency (Data cache miss latency) */
> +       if (data_src->mem_op == PERF_MEM_OP_LOAD &&
> +           event->attr.sample_type & PERF_SAMPLE_WEIGHT) {
> +               data->weight.full = (op_data3 & IBS_DC_MISS_LAT_MASK) >> IBS_DC_MISS_LAT_SHIFT;
> +       }
> +
I think here you also need to handle the WEIGHT_STRUCT case and put
the cache miss latency in the right
field. This IBS field covers the cache line movement and not the whole
instruction latency which is the tag to ret field.
In the case of WEIGHT_STRUCT you need to fill out the two fields.

>         /* L2 Hit */
>         if ((op_data3 & IBS_L2_MISS_MASK) == 0) {
>                 /* Erratum #1293 */
> --
> 2.31.1
>
