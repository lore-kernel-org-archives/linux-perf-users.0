Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F99ECAAD2
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 Aug 2022 16:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiH1Qav (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 28 Aug 2022 12:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiH1Qat (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Aug 2022 12:30:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC4BCE0C
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Aug 2022 09:30:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so3289446wms.5
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Aug 2022 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=8iYA7/zHnHRjUXwjyr89mBi6Z8ClR5CepSWLX/7DS4I=;
        b=o8jgTJYbQI7CPPSpwkNnb+jIWwRc7V1YgVR8iCXe74tBHUOjQvOTB8WItIhLtmbLAB
         MBhF4hA2Cqm0Xr+hwIRBidKdMyeLig3QWaqMrixtOn5wLzfkAa5D4tfXCwSVfTbz0kdE
         AlIyxVV4pNL90FYCa1/6DU5F+HPKI2ugBJAqwK1T8csLRsOOl7k1wphQu69xZVDe7UPq
         TlwnEHyfRK95jqcgPIf4olPg3qVNf8gsOXl1VMvDVM+Pe8D/umjylGffcUij7Jxbbdb8
         8sTjNb9tFImt3RL9ULooe24AxiE5ZX7fk8pE6tZNFCzGHnoBL7cLsF9zzZxk9I54fcij
         gN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=8iYA7/zHnHRjUXwjyr89mBi6Z8ClR5CepSWLX/7DS4I=;
        b=F7KToRkI0oPWYY1eIREAvMBruFXvoipTkL/ZgHedKQNR/vTQLjGaSsckk/Fs1CP2C/
         mAebr4kdlbgCCO/soquWoHzZViba6xvZhfxii3YAICBvGmWGLaV6k8iqI4rnW+rb0jRg
         GmsBXTtOnZ0KVhmZNkZbpHE0ql1mdiZb9JRhEwsMwOelvPfVMr1VU6DE9D563V3RyH1z
         twlFa/pFprGXIS7mjXdhyV8eZMgBXl5gP4AV0wFjBq2gTZreaPu/P2ZlR8HzUQM52D/H
         sYDLqyU/zhu+HW47SMMJ63YeevXVJ8gKYiYbQH5lLRd/p/Xcoom552PYddTZc9djZott
         bgAg==
X-Gm-Message-State: ACgBeo2HGU5h4tEfdMZinXW5wPSYyOfMWGEtj3hDV8F9DtRPgr37RdQ/
        hemQmzSLdx4DjhX+FadAhj73QshKwhPCYRMQ1ghYzQ==
X-Google-Smtp-Source: AA6agR4One6bosCJ6A9x8yh1x65r25bMjXIidz5rd+Q7JOtlDLezbSF7S3Oz6WiNgWRmBdp4jQFnGb2IgV4dLAbaavo=
X-Received: by 2002:a05:600c:25ce:b0:3a5:a3b7:bbfe with SMTP id
 14-20020a05600c25ce00b003a5a3b7bbfemr5050970wml.115.1661704246941; Sun, 28
 Aug 2022 09:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <MW4PR18MB503443512239B3F40267004C8A729@MW4PR18MB5034.namprd18.prod.outlook.com>
 <9b3f785e-1370-cf23-2ba4-2b0163185b2e@linux.intel.com> <MW4PR18MB50341AD0A32C29137D3EEF178A759@MW4PR18MB5034.namprd18.prod.outlook.com>
In-Reply-To: <MW4PR18MB50341AD0A32C29137D3EEF178A759@MW4PR18MB5034.namprd18.prod.outlook.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 28 Aug 2022 09:30:33 -0700
Message-ID: <CAP-5=fXbJ3naAWnq6U7h7jbn2_qv0zWXXaq=kJs+xO8BdJY4xA@mail.gmail.com>
Subject: Re: Cannot use address filtering with user register sampling
To:     Hongtao Yu <Hongtao.Yu@outlook.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Wenlei He <wenlei@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 26, 2022 at 3:03 PM Hongtao Yu <Hongtao.Yu@outlook.com> wrote:
>
> Thanks for the information and suggestions!
>
> We=E2=80=99ve already been using the -c options to adjust our sampling sc=
ale. The new need we are having is that we=E2=80=99d like to sample a parti=
cular part of the program instead of the whole program. Since the hardware =
address filter doesn=E2=80=99t apply here, I=E2=80=99m wondering if it is p=
ractical to achieve the selective sampling on software level when processin=
g hardware interrupts, to avoid generating tons of useless trace data. For =
example, perf could do such filtering based on a section in the binary imag=
e that specifies the interesting part of program to sample.

It is possible to write BPF programs that will drop samples. There is
an example in the tests:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/tests/bpf-script-example.c

Thanks,
Ian

> Thanks,
> Hongtao
>
>
> From: Liang, Kan <kan.liang@linux.intel.com>
> Sent: Friday, August 26, 2022 7:28 AM
> To: Hongtao Yu <Hongtao.Yu@outlook.com>; linux-perf-users@vger.kernel.org=
 <linux-perf-users@vger.kernel.org>
> Subject: Re: Cannot use address filtering with user register sampling
>
>
>
> On 2022-08-24 8:14 p.m., Hongtao Yu wrote:
> > Hi,
> >
> > I was exploring address filtering together with user reg sampling on In=
tel Skylake hardware. The idea behind it is to make reg sampling more selec=
tively. Unfortunately, I hit ` This CPU does not support address filtering`=
 error. The command I ran is:
> >
> >    perf record -e br_inst_retired.all_branches:uppp --user-regs=3DDI --=
filter 'filter * @/bin/ls'  ls
> >
> >    This CPU does not support address filtering
> >
> > IIUC, the br_inst_retired event is also hardware-based, similarly with =
the intel_pt event. But the latter works with address filtering while the f=
ormer doesn=E2=80=99t. What is rational behind this?
>
> The --filter only supports the tracepoint event(s) or or a hardware
> trace, e.g., Intel PT. They trace and dump each single instruction. You
> can use the --filter option to choose and only retrieve the
> data/instructions you are interested.
>
> Perf record -e br_inst_retired.all_branches event does sampling. I would
> recommend you to use "-c" option to control the event period.(The number
> of events that triggers a single sample.) For example, -c1000 means 1000
> events occur then the HW dumps a sample (only for the 1000th event).
> e.g.,
>     perf record -e br_inst_retired.all_branches:uppp --user-regs=3DDI
> -c1000 ls
>
> Then you can use the post-processing tools, e.g., perf report or perf
> script, to filter and output the results.
> e.g.,
>    perf script --dsos ls -F+uregs
>
>
> Thanks,
> Kan
