Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAAAC2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 19:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DEC5611CE
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 19:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhFVTzU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 15:55:20 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:36455 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhFVTzU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 15:55:20 -0400
Received: by mail-lf1-f47.google.com with SMTP id d16so29715lfn.3;
        Tue, 22 Jun 2021 12:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMgSwwLZ69FlltYZhwtvgsM5zGBul1hA2YxAck7xfRc=;
        b=ThjISDgsl2XT9GzuK2djt4hP9HhC93Pe1qzO+WKVO6SoY3SLdMsyYelrbgVtX/uReR
         m6/EKHOOn1c30XNr181CJ8qMBer7iVCRhEoPDpCKzAJ8IFzY7iY4WzcAPQLZ8WmZwMuD
         e14IwASuUz+1t+LaMF/X4P50Dis8g5KTK7v7o761aqKoeVv0pvjs+5X+3v66i8TIskNU
         zo4PJY2y8YXcxYq8KOxaA5baHJhoxjr72BN555k/ZSQy7/Voi8WaA/X6z119pywsXZYO
         mzaFYlQEj5fAQxzoHAVqkGerxD5pGYZmHsBcplYM4N7l218pgGDrDZ0/0NoiNI/TRir1
         ix+w==
X-Gm-Message-State: AOAM5315Kt88I6zb8n6zH7LCdUF3ZcTzzBSNkutjEssgOqWvvV7Jh2G/
        qY+SWg2Y7XEb+dsVpzZaNS2IaNwmJSO/XkhDF28=
X-Google-Smtp-Source: ABdhPJw7lu5PhfBMF+OmzzaAXWCyqp4lAJjQ7ed+JMumXy19+QM9n17MCFRmxRkjO66H0IrEgOSyAAJ87jTI5gau9yc=
X-Received: by 2002:a2e:9984:: with SMTP id w4mr4471550lji.393.1624391582748;
 Tue, 22 Jun 2021 12:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210621214220.167927-1-rickyman7@gmail.com>
In-Reply-To: <20210621214220.167927-1-rickyman7@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 22 Jun 2021 12:52:51 -0700
Message-ID: <CAM9d7cgwTqDov1bD8FKygKkxeOY=tys8_DP3qytCmgne35BOcA@mail.gmail.com>
Subject: Re: [PATCH] perf data: close all files in close_dir
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 21, 2021 at 2:42 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> When using perf report in directory mode, the first file is not closed on
> exit, causing a memory leak.
> The problem is caused by the iterating variable never reaching 0.
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 8fca4779ae6a..70b91ce35178 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -20,7 +20,7 @@
>
>  static void close_dir(struct perf_data_file *files, int nr)
>  {
> -       while (--nr >= 1) {
> +       while (--nr >= 0) {
>                 close(files[nr].fd);
>                 zfree(&files[nr].path);
>         }
> --
> 2.23.0
>
