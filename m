Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7BFC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 13:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiESNE4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 May 2022 09:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiESNEz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 May 2022 09:04:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56FC67D2D
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 06:04:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r23so7119440wrr.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PHmOidkQleCmLKUsLNPQqbimlA4yhd5Bxhu51HLTL60=;
        b=ozULuayu7HJqaNhaYlLw8Ndxx/u81RrGvml4++qBtYDd+cksqPNaOgRF1+nWn2QOxI
         LP1eebEBfJ0kUPg31ChYkC5kolo8XQKy7qMWe7y3LPVZM6IO37BxxDBAcPjrekcC0l1o
         asfpwwbgTKOrPucqXj98lv8tl5goDD4Q6NjNFaLW/MCKITFASzvf3lVNeV4/8zzRF9UI
         vcVcVw753kSEySiY5+lLmtwc9DEyvcDLWpd/qS4KCNTzh1dEZShmMc9lkEuWp4fauNFF
         UITrWQ0tyyJ6b7FUAaKuS6os23vqivxuj97+BEVPlfALp6XsGNqPbKl3sSUVKAgXqOoR
         iPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=PHmOidkQleCmLKUsLNPQqbimlA4yhd5Bxhu51HLTL60=;
        b=W7imYtaQ1RxRf1Y3DRcuftZRaHponaN/y7guwGRdxfcsbv5ptzNSVOu7e5OWYSmK27
         xhoyEyKKe9qg+WDYv+eF/EbzlSerzWngeUZZm6qUYoX6MmWia2XE44ePkWe0Vu8eHVnr
         uch+2a8T0eJ0DG2nUh8gCYtb7SvPKKSHuYRKiWwo2F3LYXa8yJgvMcESak9KT0kZxNAr
         VErBeA9Sx/q8LZVj/VA7pOPnD4YJtfzqKG5KUlX+SUc5eMW0XwiIuZWnvn7j55S6og/T
         uxI3LkVgzn4cad1GdtOUAak4F/FPde//VqBWasC74krHtWlYVDkvb198w8mFJwwdbKW8
         7NQg==
X-Gm-Message-State: AOAM533mC0Tcn9RoDfs43cnzhocrxV1QfFReUXzmzBVYNIj5L7tP73eR
        jeZHKOCu7vijESuf+esp2vlyQ03/tfTisY8p8OmRgQM4IFQ=
X-Google-Smtp-Source: ABdhPJxX331ZlsXheEaC98Wu8x/UyAGOxyLMLItWEghz5J/mZViFKD3q+Nys1neOYRQxZByp2GaefrY/gFLpo293OHY=
X-Received: by 2002:a5d:674c:0:b0:20d:87e:8d6f with SMTP id
 l12-20020a5d674c000000b0020d087e8d6fmr4003655wrw.40.1652965491165; Thu, 19
 May 2022 06:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWkxtm5-Ebwkh4pzA83prvuAJ5yy6CKQYatdkKWu3Tgeg@mail.gmail.com>
 <CAPS78pqVdNLWD1bAm6ds7D==+sOaL4amLYZ4wiQgT79zC5xprg@mail.gmail.com>
 <CAP-5=fX5Kmdp1LYnaq9y-8ysk=Steo07b-gtiWx=mmTXDbSJnA@mail.gmail.com>
 <CAP-5=fVjd8oBW4pahww1sYxwWHd7XDgdN3u3WrHM3k9M58MdKA@mail.gmail.com>
 <CAP-5=fW=8hE+5NUAheaD+hnT7oeL+veXN6WpV-QxJ1+r7iS2bw@mail.gmail.com> <CAP-5=fVwTgh7xMTjnU7o9GiZcbhESKNwn3U=R=Ots_V9VwWb8Q@mail.gmail.com>
In-Reply-To: <CAP-5=fVwTgh7xMTjnU7o9GiZcbhESKNwn3U=R=Ots_V9VwWb8Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 May 2022 06:04:37 -0700
Message-ID: <CAP-5=fV70jGRpCX=05WwLDQanhnB9FuS62vEy+FC248c=GAYeA@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A reminder that this is in 1 hour.

Thanks,
Ian

