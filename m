Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6596AC2B9F4
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 05:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C286141C
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 05:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhFYFjl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 01:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhFYFjj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Jun 2021 01:39:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A808C061574
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jun 2021 22:37:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c84so5428450wme.5
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jun 2021 22:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaKEOLKP9BIjbEgBwhONJmuxzHCabnKfYmr62NuhX/A=;
        b=pGgT0FyQzjpw3KLSuy26od9PVVACl7X+mw/wpk5dua6WV4O4fyMBgoKliC/GD2tHSV
         sF/vzEBRNoIA/YzBmmL9pem9FQ/ojkUxCeEtWj+DLK6kvmNsh9HmuvbrqKMk3LJ+wMnq
         4nvknpT/oAxU+gxxFQFKg4j6eRbLrZxYQIJiKWcmu/GzOwSgjTKIYQiOLGRmUHLKsIEh
         sBIGI35RJ2sT8aUCailJwG0SuSu/dkfNmNHqD9xXumNl2+khW6txjXVzjzdLIMvBb7iz
         x9hsOyXlPgPhWykNR7Kh6ZT5yTUV70/8b6qNHJkxUK9N61uOUBDhU5oaqzsP30XbEsnj
         PXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaKEOLKP9BIjbEgBwhONJmuxzHCabnKfYmr62NuhX/A=;
        b=fkJU7IpfCLV/1j7ZPhIX1XNRYlAHg+fkMmh2etzpVsf6Hv/+/BBTKKyqmf9F4kqD5M
         Ft3QBSwZJg7aPUJGltZ4Lx97k/O9Bp404ITxncvhAWuEDd8sflxpHjywrRUcW+TUl6+b
         9OGcOY1UJu3hHWAqhkBde0hkRBX8rlclJbZjXm1aME8uxis5MmIVvCNC7votMl2f9MpI
         Bt1POx6UiuZlWqEr6IQJAHv/FOimj6yF5YjS3gdMtmii+S/h04jFLwVMoLUxVhIqPgpS
         GvLcSDiMN6Sqy59+T6grs97I8JIFc3Z6QJE4mDkCfNMSc5kJ3QlagWeimvr34mZeyBc8
         x8AA==
X-Gm-Message-State: AOAM532cSgPGNSi/IsZXIOC9qwM8gvub9a0sJizI6YmLxHZGNlF0YYVd
        nbn/OQH1xbbtzYqxNuckGXLP7AZ+Sxn6dKFkqPhoCA==
X-Google-Smtp-Source: ABdhPJywhwOUfZ6IrK731NmCUA8weP65uaJQNUOxN0vMtchNBm7MIFnqzF2m7xHkWzPKIm9+Jc977tqhbobm0OxF5bs=
X-Received: by 2002:a05:600c:a01:: with SMTP id z1mr8541210wmp.77.1624599436434;
 Thu, 24 Jun 2021 22:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210624223423.189550-1-rickyman7@gmail.com>
In-Reply-To: <20210624223423.189550-1-rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Jun 2021 22:37:04 -0700
Message-ID: <CAP-5=fXWFvcvNOA+wJMSCp2Qz7EVruufvFBLWEXfdezeEJGUTA@mail.gmail.com>
Subject: Re: [PATCH v2] perf annotate: allow 's' on source code lines
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin Liska <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 24, 2021 at 3:37 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> In perf annotate, when 's' is pressed on a line containing
> source code, it shows the message "Only available for assembly
> lines".
> This patch gets rid of the error, moving the cursr to the next
> available asm line (or the closest previous one if no asm line
> is found moving forwards), before hiding source code lines.
>
> Changes in v2:
>  - handle case of no asm line found in
>    annotate_browser__find_next_asm_line by returning NULL and
>    handling error in caller.
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/ui/browsers/annotate.c | 32 ++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index ad0a70f0edaf..f5509a958e38 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -343,6 +343,29 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
>         browser->curr_hot = rb_last(&browser->entries);
>  }
>
> +static struct annotation_line *annotate_browser__find_next_asm_line(
> +                                       struct annotate_browser *browser,
> +                                       struct annotation_line *al)
> +{
> +       struct annotation_line *it = al;
> +
> +       /* find next asm line */
> +       list_for_each_entry_continue(it, browser->b.top, node) {
> +               if (it->idx_asm >= 0)
> +                       return it;
> +       }
> +
> +       /* no asm line found forwards, try backwards */
> +       it = al;
> +       list_for_each_entry_continue_reverse(it, browser->b.top, node) {
> +               if (it->idx_asm >= 0)
> +                       return it;
> +       }
> +
> +       /* There are no asm lines */
> +       return NULL;
> +}
> +
>  static bool annotate_browser__toggle_source(struct annotate_browser *browser)
>  {
>         struct annotation *notes = browser__annotation(&browser->b);
> @@ -363,9 +386,12 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
>                 browser->b.index = al->idx;
>         } else {
>                 if (al->idx_asm < 0) {
> -                       ui_helpline__puts("Only available for assembly lines.");
> -                       browser->b.seek(&browser->b, -offset, SEEK_CUR);
> -                       return false;
> +                       /* move cursor to next asm line */

comment nit, perhaps prefer "closest" rather than "next" due to
searching backward.

Thanks,
Ian

> +                       al = annotate_browser__find_next_asm_line(browser, al);
> +                       if (!al) {
> +                               browser->b.seek(&browser->b, -offset, SEEK_CUR);
> +                               return false;
> +                       }
>                 }
>
>                 if (al->idx_asm < offset)
> --
> 2.31.1
>
