Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D06EC43334
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Jun 2022 23:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiFAXwl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Jun 2022 19:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiFAXwj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Jun 2022 19:52:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB7426A0BB
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Jun 2022 16:52:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k36-20020a05600c1ca400b0039c2a3394caso214896wms.2
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jun 2022 16:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=X/VFqt1oB9dbnmFBmCgi4ywLQM2V0PTEoAnqKjWsR9Q=;
        b=r6s+CYMdNFtIDz0qA6tpudH0yB2fKbwpR9tePS1sjhKI+Zsjt7TjXJ8wUgqGFuLu6C
         woZdrT5s2G+LlLlqhSGyOokayEpBZ1c+LHHohD2IUdptB4x6iQw+h7f1ZAxLIHU1FITI
         JfIsfMQKTy/AfJIFo4FJXEbtr1iTpVXxJDaoUiRgUiJecMQkbJap1qJ91yq0htSgBsIW
         SZFpcV9R1zmtAu4hucIn7iCe25oOjoIpv0Szufg2wgkobbshSu6IvMkzkEXdtW3koSJG
         QgAAs1tnoJzUZeNB1xofM2T7F+IzlBiv6QZv7jUXikFq47+DJaSC7WSXf6FzH2CnW0wB
         lCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=X/VFqt1oB9dbnmFBmCgi4ywLQM2V0PTEoAnqKjWsR9Q=;
        b=7xtI/97HvGObJ+WmHvRtBQntcefu5Jf48rpca1ywKeN/Iz5719F+4dGNHw9ArNGiq0
         BvSatpS3ap/Wh8ZsiYYYqSP4tExXzYFnVU29KUS+AZWYKtYShYel5cJ5c4iWZVTLbkeJ
         A+Up6a88TWlb/wYx8S32RN6n00QKNfAN36tL15T1o76jDgMNkJtHL5l0d+wG0Y6c/jvW
         lP9mRlIyYkfd0mDTTTpDDDifDPvPs8oL/pnjFmwMR9K79wIlbZx4fblMyjo1YlS+iYGd
         JWidhngC1auicoRXw9nJut/HRUe0Lvbv/b+0YZHOEAb9rh9CQU8RxSlpghL5mG2+Hr2W
         bgXQ==
X-Gm-Message-State: AOAM533Z5IlkLaHuYEzyOP4qGk45UCecZZV4nelzw+qSig3cl6NZFyUT
        bAX8dAL41vTHm+qWlJfOZMnY9g9xNQ33o0jH8wGkzfWghoW2KQg4
X-Google-Smtp-Source: ABdhPJzDiJFAtv9lJy70SmrCZBY8ttiSpupoxbXrkZKF99rOi9u8uCXdonoYDggQ/5G3eEK/o6JQie0lynGa8C26Pn4=
X-Received: by 2002:a7b:c015:0:b0:397:3685:5148 with SMTP id
 c21-20020a7bc015000000b0039736855148mr1554794wmb.174.1654127556288; Wed, 01
 Jun 2022 16:52:36 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 1 Jun 2022 16:52:23 -0700
Message-ID: <CAP-5=fUgbaRLkZFPO9fQBkhMM+VFi2r+qf6-zX1GE=SGqMwgAQ@mail.gmail.com>
Subject: June 2nd - office hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

Sorry for the late notice, but those who have this on their calendar
should already have seen it, I plan to hold another office hours at
2pm GMT. The around the world times are I believe are the same as last
time namely:
China: 10pm
India: 7:30pm
Europe: 4pm
UK: 3pm
US east coast: 10am
Brazil: 11am
US west coast: 7am

If you experience problems then my email can be used for Google
hangout messages, I'll try to be on IRC (#perf on irc.oftc.net).

A reminder that the code of conduct is here:
https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
More details from two weeks ago are here:
https://lore.kernel.org/linux-perf-users/CAP-5=3DfWkxtm5-Ebwkh4pzA83prvuAJ5=
yy6CKQYatdkKWu3Tgeg@mail.gmail.com/

The Google meet details are here:
Linux Perf Tool - Office Hours
Thursday, June 2 =C2=B7 7:00 =E2=80=93 8:00am PDT
Google Meet joining info
Video call link: https://meet.google.com/goj-quks-ydn
Or dial: =E2=80=AA(US) +1 301-969-4101=E2=80=AC PIN: =E2=80=AA374 496 227=
=E2=80=AC#
More phone numbers: https://tel.meet/goj-quks-ydn?pin=3D8067739163431
Notes (ask to be added to see):
https://docs.google.com/document/d/1tQZvJ12czMedpmLLZWS0XILAte97zdR6H_tgC3I=
vafs/edit?usp=3Dsharing&resourcekey=3D0-iV9_8Oc0cSOPl0-NvEYDAA

The only agenda item I have is for Google Summer-of-Code review. We
are in the community bonding period:
https://developers.google.com/open-source/gsoc/timeline
where:
"GSoC contributors get to know mentors, read documentation, get up to
speed to begin working on their projects"
so I'm interested to know how we can help the GSoC contributors and
what milestones they have achieved (downloading the code, building the
code, making a modification, etc.).

Some thoughts on other topics are:
 - please review my patch - patches that may have gone unattended on
LKML and you'd like reviewed
 - testing - how to better structure tests, incorporate test suites
like Michael Petlan's:
https://github.com/rfmvh/perftool-testsuite
https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2205182311190.2973=
5@Diego/
 - bring your own topic

Thanks and I hope to see you tomorrow,
Ian
