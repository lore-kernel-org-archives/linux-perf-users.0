Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACC0C77B78
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 05:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjEDFvb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 01:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEDFva (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 01:51:30 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673271731
        for <linux-perf-users@vger.kernel.org>; Wed,  3 May 2023 22:51:29 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-33164ec77ccso250325ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 May 2023 22:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683179489; x=1685771489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a/HKc7PwjD3Q1+TFgDiavZuTOvfNjVC4H3DeHGWxqE=;
        b=LH2HjhcE1aiNhuDmkzmvtFKwez04ywqxfNU0XsOTpoU4jsErIKayDaTBVIHgenQXbB
         61SRlNRFoTQYGekDGPq2XB4l5VNK3WtqNszovEr06FTnwRx8kVLcz74BWG3Uj2Nebg/x
         /O7YucZJhf9TGAAea3icWANPYMQKpYKxsx+w2g9V9gFx40vEIYYdYc7Gg1LwWvcoGzQe
         JRsYq3YZlnq/U14o18qNUqhC3yx5BN5k0xmlc79iM37XsmbvzKJlA8hfTS44ezXWjd7J
         EbNnKXo5E94f+RXbDeTjxP02hhWdMehNFiomiJLppPxxFGiNoo71oRVY7CyoGWu6hXFk
         o8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683179489; x=1685771489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2a/HKc7PwjD3Q1+TFgDiavZuTOvfNjVC4H3DeHGWxqE=;
        b=k8RbFatEG5zQXn4s75IzgNCv9AWylOs5zIGPLEy2rpgDmRNhdiG4MkkRrOgSTNoPIn
         l9sG0Ym3JKxZk34T21wj3cGympiiVJJGCe1KQ/b7HuRmGg21vW6nM1SNwJFzvWeSk6xa
         oNM5x6QNzWAU5sHV+Wo1lVBwE1U8bcJs0QxuRHFnIaI4cX9NMuqK73tLM6wSnEVtr+pE
         r3B7pYTg9m4advyFy8JQg0TgJd23KvC3WvamaEUSk/ARe0RjlBKN/rGymat1LEqYEsJ+
         SUk/a3vRNUtL3JcpZCR5cZKzFEj1rsk0pp7EUaVwTmPN1FYgwOfrUh8Cfsg5lLCevzyY
         VgGQ==
X-Gm-Message-State: AC+VfDw6l1DLrTN0xOv9DQUpQsV2pQMJxmpCMURZsdhaqDQ1SKPJd8+V
        iCm5CB/5Y6gMYkah0doE9OEuecYLtphm+SuCVwaGgA==
X-Google-Smtp-Source: ACHHUZ4H21WJZUtEeXdsA9kCblIuuU+osNDBnb471oQ8EPJnmWP8nRHU6ZFKqcwHBIwabdTrIxaupWJndZQjBAvtOJs=
X-Received: by 2002:a05:6e02:18ca:b0:329:3f69:539e with SMTP id
 s10-20020a056e0218ca00b003293f69539emr208186ilu.2.1683179488546; Wed, 03 May
 2023 22:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230503211801.897735-1-acme@kernel.org> <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
In-Reply-To: <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 3 May 2023 22:51:15 -0700
Message-ID: <CAP-5=fUNmiguiW+sv19EpGVVsrBD7dnVm4uMLOuutOo7_LUR=A@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 3, 2023 at 8:12=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, May 3, 2023 at 8:00=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I did consider it, but the end result doesn't even build, so I unpulled=
 again..
> >
> > I get some libbpf error, and I'm just not interested in trying to
> > debug it. This has clearly not been tested well enough to be merged.
>
> Side note: its' not even about testing.
>
> The error message makes it clear that this is garbage and should never
> be merged even if it were to compile.
>
> There is not a way in hell that it is correct that a 'perf' tool build
> should ever even look at the vmlinux binary to build.
>
> The fact that it does shows that something is seriously wrong in
> perf-tool land, and I will not be touching any pulls until that
> fundamental mistake is entirely gone.
>
> The vmlinux image that is present in my tree (ie
> /home/torvalds/v2.6/linux/vmlinux) is a test build with an insane
> config. And the fact that the perf tool even looks at it is seriously
> broken.
>
> Whatever you are doing - stop it right now.
>
>                Linus

I think the error you gave makes it pretty clear what is going on and
Arnaldo's e-mail explains the motivation. Perhaps we can check a
vmlinux.h into the perf tree so that we don't default to generating
it. This would avoid the binary dependency but we may need different
flavors for different architectures because of structs like pt_regs.

Thanks,
Ian
