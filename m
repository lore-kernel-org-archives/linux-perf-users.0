Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D7BC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 18:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A46F61177
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 18:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbhKISwy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 13:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242741AbhKISwx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 13:52:53 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CCBC061764
        for <linux-perf-users@vger.kernel.org>; Tue,  9 Nov 2021 10:50:07 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id v23so9131445iom.12
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Nov 2021 10:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7ayoAZBsG7SmT52WD7mztV4zmoTtxtcqBtR1Gou9eQ=;
        b=FvvQNa7hOwEnvZKsAmcWroNO2el/XKh1p/kqLEDzVcYNdDaxpBYMhXrxVExMC0RjZx
         AQ2HupjCg/azmyN8xTDiF3G4QcXZY4XeOLDmOdZXmEbHtEJ2e/5VNnWhXKzC/CWgY1kW
         9Ai0rjRqqNtSScIPx29vzaPCIub0xXk3lt2V97Jszg3O5VjlFdGALPtNNKfGwK/2H8ax
         TczdgUWx6k7X5kgvedEEip075SYscdOWJB9aVTUG582f/9GT8KTSj4VC0h6wjecdCVzL
         g0vAqZQZw5qy4aqR3vUPWoREoyPuSCP+sNvLeMcJ/9uMCvWUlq6SeFT/0QRWlTZ/zUjq
         tx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7ayoAZBsG7SmT52WD7mztV4zmoTtxtcqBtR1Gou9eQ=;
        b=mXYZxZn/QwnDH3iMreZ+PFqylHsg3pgqLfUYNy5BWU8PQEcQAKE897hxbolryuhMlr
         7SEDXVJh01c7ZiK87M64TUu/pqqJ1rtqHuXOmmZ0F64Gt/FyH2xQUDOOG2yxVCHM0nCz
         KoG0kP90yJo96v9OqnHygc72JhStQu9Vq8wrA3hTshCXqn3Pl1fvn3rEXGhjZw/WrHza
         jbtJamXdDKF+hXRRK+N0nnGz7UG4truvj/AQ6Xp+TIcJV7SbWnT5X5TPntvF6AMoccd7
         0O6WfGDMJxic89nsd19CpSU7xQJh7ot2gXtbCyVPV5xytqKFEMyxllSEpmuKzP0TUkBk
         hugg==
X-Gm-Message-State: AOAM530KtdY9Cs6K4is30sgaZDkdZn2PShD3XWR0/35s1QeqgFyTvjK4
        iAw9dxX/YCLmjalWwTxnvwUNOlb6qz2+hf4tGWrddw==
X-Google-Smtp-Source: ABdhPJwEIs3vlQLt6BT4ZkuXVh+EitAS6mwjZOseedf7mXmGOjP0VnyC89E9OFlORWdmo8U8hthIKUSy2oFTXfyev58=
X-Received: by 2002:a05:6638:144f:: with SMTP id l15mr7414854jad.21.1636483807037;
 Tue, 09 Nov 2021 10:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20211109140707.1689940-1-jolsa@kernel.org> <20211109140707.1689940-2-jolsa@kernel.org>
In-Reply-To: <20211109140707.1689940-2-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 9 Nov 2021 10:49:53 -0800
Message-ID: <CAP-5=fVS2AwZ9bP4BjF9GDcZqmw5fwUZ6OGXdgMnFj3w_2OTaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tools: Add more weak libbpf functions
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 9, 2021 at 6:07 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> We hit the window where perf uses libbpf functions, that did not
> make it to the official libbpf release yet and it's breaking perf
> build with dynamicly linked libbpf.
>
> Fixing this by providing the new interface as weak functions which
> calls the original libbpf functions. Fortunatelly the changes were
> just renames.

Could we just provide these functions behind a libbpf version #if ?
Weak symbols break things in subtle ways, under certain circumstances
the weak symbol is preferred over the strong due to lazy object file
resolution:
https://maskray.me/blog/2021-06-20-symbol-processing#archive-processing
This bit me last week, but in general you get away with it as the lazy
object file will get processed in an archive exposing the strong
symbol. With an #if you either get a linker error for 2 definitions or
0 definitions, and it's clear what is broken.

In the past we had problems due to constant propagation from weak
const variables, where #if was the solution:
https://lore.kernel.org/lkml/20191001003623.255186-1-irogers@google.com/

There was some recent conversation on libbpf version for pahole here:
https://lore.kernel.org/bpf/CAP-5=fUc3LtU0WYg-Py9Jf+9picaWHJdSw=sdOMA54uY3p1pdw@mail.gmail.com/T/
https://lore.kernel.org/bpf/20211021183330.460681-1-irogers@google.com/

Thanks,
Ian

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/bpf-event.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 4d3b4cdce176..ceb96360fd12 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -33,6 +33,33 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
>         return err ? ERR_PTR(err) : btf;
>  }
>
> +struct bpf_program * __weak
> +bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
> +{
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> +       return bpf_program__next(prev, obj);
> +#pragma GCC diagnostic pop
> +}
> +
> +struct bpf_map * __weak
> +bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
> +{
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> +       return bpf_map__next(prev, obj);
> +#pragma GCC diagnostic pop
> +}
> +
> +const void * __weak
> +btf__raw_data(const struct btf *btf_ro, __u32 *size)
> +{
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> +       return btf__get_raw_data(btf_ro, size);
> +#pragma GCC diagnostic pop
> +}
> +
>  static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
>  {
>         int ret = 0;
> --
> 2.31.1
>
