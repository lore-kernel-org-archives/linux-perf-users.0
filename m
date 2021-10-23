Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBD2C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 23 Oct 2021 15:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E1B6103D
	for <linux-perf-users@archiver.kernel.org>; Sat, 23 Oct 2021 15:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhJWPoc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 23 Oct 2021 11:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJWPob (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 23 Oct 2021 11:44:31 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7669FC061714
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Oct 2021 08:42:12 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id a8so7659386ilj.10
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Oct 2021 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pDUXgDVW1wxzf59mL9Dvd7KHHb2GUCuAlda3xFFQAVo=;
        b=KL9U3u0/L4ttbSf1E7dvW93u/CxtJXzB8lMbk3dXqeEpPX0le1lbKnNTXxPwdoeufl
         s0TceG0V7u2dKPZi0Ze/BfZchilTp6Z7XrBcZq5QYK/hKso2XM/B3yiHXsqov1E9v9dg
         OZS5vv7BVZPsPYty3yab50ErBcy6sGIT6nT/oTI6b5v1Mjtaq//2AZ5K3GuS6HtVG1Ho
         VxVU0s40oBxF5oP+GRgt6clTF3ERnMoBNktT/g69PZFmV3EYPuixYWk3/CLoqVWNeESa
         pkqXw21qU2XZtFC2fxInvOVA6gzY9n+o8D6XYpR6ZW0Bqu6pCwbPTkFtd/zZ2DTb01Tk
         TzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pDUXgDVW1wxzf59mL9Dvd7KHHb2GUCuAlda3xFFQAVo=;
        b=1cg+qXIFihLjCnRGUdEqSSVeD/TWdyBScpSVLfo49tyLefwDjH0vDJOOrZVqiV0Zat
         JrfkZ7TC8/w+KkaxWjhTZpUoTVekFfjtWvua8BojzpVmSIH/321sbLAL2UTNP+09jAmp
         JvtJnLmrMeQq6GG0ogFbjBNrYvBQZW0iJ2U3O+Rlo2rivYJpLejqYXOC0sZHgX2y0rtd
         6yuITN/tDCkfpLR3UnyzWOBUGvV/Zwip2h2fYk6E4gM2LKwhpsnKbjusQXdkgQg0UqCz
         /viUlG+nCxTTaOqwS/1kBM3KaeRlgaTRUsLM3ZxfIAdntecZ54UDY/Zzr3h5ra/eoaqw
         1y6g==
X-Gm-Message-State: AOAM531KD6+kXctqgNMXiB1PS4edASMVCObB+oRj+vWZ7TFpQhIHvXL8
        UnE9dNrcCb1LHLBbMbYWGitVV9PYeb/c4s5ZtzkbjSsYJaE=
X-Google-Smtp-Source: ABdhPJyJjbFVP+2mTzMxWi3AUi2RnJiEF/v/CKf1GGqcjJS4uI0tYUXT2hB9mlSU2lqay/8A6FCldjBsvEHLydKmmOQ=
X-Received: by 2002:a92:5206:: with SMTP id g6mr3934814ilb.232.1635003731837;
 Sat, 23 Oct 2021 08:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAOBGo4xxHeiTVbJ2c0yey+86JxHW7N8uOOD1DSg5T3Z5Uge-6A@mail.gmail.com>
 <20190514220101.GB21157@kernel.org> <CAOBGo4zdETh1OrxvVDymA5QNWsRT9Z=FDFw+SJpk-GzjEnF1Rg@mail.gmail.com>
 <EE0DAC4D-BC60-4C05-AF65-2C2551649BD7@kernel.org> <CAOBGo4z31=vmUG4nJo1tKr+Km9wKD3FfejidWxEPDKD+-1JhZA@mail.gmail.com>
 <CAOBGo4xGB9sOyntHrjMyF6sT9L4Ksg8+yB6K5r+sTQxZK7gy3Q@mail.gmail.com>
In-Reply-To: <CAOBGo4xGB9sOyntHrjMyF6sT9L4Ksg8+yB6K5r+sTQxZK7gy3Q@mail.gmail.com>
From:   Travis Downs <travis.downs@gmail.com>
Date:   Sat, 23 Oct 2021 08:41:35 -0700
Message-ID: <CAOBGo4xZWh=OxqczjDg-WXa66VCFQdCz93m5GDSzXE=-aBGbSg@mail.gmail.com>
Subject: Re: perf report with newest perf not showing jump targets on "most"
 C++ code
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Just keeping the dream alive that this will be fixed one day. It's
still making perf report hard to use in C++.

As noted above it was introduced in 751b1783da784299b0509adb6a9cd3024cc4f83=
7.


On Tue, Jun 25, 2019 at 1:18 PM Travis Downs <travis.downs@gmail.com> wrote=
:
>
> Hi,
>
> Just wondering if there is anything I can do to help move this along.
>
> I guess it hasn't been reported elsewhere yet because this perf
> version hasn't hit the mainsteam, but I guess it will break in a
> widespread way for C++ perf report users when it starts to get
> deployed by the distros.
>
> Cheers,
> Travis
>
>
> On Tue, May 21, 2019 at 8:38 PM Travis Downs <travis.downs@gmail.com> wro=
te:
> >
> > Hi Arnaldo,
> >
> > Yes, --stdio2 worked well (but a bit tricky because --stdio2 was
> > introduced fairly close in the commit stream to this issue)!
> >
> > I bisected it to:
> >
> > 751b1783da784299b0509adb6a9cd3024cc4f837
> > perf annotate: Mark jumps to outher functions with the call arrow
> >
> > Indeed, in the detailed description we have:
> >
> > "... [f]or now lets just make some progress by marking jumps to outside=
 the
> >     current function as call like ..."
> >
> > And empirically I see most jumps being marked as call-like after this
> > change. Note however: with this change I see a middle-ground behavior
> > compared to what I described earlier: all the arrows on the jumps look
> > call-like, but when you select them in report tui it still correctly
> > shows the jump arrow. However, later on (by v4.20 or earlier) this
> > jump indicator disappears too.
> >
> > Here's some reproducing code:
> >
> > ---
> > #include <algorithm>
> > #include <memory>
> > #include <random>
> >
> > const size_t size =3D 10000000;
> >
> > int main() {
> >
> > auto buf =3D std::unique_ptr<uint64_t[]>(new uint64_t[size]);
> >
> > auto b =3D buf.get(), e =3D b + size;
> > std::iota(b, e, 0);
> > std::shuffle(b, e, std::default_random_engine{});
> >
> > clock_t before, after;
> >
> > before =3D clock();
> > std::sort(b, e);
> > after =3D clock();
> >
> > printf("Soring took %5.2f ns/elem\n", (after - before) * 1000000000. /
> > size / CLOCKS_PER_SEC);
> > }
> > ---
> >
> > I compile it with:
> >
> > g++ -O3 -g -march=3Dhaswell -Wall -Wextra -std=3Dc++11  -c bench.cpp
> >
> > If you run `perf annotate --stdio2 --no-source -Mintel` you see somethi=
ng like:
> >
> >              Disassembly of section .text:
> >
> >              0000000000400dc0 <void std::__introsort_loop<unsigned
> > long*, long, __gnu_cxx::__ops::_Iter_less_iter>(unsigned long*,
> > unsigned long*, long, __gnu_cxx::__ops::_Iter_less_iter) [clone
> > .isra.20]
> >              _ZSt16__introsort_loopIPmlN9__gnu_cxx5__ops15_Iter_less_it=
erEEvT_S4_T0_T1_():
> >   0.03         mov    rax,rsi
> >                sub    rax,rdi
> >                cmp    rax,0x87
> >   0.03       =E2=86=92 jle    400f5f <void std::__introsort_loop<unsign=
ed
> > long*, long, __gnu_cxx::__ops::_Iter_less_iter>(unsigned long*,
> > unsigned long*, long, __gnu_cxx::__ops::_Iter_less_iter) [clone
> > .isra.20]+
> >   0.18         push   r14
> >                mov    r14,rdx
> >                push   r13
> >                mov    r13,rdi
> >   0.05         push   r12
> >   0.05         push   rbp
> >                push   rbx
> >                test   rdx,rdx
> >              =E2=86=92 je     400eeb <void std::__introsort_loop<unsign=
ed
> > long*, long, __gnu_cxx::__ops::_Iter_less_iter>(unsigned long*,
> > unsigned long*, long, __gnu_cxx::__ops::_Iter_less_iter) [clone
> > .isra.20]+
> >   0.03         lea    rbp,[rdi+0x10]
> >              _ZSt27__unguarded_partition_pivotIPmN9__gnu_cxx5__ops15_It=
er_less_iterEET_S4_S4_T0_():
> >                sar    rax,0x4
> >   0.15         mov    rcx,QWORD PTR [r13+0x8]
> >              _ZSt16__introsort_loopIPmlN9__gnu_cxx5__ops15_Iter_less_it=
erEEvT_S4_T0_T1_():
> >   0.03         sub    r14,0x1
> >              _ZSt27__unguarded_partition_pivotIPmN9__gnu_cxx5__ops15_It=
er_less_iterEET_S4_S4_T0_():
> >                lea    rdx,[r13+rax*8+0x0]
> >                mov    rdi,QWORD PTR [rsi-0x8]
> >   0.03         mov    rax,QWORD PTR [rdx]
> >              _ZSt22__move_median_to_firstIPmN9__gnu_cxx5__ops15_Iter_le=
ss_iterEEvT_S4_S4_S4_T0_():
> >                cmp    rcx,rax
> >              =E2=86=92 jae    400eb0 <void std::__introsort_loop<unsign=
ed
> > long*, long, __gnu_cxx::__ops::_Iter_less_iter>(unsigned long*,
> > unsigned long*, long, __gnu_cxx::__ops::_Iter_less_iter) [clone
> > .isra.20]+
> >   0.08         cmp    rax,rdi
> >   0.18       =E2=86=92 jb     400ebe <void std::__introsort_loop<unsign=
ed
> > long*, long, __gnu_cxx::__ops::_Iter_less_iter>(unsigned long*,
> > unsigned long*, long, __gnu_cxx::__ops::_Iter_less_iter) [clone
> > .isra.20]+
> >   0.03         cmp    rcx,rdi
> >              =E2=86=92 jae    400ed6 <void std::__introsort_loop<unsign=
ed
> > long*, long, __gnu_cxx::__ops::_Iter_less_iter>(unsigned long*,
> > unsigned long*, long, __gnu_cxx::__ops::_Iter_less_iter) [clone
> > .isra.20]+
> >              _ZSt4swapImEvRT_S1_():
> >   0.10         mov    rdx,QWORD PTR [r13+0x0]
> >
> >
> > Note all the "call-like arrows", even though most of those jumps are
> > nearby in the same function. This function is [clone .isra] so a
> > cloned function with certain values inlined. Maybe annotate/report is
> > having trouble in those cases, thinking the jump is to another
> > function?
> >
> > Cheers,
> > Travis
> >
> >
> > On Wed, May 15, 2019 at 9:38 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > On May 15, 2019 10:04:05 PM GMT-03:00, Travis Downs <travis.downs@gma=
il.com> wrote:
> > > >Hi Arnaldo,
> > > >
> > > >I'll work on a repro case. One issue though: the arrows show up in t=
he
> > > >interactive tui mode, but to git bisect I'd like to script it, so ha=
ve
> > > >some
> > > >arrow indication in --stdio mode: any way to do that?
> > >
> > > Try --stdio2, maybe it's enough.
> > >
> > > - Arnaldo
> > > >
> > > >Cheers,
> > > >Travis
> > > >
> > > >On Tue, May 14, 2019, 5:01 PM Arnaldo Carvalho de Melo <
> > > >arnaldo.melo@gmail.com> wrote:
> > > >
> > > >> Em Sun, May 05, 2019 at 06:58:51PM -0500, Travis Downs escreveu:
> > > >> > For a few months the newest perf (build from Linus' tip) doens't
> > > >show
> > > >> > jump targets in most C++ code for me.
> > > >> >
> > > >> > The arrays on jcc instructions always point to the left, like fo=
r
> > > >> > jumps that can't be resolved, even when the jumps are only a few
> > > >bytes
> > > >> > away.
> > > >> >
> > > >> > I tried to reproduce it on a "simple" C++ looping process, with =
the
> > > >> > same compile flags as my project, but it worked there! So someth=
ing
> > > >is
> > > >> > triggering failure to resolve jump targets.
> > > >> >
> > > >> > Any advice on how to bisect or diagnose this issue would be
> > > >> > appreciated, e.g,. some way to turn on logging to see why perf
> > > >report
> > > >> > fails to resolve jump targets.
> > > >> >
> > > >> > FWIW perf as included in my distribution (perf version 4.15.18)
> > > >works
> > > >> > OK on the same files (it's perf report that matters, not perf
> > > >record)
> > > >> > but doesn't demangle the C++ symbols.
> > > >>
> > > >> Adding this to my backlog, but you could just try to use normal 'g=
it
> > > >> bisect', i.e. find a version that works for a workload you have, t=
hen
> > > >to
> > > >> on rebuilding it till you find the version that introduce the
> > > >problem.
> > > >>
> > > >> If you can send some simple C++ source code that exhibits the
> > > >problem,
> > > >> please do, I'll try to work on this as soon as I process my
> > > >backlog...
> > > >>
> > > >> I just came back from vacation.
> > > >>
> > > >> - Arnaldo
> > > >>
> > >
