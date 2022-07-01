Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFFAC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  1 Jul 2022 23:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiGAXGj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 1 Jul 2022 19:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiGAXGi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Jul 2022 19:06:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01166D56B
        for <linux-perf-users@vger.kernel.org>; Fri,  1 Jul 2022 16:06:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r20so5167935wra.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Jul 2022 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1B1PddGTFrs/U46LbISSKfXwRw3hwTHsrh1nOCkyZGM=;
        b=MwtHdmBTB8lfuO9wkWlKJj+Br1ms52PTcDsN5cQeoaOAaeGV/UAB0QIPKCip8L4RZ3
         8PjN+g1lN9q2ztsjpR02DmhQrMqjZHFKGMA/5pzC4AQmBr/bhXt5eXvKOKx2jjZrF1bx
         G9CrxAbgZ/cYYKbj09GnMy3FW/YCOVcomc9tev0xOnaM7mUcQ9pnhb+0LrI59v1UmIMp
         bie8l/RVReNL7eNCq98z5OlBA15gHQSrF6BuSGBzy8BmUnDirhFokX4LaaFNbD94NStm
         M6999INanbFvt1UuzaJMfZqiCh/wHiUEnyF0d73SvwvL13jwVQBJ42lINdUoUZWZwDV1
         l3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1B1PddGTFrs/U46LbISSKfXwRw3hwTHsrh1nOCkyZGM=;
        b=PiWTpNfjzlN690RLiA28bH3IR02qCXx0WPlwLmnmmXmo17qGvbdn+8TRJJZdpX58QX
         l3suhKjgiqSbmA60Nc3ZMx/neS9KxHGCrOks2T7dF1rxIgMIku+8/Xbd0z2owHcIfRSm
         srQOeuzPmx4WqHHauAQC7e9lHMdo1gKWtdk6Hlo9IGKik8n4g7/QBWYYrTkOXYPmJerv
         WUNR6PoOaPNV8O0+/RnDkNsfiKVHEMKGE1himMvqDGzi9QrGacuqQycx8983njaPAbWz
         VZkYeiCeY7bh7tjgmvnN1fPENVfCoILiRSmAdpD4oPzVvlKjbQzssD3ImaRwjwuGRuVr
         MY1g==
X-Gm-Message-State: AJIora+e5EoZhNY7ifJVb1sqJ4hAU5GWGRQAv1RusI84SMg+tXUi1fgO
        JUjDZf1qPwcwMCjxOx7ZIfoTq8DKx/bOhXPi9NWCAQ==
X-Google-Smtp-Source: AGRyM1tWpZix666JECrwCJowa6y3s9TWdxowxhr3qwkxiglqa7ZfYZIXog7jepaIxJ46KpT5De9W/q/nnphGp8jK8DA=
X-Received: by 2002:a5d:5983:0:b0:21b:b7cb:f84e with SMTP id
 n3-20020a5d5983000000b0021bb7cbf84emr16345581wri.654.1656716796220; Fri, 01
 Jul 2022 16:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220701205458.985106-1-namhyung@kernel.org> <20220701205458.985106-2-namhyung@kernel.org>
In-Reply-To: <20220701205458.985106-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 1 Jul 2022 16:06:24 -0700
Message-ID: <CAP-5=fVwkXcKopw--chdtjsX1D0MnXOXYjqgi-xx0_Zxk6bC=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tools: Ignore dead threads during event synthesis
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 1, 2022 at 1:55 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> When it synthesize various task events, it scans the list of task
> first and then accesses later.  There's a window threads can die
> between the two and proc entries may not be available.
>
> Instead of bailing out, we can ignore that thread and move on.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/synthetic-events.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index a068f42833c3..84d17bd4efae 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -767,11 +767,12 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>                 if (*end)
>                         continue;
>
> -               rc = -1;
> +               /* some threads may exit just after scan, ignore it */
>                 if (perf_event__prepare_comm(comm_event, pid, _pid, machine,
>                                              &tgid, &ppid, &kernel_thread) != 0)
> -                       break;
> +                       continue;
>
> +               rc = -1;
>                 if (perf_event__synthesize_fork(tool, fork_event, _pid, tgid,
>                                                 ppid, process, machine) < 0)
>                         break;
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
