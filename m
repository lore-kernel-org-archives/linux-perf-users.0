Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922D8C61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 15:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCMPUk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 11:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCMPUj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 11:20:39 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760F9664F2
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 08:20:38 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e194so12247957ybf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678720837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg/mpqiGdKgql/ouc23r5Z8gp8NHynkHtJy9u7d3hI8=;
        b=ZgclPJKxiIMOfozzAfXPChLBUKjaLXpRpRsHMb4Lw/5D+AYyjqHwp8G9n2kKb9opyX
         C3uBw1HRvyxzQ50Ndeppk/VPnIJvH1spRF3QA9Y2KOxSd80DsHUvLUADTmjxvkoIYIfM
         2UgrAOrm+le8yiF3xUvh6ppnj9Lqhx88GbBaxEAyfXkbfbdVQ3pc5JpFeVXUwY6qPGSV
         aACsv6K9Vms2pRx64xOzjjnp0NtJ8GCORb29kIAoyV0Xiuf65ezessK2F/yx7N7+O6EP
         2SOxnCwC2JufkOKFfLjsUAieeLGW0zJYQJ/0t8SOzx1h1BWWWvojgkO+tzRNga2a78/Z
         b/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678720837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hg/mpqiGdKgql/ouc23r5Z8gp8NHynkHtJy9u7d3hI8=;
        b=apH2HrosSv8FKQQfPJcKFpgNtmv9UKH06SpVak6FzNvnfiY3h3t7qCgeAuHEnX+jgZ
         VDswh99z3r/0CstDY+JGrxM8liAtqscL1uIy07NVRmSe5R3GWNZdwYMa0DHe3D+k/Z5d
         unv1w5lfK9gsftZg2JLVcOsveUhJHlme+iktLJMWeEi1GJcHVUcpK1h2GvXSkMCs9liC
         Wwzap9SQ3TzYPujuIELK0S9KjPII9oJzll8C+G6RA3beAdhTeNHFlH4M1nGOsFSUtxGt
         d79PnAaxbqe4UE1suOG4O5V/p9JsXgw75xGU//qdMiyDiWYE9nVAN7HRDJx4etg9f+SZ
         qjXA==
X-Gm-Message-State: AO0yUKXKkY+H6CEsnDHov36ZIciwRdVBIQWJZfP0FJYtf/46eYvg6hbi
        eX7HMNbT239mJF/IgCa+msaQs0X2TUhhat3lTIwoPg==
X-Google-Smtp-Source: AK7set9rwKnvGypNlqyjM9tokE1R7KsL7qPKchoDxgZaXyFBQSnUCbyj7hbrrAWEy5KQd/ac/AgTe+W5E9gm/fSgATo=
X-Received: by 2002:a5b:7:0:b0:a06:55b5:3cdf with SMTP id a7-20020a5b0007000000b00a0655b53cdfmr17165325ybp.3.1678720837421;
 Mon, 13 Mar 2023 08:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230308125326.2195613-1-tmricht@linux.ibm.com>
