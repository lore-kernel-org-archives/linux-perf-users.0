Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED19C11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 13:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 239E86141D
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 13:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhGANgn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGANgn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 09:36:43 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7868C061762
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jul 2021 06:34:11 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e20so6156864pgg.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jul 2021 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SnACoHGHKKSUmroSwFVGCmNRDhzoxlH9nVuiVepkb1o=;
        b=zCKVemtDZL3ehp7PWxjcfKDxDN51pmQ2ck1pts0xLqfsFeTIRas88OmbvMIzA4dFvo
         M8C2rBowwV3bq02pJRqrx6XT6BjR29xCvuV7POzUMI64aKMRWLZ+0Zq3ucUE2jumf6iy
         S1rBKYMUWmMh68QFry//g+ZREkHkE1VYaIXTNCg2D4LXneXuiYJExU7IVu5QXgDJGeqa
         xccvbodoy4FwRziHM0OglEbzyC9lFbIW1M8fV1Yjwhn/Mjk3aSY8bxsyTzx33X/h3z57
         AM/7uqC+nxvidyVV7fcMPb0xf5Oek8z+h27/YJPhcxOXeaX1PUr5tXsxCm5NUlkwx1b+
         7Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SnACoHGHKKSUmroSwFVGCmNRDhzoxlH9nVuiVepkb1o=;
        b=Va5FoaJ5aRdRBcz8Xar0g/oCnJ4wekHQclpFgbfmfN7B4Zxx+QT2opWNBbli4dz8Qu
         r2gMhYE61A7yhXbFMOn6xTPx+Ku/umP/znfsZUwrQ5Prl9c7v9MFPyjw8HGvGSf/Xt56
         imFIANzvoIQeqTzLU1of3lmKHEPvIyuRuXLhQ0DIslztfypDkP9i6tIGpabAmH3ndp8E
         vvk3HTOcq4WVyDP/FbvVhugoJ4pqszFR/Hlpjl9TGxUE5KeLGlGilQ2Hk1K3pgr8LZJs
         +e6YqRrelYmVqN7BlKQF7XOG+fa259m3Rt3GYwkA6Ry3AqzHGPk6aGLZpDPcbJYaJSio
         y1Ew==
X-Gm-Message-State: AOAM532P72cK5U8xwHrZ779sEdJz3j0Jb3wYnooAz/gaaPGAHlyO5qex
        zkPjaTMdqFwtCw5lvKWOwPB3Bg==
X-Google-Smtp-Source: ABdhPJykFDVO5eAJi3DVkcgV0nKVtx9Poi5lkDhj2P0Tz4JkhKgYevSdgvCDB7Pae/1N5b7+cy/IBw==
X-Received: by 2002:a62:4e96:0:b029:305:a36c:fc6 with SMTP id c144-20020a624e960000b0290305a36c0fc6mr35402pfb.70.1625146451190;
        Thu, 01 Jul 2021 06:34:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id gl17sm10080799pjb.13.2021.07.01.06.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 06:34:10 -0700 (PDT)
Date:   Thu, 1 Jul 2021 21:34:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cs-etm: Delay decode of non-timeless data until
 cs_etm__flush_events()
