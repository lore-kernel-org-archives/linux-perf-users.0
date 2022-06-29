Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF70C43334
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Jun 2022 16:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiF2QT5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 12:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiF2QT5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Jun 2022 12:19:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FADC338B9
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 09:19:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r20so23261247wra.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLkSPLqdWchiZ/oz5Bm6mdpCQSd7koMGos2YDTUdRdc=;
        b=pSR0kohjl1FpuuyJEjOCrCbFAf3ojag1+QUrSubdb5P7wmrWHATHA/3Ty6XQEmoTMD
         fiO37Na0ZzEFywr3cjXQk7QkjEjJwuihnwIGqGWPgfgh7kbpteT9g2/VIjIZ+NLTK92V
         YdaRt+ArsTeZYwyZNrUus21QGBF0uWqB2MExPhIb9P1VHKij3CRUVIpSGV3STpQYgdlq
         U1Ru94iunQEsPHIPKwnaAauFcVkwUPUQqfm1LpSbqKJ9RMPcQdLngEWz+9qQ4ld1zJ8k
         7im8s7A8cLH2kIhhdgVbLJLF1WjAK/5BG2VJtD9Gy0jPApjZfCKbzNvzkzhPgYBL5M12
         FUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLkSPLqdWchiZ/oz5Bm6mdpCQSd7koMGos2YDTUdRdc=;
        b=1YORTzEs5RYhJotkzhFipTYXiqaLQVqLyqY/OHib9X8bbohnhUqk5sDfFC0Wy/JQlW
         OOXKNWISSXlK5uhkC7kb6Uz5o5TrHRri+UttXG1rWenTrRABF1DDii2GhGG/MIGIbxjA
         ZpAiCrEiCM5ZgCMqLSOWZS4FIgBW2VN5wIRtjtuN00BV5qciSyR2Zs1nV6+sR+rJNyht
         iBZYUggT4REsNFeIAbk8qM5ZLUGVbq1lMoP1Q3zrm+2I3liuLsLxRJPh+OI7N2CoQQLm
         OfV62FiJX1rZdc0WDMLJRs1hao3FF1IhEHmcpfExI0IZvg8QSRrzr+o/K3eXWIRI9Pn4
         fhhA==
X-Gm-Message-State: AJIora+awzAjoxM+uY+2+wPWoNzvzgW6EYzBA0CSlWgPr06WNHrBEAXj
        4dXJXveGPsyoGiyeHryCQWcFN3n8KGW4QIo1JE2Cvg==
X-Google-Smtp-Source: AGRyM1uee+LoBIZBf8a8NWZEvKBYMp+aDFM7tYysu5M431x388f6Rtjs1Wica8IAH2O3Ft1YDwnG5uoIS2e72wfVrvE=
X-Received: by 2002:a5d:5a1a:0:b0:21b:883a:28a1 with SMTP id
 bq26-20020a5d5a1a000000b0021b883a28a1mr3940129wrb.40.1656519593880; Wed, 29
 Jun 2022 09:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com> <20220614143353.1559597-7-irogers@google.com>
 <Yrwb28xHsPCZzSw7@krava>
In-Reply-To: <Yrwb28xHsPCZzSw7@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jun 2022 09:19:40 -0700
Message-ID: <CAP-5=fVfNxtX+QJqB532=LckGDQRbqV5i21iWSxucg0MS0Bejw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] perf cpumap: Add range data encoding
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 29, 2022 at 2:31 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Jun 14, 2022 at 07:33:53AM -0700, Ian Rogers wrote:
>
> SNIP
>
> > -static size_t cpus_size(const struct perf_cpu_map *map)
> > +static void synthesize_range_cpus(struct synthesize_cpu_map_data *data)
> >  {
> > -     return sizeof(struct cpu_map_entries) + perf_cpu_map__nr(map) * sizeof(u16);
> > +     data->data->type = PERF_CPU_MAP__RANGE_CPUS;
> > +     data->data->range_cpu_data.any_cpu = data->has_any_cpu;
> > +     data->data->range_cpu_data.start_cpu = data->min_cpu;
> > +     data->data->range_cpu_data.end_cpu = data->max_cpu;
> >  }
> >
> > -static size_t mask_size(const struct perf_cpu_map *map, int *max)
> > -{
> > -     *max = perf_cpu_map__max(map).cpu;
> > -     return sizeof(struct perf_record_mask_cpu_map32) + BITS_TO_U32(*max) * sizeof(__u32);
> > -}
> > -
> > -static void *cpu_map_data__alloc(const struct perf_cpu_map *map, size_t *size,
> > -                              u16 *type, int *max)
> > +static void *cpu_map_data__alloc(struct synthesize_cpu_map_data *syn_data,
> > +                              size_t header_size)
> >  {
> >       size_t size_cpus, size_mask;
> > -     bool is_dummy = perf_cpu_map__empty(map);
> >
> > -     /*
> > -      * Both array and mask data have variable size based
> > -      * on the number of cpus and their actual values.
> > -      * The size of the 'struct perf_record_cpu_map_data' is:
> > -      *
> > -      *   array = size of 'struct cpu_map_entries' +
> > -      *           number of cpus * sizeof(u64)
> > -      *
> > -      *   mask  = size of 'struct perf_record_record_cpu_map' +
> > -      *           maximum cpu bit converted to size of longs
> > -      *
> > -      * and finally + the size of 'struct perf_record_cpu_map_data'.
> > -      */
> > -     size_cpus = cpus_size(map);
> > -     size_mask = mask_size(map, max);
> > +     syn_data->nr = perf_cpu_map__nr(syn_data->map);
> > +     syn_data->has_any_cpu = (perf_cpu_map__cpu(syn_data->map, 0).cpu == -1) ? 1 : 0;
>
> I'm bit lost in the logic in here.. should it be '.cpu != -1' ?
> has_any_cpu is named as bool but used as index below ;-)
>
> could you please keep/update the comment above and explain
> the conditions when each cpu_map type is taken

