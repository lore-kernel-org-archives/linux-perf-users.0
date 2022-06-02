Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E56C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Jun 2022 13:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiFBNCL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiFBNCJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Jun 2022 09:02:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96DC201BC
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Jun 2022 06:02:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k19so6373249wrd.8
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jun 2022 06:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8BRxmVh83/7oOS9ziB753MF2kjJx4caRUXZ5QQ/JsSw=;
        b=UHW3hKaPp4VcvGNiWM5hprGivixQ0QV/axF7K3VwJsm94DJKp8FL+o5CzFP0rKz5UW
         rim+LlmX0EcT9ikPrbxPFc/mLP5YcFAbWxYC5SHVZJ6F4+V1MJJUbJ79x8nrGezHRIko
         bN5V4VUlQdprSu6d4nD+iuCl132BtLcVZNlC5WLoik+n2bsqyo1pGvr8V3yu/ETJ1+x8
         9Iekx6YQ4P1Kqoj4V9LnO338o1lswXKNXDpQCTwOKhFKACvARK5oV+sC09Tdt1qfnxIk
         w4nqrJSZ4WZ4JHIaqrYyTSK6z/GTsIW06EeQ4wFqRUNpDcOu26dsGXrN8Km3NkftkXM6
         hsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8BRxmVh83/7oOS9ziB753MF2kjJx4caRUXZ5QQ/JsSw=;
        b=y8wDSrChezFrVo6FAQqmX/Liv9Q7QZYQWfoe4U36eyvtjTSGHUCeHM4PR+P1KdmR7y
         LFUBZGGxDVJWEs3qiVoGVrahaVJki3hbt6fyp9Z7TdPQkB5EVFgbBfv6BzxQhELsW/Lp
         r6ub9fY3QLCCk3Q7py5K6mdbysDWG8YTinfnJx/zfLWlFRQy/pDQULcAFACrt5H7aOeD
         AVQpC7/H7OqM3Mbm8lcARDrMpoqLmB1ohYvvdasE5lXJRCmVe7rS1ghO4S37dZBNkP/z
         ZRXzx8UZw5ijcnbUzYY8Oxcxt3o5uvUm75uqXReBE+HzZA4XU00tTks8NlCUn6DNpXUR
         O2og==
X-Gm-Message-State: AOAM5330DkGkq4utC5PewUgyQJoemSaThDtJQ4TUphznVRm7AEu4TNnM
        MLuH2fMbr7L/HyvPY1G5BRUaEVlhwAIzRvXB1hVO9IrqfOBq1Q==
X-Google-Smtp-Source: ABdhPJzI3PENcq0FmIk5RJU1BCiCoYzznhE/yfdbp5w+G75/YhIZtUX7V8vTPhnCezygvlZYjAVrBfSUYWbooZiWQok=
X-Received: by 2002:adf:f5c4:0:b0:210:2ac2:6aa0 with SMTP id
 k4-20020adff5c4000000b002102ac26aa0mr3589807wrp.300.1654174925154; Thu, 02
 Jun 2022 06:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fUgbaRLkZFPO9fQBkhMM+VFi2r+qf6-zX1GE=SGqMwgAQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUgbaRLkZFPO9fQBkhMM+VFi2r+qf6-zX1GE=SGqMwgAQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Jun 2022 06:01:51 -0700
Message-ID: <CAP-5=fVWWG5e9jf91zgxXcJs8+D5DT=pCZg0UMfc2ph3imyJNg@mail.gmail.com>
Subject: Re: June 2nd - office hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 1, 2022 at 4:52 PM Ian Rogers <irogers@google.com> wrote:
>
> Hi,
>
> Sorry for the late notice, but those who have this on their calendar
> should already have seen it, I plan to hold another office hours at
> 2pm GMT. The around the world times are I believe are the same as last
> time namely:
> China: 10pm
> India: 7:30pm
> Europe: 4pm
> UK: 3pm
> US east coast: 10am
> Brazil: 11am
> US west coast: 7am

A reminder that this is in 1 hour.

Thanks,
Ian

> If you experience problems then my email can be used for Google
> hangout messages, I'll try to be on IRC (#perf on irc.oftc.net).
>
> A reminder that the code of conduct is here:
> https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
> More details from two weeks ago are here:
> https://lore.kernel.org/linux-perf-users/CAP-5=3DfWkxtm5-Ebwkh4pzA83prvuA=
J5yy6CKQYatdkKWu3Tgeg@mail.gmail.com/
>
> The Google meet details are here:
> Linux Perf Tool - Office Hours
> Thursday, June 2 =C2=B7 7:00 =E2=80=93 8:00am PDT
> Google Meet joining info
> Video call link: https://meet.google.com/goj-quks-ydn
> Or dial: =E2=80=AA(US) +1 301-969-4101=E2=80=AC PIN: =E2=80=AA374 496 227=
=E2=80=AC#
> More phone numbers: https://tel.meet/goj-quks-ydn?pin=3D8067739163431
> Notes (ask to be added to see):
> https://docs.google.com/document/d/1tQZvJ12czMedpmLLZWS0XILAte97zdR6H_tgC=
3Ivafs/edit?usp=3Dsharing&resourcekey=3D0-iV9_8Oc0cSOPl0-NvEYDAA
>
> The only agenda item I have is for Google Summer-of-Code review. We
> are in the community bonding period:
> https://developers.google.com/open-source/gsoc/timeline
> where:
> "GSoC contributors get to know mentors, read documentation, get up to
> speed to begin working on their projects"
> so I'm interested to know how we can help the GSoC contributors and
> what milestones they have achieved (downloading the code, building the
> code, making a modification, etc.).
>
> Some thoughts on other topics are:
>  - please review my patch - patches that may have gone unattended on
> LKML and you'd like reviewed
>  - testing - how to better structure tests, incorporate test suites
> like Michael Petlan's:
> https://github.com/rfmvh/perftool-testsuite
> https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2205182311190.29=
735@Diego/
>  - bring your own topic
>
> Thanks and I hope to see you tomorrow,
> Ian
