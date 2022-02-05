Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5F5C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Feb 2022 00:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiBEAA3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Feb 2022 19:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378611AbiBEAAS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Feb 2022 19:00:18 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0237DDF8BD87
        for <linux-perf-users@vger.kernel.org>; Fri,  4 Feb 2022 16:00:18 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id m6so23165311ybc.9
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Feb 2022 16:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fajrXbA8oBUip2Cl5D2abOhYOIGlO4AlvNzT7UdfDXk=;
        b=RoBzObdOTTexQ15+9P0ldzjSdMPYBbCqrW8UhJUHaNVSQixSBbU35sODVhItGZBA5T
         yJELQctyf611MXXe5EhzKGGkWxJSZ0jHLgR0KZWNlChg1GD4Ne1YfH/c7wxdx8m6ksUM
         4sJh7SSIBt69UmpdZRIg4xyKtR4HM7sCVmsFqBG5uwV46C7UDQodzoELBMPpITICfhOF
         DjtuiY+8OM6yiS9hjEzrxhk3uzlh8H1RS3PUPvDmgylofpnlF04ycpEB1C0bSH55JQYf
         7LcOKzLpgu3D/fUXRHdTIAbHNfYFIjq4n3wV8UjqF1CYxrLApADBs3ENkOLP9V7XZ7E9
         /k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=fajrXbA8oBUip2Cl5D2abOhYOIGlO4AlvNzT7UdfDXk=;
        b=yamhsDRSw/9K6gV2yZXxMbIHwkMdZmT3wVaGDfxThX+YdYynGVJaNCgeWl7Asnva8L
         wNHvuBQAZPIyv1Gmd17qHE36SwrVI2V2dX5e+1OxYIITEEiyCvFth71EPngZNjTvnlmG
         HpZ6sOW1s7ypPvPul+aNAq1g+jHSMIBXto2yEI0zWEI/bJ0l6jJBdqczHgSu1EKF1cTf
         YEpdLZTB9jlNZsgPt2tD48PcAZH7p5/iN0AhGBHlj1J9jF9Tqx9+IIIJ9k2Sp7p8ejN7
         131aWBxZ+WWJfCKZY6xmC6UcnO9sRLOceyiJ5Qa8yCOLstfXdrvbmBeJFpvLaH6qjG+W
         vpgQ==
X-Gm-Message-State: AOAM530qQJ3tzvhdk84iPt86fuaeGallOm/MPBnG9yO19TnWbNhxZsUh
        JKDES5sH7duM2WBSj2PwCdNPakILa3MnXL8JPd1YcziS4PQ=
X-Google-Smtp-Source: ABdhPJx/kpEs40PPshfJF4bG7qo+g9Y5wB463TEA9sfzMWcU5X2lH8i4RGYlNmcaI2rmLICY/91DJDTvoqZYUQCzrEo=
X-Received: by 2002:a5b:b84:: with SMTP id l4mr1597448ybq.665.1644019216717;
 Fri, 04 Feb 2022 16:00:16 -0800 (PST)
MIME-Version: 1.0
References: <802c5ec0-dc3b-bab9-20f5-59be612a46f8@gmail.com> <CAP-5=fVYqS74t_UJ_dQaQE8FHWNYSHuYqVaWb-BfhewMCCbFaA@mail.gmail.com>
In-Reply-To: <CAP-5=fVYqS74t_UJ_dQaQE8FHWNYSHuYqVaWb-BfhewMCCbFaA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 4 Feb 2022 16:00:00 -0800
Message-ID: <CAP-5=fWAbBBHhqqZ5u5B8GiCb=7V6oACZnecQF3zOWMnV5YCDw@mail.gmail.com>
Subject: Re: Google Summer of Code 2022 - Project ideas page for the Linux
 Foundation online
To:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A reminder that on Monday (February 7) the application period for
mentoring organizations for the Google Summer of Code 2022 will start.
Please volunteer to mentor or suggest projects.

