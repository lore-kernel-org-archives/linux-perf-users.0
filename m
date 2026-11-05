Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793841016;
	b=eMByqbfpo0jHtEl7cPdvL3+zrDlBHJER2oN+sDSeKw5Intos9QHoKd3h2og8N+37paBf
	 zgLgwdZwONvk0XkmI8ETWm6JQgeyc+BIivTAg68EfHL4sY0kGTC5bQO03UcirZhSDT7Hh
	 fMi14AYO7jl4yVsbALu4frNsCig+lFNF2NxenihJ9CclomIAK8rk9VLtGOpeMHkWTI9Oj
	 XvPylCF1K7nDskBB++nCjZzVRvZiOyOcmxYyzvnn8bICBHuyLz5XJKF/+th+5gutifx0l
	 ehA9xvje+0sGUeA6hyPnBxn8ZGv009jHl32WiN9u/+INxx6p576hsgffZFyhotsl6Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841016;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=06i9S58upGsm3b8HTfTIZOPkxtQFsVP1RAkt5cgN0pg=;
	b=NKqV4A/9cMciUHE48CapJOy4RRixoEfbCeR8pQ8EX0jCv10UDpQmfUFPHiCSV8xXetg1
	 Z6bKjN6oqMj8PwY1wNETb/X0wUVjxwxtwA6f55o9zifIxn3Jsaexw1/zu18K0ut77tJ9R
	 5wWyZP58cjgdcGXoBM165yJzyb0cvNMQYmSjiE4L/9Ln0D+u/rDX1eLst0oNgykOg2oUc
	 HP50oPOIyWowtNbLNTw6Z7rUg7v6UU0HQ0wUSx093x5kPKzf2omrzikWp+pafU2Z3Xhnt
	 PZDOO0ZC569K92BZBvUi7TwSD4LYwKMO6y2ko9rSL52InWhd+FuqfyEb04tVrml0rLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SfM9ui5B;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066A606A31B;
	Thu,  5 Nov 2026 01:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7066A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SfM9ui5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793841016; x=1825377016;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I+YiZY/GNN0hx/CgEHMS2Vj81O65bVBjTSY+GjWMxsY=;
  b=SfM9ui5BZZEe7Uu3SHeC6f4avg5Pnf6wCob7HmRGEoNhkEpwK1+yV4Gd
   lroaa3Lynn8XbneO9BZjpqg1pYX1MYFVPRcQ+ftS0tGry0POHNl+z2u6e
   rOBRv3nfqoaKrHJei4smy2WhzdEZyaBGY6djo9Yzmf/ltnt5Jiiz9dRmD
   guriUozmdDZqVBvybnCGoDrfeuitqPXw/lrcDWMqwLPGLDCIXlZiyPVxr
   oOyq0vdtCLAHqcg+q1zChFY2/f8axh+/It/rUq/DsRuExRqjV4slkafVE
   i4eP9+m1P+bDSG843tda4DTrGO7n5rmZtHs6wPbLdon+E8g9/JS5MhZS/
   Q==;
X-CSE-ConnectionGUID: 4jxDbUQyT/WPU3JKVjjIrA==
X-CSE-MsgGUID: M1iz/vbsRnCSNZMoM4+JBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2500399"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2500399"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 17:10:15 -0800
X-CSE-ConnectionGUID: 4KySTrwQT9KHlMAPuYHeFA==
X-CSE-MsgGUID: 02/vagQKS/6/runkKsdT2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6877447"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 17:10:14 -0800
Date: Thu, 5 Nov 2026 09:10:10 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Ian Rogers <irogers@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, yi1.lai@intel.com
Subject: [linus:master] [perf vendor events intel]  3c989481ee:
 perf-sanity-tests.x86_topdown.topdown_events.fail
Message-ID: <202611050801.67bb4af4-lkp@intel.com>
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



Hello,

kernel test robot noticed "perf-sanity-tests.x86_topdown.topdown_events.fail" on:

commit: 3c989481ee3cc22ac5d34e73862a4016af770710 ("perf vendor events intel: Update emeraldrapids events from 1.24 to 1.25") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c]

in testcase: perf-sanity-tests
with following parameters:

  perf_compiler: gcc
  group: group-02


config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 8592+ (Emerald Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202611050801.67bb4af4-lkp@intel.com


2026-10-04 03:23:58 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-3c989481ee3cc22ac5d34e73862a4016af770710/tools/perf/perf test 77 -v
 77: x86 topdown                                                                                               :
 77.1: topdown events                                                                                          : Running (4 active)
---- start ----
...
event syntax error: 'cpu/mem_trans_retired.load_latency/'
                     \___ Bad event or PMU ...
event syntax error: '..atency/'
                                  \___ expected numeric value ...
event syntax error: '..atency/'
                                  \___ expected numeric value ...
WARNING: events were regrouped to match PMUs evlist after sorting/fixing: '{slots,cpu/topdown-bad-spec/}'
---- end(-1) ----
 77.1: topdown events                                                                                          : FAILED!
 77.2: topdown sorting                                                                                         : Ok
 77.3: topdown slots injection                                                                                 : Ok
 77.4: topdown metrics_clear no extra slots                                                                    : Ok

=== Test Summary ===
Passed main tests : 0
Passed subtests   : 3
Skipped tests     : 0
Failed tests      : 1
List of failed tests:
   77.1: topdown events


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261105/202611050801.67bb4af4-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


