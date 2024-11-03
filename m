Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F09320B;
	Sun,  3 Nov 2024 04:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730609719; cv=none; b=uU5QZt+U6N6mmFC6S9AaZ/nMkBRYrUUECHrwkyngm7OH5c7E0IXIdLkijnXRus7uVV/AbsCGZFWo6vH1XeTifNJrDB5PhKFVjkorqxeSgcORFRA/mOrE0CVslfsMkGq7LdUUJECInONERqVdWfkOspUtd/OUtfjTtl1OjUqR5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730609719; c=relaxed/simple;
	bh=tlQrntuUWRfP2jYT5MQ26UOHKEWeDh6VfzqbpkmBdnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiXzoTEBMOE/FjHw2hwZyq/5hWXT+9WID3uHMQa1h22ZlxEsoiMuFldJO5iP+k5FQ9KzSiby6qc9QGNiYnYZG4/sAfu+1aqUT+JAR5zlhAjzelIbVfJg0qF/RmYJsCYi/n76eYml8IiRc1cPv/d0GCBQpn8DR0nhsfhyJ1wjWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7J70+Rf; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7J70+Rf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730609717; x=1762145717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tlQrntuUWRfP2jYT5MQ26UOHKEWeDh6VfzqbpkmBdnM=;
  b=k7J70+Rfk12qQEfoCxz4OnR/p85e3JZ5S+79WKMUqEWU046qen9TcWep
   cZQ4UAcUQ+0MRsV7L4Fowph7c9/sVjVD3jc18drWDU2RUB6BKNm7KiQtq
   aQwqqnHj4xcPksgOuLcxbghx3M6hBH+odXp7LZTarsw3YWqSf7oMyhv5U
   +lI4hyhR2Q/TQNmDP3jBEmS6hM7FvBgUEcO9Zc32+UJVMiwKY/9YqX0M8
   dZ1ttF4QgZxM+1Qe6Dy53k0ZbVyJzOdMmqvxhanBfeOkCMq18ddWnrYco
   yL0BZ9C9b7P6scd5zCf4kYCflvOvOiVIFSXjE6TdGf3JettWISo2qzDtM
   g==;
X-CSE-ConnectionGUID: kRsVw6L0RC6iNq56E4Vf7w==
X-CSE-MsgGUID: lFtqKOlgSNqreAoCIM4pjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="29748595"
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="29748595"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 21:55:16 -0700
X-CSE-ConnectionGUID: Gd8XBjQMQ8i3R2rqK/h5Pw==
X-CSE-MsgGUID: t9neAcF7T+yWCCRI/ZSZ+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="83673950"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 02 Nov 2024 21:55:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7Sdq-000jhd-2r;
	Sun, 03 Nov 2024 04:55:10 +0000
Date: Sun, 3 Nov 2024 12:54:14 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Peterson <benjamin@engflow.com>
Cc: oe-kbuild-all@lists.linux.dev, Benjamin Peterson <benjamin@engflow.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: avoid garbage when not printing an trace
 event's arguments
Message-ID: <202411031202.CkbT89xW-lkp@intel.com>
References: <20241101005338.5846-1-benjamin@engflow.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101005338.5846-1-benjamin@engflow.com>

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master acme/perf/core v6.12-rc5 next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Peterson/perf-trace-avoid-garbage-when-not-printing-an-trace-event-s-arguments/20241101-085413
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20241101005338.5846-1-benjamin%40engflow.com
patch subject: [PATCH] perf trace: avoid garbage when not printing an trace event's arguments
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241103/202411031202.CkbT89xW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411031202.CkbT89xW-lkp@intel.com/

All errors (new ones prefixed by >>):

   Makefile.config:652: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
     PERF_VERSION = 6.12.rc3.g6e02cf5e2f22
   builtin-trace.c: In function 'trace__fprintf_tp_fields':
>> builtin-trace.c:3090:35: error: field precision specifier '.*' expects argument of type 'int', but argument 3 has type 'size_t' {aka 'long unsigned int'} [-Werror=format=]
    3090 |         fprintf(trace->output, "%.*s", printed, bf);
         |                                 ~~^~   ~~~~~~~
         |                                   |    |
         |                                   int  size_t {aka long unsigned int}
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:105: tools/perf/builtin-trace.o] Error 1
   make[5]: *** [Makefile.perf:762: tools/perf/perf-in.o] Error 2
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile.perf:292: sub-make] Error 2
   make[3]: *** [Makefile:76: all] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
