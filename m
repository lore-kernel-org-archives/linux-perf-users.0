Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3079816F83F;
	Tue, 28 May 2024 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902204; cv=none; b=fALZ1n282cu5uVjJpyNebJi5pR6H1mIQ6paUSIW/mjZczOEOWLzRO73zq1UeE8/2wSSu+YcTz2fiZuFo7sOJnZB6of+C1cbr6oSDV1M1uq6sww8pjnAV1JLg9y1EFl8EV1wmAgoQy84Ef+HWD76vjc8pmumezZqKhNLIlsFe7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902204; c=relaxed/simple;
	bh=g5gjUI6U9MyFiQJVsusPkXpALwzny/wmFRw4Cfu09OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0MfyZVkuDpU8KVA0ngbDRq/NusTr9FHLNd5q/EI1+tzA1wmeqscCm2FgSitap91jU1EJpwyc2P+vMe4DO7ucDh7meC/mBUhZr+IxKWL4fw0sFIq+9uQoL2LsxhgEHHUGBsT3ZsRVisFOl1zwGcE/CDfHGNpqis7Yap54AHMH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwrcWLOi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwrcWLOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902201; x=1748438201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g5gjUI6U9MyFiQJVsusPkXpALwzny/wmFRw4Cfu09OE=;
  b=MwrcWLOiWoynDk4atq64WKQXX8KFg+xhNmAbTBAAmMRMhGtflLoDGX9T
   PsNiDxr5fyWf9yHTlXr8BUtJCppWwjg2ghzDYFth02+PIhXjVaMh2//OV
   ubqaPj1Y0Rqq5ITqvpEw1w+ikU+te67d7cpltKvFKU0oLwqWpAPBhBqVM
   yop8ypbhvQmdsouYiWqurMIKwJr7LDjmESKhgdmDYfCPZ9P6vPKDcC0u5
   Y5jfnp3UY2UKUbBcLJLseIJvDvRLeygJL4mZUVSXnRb7W16DqX8Ge2pfG
   eIfedtYif9VO2vB289CQ9pMQrBboICppj5RSVoGDAxomipAFzlPcO2+ME
   A==;
X-CSE-ConnectionGUID: sRgUrOhsTfqTVHzEEFsp3A==
X-CSE-MsgGUID: rWRCe5BXSoKiRbWKZAbk8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13016917"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13016917"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:16:40 -0700
X-CSE-ConnectionGUID: Iw/m+uzSReGhoW15PGkVQg==
X-CSE-MsgGUID: NqYCGnvaTqWxDRDovt4CDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="34983497"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 28 May 2024 06:16:35 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBwgr-000CDR-1I;
	Tue, 28 May 2024 13:16:33 +0000
Date: Tue, 28 May 2024 21:15:39 +0800
From: kernel test robot <lkp@intel.com>
To: Xu Yang <xu.yang_2@nxp.com>, frank.li@nxp.com, will@kernel.org,
	mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com
Cc: oe-kbuild-all@lists.linux.dev, mike.leach@linaro.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v11 2/8] perf: imx_perf: add macro definitions for
 parsing config attr
Message-ID: <202405282005.xvD134Kz-lkp@intel.com>
References: <20240528160523.1695953-2-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528160523.1695953-2-xu.yang_2@nxp.com>

Hi Xu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on perf-tools-next/perf-tools-next]
[also build test WARNING on tip/perf/core perf-tools/perf-tools linus/master v6.10-rc1 next-20240528]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Yang/perf-imx_perf-add-macro-definitions-for-parsing-config-attr/20240528-160104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20240528160523.1695953-2-xu.yang_2%40nxp.com
patch subject: [PATCH v11 2/8] perf: imx_perf: add macro definitions for parsing config attr
config: arm64-randconfig-004-20240528 (https://download.01.org/0day-ci/archive/20240528/202405282005.xvD134Kz-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240528/202405282005.xvD134Kz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405282005.xvD134Kz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/perf/fsl_imx9_ddr_perf.c:46: warning: "CONFIG_COUNTER" redefined
      46 | #define CONFIG_COUNTER          GENMASK(15, 8)
         | 
   In file included from include/linux/kconfig.h:5,
                    from <command-line>:
   ./include/generated/autoconf.h:433: note: this is the location of the previous definition
     433 | #define CONFIG_COUNTER 1
         | 


vim +/CONFIG_COUNTER +46 drivers/perf/fsl_imx9_ddr_perf.c

    44	
    45	#define CONFIG_EVENT		GENMASK(7, 0)
  > 46	#define CONFIG_COUNTER		GENMASK(15, 8)
    47	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
