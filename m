Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C455EB64DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jun 2023 19:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjFSTE4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jun 2023 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFSTEz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jun 2023 15:04:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D5518C
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jun 2023 12:04:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b46f1256bbso23962551fa.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jun 2023 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1687201492; x=1689793492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzpzSXcJNt2GDsK+43ZK/uSItcMyByB0gXZwcs2zWL8=;
        b=J+1cLliv98rSFofa+UWME4RIq3zdyYTQID1sx8+kCq375XpPJUIxBmH3CQmHSo5//J
         AXopCQue+A08F1XKUy2fqH+FNllGbTBqChD63/ZpHSBbldtk/a12adQjMkLqUXJ/Sqtg
         4TW9AD4/AZeM6efGebdhSVVz6pM7uYPUwaUnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687201492; x=1689793492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzpzSXcJNt2GDsK+43ZK/uSItcMyByB0gXZwcs2zWL8=;
        b=XaZspxrmpRNMDoqmwnB0387wVY8NbvVIis9LNCJxq9LmS3D4pjERL2yeWowerKUqnw
         8JMI2Czd+Hh/c/6y7oQYg/OayAgzIrw31hok+akPvLI3u1FpY7B/eqaFWE6UU+w9A2dU
         nKIkOkS4Fq80J7rXBsmt7NMZ45wxpdngAo8Glho2YQO+TgR/Da+l05mezI4I51gj8uEJ
         D6yqJx89Di79ZzwY2YtHnot68NpqsJt5Ns3e/OmfptjSWjubMDPAVzadMM7iQ0pNt9j/
         fI3nK4UJe4AcJNTKMbSUWaRvkENaE8if8JUqHWbwjzllow4g57xAwH11mw3nRyfP3IkT
         OM9w==
X-Gm-Message-State: AC+VfDwOUOZW5aVwC9YpZ6ygZTGyKOftQvbXFxts31+icIj2npnz24eG
        JIyEZ7WuLHS87kmKh8XdOyOI9aGwc3ZxcqInvaMd
X-Google-Smtp-Source: ACHHUZ7mHJJ87PwuPguZaHHd3DMLuZqOQ6pWQ+agtvn/ioD9AatxkbRT2bjyFtLUK8knzNEhF5INROqnVrw3kM/Wp3M=
X-Received: by 2002:a2e:8e2b:0:b0:2b4:5d74:d760 with SMTP id
 r11-20020a2e8e2b000000b002b45d74d760mr2474899ljk.25.1687201492189; Mon, 19
 Jun 2023 12:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-10-alexghiti@rivosinc.com> <CAOnJCU+n0O9oQmd1Vs3kimaBai7vbaf5RiMRFyvphCCLCGMB1A@mail.gmail.com>
 <CAHVXubgGqRLN3cb=eEW8zXHto6ZqJGg4LoFi=rEnuBCztYtV=w@mail.gmail.com>
In-Reply-To: <CAHVXubgGqRLN3cb=eEW8zXHto6ZqJGg4LoFi=rEnuBCztYtV=w@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 19 Jun 2023 12:04:40 -0700
Message-ID: <CAOnJCUKCMRrj6HQbj5XGTKRsu8pwcg3Yg5zwGw6mPwMS_q-U8A@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] tools: lib: perf: Implement riscv mmap support
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 16, 2023 at 2:06=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> On Fri, Jun 16, 2023 at 10:43=E2=80=AFAM Atish Patra <atishp@atishpatra.o=
rg> wrote:
> >
> > On Fri, May 12, 2023 at 2:03=E2=80=AFAM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > riscv now support mmaping hardware counters so add what's needed to
> > > take advantage of that in libperf.
> > >
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  tools/lib/perf/mmap.c | 65 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 65 insertions(+)
> > >
> > > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > > index 0d1634cedf44..65f250e0ef92 100644
> > > --- a/tools/lib/perf/mmap.c
> > > +++ b/tools/lib/perf/mmap.c
> > > @@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int counte=
r)
> > >
> > >  static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
> > >
> > > +#elif __riscv_xlen =3D=3D 64
> > > +
> >
> > This is applicable for RV32 as well. No ?
> > otherwise, you won't need CSR_CYCLEH
>
> Admittedly, I have not checked rv32 at all in this series and the code
> below is a copy-paste. I'd say that rv32 support is out of scope for
> this series, is that ok with you?
>

That's fine. Let's just remove the CYCLEH and leave a TODO comment for RV32=
.

> >
> > > +#define CSR_CYCLE      0xc00
> > > +#define CSR_TIME       0xc01
> > > +#define CSR_CYCLEH     0xc80
> > > +
> > > +#define csr_read(csr)                                          \
> > > +({                                                             \
> > > +       register unsigned long __v;                             \
> > > +               __asm__ __volatile__ ("csrr %0, " #csr          \
> > > +                : "=3Dr" (__v) :                                 \
> > > +                : "memory");                                   \
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
> > > +       switchcase_csr_read_32(CSR_CYCLEH, ret)
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
> > > 2.37.2
> > >
> >
> >
> > --
> > Regards,
> > Atish



--=20
Regards,
Atish
