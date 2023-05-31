Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8E2C77B73
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 May 2023 14:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbjEaOYc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 May 2023 10:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjEaOY2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 May 2023 10:24:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF4194
        for <linux-perf-users@vger.kernel.org>; Wed, 31 May 2023 07:24:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f623adec61so61410585e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 May 2023 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685543057; x=1688135057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UX4uQnFBny46FGtELxF82bEZ7MtHQbRmUfHqzbpy2lU=;
        b=IfZ/Ty5r3Rvqpyw7mbNjCMOnUMNLWEjwe+gPBeXaNQKgtzbrn43qBaFsQ01WG62yjv
         XME9SbyP0N5U1D9NoQRBkV9Zhqo1YGZZ53aXrSteaeilPxLX2+XbnbvtmK8KVitIuNum
         BTw0oVjDbhu+LZvVe9vwdVAdbPm6FM6OrfIGRXCfRJwEyWbKyAxPmC0AxCpZ/t4lXnVG
         ZEbjJhaOYnNF5I7VXOD2aSrPOgT/5V5ayPDbsai1cu/XzZW/x1EOnDPlftPM1zLUo5hK
         LpNd3f3eYdQgduYWjrWRqJHgEFVdyS9CpXr7n4tqRw18zRe8skA+G5OYnlILCzE7fCiE
         4hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685543057; x=1688135057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX4uQnFBny46FGtELxF82bEZ7MtHQbRmUfHqzbpy2lU=;
        b=guAQCp99a5+dYFemE4rvX1BZS0G1enZMh2sHKvlCfoIKnaf0a9kUkARr6jzK3zYP0z
         X4D2yj/r/NeUIYA2S/JysqehwDLXMXsQm1bwJPpc+VIure15NyDD9Kl1PCQr+ffb/yMi
         ali0FlYiuLWydX4NBDiTY+Bpl4L3NRy7ba/WOxXPWG0z/v93r+Le5/Sbr1Tu55LXTK4U
         56hHTJ+g/06p0dwheUtc5LPw6EbtPMDa/M0KRfv/AZtSERsAWSiSDucIi8+cTP/caQuD
         Oh2I0OD/4sJ5tZtP4xE6jCVQYVRFd74whXrRxstZneu71b5nyLX2rKQjoZ1mjLtvWHRP
         EI3Q==
X-Gm-Message-State: AC+VfDz/jKDAWVJ3ZOuBM1aWP0ydGaQhm68lvDXDH4yhQqZaooMhpz5k
        QSWFqGxpuiPkpL61bm+yjDsm7w==
X-Google-Smtp-Source: ACHHUZ5dPMhB9kse11TIMIIwrwKdudQXmklhlG9pDb6dSrstXMUpAu5VAPxTeBjZUNfqusU9DTLd+A==
X-Received: by 2002:a1c:f30e:0:b0:3f6:e42:8f85 with SMTP id q14-20020a1cf30e000000b003f60e428f85mr4390658wmq.37.1685543057440;
        Wed, 31 May 2023 07:24:17 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c211400b003f4ebeaa970sm21044711wml.25.2023.05.31.07.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:24:17 -0700 (PDT)
Date:   Wed, 31 May 2023 16:24:16 +0200
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
Subject: Re: [PATCH v2 05/10] riscv: Prepare for user-space perf event mmap
 support
Message-ID: <20230531-107c91fd5c1926f7c8a2a25d@orel>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-6-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512085321.13259-6-alexghiti@rivosinc.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 12, 2023 at 10:53:16AM +0200, Alexandre Ghiti wrote:
> Provide all the necessary bits in the generic riscv pmu driver to be
> able to mmap perf events in userspace: the heavy lifting lies in the
> driver backend, namely the legacy and sbi implementations.
> 
> Note that arch_perf_update_userpage is almost a copy of arm64 code.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/Makefile     |  2 +-
>  arch/riscv/kernel/perf_event.c | 58 ++++++++++++++++++++++++++++++++++
>  drivers/perf/riscv_pmu.c       | 41 ++++++++++++++++++++++++
>  include/linux/perf/riscv_pmu.h |  4 +++
>  4 files changed, 104 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/perf_event.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
