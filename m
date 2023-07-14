Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49483EB64DA
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Jul 2023 08:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjGNIGI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Jul 2023 04:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjGNIFm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Jul 2023 04:05:42 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BBB3ABA
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jul 2023 01:03:43 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b708e49059so24751111fa.3
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jul 2023 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1689321821; x=1691913821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjGLAxee+6Ys9A4CymyGT7r3XR+DwzfZMVxRgHoxE5Q=;
        b=CjrJSFwQHNriZicyQY+/qEHwW+RTQYr4SNIG047YQMIYg0SDkOYGzcHkruU4HmdQx9
         jbtscSpbmpGVYMjHVaxk3IB3OeT8otxO2C8i0F3xLjBHUcMg1WuQW7ENtOZsfYVzNRFI
         3BUW0it+1aYPguLEVgD5Sjj70w/JS4oI0XbZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321821; x=1691913821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjGLAxee+6Ys9A4CymyGT7r3XR+DwzfZMVxRgHoxE5Q=;
        b=EVsO6DWTwFIjuzk1DM8ffmcCdKutFFCeo4meQ0GBptkO+gnpIdvXnU1iEwXm7nBJc+
         ERJtQ/MvqRB8CF4F4v30fQFTFu3EEO44MbPVKeNgQ/XXhYtV37FpbJBEjUB5ZsZDfXxM
         D7A5osq8nU4UrASlUaXRtMbmzHPHbiFqrSnVmE83WW2cSEH/BbQWE0f6Ss6VdM7gc6Fq
         xay4CXBxfEaLcv69RnxpooZLnmSKOYySQvjSkpNJrBUKliGXI7d1mJxQZaUi2gEJUGmg
         3FBASaXv//pubQk9kj99evmQCN+e11YYU/44nmgnE0U4gzHhy1bEp/A2/EneQ9553Ik9
         ccRg==
X-Gm-Message-State: ABy/qLas1ZlYa7luhaNo33e1vlNt1ezoExn76wIfVyny/ks5mceij8MY
        QdLMO4UX/M2pF0yMqfzpo8AccD1yg5nNZE5360fG
X-Google-Smtp-Source: APBJJlFMUlhWa9Bc5+g9g+JYTmYYF2lCTHnWmApqUVwFo+Nv3dexs2cSKLqHSfAq2guIwBhHZgSIhFGHf3AueKs0GvA=
X-Received: by 2002:a05:651c:104e:b0:2b6:c790:150a with SMTP id
 x14-20020a05651c104e00b002b6c790150amr3565106ljm.22.1689321821152; Fri, 14
 Jul 2023 01:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124647.215952-1-alexghiti@rivosinc.com> <20230703124647.215952-7-alexghiti@rivosinc.com>
In-Reply-To: <20230703124647.215952-7-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 14 Jul 2023 01:03:29 -0700
Message-ID: <CAOnJCULYD_Z32dupvTZZm7E6GnXaOy+R3yf7wqSy3ZMdd6eOFw@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] drivers: perf: Implement perf event mmap support
 in the legacy backend
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

On Mon, Jul 3, 2023 at 5:52=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> Implement the needed callbacks in the legacy driver so that we can
> directly access the counters through perf in userspace.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/perf/riscv_pmu_legacy.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_leg=
acy.c
> index 6a000abc28bb..79fdd667922e 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -71,6 +71,29 @@ static void pmu_legacy_ctr_start(struct perf_event *ev=
ent, u64 ival)
>         local64_set(&hwc->prev_count, initial_val);
>  }
>
> +static uint8_t pmu_legacy_csr_index(struct perf_event *event)
> +{
> +       return event->hw.idx;
> +}
> +
> +static void pmu_legacy_event_mapped(struct perf_event *event, struct mm_=
struct *mm)
> +{
> +       if (event->attr.config !=3D PERF_COUNT_HW_CPU_CYCLES &&
> +           event->attr.config !=3D PERF_COUNT_HW_INSTRUCTIONS)
> +               return;
> +
> +       event->hw.flags |=3D PERF_EVENT_FLAG_USER_READ_CNT;
> +}
> +
> +static void pmu_legacy_event_unmapped(struct perf_event *event, struct m=
m_struct *mm)
> +{
> +       if (event->attr.config !=3D PERF_COUNT_HW_CPU_CYCLES &&
> +           event->attr.config !=3D PERF_COUNT_HW_INSTRUCTIONS)
> +               return;
> +
> +       event->hw.flags &=3D ~PERF_EVENT_FLAG_USER_READ_CNT;
> +}
> +
>  /*
>   * This is just a simple implementation to allow legacy implementations
>   * compatible with new RISC-V PMU driver framework.
> @@ -91,6 +114,9 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>         pmu->ctr_get_width =3D NULL;
>         pmu->ctr_clear_idx =3D NULL;
>         pmu->ctr_read =3D pmu_legacy_read_ctr;
> +       pmu->event_mapped =3D pmu_legacy_event_mapped;
> +       pmu->event_unmapped =3D pmu_legacy_event_unmapped;
> +       pmu->csr_index =3D pmu_legacy_csr_index;
>
>         perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
>  }
> --
> 2.39.2
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish
