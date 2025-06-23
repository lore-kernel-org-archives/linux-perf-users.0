Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12B2D542B;
	Mon, 23 Jun 2025 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750711403; cv=none; b=b2sm+v+eEpQEGMx3FBZoJkrG8P+W0QZQpwm0MpXkxNLQ71WI6Kju0l7Ifar4WWkM1UyHlWDidwq1W6LXQ130/Q/zMMp/ExK4CWm4ge7B3gz1q2Dxxcl2+qULAI7rbl+EDKoLGOVE4dtiHGt8OMVrh9Ka8sJ7ZrWEqdTXaEk/8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750711403; c=relaxed/simple;
	bh=ZF8iOADmf8w+7qUTaik1sR5sLxxucpt9xz9r6IIBx8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHd6s64ApfLulcqqX4uQ5KdqDWYBOKiwKCJw5jWHjrjrMGQORFVnV0rUMHA/c450BQGXYqyJrRxnKL8eH1MLXiWUO+QvavVrs8fPkF1BPebChpl2Sn3Bd/pi3GT2DSY/OQ/pf9A6riVYDu6wksJ4/l5ZgGMynD7fawoyz19/ftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFjLTigN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFjLTigN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750711401; x=1782247401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZF8iOADmf8w+7qUTaik1sR5sLxxucpt9xz9r6IIBx8E=;
  b=JFjLTigNx+cO+8ycNfK0fX+kyN4ViHfz+eHbnRNOy6ioT3yud8P6jmgD
   74/kqmMpgx45E6eFOyA2DD5itGJw989w+CLuld5CmjAzzwUsjSLIavvnY
   FXp0h/xtz2HiLrqHehr6qktST0VUzcr7yq2HS5IKrayfMY7wKdjpsK0M0
   PxLubOMs/glkLrZk28zFJnSimk4ij69Igkhpb4IRjLZdKLSLJ9joFr59N
   6H0OIaJITia2VwBvPKprl8MbsHykMlwhV2sJZ0IVs6fVeFvBZCuG9tPzE
   H0imYgQyxNoi2B8Aln6Z42wcCl18Eg7DFhNKmwOT6BcuyA9yrWxyFS1P+
   A==;
X-CSE-ConnectionGUID: jzCD4RxET7W1EI5zjrRlPA==
X-CSE-MsgGUID: gpTGF5f1RxaFSRCRnJrJEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="40547183"
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="40547183"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 13:43:21 -0700
X-CSE-ConnectionGUID: vhpMNoOJRVyHoigd9p+7Iw==
X-CSE-MsgGUID: sLayHnBySu6O9o+QgzInsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="151185395"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 23 Jun 2025 13:43:15 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTo0W-000PJq-2Z;
	Mon, 23 Jun 2025 20:43:12 +0000
Date: Tue, 24 Jun 2025 04:43:02 +0800
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
Message-ID: <202506240401.zlRG1qiO-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 86731a2a651e58953fc949573895f2fa6d456841]

url:    https://github.com/intel-lab-lkp/linux/commits/Cl-ment-Le-Goffic/bus-firewall-move-stm32_firewall-header-file-in-include-folder/20250623-173554
base:   86731a2a651e58953fc949573895f2fa6d456841
patch link:    https://lore.kernel.org/r/20250623-ddrperfm-upstream-v1-6-7dffff168090%40foss.st.com
patch subject: [PATCH 06/13] perf: stm32: introduce DDRPERFM driver
config: i386-buildonly-randconfig-002-20250624 (https://download.01.org/0day-ci/archive/20250624/202506240401.zlRG1qiO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250624/202506240401.zlRG1qiO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506240401.zlRG1qiO-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/perf/stm32_ddr_pmu.c: In function 'stm32_ddr_start_counters':
>> drivers/perf/stm32_ddr_pmu.c:205:9: error: implicit declaration of function 'writel_relaxed' [-Werror=implicit-function-declaration]
     205 |         writel_relaxed(r->start.mask, pmu->membase + r->start.reg);
         |         ^~~~~~~~~~~~~~
   drivers/perf/stm32_ddr_pmu.c: In function 'stm32_ddr_clear_counter':
>> drivers/perf/stm32_ddr_pmu.c:232:22: error: implicit declaration of function 'readl_relaxed' [-Werror=implicit-function-declaration]
     232 |         u32 status = readl_relaxed(pmu->membase + r->status.reg);
         |                      ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/writel_relaxed +205 drivers/perf/stm32_ddr_pmu.c

   200	
   201	static void stm32_ddr_start_counters(struct stm32_ddr_pmu *pmu)
   202	{
   203		const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
   204	
 > 205		writel_relaxed(r->start.mask, pmu->membase + r->start.reg);
   206	}
   207	
   208	static void stm32_ddr_stop_counters(struct stm32_ddr_pmu *pmu)
   209	{
   210		const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
   211	
   212		writel_relaxed(r->stop.mask, pmu->membase + r->stop.reg);
   213	}
   214	
   215	static void stm32_ddr_clear_time_counter(struct stm32_ddr_pmu *pmu)
   216	{
   217		const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
   218	
   219		writel_relaxed(r->clear_time.mask, pmu->membase + r->clear_time.reg);
   220	}
   221	
   222	static void stm32_ddr_clear_event_counter(struct stm32_ddr_pmu *pmu, struct stm32_ddr_cnt *counter)
   223	{
   224		const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
   225	
   226		writel_relaxed(r->clear_cnt.mask & BIT(counter->idx), pmu->membase + r->clear_cnt.reg);
   227	}
   228	
   229	static void stm32_ddr_clear_counter(struct stm32_ddr_pmu *pmu, struct stm32_ddr_cnt *counter)
   230	{
   231		const struct stm32_ddr_pmu_regspec *r = pmu->cfg->regs;
 > 232		u32 status = readl_relaxed(pmu->membase + r->status.reg);
   233	
   234		if (counter->idx == pmu->cfg->time_cnt_idx)
   235			stm32_ddr_clear_time_counter(pmu);
   236		else
   237			stm32_ddr_clear_event_counter(pmu, counter);
   238	
   239		if (status & r->status.mask)
   240			dev_err(pmu->dev, "Failed to clear counter %i because the PMU is busy\n",
   241				counter->idx);
   242	}
   243	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
