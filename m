Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949742264D3;
	Fri, 27 Jun 2025 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011115; cv=none; b=n8pSMO5si4QMXMJR/X/sNCkZy3f4zrQzca3xX7Rrz0LxBTGEan2IboK0Rb/Ai8A97s9IJlYIyckNwV31wlKmvRDQnf2pGTYm3z7tqVDs7/+0VzqIzhj366eVix7Kuo9mE2QpMAGcnsySsARLmfxDdveIsfVF0qPG+zrKBaYJ0b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011115; c=relaxed/simple;
	bh=Fyg0cpFx4aTbB3uk0FSSpezLibp4GAAeDnWy0ypWXYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AshjbnrA5n0IcxRNBbLOa4ie+PETARp5yr0uwReG1+xu4+WqclX5Fdr45NIv7s9Ob7/LXnRiGuaZ4hWL6HOS7Ng64tMZ2gZb7pQSpTKVEBsKCBuk8Zc5jBT3wR64c1MhnaBhOSmYGPvTJgabEyG/V+OSzkuJD19RPkHN2n8xBa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKYXYNlN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKYXYNlN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751011112; x=1782547112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fyg0cpFx4aTbB3uk0FSSpezLibp4GAAeDnWy0ypWXYg=;
  b=oKYXYNlNJ+0XaIMizaMCCtSJHPl8GgCgE0yVZXRMJYCraxsilo1F8NNc
   mbEVB2KyJho8x2NZ6Lp25Yk2wrzFZM2308fBiL15fJ2Rxt0zw9kf/svlu
   oKMAfihyQZnQfc3AzbMmekWCdw7+lqLmY/D0Vd51CQZ9Z4rAQJWehORi3
   /f6tOv0VhEAQGYGmlUcIkIAgG7FOD9Ck6eP0/0nPiZ8hcWYt5aeXQabt4
   wwhJSCF3RsQTROWU7sYEu4o5kuefv19HP205FJ1yW/vJ0TBm8uwiMced8
   K7JHcZoEfT1RUxFeFdmI2cTt8Fraep8FlOLXUkHSjEXrrRpwxCsIohy7F
   g==;
X-CSE-ConnectionGUID: X4TgQyoGRX2aDUGvk5eo+Q==
X-CSE-MsgGUID: QdCZvF+0RriYk0NgMeBOIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="78759736"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="78759736"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 00:58:32 -0700
X-CSE-ConnectionGUID: uoRikHCJQTaAUw8eJtuwog==
X-CSE-MsgGUID: ZHkJKVaYSmq20p6vFpHyBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="152479988"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 27 Jun 2025 00:58:29 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uV3yc-000VwV-01;
	Fri, 27 Jun 2025 07:58:26 +0000
Date: Fri, 27 Jun 2025 15:58:15 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Rogers <irogers@google.com>, Eric Biggers <ebiggers@google.com>,
	Yuzhuo Jing <yuzhuo@google.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3 1/3] vdso: Switch get/put unaligned from packed struct
 to memcpy
Message-ID: <202506271501.X7apmMDK-lkp@intel.com>
References: <20250626054826.433453-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626054826.433453-2-irogers@google.com>

Hi Ian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16-rc3 next-20250626]
[cannot apply to tip/timers/vdso acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/vdso-Switch-get-put-unaligned-from-packed-struct-to-memcpy/20250626-135005
base:   linus/master
patch link:    https://lore.kernel.org/r/20250626054826.433453-2-irogers%40google.com
patch subject: [PATCH v3 1/3] vdso: Switch get/put unaligned from packed struct to memcpy
config: nios2-randconfig-r111-20250627 (https://download.01.org/0day-ci/archive/20250627/202506271501.X7apmMDK-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250627/202506271501.X7apmMDK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506271501.X7apmMDK-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   drivers/infiniband/core/cm.c: note: in included file (through include/rdma/ibta_vol1_c12.h, drivers/infiniband/core/cm_msgs.h):
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
   drivers/infiniband/core/cm.c: note: in included file (through include/uapi/linux/swab.h, include/linux/swab.h, include/uapi/linux/byteorder/little_endian.h, ...):
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   drivers/infiniband/core/cm.c: note: in included file (through include/rdma/ibta_vol1_c12.h, drivers/infiniband/core/cm_msgs.h):
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
   drivers/infiniband/core/cm.c: note: in included file (through include/uapi/linux/swab.h, include/linux/swab.h, include/uapi/linux/byteorder/little_endian.h, ...):
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   drivers/infiniband/core/cm.c: note: in included file (through include/rdma/ibta_vol1_c12.h, drivers/infiniband/core/cm_msgs.h):
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
   drivers/infiniband/core/cm.c: note: in included file (through include/uapi/linux/swab.h, include/linux/swab.h, include/uapi/linux/byteorder/little_endian.h, ...):
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   drivers/infiniband/core/cm.c: note: in included file (through include/rdma/ibta_vol1_c12.h, drivers/infiniband/core/cm_msgs.h):
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
>> include/rdma/iba.h:48:16: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   include/rdma/iba.h:48:16: sparse:     expected void *
   include/rdma/iba.h:48:16: sparse:     got restricted __be64 const *
   drivers/infiniband/core/cm.c: note: in included file (through include/uapi/linux/swab.h, include/linux/swab.h, include/uapi/linux/byteorder/little_endian.h, ...):
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:31:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/uapi/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini

vim +48 include/rdma/iba.h

d05d4ac4c9316a2 Leon Romanovsky 2020-01-16  41  
d05d4ac4c9316a2 Leon Romanovsky 2020-01-16  42  static inline u64 _iba_get64(const __be64 *ptr)
d05d4ac4c9316a2 Leon Romanovsky 2020-01-16  43  {
d05d4ac4c9316a2 Leon Romanovsky 2020-01-16  44  	/*
d05d4ac4c9316a2 Leon Romanovsky 2020-01-16  45  	 * The mads are constructed so that 32 bit and smaller are naturally
d05d4ac4c9316a2 Leon Romanovsky 2020-01-16  46  	 * aligned, everything larger has a max alignment of 4 bytes.
d05d4ac4c9316a2 Leon Romanovsky 2020-01-16  47  	 */
d05d4ac4c9316a2 Leon Romanovsky 2020-01-16 @48  	return be64_to_cpu(get_unaligned(ptr));
d05d4ac4c9316a2 Leon Romanovsky 2020-01-16  49  }
d05d4ac4c9316a2 Leon Romanovsky 2020-01-16  50  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
