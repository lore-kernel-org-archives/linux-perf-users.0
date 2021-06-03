Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BF2C47096
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Jun 2021 23:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB9A613AE
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Jun 2021 23:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFCXYJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Jun 2021 19:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFCXYJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Jun 2021 19:24:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12AAC06174A;
        Thu,  3 Jun 2021 16:22:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id jt22so11673276ejb.7;
        Thu, 03 Jun 2021 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cr/W34PCQ0jRykdhfg80VXv5W+pmG+k6UQUukwu1AKM=;
        b=rMzBmoS0a8UrOPfPp2DWc30WeIA4v2R5A8u86TA6B3W0K1LZtXURReMUUga0DBrw4S
         DuWbUtup1Aiem/4pRbmdvbWITrjBmifjxtUfQ7OuQLLqpv8dC+JM5w12S3wDF6bkZe43
         3xmcl2y+brCEWOSoGpr5eAg9oiv1/qcKLNb1HQJsAw5INZK1STGrGiwoE7uBwmEU2qox
         gLDFO3r0HxsWgOsnbHjmHlIyk1BbX3h+s0Sb9JOlgRzQ2wm0cz1UJoWSijV71UMPETfm
         bSqODbZpzpvR7GD5+4xJ7KkARH6DFkDfFVcHSRguqh60o3qBF++QwN6ia8qsPUyuHQbf
         C73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cr/W34PCQ0jRykdhfg80VXv5W+pmG+k6UQUukwu1AKM=;
        b=cVW84gkKR5bjRIXV4eSjcCv++hI/M60jspwM814Oqb62aNdfl1SsLa7RZqpDRFpTni
         FUeLzRNCsshaWs3pswbvfcT34b/sjOsFNaOuZvkAWJW5iqYx+Xu6n1iUVXmd4n9H1t62
         IM2TQGGnEHTlQL0xXn2M0eaDIxAUMvf6gaCFZmWj9cXIJ7sOZpG4FHtvMTD9edtlERun
         DnAmygoTlF9gRKT5+JYpV1HrONMcsSA/4AzOZR/Siaa8LA45EppJO5ZbYYFshdUIeshC
         AktBg+7wLfZM/gulT9w9DM5PiT7pJSLiT69/Vai55o6xoXKuZYQnlap2VjfjdW4IWRsg
         ekjg==
X-Gm-Message-State: AOAM533q/0pMOH7/uWAbO52UbCCzSQUl0QA7JaJjrcJP8VNdeyFrJLoa
        laQ+WWtXI92x/r2Ft5OjlxI=
X-Google-Smtp-Source: ABdhPJzGcHenR9d4YZ16zyRdJS6roMhpYMMFVYh3FlokWW3Z58CKH67neiguQV8QDLK0wl1TYubIGg==
X-Received: by 2002:a17:906:c1d3:: with SMTP id bw19mr1480400ejb.145.1622762524381;
        Thu, 03 Jun 2021 16:22:04 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.179.73])
        by smtp.gmail.com with ESMTPSA id h22sm2405074edv.0.2021.06.03.16.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:22:04 -0700 (PDT)
Message-ID: <b82ed13f7d907f548fde2fc1982a108cc8ca69ac.camel@gmail.com>
Subject: Re: [PATCH v6 16/20] perf session: Introduce decompressor into
 trace reader object
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
Date:   Fri, 04 Jun 2021 01:22:02 +0200
In-Reply-To: <ec370117b49575be493add488a07450517c78aaf.1622025774.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1622025774.git.alexey.v.bayduraev@linux.intel.com>
         <ec370117b49575be493add488a07450517c78aaf.1622025774.git.alexey.v.bayduraev@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Wed, 2021-05-26 at 13:53 +0300, Alexey Bayduraev wrote:
> Introduce decompressor into trace reader object so that decompression
> could be executed on per data file basis separately for every data
> file located in data directory.
> 
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/util/session.c | 51 +++++++++++++++++++++++++++++----------
>  tools/perf/util/session.h |  1 +
>  2 files changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 335c073bae87..6c9a682eb291 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -73,6 +73,9 @@ struct reader {
>         u64              data_offset;
>         reader_cb_t      process;
>         bool             in_place_update;
> +       struct zstd_data zstd_data;
> +       struct decomp    *decomp;
> +       struct decomp    *decomp_last;
>         struct reader_state state;
>  };
>  
> @@ -85,7 +88,10 @@ static int perf_session__process_compressed_event(struct
> perf_session *session,
>         size_t decomp_size, src_size;
>         u64 decomp_last_rem = 0;
>         size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
> -       struct decomp *decomp, *decomp_last = session->decomp_last;
> +       struct decomp *decomp, *decomp_last = session->active_reader ?
> +               session->active_reader->decomp_last : session->decomp_last;
> +       struct zstd_data *zstd_data = session->active_reader ?
> +               &session->active_reader->zstd_data : &session->zstd_data;
>  
>         if (decomp_last) {
>                 decomp_last_rem = decomp_last->size - decomp_last->head;
> @@ -113,7 +119,7 @@ static int perf_session__process_compressed_event(struct
> perf_session *session,
>         src = (void *)event + sizeof(struct perf_record_compressed);
>         src_size = event->pack.header.size - sizeof(struct
> perf_record_compressed);
>  
> -       decomp_size = zstd_decompress_stream(&(session->zstd_data), src,
> src_size,
> +       decomp_size = zstd_decompress_stream(zstd_data, src, src_size,
>                                 &(decomp->data[decomp_last_rem]), decomp_len -
> decomp_last_rem);
>         if (!decomp_size) {
>                 munmap(decomp, mmap_len);
> @@ -123,12 +129,22 @@ static int perf_session__process_compressed_event(struct
> perf_session *session,
>  
>         decomp->size += decomp_size;
>  
> -       if (session->decomp == NULL) {
> -               session->decomp = decomp;
> -               session->decomp_last = decomp;
> +       if (session->active_reader) {
> +               if (session->active_reader->decomp == NULL) {
> +                       session->active_reader->decomp = decomp;
> +                       session->active_reader->decomp_last = decomp;
> +               } else {
> +                       session->active_reader->decomp_last->next = decomp;
> +                       session->active_reader->decomp_last = decomp;
> +               }
>         } else {
> -               session->decomp_last->next = decomp;
> -               session->decomp_last = decomp;
> +               if (session->decomp == NULL) {
> +                       session->decomp = decomp;
> +                       session->decomp_last = decomp;
> +               } else {
> +                       session->decomp_last->next = decomp;
> +                       session->decomp_last = decomp;
> +               }
>         }
>  
>         pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
> @@ -319,11 +335,10 @@ static void perf_session__delete_threads(struct
> perf_session *session)
>         machine__delete_threads(&session->machines.host);
>  }
>  
> -static void perf_session__release_decomp_events(struct perf_session *session)
> +static void perf_decomp__release_events(struct decomp *next)
>  {
> -       struct decomp *next, *decomp;
> +       struct decomp *decomp;
>         size_t mmap_len;
> -       next = session->decomp;
>         do {
>                 decomp = next;
>                 if (decomp == NULL)
> @@ -336,6 +351,8 @@ static void perf_session__release_decomp_events(struct
> perf_session *session)
>  
>  void perf_session__delete(struct perf_session *session)
>  {
> +       int r;
> +
>         if (session == NULL)
>                 return;
>         auxtrace__free(session);
> @@ -343,10 +360,12 @@ void perf_session__delete(struct perf_session *session)
>         perf_session__destroy_kernel_maps(session);
>         perf_session__delete_threads(session);
>         if (session->readers) {
> +               for (r = 0; r < session->nr_readers; r++)
> +                       perf_decomp__release_events(session-
> >readers[r].decomp);
>                 zfree(&session->readers);
>                 session->nr_readers = 0;
>         }
> -       perf_session__release_decomp_events(session);
> +       perf_decomp__release_events(session->decomp);
>         perf_env__exit(&session->header.env);
>         machines__exit(&session->machines);
>         if (session->data)
> @@ -2157,7 +2176,8 @@ static int __perf_session__process_decomp_events(struct
> perf_session *session)
>  {
>         s64 skip;
>         u64 size;
> -       struct decomp *decomp = session->decomp_last;
> +       struct decomp *decomp = session->active_reader ?
> +               session->active_reader->decomp_last : session->decomp_last;
>  
>         if (!decomp)
>                 return 0;
> @@ -2214,6 +2234,9 @@ reader__process_events(struct reader *rd, struct
> perf_session *session,
>  
>         memset(mmaps, 0, sizeof(st->mmaps));
>  
> +       if (zstd_init(&rd->zstd_data, 0))
> +               return -1;
> +
>         mmap_prot  = PROT_READ;
>         mmap_flags = MAP_SHARED;

zstd_fini is never called on zstd_data.

Thanks,
Riccardo

> @@ -2257,12 +2280,13 @@ reader__process_events(struct reader *rd, struct
> perf_session *session,
>                 goto remap;
>         }
>  
> +       session->active_reader = rd;
>         size = event->header.size;
>  
>         skip = -EINVAL;
>  
>         if (size < sizeof(struct perf_event_header) ||
> -           (skip = rd->process(session, event, st->file_pos, rd->path)) < 0)
> {
> +           (skip = perf_session__process_event(session, event, st->file_pos,
> rd->path)) < 0) {
>                 pr_err("%#" PRIx64 " [%s] [%#x]: failed to process type: %d
> [%s]\n",
>                        st->file_offset + st->head, rd->path, event-
> >header.size,
>                        event->header.type, strerror(-skip));
> @@ -2289,6 +2313,7 @@ reader__process_events(struct reader *rd, struct
> perf_session *session,
>                 goto more;
>  
>  out:
> +       session->active_reader = NULL;
>         return err;
>  }
>  
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index 2815d00b5467..e0a8712f8770 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -44,6 +44,7 @@ struct perf_session {
>         struct decomp           *decomp_last;
>         struct reader           *readers;
>         int                     nr_readers;
> +       struct reader           *active_reader;
>  };
>  
>  struct decomp {


