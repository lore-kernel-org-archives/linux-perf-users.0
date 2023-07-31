Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41970C001E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 Jul 2023 15:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjGaPLP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 Jul 2023 11:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGaPKx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 Jul 2023 11:10:53 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5DB1725
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jul 2023 08:10:29 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40a47e8e38dso505441cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jul 2023 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690816225; x=1691421025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMmlT4xiGpOtC9VGm+XQXDU04xNWVwR28wOF8+RMY3s=;
        b=Y++IoCt4DRCFsvq0LcA2oo34SeicYFBVj7wGzcX/2KR+FrOmMIXEoAA0UUrnTXuM5l
         kG0d//PFEOd4YhsdzpGS3We2jvMrcURWB0Nl4WgdK+0/egyXYEIhbczttmN9c6j0yEls
         VyB5KKxCA0oAZ1zRHYqcVKQVo75Zdrw5iG12PAwDkb/Q0L94PoYf8idDKGtzFzKG8Hdg
         z4fYwAFuBHfWoAdfnh1i4qnMkgFdZAUxbJx+bUpGncVKjfC47HFf+bhts8PnoXJz5ehl
         8EqxeyW2oiWnWSY9alCF/zWuNY9qcZKhg3kAEcfUHfVSGCeUa2tyXQK5eOYJGEn7jpqt
         umIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690816225; x=1691421025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMmlT4xiGpOtC9VGm+XQXDU04xNWVwR28wOF8+RMY3s=;
        b=d1YzMcJE9Xr52Qo4EjiG6WBOrIypxmgvI2rfb7ZBqOFOSMvnnkdd8JqLbfXO+H3JO8
         9tu9+f1CBqxdMOM2wONbSC+L+pGbg+7SsLhAs5BqDbcbJco7AkOTK70mUz/B2tKoncFS
         op7+ItkhFc9PZQNXaVBfWmlQ2LceK1MS8BIjWJuvAWyY1aghn0RBWqnp5U2iKsuuurf9
         9xV8RwdNGfgo54TSb9flvKe4s92C/eGWs3oLkSFNnPjWwJ42+1aZ2+trbVVnCEXax1Qn
         aSNDja3CBDFcL+2fmzMzCO+IzjZDc9qSn1knFOJaZeeHfOxb22JU1c1/HlVK4UjC95tY
         uKJQ==
X-Gm-Message-State: ABy/qLZ6tLU6XCd4Z9foXeVwg+gPKGlpXeelZOSFWYCOaPInZAvIl4SU
        xIJYvY4dF6NDtvpVy2RVSGF9hgdWH0C0IqGReLPHog==
X-Google-Smtp-Source: APBJJlF80g4PGoUsmWgES6Mx7Q1A6B085YSp8JisqMkb362UzUiQDX1a393xdAlG961DXd2bHAapUHeUGEeS7d31Wfk=
X-Received: by 2002:a05:622a:188b:b0:403:a43d:bd7d with SMTP id
 v11-20020a05622a188b00b00403a43dbd7dmr426388qtc.4.1690816224935; Mon, 31 Jul
 2023 08:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
 <20230727141428.962286-10-alexghiti@rivosinc.com> <CAP-5=fU5XYXrVnRUidpwjV2LiTsdebfidL43_Qo4Z7TBxMsVGA@mail.gmail.com>
 <CAHVXubgVAe1WsiZx5Ay+3KPK4u24k_vsnTwFFmBeVsHrGXwhfw@mail.gmail.com> <CAHVXubj80rQRShuDS09BeTrfR6nux0A68EMWLbeat8fd_Y3YdA@mail.gmail.com>
In-Reply-To: <CAHVXubj80rQRShuDS09BeTrfR6nux0A68EMWLbeat8fd_Y3YdA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 31 Jul 2023 08:10:12 -0700
Message-ID: <CAP-5=fWwzuGZ6a6Z38ndsb7gw7_uwS0a2VGXx08hMeiK8eZ91w@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] tools: lib: perf: Implement riscv mmap support
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 31, 2023 at 3:27=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> On Mon, Jul 31, 2023 at 12:15=E2=80=AFPM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
> >
> > Hi Ian,
> >
> > On Fri, Jul 28, 2023 at 7:53=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Thu, Jul 27, 2023 at 7:28=E2=80=AFAM Alexandre Ghiti <alexghiti@ri=
vosinc.com> wrote:
> > > >
> > > > riscv now supports mmaping hardware counters so add what's needed t=
o
> > > > take advantage of that in libperf.
> > > >
> > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> > > > ---
> > > >  tools/lib/perf/mmap.c | 65 +++++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 65 insertions(+)
> > > >
> > > > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > > > index 0d1634cedf44..378a163f0554 100644
> > > > --- a/tools/lib/perf/mmap.c
> > > > +++ b/tools/lib/perf/mmap.c
> > > > @@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int coun=
ter)
> > > >
> > > >  static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); =
}
> > > >
> > > > +#elif __riscv_xlen =3D=3D 64
> > >
> > > This is something of an odd guard, perhaps:
> > > #elif defined(__riscv) && __riscv_xlen =3D=3D 64
> > >
> > > That way it is more intention revealing that this is riscv code. Coul=
d
> > > you add a comment relating to the __riscv_xlen ?
> >
> > I guess Andrew answered that already.
> >