In-Reply-To: <20230308125326.2195613-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 08:20:25 -0700
Message-ID: <CAP-5=fXzeAJqRjtEqsWS26K-+qh3gsDJ+nKOEY7riqedTb-WQQ@mail.gmail.com>
Subject: Re: [PATCH] perf list: Add PMU pai_ext event description for IBM z16
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Mar 8, 2023 at 4:54=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> Add the event description for the IBM z16 pai_ext PMU released with
> commit c432fefe8e62 ("s390/pai: Add support for PAI Extension 1 NNPA coun=
ters")
>
> The document SA22-7832-13 "z/Architecture Principles of Operation",
> published May, 2022, contains the description of the
> Processor Activity Instrumentation Facility and the NNPA counter
> set., See Pages 5-113 to 5-116 and chapter 26 for details.
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../pmu-events/arch/s390/cf_z16/pai_ext.json  | 178 ++++++++++++++++++
>  tools/perf/pmu-events/jevents.py              |   1 +
>  2 files changed, 179 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json b/tools/=
perf/pmu-events/arch/s390/cf_z16/pai_ext.json
> new file mode 100644
> index 000000000000..7ccbded95dc9
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
> @@ -0,0 +1,178 @@
> +[
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6144",
> +               "EventName": "NNPA_ALL",
> +               "BriefDescription": "NNPA ALL Sum of all non zero counter=
s",
> +               "PublicDescription": "Sum of all non zero NNPA (Neural Ne=
tworks Processing Assist) counters"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6145",
> +               "EventName": "NNPA_ADD",
> +               "BriefDescription": "NNPA ADD function ending with CC=3D0=
"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6146",
> +               "EventName": "NNPA_SUB",
> +               "BriefDescription": "NNPA SUB function ending with CC=3D0=
"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6147",
> +               "EventName": "NNPA_MUL",
> +               "BriefDescription": "NNPA MUL function ending with CC=3D0=
"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6148",
> +               "EventName": "NNPA_DIV",
> +               "BriefDescription": "NNPA DIV function ending with CC=3D0=
"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6149",
> +               "EventName": "NNPA_MIN",
> +               "BriefDescription": "NNPA MIN function ending with CC=3D0=
"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6150",
> +               "EventName": "NNPA_MAX",
> +               "BriefDescription": "NNPA MAX function ending with CC=3D0=
"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6151",
> +               "EventName": "NNPA_LOG",
> +               "BriefDescription": "NNPA LOG function ending with CC=3D0=
"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6152",
> +               "EventName": "NNPA_EXP",
> +               "BriefDescription": "NNPA EXP function ending with CC=3D0=
"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6153",
> +               "EventName": "NNPA_IBM_RESERVED_9",
> +               "BriefDescription": "Reserved for IBM use",
> +               "PublicDescription": "Reserved for IBM use"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6154",
> +               "EventName": "NNPA_RELU",
> +               "BriefDescription": "NNPA RELU function ending with CC=3D=
0"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6155",
> +               "EventName": "NNPA_TANH",
> +               "BriefDescription": "NNPA TANH function ending with CC=3D=
0"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6156",
> +               "EventName": "NNPA_SIGMOID",
> +               "BriefDescription": "NNPA SIGMOID function ending with CC=
=3D0"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6157",
> +               "EventName": "NNPA_SOFTMAX",
> +               "BriefDescription": "NNPA SOFTMAX function ending with CC=
=3D0"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6158",
> +               "EventName": "NNPA_BATCHNORM",
> +               "BriefDescription": "NNPA BATCHNORM function ending with =
CC=3D0"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6159",
> +               "EventName": "NNPA_MAXPOOL2D",
> +               "BriefDescription": "NNPA MAXPOOL2D function ending with =
CC=3D0"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6160",
> +               "EventName": "NNPA_AVGPOOL2D",
> +               "BriefDescription": "NNPA AVGPOOL2D function ending with =
CC=3D0"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6161",
> +               "EventName": "NNPA_LSTMACT",
> +               "BriefDescription": "NNPA LSTMACT function ending with CC=
=3D0"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6162",
> +               "EventName": "NNPA_GRUACT",
> +               "BriefDescription": "NNPA GRUACT function ending with CC=
=3D0"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6163",
> +               "EventName": "NNPA_CONVOLUTION",
> +               "BriefDescription": "NNPA CONVOLUTION function ending wit=
h CC=3D0"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6164",
> +               "EventName": "NNPA_MATMUL_OP",
> +               "BriefDescription": "NNPA MATMUL OP function ending with =
CC=3D0"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6165",
> +               "EventName": "NNPA_MATMUL_OP_BCAST23",
> +               "BriefDescription": "NNPA NNPA MATMUL OP BCAST23 function=
 ending with CC=3D0"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6166",
> +               "EventName": "NNPA_SMALLBATCH",
> +               "BriefDescription": "NNPA SMALLBATCH OP function ending w=
ith CC=3D0",
> +               "PublicDescription": "NNPA function with conditions as de=
scribed in Common Operation"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6167",
> +               "EventName": "NNPA_LARGEDIM",
> +               "BriefDescription": "NNPA LARGEDIM OP function ending wit=
h CC=3D0",
> +               "PublicDescription": "NNPA function with conditions as de=
scribed in Common Operation"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6168",
> +               "EventName": "NNPA_SMALLTENSOR",
> +               "BriefDescription": "NNPA SMALLTENSOR OP function ending =
with CC=3D0",
> +               "PublicDescription": "NNPA function with conditions as de=
scribed in Common Operation"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6169",
> +               "EventName": "NNPA_1MFRAME",
> +               "BriefDescription": "NNPA 1MFRAME OP function ending with=
 CC=3D0",
> +               "PublicDescription": "NNPA function with conditions as de=
scribed in Common Operation"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6170",
> +               "EventName": "NNPA_2GFRAME",
> +               "BriefDescription": "NNPA 2GFRAME OP function ending with=
 CC=3D0",
> +               "PublicDescription": "NNPA function with conditions as de=
scribed in Common Operation"
> +       },
> +       {
> +               "Unit": "PAI-EXT",
> +               "EventCode": "6171",
> +               "EventName": "NNPA_ACCESSEXCEPT",
> +               "BriefDescription": "NNPA ACCESSEXCEPT OP function ending=
 with CC=3D0",
> +               "PublicDescription": "NNPA function with conditions as de=
scribed in Common Operation"
> +       }
> +]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 2bcd07ce609f..b20d06fcc358 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -246,6 +246,7 @@ class JsonEvent:
>            'CPU-M-CF': 'cpum_cf',
>            'CPU-M-SF': 'cpum_sf',
>            'PAI-CRYPTO' : 'pai_crypto',
> +          'PAI-EXT' : 'pai_ext',
>            'UPI LL': 'uncore_upi',
>            'hisi_sicl,cpa': 'hisi_sicl,cpa',
>            'hisi_sccl,ddrc': 'hisi_sccl,ddrc',
> --
> 2.39.1
>
