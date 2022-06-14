Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F134C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Jun 2022 14:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiFNOjL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 10:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347945AbiFNOjK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 10:39:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1DB3CFCE
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 07:39:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h5so11639472wrb.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5SSmOpxaieAxhBhqLWRq50g/jaHGZ+k1H6+ZODiYts=;
        b=LhfEscu4SL/74tSj97prUIfgT825d4K7enMooSY9LuVRkpG/9fKkilfDhaXyGaRK+X
         6WjpPY20DgafAmrFzGmZnHZzPgqJr20pxhwzByrKfmX9Y8RJs+nxCVpFIapqDO7m771z
         Rsa3ALsO9dINWlsHpfnd9yuqMLd1ZebR6EnOkn7g4CN5Set3VhlUJsGajH2xi8RG0ypt
         XlDWGze1rayefwh/p4q1wsorWjrIm1AhI+aQ/WCmP+mnv3W3cGC9SrjCDVG6m+5ySmVm
         ISYCLkP1w4Nza0VGGbpFYZOsxZBEDg7Rq0SfWMT86p8sNPg6b0hYdAlfOWmsPQOe5jGN
         RsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5SSmOpxaieAxhBhqLWRq50g/jaHGZ+k1H6+ZODiYts=;
        b=pslA1exdLra3hrv5mny49fHh7WRHFGmf73clCJxafTTmFWBt6SsjQpVcx81fYrN1Pd
         wrQ7DSt61clZ3JEADsceHjuUvh2o/ophmyN52rfXDadZMJQOiXGq2sFD0uZLNBiCmU3m
         tzwXOfZSQw+YhqXJpP92ASqeGTCZIBqlVsrcOsb7xkgsrWjPnw/5aJn1fgjz8B2kYWlq
         +p02zaSuWh8OIANO24+CnxdiqkPKA1tcZ72Z3mzglhRamRNxv60Mp0JTaV6gfYNP9D7Z
         nxBjCw9cbrj/Pnumr/XCD9gCaIYJCZ0raqp1+mxDFrQOquruRyfQPmEwAufctOrf2lNU
         V1gw==
X-Gm-Message-State: AJIora/qr5zUsiXLLeOamScnknTiEyM8nOouhV4ZSlRJqgsIE6duteXP
        L1bAe6LOm8frJTOWYtfs/e0tt8CJolRvPljEYNy3XFZAj34=
X-Google-Smtp-Source: AGRyM1s7gwiJFhXq3CTNcQ+tU3H7yju67V8T7j+VRz7Qx3Yg4u1r1anNz4VqC0dMSQxjIrAWVcrJ0JBnWeZG2x80nHU=
X-Received: by 2002:a05:6000:1a8d:b0:219:e3f2:c092 with SMTP id
 f13-20020a0560001a8d00b00219e3f2c092mr5456547wry.375.1655217547516; Tue, 14
 Jun 2022 07:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220610135939.63361-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20220610135939.63361-1-atrajeev@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jun 2022 07:38:55 -0700
Message-ID: <CAP-5=fV6sPUtSqPBmJ0dmeUK+wuuXgyq-GQRV_g_B5uC4y5oGA@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/tests: Fix session topology test comparison check
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, disgoel@linux.vnet.ibm.com,
        mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 10, 2022 at 7:00 AM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> commit cfd7092c31ae ("perf test session topology: Fix test to
> skip the test in guest environment") added check to skip the
> testcase if the socket_id can't be fetched from topology info.
> But the condition check uses strncmp which should be changed to
> !strncmp and to correctly match platform. Patch fixes this
> condition check.
>
> Fixes: cfd7092c31ae ("perf test session topology: Fix test to skip the test in guest environment")
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index d23a9e322ff5..0b4f61b6cc6b 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -115,7 +115,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>          * physical_package_id will be set to -1. Hence skip this
>          * test if physical_package_id returns -1 for cpu from perf_cpu_map.
>          */
> -       if (strncmp(session->header.env.arch, "powerpc", 7)) {
> +       if (!strncmp(session->header.env.arch, "ppc64le", 7)) {
>                 if (cpu__get_socket_id(perf_cpu_map__cpu(map, 0)) == -1)
>                         return TEST_SKIP;
>         }
> --
> 2.35.1
>
