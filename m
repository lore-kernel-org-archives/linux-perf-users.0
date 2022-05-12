Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF78FC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 May 2022 16:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbiELQfN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 12 May 2022 12:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351319AbiELQfL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 May 2022 12:35:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D3A20CDA9
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2022 09:35:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so7993694wrg.12
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2022 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7gotrvOd2Ir7jSt+G6TYeb+hhft2tx+dFTRU2yOxAe8=;
        b=THmz1iVPUks0obis6dDJduCtvjnrI08aPA9R4kbusWRiOF9YlfFrtiuPBTLJ1TnOFP
         InnhBzj2FWp1vT5STU5wS6JlFW+6Bu2nOxPmUXsjoz3lpC4Dg9fZnPJJQ3B3+7jR6CnV
         GIUtzmenUjBgCdI25VSvjqX1fCC3rIZvX/alMwABJRiNOp7r4MDJW1HjAi9qh3D50BT+
         pcBVnhESdHgA3u11yx3I9wiLBqzSYce2p5JseXGlQkdXblIz9mBCOlLNeZLh19KLDi9T
         x7jzxT69wLGrTxY3emvR4FT1fxogrcy+ycy7wR6K1uZHhu9CkOo0Y7MnyliJ0gw5HnXb
         lB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7gotrvOd2Ir7jSt+G6TYeb+hhft2tx+dFTRU2yOxAe8=;
        b=1F64n5fI2R16+zowUATb9ze/1lUkk9mFiwK8oB0JhX1D2TgY5Lx+asxNPbV5OouQdJ
         o0S1mrVCukYE2NSQYSxJgTzp6pc2HVAxcDPhqVCk3/8hKO7LLb0pwQvkalntqmd+WGoC
         rhhEKy9xPWzHMMLpd6375PsfJwAOQ0gEKSDVgI3hmXtp++SnuovV/VOQ2emq3UAgj1XM
         uEEALrbeNRX4pa/xsfoIraDA8D3eeJ9qe+/77W/BMpdke8iU7zG4aMwZoSOkyc2+QqUe
         a+okPqdf2PGWrytSvYsCKIOXG95jaTEB7J3SHt8Po3aCc3/v6V5C2ln2LJHaxwTYDsxC
         23Vw==
X-Gm-Message-State: AOAM5308OJIyUU7zyMXKFNslgBunWa7I3IfqzyVlD4BuNeoCGoert2iF
        YEQFjFZXkFqqM0EkwAvonT5JC+1f3wEKx4Uj13x56bHtOBo=
X-Google-Smtp-Source: ABdhPJyBISaqTd31cFRnmd2CNxdxJWcWAj2/x4753D0zyNrl1dq0gMZ2fMc+Y4nttFBjJ7GMSzPDS7VDQFkL/89yoAA=
X-Received: by 2002:adf:dd0e:0:b0:20a:c689:f44a with SMTP id
 a14-20020adfdd0e000000b0020ac689f44amr473247wrm.40.1652373306526; Thu, 12 May
 2022 09:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWkxtm5-Ebwkh4pzA83prvuAJ5yy6CKQYatdkKWu3Tgeg@mail.gmail.com>
 <CAPS78pqVdNLWD1bAm6ds7D==+sOaL4amLYZ4wiQgT79zC5xprg@mail.gmail.com> <CAP-5=fX5Kmdp1LYnaq9y-8ysk=Steo07b-gtiWx=mmTXDbSJnA@mail.gmail.com>
In-Reply-To: <CAP-5=fX5Kmdp1LYnaq9y-8ysk=Steo07b-gtiWx=mmTXDbSJnA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 12 May 2022 09:34:51 -0700
Message-ID: <CAP-5=fVjd8oBW4pahww1sYxwWHd7XDgdN3u3WrHM3k9M58MdKA@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I've closed the form. The results ordered from most to least popular
are (ties are together):

Preferred day of the week:
Thursday
Monday or Tuesday
Friday
Wednesday

Preferred times:
1pm GMT
2pm GMT or 3pm GMT or 4pm GMT
5pm GMT

Preferred meeting tool:
Google meet
Zoom
Jtisi

As per the GSoC timeline [1] we are requesting our student slots
today. I'm hoping the office hours are going to be more broadly useful
than just for GSoC students. 1pm GMT is 6am on the US west coast,
which may mean we need to use a 2nd choice :-)

Thanks,
Ian

[1] https://developers.google.com/open-source/gsoc/timeline


On Thu, May 5, 2022 at 9:57 AM Ian Rogers <irogers@google.com> wrote:
>
> A reminder to help indicate a preference on office hour times and
> video conference tool. So far the preferences are:
>  - day of week: Thursday
>  - time: 1pm GMT, 10am GMT-3, 3pm GMT+2, 6am GMT-7, 6:30pm GMT+5:30, 9pm GMT+8
>  - video conference tool: Google meet
>
> Thanks,
> Ian
>
> On Mon, May 2, 2022 at 9:35 AM Tanusree Debnath <tanu235m@gmail.com> wrote:
> >
> > Hi,
> > Thanks for the email. I have taken the survey and selected the times.
> > Regards,
> > Tanu
> >
> > On Sun, May 1, 2022 at 11:12 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Hi,
> > >
> > > We have multiple Google summer-of-code applicants this year, and we'd
> > > like to have a forum where they can discuss their proposal, work,
> > > problems, etc. with the wider developer community. As such we're
> > > proposing to set up biweekly office hours. It could be that these
> > > office hours provide useful for other discussions too. To work out the
> > > best time and video conference tool for this I've created an anonymous
> > > Google form:
> > >
> > > https://forms.gle/WCN19uMjp15bNRJV6
> > >
> > > Please help determine the best time and tool by entering what works
> > > best for you.
> > >
> > > Thanks!
> > > Ian
