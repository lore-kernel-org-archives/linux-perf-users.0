From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PULL] Please pull Intel JSON file updates
Date: Thu, 18 Jan 2018 15:45:18 -0800
Message-ID: <20180118234518.GA27753@tassilo.jf.intel.com>
References: <20180118184335.GA17406@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:61775 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932394AbeARXp1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Jan 2018 18:45:27 -0500
Content-Disposition: inline
In-Reply-To: <20180118184335.GA17406@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org

On Thu, Jan 18, 2018 at 10:43:35AM -0800, Andi Kleen wrote:
> Arnaldo,
> 
> Please pull the Intel JSON file updates for perf. 
> 
> No new CPUs, but I updated all the Intel files since IvyBridge
> to the latest versions from 01.org. There are many changes,
> updated descriptions, some new events and general improvements.

Update: this is a revised pull request which fixes some problems with
the IvyBridge/Town offcore response events. It's additional patches,
so if you pulled the earlier one call pull this one on top of it.

The following changes since commit a72594ca5c70ef4a94fab8ad541beda0d0a94139:

  Merge tag 'perf-core-for-mingo-4.16-20180117' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-01-17 17:20:24 +0100)

are available in the Git repository at:

  ssh://ra.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/intel-json-updates-20180118-1

for you to fetch changes up to 4d877b7629e8e804f6a7fc75ab890c7f6fe72d07:

  perf vendor events: Update IvyTown files to V20 (2018-01-18 15:41:17 -0800)

