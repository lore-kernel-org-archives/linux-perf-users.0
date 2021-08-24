Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47902C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 19:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3182860FD8
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 19:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhHXT2L (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:28:11 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:40677 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhHXT2L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 15:28:11 -0400
Received: by mail-lf1-f49.google.com with SMTP id v19so22507124lfo.7;
        Tue, 24 Aug 2021 12:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6h+JNdLP52k3zMbkqivoL2joVOk1AQjGMNl+Mz3dyfY=;
        b=OOhmObWIrfACoMuFk//OPvaQD8SFPaZa5zZURYCGr/htDcQJRoGuEnaNwb8SkiREPv
         0/z7/oz/poq9cfdV9Nqtz4Mo+EbJ2EKrDEPmMmWznh9nSsjtfK96K0WgZguWqfG4+7o6
         IQylnorMiXYKbGq2rCEXxjAzs7Lx2DxBpR8Am3xi8vZGuAVnG7KL/OfEM0F5ue7AYC4p
         7zDAuUXvm0LiV0oYJ94NjuhHt1XRePElD5xpuPQCHjrnYBhWKUd/sNfqkOgbMJGXMrzV
         GAaMD/jf3XN0eelvnOw3LiNAhAawm2LHRz0iubnWlBb9Ol/eIDC7OYl4AUlRgaiRnXKG
         Gm3g==
X-Gm-Message-State: AOAM533DEywlDMKIhq5etT0akJEZUlZw01gcq4i9kOT767UIc1GSl6i9
        fCr+UE5F3cg8L2l97UIC79dnFSw71KEJEKnY9BQ=
X-Google-Smtp-Source: ABdhPJwVjtxL1IV+werzcf+48UR6fug7aD9qw2gQnW8m7Gw9uhN3VBeaMl9OYfVvczCZo29jCWYJIAkR8PzrEWJguFM=
X-Received: by 2002:a05:6512:158e:: with SMTP id bp14mr22092115lfb.509.1629833245611;
 Tue, 24 Aug 2021 12:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629454773.git.rickyman7@gmail.com> <9dee672538967a3cf7e82ef194ebccc709b1af41.1629454773.git.rickyman7@gmail.com>
In-Reply-To: <9dee672538967a3cf7e82ef194ebccc709b1af41.1629454773.git.rickyman7@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 24 Aug 2021 12:27:13 -0700
Message-ID: <CAM9d7cjJuLdBtN_2it88v4VAmVZ5sSzcpDX-eU9A+hiyO3izaA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/15] perf workqueue: introduce workqueue struct
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Riccardo,

On Fri, Aug 20, 2021 at 3:54 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> +/**
> + * workqueue_strerror - print message regarding lastest error in @wq
> + *
> + * Buffer size should be at least WORKQUEUE_STRERR_BUFSIZE bytes.
> + */
> +int workqueue_strerror(struct workqueue_struct *wq, int err, char *buf, size_t size)
> +{
> +       int ret;
> +       char sbuf[THREADPOOL_STRERR_BUFSIZE], *emsg;
> +       const char *errno_str;
> +
> +       errno_str = workqueue_errno_str[-err-WORKQUEUE_ERROR__OFFSET];

It seems easy to crash with an invalid err argument.

> +
> +       switch (err) {
> +       case -WORKQUEUE_ERROR__POOLNEW:
> +       case -WORKQUEUE_ERROR__POOLEXE:
> +       case -WORKQUEUE_ERROR__POOLSTOP:
> +       case -WORKQUEUE_ERROR__POOLSTARTTHREAD:
> +               if (IS_ERR_OR_NULL(wq))
> +                       return scnprintf(buf, size, "%s: unknown.\n",
> +                               errno_str);
> +
> +               ret = threadpool__strerror(wq->pool, wq->pool_errno, sbuf, sizeof(sbuf));
> +               if (ret < 0)
> +                       return ret;
> +               return scnprintf(buf, size, "%s: %s.\n", errno_str, sbuf);
> +       case -WORKQUEUE_ERROR__WRITEPIPE:
> +       case -WORKQUEUE_ERROR__READPIPE:
> +               emsg = str_error_r(errno, sbuf, sizeof(sbuf));

This means the errno should be kept before calling this, right?

> +               return scnprintf(buf, size, "%s: %s.\n", errno_str, emsg);
> +       case -WORKQUEUE_ERROR__INVALIDMSG:
> +               return scnprintf(buf, size, "%s.\n", errno_str);
> +       default:
> +               emsg = str_error_r(err, sbuf, sizeof(sbuf));
> +               return scnprintf(buf, size, "Error: %s", emsg);

Newline at the end?

Thanks,
Namhyung


> +       }
> +}
> +
