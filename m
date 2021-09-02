Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ADBC432BE
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 12:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49507610CD
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 12:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhIBMXX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 08:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234098AbhIBMXX (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Sep 2021 08:23:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9018F6054E;
        Thu,  2 Sep 2021 12:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630585345;
        bh=LtO9so53QFcq+GSVqeOS9+q6OqRT7pG2sQXE1iTcrqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+arjeBtP60Jc0aWJJ3X8l1UHnzxL6ArOqmFjNAFMJkA2xQHDAyurmji05dmCS0AX
         ASrFCM88WJSxodnXXqw+ddL39T9QoJigLw9bzaWIRNlB7i2Pirod+wARCRJpLS5P4N
         AeVxCMM1EKx1ewf9T8Vye/Gmza39Mg3b8VCu10W+jJ0zkG98iK0vIMMEj4REPVhg4O
         27wIWarQJD2ZWL9Etr2pnkCBKT1Mz/JjmIcql9GVL7bPRVqKAy9XSbypJEDq7CsOwt
         brn4AjNL6ruUIx2V8PdrY1ek9izEaa3/YTQnwO3NZ7xWiL0sJqWXfSqtYpHgZjIBwC
         RizJuqgWYfreg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5708F4007E; Thu,  2 Sep 2021 09:22:21 -0300 (-03)
Date:   Thu, 2 Sep 2021 09:22:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <YTDB/VuANx5c+5sk@kernel.org>
References: <20210902081800.550016-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902081800.550016-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 02, 2021 at 04:18:00PM +0800, Leo Yan escreveu:
> When build perf tool with passing option 'CORESIGHT=1' explicitly, if
> the feature test fails for library libopencsd, the build doesn't
> complain the feature failure and continue to build the tool with
> disabling the CoreSight feature insteadly.
> 
> This patch changes the building behaviour, when build perf tool with the
> option 'CORESIGHT=1' and detect the failure for testing feature
> libopencsd, the build process will be aborted and it shows the complaint
> info.

Thanks, added some committer notes to show that it now works:

commit 8fb36b1f54873870262810d3db10526559e1d6c2
Author: Leo Yan <leo.yan@linaro.org>
Date:   Thu Sep 2 16:18:00 2021 +0800

    perf build: Report failure for testing feature libopencsd
    
    When build perf tool with passing option 'CORESIGHT=1' explicitly, if
    the feature test fails for library libopencsd, the build doesn't
    complain the feature failure and continue to build the tool with
    disabling the CoreSight feature insteadly.
    
    This patch changes the building behaviour, when build perf tool with the
    option 'CORESIGHT=1' and detect the failure for testing feature
    libopencsd, the build process will be aborted and it shows the complaint
    info.
    
    Committer testing:
    
    First make sure there is no opencsd library installed:
    
      $ rpm -qa | grep -i csd
      $ sudo rm -rf `find /usr/local -name "*csd*"`
      $ find /usr/local -name "*csd*"
      $
    
    Then cleanup the perf build output directory:
    
      $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ;
      $
    
    And try to build explicitely asking for coresight:
    
      $ make O=/tmp/build/perf CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin
      make: Entering directory '/var/home/acme/git/perf/tools/perf'
        BUILD:   Doing 'make -j24' parallel build
        HOSTCC  /tmp/build/perf/fixdep.o
        HOSTLD  /tmp/build/perf/fixdep-in.o
        LINK    /tmp/build/perf/fixdep
      Makefile.config:493: *** Error: No libopencsd library found or the version is not up-to-date. Please install recent libopencsd to build with CORESIGHT=1.  Stop.
      make[1]: *** [Makefile.perf:238: sub-make] Error 2
      make: *** [Makefile:113: install-bin] Error 2
      make: Leaving directory '/var/home/acme/git/perf/tools/perf'
      $
    
    Now install the opencsd library present in Fedora 34:
    
      $ sudo dnf install opencsd-devel
      <SNIP>
      Installed:
        opencsd-1.0.0-1.fc34.x86_64 opencsd-devel-1.0.0-1.fc34.x86_64
      Complete!
      $
    
    Try again building with coresight:
    
      $ make O=/tmp/build/perf CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin
      make: Entering directory '/var/home/acme/git/perf/tools/perf'
        BUILD:   Doing 'make -j24' parallel build
      Makefile.config:493: *** Error: No libopencsd library found or the version is not up-to-date. Please install recent libopencsd to build with CORESIGHT=1.  Stop.
      make[1]: *** [Makefile.perf:238: sub-make] Error 2
      make: *** [Makefile:113: install-bin] Error 2
      make: Leaving directory '/var/home/acme/git/perf/tools/perf'
      $
    
    Since Fedora 34 is pretty recent, one assumes we need to get it from its
    upstream git repository, use rpm to find where that is:
    
      $ rpm -q --qf "%{URL}\n" opencsd
      https://github.com/Linaro/OpenCSD
      $
    
    Go there, clone the repo, build it and install into /usr/local, then try
    again:
    
      $ cd ~acme/git/perf
      $ make O=/tmp/build/perf VF=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin | grep -i opencsd
      ...                    libopencsd: [ on  ]
        PERF_VERSION = 5.14.g454719f67a3d
      $ export LD_LIBRARY_PATH=/usr/local/lib
      $ ldd ~/bin/perf | grep opencsd
            libopencsd_c_api.so.1 => /usr/local/lib/libopencsd_c_api.so.1 (0x00007f28f78a4000)
            libopencsd.so.1 => /usr/local/lib/libopencsd.so.1 (0x00007f28f6a2e000)
      $
    
    Now it works.
    
    Requested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Signed-off-by: Leo Yan <leo.yan@linaro.org>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: James Clark <james.clark@arm.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
    Cc: Mike Leach <mike.leach@linaro.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
    Cc: coresight@lists.linaro.org
    Link: http://lore.kernel.org/lkml/20210902081800.550016-1-leo.yan@linaro.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b051c0c312c5243a..b66cf128cbc76d07 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -489,6 +489,8 @@ ifdef CORESIGHT
         CFLAGS += -DCS_RAW_PACKED
       endif
     endif
+  else
+    dummy := $(error Error: No libopencsd library found or the version is not up-to-date. Please install recent libopencsd to build with CORESIGHT=1)
   endif
 endif
 
