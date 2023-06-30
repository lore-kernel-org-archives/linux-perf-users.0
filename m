Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E993C0015E
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 10:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjF3Kfl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 06:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjF3Kfc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 06:35:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F354D3AB2
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 03:35:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51d9124e1baso1809781a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688121305; x=1690713305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aIpEGvFXrs8o97FGml0s9iS/MpzyaImfG5Q+Ha+S4rk=;
        b=Pa9I9sD8aoveHuo5s0uVgd8tNUEW0sJ61kej0dmwT4IQqKaVVnOWDSFhGcmpXdsyMa
         O8g0+grHMbOyc21MOZrirw3K2oqzfnAq5DuBNNxslOFGnjbOU1gURVPKT2COlriQzVI4
         qSv2iorZqqMXZETI1R1z7KZ4gaWGayca1oDUvV1umBwxvJ/cNT8MNXSlFHIlzxmp+1dI
         WwwuJ+7e1e2hgz2cFbd9CWuTFCeK37qQ25dZe8g232SyAQIgpCP3G/QXW9X43lQw7kYP
         l1ygIETj5LA3gXiQYghkg9hUKVr9GRt1ljJ1DWzRo1KSUOvg7xrA9jLsgHOqafXRT9Wc
         hLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688121305; x=1690713305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIpEGvFXrs8o97FGml0s9iS/MpzyaImfG5Q+Ha+S4rk=;
        b=gRypNg+z/fr8gckaBLJ1tpxbH14rJH3kgPgctF/o+02oRQcrAue+c51b1LUqB9udBe
         vl8SEiYAQBLYQ8jhfpXXp2HxliVJs7tQsUTNpJ2xP4H/GAckfzw5PYmild+PyGRK198A
         oohbXHKzSkhfT3wxdpOM/4CDhbKghla1cR6SayPJ8LSxtXSppz8Caa18qqONL7QhAp62
         F4JDSl/giBZxcOb/p2XpJ2tpJMNwIdBG2bbhkk9O2ErKcJAe7nLw5jtCceauiQL0N5hB
         luyfaExYjs7MbrsoR5+9zfOko9tetenx8l6vQiQeZ1JvXmOZ2bAKTofc7XDVmXnvMVIE
         q4qQ==
X-Gm-Message-State: ABy/qLYPhxjCzhVTX6MObn6EykgDZAoF55NkxVUf6riVAaiMYp05w1Xz
        7J+SLR+zTlsE6LrOcgbX4DZL7Q==
X-Google-Smtp-Source: APBJJlFI4nzgC9G6s9EsR/Gn6ZOe43adgLRDEgX9KqwfVxRhQo4NY7mFu+YK8TxklGgFUZipBiY9gw==
X-Received: by 2002:a17:906:4b49:b0:98e:477d:36c0 with SMTP id j9-20020a1709064b4900b0098e477d36c0mr1579960ejv.47.1688121305353;
        Fri, 30 Jun 2023 03:35:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id k26-20020a17090627da00b00992e94bcfabsm460906ejc.167.2023.06.30.03.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 03:35:04 -0700 (PDT)
Date:   Fri, 30 Jun 2023 12:35:03 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
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
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/10] riscv: Make legacy counter enum match the HW
 numbering
Message-ID: <20230630-ba45f06f3d9faba17c6d8f6a@orel>
References: <20230630083013.102334-1-alexghiti@rivosinc.com>
 <20230630083013.102334-4-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630083013.102334-4-alexghiti@rivosinc.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 30, 2023 at 10:30:06AM +0200, Alexandre Ghiti wrote:
> RISCV_PMU_LEGACY_INSTRET used to be set to 1 whereas the offset of this
> hardware counter from CSR_CYCLE is actually 2: make this offset match the
> real hw offset so that we can directly expose those values to userspace.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_legacy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
> index ca9e20bfc7ac..6a000abc28bb 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -13,7 +13,7 @@
>  #include <linux/platform_device.h>
>  
>  #define RISCV_PMU_LEGACY_CYCLE		0
> -#define RISCV_PMU_LEGACY_INSTRET	1
> +#define RISCV_PMU_LEGACY_INSTRET	2
>  
>  static bool pmu_init_done;
>  
> -- 
> 2.39.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