----------------------------------------------------------------
Andi Kleen (13):
      perf vendor events: Update Broadwell events to V22
      perf vendor events: Update BroadwellX events to V13
      perf vendor events: Update Goldmont events to V12
      perf vendor events: Update Haswell events to V27
      perf vendor events: Update HaswellX events to V19
      perf vendor events: Update IvyBridge events to V20
      perf vendor events: Update IvyTown events to V20
      perf vendor events: Update Silvermont events to V14
      perf vendor events: Update Skylake events to V36
      perf vendor events: Update SkylakeX events to V1.06
      perf vendor events: Update BroadwellDE events to V7
      perf vendor events: Update IvyBridge files to V20
      perf vendor events: Update IvyTown files to V20

 .../perf/pmu-events/arch/x86/broadwell/cache.json  |  555 ++-
 .../arch/x86/broadwell/floating-point.json         |  108 +-
 .../pmu-events/arch/x86/broadwell/frontend.json    |  138 +-
 .../perf/pmu-events/arch/x86/broadwell/memory.json |  210 +-
 .../perf/pmu-events/arch/x86/broadwell/other.json  |   20 +-
 .../pmu-events/arch/x86/broadwell/pipeline.json    | 1216 +++---
 .../arch/x86/broadwell/virtual-memory.json         |  150 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     |  389 +-
 .../arch/x86/broadwellde/floating-point.json       |  108 +-
 .../pmu-events/arch/x86/broadwellde/frontend.json  |  138 +-
 .../pmu-events/arch/x86/broadwellde/memory.json    |    9 +-
 .../pmu-events/arch/x86/broadwellde/other.json     |   20 +-
 .../pmu-events/arch/x86/broadwellde/pipeline.json  | 1214 +++---
 .../arch/x86/broadwellde/virtual-memory.json       |  150 +-
 .../perf/pmu-events/arch/x86/broadwellx/cache.json |  383 +-
 .../arch/x86/broadwellx/floating-point.json        |  108 +-
 .../pmu-events/arch/x86/broadwellx/frontend.json   |  138 +-
 .../pmu-events/arch/x86/broadwellx/memory.json     |   40 +-
 .../perf/pmu-events/arch/x86/broadwellx/other.json |   20 +-
 .../pmu-events/arch/x86/broadwellx/pipeline.json   | 1214 +++---
 .../arch/x86/broadwellx/virtual-memory.json        |  150 +-
 tools/perf/pmu-events/arch/x86/goldmont/cache.json | 1244 +++++-
 .../perf/pmu-events/arch/x86/goldmont/memory.json  |  280 +-
 tools/perf/pmu-events/arch/x86/goldmont/other.json |   54 +-
 .../pmu-events/arch/x86/goldmont/pipeline.json     |  506 +--
 .../arch/x86/goldmont/virtual-memory.json          |   60 +-
 tools/perf/pmu-events/arch/x86/haswell/cache.json  |  365 +-
 .../arch/x86/haswell/floating-point.json           |   20 +-
 .../perf/pmu-events/arch/x86/haswell/frontend.json |  132 +-
 tools/perf/pmu-events/arch/x86/haswell/memory.json |   21 +
 tools/perf/pmu-events/arch/x86/haswell/other.json  |   20 +-
 .../perf/pmu-events/arch/x86/haswell/pipeline.json | 1131 ++---
 .../arch/x86/haswell/virtual-memory.json           |  212 +-
 tools/perf/pmu-events/arch/x86/haswellx/cache.json |  377 +-
 .../arch/x86/haswellx/floating-point.json          |   20 +-
 .../pmu-events/arch/x86/haswellx/frontend.json     |  132 +-
 .../perf/pmu-events/arch/x86/haswellx/memory.json  |   28 +
 tools/perf/pmu-events/arch/x86/haswellx/other.json |   20 +-
 .../pmu-events/arch/x86/haswellx/pipeline.json     | 1133 ++---
 .../arch/x86/haswellx/virtual-memory.json          |  212 +-
 .../perf/pmu-events/arch/x86/ivybridge/cache.json  |  243 +-
 .../pmu-events/arch/x86/ivybridge/frontend.json    |  122 +-
 .../perf/pmu-events/arch/x86/ivybridge/memory.json |   24 +-
 .../perf/pmu-events/arch/x86/ivybridge/other.json  |   20 +-
 .../pmu-events/arch/x86/ivybridge/pipeline.json    |  822 ++--
 .../arch/x86/ivybridge/virtual-memory.json         |   60 +-
 tools/perf/pmu-events/arch/x86/ivytown/cache.json  |  236 +-
 .../perf/pmu-events/arch/x86/ivytown/frontend.json |  122 +-
 tools/perf/pmu-events/arch/x86/ivytown/memory.json |   24 +-
 tools/perf/pmu-events/arch/x86/ivytown/other.json  |   20 +-
 .../perf/pmu-events/arch/x86/ivytown/pipeline.json |  822 ++--
 .../arch/x86/ivytown/virtual-memory.json           |   60 +-
 .../perf/pmu-events/arch/x86/silvermont/cache.json |    3 +-
 tools/perf/pmu-events/arch/x86/skylake/cache.json  | 4390 +++-----------------
 .../arch/x86/skylake/floating-point.json           |    5 +-
 .../perf/pmu-events/arch/x86/skylake/frontend.json |  232 +-
 tools/perf/pmu-events/arch/x86/skylake/memory.json | 2118 +---------
 tools/perf/pmu-events/arch/x86/skylake/other.json  |   40 +-
 .../perf/pmu-events/arch/x86/skylake/pipeline.json |  973 ++---
 .../arch/x86/skylake/virtual-memory.json           |  262 +-
 tools/perf/pmu-events/arch/x86/skylakex/cache.json |  257 +-
 .../arch/x86/skylakex/floating-point.json          |    3 +-
 .../pmu-events/arch/x86/skylakex/frontend.json     |   48 +-
 .../perf/pmu-events/arch/x86/skylakex/memory.json  |  231 +-
 tools/perf/pmu-events/arch/x86/skylakex/other.json |   94 +-
 .../pmu-events/arch/x86/skylakex/pipeline.json     |   44 +-
 .../arch/x86/skylakex/virtual-memory.json          |   42 +-
 67 files changed, 10418 insertions(+), 13344 deletions(-)
