Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C157DC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Jul 2022 22:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiGEWmE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Jul 2022 18:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGEWmD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Jul 2022 18:42:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B793011C01;
        Tue,  5 Jul 2022 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657060922; x=1688596922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dcYq/1YuB/JBMWYqjYqQ5YtRYg69/7SayXrUgOGsr6o=;
  b=dV1tdJEA9imihPnvWVEj5Wr4tYeP+6OeU2IPWGdMQ4P+Bf8J9aQBBhwX
   0DtP74uI9D8tyxL8uRRbsjOwObn+UMolW0nnDQVfHGeVipnzwBLmTJYel
   i7Qhi0adXLdXKde6TJsvpax9yk0K0+DMA9Hvr5RGeHfJnoI4DStOvCIK3
   wwXtQaAN7VIde5SNoi5Xc/jtCva79UdQpgIUzl5ntE3D6bMCDOtyVvpv6
   sKCGa3pDr9WbGvH/degjIsEUuFsGO2AsHUPsDUIzbwI9NBZrwWfIGQIXS
   zkyssITR6wpSNpDNDCn2NYKwzS46bLNkO55zdhqHJW7vCDP3JHbdcUj2b
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266576420"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266576420"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 15:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="593089358"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2022 15:42:00 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8rF1-000Jfc-BY;
        Tue, 05 Jul 2022 22:41:59 +0000
Date:   Wed, 6 Jul 2022 06:41:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH 14/14] perf test: Add relevant documentation about
 CoreSight testing
Message-ID: <202207060615.3jB32CbT-lkp@intel.com>
References: <20220701120804.3226396-15-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701120804.3226396-15-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on acme/perf/core]
[also build test WARNING on tip/perf/core linus/master v5.19-rc5 next-20220705]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/carsten-haitzler-foss-arm-com/perf-test-Refactor-shell-tests-allowing-subdirs/20220701-210837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/trace/coresight/coresight-perf.rst:104: WARNING: Inline emphasis start-string without end-string.

vim +104 Documentation/trace/coresight/coresight-perf.rst

    98	
    99	    CoreSight / ASM Pure Loop
   100	    CoreSight / Memcpy 16k 10 Threads
   101	    CoreSight / Thread Loop 10 Threads - Check TID
   102	    ...
   103	
 > 104	These perf record tests will not run if the tool binaries do not exist
   105	in tests/shell/coresight/*/ and will be skipped. If you do not have
   106	CoreSight support in hardware then either do not build perf with
   107	CoreSight support or remove these binaries in order to not have these
   108	tests fail and have them skip instead.
   109	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
