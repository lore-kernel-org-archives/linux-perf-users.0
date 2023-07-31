Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7598BC001DF
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 Jul 2023 10:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGaK2K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 Jul 2023 06:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjGaK2A (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 Jul 2023 06:28:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72CDE8
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jul 2023 03:27:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3178fa77b27so2770538f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jul 2023 03:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690799277; x=1691404077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML7AinUDVA2CqBB8483zq1nBkxRS460v6WFiKGGmbXw=;
        b=HDjhzaPlqiuA0S3baU9N7AYN1C6DUjgtDALoeJq5aufWUnbgGfC7ri/9FPQIqGzKbr
         a4Svo1r7W9I/U45tg6vynpKwViqCyi560TPOCUdBIv3WicpMwGVfcjERyOxlBw+mNugr
         D3TNX+y/ZS8TAIXOc5N7gD6//JnB8rEIaEJ6+MldyvnVb3drV/zksbkcg/thXeyRtqn0
         E6NIZzlCLOeAaX7g0CxdtVFcKfhts6SI//feucztq+DAw0weSyfty0scu1tLedenORu6
         ASq+u0mArosRDhMuUYuo1tU82hiiEaKFG2lb9u0XQJ4fsvOEsGH3dBJsFjAQjAjI/3nM
         4CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690799277; x=1691404077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML7AinUDVA2CqBB8483zq1nBkxRS460v6WFiKGGmbXw=;
        b=d3skGdw9KxFuuVHocVx7YYef3flOtuj2YZg6CwNhFNdxeIrlZMVtdfYMIoaIESCA1t
         PGJ+xIm2sEGFZewFVLFh4VnSOOR6hTYNYOhgZl+82xpTIFe3xsoO/AYj/7AXsHxpIue7
         r4Za/IMPFpMOErM87t9Afdf4XQxH4m7GPJYVGuzOfu7KKzRVCE2DJRi8vkqbbI1i0FiL
         KFAXzGn/ohI/62GY1FG3eUOO66DefiCjkZBLu34bBgJdKaGnu3Fl7+pDxPa1LLLm2bjf
         GA/jGOss40Z92XJGqI8kGZNg4wbe//StlrRXw0SNIGlbkl0P7PkhTjNjMeY68pXblAQo
         8IyQ==
X-Gm-Message-State: ABy/qLa8Sfi0OviHnx6pic1wBcGje/gITwQ7fXdLJg3b6+5lgqbrr2ug
        WfisL9XhYPlg4ZCXk9E50t0KT3Wgu8HPV7LVmMjkcQ==
X-Google-Smtp-Source: APBJJlEhaO5lz0dS3gmvYAUrPoGWqkGephnAst4AFjzfN8FgSJ7PtOXovOzb/eZPxNwPZcjK76ztR3OHJOwHd8MDE7g=
X-Received: by 2002:a5d:554b:0:b0:317:6816:578c with SMTP id
 g11-20020a5d554b000000b003176816578cmr8613111wrw.5.1690799277292; Mon, 31 Jul
 2023 03:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
 <20230727141428.962286-10-alexghiti@rivosinc.com> <CAP-5=fU5XYXrVnRUidpwjV2LiTsdebfidL43_Qo4Z7TBxMsVGA@mail.gmail.com>
 <CAHVXubgVAe1WsiZx5Ay+3KPK4u24k_vsnTwFFmBeVsHrGXwhfw@mail.gmail.com>
In-Reply-To: <CAHVXubgVAe1WsiZx5Ay+3KPK4u24k_vsnTwFFmBeVsHrGXwhfw@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 31 Jul 2023 12:27:46 +0200
Message-ID: <CAHVXubj80rQRShuDS09BeTrfR6nux0A68EMWLbeat8fd_Y3YdA@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] tools: lib: perf: Implement riscv mmap support
To:     Ian Rogers <irogers@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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

