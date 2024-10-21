Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5E1E1C3B;
	Mon, 21 Oct 2024 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516709; cv=none; b=TlTtBlqBuXCroza6yQz2eilb8yF0dnydh8Y7ppgzjDEYm5dbJnIb72DLIT1TCotpyVuCfvCfBNKoXEfNOe1jBOd8X3L0jxaGbe9IVdnH977F7UF92gCADDxsOQ8AR6LVR9NC/WWymEgtTHsApOMuwvMXnf/YzhP8IvjjHb+AwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516709; c=relaxed/simple;
	bh=ai3fjlvIFrMIPL3yL7pIMzbZFTs1xDvVwbDDipH4J68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTHMr+7SE403DcSnpX5N0v0eGEJpWYoAliV0rP6rCOv4r61FJAh/YxXTm0LllTiGWYIHlrVMoMxBj7eBnpLkmPI+8+G0avn0NU8q1/7/R5+BdJgb5FhXDbDQS9ITsaGn2HhYyZaQG458Ye9uln++tKbfCC0cqjSEsDHSE4NtQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZBO6xGu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZBO6xGu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729516707; x=1761052707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ai3fjlvIFrMIPL3yL7pIMzbZFTs1xDvVwbDDipH4J68=;
  b=PZBO6xGukSQi3v0cmdftCgaaz9vNTpj9McPixJwO8/ALhrndLpKeiQeW
   AoFzcOUQagUNxaGys2MQxLhOJn+LjEdYTHFNYJHSXftcfeW+N1BYCb8YN
   uM/4QAuf508nHqpZZC+U6Xb7jQ5m3Ice0x64jTh8IIkhhFlGDYZndl3k8
   NoZvDblTDt+XgwVg6e1wtfNybZ9GHcVFH+Y2Yd5kL3BtVcpp2BMKZ83PN
   X36KfobJRsfN+AqAaVerQ9RzJ7ZqZY/N4dUaozr+UnC7X5ucWrs0gbzhv
   uz/uF9jRzK3o07qQLYkJ+6nCA7N9bNq/N4KuPVLnDctv3zfUwytz2TTzC
   Q==;
X-CSE-ConnectionGUID: xlgkevAtQ9SmTqczfi+z8A==
X-CSE-MsgGUID: /PReO6RSTkelEXDIe1jDBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="40368885"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="40368885"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:18:26 -0700
X-CSE-ConnectionGUID: OFEfAP9dREqogMk2yqwixw==
X-CSE-MsgGUID: p5cuxn8xQfmY6lvCmFpe7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79874134"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2024 06:18:21 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2sIc-000SBG-36;
	Mon, 21 Oct 2024 13:18:18 +0000
Date: Mon, 21 Oct 2024 21:17:26 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	James Clark <james.clark@linaro.org>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 4/5] perf test: Add hwmon "PMU" test
Message-ID: <202410212129.7qRTRilb-lkp@intel.com>
References: <20241017063555.366065-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017063555.366065-5-irogers@google.com>

Hi Ian,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on next-20241021]
[cannot apply to tip/perf/core perf-tools/perf-tools linus/master acme/perf/core v6.12-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/tools-api-io-Ensure-line_len_out-is-always-initialized/20241017-143759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20241017063555.366065-5-irogers%40google.com
patch subject: [PATCH v5 4/5] perf test: Add hwmon "PMU" test
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241021/202410212129.7qRTRilb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410212129.7qRTRilb-lkp@intel.com/

All errors (new ones prefixed by >>):

   Makefile.config:665: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
     PERF_VERSION = 6.12.rc3.g552cc7c00b6d
   tests/hwmon_pmu.c: In function 'do_test':
>> tests/hwmon_pmu.c:149:17: error: implicit declaration of function 'strlcpy'; did you mean 'strncpy'? [-Werror=implicit-function-declaration]
     149 |                 strlcpy(str, test_event, sizeof(str));
         |                 ^~~~~~~
         |                 strncpy
   cc1: all warnings being treated as errors
   make[7]: *** [tools/build/Makefile.build:105: tools/perf/tests/hwmon_pmu.o] Error 1
   make[7]: *** Waiting for unfinished jobs....
   make[6]: *** [tools/build/Makefile.build:158: tests] Error 2
   make[5]: *** [Makefile.perf:777: tools/perf/perf-test-in.o] Error 2
   make[5]: *** Waiting for unfinished jobs....
   util/hwmon_pmu.c: In function 'parse_hwmon_filename':
   util/hwmon_pmu.c:175:9: error: implicit declaration of function 'strlcpy'; did you mean 'strncpy'? [-Werror=implicit-function-declaration]
     175 |         strlcpy(fn_type, filename, sizeof(fn_type));
         |         ^~~~~~~
         |         strncpy
   cc1: all warnings being treated as errors
   make[7]: *** [tools/build/Makefile.build:106: tools/perf/util/hwmon_pmu.o] Error 1
   make[7]: *** Waiting for unfinished jobs....
   make[6]: *** [tools/build/Makefile.build:158: util] Error 2
   make[5]: *** [Makefile.perf:789: tools/perf/perf-util-in.o] Error 2
   make[4]: *** [Makefile.perf:292: sub-make] Error 2
   make[3]: *** [Makefile:76: all] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
