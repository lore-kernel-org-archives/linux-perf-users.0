Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E914C001E0
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Aug 2023 19:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbjHJT1a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Aug 2023 15:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbjHJT13 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Aug 2023 15:27:29 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE47EC7
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2023 12:27:26 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-407db3e9669so67391cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2023 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691695646; x=1692300446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNnltR97BeMOnmf/YZYMujSXMH2ommF1rsHE9Oftg0w=;
        b=m5swtl2RPkKGhH31c5dbSWWJzoE9Tb+6vSVU6lNJv/hCgc2tL5fjN/8xF3te1zxsz6
         G+u5ltz59IfYdr/d1QWpN5VPjXVfRvNLzYsouwyNpVM2g3p6z0qam9cGkr3sO9ZqBqLG
         2eJoNiqD6fbJfFYNl0pm/vkr4lMaFO+zhB8JnTEZcjfqa2kmsCMgO6xHGK7bHDwjgKGT
         7NPrfmxSxNpf2CwJVFmW1PxppfQBppgY49YNTcjHAaiZbwqMPoIruJIyjdJG1zjF1SPc
         eu3/hMX30UQaBEA6xZ0NDFGVq9AbTafsK0QJYzNAMRUUoq/Sv0H58lE8pE6z4ugBDaAM
         c2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691695646; x=1692300446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNnltR97BeMOnmf/YZYMujSXMH2ommF1rsHE9Oftg0w=;
        b=Aq2Q6fxbmAzs1ETjZHdm9VCRDUrzK8rV0bk+lE/o01uBimOrydxYcC9b0ON5n5T/1C
         +wtU0Qq89f/lJUJZ0zm9owxxOm+EsLKGGz47xByPlftBhCKKHBhVmsjssL1+/5OBGwqT
         S+joJZrCSTCKLXBu1Wsy0FPbmgz6qXnHTcQ047ywGYRavKcGFCsJnc2dGIKX3NBvjD0u
         avXDDyJK7gxh3P7LtiqhavhRCyb5PZg3fLmd6E53VxwNwsyISsynTDRMLERkXhm+2pwt
         WcoM525l7hFml5IG1c6Sv9mN222KiH3NpGDY170U6kb+HDfv/iX9H+UJWfCMf1+YZ2Yq
         3yRA==
X-Gm-Message-State: AOJu0YxBQOB0nqYayoxSiDqB7JOa5XQ/y3Brlj9e9ENs1yswoAbQOAiW
        QoqgDFND7g25Hmyu/OLfPzb32H4Y1mmkL3gjwsVpJS2UKdMlx/Lacpr0WQ==
X-Google-Smtp-Source: AGHT+IGVCtCr21eEdt4tIfAgdEow8iRngkIScUU7nCQAlw9xC6j2AxFQLwF17ebcJCOX84KXLOlsJW8OyMKgkV5yZVk=
X-Received: by 2002:ac8:7f8e:0:b0:40f:dc70:fde2 with SMTP id
 z14-20020ac87f8e000000b0040fdc70fde2mr61719qtj.26.1691695646021; Thu, 10 Aug
 2023 12:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230807111631.3033102-1-john.g.garry@oracle.com> <373e8253-656c-84dc-c05-b578e3725d@os.amperecomputing.com>
In-Reply-To: <373e8253-656c-84dc-c05-b578e3725d@os.amperecomputing.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 10 Aug 2023 12:27:14 -0700
Message-ID: <CAP-5=fVsePTVU2qeeUzVFkWA7Oxj6bgSq+yWzO=t3y283vOgOw@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Raise exception for no definition of a arch
 std event
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     John Garry <john.g.garry@oracle.com>, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 9, 2023 at 10:11=E2=80=AFPM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
>
> Hi John,
>
> On Mon, 7 Aug 2023, John Garry wrote:
> > Recently Ilkka reported that the JSONs for the AmpereOne arm64-based
> > platform included a dud event which referenced a non-existent arch std
> > event [0].
>
> I wish I had found the bug in my patch a long time ago but, in fact, it
> was Dave Kleikamp who initially pointed it out to me and figured out the
> difference between jevents.c and jevents.py when porting the patch to 5.1=
5
> kernel.
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2023-June/844874.ht=
ml
>
> >
> > Previously in the times of jevents.c, we would raise an exception for t=
his.
> >
> > This is still invalid, even though the current code just ignores such a=
n
> > event.
> >
> > Re-introduce code to raise an exception for when no definition exists t=
o
> > help catch as many invalid JSONs as possible.
> >
> > [0] https://lore.kernel.org/linux-perf-users/9e851e2a-26c7-ba78-cb20-be=
4337b2916a@oracle.com/
> >
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
>
> Thanks for the patch! I quickly tested it and it worked as expected. Just
> in case this is needed:
>
> Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Cheers, Ilkka
>
> > ---
> > Please do not apply before [0], above.
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index 8cd561aa606a..98cccc3fcbbd 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -347,12 +347,15 @@ class JsonEvent:
> >       if self.desc and not self.desc.endswith('. '):
> >         self.desc +=3D '. '
> >       self.desc =3D (self.desc if self.desc else '') + ('Unit: ' + self=
.pmu + ' ')
> > -    if arch_std and arch_std.lower() in _arch_std_events:
> > -      event =3D _arch_std_events[arch_std.lower()].event
> > -      # Copy from the architecture standard event to self for undefine=
d fields.
> > -      for attr, value in _arch_std_events[arch_std.lower()].__dict__.i=
tems():
> > -        if hasattr(self, attr) and not getattr(self, attr):
> > -          setattr(self, attr, value)
> > +    if arch_std:
> > +      if arch_std.lower() in _arch_std_events:
> > +        event =3D _arch_std_events[arch_std.lower()].event
> > +        # Copy from the architecture standard event to self for undefi=
ned fields.
> > +        for attr, value in _arch_std_events[arch_std.lower()].__dict__=
.items():
> > +          if hasattr(self, attr) and not getattr(self, attr):
> > +            setattr(self, attr, value)
> > +      else:
> > +        raise argparse.ArgumentTypeError('Cannot find arch std event:'=
, arch_std)
> >
> >     self.event =3D real_event(self.name, event)
> >
> > --
> > 2.35.3
> >
> >
