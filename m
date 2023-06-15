Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7704DEB64DB
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jun 2023 08:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbjFOIhC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jun 2023 04:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245170AbjFOIgm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jun 2023 04:36:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8951295E
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 01:36:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b448b24a66so2154411fa.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1686818186; x=1689410186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDqFlnJs7b5XSrXYfFDcBdbg7c+MBzrrq0kAraysWF0=;
        b=BF4NTGgyxuXLd/DCtsfhMWllCFX5t8hYdRqzQeUl9mxCjttJAJ7Pm8/A9437zSmkP2
         fiulhEjOtigFq6kjTjDFwsjbyk5q51xYQkvo3CsBOJjdXMSWDuxF3PDmK12cqPN7B66v
         hsQKjBkbPmpmAppRPNgBHtAEKvcG+b6yfyydk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818186; x=1689410186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDqFlnJs7b5XSrXYfFDcBdbg7c+MBzrrq0kAraysWF0=;
        b=NIUhSQ+6JRILDF3xLIr5L3+ghCRFteXsT5JZcDuC3fKdOvSRm8DkKOBiGZ/MxNoYbC
         wPAUPEkEijzajhg/6WmbiGag3e7CN1P12NH47jZE7I6wHKfQhpAwkQny50PS4F0tH9tv
         djvGCBzNKEKFK0qfqTowLUHe0uKRfkETlClC1QtNp0n+CdKtgvVqPO6AwvL8MFQu8OZD
         57guvlv3ahXALFcjzKuTIcFdKmohsdLWe7VKNlF7eISaXpfaZC7Pr0LU5DlashvwWtB1
         nrmpV5J06zceYx1yQAlJRF/frFjOGVuzu3jYdyWnEN16ezKycNh/kFeGYKQmXJkbpL/k
         ZJyg==
X-Gm-Message-State: AC+VfDyjEoxu/XQmxLqEXfdi7pM+vM4tCofJYGlY++w08u8v0n/lr84W
        yFbpNqQOukeErsgGo0lYdlK1tbzI5YKCIdYCw/7B
X-Google-Smtp-Source: ACHHUZ5Bdq/pHXm3zHoqwzxyGEBNA9JTaa6iUkRvIy+81mbIKyUzp1Kmd9vgi/5KwuUU4fD/I76lgbpxMD9W4Q7qWlI=
X-Received: by 2002:a2e:8611:0:b0:2b3:4c18:cf41 with SMTP id
 a17-20020a2e8611000000b002b34c18cf41mr2931471lji.53.1686818186178; Thu, 15
 Jun 2023 01:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-3-alexghiti@rivosinc.com> <20230531-707d254be1238272fb2c182d@orel>
In-Reply-To: <20230531-707d254be1238272fb2c182d@orel>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 15 Jun 2023 01:36:14 -0700
Message-ID: <CAOnJCUJHMt4ziauJw-O5vr1NohaSDpN=NQUoSC4oxHRurkV0JQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] include: riscv: Fix wrong include guard in riscv_pmu.h
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 31, 2023 at 6:56=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, May 12, 2023 at 10:53:13AM +0200, Alexandre Ghiti wrote:
> > The current include guard prevents the inclusion of asm/perf_event.h
> > which uses the same include guard: fix the one in riscv_pmu.h so that i=
t
> > matches the file name.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  include/linux/perf/riscv_pmu.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_=
pmu.h
> > index 43fc892aa7d9..9f70d94942e0 100644
> > --- a/include/linux/perf/riscv_pmu.h
> > +++ b/include/linux/perf/riscv_pmu.h
> > @@ -6,8 +6,8 @@
> >   *
> >   */
> >
> > -#ifndef _ASM_RISCV_PERF_EVENT_H
> > -#define _ASM_RISCV_PERF_EVENT_H
> > +#ifndef _RISCV_PMU_H
> > +#define _RISCV_PMU_H
> >
> >  #include <linux/perf_event.h>
> >  #include <linux/ptrace.h>
> > @@ -81,4 +81,4 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *nu=
m_hw_ctr);
> >
> >  #endif /* CONFIG_RISCV_PMU */
> >
> > -#endif /* _ASM_RISCV_PERF_EVENT_H */
> > +#endif /* _RISCV_PMU_H */
> > --
> > 2.37.2
> >
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
