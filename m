Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8AEEB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 16:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjFWQXw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 12:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFWQXv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 12:23:51 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A192133
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 09:23:50 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-62ff6cf5af0so7902436d6.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687537429; x=1690129429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szmBtvU5lXtyj4OzmgUm0PHDWxR2d+tKn3pXz8ncz8E=;
        b=aRAUPqnFgbLMBpf2DekdaW9jsksnvmRerBcjk8qHUbUIC8dHTKFDY1XgjrgS2NsRwf
         Ezyafv7xhaxGDUEkMjf09++c/DPhOCJ6Zd3qaMecyiFCqH+neipyJ9CV58PLW0dXsecX
         asgEbevGjIqjshOn85JUec83A499Xawnc+LsLwBOOi1whz660bJSK120A4jvPDSDbwiR
         Al3IBD/N21Jz4LeY3WayiqLIGk4/x6OcH6n4rcZt4qngTr9ktIY3r8X1pY4MlGprPbrz
         e7gTV4YuNpTltfb2IgRy7a1IN6c0YwL2SEMpbL3GeHVOyjF1kKGqMPssbUcXxIpG+38H
         WTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687537429; x=1690129429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szmBtvU5lXtyj4OzmgUm0PHDWxR2d+tKn3pXz8ncz8E=;
        b=i275h5Xs1mQcVBEfHBrq83UjYm4OhniH4NQsKB79WUAp2hcxD6lHVb77y8lob12CwW
         qTwtQNkJlfHt5P06dKB+uGEZj99XlZ8Hx3mzBWEXVizCTiQsQ5Qvrk+UxAxnXUJZA0Uz
         qjlmSRfBkj3MReRdMI+NBwO7mhpufUbX97wHySbKEQYQT34ZLv3UHuRq8ZM99ILCoYAm
         UAXKmTXE4a1IZuFKS/C5sQwyoO0TcHts02TxdCpvKM0FZ4vyxLNksZNvetlBehXWP+4M
         aBsWgxzcnJotOBN19AauUXRXlpgFsCEdf+zPh8NU6wcTPO4zA6pdz0fRkNxgSyNJZG2P
         xGAA==
X-Gm-Message-State: AC+VfDzpt9qWne3njU68dZsDqc2ULFW+hLB8VyOfHzo7J76tLJGSNRDi
        R9snPdS83cZC8yznw6R2AqtiKEnjr8j5dW8xkjRo1ih3zy2mGx0FTVOVmA==
X-Google-Smtp-Source: ACHHUZ50h5cr87B295HLJpaOMx8ZYSZ5fEEsg4wGEripzaequucQavAxMuEpKspTpWcpAghmpT0T2LV5R2pcCPcpkrY=
X-Received: by 2002:a05:6214:20e4:b0:621:83d:3a47 with SMTP id
 4-20020a05621420e400b00621083d3a47mr24483175qvk.39.1687537429318; Fri, 23 Jun
 2023 09:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net> <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
 <CAM9d7chvZjZ4YVc6j3w7OkdHteyJ0GUZboieu9G7jAWBevoZqA@mail.gmail.com>
 <e553c4f8-ed3d-0755-cc8a-b5ffe43b2c2f@amd.com> <CAKwvOdk6TTNhu_+FdONTXPo9Z8u5D4-5kf-rMN8oK4+6fMyc-w@mail.gmail.com>
 <CABPqkBQVfQFJKCdHXEMGFcupzvy8zq14F52eLW5s9vr2Shmi6w@mail.gmail.com>
 <85822c3c-2254-52cc-e6b1-9c89adb63771@amd.com> <CAKwvOdkfEexsE07XXGW3FF+nMt-pR8uv2EA7QzsPbEZsSQBO-Q@mail.gmail.com>
 <85aabdc8-07cd-3285-1f3f-605f9ebbab18@amd.com> <b6a503b7-b421-a5c0-1cc8-4f1567b8d9de@amd.com>
