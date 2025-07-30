Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC52DAFA0;
	Wed, 30 Jul 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886622; cv=none; b=izVprblrixs8QZKjC5uLnR8yZw2EtAclUJ3dBSHP617HCM0Ea1Laonp98yuSz0SLqO9shcwE4z8OYEBZa32OXhe/7TMJRMjG5asWaigZmls50akVtGkgAjxuF85da3lvVSe1soei0QKRlGnTRwflqAhGMf4Aly5xCC9Rc4Tn4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886622; c=relaxed/simple;
	bh=idRnj5P4PrYGxexiNDf1IWPLr0mVthPDzs6oUfOLhrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD7h4YtW5OklnXleX/HOMIuzvP+gzvDl3VqfGEelF6cVskaGzXYiG+ki48cnyO+MqWUmUgUI2Atl6QN4BPD/OpcZdAbXWO04eIPNovJZpEphO9F58pRTsHP/aRW3jmGy0ph9QAiTAHd3TuRgxJ8vIx8D3KnRJM11jN3vul53nck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bz2oH02/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bz2oH02/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753886621; x=1785422621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=idRnj5P4PrYGxexiNDf1IWPLr0mVthPDzs6oUfOLhrM=;
  b=Bz2oH02/Z58mRocLaBzsJfjnRHGs7UiK3Lvfxuh1uZ5cfGpoJpEYshoX
   y2A2HGum6UCiwkJch6i88gAraOMQybQJ4ORJZKp4OxR1hEryBet0pGIZU
   dAik0eRhLAetr+Ime8fnvEtn8Xl6tJS/dY6s8xvcUs1oDhIuk+Y1/VvU1
   jn6S3riB2Kc+h/ph/WxzwbiVRAmQvSfs8p5Z+0Tt7K/S4lEgHJ6IkAlnb
   rnXOkvB2lBXDaBD1ZGnSpYQesiOrHnW7oNJQLNqRLjdvs6GYAPXCTSwyd
   CkoPzXDmuKEkRySt9zMBU/I8AJmgHqKq8J3hstElDTvlfoxE6gX/CZrP4
   g==;
X-CSE-ConnectionGUID: Eqmfr9EHRpeo5RVIoNAkDw==
X-CSE-MsgGUID: I29DRyAGQAOsLA4NGX/xHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="55890914"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="55890914"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:43:40 -0700
X-CSE-ConnectionGUID: oTzVPsG9QR+19wHO6VXhaA==
X-CSE-MsgGUID: 8uYbk/j7SeWAaepWravi+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="193987297"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 Jul 2025 07:43:34 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uh81k-0002qG-0g;
	Wed, 30 Jul 2025 14:43:32 +0000
Date: Wed, 30 Jul 2025 22:43:04 +0800
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
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	Le Goffic <legoffic.clement@gmail.com>,
	Julius Werner <jwerner@chromium.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Subject: Re: [PATCH v5 13/20] perf: stm32: introduce DDRPERFM driver
Message-ID: <202507302237.gyVCBmXs-lkp@intel.com>
References: <20250728-ddrperfm-upstream-v5-13-03f1be8ad396@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728-ddrperfm-upstream-v5-13-03f1be8ad396@foss.st.com>

Hi Clément,

kernel test robot noticed the following build errors:

[auto build test ERROR on 89be9a83ccf1f88522317ce02f854f30d6115c41]