On Mon, Jul 31, 2023 at 12:15=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
>
> Hi Ian,
>
> On Fri, Jul 28, 2023 at 7:53=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Jul 27, 2023 at 7:28=E2=80=AFAM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > riscv now supports mmaping hardware counters so add what's needed to
> > > take advantage of that in libperf.
> > >
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> > > ---
> > >  tools/lib/perf/mmap.c | 65 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 65 insertions(+)
> > >
> > > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > > index 0d1634cedf44..378a163f0554 100644
> > > --- a/tools/lib/perf/mmap.c
> > > +++ b/tools/lib/perf/mmap.c
> > > @@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int counte=
r)
> > >
> > >  static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
> > >
> > > +#elif __riscv_xlen =3D=3D 64
> >
> > This is something of an odd guard, perhaps:
> > #elif defined(__riscv) && __riscv_xlen =3D=3D 64
> >
> > That way it is more intention revealing that this is riscv code. Could
> > you add a comment relating to the __riscv_xlen ?
>
> I guess Andrew answered that already.
>
> >
> > > +
> > > +/* TODO: implement rv32 support */
> > > +
> > > +#define CSR_CYCLE      0xc00
> > > +#define CSR_TIME       0xc01
> > > +
> > > +#define csr_read(csr)                                          \
> > > +({                                                             \
> > > +       register unsigned long __v;                             \
> > > +               __asm__ __volatile__ ("csrr %0, " #csr          \
> > > +                : "=3Dr" (__v) :                                 \
> > > +                : "memory");                                   \
> >
> > To avoid the macro pasting that could potentially go weird, could this =
be:
> >
> > __asm__ __volatile__ ("csrr %0, %1",
> >   : "=3Dr"(__v) /* outputs */
> >   : "i"(csr) /* inputs */
> >   : "memory" /* clobbers */)

Forgot to answer this one: it compiles, but I have to admit that I
don't understand the difference and if that's correct (all macros in
arch/riscv/include/asm/csr.h use # to do this) and what benefits it
brings. Can you elaborate more on things that could "go weird"?

Thanks again,

Alex

> >
> > Also, why is this clobbering memory? Worth adding a comment.
>
> No idea, I see that it is also done this way in
> arch/riscv/include/asm/csr.h. @Atish Kumar Patra , @Palmer Dabbelt ?
>
> Thanks for your comments!
>
> Alex
>
> >
> > Thanks,
> > Ian
> >
> > > +                __v;                                           \
> > > +})
> > > +
> > > +static unsigned long csr_read_num(int csr_num)
> > > +{
> > > +#define switchcase_csr_read(__csr_num, __val)           {\
> > > +       case __csr_num:                                 \
> > > +               __val =3D csr_read(__csr_num);            \
> > > +               break; }
> > > +#define switchcase_csr_read_2(__csr_num, __val)         {\
> > > +       switchcase_csr_read(__csr_num + 0, __val)        \
> > > +       switchcase_csr_read(__csr_num + 1, __val)}
> > > +#define switchcase_csr_read_4(__csr_num, __val)         {\
> > > +       switchcase_csr_read_2(__csr_num + 0, __val)      \
> > > +       switchcase_csr_read_2(__csr_num + 2, __val)}
> > > +#define switchcase_csr_read_8(__csr_num, __val)         {\
> > > +       switchcase_csr_read_4(__csr_num + 0, __val)      \
> > > +       switchcase_csr_read_4(__csr_num + 4, __val)}
> > > +#define switchcase_csr_read_16(__csr_num, __val)        {\
> > > +       switchcase_csr_read_8(__csr_num + 0, __val)      \
> > > +       switchcase_csr_read_8(__csr_num + 8, __val)}
> > > +#define switchcase_csr_read_32(__csr_num, __val)        {\
> > > +       switchcase_csr_read_16(__csr_num + 0, __val)     \
> > > +       switchcase_csr_read_16(__csr_num + 16, __val)}
> > > +
> > > +       unsigned long ret =3D 0;
> > > +
> > > +       switch (csr_num) {
> > > +       switchcase_csr_read_32(CSR_CYCLE, ret)
> > > +       default:
> > > +               break;
> > > +       }
> > > +
> > > +       return ret;
> > > +#undef switchcase_csr_read_32
> > > +#undef switchcase_csr_read_16
> > > +#undef switchcase_csr_read_8
> > > +#undef switchcase_csr_read_4
> > > +#undef switchcase_csr_read_2
> > > +#undef switchcase_csr_read
> > > +}
> > > +
> > > +static u64 read_perf_counter(unsigned int counter)
> > > +{
> > > +       return csr_read_num(CSR_CYCLE + counter);
> > > +}
> > > +
> > > +static u64 read_timestamp(void)
> > > +{
> > > +       return csr_read_num(CSR_TIME);
> > > +}
> > > +
> > >  #else
> > >  static u64 read_perf_counter(unsigned int counter __maybe_unused) { =
return 0; }
> > >  static u64 read_timestamp(void) { return 0; }
> > > --
> > > 2.39.2
> > >
