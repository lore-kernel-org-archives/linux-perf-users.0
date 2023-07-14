Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F26EB64DC
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Jul 2023 09:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjGNJ3q (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Jul 2023 05:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjGNJ3p (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Jul 2023 05:29:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514802D66
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jul 2023 02:29:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b703a0453fso25235861fa.3
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jul 2023 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689326981; x=1691918981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPuE+yRzqiEB8varg/w30zSn9gbVAkPIryT0l1Bao0s=;
        b=jK5Xtm5jSqA1gQEB1zqIWZrWjhypJYmneNg2c/JPWKd+ea9Kaql368JQ7WEkdFlnDc
         3NyBkZhtAZeJEoB0DyaD+4ec+9G/adfezCCfH+VSTTPf95jFkGBE+PWh5KR5MrVQU413
         puA97e3k8noBO4WvDAM2xRmZO11oKqI0SGP1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689326981; x=1691918981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPuE+yRzqiEB8varg/w30zSn9gbVAkPIryT0l1Bao0s=;
        b=jKZuOH/HwG6vU8CMXPKDCWL5lLLtPdeAun69xxzmBtCcQaXOJRao8oUmZ6VCQNNFRO
         Uayop56H0NiRn0rTThBKmnxtHNpwLEACdiYwvLupNBEubf3aggYbQyiqNHUSHAGDpLCS
         UQqUc6dJQAad3JdcMJBhbBkTDmO1XIHYvBpJBAydrE8b5B2tfTahAzOZlzUwwT/Xl1Cn
         3hLIiOyurSzkrBXLR33vaBa52W1DhTZfCiKCcdQ5y70PSH+0WX4wP37NPsj0Xl9lXxJC
         Ua03QuWlMgP+q3Rp718bvLGbFGsIQUsV0oAmEyHkNG8lVTXs6SYcL62UFv/gn/QzTOGi
         7q5g==
X-Gm-Message-State: ABy/qLaorsvQ8Pj5JFiWRoeSYxiPuPk7NrrJggLhPJnzpqNxqU4vYKfH
        jHu2uEbWqrPMIAiQlyCVBvhkSS6eqQ9TIAJCc1b6
X-Google-Smtp-Source: APBJJlH+wwYG8rQHkktJTc9cF2xK2F2ZrpVsAjubYvXyVIMRlsbQTU4ksU6lDxZvd+KH8RWoOin1VgN0rwcYfkVGNd0=
X-Received: by 2002:a2e:b04b:0:b0:2b8:3ff3:cd93 with SMTP id
 d11-20020a2eb04b000000b002b83ff3cd93mr643024ljl.7.1689326981568; Fri, 14 Jul
 2023 02:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com> <20230703124647.215952-10-alexghiti@rivosinc.com>
In-Reply-To: <20230703124647.215952-10-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 14 Jul 2023 02:29:30 -0700
Message-ID: <CAOnJCULxXRx0H30zrozcEJ5Nhmco7+m98kJxf8BGJsob8F97MA@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] tools: lib: perf: Implement riscv mmap support
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

On Mon, Jul 3, 2023 at 5:56=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> riscv now supports mmaping hardware counters so add what's needed to
> take advantage of that in libperf.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  tools/lib/perf/mmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index 0d1634cedf44..378a163f0554 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int counter)
>
>  static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
>
> +#elif __riscv_xlen =3D=3D 64
> +
> +/* TODO: implement rv32 support */
> +
> +#define CSR_CYCLE      0xc00
> +#define CSR_TIME       0xc01
> +
> +#define csr_read(csr)                                          \
> +({                                                             \
> +       register unsigned long __v;                             \
> +               __asm__ __volatile__ ("csrr %0, " #csr          \
> +                : "=3Dr" (__v) :                                 \
> +                : "memory");                                   \
> +                __v;                                           \
> +})
> +
> +static unsigned long csr_read_num(int csr_num)
> +{
> +#define switchcase_csr_read(__csr_num, __val)           {\
> +       case __csr_num:                                 \
> +               __val =3D csr_read(__csr_num);            \
> +               break; }
> +#define switchcase_csr_read_2(__csr_num, __val)         {\
> +       switchcase_csr_read(__csr_num + 0, __val)        \
> +       switchcase_csr_read(__csr_num + 1, __val)}
> +#define switchcase_csr_read_4(__csr_num, __val)         {\
> +       switchcase_csr_read_2(__csr_num + 0, __val)      \
> +       switchcase_csr_read_2(__csr_num + 2, __val)}
> +#define switchcase_csr_read_8(__csr_num, __val)         {\
> +       switchcase_csr_read_4(__csr_num + 0, __val)      \
> +       switchcase_csr_read_4(__csr_num + 4, __val)}
> +#define switchcase_csr_read_16(__csr_num, __val)        {\
> +       switchcase_csr_read_8(__csr_num + 0, __val)      \
> +       switchcase_csr_read_8(__csr_num + 8, __val)}
> +#define switchcase_csr_read_32(__csr_num, __val)        {\
> +       switchcase_csr_read_16(__csr_num + 0, __val)     \
> +       switchcase_csr_read_16(__csr_num + 16, __val)}
> +
> +       unsigned long ret =3D 0;
> +
> +       switch (csr_num) {
> +       switchcase_csr_read_32(CSR_CYCLE, ret)
> +       default:
> +               break;
> +       }
> +
> +       return ret;
> +#undef switchcase_csr_read_32
> +#undef switchcase_csr_read_16
> +#undef switchcase_csr_read_8
> +#undef switchcase_csr_read_4
> +#undef switchcase_csr_read_2
> +#undef switchcase_csr_read
> +}
> +
> +static u64 read_perf_counter(unsigned int counter)
> +{
> +       return csr_read_num(CSR_CYCLE + counter);
> +}
> +
> +static u64 read_timestamp(void)
> +{
> +       return csr_read_num(CSR_TIME);
> +}
> +
>  #else
>  static u64 read_perf_counter(unsigned int counter __maybe_unused) { retu=
rn 0; }
>  static u64 read_timestamp(void) { return 0; }
> --
> 2.39.2
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
