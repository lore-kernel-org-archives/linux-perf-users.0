Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7071CC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 06:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJFGCD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 02:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJFGCC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 02:02:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417B95FAD0
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Oct 2022 23:02:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f193so1048703pgc.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Oct 2022 23:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2XrgiIqxfYqeYgpiX2f0Tk/oR7IHm7sRfeEC295sJaA=;
        b=mSp6cxf6NE0+p5rZyZdvKHmAxBMiREVppMlFoZL89AyaB8ynlQrw6/S5Gw0RDmksR+
         ww/LJh7kbYjyYNTu8eIpaZ1VPoncaP5x0gFXTFJKWM4Zsj+xGE9P22KvOrtceZiEtdBG
         hvFB6VXjCKB4DOxfiqgL41mBeyagCEqqz5IpRjhw97CH6bRE+8Za0UhCNXcUkEQMPkcV
         GWkyLTqGH+Gjik8aPHxxBfUjCbICLaErV4mpkpp447XJ4P5JrQoCWuCf5Dta+1SZ4+HA
         83WKmsQL8LS5cmviGopTTi6I/PGgDbyjWhFLDMM/0F0VTTh4Ei4MUncGXU41rdzgRha1
         IIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2XrgiIqxfYqeYgpiX2f0Tk/oR7IHm7sRfeEC295sJaA=;
        b=Om6vxgwLxgqat5KmS/9IN67Yvz/AEJtWxo/97xeRkvNJdT193J6RVsyRL0yACQA3sf
         TwH9ULceWDWwvNagLmBYbi5t7ArIzhPXbColKZ8UfnLsg9+mn7tp9zgLERbheFr8dsvv
         ucKPEEDiMXES6lAvNMDOmEPHNJyGtgaRrjZCsrFR0qwPEkohu+uDuOkjtSfUrg9jco6Y
         fRgp4HK1wL90N8X4BEffFrVt5NNwF5OM+9gkphmGa95ri73bF6R4Z0PLOejmHQXmMOV9
         x6bpSE6ZQGJw3SLSgbC/3SgPiQFLohKkBCzx+TKBmhR6rBAdj5DaYMR31ajJWkODaEqg
         tv4g==
X-Gm-Message-State: ACrzQf2LnVrgeb+ZQl+iW+x5EeflkNXsWULwO30kb4JZYlUe5Y7S5m0J
        vqtPzfpkYtvqYy9EgylQ4AMXew==
X-Google-Smtp-Source: AMsMyM6wgFj5dXqJGhfYSFIQV1/rzUd29qZrU9WThiVMiWd41kVQTxh8yFZOW+g/6arD9OtQbY0rXw==
X-Received: by 2002:a63:86c2:0:b0:45a:2045:471 with SMTP id x185-20020a6386c2000000b0045a20450471mr2990557pgd.447.1665036120636;
        Wed, 05 Oct 2022 23:02:00 -0700 (PDT)
Received: from leoy-yangtze.lan (45.78.17.119.16clouds.com. [45.78.17.119])
        by smtp.gmail.com with ESMTPSA id w2-20020a623002000000b00538056de6ecsm11938015pfw.52.2022.10.05.23.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 23:01:59 -0700 (PDT)
Date:   Thu, 6 Oct 2022 14:01:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf mem: Fix -C option behavior for perf mem record
Message-ID: <Yz5vUmZtQzYNRt73@leoy-yangtze.lan>
References: <20221004200211.1444521-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004200211.1444521-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Oct 04, 2022 at 01:02:11PM -0700, Namhyung Kim wrote:
> The -C/--cpu option was maily for report but it also affected record as
> it ate the option.  So users needed to use "--" after perf mem record to
> pass the info to the perf record properly.
> 
> Check if this option is set for record, and pass it to the actual perf
> record.
> 
> Before)
>   $ sudo perf --debug perf-event-open mem record -C 0 2>&1 | grep -a sys_perf_event_open
>   ...
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 4
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 6
>   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 7
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 9
>   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 10
>   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 11
>   ...
> 
> After)
>   $ sudo perf --debug perf-event-open mem record -C 0 2>&1 | grep -a sys_perf_event_open
>   ...
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 4
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
> 
> Cc: Leo Yan <leo.yan@linaro.org>
> Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

The change LGTM:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
