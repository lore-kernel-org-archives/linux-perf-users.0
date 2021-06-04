Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4242BC4708F
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 04:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A11613F6
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 04:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFDELB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 00:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhFDELA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 00:11:00 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9CBC06174A
        for <linux-perf-users@vger.kernel.org>; Thu,  3 Jun 2021 21:09:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n4so7877454wrw.3
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Jun 2021 21:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfFWh4ehMvZvarUEM/OEH+HgEJn9h9iDxFF2ooCD8dA=;
        b=izbJ97c5bA5kiAg0OyxG8z7Op1DZWsH9lOrD0hv8MC+iEa29K9rV1k21a4TSFqGSRN
         DLp/z/A9fClS7OxJXegKLroGrPgZTFNmtcLlGk6Vnw6BlxC9ZunDPDYFqUbLo7KVNuiw
         OLGzKA7WR6Hihl44JJSKOIT49fcKaXWLwM9TBWSI8Z/8JlbuWHczr8lrMawrYzIV81iV
         yGl5gGUmFh+nwFtLbgmevWlj6xierVLPmgVGzB6RE5hcgJ3pE59hxAkUV8BUvKQXAcxB
         3K2GXHwiy7HxYdLm757RyIYVhC/kDvv2TdWWQd836RbugR6VDfHXf6/tBU2PAA9NV+Pp
         r3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfFWh4ehMvZvarUEM/OEH+HgEJn9h9iDxFF2ooCD8dA=;
        b=jabjpAfxO3ZlImCJC0RkuM1M2hGbda7F3gzkiETB9W7uUTf8Z4V3YFrPmlksZt4jPu
         +ULe8twZ43pSD24Wsg9Hge1NFe2TU5p6CfqPttmUZP4Mr3Fnbub42w28cw+WMG01IDOo
         rnp/wYoKI9ZsSpFxPLLKvYFTPLebQMGyO2Wybn1/hb7TaZiadKDVA39F5JEUEHaMXKoY
         57/Gf9TECARWHcU73tsHLmZdj1SwfTyQIOQEJBP42D3KzPwD/jDxcQMZLXUP/qalJ5gK
         SBMusgLhW9BOCWe7eOJyhrz35RPYzKFMieebCqvYzRuncGV3iLdon9BRJn9O84Z0GcW9
         Sk4A==
X-Gm-Message-State: AOAM5301yhIcZLNQMHtZDycw4bPlIH/HBW6HiNHcLi3ILy1A3Ec2MfP3
        /BF8114O86POtkYsPMaMZTcJaEBApz8wxQdaN1olgA==
X-Google-Smtp-Source: ABdhPJwCMc8OCua2a8Stp6+Juhx/T0QnU8lnOkF9ApbXBxQGf+cjfYTZ8147PX7RSpFOPdLl217ejDPQJt2rA/pO1sQ=
X-Received: by 2002:a5d:4903:: with SMTP id x3mr1481395wrq.376.1622779739764;
 Thu, 03 Jun 2021 21:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210602220833.285226-1-rickyman7@gmail.com>
In-Reply-To: <20210602220833.285226-1-rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Jun 2021 21:08:46 -0700
Message-ID: <CAP-5=fVp4xGd8wxLc1eFfTUPn3Urp23RmHBha2kgiJGvfysgZg@mail.gmail.com>
Subject: Re: [PATCH] perf symbol-elf: fix memory leak: free sdt_note.args
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Fabian Hemmer <copy@copy.sh>,
        Remi Bernon <rbernon@codeweavers.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 2, 2021 at 3:12 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> Reported by ASan.

Did you have a reproducer for getting this to fail?

> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol-elf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 4c56aa8374344..a73345730ba90 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -2412,6 +2412,7 @@ int cleanup_sdt_note_list(struct list_head *sdt_notes)
>
>         list_for_each_entry_safe(pos, tmp, sdt_notes, note_list) {
>                 list_del_init(&pos->note_list);
> +               zfree(&pos->args);
>                 zfree(&pos->name);
>                 zfree(&pos->provider);
>                 free(pos);
> --
> 2.31.1
>
