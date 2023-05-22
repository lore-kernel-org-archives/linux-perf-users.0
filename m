Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC845C77B73
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 17:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjEVRun (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjEVRul (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 13:50:41 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E139118
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2023 10:50:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so4426189a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2023 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684777837; x=1687369837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21N69fXRIa64PVVS5XD52blO3YZaOM8DbCnSTBRVsMo=;
        b=pKsK3+dF5scOPXlLPS0Vte0P8EJ0sQ0Tk7YUG1IGXnY1NZoJiWWANPx+tGrLcJuPAy
         yKHpqsmHeRiH6zkIv+pC76wPN1vHbEibBkCvMsy3UKzQkOvj6wYQB/S1fUVZgtb8obhl
         FsYtfcSJJhqHcD6mo0pphPpVxvEo4GQ0va7W5KBP+Ve2qLiVmWLlNC++/fynDWOdpW/+
         4rlJLLmKHlhlT2Ljgpm2VeJ9Ze7Ba0DieFRfpVveY3Hjqg0H9n492VAG3NuDUzBbpdMG
         b7IlYNWuuCg9JpSkCwHcuudlWbSNwVcwUDTwSaZ/1LZrpRIyrs7ice/UMCXECoozR6PL
         mdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684777837; x=1687369837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21N69fXRIa64PVVS5XD52blO3YZaOM8DbCnSTBRVsMo=;
        b=Hq0vlQ7qYtMKQVx4V3UKf6g4nY3snKLWFuqzzQ+0/Pwz79sKDM9dFdWYIvIgtg+0BC
         /3CBaQDjnMad/20Y1q+pEB38ha/Qhcqd9Nl+5qwQaGK3afCc7e6mjLW/oYfY0LCIxlR2
         tmFy8a/PRGf4penyNzM5HD9norU1khT3y+K2CYAjMWGfGK6EFaUpIpYZuPq+TFh9AGpf
         H1rE8aPyYuwKMvF8tNlGnXCeqF8q9t8QHNvn7FmOaBku7JeBN60Ye5G3Roi5vLYlSUoK
         oinDklNEF3k4glFHzHyCCBvJYI1ZsZt9c8WPD7Z2TuGepYUz2wd2t5xY9IRmGkMdylfK
         bvRQ==
X-Gm-Message-State: AC+VfDwCLU1KcP1m+o+n7pvU0/AKNQxOARgoAfmj4RY+cOUNtgkQnWVg
        wyAo/GzQ6fi6bS+K5AhkSxdiWqorNbSwoRwzsf7Z/Urz
X-Google-Smtp-Source: ACHHUZ7l8cAuGF50AuqLJ9c8V0BZBJEIIN1GH97xtPys+RsKWDwmRNo4CYDASTWQFX5SArDzzwAmTdnFFOuDeEFP98k=
X-Received: by 2002:a17:90a:928e:b0:250:4a18:f575 with SMTP id
 n14-20020a17090a928e00b002504a18f575mr10759227pjo.9.1684777836898; Mon, 22
 May 2023 10:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAGA5_H6Ld9U0eTatJeExSGEynf41mvfcPZ34rtdO7rAVNuoXYQ@mail.gmail.com>
 <CAP-5=fWV2+auUQHQ5cvn2948M=0ThtrHftgGMM44ceCZyHiQeQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWV2+auUQHQ5cvn2948M=0ThtrHftgGMM44ceCZyHiQeQ@mail.gmail.com>
From:   Rajasekhar Pulluru <pullururajasekhar@gmail.com>
Date:   Mon, 22 May 2023 23:20:24 +0530
Message-ID: <CAGA5_H7CWd2vpomkLJ2mFzg8TyBdfkugTy1oYN3ojEGRy-VWqA@mail.gmail.com>
Subject: Re: DSO_BINARY_TYPE__SYSTEM_PATH_DSO
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,
Thanks for responding, I really appreciate your time and help!

Sorry, I don't see namespace related information in perf script output
(with/without -D option).
I tried to explore other options, but was not able to find an option
that can dump the ns information.

Do you have any alternate suggestions to debug this?

Thanks & Regards,
Rajasekhar

On Fri, May 19, 2023 at 11:27=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, May 19, 2023 at 10:49=E2=80=AFAM Rajasekhar Pulluru
> <pullururajasekhar@gmail.com> wrote:
> >
> > Hi Team,
> > Could someone help me shed some light on this macro
> > DSO_BINARY_TYPE__SYSTEM_PATH_DSO ?
> >
> > Case-1: I am trying to run perf top -p `pidof <app>` on ubuntu host
> > (based on ubuntu:jammy, outside the container) where the <app> runs
> > inside a container that's based on ubuntu bionic, and I don't see any
> > of <app> symbols (only hex-address and no function names) in perf top
> > output.
> >
> > Case-2: When I try to run perf top -p `pidof <app>` on ubuntu host
> > (based on ubuntu:bionic, outside the container) where the <app> runs
> > inside a container that's also based on ubuntu bionic, and I can see
> > <app> symbols (function names) in perf top output.
> >
> > On debugging both the cases, I find that, case-2 is able to display
> > symbol when dso__load of </opt/bin/<app> is successful for the type
> > DSO_BINARY_TYPE__SYSTEM_PATH_DSO, where-as the same fails for case-1
> > (is_regular_file check fails), and perf top reports "Failed to open
> > /opt/bin/<app>, continuing without symbols".
> >
> > In both the cases, the file /opt/bin/<app> is not available on the
> > host, and its only available inside the container.
> > What could be causing the above failure?
> >
> > Appreciate any help/inputs.
>
> Hi Rajasekhar,
>
> This is an area I'm not familiar with. I suspect the reason perf
> record/report are succeeding from your description is namespace
> information. If you look at the perf.data file with "perf script" and
> probably the "-D" option, you should see information. I'm not sure
> anybody has wired up the namespace code with perf top, which would go
> a long way to explaining your problems.
>
> Thanks for investigating this!
> Ian
>
> > Thanks & Regards,
> > Rajasekhar