So this relates to the CPU map "empty" problem that I've been moaning
about for a time with Adrian, Arnaldo, etc. The CPU map can contain -1
for the "any CPU" case in perf_event_open, it can also contain CPU
values after this as the result of a merge. Having only -1 in the CPU
map is referred to as a dummy (presumably because the dummy event uses
it), what does it mean if you have the -1 and CPU values? Things get
really messy when you look at what the definition of empty is. Here
I've used the term from perf_event_open that -1 means this can be on
any CPU. As the CPU map data is sorted we can take advantage that the
"any CPU" value always comes first. If we have it we set the bit here.
We also use the bit below so that we ignore the first array element if
it has -1 in it. As the -1 adjusts the CPU map size, there are some
other adjustments as well. Hopefully this makes things clearer and I
want to rewrite parts of the CPU map API to make them clearer too -
empty should mean == NULL or nr == 0, dummy is more confusing to me
than "any CPU", etc.

Thanks,
Ian

> thanks,
> jirka
>
> >
> > -     if (is_dummy || (size_cpus < size_mask)) {
> > -             *size += size_cpus;
> > -             *type  = PERF_CPU_MAP__CPUS;
> > -     } else {
> > -             *size += size_mask;
> > -             *type  = PERF_CPU_MAP__MASK;
> > +     syn_data->min_cpu = perf_cpu_map__cpu(syn_data->map, syn_data->has_any_cpu).cpu;
> > +     syn_data->max_cpu = perf_cpu_map__max(syn_data->map).cpu;
> > +     if (syn_data->max_cpu - syn_data->min_cpu + 1 == syn_data->nr - syn_data->has_any_cpu) {
> > +             /* A consecutive range of CPUs can be encoded using a range. */
> > +             assert(sizeof(u16) + sizeof(struct perf_record_range_cpu_map) == sizeof(u64));
> > +             syn_data->type = PERF_CPU_MAP__RANGE_CPUS;
> > +             syn_data->size = header_size + sizeof(u64);
> > +             return zalloc(syn_data->size);
> >       }
> >
> > -     *size += sizeof(__u16); /* For perf_record_cpu_map_data.type. */
> > -     *size = PERF_ALIGN(*size, sizeof(u64));
> > -     return zalloc(*size);
> > +     size_cpus = sizeof(u16) + sizeof(struct cpu_map_entries) + syn_data->nr * sizeof(u16);
> > +     /* Due to padding, the 4bytes per entry mask variant is always smaller. */
> > +     size_mask = sizeof(u16) + sizeof(struct perf_record_mask_cpu_map32) +
> > +             BITS_TO_U32(syn_data->max_cpu) * sizeof(__u32);
> > +     if (syn_data->has_any_cpu || size_cpus < size_mask) {
> > +             /* Follow the CPU map encoding. */
> > +             syn_data->type = PERF_CPU_MAP__CPUS;
> > +             syn_data->size = header_size + PERF_ALIGN(size_cpus, sizeof(u64));
> > +             return zalloc(syn_data->size);
> > +     }
> > +     /* Encode using a bitmask. */
> > +     syn_data->type = PERF_CPU_MAP__MASK;
> > +     syn_data->size = header_size + PERF_ALIGN(size_mask, sizeof(u64));
> > +     return zalloc(syn_data->size);
>
> SNIP
