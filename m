Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A78BC04A6A
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Jul 2023 07:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjG2Hid (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 29 Jul 2023 03:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjG2HiY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 29 Jul 2023 03:38:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61003C29
        for <linux-perf-users@vger.kernel.org>; Sat, 29 Jul 2023 00:38:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so83267766b.2
        for <linux-perf-users@vger.kernel.org>; Sat, 29 Jul 2023 00:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690616301; x=1691221101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IYmWtjCeCkbkXYXMidyXsHWo/uzc6Q0z95DnXsdb6Jk=;
        b=Ut1CWQVuoMLWFKzhCEeRWNrfILigN3hwnJXELqS2Tsfgnn3fFk2TtGyJAzjAj5wGEA
         sNipHCgNMxUMrgl7nescH6w++92Hb6aQiDANbCUKSWm8nzmINfUaAvlXNQcLqjtL2I3+
         enz93UK0DlVK8+cta6KaXLupiTePyrO5Hriwxh8lFtelzsB2raxvmYI1/RkfKtyzsB6x
         xWlmXhc0SpGkcPfWHr9tectW+YjxDC3M3yxfNMFziU7BBL7nHRpDeLc1luZT8v2fPWgQ
         yrYMEYjOMuO3tiMBJmnqpRaJ4UxvaR5S6If5xytfRSueIvZvYxd/kgMfYtBaZ429//Dn
         LkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690616301; x=1691221101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYmWtjCeCkbkXYXMidyXsHWo/uzc6Q0z95DnXsdb6Jk=;
        b=NKlmstfu5P1bYkWbRdecqGQrIS5STz2RT6b7LIrmkq0gsWfEdpgqnaJN00Ygw+Gn3c
         S1aa+I346GyBeUozX+HPsMqA2fJw0Z0Rj6QnmkZ4WBvKX6IhX7ZrT8NpfLkWPnFDrqE9
         Am3filSVHce7a5o8UKaMism5aQ4O0fwO6JWmSAJS1Yb6Hb988Pv7V5AbC1BRgGOCr3vq
         i/eh+ZOVlsDD0lfJOFBPfgt+1Vty2t8jaFOLIOe/UxRpyqIlzDHk3AquY3shF2EW/BZ6
         iyEC9hKL7ILwk9AS+6/1rAl5l3egsWfRd1IM7Fnx9FM9Au0jRGqXJlvR74YpaCWT3abd
         2ZxQ==
X-Gm-Message-State: ABy/qLbv8U7qMGQq/11Jw2rWXJ1um8i0k2KuYB9X9LQX8rSzQc4yW7lK
        RLhq4rliyGUEy5CWwB1RC7ZD/I+Nt7dJm8970Lc=
X-Google-Smtp-Source: APBJJlE05iU3+hYWOPGNmt1tk5T+oJvM8YCFPE9dtxhtPAlwF0v+PGLvzacP+3sj+ZuHwVpYnCzI/w==
X-Received: by 2002:a17:906:74d6:b0:99b:e03b:3968 with SMTP id z22-20020a17090674d600b0099be03b3968mr1356267ejl.64.1690616301218;
        Sat, 29 Jul 2023 00:38:21 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id kk9-20020a170907766900b00982cfe1fe5dsm3000715ejc.65.2023.07.29.00.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 00:38:20 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:38:19 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
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
        =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v4 10/10] perf: tests: Adapt mmap-basic.c for riscv
Message-ID: <20230729-b5ec43a48d67caf13025fafe@orel>
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
 <20230727141428.962286-11-alexghiti@rivosinc.com>
 <CAP-5=fXvqJk9hA51pDSXodEWSP4DzN+RJ1scpyzJOrxk2w5kjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXvqJk9hA51pDSXodEWSP4DzN+RJ1scpyzJOrxk2w5kjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 28, 2023 at 10:54:02AM -0700, Ian Rogers wrote:
> On Thu, Jul 27, 2023 at 7:30 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > riscv now supports mmaping hardware counters to userspace so adapt the test
> > to run on this architecture.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  tools/perf/tests/mmap-basic.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> > index e68ca6229756..f5075ca774f8 100644
> > --- a/tools/perf/tests/mmap-basic.c
> > +++ b/tools/perf/tests/mmap-basic.c
> > @@ -284,7 +284,7 @@ static struct test_case tests__basic_mmap[] = {
> >                          "permissions"),
> >         TEST_CASE_REASON("User space counter reading of instructions",
> >                          mmap_user_read_instr,
> > -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || __riscv_xlen == 64
> 
> Same comment relating to the guard, why not defined(__riscv) ?

__riscv_xlen will always be defined for all riscv targets, so also
checking __riscv isn't necessary when a specific bit width also needs
to be checked. __riscv is useful for checks that don't need to be
concerned with the bit width. Grepping, I see instances of both
"defined(__riscv) && __riscv_xlen ==" and just "__riscv_xlen ==".
IMHO, the former should be reduced to the latter, rather than creating
more instances of them.

Thanks,
drew