Thanks,
Ian
On Thu, Jan 27, 2022 at 9:56 AM Ian Rogers <irogers@google.com> wrote:
>
> TL;DR please consider being a GSoC mentor and contributing project ideas.
>
> Hi,
>
> Last year Riccardo Mancini made great contributions to the perf code
> base [1]! Riccardo's mentors were Arnaldo, Namhyung and myself, with 1
> hour weekly meetings and patches that needed review. The project was
> administered by the Linux Foundation. I consider Riccardo's work last
> year really useful and a great contribution, so I'm keen that the
> Linux perf tool/subsystem can participate in the Google Summer of Code
> again this year.
>
> This year Google Summer of Code has changed, operating within the
> Linux Foundation means following how their administrators want to run
> things. Notable improvements/changes are [2]:
>  - Contributors, not only students: From now on it is not required any
> more to be a university/college student to code for GSoC. Anyone 18
> years old and older can do.
>  - Two project sizes: 16 GSoCs with ~350-hour projects, then one with
> ~175-hour projects, some tasks fit better into one size others into
> the other, no one-size-fits-all. Now we can have both. The
> organizations can select from these two sizes for each project idea
> they offer.
>  - Coding period flexibility: Before, there was a fixed time period of
> ~3 months in which the projects had to be done, also with fixed dates
> for the 2 or 3 evaluations. From 2022 on the period can be extended to
> 22 weeks on agreement between mentor and contributor, should there be
> some interruptions like exams, trips, sickness, different dates of
> mid-year break, =E2=80=A6 This gives more people the chance to be able to
> participate.
>
> To make sure we get great applicants we need great projects and
> mentors. We need to refresh the project page that was copied over from
> last year:
> https://wiki.linuxfoundation.org/gsoc/2022-gsoc-perf
> There are often things that come up on the mailing list that could be
> projects. For example, better programming language support [3],
> reference count sanity checking [4] and new features like function
> latency histograms [5] where BPF has opened up new possibilities.
> There may also be areas of tech debt that you'd like to see cleaned
> up.
>
> Please consider volunteering to be a mentor or just suggesting your
> ideas. For convenience probably the easiest way to do that is by
> replying to this e-mail on the linux-perf-users mailing list.
>
> Thanks!
> Ian
>
> [1] https://lore.kernel.org/linux-perf-users/3c4f8dd64d07373d876990ceb16e=
469b4029363f.camel@gmail.com/
> [2] https://wiki.linuxfoundation.org/gsoc/google-summer-code-2022
> [3] https://lore.kernel.org/linux-perf-users/87o85ftc3p.fsf@smart-cactus.=
org/
> [4] https://lore.kernel.org/linux-perf-users/20220125204602.4137477-1-iro=
gers@google.com/
> [5] https://lore.kernel.org/all/20211129231830.1117781-1-namhyung@kernel.=
org/
>
> ---------- Forwarded message ---------
> From: Till Kamppeter <till.kamppeter@gmail.com>
> Date: Wed, Jan 26, 2022 at 11:08 AM
> Subject: Google Summer of Code 2022 - Project ideas page for the Linux
> Foundation online
>
> Hi,
>
> the Linux Foundation will apply again as mentoring organization in this
> year's Google Summer of Code.
>
> Note that GSoC 2022 will be different again, code contributors do not
> need to be students, choice between 3-month=C2=B4s full-time or half-time
> projects, more flexibility of when coding takes place.
>
> On February 7, 2022 the application period for mentoring organizations
> for the Google Summer of Code 2022 will start.
>
> To be successful, we need a rich project idea list so that we will get
> selected by Google.
>
> I have set up a page for project ideas for the Linux Foundation's
> participation in the Google Summer of Code 2022:
>
> https://wiki.linuxfoundation.org/gsoc/google-summer-code-2022
>
> Please add your ideas to the sub-page of your work group. Also remove
> project ideas which are already done in one of the previous years or not
> needed any more and make sure that all contact info is up-to-date and
> all links are working.
>
> Make sure to not talk about "students", but about "contributors"
> instead. I have, at least partially, taken care of this when I have
> copied your sub-group pages from last year.
>
> Also make sure to remove the "**Still needs to get updated!!**" phrase
> after having updated your project ideas.
>
> If you have problems mail me with your project ideas and other editing
> wishes.
>
> The ideas list is in the Linux Foundation Wiki. If you want to edit and
> did not have the edit rights already from previous years, please tell me
> and I give you edit rights. I need your Linux Foundation user name for
> that and the e-mail address associated with this account for this.
>
> Please also take into account that the deadline for our application as
> mentoring organization is Feb 21 and after that Google will evaluate the
> applications. So have your ideas (at least most of them, ideas can be
> posted up to the student application deadline) in by then to raise our
> chances to get accepted.
>
> Please also tell us if you do not want to participate any more with your
> workgroup, so that we can remove your sub-page.
>
>     Till