url:    https://github.com/intel-lab-lkp/linux/commits/Cl-ment-Le-Goffic/bus-firewall-move-stm32_firewall-header-file-in-include-folder/20250728-234144
base:   89be9a83ccf1f88522317ce02f854f30d6115c41
patch link:    https://lore.kernel.org/r/20250728-ddrperfm-upstream-v5-13-03f1be8ad396%40foss.st.com
patch subject: [PATCH v5 13/20] perf: stm32: introduce DDRPERFM driver
config: s390-randconfig-001-20250730 (https://download.01.org/0day-ci/archive/20250730/202507302237.gyVCBmXs-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507302237.gyVCBmXs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507302237.gyVCBmXs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/perf/stm32_ddr_pmu.c:213:2: error: call to undeclared function 'writel_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     213 |         writel_relaxed(r->start.mask, pmu->membase + r->start.reg);
         |         ^
   drivers/perf/stm32_ddr_pmu.c:220:2: error: call to undeclared function 'writel_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     220 |         writel_relaxed(r->stop.mask, pmu->membase + r->stop.reg);
         |         ^
   drivers/perf/stm32_ddr_pmu.c:227:2: error: call to undeclared function 'writel_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     227 |         writel_relaxed(r->clear_time.mask, pmu->membase + r->clear_time.reg);
         |         ^
   drivers/perf/stm32_ddr_pmu.c:234:2: error: call to undeclared function 'writel_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     234 |         writel_relaxed(r->clear_cnt.mask & BIT(counter->idx), pmu->membase + r->clear_cnt.reg);
         |         ^
>> drivers/perf/stm32_ddr_pmu.c:240:15: error: call to undeclared function 'readl_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     240 |         u32 status = readl_relaxed(pmu->membase + r->status.reg);
         |                      ^
   drivers/perf/stm32_ddr_pmu.c:255:12: error: call to undeclared function 'readl_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     255 |         u32 val = readl_relaxed(pmu->membase + r->enable.reg);
         |                   ^
   drivers/perf/stm32_ddr_pmu.c:258:2: error: call to undeclared function 'writel_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     258 |         writel_relaxed(val, pmu->membase + r->enable.reg);
         |         ^
   drivers/perf/stm32_ddr_pmu.c:264:12: error: call to undeclared function 'readl_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     264 |         u32 val = readl_relaxed(pmu->membase + r->enable.reg);
         |                   ^
   drivers/perf/stm32_ddr_pmu.c:267:2: error: call to undeclared function 'writel_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     267 |         writel_relaxed(val, pmu->membase + r->enable.reg);
         |         ^
   drivers/perf/stm32_ddr_pmu.c:285:17: error: call to undeclared function 'readl_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     285 |                 cnt_sel_val = readl_relaxed(pmu->membase + r->cfg.reg);
         |                               ^
   drivers/perf/stm32_ddr_pmu.c:288:3: error: call to undeclared function 'writel_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     288 |                 writel_relaxed(cnt_sel_val, pmu->membase + r->cfg.reg);
         |                 ^
   drivers/perf/stm32_ddr_pmu.c:302:16: error: call to undeclared function 'readl_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     302 |         cnt_sel_val = readl_relaxed(pmu->membase + cnt_sel_evt_reg);
         |                       ^
   drivers/perf/stm32_ddr_pmu.c:306:2: error: call to undeclared function 'writel_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     306 |         writel_relaxed(cnt_sel_val, pmu->membase + cnt_sel_evt_reg);
         |         ^
   drivers/perf/stm32_ddr_pmu.c:428:9: error: call to undeclared function 'readl_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     428 |                 val = readl_relaxed(pmu->membase + r->counter_evt[counter->idx].reg);
         |                       ^
   drivers/perf/stm32_ddr_pmu.c:778:3: error: call to undeclared function 'writel_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     778 |                 writel_relaxed(pmu->dram_type, pmu->membase + pmu->cfg->regs->dram_inf.reg);
         |                 ^
   drivers/perf/stm32_ddr_pmu.c:803:2: error: call to undeclared function 'writel_relaxed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     803 |         writel_relaxed(pmu->dram_type, pmu->membase + pmu->cfg->regs->dram_inf.reg);
         |         ^
   16 errors generated.


vim +/writel_relaxed +213 drivers/perf/stm32_ddr_pmu.c

   208	
   209	static void stm32_ddr_start_counters(struct stm32_ddr_pmu *pmu)
   210	{
   211		const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
   212	
 > 213		writel_relaxed(r->start.mask, pmu->membase + r->start.reg);
   214	}
   215	
   216	static void stm32_ddr_stop_counters(struct stm32_ddr_pmu *pmu)
   217	{
   218		const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
   219	
   220		writel_relaxed(r->stop.mask, pmu->membase + r->stop.reg);
   221	}
   222	
   223	static void stm32_ddr_clear_time_counter(struct stm32_ddr_pmu *pmu)
   224	{
   225		const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
   226	
   227		writel_relaxed(r->clear_time.mask, pmu->membase + r->clear_time.reg);
   228	}
   229	
   230	static void stm32_ddr_clear_event_counter(struct stm32_ddr_pmu *pmu, struct stm32_ddr_cnt *counter)
   231	{
   232		const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
   233	
   234		writel_relaxed(r->clear_cnt.mask & BIT(counter->idx), pmu->membase + r->clear_cnt.reg);
   235	}
   236	
   237	static void stm32_ddr_clear_counter(struct stm32_ddr_pmu *pmu, struct stm32_ddr_cnt *counter)
   238	{
   239		const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
 > 240		u32 status = readl_relaxed(pmu->membase + r->status.reg);
   241	
   242		if (counter->idx == pmu->cfg->time_cnt_idx)
   243			stm32_ddr_clear_time_counter(pmu);
   244		else
   245			stm32_ddr_clear_event_counter(pmu, counter);
   246	
   247		if (status & r->status.mask)
   248			dev_err(pmu->dev, "Failed to clear counter %i because the PMU is busy\n",
   249				counter->idx);
   250	}
   251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
