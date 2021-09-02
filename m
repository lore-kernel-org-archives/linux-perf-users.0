Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC05EC432BE
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CABF3610D2
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 12:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhIBMqf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 08:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344508AbhIBMqe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Sep 2021 08:46:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD047C061575
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Sep 2021 05:45:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d17so1094984plr.12
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Sep 2021 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aLUCaxfHoqaYw4dc2BPnEWZ4Nj1yQ7MkEOLJcpw995o=;
        b=pRDMNEmiII3b8vVMf6cC55QX+Rhpnv2tcvRa9eaLtVUbY+dipRcupJvD96OeOfBIcH
         VEckmb5wWhnU/Gn7K4EKCJlmRxzhn4p++hfMqzbKYLlVJ8Yo0NTIPJqgXp/GvaY0nR/W
         Pm24e76co7SMNlD/02EIWaT2uC1lrf1ZYbp4LJHT2MoRLfvmSTVVJTh4cD3g4whWmzMW
         KrXPHbfsx9B2mJXtmUf2YxEJZkKEyUWE/WnNT5WeKNtiNxHqaX846sAxIabLhfvg6zT8
         mGUsGlMcYJR9Yb4RQx5n2HMbdUoyp1bvTFle96hvwU3RrpPIKWuZGEWAxCQRTSU/3OpQ
         bNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aLUCaxfHoqaYw4dc2BPnEWZ4Nj1yQ7MkEOLJcpw995o=;
        b=V39voxRO9aoVN+s+TOr36XJ+If0WbWa8oCEHttH5WOoLiGZ1NWoq8KCSmvwX4tWUxb
         2KiM+6rRF4O7hdX5SynhR8PrJm5estCyoj1iUH4ZTigjgOeMsh4kYygT0buz31F3niQu
         yi39zsysT4jMIPdwiwMPDuGPMmoPYzUSNgpXR/sE7/C6QXENaZbaQqjSm6diyMK9DlI4
         6efevnkskKPKHzLjOMiPtz243nnMFtZJkMl2o1yMtYLSBDixj7fJGXEGQlcWTmaCt6XM
         8HQM58w4uDO3KiTb/MtvHsZn1crrS9jQDKKjtj8toDciZI/mAEjjqcrWFBpe9V/dWZrr
         it+g==
X-Gm-Message-State: AOAM532aTuBYouzY7QGmUrNLt+M6xYUgkCV3SD0E2FFxbPBg0TYIGKiC
        zgU/n3P/cqpCRRxJIH1x9J7xmQ==
X-Google-Smtp-Source: ABdhPJxvnnsb9uBsZrCGXpIlWksIuIjmbrcDWBBd8+sJmXUkAzCqvtsV38cL+n+ih00t9/6e4/C/JA==
X-Received: by 2002:a17:902:724b:b0:131:ab33:1e4e with SMTP id c11-20020a170902724b00b00131ab331e4emr2779233pll.12.1630586735126;
        Thu, 02 Sep 2021 05:45:35 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id s192sm2763072pgc.23.2021.09.02.05.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 05:45:34 -0700 (PDT)
Date:   Thu, 2 Sep 2021 20:45:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf build: Report failure for testing feature
 libopencsd
Message-ID: <20210902124529.GH303522@leoy-ThinkPad-X240s>
References: <20210902081800.550016-1-leo.yan@linaro.org>
 <YTDB/VuANx5c+5sk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTDB/VuANx5c+5sk@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 02, 2021 at 09:22:21AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 02, 2021 at 04:18:00PM +0800, Leo Yan escreveu:
> > When build perf tool with passing option 'CORESIGHT=1' explicitly, if
> > the feature test fails for library libopencsd, the build doesn't
> > complain the feature failure and continue to build the tool with
> > disabling the CoreSight feature insteadly.
> > 
> > This patch changes the building behaviour, when build perf tool with the
> > option 'CORESIGHT=1' and detect the failure for testing feature
> > libopencsd, the build process will be aborted and it shows the complaint
> > info.
> 
> Thanks, added some committer notes to show that it now works:
> 
> commit 8fb36b1f54873870262810d3db10526559e1d6c2
> Author: Leo Yan <leo.yan@linaro.org>
> Date:   Thu Sep 2 16:18:00 2021 +0800
> 
>     perf build: Report failure for testing feature libopencsd
>     
>     When build perf tool with passing option 'CORESIGHT=1' explicitly, if
>     the feature test fails for library libopencsd, the build doesn't
>     complain the feature failure and continue to build the tool with
>     disabling the CoreSight feature insteadly.
>     
>     This patch changes the building behaviour, when build perf tool with the
>     option 'CORESIGHT=1' and detect the failure for testing feature
>     libopencsd, the build process will be aborted and it shows the complaint
>     info.
>     
>     Committer testing:
>     
>     First make sure there is no opencsd library installed:
>     
>       $ rpm -qa | grep -i csd
>       $ sudo rm -rf `find /usr/local -name "*csd*"`
>       $ find /usr/local -name "*csd*"
>       $
>     
>     Then cleanup the perf build output directory:
>     
>       $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ;
>       $
>     
>     And try to build explicitely asking for coresight:
>     
>       $ make O=/tmp/build/perf CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin

The build command contains duplicate 'O=/tmp/build/perf'.

>       make: Entering directory '/var/home/acme/git/perf/tools/perf'
>         BUILD:   Doing 'make -j24' parallel build
>         HOSTCC  /tmp/build/perf/fixdep.o
>         HOSTLD  /tmp/build/perf/fixdep-in.o
>         LINK    /tmp/build/perf/fixdep
>       Makefile.config:493: *** Error: No libopencsd library found or the version is not up-to-date. Please install recent libopencsd to build with CORESIGHT=1.  Stop.
>       make[1]: *** [Makefile.perf:238: sub-make] Error 2
>       make: *** [Makefile:113: install-bin] Error 2
>       make: Leaving directory '/var/home/acme/git/perf/tools/perf'
>       $
>     
>     Now install the opencsd library present in Fedora 34:
>     
>       $ sudo dnf install opencsd-devel
>       <SNIP>
>       Installed:
>         opencsd-1.0.0-1.fc34.x86_64 opencsd-devel-1.0.0-1.fc34.x86_64
>       Complete!
>       $
>     
>     Try again building with coresight:
>     
>       $ make O=/tmp/build/perf CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin
>       make: Entering directory '/var/home/acme/git/perf/tools/perf'
>         BUILD:   Doing 'make -j24' parallel build
>       Makefile.config:493: *** Error: No libopencsd library found or the version is not up-to-date. Please install recent libopencsd to build with CORESIGHT=1.  Stop.
>       make[1]: *** [Makefile.perf:238: sub-make] Error 2
>       make: *** [Makefile:113: install-bin] Error 2
>       make: Leaving directory '/var/home/acme/git/perf/tools/perf'
>       $
>     
>     Since Fedora 34 is pretty recent, one assumes we need to get it from its
>     upstream git repository, use rpm to find where that is:
>     
>       $ rpm -q --qf "%{URL}\n" opencsd
>       https://github.com/Linaro/OpenCSD
>       $
>     
>     Go there, clone the repo, build it and install into /usr/local, then try
>     again:
>     
>       $ cd ~acme/git/perf
>       $ make O=/tmp/build/perf VF=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin | grep -i opencsd
>       ...                    libopencsd: [ on  ]
>         PERF_VERSION = 5.14.g454719f67a3d
>       $ export LD_LIBRARY_PATH=/usr/local/lib
>       $ ldd ~/bin/perf | grep opencsd
>             libopencsd_c_api.so.1 => /usr/local/lib/libopencsd_c_api.so.1 (0x00007f28f78a4000)
>             libopencsd.so.1 => /usr/local/lib/libopencsd.so.1 (0x00007f28f6a2e000)
>       $
>     
>     Now it works.

Good to know the very detailed steps.  Thanks a lot for writing up
this!

Leo
