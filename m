Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37554ECAAD5
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Sep 2022 10:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIHKQp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Sep 2022 06:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIHKQo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Sep 2022 06:16:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBF1AC00FC;
        Thu,  8 Sep 2022 03:16:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F36DA14BF;
        Thu,  8 Sep 2022 03:16:48 -0700 (PDT)
Received: from [10.162.41.8] (unknown [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 265F23F71A;
        Thu,  8 Sep 2022 03:16:37 -0700 (PDT)
Message-ID: <36c5c95c-b5e7-388f-727b-7864ef3fe41f@arm.com>
Date:   Thu, 8 Sep 2022 15:46:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 6/7] arm64/perf: Add BRBE driver
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     kbuild-all@lists.01.org, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20220908051046.465307-7-anshuman.khandual@arm.com>
 <202209081717.00OiPpzm-lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202209081717.00OiPpzm-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 9/8/22 14:53, kernel test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on acme/perf/core]
> [also build test ERROR on tip/perf/core arm64/for-next/core linus/master v6.0-rc4 next-20220907]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220908-131425
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
> config: arm64-buildonly-randconfig-r002-20220907 (https://download.01.org/0day-ci/archive/20220908/202209081717.00OiPpzm-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/5b70e42a715860504646cb5bd1788ddb823dd50b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220908-131425
>         git checkout 5b70e42a715860504646cb5bd1788ddb823dd50b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/perf/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>

These build problems will not happen with the prerequisite patches as mentioned
in the cover letter.

https://lore.kernel.org/all/20220824044822.70230-1-anshuman.khandual@arm.com/

https://lore.kernel.org/all/20220906084414.396220-1-anshuman.khandual@arm.com/
