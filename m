Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792947965;
	b=HP1XIbdlOLOmqAxsg0I5BsinDiof/Qv1HpOjUjCdJknvVQIzRB9wEefTtKVJTIxUdJC5
	 4xeOCSM2IgLI9tXzt40CAbK2OrvtraXJijoVZTM/wOeduRZnkt8sFjhkd3DwovitSv0VG
	 P38J3Dyql33162jttommQwqRcxTNIfxm1rFq+4hUkq+2kM3ocL2ZKfzMqQkjJwYn3auXv
	 gjL+QAJekjE64XYReqa7La0xdHxASzHqtMuisvxWnA0L348H5fYRhsqCOnGVDa3cfTQM3
	 SUH6pqoz4wO0ZsJKwW0chXpnZ49UwQXQjRinFo28Xqk0zP+7CeJar2OsCGtKBRa6+xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792947965;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=oUwvHq0P/9gsOPpgAsIiXBykttRf2wfXHYBWY4fgpX4=;
	b=AhBv58+UiYfwP0XdVv+WfCErXtalkEJMc18Z9ZFHrtm/rK/ZRxWlOeYwU74PsCBSsS90
	 F2GuGhbl9JIa/fEwle1fwqP/xHnn5DXV8q+UEYavveE9XFChNUWQZAM29KVWNPqXi0JJ+
	 qOf7tWmmPs5qxQJdIlIKAPDbFjx/QmHcaOr0xQ2LUtzGO37g9D3hy3MkMyQbETFZIyTsQ
	 ynWm87oT2063kRnDiIPCl4VUa0WIszO9ur2Gq3wjJtP0AeXhikQVZ+aDmIYeAaq+jiLOd
	 7Gsyt10PWTDj34sFmWx2p5AhqFaj27TpMXFbqJ1cBbPqm0OLDcXADztqIxMRImz3rPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R2sE4R29;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EE606A31A;
	Sun, 25 Oct 2026 17:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE0EE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R2sE4R29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792947963; x=1824483963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AxOjbFvh/NcIZrioJUJIpPem4ac7BqaQaQFD2sY7xA8=;
  b=R2sE4R29VIABX3QPzLRl6Z1YY7M7zIGR64PW/rA2dk9afhMKKukVvbL7
   0k7CFnwNP+cXXqO2QPGQz6gt5pFhBE+5KZQya2Zs2dRRh/m5WHROcNxnT
   dggBGGoY6hXlrFMn+HDuRtbb9qIQZOBe7FGAiQBknaboIyVUeVC9Ah+pK
   yoK+W1MMqP/WgUvx278MvgGnNKNyY/+jh0ugQ1mPppf9MIUvOonLzoZwy
   7STbbizVbcSNgwiWdz3UxI9pMBkKOXP8IY1/+tNY71Mq6w31rKkWuWkDi
   EHLMAWG0AjxDbDeT6tFbB46QKm71V0fgVh5YgxNCgfqg3bpcWSRR+pHSj
   Q==;
X-CSE-ConnectionGUID: qb5x8gk3R66xo5Af9nbtJQ==
X-CSE-MsgGUID: TtyQkWpDTgy3pRn0CoNzpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1611689"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1611689"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 10:06:02 -0700
X-CSE-ConnectionGUID: 58RfMdFWTXqNG1oYrD8erg==
X-CSE-MsgGUID: ITdobinPTCSRoDNVxb84cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4051939"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Oct 2026 10:05:58 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xL1fN-00000000UxW-3BwO;
	Sun, 25 Oct 2026 17:05:53 +0000
Date: Mon, 26 Oct 2026 01:05:39 +0800
From: kernel test robot <lkp@intel.com>
To: Amir Ayupov <aaupov@fb.com>, James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Pereira <danielmaraboo@gmail.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
Message-ID: <202610260043.uPhMX80G-lkp@intel.com>
References: <cd3e622681f7254216b0488f09d2cb2d91a2d8ca.1792907333.git.aaupov@fb.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd3e622681f7254216b0488f09d2cb2d91a2d8ca.1792907333.git.aaupov@fb.com>

Hi Amir,

kernel test robot noticed the following build errors:

[auto build test ERROR on 343cfcbb3ecfdb80aa576a428cfa3b65ad783842]

