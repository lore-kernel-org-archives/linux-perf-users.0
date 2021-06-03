Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406F2C47096
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Jun 2021 22:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9696140A
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Jun 2021 22:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCW7g (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Jun 2021 18:59:36 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:44547 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFCW7g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Jun 2021 18:59:36 -0400
Received: by mail-ej1-f49.google.com with SMTP id c10so11557533eja.11;
        Thu, 03 Jun 2021 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=d0FPSnKWKgyYbiM8cigMcHZW9uwmiUJWHnRMyIytsDY=;
        b=Zg72/ybcmMgZubOk5F1MC5rjdQD7HkORmiTwrToSzNILlOwM6xwmwTKfeW3QTdW9MO
         UqpdbfTxaqXOvJdplo9wua3LC4lk6pShQ/lG3KcfjTxsD/PhpnA8d1KcgcfaBEwvDhVj
         EFp50ejbyws7Ufql1owugAuPyj7UwoJ7Bv1ENT42Nforc/u+daOJnjMKsCOhV4CTc6c9
         ZrUt2YonCrB66Z7bBKfwU0xEhydOcD4iiqpxFM83RYIcC07Jp2RfHKX98dG/6naWZnY0
         qmJh4CGr9zcrG3kgC36YyKqNgyaxeTEK5UA54kPw9Y/uedQW8pDyfRxEp5eFowO5iSQG
         nHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=d0FPSnKWKgyYbiM8cigMcHZW9uwmiUJWHnRMyIytsDY=;
        b=AGg1xR9+NgSCIrf9b5aIjYIPX5C13drwmC4SlVlcA47ufpIX21Dli8b5kdPqA0jQpl
         dMgxNEcx0f1pswDP+DAbFnQZJc5Uk008cDa/Umya9ckYUuydsC/4YI4x/3GJrO6IGElm
         Wcki45RQfFHw0FXBGGL6aoZvXdFehOB84dUuu/5eMG0rnv7ZlodZ59jgvtt6ntiCPGc3
         ckBofPTxMSLQJ8wZoJoonGRZquVo9Jp4GX2Gfa3pO3cgFdrTCHOlEkljvj5O0SitWxBJ
         Z5HZJk9fEeRKEpqbGct5lTAtvcdJ8fAFZt8Fl8LorE3YJgTQ2OYSJvlD/aHpDKv1KqBT
         TDIg==
X-Gm-Message-State: AOAM533wD4hV4pK44M+Ky1zoK5bVTGc0QyjS+d0wIOWUyiie5If8bq7m
        Y2JDz6IJXmLnsrDab4BasaWnCBYjuUkzfZQE1AY=
X-Google-Smtp-Source: ABdhPJy8AreRDvIuBKD6CO2n0Z5xuE7xdGJAAqdVO0212AH+iFsrqnTrzEsdB9z58RTqpIXB6FiyWw==
X-Received: by 2002:a17:907:7713:: with SMTP id kw19mr1335113ejc.249.1622761010060;
        Thu, 03 Jun 2021 15:56:50 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.179.73])
        by smtp.gmail.com with ESMTPSA id d22sm2055397ejj.47.2021.06.03.15.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 15:56:49 -0700 (PDT)
Message-ID: <3b297a17f935d2a00bfa74afbbf064b01fe83607.camel@gmail.com>
Subject: Re: [PATCH v6 03/20] perf record: Introduce thread local variable
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
Date:   Fri, 04 Jun 2021 00:56:48 +0200
In-Reply-To: <c5a046f8bed989e4ede98f1fcdaa9d0b6bf78cac.1622025774.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1622025774.git.alexey.v.bayduraev@linux.intel.com>
         <c5a046f8bed989e4ede98f1fcdaa9d0b6bf78cac.1622025774.git.alexey.v.bayduraev@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

thank you very much for your work for adding threading capabilites to perf
record. 
I did some testing on your entire patchset, especially checking for memory
issues using ASan. This is just the first of a couple of emails to point out
some issues I found.
I will also do additional tests in the future.

On Wed, 2021-05-26 at 13:52 +0300, Alexey Bayduraev wrote:
SNIP
> @@ -2220,18 +2275,20 @@ static int __cmd_record(struct record *rec, int argc,
> const char **argv)
>                 goto out_child;
>         }
>  
> -       if (!quiet)
> -               fprintf(stderr, "[ perf record: Woken up %ld times to write data
> ]\n", waking);
> -
>         if (target__none(&rec->opts.target))
>                 record__synthesize_workload(rec, true);
>  
>  out_child:
> +       record__stop_threads(rec, &waking);
> +out_free_threads:
>         record__free_thread_data(rec);
>         evlist__finalize_ctlfd(rec->evlist);
>         record__mmap_read_all(rec, true);
>         record__aio_mmap_read_sync(rec);

record__mmap_read_all should be moved before record__free_thread_data since it
uses the thread_data that's just been freed.
Furthermore, record__mmap_read_all should also be moved before the
out_free_threads label, since it cannot be called unless record__start_threads
succeeded, otherwise thread would be NULL and will cause a segfault (it happens
if there is an error somewhere else in perf, for example).

In my tests the following order works, but it should be double checked for
possible side-effects of this order change.

out_child:
        record__stop_threads(rec, &waking);
        record__mmap_read_all(rec, true);
out_free_threads:
        record__free_thread_data(rec);
        evlist__finalize_ctlfd(rec->evlist);
        record__aio_mmap_read_sync(rec);

Thanks,
Riccardo

> +       if (!quiet)
> +               fprintf(stderr, "[ perf record: Woken up %ld times to write data
> ]\n", waking);
> +
>         if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
>                 ratio = (float)rec->session->bytes_transferred/(float)rec-
> >session->bytes_compressed;
>                 session->header.env.comp_ratio = ratio + 0.5;
SNIP


