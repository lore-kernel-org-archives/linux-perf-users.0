Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF7C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 04:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiEREqP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 00:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiEREqN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 00:46:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D10F1260B
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:46:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u3so944480wrg.3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXaTY4KqUJaIozeXvx5Y70iZwlWNulDivMpkv1qtAes=;
        b=QnEROjlY59cCqYTFLpPTAG4jrLQMfzYgl6J52oW/zwCd/SMTy5737J/4Fpw3elm3mb
         oE3J9W2/OPHsUfzd9oWQe+Bmhd2WTDhGKmAPJYD09sutaUVlJEkBEnInk4LfZu/nVd5X
         +08CJSUQEEet1nKoyMpzvfpCk7vFqOPX3z9fJh4fkIZYj/erZYDzavktqpMMk38CzMeE
         D6v9ZIXZEodggD8aRytPIIpgCPFD3RtKpf8UDviw/hxSxQ+PXg+vAqrc97WJdiLwfbZ1
         OTlNStPRgL1TAAZzIOyJpBsZ4ltQ3TYkqiQZDjbl4Wz5U9x1gjfxR8xAunZUoSeO+rMF
         9YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXaTY4KqUJaIozeXvx5Y70iZwlWNulDivMpkv1qtAes=;
        b=mpMLhgU6qjslEWhLUbBfL1gBHaNOj7ZoqZtOcox4f6RAkrdTZjpI31TAF3r3jpw3V/
         6OYETKh9C9DN6tTe3P2BG67ObLVSYTf1KG5mo70ymq5s2awfN+OcGzWw3DaWSao0c5/n
         qBUsw+cJH272m6+6gG9WmHLO4Rl1qPoOHxeI1nD10hdgp25WNSwxmb4/wgSJyDSuSiGS
         a0CbWmOXQr0M7/vYsVSR4F4ywiUkY5tOH2JejTgQaVtT36ClsZSOQuUnYB5DU9/8fX0/
         uPmu4nbe2hsAXxKG/a7Ea+OqGeuGygNYfKlwKzqX++4RmByUIa5pFR0Ed3UOl5cvwQso
         OC7g==
X-Gm-Message-State: AOAM5338ctyofMDtG+ZntdH9F3DeuDhN68TXLuxvli2VEoixN2Qd5tsn
        E7ZiP/cl8WRt/ZZw9GSQD8qd4k0jpLVYBXGcNVt2Kg==
X-Google-Smtp-Source: ABdhPJyLXUL07uz5XWVyoozPMmvElgMnGmtzGQ5cFnBzsSyjmjmpcwHIf6RheJdz/bdInVDDH4/wjQYueClopvcpwQk=
X-Received: by 2002:a05:6000:78b:b0:20d:101b:2854 with SMTP id
 bu11-20020a056000078b00b0020d101b2854mr8366173wrb.300.1652849169359; Tue, 17
 May 2022 21:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220510074659.2557731-1-jolsa@kernel.org> <CAEf4BzbK9zgetgE1yKkCANTZqizUrXgamJa2X0f0XmzQUdFrCQ@mail.gmail.com>
 <YntnRixbfQ1HCm9T@krava> <Ynv+7iaaAbyM38B6@kernel.org> <CAEf4BzaQsF31f3WuU32wDCzo6bw7eY8E9zF6Lo218jfw-VQmcA@mail.gmail.com>
In-Reply-To: <CAEf4BzaQsF31f3WuU32wDCzo6bw7eY8E9zF6Lo218jfw-VQmcA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 17 May 2022 21:45:56 -0700
Message-ID: <CAP-5=fX6Z549my7VR0GYNW11vvXJc_4dmg8KOvaFAusjKJV=JA@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] perf tools: Fix prologue generation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 17, 2022 at 3:03 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 11, 2022 at 11:22 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, May 11, 2022 at 09:35:34AM +0200, Jiri Olsa escreveu:
> > > On Tue, May 10, 2022 at 04:48:55PM -0700, Andrii Nakryiko wrote:
> > > > On Tue, May 10, 2022 at 12:47 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > >
> > > > > hi,
> > > > > sending change we discussed some time ago [1] to get rid of
> > > > > some deprecated functions we use in perf prologue code.
> > > > >
> > > > > Despite the gloomy discussion I think the final code does
> > > > > not look that bad ;-)
> > > > >
> > > > > This patchset removes following libbpf functions from perf:
> > > > >   bpf_program__set_prep
> > > > >   bpf_program__nth_fd
> > > > >   struct bpf_prog_prep_result
> > > > >
> > > > > v2 changes:
> > > > >   - use fallback section prog handler, so we don't need to
> > > > >     use section prefix [Andrii]
> > > > >   - realloc prog->insns array in bpf_program__set_insns [Andrii]
> > > > >   - squash patch 1 from previous version with
> > > > >     bpf_program__set_insns change [Daniel]
> > > > >   - patch 3 already merged [Arnaldo]
> > > > >   - added more comments
> > > > >
> > > > >   meanwhile.. perf/core and bpf-next diverged, so:
> > > > >     - libbpf bpf_program__set_insns change is based on bpf-next/master
> > > > >     - perf changes do not apply on bpf-next/master so they are based on
> > > > >       perf/core ... however they can be merged only after we release
> > > > >       libbpf 0.8.0 with bpf_program__set_insns change, so we don't break
> > > > >       the dynamic linking
> > > > >       I'm sending perf changes now just for review, I'll resend them
> > > > >       once libbpf 0.8.0 is released
> > > > >
> > > > > thanks,
> > > > > jirka
> > > > >
> > > > >
> > > > > [1] https://lore.kernel.org/bpf/CAEf4BzaiBO3_617kkXZdYJ8hS8YF--ZLgapNbgeeEJ-pY0H88g@mail.gmail.com/
> > > > > ---
> > > > > Jiri Olsa (1):
> > > > >       libbpf: Add bpf_program__set_insns function
> > > > >
> > > >
> > > > The first patch looks good to me. The rest I can't really review and
> > > > test properly, so I'll leave it up to Arnaldo.
> > > >
> > > > Arnaldo, how do we coordinate these patches? Should they go through
> > > > bpf-next (after you Ack them) or you want them in your tree?
> > > >
> > > > I'd like to get the bpf_program__set_insns() patch into bpf-next so
> > > > that I can do libbpf v0.8 release, having it in a separate tree is
> > > > extremely inconvenient. Please let me know how you think we should
> > > > proceed?
> > >
> > > we need to wait with perf changes after the libbpf is merged and
> > > libbpf 0.8.0 is released.. so we don't break dynamic linking for
> > > perf
> > >
> > > at the moment please just take libbpf change and I'll resend the
> > > perf change later if needed
> >
> > Ok.
> >
>
> Jiri, libbpf v0.8 is out, can you please re-send your perf patches?

We still haven't done as Andrii suggested in:
https://lore.kernel.org/lkml/CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=hq657buqe2_yRKxaK-A@mail.gmail.com/
so for LIBBPF_DYNAMIC I believe we're compiling against the header
files in tools/lib rather than the installed libbpf's header files.
This may have some unexpected consequences.

Thanks,
Ian

>
> > - Arnaldo
