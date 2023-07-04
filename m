Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D15EB64D9
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Jul 2023 12:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjGDM2Y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Jul 2023 08:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjGDM2W (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Jul 2023 08:28:22 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAD710D0
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jul 2023 05:28:20 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-635fa79d7c0so23594546d6.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jul 2023 05:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1688473699; x=1691065699;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l5YpNQ9k3FxEI6NyEQ6O/c948FLcVDYur8dACWC8IMo=;
        b=MKbpxpd3h33Jur04KbPUrCLTlVIAAu5iv7+InZ2Ld/h7aQEoYZjAV/1l7GNlBXhBs/
         SBy7ElK8A3XM0+bIPwHaC+MmN5ZHDIgtcMt0tbcTmJ/TCFBrs4T9BMNP4X7XwieicLlM
         3Uf0jz/gYRqoPW9beXrjMAL/7Ilt9EiZwz9MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688473699; x=1691065699;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5YpNQ9k3FxEI6NyEQ6O/c948FLcVDYur8dACWC8IMo=;
        b=lmds/P96Qrz4o6/2dGHniivll0XttZuC5dA1p3GSeJKN/DRceCjk3LVf1KF+6Vn5b2
         cBBKUNxAI9gskjBRY1CxAiu2rwV1r82m1Nt3C7jEl7b1FPG+M/vgdxUIubCIafxY0Y85
         50R6t0kpQR2HSV17oPhTaWcl1RSLsHi/X55L4SvPGvpGpaYg78BAL2SRqCpZlZWJUQk5
         tArQhArq9pqVrZ/9HTCNj+MW7EN32reIJa0zvo6fvzSPWj1cd8zAZEdmIbfdPuD3itel
         q3YtrFTrHwrT4pWjYQzofd1gVchQAwYt3SFrHeSM/JITOqixf11B+VM5MvF0ONrlKltf
         bU8g==
X-Gm-Message-State: AC+VfDw3uNnPzD8vJzf8hVQk0Yn195PAulHWAF6qsCf3VVkXnSGhVRYQ
        uAiYafCcLLXOzdDjwIR2mr1mYA==
X-Google-Smtp-Source: ACHHUZ6ytBJOoBgDRsxovcaKyYEdk2QBLDw+FxvVzCXKV9CmY3KSb9amNV59gJ8MDByp7CHlrPVdRA==
X-Received: by 2002:ad4:5ba6:0:b0:623:5c93:77eb with SMTP id 6-20020ad45ba6000000b006235c9377ebmr22037706qvq.13.1688473699061;
        Tue, 04 Jul 2023 05:28:19 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id oj2-20020a056214440200b00631fc149a19sm1667137qvb.110.2023.07.04.05.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 05:28:18 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 4 Jul 2023 08:28:08 -0400 (EDT)
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
cc:     Jonathan Corbet <corbet@lwn.net>,
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
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 08/10] Documentation: admin-guide: Add riscv
 sysctl_perf_user_access
In-Reply-To: <20230703124647.215952-9-alexghiti@rivosinc.com>
Message-ID: <72d2ad7a-601a-a06a-5587-3843971dddf3@maine.edu>
References: <20230703124647.215952-1-alexghiti@rivosinc.com> <20230703124647.215952-9-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On Mon, 3 Jul 2023, Alexandre Ghiti wrote:

> -=================================
> +perf_user_access (arm64 and riscv only)
> +=======================================

so I complained about this when support for this went in for arm64.

Why do we have two separate ways of getting this info, one for x86 and one 
for arm64/riscv?

Could we get x86 patched to use the same interface?

It's a pain for tool users to have to maintain multiple code paths because 
the various architectures can't agree on how to export this info to 
userspace.

Vince
