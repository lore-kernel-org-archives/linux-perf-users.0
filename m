Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54D8C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 13:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiJFNRQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJFNRP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 09:17:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5303BA8CF7
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Oct 2022 06:17:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so4340977pjs.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Oct 2022 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=02+l5Dup8iobjnpzNvILInltP6SSg7vn8eRfMH1tN68=;
        b=PlPVDGcgoKADttm3GBAKtN6r3dpMaHZPrp4uNihBXrRA0gX7+ZEGw2m30nEhgc4zen
         if27Aj8YByw5pmYjuAx94Fg5iwlYpb4ePY64yrl4l0HMOlc4IgLI/O18ZSATsalraXWG
         N3+zGQaQRlAFctoD02AGFDi+WYwm3RMSLzxRnpqkBoru5yOy8t5TTV55e/gQkeZ+2kIO
         UaHGpRtwu0+rKZ/rPvVQVftkRIy94OUP1HRgujdOWVvBOa8kCoJDMaaqSNgD9onZAsvU
         1pS64n9i93ikIpW6tE/1kchE1MGeD6tuOzPabnGj5mI9wHwQFIASc2a0z1MUwxLLiX8P
         iA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=02+l5Dup8iobjnpzNvILInltP6SSg7vn8eRfMH1tN68=;
        b=JvFwS4H9nHgcWlyOfx/55TRKPVas5Al7NhJtluwquCHINjMm/6egU3YL0U8rdzRP6c
         U4Me69FBicfjIFtV6FS02FYFpNdkL4/vl59hWJjS4gvXeEvBb5OdQCoVQ66WuyVCVg6Z
         9eoTqLumFB5NSQ83x7g/ms0CErbLrcV+s4n40YZ+2oDNGH7AwvzjImFWOG3g1Ga1SsO1
         f77ujwPNNqHdzz/KELh+XpfU+5XkK3Ib1I50LDSHewhYX4jEEbQ6GLaGZmoQS9aG1KqB
         WBh6c4rLX4U1lcJQ6a6dG5y8bCjPXA24vCMcpSpYgZDMzsEcGxbhySbNUQd1NfuPdyPf
         8b4A==
X-Gm-Message-State: ACrzQf1xYnAwk+RwePiRD25RrEukIqVyyzqkN7KcgVbE7xkzwDACfNja
        YnSqJAzZyoUA03+HmHhYBi4Tjg==
X-Google-Smtp-Source: AMsMyM7E2jdAua9PflCTdfw9BxHq/H4xgwm6PVffFkhcNWwdGQyWaKpIZMKrkYdrJttA4awLNL+C8w==
X-Received: by 2002:a17:902:ced2:b0:17f:5eb2:cd72 with SMTP id d18-20020a170902ced200b0017f5eb2cd72mr4865973plg.162.1665062233764;
        Thu, 06 Oct 2022 06:17:13 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-202.hinet-ip.hinet.net. [211.75.219.202])
        by smtp.gmail.com with ESMTPSA id c92-20020a17090a496500b0020a11217682sm2840215pjh.27.2022.10.06.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:17:11 -0700 (PDT)
Date:   Thu, 6 Oct 2022 21:17:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5] perf test: Introduce script for data symbol testing
Message-ID: <Yz7VUaXs0bhimqsP@leoy-yangtze.lan>
References: <20221006101039.47870-1-leo.yan@linaro.org>
 <Yz65kF01XYLayp9E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz65kF01XYLayp9E@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 06, 2022 at 08:18:40AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> Replaced the one I had merged with v5 and added this:
> 
> Committer testing:
> 
>   [root@quaco ~]# grep -m1 "model name" /proc/cpuinfo
>   model name    : Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
>   [root@quaco ~]#
>   [root@quaco ~]# perf test -v "data symbol"
>   104: Test data symbol                                                :
>   --- start ---
>   test child forked, pid 192318
>   Compiling test program...
>   Recording workload...
>   [ perf record: Woken up 2 times to write data ]
>   [ perf record: Captured and wrote 0.389 MB /tmp/__perf_test.perf.data.LIuQl (5570 samples) ]
>   Cleaning up files...
>   test child finished with 0
>   ---- end ----
>   Test data symbol: Ok
>   [root@quaco ~]#
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> -------------
> 
> The verbose mode could show the 'perf report' output, I think, but this
> can be done later, if agreed.

Yeah, will add output logs for the test.

Thanks for picking up patch.  And thanks for Ravi's testing.

Thanks,
Leo
