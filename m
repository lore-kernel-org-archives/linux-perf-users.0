Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AB6C00140
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Aug 2022 15:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiHJPtU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHJPtS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Aug 2022 11:49:18 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A8221E24
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 08:49:17 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id bi51so3482287vkb.5
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 08:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=z4rm8qHQd6KDv0Z23+IZwQE1Sw/HS2T9ErGB9+4K64Q=;
        b=l7Pj5auHrFzhQ5xcoEnc7Y6ZAxm4dUjgCAcjmQkvr/LlDBZxTcSm03cOiqSlH2gKQE
         opoYC+rUehvJbcnKIWtGUs5kYzi01jhx6xh2wAOpz5iEtXstzZCufPzp1HIn+3O1B3wl
         vlNWIuaKgE/5QiMl0FioBlAcRMjhZRpZmYmvk6dot3EvByoUTDbknMPmS8njkPs9VOC0
         MsNoHDW+RQbFQ5gEDbQIywOhj1e3nc8hvgXbKMVpk9MbMaBkvZH4qnnGGg9wMH5PTCRT
         av613sHyEGdpalYMVoL1rngzemzxIjjzVQRhV8SEVt6Ap7wma1DUWtJ9MnKDMwhYrP3E
         VCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=z4rm8qHQd6KDv0Z23+IZwQE1Sw/HS2T9ErGB9+4K64Q=;
        b=VJMIva/y2SfqOGEH4VDJVkcu45RacGH5P51/hvwSaAxjQG7ODsES4nUEMMR0snIz9c
         mk6PxofvZQfEZmGRG5hNztdjk2kM5rC46dP7HAdyNkwbfqT4cvFWRNg9oxNjLdI/fNQw
         NeImPcPYto2an46ZWXKrEKL5doe0KNAtp226gTZ5f/tDHw6e6rVvolNVu9EVFQJy1f2D
         q9hlpuI7y/MzKAh20kku0Zd15857FBNIOyFg4UbrKuCrROay4gQoQtsl17elPdWiAj9h
         V83yQTKrfdRmJrO8Wq652jmBxOXGhpPB/8km72T7X+vZ0MY9ZIzpvOlkAjClj751jpac
         OjvQ==
X-Gm-Message-State: ACgBeo3NGXdlN72ap7215bjCYyGDKsjdYoLdFy8NO58+wQCG73e8j79q
        iuViVFOsSBTAGlQ4xtxZBOF5eFRZVZb+wsw+Z6+saLPI71I=
X-Google-Smtp-Source: AA6agR4WWa6V7KdTH8Aa45Kuvcq9309pyU5Y9Q+FB2vUhFqbyofXP6ZckYa7tnrPLjqi4JnhpT5PyRkYTJzwfqs4eK0=
X-Received: by 2002:a05:6122:e2a:b0:37c:eefd:4df6 with SMTP id
 bk42-20020a0561220e2a00b0037ceefd4df6mr1064245vkb.37.1660146556245; Wed, 10
 Aug 2022 08:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWiQHvYZp5R=uw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com>
In-Reply-To: <CAP-5=fWiQHvYZp5R=uw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 10 Aug 2022 08:49:04 -0700
Message-ID: <CAP-5=fViwt1+PwcPZgw7Vy0VtP+UzSRNCYSLjbbAiTd44R5VZg@mail.gmail.com>
Subject: Re: August 11th - office hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A reminder that this is tomorrow. Discussion of reviewers and reviewer
rotation is on the agenda. Please suggest more items.

Thanks,
Ian

On Mon, Aug 8, 2022 at 3:36 PM Ian Rogers <irogers@google.com> wrote:
>
> Hi,
>
> There will be another office hours on Thursday August 11th at 2pm
> GMT*. Currently on the agenda is the idea of having a reviewer
> rotation similar to BPF:
> https://lore.kernel.org/bpf/50da58e3-e056-2d24-765b-818fed09e216@iogearbo=
x.net/T/
> Please suggest other agenda items as replies to the mailing list to this =
email.
>
> If you experience problems accessing the meeting then my email can be
> used for Google hangout messages, and I'll try to be on IRC (#perf on
> irc.oftc.net).
>
> The code of conduct is below**:
> https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
>
> The Google meet details are here:
> Linux Perf Tool - Office Hours
> Thursday, August 11 =C2=B7 7:00 =E2=80=93 8:00am
> Google Meet joining info
> Video call link: https://meet.google.com/goj-quks-ydn
> Or dial: =E2=80=AA(US) +1 301-969-4101=E2=80=AC PIN: =E2=80=AA374 496 227=
=E2=80=AC#
> More phone numbers: https://tel.meet/goj-quks-ydn?pin=3D8067739163431
> Notes (ask to be added to see):
> https://docs.google.com/document/d/1tQZvJ12czMedpmLLZWS0XILAte97zdR6H_tgC=
3Ivafs/edit?usp=3Dsharing&resourcekey=3D0-iV9_8Oc0cSOPl0-NvEYDAA
>
> Thanks,
> Ian
>
> *The around the world times I believe are:
> China: 10pm
> India: 7:30pm
> Europe: 4pm
> UK: 3pm
> US east coast: 10am
> Brazil: 11am
> US west coast: 7am
>
> **More details from the first office hours are here:
> https://lore.kernel.org/linux-perf-users/CAP-5=3DfWkxtm5-Ebwkh4pzA83prvuA=
J5yy6CKQYatdkKWu3Tgeg@mail.gmail.com/