url:    https://github.com/intel-lab-lkp/linux/commits/Amir-Ayupov/coresight-etm4x-Fix-event-count-decoding/20261024-233901
base:   343cfcbb3ecfdb80aa576a428cfa3b65ad783842
patch link:    https://lore.kernel.org/r/cd3e622681f7254216b0488f09d2cb2d91a2d8ca.1792907333.git.aaupov%40fb.com
patch subject: [PATCH v3 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20261026/202610260043.uPhMX80G-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261026/202610260043.uPhMX80G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610260043.uPhMX80G-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/kvm/arm_pmu.h:11,
                    from arch/arm64/include/asm/kvm_host.h:38,
                    from arch/arm64/include/asm/arm_pmuv3.h:9,
                    from arch/arm64/kernel/cpufeature.c:80:
   include/linux/perf/arm_pmuv3.h: In function 'pmuv3_event_implemented':
>> include/linux/perf/arm_pmuv3.h:333:26: error: implicit declaration of function 'pmuv3_implemented'; did you mean 'pmuv3_event_implemented'? [-Wimplicit-function-declaration]
     333 |         if (id >= 64 || !pmuv3_implemented(read_pmuver()))
         |                          ^~~~~~~~~~~~~~~~~
         |                          pmuv3_event_implemented
>> include/linux/perf/arm_pmuv3.h:333:44: error: implicit declaration of function 'read_pmuver' [-Wimplicit-function-declaration]
     333 |         if (id >= 64 || !pmuv3_implemented(read_pmuver()))
         |                                            ^~~~~~~~~~~
>> include/linux/perf/arm_pmuv3.h:336:28: error: implicit declaration of function 'read_pmceid0' [-Wimplicit-function-declaration]
     336 |         pmceid = id < 32 ? read_pmceid0() : read_pmceid1();
         |                            ^~~~~~~~~~~~
>> include/linux/perf/arm_pmuv3.h:336:45: error: implicit declaration of function 'read_pmceid1' [-Wimplicit-function-declaration]
     336 |         pmceid = id < 32 ? read_pmceid0() : read_pmceid1();
         |                                             ^~~~~~~~~~~~
   arch/arm64/include/asm/arm_pmuv3.h: At top level:
>> arch/arm64/include/asm/arm_pmuv3.h:49:19: error: conflicting types for 'read_pmuver'; have 'u32(void)' {aka 'unsigned int(void)'}
      49 | static inline u32 read_pmuver(void)
         |                   ^~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:333:44: note: previous implicit declaration of 'read_pmuver' with type 'int()'
     333 |         if (id >= 64 || !pmuv3_implemented(read_pmuver()))
         |                                            ^~~~~~~~~~~
>> arch/arm64/include/asm/arm_pmuv3.h:160:19: error: conflicting types for 'read_pmceid0'; have 'u64(void)' {aka 'long long unsigned int(void)'}
     160 | static inline u64 read_pmceid0(void)
         |                   ^~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:336:28: note: previous implicit declaration of 'read_pmceid0' with type 'int()'
     336 |         pmceid = id < 32 ? read_pmceid0() : read_pmceid1();
         |                            ^~~~~~~~~~~~
>> arch/arm64/include/asm/arm_pmuv3.h:165:19: error: conflicting types for 'read_pmceid1'; have 'u64(void)' {aka 'long long unsigned int(void)'}
     165 | static inline u64 read_pmceid1(void)
         |                   ^~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:336:45: note: previous implicit declaration of 'read_pmceid1' with type 'int()'
     336 |         pmceid = id < 32 ? read_pmceid0() : read_pmceid1();
         |                                             ^~~~~~~~~~~~
>> arch/arm64/include/asm/arm_pmuv3.h:170:20: error: conflicting types for 'pmuv3_implemented'; have 'bool(int)' {aka '_Bool(int)'}
     170 | static inline bool pmuv3_implemented(int pmuver)
         |                    ^~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:333:26: note: previous implicit declaration of 'pmuv3_implemented' with type 'int()'
     333 |         if (id >= 64 || !pmuv3_implemented(read_pmuver()))
         |                          ^~~~~~~~~~~~~~~~~


vim +333 include/linux/perf/arm_pmuv3.h

   320	
   321	/*
   322	 * Whether this CPU's PMU implements a common event, as reported by
   323	 * PMCEID{0,1}: events 0x0000-0x003f in bits [31:0], and from PMUv3p1 events
   324	 * 0x4000-0x403f in bits [63:32], which read as zero before PMUv3p1.
   325	 * Must run on the CPU whose PMU is queried.
   326	 */
   327	static inline bool pmuv3_event_implemented(u16 event)
   328	{
   329		bool ext = event >= ARMV8_PMUV3_EXT_COMMON_EVENT_BASE;
   330		u16 id = ext ? event - ARMV8_PMUV3_EXT_COMMON_EVENT_BASE : event;
   331		u64 pmceid;
   332	
 > 333		if (id >= 64 || !pmuv3_implemented(read_pmuver()))
   334			return false;
   335	
 > 336		pmceid = id < 32 ? read_pmceid0() : read_pmceid1();
   337		return pmceid & BIT_ULL(id % 32 + (ext ? 32 : 0));
   338	}
   339	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
