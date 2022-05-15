Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B66C433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 15 May 2022 23:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiEOXhn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 15 May 2022 19:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiEOXhm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 15 May 2022 19:37:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3307B2BB13
        for <linux-perf-users@vger.kernel.org>; Sun, 15 May 2022 16:37:41 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so18306430wrg.12
        for <linux-perf-users@vger.kernel.org>; Sun, 15 May 2022 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uZizrqFLcZjNVCYXDwhmdKxSy77IJEmUg7KSUGMvXqg=;
        b=h/iirt8Lla24soBD+drRXtNMcZMINCxKoPiVIwRJE4+m6hVEfnPCwK03zv7PJ5ju+0
         75aNRhANHAzxbpmddKE6FjOvVpzm/rTmjomf1WYracjjsRweihpfm1yfDpwwxvsGca2t
         kkdouJBjMukCVwZXLY/r8GDvARh/LwgQ+HKQzDqP/bjiuxnVs1rovp3c1ik4dFnRRUt2
         qnWtew4d/87en899+eoztBKVhcuj0nWj+ItXr8C8YWtgC2GhhR2jcVWfEHuEkDSm2FYV
         jvzZqmw0GbLL2VEyjSKjaZWQtlY90pRKvxqUm9LPPR/cWMvVsB1CG6/qu5X3RI+1lqpu
         p9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=uZizrqFLcZjNVCYXDwhmdKxSy77IJEmUg7KSUGMvXqg=;
        b=QkF3CVdMIqTVx8JnhN0AaKxhUnk0oYTqzJO/vvkajXtqoUJ4rNTh6MmxVy/gQST/tV
         eDCnGcaU3fzw2YbvKxEhTd9H8RRvsp2H8/JVKNr+0R3OFZO0J6QeA36DlQLwSkG6lZG6
         u/d+FgYmEgv8dHgenhmuZX8oWz1GILxWXi07+tJl4u0gtSf+CBuox4PKdZT44kXJlgm2
         WIQ9ssAVFq8nxGHERx4ob1SsJqkTuTyT0kAnWBON5HxxuUTmYWvOIVK4tZ5jgKjV19lN
         tZMUElpuM/2LCIEaWrqO5Z2x1Bphieig+Pddqz5KtEZwiw+taSxjrMWh3dJWhlf9CYCa
         QF5g==
X-Gm-Message-State: AOAM532noVEQug+pS55jJqiWa+TkhmpR+wQTMAF74QrTmR7IOMP0S3Mp
        M+hp61rQ/atezp+1hIkU0f3//E8ykM5jwoeC7Jtz2VgDu2TlHQ==
X-Google-Smtp-Source: ABdhPJypJpLs8ysBmMnghXOD+Y5jJCguCofrYvNO4T3b0bChhdBkDb74xHNKhm420mPYvqrq1FP0xP5cwSMGm24Wk/I=
X-Received: by 2002:a5d:674c:0:b0:20d:87e:8d6f with SMTP id
 l12-20020a5d674c000000b0020d087e8d6fmr2128935wrw.40.1652657858890; Sun, 15
 May 2022 16:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWkxtm5-Ebwkh4pzA83prvuAJ5yy6CKQYatdkKWu3Tgeg@mail.gmail.com>
 <CAPS78pqVdNLWD1bAm6ds7D==+sOaL4amLYZ4wiQgT79zC5xprg@mail.gmail.com>
 <CAP-5=fX5Kmdp1LYnaq9y-8ysk=Steo07b-gtiWx=mmTXDbSJnA@mail.gmail.com> <CAP-5=fVjd8oBW4pahww1sYxwWHd7XDgdN3u3WrHM3k9M58MdKA@mail.gmail.com>
In-Reply-To: <CAP-5=fVjd8oBW4pahww1sYxwWHd7XDgdN3u3WrHM3k9M58MdKA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 15 May 2022 16:37:26 -0700
Message-ID: <CAP-5=fW=8hE+5NUAheaD+hnT7oeL+veXN6WpV-QxJ1+r7iS2bw@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

Looking forward to seeing people at our first office hours this
Thursday. 1pm GMT (6am PDT) was too early and so I picked 2pm GMT. If
you'd like to be added to the Google calendar invite let me know,
otherwise the connection details are below:

Linux Perf Tool - Office Hours
Thursday, May 19 =C2=B7 7:00 =E2=80=93 8:00am
Google Meet joining info
Video call link: https://meet.google.com/goj-quks-ydn
Or dial: =E2=80=AA(US) +1 301-969-4101=E2=80=AC PIN: =E2=80=AA374 496 227=
=E2=80=AC#
More phone numbers: https://tel.meet/goj-quks-ydn?pin=3D8067739163431

Thanks,
Ian


On Thu, May 12, 2022 at 9:34 AM Ian Rogers <irogers@google.com> wrote:
>
> I've closed the form. The results ordered from most to least popular
> are (ties are together):
>
> Preferred day of the week:
> Thursday
> Monday or Tuesday
> Friday
> Wednesday
>
> Preferred times:
> 1pm GMT
> 2pm GMT or 3pm GMT or 4pm GMT
> 5pm GMT
>
> Preferred meeting tool:
> Google meet
> Zoom
> Jtisi
>
> As per the GSoC timeline [1] we are requesting our student slots
> today. I'm hoping the office hours are going to be more broadly useful
> than just for GSoC students. 1pm GMT is 6am on the US west coast,
> which may mean we need to use a 2nd choice :-)
>
> Thanks,
> Ian
>
> [1] https://developers.google.com/open-source/gsoc/timeline
>
>
> On Thu, May 5, 2022 at 9:57 AM Ian Rogers <irogers@google.com> wrote:
> >
> > A reminder to help indicate a preference on office hour times and
> > video conference tool. So far the preferences are:
> >  - day of week: Thursday
> >  - time: 1pm GMT, 10am GMT-3, 3pm GMT+2, 6am GMT-7, 6:30pm GMT+5:30, 9p=
m GMT+8
> >  - video conference tool: Google meet
> >
> > Thanks,
> > Ian
> >
> > On Mon, May 2, 2022 at 9:35 AM Tanusree Debnath <tanu235m@gmail.com> wr=
ote:
> > >
> > > Hi,
> > > Thanks for the email. I have taken the survey and selected the times.
> > > Regards,
> > > Tanu
> > >
> > > On Sun, May 1, 2022 at 11:12 AM Ian Rogers <irogers@google.com> wrote=
:
> > > >
> > > > Hi,
> > > >
> > > > We have multiple Google summer-of-code applicants this year, and we=
'd
> > > > like to have a forum where they can discuss their proposal, work,
> > > > problems, etc. with the wider developer community. As such we're
> > > > proposing to set up biweekly office hours. It could be that these
> > > > office hours provide useful for other discussions too. To work out =
the
> > > > best time and video conference tool for this I've created an anonym=
ous
> > > > Google form:
> > > >
> > > > https://forms.gle/WCN19uMjp15bNRJV6
> > > >
> > > > Please help determine the best time and tool by entering what works
> > > > best for you.
> > > >
> > > > Thanks!
> > > > Ian
