Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B280BC2FC0E
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Aug 2023 09:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349504AbjHQJYQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Aug 2023 05:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349552AbjHQJYE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Aug 2023 05:24:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2254E1FE2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Aug 2023 02:24:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc5acc627dso51120065ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Aug 2023 02:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692264242; x=1692869042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KPbt6Jr4uE4XqkroaxTN40QvL9ZRwcamAUU0Alom8Ec=;
        b=rI6iWAqTfcbFXuRszbw0kH7S7Efm8TDPPaTRvQfqQAODkeiPGEer1xsAgnG42yVQr9
         L3URCg142nt5JV7OT34bh5MdV49Y/N9+vDCDkRWeow95/CTCqjeWhbS+mjW1SKxpI+D9
         J9WzjfnihA0HQ3OQ22c1eO5ymIPPiWyFE5N0svVLR+mDVK7ijU0cJsuqAty+bKyRlhSv
         iDYIQEtErdogHHIlKmTtsWRXCgeDabvOQyFBJjASvlFsk/Z9c3v+5wNsoGVLF9E3UmxC
         iHBnf1Bbvrssr9ej6ikHkdY6q0moHRV3UoyFuEbAsd0tnfbURsGaT6Ui11pgMfahVMUN
         f6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264242; x=1692869042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPbt6Jr4uE4XqkroaxTN40QvL9ZRwcamAUU0Alom8Ec=;
        b=WikR2YDMj8D+50BtGhE8BvEoyyaYPmKooC4GiZHdU4fvgJiigYODSqsSv8NxbuzW8F
         fnDW5q/5Li2UkUaHP5sAlpbiLokmhvt1FhacuehtJCwnj/zFCYS3I5cJWC62Z+29IZcT
         DoADmILBpaKykShAz6XMl/sh4eB0nKkJdOSrPp07UENH0DEFLM+Nl7tCcaK0haSUz8lH
         FIXu3zyscCtD4TVdf4lhITujMd25asuXqSRmTo5cF7Lbq6J0WtrdEzo3t1bmbOFwgAfV
         krqIwUI4EU5rG3P4c/0Q0w5RP8Ll5u57dDPzkZgZE8IBjB18MxmL23j34wjnIXC2alXx
         NJOg==
X-Gm-Message-State: AOJu0YzvBIN+yvuzZv6t1FmT7CeYseu7YKJzbV6w652E1vU+i5aQfFoR
        RgHR7LqbP1BURsu7Ij9bg9IsGQ==
X-Google-Smtp-Source: AGHT+IFk70YzOl9gPu9ed6IJstA4fhK4tebZKjgbqrU2bEbbFU9mBw3Ch4/wFSeVGfyDH7rTfUpgxw==
X-Received: by 2002:a17:902:bd89:b0:1b8:95a1:847c with SMTP id q9-20020a170902bd8900b001b895a1847cmr3827038pls.40.1692264242560;
        Thu, 17 Aug 2023 02:24:02 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id y22-20020a1709027c9600b001b8a85489a3sm14600942pll.262.2023.08.17.02.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 02:24:02 -0700 (PDT)
Date:   Thu, 17 Aug 2023 17:23:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Eric Lin <eric.lin@sifive.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/6] perf parse-regs: Refactor architecture functions
Message-ID: <20230817092353.GB176609@leoy-huanghe.lan>
References: <20230606014559.21783-1-leo.yan@linaro.org>
 <CAP-5=fV1m440mKc0R=m5C4N2NtoiixchtnpX2eR3PA_5hXbqEQ@mail.gmail.com>
 <ZNvCxM/ULdUfzHtR@kernel.org>
 <ZNvHx+KxIL6JzEl/@kernel.org>
 <ZNvJdsVmmAWLmfH6@kernel.org>
 <ZNvKjeFkXY8ezf9e@kernel.org>
 <20230816020715.GA135657@leoy-huanghe.lan>
 <ZNy3D6DV3Q9YjxKd@kernel.org>
 <ZNy3jg7xxBp4161E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNy3jg7xxBp4161E@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 16, 2023 at 08:48:30AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > And move that to perf-tools-next, we can go on from there.
> > 
> > The above is because we don't define CONFIG_PERF_REGS for these
> > architectures and thus that variable ends up not being used, so I'm
> > fixing up like below, in the cset where you made DWARF_MINIMAL_REGS
> > receive the arch parameter.
> 
> I added this to the cset commit message:
> 
> Committer notes:
> 
> Make DWARF_MINIMAL_REGS() an inline function, so that we can use the
> __maybe_unused attribute for the 'arch' parameter, as this will avoid a
> build failure when that variable is unused in the callers. That happens
> when building on unsupported architectures, the ones without
> HAVE_PERF_REGS_SUPPORT defined.

Looks good to me, thanks for fixing.

Leo
