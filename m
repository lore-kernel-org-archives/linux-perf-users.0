Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E532EC19F2A
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Aug 2022 13:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiHKNEi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Aug 2022 09:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiHKNEh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Aug 2022 09:04:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115145C9E5
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Aug 2022 06:04:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z12so21275885wrs.9
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Aug 2022 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=2e5xEraFwitssTUNEgMvhSN1Fo53ZSeZM3+SG4owPqA=;
        b=UvEelm+FVkoDXMkUUsli0SxdIdTgc4ZzSyCT1PeVpi7MP/OLUEDPMQ8Pytq+dlLh4E
         mMftHGZ2BizWYEkswoxmBrf1ccXRwMR5W0FYqNltyD3cREHjBVpZ4Ilf4KrBejTcb1ov
         VUpg7Q14najvpz7ikaOHo9NRPd//tKDk7Q2a+fGyiiipdv31QcKwUxzh2FMsF9kgshMp
         /q7DQ44yJJ2i3xP2JSuozz5Sy9rpkw0MkGklcYVhC6HFsbBs4tKDz6m7KV5RrVrAT4cJ
         v30K5gxpL8FJCKGSlg9oZyF7avtlP5Pq7AWG8i2mMMbXoIIiu98rvA94QvHjVN6dyV0d
         Lr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=2e5xEraFwitssTUNEgMvhSN1Fo53ZSeZM3+SG4owPqA=;
        b=XD4AhoADmFwYA0daOXgZ00Smvisnc8d8b1AZQ993Z1wai+sk7144jnu96KTX4XYNy7
         m3qYDetUVOGH2iJHM+ZjVfMQc8bHWPIzH/sz+earxjw25cwNGhiJWVbVelZ6gv/NurIy
         d5QkjzZ1edybi+e0HFaavryD5nJuHj75WO9RKbYuAAq/dbRfmBKDEyGVMGn2mN9xRs2k
         wyVs3dYPFGRHn4fMlrPeukt0vth+tOuWdlbWkkTwAdTojMTO7+jynARl1c74/b+cQcZk
         hFb0rVXLXgPr5UmkuZ2D66cb0+WzYGht5E6OoEcVZlYLyAE2EHNr0jRzShot6DdNbc4f
         JQjQ==
X-Gm-Message-State: ACgBeo1LGrBiBVlZQ6EASIwHvyE7MXeRTJas5Dl8OQpDXLHyKZECm+Nc
        la5UweHUwsG+QFQFxAsKp6tz6Dz4IO61oDhaeFHiUNw9jKs=
X-Google-Smtp-Source: AA6agR59fn6Bg6JoTUAjggngVTIlBEac9mQufOByt4r3awlauhESGYNTJP2k9+TrpxM+k2DkqXrzepVF4JAqSrtvVjk=
X-Received: by 2002:a05:6000:1a87:b0:222:2c85:2f5b with SMTP id
 f7-20020a0560001a8700b002222c852f5bmr15234001wry.654.1660223073368; Thu, 11
 Aug 2022 06:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWiQHvYZp5R=uw4xUwBiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com>
 <CAP-5=fViwt1+PwcPZgw7Vy0VtP+UzSRNCYSLjbbAiTd44R5VZg@mail.gmail.com>
In-Reply-To: <CAP-5=fViwt1+PwcPZgw7Vy0VtP+UzSRNCYSLjbbAiTd44R5VZg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 11 Aug 2022 06:04:21 -0700
Message-ID: <CAP-5=fX40Ko6XV3F=06+mpyo=bNkbvoMTKiVbDyxYa9CA_fuUQ@mail.gmail.com>
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

On Wed, Aug 10, 2022 at 8:49 AM Ian Rogers <irogers@google.com> wrote:
>
> A reminder that this is tomorrow. Discussion of reviewers and reviewer
> rotation is on the agenda. Please suggest more items.

A reminder that this is in an hour.

Thanks,
Ian

> Thanks,
> Ian
>
> On Mon, Aug 8, 2022 at 3:36 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Hi,
> >
> > There will be another office hours on Thursday August 11th at 2pm
> > GMT*. Currently on the agenda is the idea of having a reviewer
> > rotation similar to BPF:
> > https://lore.kernel.org/bpf/50da58e3-e056-2d24-765b-818fed09e216@iogear=
box.net/T/
> > Please suggest other agenda items as replies to the mailing list to thi=
s email.
> >
> > If you experience problems accessing the meeting then my email can be
> > used for Google hangout messages, and I'll try to be on IRC (#perf on
> > irc.oftc.net).
> >
> > The code of conduct is below**:
> > https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
> >
> > The Google meet details are here:
> > Linux Perf Tool - Office Hours
> > Thursday, August 11 =C2=B7 7:00 =E2=80=93 8:00am
> > Google Meet joining info
> > Video call link: https://meet.google.com/goj-quks-ydn
> > Or dial: =E2=80=AA(US) +1 301-969-4101=E2=80=AC PIN: =E2=80=AA374 496 2=
27=E2=80=AC#
> > More phone numbers: https://tel.meet/goj-quks-ydn?pin=3D8067739163431
> > Notes (ask to be added to see):
> > https://docs.google.com/document/d/1tQZvJ12czMedpmLLZWS0XILAte97zdR6H_t=
gC3Ivafs/edit?usp=3Dsharing&resourcekey=3D0-iV9_8Oc0cSOPl0-NvEYDAA
> >
> > Thanks,
> > Ian
> >
> > *The around the world times I believe are:
> > China: 10pm
> > India: 7:30pm
> > Europe: 4pm
> > UK: 3pm
> > US east coast: 10am
> > Brazil: 11am
> > US west coast: 7am
> >
> > **More details from the first office hours are here:
> > https://lore.kernel.org/linux-perf-users/CAP-5=3DfWkxtm5-Ebwkh4pzA83prv=
uAJ5yy6CKQYatdkKWu3Tgeg@mail.gmail.com/
