Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C439EF2A;
	Fri, 18 Sep 2026 03:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702050; cv=none; b=dWS/KB5HmBz/PGM3sBKHJNoiB2GakE9lv16XSIf3KgCZR6YqxSYi0cTE4DEU403fok0YqbPw5MV2JRbPGmMaRsJp5xjerAs6y/lOsHIfXWjqIVPxURNz2+gbAtCTCoNbFVybMVh8VpqKnWKoN/c9df0R5pqRscT3+dsf/6fydaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702050; c=relaxed/simple;
	bh=eMvpgOlCYSNO8jNPa52KDuoaDDeYU29ATnASRP1l80A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ktdnvnsB/DjMsOmysjq8xlU/E9tpKW7Xkht1nKwBlK6VEMmorGfJIm1Zy1NM/fAF3u0LrMFikoBYdv+X49NBgdS5vJ+T0rovj6912PlEDEHQz32P9UYKEIW7Ns51CGyMLlYmbMgAuzyMA0dhxgy1VceBazqFrKQMpaHlHzq/1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7VdDuPC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7VdDuPC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789702048; x=1821238048;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eMvpgOlCYSNO8jNPa52KDuoaDDeYU29ATnASRP1l80A=;
  b=j7VdDuPCWUsblivqNMLnpw+PSg8TXPilXyPwE/ONgwMt0nGwEjDkVt3H
   fLs3xPkRufw1hgOY3k6cJwQ1zR4Dj6dHnmYv4QyrydIBuvh3OwsaK0CMY
   cgwG9sIUfDHjh0ulK30xFM/vAK5gV+3Wt9xMvK8lMfwEWsLGXO7xuczRn
   r5Ty1fvB7j0Ox7qQx81WD+p0+JPCIDeXzpEWV+UqrFurEBD+47H6ap4Qj
   8kwNHJ7nr44va+aYo5N2h+pnue9SkwtsNPW1WXkm1lDAgwRmWHj1XaczQ
   YGS6UAMWxB4KwTJmOS/IxmCPRDz6sypJiBs8b0AMQYGW0gWE4mwWFEdm/
   A==;
X-CSE-ConnectionGUID: HjeuyjfoQFy+jQPXnFXAfg==
X-CSE-MsgGUID: 7stlToB/TCan92GWl46yCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90045727"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90045727"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 20:27:27 -0700
X-CSE-ConnectionGUID: KTFmkf0kRBmeQ7Y94kyWPg==
X-CSE-MsgGUID: kZ+zaDbXROed+J30DQdACg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271510655"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 20:27:26 -0700
Date: Fri, 18 Sep 2026 11:27:22 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Ian Rogers <irogers@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: [linux-next:master] [perf tests]  1572ba36fb:
 perf-sanity-tests.perf.make.fail
Message-ID: <202609180536.c80fabf6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hello,

kernel test robot noticed "perf-sanity-tests.perf.make.fail" on:

commit: 1572ba36fbca95835dc17b35a70c4524301205c6 ("perf tests: Improvements to build-test performance") https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 0d9d0dbf2fddcff5859d623e90ca73c4054276e1]

in testcase: perf-sanity-tests
with following parameters:

	perf_compiler: clang
	group: group-00

config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 10 threads 1 sockets Intel(R) Core Ultra Series 3 @ 3.20GHz (Panther Lake) with 32G memory

If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202609180536.c80fabf6-lkp@intel.com


make PERF failed:
Makefile.config:1046: No babeltrace2 found, disables 'perf data' CTF format support, please install libbabeltrace2-dev[el]
Makefile.config:1136: Rust is not found. Test workloads with rust are disabled.
  PERF_VERSION = 7.3.0-rc2
util/demangle-cxx.cpp:5:10: fatal error: linux/compiler.h: No such file or directory
    5 | #include <linux/compiler.h>
      |          ^~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-1572ba36fbca95835dc17b35a70c4524301205c6/tools/build/Makefile.build:100: util/demangle-cxx.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-1572ba36fbca95835dc17b35a70c4524301205c6/tools/build/Makefile.build:158: util] Error 2
make[2]: *** [Makefile.perf:574: perf-util-in.o] Error 2
make[1]: *** [Makefile.perf:286: sub-make] Error 2
make: *** [Makefile:82: all] Error 2

Root cause analysis assisted by LLM:

Commit 1572ba36fbca ("perf tests: Improvements to build-test
performance") made tools/perf/Makefile and tools/perf/tests/make skip
computing PARALLEL_OPT/-j$(JOBS) entirely whenever MAKEFLAGS contains
the substrings "-j" or "jobserver", on the assumption that this means
a live GNU Make jobserver is available and should be trusted.

This assumption doesn't always hold: MAKEFLAGS can be set as a plain
environment variable by outer packaging tooling (rpmbuild/mock's
%make_build, %_smp_mflags, etc.) without a live jobserver pipe backing
it. When that happens, PARALLEL_OPT is silently left unset, and worse,
the documented 'make JOBS=1' override -- which the comment explicitly
promises still works -- is ignored too, because the JOBS handling is
nested *inside* the same detection gate. This can result in mismatched
parallelism between nested sub-makes and build failures such as:

  util/demangle-cxx.cpp:5:10: fatal error: linux/compiler.h: No such file or directory

The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260918/202609180536.c80fabf6-lkp@intel.com

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