Not sure. I still think it looks weird:
...
#if defined(__i386__) || defined(__x86_64__)
...
#elif defined(__aarch64__)
...
#elif __riscv_xlen =3D=3D 64
...
#else
static u64 read_perf_counter(unsigned int counter __maybe_unused) { return =
0; }
static u64 read_timestamp(void) { return 0; }
#endif

The first two are clearly #ifdef-ing architecture specific assembly
code, under what conditions I get RISC-V code  =C2=AF\(=E3=83=84)/=C2=AF At=
 least worth
a comment like "csrr is only available when you have xlens of 64
because ..."

> > >
> > > > +
> > > > +/* TODO: implement rv32 support */
> > > > +
> > > > +#define CSR_CYCLE      0xc00
> > > > +#define CSR_TIME       0xc01
> > > > +
> > > > +#define csr_read(csr)                                          \
> > > > +({                                                             \
> > > > +       register unsigned long __v;                             \
> > > > +               __asm__ __volatile__ ("csrr %0, " #csr          \
> > > > +                : "=3Dr" (__v) :                                 \
> > > > +                : "memory");                                   \
> > >
> > > To avoid the macro pasting that could potentially go weird, could thi=
s be:
> > >
> > > __asm__ __volatile__ ("csrr %0, %1",
> > >   : "=3Dr"(__v) /* outputs */
> > >   : "i"(csr) /* inputs */
> > >   : "memory" /* clobbers */)
>
> Forgot to answer this one: it compiles, but I have to admit that I
> don't understand the difference and if that's correct (all macros in
> arch/riscv/include/asm/csr.h use # to do this) and what benefits it
> brings. Can you elaborate more on things that could "go weird"?

So rather than use an input constraint for the asm block you are using
the C preprocessor to paste in the csr argument. If csr is something
like "1" then it looks good and you'll get "csrr %0,1". If you pass
something like "1 << 31" then that will be pasted as "csrr %0, 1 <<
31" and that starts to get weird in the context of being in the
assembler where it is unlikely the C operators work. Using the input
constraint avoids this, causes the C compiler to check the type of the
argument and you'll probably get more intelligible error messages as a
consequence.

>
> Thanks again,
>
> Alex
>
> > >
> > > Also, why is this clobbering memory? Worth adding a comment.
> >
> > No idea, I see that it is also done this way in
> > arch/riscv/include/asm/csr.h. @Atish Kumar Patra , @Palmer Dabbelt ?

It would seem to make sense then not to have a memory constraint until
we know why we're doing it?

Thanks,
Ian

> >
> > Thanks for your comments!
> >
> > Alex
> >
> > >
> > > Thanks,
> > > Ian
> > >
> > > > +                __v;                                           \
> > > > +})
> > > > +
> > > > +static unsigned long csr_read_num(int csr_num)
> > > > +{
> > > > +#define switchcase_csr_read(__csr_num, __val)           {\
> > > > +       case __csr_num:                                 \
> > > > +               __val =3D csr_read(__csr_num);            \
> > > > +               break; }
> > > > +#define switchcase_csr_read_2(__csr_num, __val)         {\
> > > > +       switchcase_csr_read(__csr_num + 0, __val)        \
> > > > +       switchcase_csr_read(__csr_num + 1, __val)}
> > > > +#define switchcase_csr_read_4(__csr_num, __val)         {\
> > > > +       switchcase_csr_read_2(__csr_num + 0, __val)      \
> > > > +       switchcase_csr_read_2(__csr_num + 2, __val)}
> > > > +#define switchcase_csr_read_8(__csr_num, __val)         {\
> > > > +       switchcase_csr_read_4(__csr_num + 0, __val)      \
> > > > +       switchcase_csr_read_4(__csr_num + 4, __val)}
> > > > +#define switchcase_csr_read_16(__csr_num, __val)        {\
> > > > +       switchcase_csr_read_8(__csr_num + 0, __val)      \
> > > > +       switchcase_csr_read_8(__csr_num + 8, __val)}
> > > > +#define switchcase_csr_read_32(__csr_num, __val)        {\
> > > > +       switchcase_csr_read_16(__csr_num + 0, __val)     \
> > > > +       switchcase_csr_read_16(__csr_num + 16, __val)}
> > > > +
> > > > +       unsigned long ret =3D 0;
> > > > +
> > > > +       switch (csr_num) {
> > > > +       switchcase_csr_read_32(CSR_CYCLE, ret)
> > > > +       default:
> > > > +               break;
> > > > +       }
> > > > +
> > > > +       return ret;
> > > > +#undef switchcase_csr_read_32
> > > > +#undef switchcase_csr_read_16
> > > > +#undef switchcase_csr_read_8
> > > > +#undef switchcase_csr_read_4
> > > > +#undef switchcase_csr_read_2
> > > > +#undef switchcase_csr_read
> > > > +}
> > > > +
> > > > +static u64 read_perf_counter(unsigned int counter)
> > > > +{
> > > > +       return csr_read_num(CSR_CYCLE + counter);
> > > > +}
> > > > +
> > > > +static u64 read_timestamp(void)
> > > > +{
> > > > +       return csr_read_num(CSR_TIME);
> > > > +}
> > > > +
> > > >  #else
> > > >  static u64 read_perf_counter(unsigned int counter __maybe_unused) =
{ return 0; }
> > > >  static u64 read_timestamp(void) { return 0; }
> > > > --
> > > > 2.39.2
> > > >
