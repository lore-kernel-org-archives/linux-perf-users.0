Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172C82264C7;
	Thu, 26 Jun 2025 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750981999; cv=none; b=ooaK+NDUaXt58XqwwWEXTJ74m7e2pJLZ/l1zjKaFxSv8b6cNa6BtMNpA7kA4djIThRwFBO3JVebPsBUN3dTkp1seQ6LDkbjStHB8p3+nLM5DYc6QXFVMx0cwEJKBEuHT6UJX1KEZu+WJ1cX7/VochKAVAUH34iDnkONwooULjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750981999; c=relaxed/simple;
	bh=SN/NGzVIJgralBcDDuVPGj29WH5pdAz4U3HXHsEVx8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkFwihT1r94JbSzREZ6lr2NZCBUYuLW0AE4GHLd8dNJMiJv2XmSEi2M7gRwq2Wi1zVg+k5LxcH9pG3xr2vIpMhI0C17/o7xbLeZp4ypyr8JEiflg37bOWcgKYy+fJGaljwnomR2EPlo+Xso/ImgOSnct5h/MyCE38tI+oy5cJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goqhwdc/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goqhwdc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750981997; x=1782517997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SN/NGzVIJgralBcDDuVPGj29WH5pdAz4U3HXHsEVx8s=;
  b=goqhwdc/OE4m1I8qlZ+tPCclsafXQERmNjmNYcO11CDqJHucbUJ4u2XQ
   wMf6V31267SYO8b2biaoH20bmb96cl6AR9eP9xqO8U1IwMh1oX9c7pw/X
   50NlDz6mJuDNQKXq/JNECcXpaEHfkSMl/UfWQhxsq96eEh2KdshAozLYV
   mH2NnG1a26jrmijjDp9WPNQsMQgA5lSiTVumEnjjVbGQV91FePKr1lfFR
   oeh2U9bkwIjV2ACh0PK9PPRjKUBwNuyia4MewbIbgnIIdO/WMUQTf6mdv
   C3tFyBSquZZDD/zS8J5wTozIU2zUyXMcO+j0HNQNjIL0VvhmEESm1K63d
   A==;
X-CSE-ConnectionGUID: GE0qJEBHS5a2P+LEY4ec5w==
X-CSE-MsgGUID: doB5kI2kT4SnsErfn5ok0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53236093"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="53236093"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 16:53:16 -0700
X-CSE-ConnectionGUID: gp+S1qc3Qt+VQ3YEWjmHMQ==
X-CSE-MsgGUID: FWOuogMYQS6kHK1SwV6JTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="183554204"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Jun 2025 16:53:12 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUwOz-000VeA-2T;
	Thu, 26 Jun 2025 23:53:09 +0000
Date: Fri, 27 Jun 2025 07:52:47 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Subject: Re: [PATCH 06/13] perf: stm32: introduce DDRPERFM driver
Message-ID: <202506270708.6w6phhmi-lkp@intel.com>
References: <20250623-ddrperfm-upstream-v1-6-7dffff168090@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623-ddrperfm-upstream-v1-6-7dffff168090@foss.st.com>

Hi Clément,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 86731a2a651e58953fc949573895f2fa6d456841]

url:    https://github.com/intel-lab-lkp/linux/commits/Cl-ment-Le-Goffic/bus-firewall-move-stm32_firewall-header-file-in-include-folder/20250623-173554
base:   86731a2a651e58953fc949573895f2fa6d456841
patch link:    https://lore.kernel.org/r/20250623-ddrperfm-upstream-v1-6-7dffff168090%40foss.st.com
patch subject: [PATCH 06/13] perf: stm32: introduce DDRPERFM driver
config: i386-buildonly-randconfig-004-20250627 (https://download.01.org/0day-ci/archive/20250627/202506270708.6w6phhmi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250627/202506270708.6w6phhmi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506270708.6w6phhmi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/perf/stm32_ddr_pmu.c: In function 'stm32_ddr_start_counters':
   drivers/perf/stm32_ddr_pmu.c:205:9: error: implicit declaration of function 'writel_relaxed' [-Werror=implicit-function-declaration]
     205 |         writel_relaxed(r->start.mask, pmu->membase + r->start.reg);
         |         ^~~~~~~~~~~~~~
   drivers/perf/stm32_ddr_pmu.c: In function 'stm32_ddr_clear_counter':
   drivers/perf/stm32_ddr_pmu.c:232:22: error: implicit declaration of function 'readl_relaxed' [-Werror=implicit-function-declaration]
     232 |         u32 status = readl_relaxed(pmu->membase + r->status.reg);
         |                      ^~~~~~~~~~~~~
   drivers/perf/stm32_ddr_pmu.c: At top level:
>> drivers/perf/stm32_ddr_pmu.c:862:34: warning: 'stm32_ddr_pmu_of_match' defined but not used [-Wunused-const-variable=]
     862 | static const struct of_device_id stm32_ddr_pmu_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/stm32_ddr_pmu_of_match +862 drivers/perf/stm32_ddr_pmu.c

   861	
 > 862	static const struct of_device_id stm32_ddr_pmu_of_match[] = {
   863		{
   864			.compatible = "st,stm32mp131-ddr-pmu",
   865			.data = &stm32_ddr_pmu_cfg_mp1
   866		},
   867		{
   868			.compatible = "st,stm32mp151-ddr-pmu",
   869			.data = &stm32_ddr_pmu_cfg_mp1
   870		},
   871		{
   872			.compatible = "st,stm32mp251-ddr-pmu",
   873			.data = &stm32_ddr_pmu_cfg_mp2
   874		},
   875		{ },
   876	};
   877	MODULE_DEVICE_TABLE(of, stm32_ddr_pmu_of_match);
   878	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
