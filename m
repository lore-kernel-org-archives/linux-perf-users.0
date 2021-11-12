Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50625C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 04:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189FF60F70
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 04:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhKLEHi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 23:07:38 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:34673 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKLEHi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 23:07:38 -0500
Received: by mail-lf1-f53.google.com with SMTP id n12so9473012lfe.1;
        Thu, 11 Nov 2021 20:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jd7zy18ol8o88j6NC0liFiHDW4mhayufilBqjLPvku0=;
        b=X5KHFZqfi7U9pZ+vYvjap4o2PtneMVhGsfKKNFkCJZ1albdP2WWBxqIiW6wnlDGXs5
         ceEp4aXafrbAVwZRiCcjpUdGQqyvIDufMd2tB00ikIpUn+uSijqmXOufiaLshelED5rx
         1+Gc2MAN1SYBBHn53E1FI5NP+oum/PVWMmLeFmM1tpj06Mr0ch+mZlOlqkdEV4NuEFDR
         /Rgxg4jWu/r5aYCEAm2vE8pGDm9iOFlp/u6FjUd/5aiJL4HJhTdtOMKCLR2eEF2bI7S7
         KR+3RFxONQDIBmhk4iT2lDx1WZc5Fn0o61dO2zo9Bz9qWZwC8rGcsK8H+74bHRrJpFnO
         zHEQ==
X-Gm-Message-State: AOAM533DDIIxXdhx3npjE+Qe3hIqz91b4+6//OX7aVsFU1dNIO8hRLWt
        uYBHmZubmwpnEnFZyL4nyStDxMG/EpigMb0+Bzpkm64+
X-Google-Smtp-Source: ABdhPJw30TdWp5f+kxYRo5Y61nqw3dajwbhDnRMvMs7xu8glXMn3V7gVVc4h7hEKSo1MVx+E1iG9Lk6iYyZGZUe1wBw=
X-Received: by 2002:a05:6512:239d:: with SMTP id c29mr11393075lfv.454.1636689886753;
 Thu, 11 Nov 2021 20:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20211112035124.94327-1-irogers@google.com>
In-Reply-To: <20211112035124.94327-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 11 Nov 2021 20:04:35 -0800
Message-ID: <CAM9d7cji1Mtqap+TbMRn6ZeBb1v4ykKv4uBQxKtCQ3Zv9vY_jg@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf symbols: Add documentation to struct symbol.
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On Thu, Nov 11, 2021 at 7:51 PM Ian Rogers <irogers@google.com> wrote:
>
> Refactor some existing comments and then infer the rest.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

For all 3 patches,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/symbol.h | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 166196686f2e..3586fa549f44 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -40,22 +40,33 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
>                              GElf_Shdr *shp, const char *name, size_t *idx);
>  #endif
>
> -/** struct symbol - symtab entry
> - *
> - * @ignore - resolvable but tools ignore it (e.g. idle routines)
> +/**
> + * A symtab entry. When allocated this may be preceded by an annotation (see
> + * symbol__annotation), a browser_index (see symbol__browser_index) and rb_node
> + * to sort by name (see struct symbol_name_rb_node).
>   */
>  struct symbol {
>         struct rb_node  rb_node;
> +       /** Range of symbol [start, end). */
>         u64             start;
>         u64             end;
> +       /** Length of the string name. */
>         u16             namelen;
> +       /** ELF symbol type as defined for st_info. E.g STT_OBJECT or STT_FUNC. */
>         u8              type:4;
> +       /** ELF binding type as defined for st_info. E.g. STB_WEAK or STB_GLOBAL. */
>         u8              binding:4;
> +       /** Set true for kernel symbols of idle routines. */
>         u8              idle:1;
> +       /** Resolvable but tools ignore it (e.g. idle routines). */
>         u8              ignore:1;
> +       /** Symbol for an inlined function. */
>         u8              inlined:1;
> +       /** Architecture specific. Unused except on PPC where it holds st_other. */
>         u8              arch_sym;
> +       /** Has symbol__annotate2 been performed. */
>         bool            annotate2;
> +       /** The name of length namelen associated with the symbol. */
>         char            name[];
>  };
>
> --
> 2.34.0.rc1.387.gb447b232ab-goog
>
