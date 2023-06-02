Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6627BC77B7A
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jun 2023 15:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbjFBPLm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Jun 2023 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbjFBPLk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jun 2023 11:11:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D6FE52
        for <linux-perf-users@vger.kernel.org>; Fri,  2 Jun 2023 08:11:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b01d3bb571so11483075ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jun 2023 08:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685718661; x=1688310661;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFjFf9QHgSHlj44B9KI6vj2WvMIUXClf6uC8Orp896M=;
        b=sZOmeXFx40HznLvZP3MtBtdm+lGPllVCu2O5BSqzyyMxXUEMK4UTbDUNRUl7DLtRnA
         klyFQh/2w5mnjdVujmROdH4EzHFRagXr5W/wbjs5nE+JMafxvCA9EVWbv+Ifno8XvG7Z
         xWRL+65CiBVxpO6a+ZS6ZiwdchnAF4spnitJC/5spZn8nFVb1BnTm29afQDct3BcKr7d
         4fDBkjkUlMgYjZrFZbv8nhOELLLwUYmNLHDubDpxT548HljZzkVQzttCA65dKJXtogJq
         YvmE0geSJdLx5qj/rddqcz79+a9+KilywkF0gK7bGYfYgXsVvzh+hJM2xQSpQR/qw7fD
         izBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685718661; x=1688310661;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFjFf9QHgSHlj44B9KI6vj2WvMIUXClf6uC8Orp896M=;
        b=aHRa/rkkd7rUdsFa12573ZbhsATyCf2EU93xgKdrQnYUsYKp3hrtcxBqJIJ1+fr3i0
         CZ568uIeu58VZFnV/SD5TD30m9zFOMUolMm6POPMo7IV4Et+KYpf8tEnTuOTaKNCy8Id
         vpVMipzvbxpykTJS9acz0hSEofnF9imuuruadwvfN4Xplcos2t9KJ4eeHL4zwtsGG72q
         29gWqrRBDew7x+3Du+ezeCpqNYUuEELkl+NfElz3VqVDmpV66pABUuI/i5HUtDO2AaiB
         EIZILa7uNAXjVU9QVuazcubBYswxRPiBscII2Wc4JDoTmvHHSVAuErzEOgTo5X0VSeBi
         PWpg==
X-Gm-Message-State: AC+VfDyP9TFyCzktptfRUK4XTKN9mrUv1dpxOVItmJ4y7zcQdQH8ZSj2
        pzrGlev67jLhn0vy/DYe2KRkbXU9BK2KVc+vgxA=
X-Google-Smtp-Source: ACHHUZ5m9nXzekMPUkJhtVrD6dDGKXCV96hCHhEhhL18NuaQnxAQmnEqUiIBBKbi4QiZM8Xq4hhD8g==
X-Received: by 2002:a17:902:dac4:b0:1ac:859a:5b5a with SMTP id q4-20020a170902dac400b001ac859a5b5amr332989plx.0.1685718661326;
        Fri, 02 Jun 2023 08:11:01 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902a38400b0019a5aa7eab0sm1511912pla.54.2023.06.02.08.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:11:00 -0700 (PDT)
In-Reply-To: <20230601095355.1168910-1-ism.hong@gmail.com>
References: <20230601095355.1168910-1-ism.hong@gmail.com>
Subject: Re: [PATCH] riscv: perf: Fix callchain parse error with kernel
 tracepoint events
Message-Id: <168571785998.17076.15304236067157396048.b4-ty@rivosinc.com>
Date:   Fri, 02 Jun 2023 07:57:39 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     ism.hong@realtek.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ism Hong <ism.hong@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On Thu, 01 Jun 2023 17:53:55 +0800, Ism Hong wrote:
> For RISC-V, when tracing with tracepoint events, the IP and status are
> set to 0, preventing the perf code parsing the callchain and resolving
> the symbols correctly.
> 
>  ./ply 'tracepoint:kmem/kmem_cache_alloc { @[stack]=count(); }'
>  @:
>  { <STACKID4294967282> }: 1
> 
> [...]

Applied, thanks!

[1/1] riscv: perf: Fix callchain parse error with kernel tracepoint events
      https://git.kernel.org/palmer/c/9a7e8ec0d4cc

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

