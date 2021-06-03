Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95260C47096
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Jun 2021 23:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AAD6140F
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Jun 2021 23:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFCXaU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Jun 2021 19:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCXaU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Jun 2021 19:30:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE78C061756;
        Thu,  3 Jun 2021 16:28:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s6so8999157edu.10;
        Thu, 03 Jun 2021 16:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xfUY0TX7tuXJEEdu4nINq9m/FRxe8qkPqXyMt/FVDPo=;
        b=S/xTZKg3ARoLNKJrpj4PAaD/NKSurt9tsbgEjJSPtWkk60cEM1KYxnKGAlhygJz3Lk
         qdPbl6Z0UTO7UoSlkdhAjx4bFqJ3BPagC2U+u+RFp5VcGaG56pK1lWsxnPZzJKm8PG9e
         KZ0f4OQBNZGmjh8/1AHRSld8Sm0+pgIMvZS/foKu9J9G3QuscalAoj3a8EoFVzGqZHM+
         kPl0wHgnT1wn4KNLrRlEdH83OGodCrZXL482W+cQK65sJeByqMpYq/oqBw3i1eQcsE6M
         1cz545UZiIrQVI+oVKXw4bv5sp2tpqCHH7748g0Du7vFq59NFh1mJbX/MV2a3dlKVBIa
         N+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xfUY0TX7tuXJEEdu4nINq9m/FRxe8qkPqXyMt/FVDPo=;
        b=Fsy3Vzv8V0I+5aElFODPtpjbLXDq3cT5bFUL4x3TPYJMQ2gD2pwrsT/x5oIuGueQfF
         7I/zrweb3T3rr1wl7gfUaGWM88wiYr2CVw4bzHgDEJBt9DJYVqqj/RgbK+6LFhl7Rn6I
         eTK/7xU5L9SDVNG9kA+uvCf6JTX1IrH7aVI+m51rS2jw9fD3B8BzAPJEUTnc44LKJJ3L
         0+exxuZLQlSZoLK5bI7bEMvbIfR+ELMB9evyG92571B1SkaykkoGFqc7KBwjUjYaFohI
         1pH6pcf1n5NCdM3ydLYQK7MmvPaGGyAG9DmJeBL8D1D31wkaZVDSp1rDOjOq2MhVFQ2Q
         S+zg==
X-Gm-Message-State: AOAM533/ftTl4ubssI3oQY7tQxWNxwayBJVKak7FCM29nOeDZ36A5onD
        PSY89s0xt8F3F71idD5xb6U=
X-Google-Smtp-Source: ABdhPJzgBMMxuetZGn38RWYmHESgf/uKRAWdE3OsttNAtX5gpr0WTvIPnk4EWrerNZypqNyTCveMLA==
X-Received: by 2002:a05:6402:4316:: with SMTP id m22mr1742860edc.316.1622762899369;
        Thu, 03 Jun 2021 16:28:19 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.179.73])
        by smtp.gmail.com with ESMTPSA id j22sm2131542ejt.11.2021.06.03.16.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:28:18 -0700 (PDT)
Message-ID: <c3f5c4ecfc86ec1de29f6db681b2e5fce7ef23a3.camel@gmail.com>
Subject: Re: [PATCH v6 20/20] perf session: Load data directory files for
 analysis
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Fri, 04 Jun 2021 01:28:17 +0200
In-Reply-To: <be40346cdb384e0721f79d918067ff9026743845.1622025774.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1622025774.git.alexey.v.bayduraev@linux.intel.com>
         <be40346cdb384e0721f79d918067ff9026743845.1622025774.git.alexey.v.bayduraev@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Wed, 2021-05-26 at 13:53 +0300, Alexey Bayduraev wrote:
> Load data directory files and provide basic raw dump and aggregated
> analysis support of data directories in report mode, still with no
> memory consumption optimizations.
> 
> Design and implementation are based on the prototype [1], [2].
> 
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -
> b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/util/session.c | 129 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 041601810b85..dd4ef9749cd0 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -65,6 +65,7 @@ struct reader_state {
>         u64      data_size;
>         u64      head;
>         bool     eof;
> +       u64      size;
>  };
>  
>  enum {
> @@ -2319,6 +2320,7 @@ reader__read_event(struct reader *rd, struct
> perf_session *session,
>         if (skip)
>                 size += skip;
>  
> +       st->size += size;
>         st->head += size;
>         st->file_pos += size;
>  
> @@ -2418,6 +2420,130 @@ static int __perf_session__process_events(struct
> perf_session *session)
>         return err;
>  }
>  
> +/*
> + * This function reads, merge and process directory data.
> + * It assumens the version 1 of directory data, where each
> + * data file holds per-cpu data, already sorted by kernel.
> + */
> +static int __perf_session__process_dir_events(struct perf_session *session)
> +{
> +       struct perf_data *data = session->data;
> +       struct perf_tool *tool = session->tool;
> +       int i, ret = 0, readers = 1;
> +       struct ui_progress prog;
> +       u64 total_size = perf_data__size(session->data);
> +       struct reader *rd;
> +
> +       perf_tool__fill_defaults(tool);
> +
> +       ui_progress__init_size(&prog, total_size, "Sorting events...");
> +
> +       for (i = 0; i < data->dir.nr; i++) {
> +               if (data->dir.files[i].size)
> +                       readers++;
> +       }
> +
> +       rd = session->readers = zalloc(readers * sizeof(struct reader));
> +       if (!rd)
> +               return -ENOMEM;
> +       session->nr_readers = readers;
> +       readers = 0;
> +
> +       rd[readers] = (struct reader) {
> +               .fd              = perf_data__fd(session->data),
> +               .path            = session->data->file.path,
> +               .data_size       = session->header.data_size,
> +               .data_offset     = session->header.data_offset,
> +               .in_place_update = session->data->in_place_update,
> +       };
> +       ret = reader__init(&rd[readers], NULL);
> +       if (ret)
> +               goto out_err;
> +       ret = reader__mmap(&rd[readers], session);
> +       if (ret != READER_OK) {
> +               if (ret == READER_EOF)
> +                       ret = -EINVAL;
> +               goto out_err;
> +       }
> +       readers++;
> +
> +       for (i = 0; i < data->dir.nr; i++) {
> +               if (data->dir.files[i].size) {
> +                       rd[readers] = (struct reader) {
> +                               .fd              = data->dir.files[i].fd,
> +                               .path            = data->dir.files[i].path,
> +                               .data_size       = data->dir.files[i].size,
> +                               .data_offset     = 0,
> +                               .in_place_update = session->data-
> >in_place_update,
> +                       };
> +                       ret = reader__init(&rd[readers], NULL);

zstd_fini is never called on rd[readers].zstd_data
Maybe it can be done in perf_session__delete. For example, we could add a new
reader__fini function to do the cleanup of zstd data and
perf_decomp__release_events.

Thanks,
Riccardo

> +                       if (ret)
> +                               goto out_err;
> +                       ret = reader__mmap(&rd[readers], session);
> +                       if (ret != READER_OK) {
> +                               if (ret == READER_EOF)
> +                                       ret = -EINVAL;
> +                               goto out_err;
> +                       }
> +                       readers++;
> +               }
> +       }
> +
> +       i = 0;
> +
> +       while ((ret >= 0) && readers) {
> +               if (session_done())
> +                       return 0;
> +
> +               if (rd[i].state.eof) {
> +                       i = (i + 1) % session->nr_readers;
> +                       continue;
> +               }
> +
> +               ret = reader__read_event(&rd[i], session, &prog);
> +               if (ret < 0)
> +                       break;
> +               if (ret == READER_EOF) {
> +                       ret = reader__mmap(&rd[i], session);
> +                       if (ret < 0)
> +                               goto out_err;
> +                       if (ret == READER_EOF)
> +                               readers--;
> +               }
> +
> +               /*
> +                * Processing 10MBs of data from each reader in sequence,
> +                * because that's the way the ordered events sorting works
> +                * most efficiently.
> +                */
> +               if (rd[i].state.size >= 10*1024*1024) {
> +                       rd[i].state.size = 0;
> +                       i = (i + 1) % session->nr_readers;
> +               }
> +       }
> +
> +       ret = ordered_events__flush(&session->ordered_events,
> OE_FLUSH__FINAL);
> +       if (ret)
> +               goto out_err;
> +
> +       ret = perf_session__flush_thread_stacks(session);
> +out_err:
> +       ui_progress__finish();
> +
> +       if (!tool->no_warn)
> +               perf_session__warn_about_errors(session);
> +
> +       /*
> +        * We may switching perf.data output, make ordered_events
> +        * reusable.
> +        */
> +       ordered_events__reinit(&session->ordered_events);
> +
> +       session->one_mmap = false;
> +
> +       return ret;
> +}
> +
>  int perf_session__process_events(struct perf_session *session)
>  {
>         if (perf_session__register_idle_thread(session) < 0)
> @@ -2426,6 +2552,9 @@ int perf_session__process_events(struct perf_session
> *session)
>         if (perf_data__is_pipe(session->data))
>                 return __perf_session__process_pipe_events(session);
>  
> +       if (perf_data__is_dir(session->data))
> +               return __perf_session__process_dir_events(session);
> +
>         return __perf_session__process_events(session);
>  }
>  


