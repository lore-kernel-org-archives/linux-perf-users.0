Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FDCC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Mar 2022 10:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiCNKtt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiCNKtt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Mar 2022 06:49:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7546B1E3CF;
        Mon, 14 Mar 2022 03:48:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B7E3106F;
        Mon, 14 Mar 2022 03:48:39 -0700 (PDT)
Received: from [10.163.33.185] (unknown [10.163.33.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80CDB3F99C;
        Mon, 14 Mar 2022 03:48:32 -0700 (PDT)
Message-ID: <29ab721c-10bd-68e7-a1e0-8564e60f7584@arm.com>
Date:   Mon, 14 Mar 2022 16:18:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 05/10] perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on
 arm64 platform
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org
Cc:     kbuild-all@lists.01.org, Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220314055857.125421-6-anshuman.khandual@arm.com>
 <202203141608.b9LFCtgv-lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202203141608.b9LFCtgv-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 3/14/22 14:07, kernel test robot wrote:
>>> error: include/uapi/linux/perf_event.h: leak CONFIG_ARM64 to user-space
>    make[2]: *** [scripts/Makefile.headersinst:63: usr/include/linux/perf_event.h] Error 1
>    make[2]: Target '__headers' not remade because of errors.
>    make[1]: *** [Makefile:1277: headers] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:219: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.

I should have avoided CONFIG_ARM64 in the the header file which gets
duplicated for tools/include/.. Looking at this once again, platform
build wrappers are not really required for these arch overrides. These
arm64 branch types can co-exist with any other platform overrides when
they get added later on. Just that the branch type nomenclature should
include the platform name some where. Something like ..

PERF_BR_<ARCH>_<BRANCH_TYPE>

#define PERF_BR_ARM64_FIQ               PERF_BR_NEW_ARCH_1
#define PERF_BR_ARM64_DEBUG_HALT        PERF_BR_NEW_ARCH_2
#define PERF_BR_ARM64_DEBUG_EXIT        PERF_BR_NEW_ARCH_3
#define PERF_BR_ARM64_DEBUG_INST        PERF_BR_NEW_ARCH_4
#define PERF_BR_ARM64_DEBUG_DATA        PERF_BR_NEW_ARCH_5

Will do this change next time around.

- Anshuman
