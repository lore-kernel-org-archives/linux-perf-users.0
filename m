Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01BEC61DA4
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Feb 2023 03:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBXDp4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Feb 2023 22:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBXDpz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Feb 2023 22:45:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1DE131
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Feb 2023 19:45:54 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p8so12743025wrt.12
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Feb 2023 19:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33nRVcEx51wK1syFEsZ5/2j4bLwy5lT6Y+g6+3Ht0fw=;
        b=b/5IGEPSM+YeIYNI+lfqEA27fjSYmJp+Q4NVnM3uPFUAONFhkq9s2BxFPe7LVG5hRo
         ni/Ppeb0E5i3Mt5BFtSSxiMVcJ9GVbE8Z53ckPA7QlFn2CwUCw0ZNd1F6qLRRjK4JVOb
         qrdkm8LGC8RmFezW3sQAfGlO3LOpLLYY9p/7Qm3VFfwGMYsM9Nw4AGphyAEe5AhJPkC3
         4PCu/4mXl67LKD5KoiYzOuWdgoIRBl7+5ZWyspcs/KFfs2TkkLVTZTCn4LbSN484NXfb
         nZcwCZWFg40iKzG0tEYbqgyPBiKBhxGeryPo77S1vHKHwZi7nLo4ktLHfE23vwSZa+2X
         yWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33nRVcEx51wK1syFEsZ5/2j4bLwy5lT6Y+g6+3Ht0fw=;
        b=qifI+RcDqS1inAPWSFV6uy1Q3JiBgahPSJEENMtJb3RHxx/TFY9vkoq8BQ8oRdwrq8
         2KGUgk0eScecZ+RNpGX2K1FDhoUVCXS+zuh8vBe++O/2N2WLuG4X66COV0Y6xjCfYmtJ
         5YS9loJd0pTf+y52wHt58FNuLaR42Zjn4HbSN8hFTaXwGXbeghVjEVXWssj+IPDLAaeu
         mMmyy37LlQIlL3skLagCljWLbv0znk/JEWaNjideIFCROHKWJ9MFGO3iaQ3mLYzKF19P
         70Q6s7FKqOjAqEfE7GXYh2+vo0eJiVlWg4y57WNLS72WcsmXdNl1HVUm1kf4Ruk3+mS8
         QWKA==
X-Gm-Message-State: AO0yUKUNcPTV7gQ0xh9+y9IsXLDVUW7VbpLua01flRp89Vt5VivzOcJd
        eQpC9FCnn96QTqDuhs++qu0rWnIWy0InTdwURjnNf5bW0kiVHokU
X-Google-Smtp-Source: AK7set9Jt2AbBb2iYiGwcv8kMMBiAWSeL4Q/pq3PMf2uj7eHRELjQt4QBUXrBqaiOXtWLtJfcPnNRiKa4/ESMlqoDE0=
X-Received: by 2002:a5d:5041:0:b0:2c5:881a:eaab with SMTP id
 h1-20020a5d5041000000b002c5881aeaabmr921413wrt.4.1677210352475; Thu, 23 Feb
 2023 19:45:52 -0800 (PST)
MIME-Version: 1.0
References: <CAPXMrf9hCmTKjUJJ_cymxqw696FdDvgV0xuDjwGeQTkoDpi=KQ@mail.gmail.com>
In-Reply-To: <CAPXMrf9hCmTKjUJJ_cymxqw696FdDvgV0xuDjwGeQTkoDpi=KQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Feb 2023 19:45:40 -0800
Message-ID: <CAP-5=fWzTyz5hZqPSrtMyxZ3biu+ywtzMJk-A2jituE20EGGNA@mail.gmail.com>
Subject: Re: perf record is crashing on system with bpf progs are running
To:     RAJESH DASARI <raajeshdasari@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Feb 23, 2023 at 12:02=E2=80=AFAM RAJESH DASARI <raajeshdasari@gmail=
.com> wrote:
>
> Hi ,
>
> perf record is crashing on systems with bpf programs are running.
>
> We are running on the 4.18 host kernel and we launch a container ,
> inside the container we run perf record command, (bpf program is
> running). Perf is built on top of the 5.4.228 kernel.

You mean you are running perf built from Linux 5.4? Could you try
something more recent like Linux 6.2?

Thanks,
Ian

> (gdb) bt
> #0  0x000000000055becf in perf_event__synthesize_one_bpf_prog
> (opts=3D0x94def8 <record+280>, event=3D0xabd910, fd=3D132, machine=3D0xaf=
6208,
> process=3D0x421260 <process_synthesized_event>,
>     session=3D0xaf6090) at util/bpf-event.c:242
> #1  perf_event__synthesize_bpf_events (session=3Dsession@entry=3D0xaf6090=
,
> process=3Dprocess@entry=3D0x421260 <process_synthesized_event>,
> machine=3Dmachine@entry=3D0xaf6208,
>     opts=3Dopts@entry=3D0x94def8 <record+280>) at util/bpf-event.c:333
> #2  0x000000000041ff5c in record__synthesize (tail=3Dtail@entry=3Dfalse,
> rec=3D0x94dde0 <record>) at builtin-record.c:1323
> #3  0x0000000000422bc4 in __cmd_record (rec=3D0x94dde0 <record>,
> argv=3D<optimized out>, argc=3D<optimized out>) at builtin-record.c:1465
> #4  cmd_record (argc=3D<optimized out>, argv=3D<optimized out>) at
> builtin-record.c:2474
> #5  0x0000000000490769 in run_builtin (p=3Dp@entry=3D0x9574b8
> <commands+216>, argc=3Dargc@entry=3D1, argv=3Dargv@entry=3D0x7fffffffc120=
) at
> perf.c:312
> #6  0x000000000040c05a in handle_internal_command
> (argv=3D0x7fffffffc120, argc=3D1) at perf.c:364
> #7  run_argv (argv=3D<synthetic pointer>, argcp=3D<synthetic pointer>) at=
 perf.c:408
> #8  main (argc=3D1, argv=3D0x7fffffffc120) at perf.c:538
>
> We tried running perf record --no-bpf-event but crash is still seen so
> we added the below patch to skip processing bpf events when
> no-bpf-event options is provided , but not sure if this is the actual
> solution, please provide your inputs.
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 454e275..78e96ad 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1320,11 +1320,12 @@ static int record__synthesize(struct record
> *rec, bool tail)
>                 return err;
>         }
>
> -       err =3D perf_event__synthesize_bpf_events(session,
> process_synthesized_event,
> -                                               machine, opts);
> -       if (err < 0)
> -               pr_warning("Couldn't synthesize bpf events.\n");
> -
> +        if (!opts->no_bpf_event) {
> +                err =3D perf_event__synthesize_bpf_events(session,
> process_synthesized_event,
> +                                                       machine, opts);
> +               if (err < 0)
> +                       pr_warning("Couldn't synthesize bpf events.\n");
> +        }
>
>
> Thanks,
> Rajesh Dasari.
