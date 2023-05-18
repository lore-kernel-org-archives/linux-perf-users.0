Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D2EC77B7D
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 May 2023 16:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjERQDL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 May 2023 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjERQDL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 May 2023 12:03:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9206CE0;
        Thu, 18 May 2023 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684425788; x=1715961788;
  h=date:from:to:cc:subject:message-id;
  bh=AXO77ZTWE02Slm/DXTZbzth3nLGdhkVRlCi55ivDtfs=;
  b=Y3sqbo98ypo+G6UJVyfUa3WGpa/BempMQwuY4ErBtkAu8r9/TDcjUJiX
   UId2N9YvG8W5364RdLW3SFuyq9oe1iPPSPjq7QYEypU9drz5QkIthz9dK
   pRmYo84Ue7SZNzEOOqrITYya2X3PusTJ1g6MA2zVGLpCTWRr4ckS6o2JN
   Be2iJGlMBUCxvakpCQCvvgcmpkrE+qtvWkOGHZGsIIdj9Souj2NEiP5D+
   WEi2mg9+ioQqzlICsVC5iSOQrlM7e4h3ROa6V3zNyy9HiiCIW5UV3BAwv
   YZ2ZhwzwK4s0GA18vjGft2XBSJoYZJoTdkCo2zGfS1nQzUXUdXpFY8oRu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="350943202"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="350943202"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 09:02:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="767266029"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="767266029"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 May 2023 09:02:36 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pzg5M-000AAi-0Z;
        Thu, 18 May 2023 16:02:36 +0000
Date:   Fri, 19 May 2023 00:01:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        amd-gfx@lists.freedesktop.org, linux-bluetooth@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [linux-next:master] BUILD SUCCESS WITH WARNING
 798d276b39e984345d52b933a900a71fa0815928
Message-ID: <20230518160140.l1OXt%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230517200055/lkp-src/repo/*/linux-next
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 798d276b39e984345d52b933a900a71fa0815928  Add linux-next specific files for 20230518

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202304220119.94Pw6YsD-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202305182345.LTMlWG84-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/base/regmap/regcache-maple.c:113:23: warning: 'lower_index' is used uninitialized [-Wuninitialized]
drivers/base/regmap/regcache-maple.c:113:36: warning: 'lower_last' is used uninitialized [-Wuninitialized]
drivers/bluetooth/btnxpuart.c:1332:34: warning: unused variable 'nxpuart_of_match_table' [-Wunused-const-variable]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6396:21: warning: variable 'count' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:499:13: warning: variable 'j' set but not used [-Wunused-but-set-variable]

Unverified Warning (likely false positive, please contact us if interested):

kernel/events/uprobes.c:478 uprobe_write_opcode() warn: passing zero to 'PTR_ERR'

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arc-axs103_defconfig
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   `-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arm-randconfig-r001-20230517
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- ia64-randconfig-r022-20230517
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- microblaze-buildonly-randconfig-r002-20230517
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- x86_64-randconfig-m001
|   |-- kernel-events-uprobes.c-uprobe_write_opcode()-warn:passing-zero-to-PTR_ERR
|   `-- lib-stackdepot.c-stack_print()-warn:unsigned-stack-size-is-never-less-than-zero.
`-- xtensa-randconfig-r014-20230517
    |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
    `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
clang_recent_errors
`-- x86_64-randconfig-x052
    `-- drivers-bluetooth-btnxpuart.c:warning:unused-variable-nxpuart_of_match_table

elapsed time: 729m

configs tested: 119
configs skipped: 4

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc          buildonly-randconfig-r006-20230517   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230517   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230517   clang
arm                                 defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                  randconfig-r001-20230517   gcc  
arm                  randconfig-r006-20230517   gcc  
arm                  randconfig-r025-20230517   clang
arm                  randconfig-r046-20230517   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r004-20230517   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r012-20230517   clang
hexagon              randconfig-r016-20230517   clang
hexagon              randconfig-r031-20230517   clang
hexagon              randconfig-r041-20230517   clang
hexagon              randconfig-r045-20230517   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r022-20230517   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230517   gcc  
loongarch            randconfig-r023-20230517   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230517   gcc  
microblaze           randconfig-r021-20230517   gcc  
microblaze           randconfig-r033-20230517   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230517   gcc  
mips                 randconfig-r032-20230517   gcc  
mips                           rs90_defconfig   clang
nios2                            alldefconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r015-20230517   gcc  
openrisc             randconfig-r004-20230517   gcc  
openrisc             randconfig-r035-20230517   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc              randconfig-r011-20230517   gcc  
powerpc              randconfig-r013-20230517   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230517   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230517   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230517   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230517   gcc  
sh                   randconfig-r005-20230517   gcc  
sh                           se7619_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r024-20230517   gcc  
sparc64              randconfig-r026-20230517   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-x051   gcc  
x86_64                        randconfig-x052   clang
x86_64                        randconfig-x053   gcc  
x86_64                        randconfig-x054   clang
x86_64                        randconfig-x055   gcc  
x86_64                        randconfig-x056   clang
x86_64                        randconfig-x061   gcc  
x86_64                        randconfig-x062   clang
x86_64                        randconfig-x063   gcc  
x86_64                        randconfig-x064   clang
x86_64                        randconfig-x065   gcc  
x86_64                        randconfig-x066   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r014-20230517   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
