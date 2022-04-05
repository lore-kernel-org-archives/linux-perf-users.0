Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2D4C4167D
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Apr 2022 21:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348846AbiDEVad (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356680AbiDEVZK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Apr 2022 17:25:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541C613FAD
        for <linux-perf-users@vger.kernel.org>; Tue,  5 Apr 2022 13:54:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so2393810wms.2
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Apr 2022 13:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nx4tu10XLVwuWMKd2gk4KppQ8JJIxvhcQ29/iPG2IRM=;
        b=eqOWNmnta05+b+Ks9A/OpzkM9BQ7Zkyb2ij9AUArwoMbPnarMdcpuupM9H5Fsr55go
         wcqaIraLCeM8FgLHL2/kHi6PguAVLkAZo1Gxzv9e2HOPZfKNZZMucwX87o6H/x8nANko
         5nRx07oco1X+nZ0lPKG6Vapi9/oVSDLIe4Pf6nbQSSnDu6axFg8/70lyXD4662ipw+az
         g6+fSw+sWFaWAZW/EIvaEJ32hxeDoI0EpCMkQdTzgll2untWgsrOlNpYs5O92rZdurO7
         sJM+w38MxlgoI555Eerxwbi8gjkxykP1Lc6fz9+lGXLSwvCwZ6fGcev4gJN0goPNJkgT
         FRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nx4tu10XLVwuWMKd2gk4KppQ8JJIxvhcQ29/iPG2IRM=;
        b=BiViK8V0/R51mFl/tn9jlWbwcBdq5/JfD4FhBjriujnS0oxcNW/8Dl/tYiZfpZiwdE
         Tiib642Bfu4shfYR0aiEmlYjL+OGFDwmhTsXuk1iZL9FuI6QCP6ptnS/OuNqO5tyB3uj
         8kqPTdcL/1Lz5CT640S7DdJbN91e1LVxBQkc7GMdd5GtnjzoVR49lOafdd8mAETZJQoy
         oUI4KX4c4jnNYCzxffx2OtBZ4U/8u8BemKQ0IiSVyk1OppMmDutJaORTXyV22OqkubAD
         7k09XDooaFY4dxzaPIbfMZpsJUAFQ1/SrnQESX7KAaQcez2sC42ESww786M64Y0EnVB9
         bzhw==
X-Gm-Message-State: AOAM531vjv67mQ6mQraowzGF1zaKNELHisTAJ597FDnOrtutHxnwc8OL
        2jg5v/yRYWggvGtUxzIgV/mIBj0wMO713vNVMofdVC/BtJg=
X-Google-Smtp-Source: ABdhPJymzhHlCpkJHCTC9S+DbNBjtdzVxZ7emC9nQydPusQAa8v9MACOb/bXNmfcFbdNFAHEIDCHHLXtj3fchKS6LXs=
X-Received: by 2002:a7b:cb56:0:b0:38e:7e24:33ab with SMTP id
 v22-20020a7bcb56000000b0038e7e2433abmr4620871wmj.182.1649192052690; Tue, 05
 Apr 2022 13:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220404221541.30312-1-mpetlan@redhat.com>
In-Reply-To: <20220404221541.30312-1-mpetlan@redhat.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 5 Apr 2022 13:53:59 -0700
Message-ID: <CAP-5=fVUs0rtEWsym4Sw7t83COvdOUFqGYi30_qX4zA=TMzJog@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf docs: Add perf-iostat link to manpages
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@redhat.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Apr 4, 2022 at 3:59 PM Michael Petlan <mpetlan@redhat.com> wrote:
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> index 9c330cdfa973..71ebdf8125de 100644
> --- a/tools/perf/Documentation/perf.txt
> +++ b/tools/perf/Documentation/perf.txt
> @@ -83,7 +83,7 @@ linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
>  linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
>  linkperf:perf-evlist[1], linkperf:perf-ftrace[1],
>  linkperf:perf-help[1], linkperf:perf-inject[1],
> -linkperf:perf-intel-pt[1], linkperf:perf-kallsyms[1],
> +linkperf:perf-intel-pt[1], linkperf:perf-iostat[1], linkperf:perf-kallsyms[1],
>  linkperf:perf-kmem[1], linkperf:perf-kvm[1], linkperf:perf-lock[1],
>  linkperf:perf-mem[1], linkperf:perf-probe[1], linkperf:perf-sched[1],
>  linkperf:perf-script[1], linkperf:perf-test[1],
> --
> 2.18.4
>