Message-ID: <20210701133404.GB91264@leoy-ThinkPad-X240s>
References: <20210609130421.13934-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609130421.13934-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 09, 2021 at 04:04:20PM +0300, James Clark wrote:
> Currently, timeless mode starts the decode on PERF_RECORD_EXIT, and
> non-timeless mode starts decoding on the fist PERF_RECORD_AUX record.
> 
> This can cause the "data has no samples!" error if the first
> PERF_RECORD_AUX record comes before the first (or any relevant)
> PERF_RECORD_MMAP2 record because the mmaps are required by the decoder
> to access the binary data.
> 
> This change pushes the start of non-timeless decoding to the very end of
> parsing the file. The PERF_RECORD_EXIT event can't be used because it
> might not exist in system-wide or snapshot modes.
> 
> I have not been able to find the exact cause for the events to be
> intermittently in the wrong order in the basic scenario:
> 
> 	perf record -e cs_etm/@tmc_etr0/u top
> 
> But it can be made to happen every time with the --delay option. This is
> because "enable_on_exec" is disabled, which causes tracing to start
> before the process to be launched is exec'd. For example:
> 
> 	perf record -e cs_etm/@tmc_etr0/u --delay=1 top
> 	perf report -D | grep 'AUX\|MAP'
> 
> 	0 16714475632740 0x520 [0x40]: PERF_RECORD_AUX offset: 0 size: 0x30 flags: 0 []
> 	0 16714476494960 0x5d0 [0x40]: PERF_RECORD_AUX offset: 0x30 size: 0x30 flags: 0 []
> 	0 16714478208900 0x660 [0x40]: PERF_RECORD_AUX offset: 0x60 size: 0x30 flags: 0 []
> 	4294967295 16714478293340 0x700 [0x70]: PERF_RECORD_MMAP2 8712/8712: [0x557a460000(0x54000) @ 0 00:17 5329258 0]: r-xp /usr/bin/top
> 	4294967295 16714478353020 0x770 [0x88]: PERF_RECORD_MMAP2 8712/8712: [0x7f86f72000(0x34000) @ 0 00:17 5214354 0]: r-xp /usr/lib/aarch64-linux-gnu/ld-2.31.so
> 
> Another scenario in which decoding from the first aux record fails is a
> workload that forks. Although the aux record comes after 'bash', it
> comes before 'top', which is what we are interested in. For example:
> 
> 	perf record -e cs_etm/@tmc_etr0/u -- bash -c top
> 	perf report -D | grep 'AUX\|MAP'
> 
> 	4294967295 16853946421300 0x510 [0x70]: PERF_RECORD_MMAP2 8723/8723: [0x558f280000(0x142000) @ 0 00:17 5213953 0]: r-xp /usr/bin/bash
> 	4294967295 16853946543560 0x580 [0x88]: PERF_RECORD_MMAP2 8723/8723: [0x7fbba6e000(0x34000) @ 0 00:17 5214354 0]: r-xp /usr/lib/aarch64-linux-gnu/ld-2.31.so
> 	4294967295 16853946628420 0x608 [0x68]: PERF_RECORD_MMAP2 8723/8723: [0x7fbba9e000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
> 	0 16853947067300 0x690 [0x40]: PERF_RECORD_AUX offset: 0 size: 0x3a60 flags: 0 []
> 	...
> 	0 16853966602580 0x1758 [0x40]: PERF_RECORD_AUX offset: 0xc2470 size: 0x30 flags: 0 []
> 	4294967295 16853967119860 0x1818 [0x70]: PERF_RECORD_MMAP2 8723/8723: [0x5559e70000(0x54000) @ 0 00:17 5329258 0]: r-xp /usr/bin/top
> 	4294967295 16853967181620 0x1888 [0x88]: PERF_RECORD_MMAP2 8723/8723: [0x7f9ed06000(0x34000) @ 0 00:17 5214354 0]: r-xp /usr/lib/aarch64-linux-gnu/ld-2.31.so
> 	4294967295 16853967237180 0x1910 [0x68]: PERF_RECORD_MMAP2 8723/8723: [0x7f9ed36000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
> 
> A third scenario is when the majority of time is spent in a shared
> library that is not loaded at startup. For example a dynamically loaded
> plugin.
> 
> Testing
> =======
> 
> Testing was done by checking if any samples that are present in the
> old output are missing from the new output. Timestamps must be
> stripped out with awk because now they are set to the last AUX sample,
> rather than the first:
> 
> 	./perf script $4 | awk '!($4="")' > new.script
> 	./perf-default script $4 | awk '!($4="")' > default.script
> 	comm -13 <(sort -u new.script) <(sort -u default.script)
> 
> Testing showed that the new output is a superset of the old. When lines
> appear in the comm output, it is not because they are missing but
> because [unknown] is now resolved to sensible locations. For example
> last putp branch here now resolves to libtinfo, so it's not missing
> from the output, but is actually improved:
> 
> Old:
> 	top 305 [001]  1 branches:uH: 402830 _init+0x30 (/usr/bin/top.procps) => 404a1c [unknown] (/usr/bin/top.procps)
> 	top 305 [001]  1 branches:uH: 404a20 [unknown] (/usr/bin/top.procps) => 402970 putp@plt+0x0 (/usr/bin/top.procps)
> 	top 305 [001]  1 branches:uH: 40297c putp@plt+0xc (/usr/bin/top.procps) => 0 [unknown] ([unknown])
> New:
> 	top 305 [001]  1 branches:uH: 402830 _init+0x30 (/usr/bin/top.procps) => 404a1c [unknown] (/usr/bin/top.procps)
> 	top 305 [001]  1 branches:uH: 404a20 [unknown] (/usr/bin/top.procps) => 402970 putp@plt+0x0 (/usr/bin/top.procps)
> 	top 305 [001]  1 branches:uH: 40297c putp@plt+0xc (/usr/bin/top.procps) => 7f8ab39208 putp+0x0 (/lib/libtinfo.so.5.9)
> 
> In the following two modes, decoding now works and the "data has no
> samples!" error is not displayed any more:
> 
> 	perf record -e cs_etm/@tmc_etr0/u -- bash -c top
> 	perf record -e cs_etm/@tmc_etr0/u --delay=1 top
> 
> In snapshot mode, there is also an improvement to decoding. Previously
> samples for the 'kill' process that was used to send SIGUSR2 were
> completely missing, because the process hadn't started yet. But now
> there are additional samples present:
> 
> 	perf record -e cs_etm/@tmc_etr0/u --snapshot -a
> 	perf script
> 
> 		stress 19380 [003] 161627.938153:    1000000    instructions:uH:      aaaabb612fb4 [unknown] (/usr/bin/stress)
> 		  kill 19644 [000] 161627.938153:    1000000    instructions:uH:      ffffae0ef210 [unknown] (/lib/aarch64-linux-gnu/ld-2.27.so)
> 		stress 19380 [003] 161627.938153:    1000000    instructions:uH:      ffff9e754d40 random_r+0x20 (/lib/aarch64-linux-gnu/libc-2.27.so)
> 
> Also tested was the round trip of 'perf inject' followed by 'perf
> report' which has the same differences and improvements.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Excellent work, James!  I learned several things from it :)

I went through the testing cases one by one, have verified all
elaborated cases (but I don't verify injection cases):

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
