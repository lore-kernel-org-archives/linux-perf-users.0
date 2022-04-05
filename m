Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED052C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Apr 2022 04:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbiDFEjo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Apr 2022 00:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385426AbiDEVtm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Apr 2022 17:49:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C47414081
        for <linux-perf-users@vger.kernel.org>; Tue,  5 Apr 2022 13:54:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso377224wml.5
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Apr 2022 13:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7Nc+OWWIHGASt7ceT9HSinzryxH9yuTM/mZ7qudLXw=;
        b=bm/b2V233v0KNNPc7n160+dYkg6oyI3vuHJw7cwpfH3x1XoVwVTtPf7dhxtA+/iqpB
         yXFRC0q+UzSdlPi5nCrVj3XPz4+yhzr+NGHhvfrdRf5qtIx2nc03d0jPeCmPRkocdopq
         n1DkrGB9C9829F9Ay/BWUWvSNDJvDg7SMM5s0lNd5uLasXWSaJXIHANmnxtyVW7UVJRi
         hzyfG7q8txrMwFUGnK3uzRbDqnLInUOgGIZU44+OuTHXsF2hhxcd0hzC3DFCNdqnnFqW
         W0Mtnp+wXORSk0PiWEwmollVO3u7Edhs0EHDduSUrWLRpsbTxP8Q4y+UtBySMaYgXZSG
         C41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7Nc+OWWIHGASt7ceT9HSinzryxH9yuTM/mZ7qudLXw=;
        b=tsSmmdld1s9Izo2Gb9ewBt0W9keiJuj4lDBeiT6ruLv6ho9IblTZFe5AzRNdopuorm
         gcwRojacFBpgFAON6lJPsWFXOkADy1Xc3Qyb6lh9kuL+f7nfTtVLO72c1TMhZwUQeEak
         ScOsjr6w21sK7/edY57Zmx42IsXL3wvrpYQWvofacXTKFfDl5za6whW02rWnNdeRgy+i
         f2gGo7Jg1WKQGcojOJj64Nut9XT1Rawpbc7uMWi2sz8b8Qmy60fE8ibMzRZHbV1c0mZP
         pc8GUhb5ZXVvTv2PiwRXrxBLzgFGlXYyyFf1ipcwIiCZFCzVMcr+cMbqWMf1IssbZNEm
         mdBg==
X-Gm-Message-State: AOAM530i4AxiE79se+TdQEyWG31m6hFvXBWpbKMN9CEzA7gfTlscY/4i
        vFU7gttjTqINCCsSt9B3BoiQCI4SRNB+JQmJ/riqqA==
X-Google-Smtp-Source: ABdhPJxi9QvC33Jh4rHSq+kDji7OP+D6x1uAK7z2Fo7Dum0AOdnp4zqI80VE5MsVGvZ1SroomUM1SQKFDDW0bWEt/08=
X-Received: by 2002:a05:600c:348c:b0:38c:f335:7219 with SMTP id
 a12-20020a05600c348c00b0038cf3357219mr4698128wmq.174.1649192073464; Tue, 05
 Apr 2022 13:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220404221541.30312-1-mpetlan@redhat.com> <20220404221541.30312-2-mpetlan@redhat.com>
In-Reply-To: <20220404221541.30312-2-mpetlan@redhat.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 5 Apr 2022 13:54:21 -0700
Message-ID: <CAP-5=fXo+gU1YwnHdWwk+5WNSOu9=V7WT7VknabwNnz0Lycxjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf: Add external commands to list-cmds
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@redhat.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Apr 4, 2022 at 3:59 PM Michael Petlan <mpetlan@redhat.com> wrote:
>
> The `perf --list-cmds` output prints only internal commands, although
> there is no reason for that from users' perspective.
>
> Adding the external commands to commands array with NULL function
> pointer allows printing all perf commands while not changing the logic
> of command handler selection.
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/perf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 2f6b67189b42..91eb36ec6f1c 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -55,6 +55,7 @@ struct cmd_struct {
>  };
>
>  static struct cmd_struct commands[] = {
> +       { "archive",    NULL,   0 },
>         { "buildid-cache", cmd_buildid_cache, 0 },
>         { "buildid-list", cmd_buildid_list, 0 },
>         { "config",     cmd_config,     0 },
> @@ -62,6 +63,7 @@ static struct cmd_struct commands[] = {
>         { "diff",       cmd_diff,       0 },
>         { "evlist",     cmd_evlist,     0 },
>         { "help",       cmd_help,       0 },
> +       { "iostat",     NULL,   0 },
>         { "kallsyms",   cmd_kallsyms,   0 },
>         { "list",       cmd_list,       0 },
>         { "record",     cmd_record,     0 },
> @@ -360,6 +362,8 @@ static void handle_internal_command(int argc, const char **argv)
>
>         for (i = 0; i < ARRAY_SIZE(commands); i++) {
>                 struct cmd_struct *p = commands+i;
> +               if (p->fn == NULL)
> +                       continue;
>                 if (strcmp(p->cmd, cmd))
>                         continue;
>                 exit(run_builtin(p, argc, argv));
> --
> 2.18.4
>