On Wed, May 18, 2022 at 9:17 AM Ian Rogers <irogers@google.com> wrote:
>
> A reminder that our first "office hours" are tomorrow at 2pm GMT,
> which I believe translates to these times around the world:
> China: 10pm
> India: 7:30pm
> Europe: 4pm
> UK: 3pm
> US east coast: 10am
> Brazil: 11am
> US west coast: 7am
> I expect there could be problems connecting and so I'll be logged into
> the IRC (#perf on irc.oftc.net).
>
> My expectation is we'll speak in English but we should be mindful that
> this will be hard for people who don't get a lot of practice speaking
> English. Don't be afraid to raise a hand if you don't understand
> something. There may be someone else on the call who can help with a
> translation :-)
>
> It goes without saying but please be aware of the Linux contributor
> covenant code of conduct:
> https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
> Arnaldo will be on the call and is the maintainer.
>
> Agenda wise I think introductions would be nice and then we hope for
> the Google Summer-of-Code applicants to speak about their projects -
> what the project is, their plan and timeline. This will doubtless
> solicit feedback from people who've worked on Linux's perf tool for
> longer. People may have hot topics they'd like to bring up and if time
> allows we can discuss these. I'd also like to discuss (if we have
> time) the office hours itself, how can we make them useful, how
> frequently to have them, perhaps we can get invited speakers, etc.
>
> Thanks in advance and I'm looking forward to seeing everyone,
> Ian
>
> On Sun, May 15, 2022 at 4:37 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Hi,
> >
> > Looking forward to seeing people at our first office hours this
> > Thursday. 1pm GMT (6am PDT) was too early and so I picked 2pm GMT. If
> > you'd like to be added to the Google calendar invite let me know,
> > otherwise the connection details are below:
> >
> > Linux Perf Tool - Office Hours
> > Thursday, May 19 =C2=B7 7:00 =E2=80=93 8:00am
> > Google Meet joining info
> > Video call link: https://meet.google.com/goj-quks-ydn
> > Or dial: =E2=80=AA(US) +1 301-969-4101=E2=80=AC PIN: =E2=80=AA374 496 2=
27=E2=80=AC#
> > More phone numbers: https://tel.meet/goj-quks-ydn?pin=3D8067739163431
> >
> > Thanks,
> > Ian
> >
> >
> > On Thu, May 12, 2022 at 9:34 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > I've closed the form. The results ordered from most to least popular
> > > are (ties are together):
> > >
> > > Preferred day of the week:
> > > Thursday
> > > Monday or Tuesday
> > > Friday
> > > Wednesday
> > >
> > > Preferred times:
> > > 1pm GMT
> > > 2pm GMT or 3pm GMT or 4pm GMT
> > > 5pm GMT
> > >
> > > Preferred meeting tool:
> > > Google meet
> > > Zoom
> > > Jtisi
> > >
> > > As per the GSoC timeline [1] we are requesting our student slots
> > > today. I'm hoping the office hours are going to be more broadly usefu=
l
> > > than just for GSoC students. 1pm GMT is 6am on the US west coast,
> > > which may mean we need to use a 2nd choice :-)
> > >
> > > Thanks,
> > > Ian
> > >
> > > [1] https://developers.google.com/open-source/gsoc/timeline
> > >
> > >
> > > On Thu, May 5, 2022 at 9:57 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > A reminder to help indicate a preference on office hour times and
> > > > video conference tool. So far the preferences are:
> > > >  - day of week: Thursday
> > > >  - time: 1pm GMT, 10am GMT-3, 3pm GMT+2, 6am GMT-7, 6:30pm GMT+5:30=
, 9pm GMT+8
> > > >  - video conference tool: Google meet
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > On Mon, May 2, 2022 at 9:35 AM Tanusree Debnath <tanu235m@gmail.com=
> wrote:
> > > > >
> > > > > Hi,
> > > > > Thanks for the email. I have taken the survey and selected the ti=
mes.
> > > > > Regards,
> > > > > Tanu
> > > > >
> > > > > On Sun, May 1, 2022 at 11:12 AM Ian Rogers <irogers@google.com> w=
rote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > We have multiple Google summer-of-code applicants this year, an=
d we'd
> > > > > > like to have a forum where they can discuss their proposal, wor=
k,
> > > > > > problems, etc. with the wider developer community. As such we'r=
e
> > > > > > proposing to set up biweekly office hours. It could be that the=
se
> > > > > > office hours provide useful for other discussions too. To work =
out the
> > > > > > best time and video conference tool for this I've created an an=
onymous
> > > > > > Google form:
> > > > > >
> > > > > > https://forms.gle/WCN19uMjp15bNRJV6
> > > > > >
> > > > > > Please help determine the best time and tool by entering what w=
orks
> > > > > > best for you.
> > > > > >
> > > > > > Thanks!
> > > > > > Ian
