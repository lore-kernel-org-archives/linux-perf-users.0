Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEB6C07E99
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 20:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD0461961
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 20:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhGEUu4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jul 2021 16:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhGEUu4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jul 2021 16:50:56 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD931C061574;
        Mon,  5 Jul 2021 13:48:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u25so26117268ljj.11;
        Mon, 05 Jul 2021 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSiA5dyVn8zv0+eT4D7tVl3QtiwSLMc/3FaTxgI9gME=;
        b=DK/4yX9kQqxPbVsJUNFEpx/Ad+HeaOjR9kQOdcGoxCP9UqNcruq1+KnMa8xY+VqKov
         txOweGEupbFn8lqniF6EqC01CGAAPLvlNN7lXn4aeok/lQNQtC//rsZ71SFwwJng6tMo
         WyD+qXCbEau9wMbtZV1l7YM4HorQeRci65zwYlNv0Yh+dFY/BkvJf3UTWu1XM+L2KV3i
         xq0/MVLsUMz8atiG78qWEU7mFGRVN3pyUC1U+hJyg27Bi1dqP1qQdtIq761wpILFc5+u
         QqDiTFZ8NTyFDnMCM45Ems+WPz2JwitIxYQO2+9a7kfd7h2sZhCod+RIHb6x5EMFdR4p
         eLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSiA5dyVn8zv0+eT4D7tVl3QtiwSLMc/3FaTxgI9gME=;
        b=tGoERNkgCTFIzOxC+rJs1edd64ugL1vMTQ4uSF8ztOMLaoScfZBVs5wIhB/ZdN091N
         eKFTmsYOQ8wBqUqGMSFT7LsXhCJzL3vAahlYwiA6WgXAnadxAcelZ3eelRasqVb6Fh3g
         HI7yzKtKFclxyd10yd1Atkja/EMJl8lE+FqU13O6ny++3aWm/QqQiNhBKwqnH13H3qan
         Ly2QIcBuCLw3T0dlv4yuIGzy3m0OQ+eibOpRVlEAtqtx470GIFKatOwR4p6qg6a1bGIC
         KA4/ApZQjOf6OpJcq9oPCJf3A+WSVcIieZWeixFjH6tuGjbJoen6kixnigIZZEH+L49i
         agsA==
X-Gm-Message-State: AOAM530pie3wGy4sbhh9m6W4c1rQijM+8IjM1MMzEYWQpM6XKPkmuss+
        s9L4B02tccmOJSzlRdjwhY5uw4L6TMZSk8s9OMUWKrHf
X-Google-Smtp-Source: ABdhPJwbLlhoav8nYitmyBR+jEf/eZMPDb/uuQ16xtijRvjENbzkRcnREFQnPaAcgQ8V6Khukm5gkdLIVL4WjxKniD0=
X-Received: by 2002:a2e:8e6d:: with SMTP id t13mr12241177ljk.26.1625518096113;
 Mon, 05 Jul 2021 13:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <162532651032.393143.4602033845482295575.stgit@devnote2>
In-Reply-To: <162532651032.393143.4602033845482295575.stgit@devnote2>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Mon, 5 Jul 2021 13:48:04 -0700
Message-ID: <CAM9d7cj2H75byaNH-n4XeKbMu30j6_P3TAPwpoE9R1LXVTTSwQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf: Fix perf probe for Fedora34 glibc update
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jul 3, 2021 at 8:36 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Arnaldo,
>
> Here is a series of patches to fix the perf-probe error against the
> Fedora34 glibc update, which moves most of symbols from .symtab to
> .dynsym. The key is that the "most of" symbols moved, but it still
> have some PLT symbols in .symtab. Thus the perf symbol-elf failes to
> decode symbols.

Do you know what's the rationale of the move?
Is it a change from glibc or Fedora?

Thanks,
Namhyung


>
> Here is the original report from Thomas about this issue.
>
>  https://lore.kernel.org/linux-perf-users/f6752514-eaf9-371e-f81b-0d9e41ebae0c@linux.ibm.com/
>
> Thank you,
>
> ---
>
> Masami Hiramatsu (3):
>       perf-probe: Fix debuginfo__new() to enable build-id based debuginfo
>       perf symbol-elf: Decode dynsym even if symtab exists
>       perf probe: Do not show @plt function by default
>
>
>  tools/perf/builtin-probe.c     |    2 -
>  tools/perf/util/probe-finder.c |    5 ++
>  tools/perf/util/symbol-elf.c   |   82 ++++++++++++++++++++++++++--------------
>  3 files changed, 60 insertions(+), 29 deletions(-)
>
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