In-Reply-To: <b6a503b7-b421-a5c0-1cc8-4f1567b8d9de@amd.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 23 Jun 2023 09:23:38 -0700
Message-ID: <CAKwvOdmY7qoSG61f7UouWFz+gNN531FhpHbqawrAKCNKNDJHnw@mail.gmail.com>
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Slade Watkins <srw@sladewatkins.net>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Kees Cook <keescook@chromium.org>, sandipan.das@amd.com,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Oct 11, 2022 at 10:05=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.c=
om> wrote:
>
> On 12-Oct-22 9:36 AM, Ravi Bangoria wrote:
> > On 12-Oct-22 3:02 AM, Nick Desaulniers wrote:
> >> On Thu, Oct 6, 2022 at 8:56 PM Ravi Bangoria <ravi.bangoria@amd.com> w=
rote:
> >>>
> >>> +cc: PeterZ
> >>>
> >>>>>>>> +Ravi who may be able to say if there are any issues with the pr=
ecise
> >>>>>>>> sampling on AMD.
> >>>>>>>
> >>>>>>> Afaik cvcles:pp will use IBS but it doesn't support per-task prof=
iling
> >>>>>>> since it has no task context.  Ravi is working on it..
> >>>>>>
> >>>>>> Right.
> >>>>>> https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@am=
d.com
> >>>>>
> >>>>> Cool, thanks for working on this Ravi.
> >>>>>
> >>>>> I'm not sure yet whether I may replace the kernel on my corporate
> >>>>> provided workstation, so I'm not sure yet I can help test that patc=
h.
> >>>>>
> >>>>> Can you confirm that
> >>>>> $ perf record -e cycles:pp --freq=3D128 --call-graph lbr -- <comman=
d to profile>
> >>>>>
> >>>>> works with just that patch applied? Or is there more work required?
> >>>>> What is the status of that patch?
> >>>>>
> >>>>> For context, we had difficulty upstreaming support for instrumentat=
ion
> >>>>> based profile guided optimizations in the Linux kernel.
> >>>>> https://lore.kernel.org/lkml/CAHk-=3DwhqCT0BeqBQhW8D-YoLLgp_eFY=3D8=
Y=3D9ieREM5xx0ef08w@mail.gmail.com/
> >>>>> We'd like to be able to use either instrumentation or sampling to
> >>>>> optimize our builds.  The major barrier to sample based approaches =
are
> >>>>> architecture / micro architecture issues with sample based profile
> >>>>> data collection, and bitrot of data processing utilities.
> >>>>> https://github.com/google/autofdo/issues/144
> >>>>
> >>>> On existing AMD Zen2, Zen3 the following cmdline:
> >>>> $ perf record -e cycles:pp --freq=3D128 --call-graph lbr -- <command=
 to profile>
> >>>>
> >>>> does not work. I see two reasons:
> >>>>
> >>>> 1. cycles:pp is likely converted into IBS op in cycle mode.
> >>>>     Current kernels do not support IBS in per-thread mode.
> >>>>     This is purely a kernel limitation
> >>>
> >>> Right, it's purely a kernel limitation. And below simple patch on top
> >>> of event-context rewrite patch[1] should be sufficient to make cycles=
:pp
> >>> working in per-process mode on AMD Zen.
> >>>
> >>> ---
> >>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> >>> index c251bc44c088..de01b5d27e40 100644
> >>> --- a/arch/x86/events/amd/ibs.c
> >>> +++ b/arch/x86/events/amd/ibs.c
> >>> @@ -665,7 +665,7 @@ static struct perf_ibs perf_ibs_fetch =3D {
> >>>
> >>>  static struct perf_ibs perf_ibs_op =3D {
> >>>         .pmu =3D {
> >>> -               .task_ctx_nr    =3D perf_invalid_context,
> >>> +               .task_ctx_nr    =3D perf_hw_context,
> >>>
> >>>                 .event_init     =3D perf_ibs_init,
> >>>                 .add            =3D perf_ibs_add,
> >>> ---
> >>>
> >>> [1]: https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@=
amd.com
> >>
> >> Hi Ravi,
> >> I didn't see the above diff in
> >> https://lore.kernel.org/lkml/20221008062424.313-1-ravi.bangoria@amd.co=
m/
> >> Was there another distinct patch you were going to send for the above?
> >
> > Yes Nick. I was planning to send it once the rewrite stuff goes in.
>
> Hi Nick,
>
> Since you have practical use case, would it be possible to run your workf=
low
> with perf rewrite and IBS patches applied? It will help us in finding/fix=
ing
> more bugs and upstreaming these changes.

Hi Ravi,
Sorry, I'm not able to load a custom kernel image on my employer
provided workstation, and I never got approval to expense hardware for
testing this otherwise.

Was there ever any update on this? I'm on 6.1.25 now and still cant run
$ perf record -e cycles:pp --call-graph lbr <any command to profile>
$ cat /proc/cpuinfo
...
model name      : AMD Ryzen Threadripper PRO 3995WX 64-Cores
...
--=20
Thanks,
~Nick Desaulniers
