Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792153977A;
	Tue, 13 Oct 2026 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917782; cv=none; b=aNhjjDNtyJa5bMqI46Ok5VDSu2C0+a6B909WX/AX1XUNiSvJJudKTwDgS+1oOX/V8FdjaQjv3ZxdWPirPj2588KiYVQ4RvKyTeQpM2DWodlig84CBC/WqtlmFeomGW9DqyDlhda8KMtmkx304WG9t4C30RKZrMdXHxC7xcOzqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917782; c=relaxed/simple;
	bh=Zr6u91rhqkBjnyQNOXrI3qSFg8iNZIlmX7O9cZBaIvg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h4JCWQZj9iTKJ4UDrPDXD3Gk+G11JyB6PbqkDvwgupCWkamvHbAfmuJI0094UcMNtXPrBYD02Zjgz78Az+HSNaay0IFdR4n0KZiOkq0mnGYTIQbzpn0GBy/wNZhxveX4YUlQ6H9nTLDHxZm3lErLOssJIZfQI4/n/rajidX6JY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=d5fjw0C9; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="d5fjw0C9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1791917781; x=1823453781;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ExDc15Ef98vtkv2halza2GLOY92o7Aeod/xe2/R8Z/4=;
  b=d5fjw0C9ZSilqFFY0fvicinohk2ZWZQ15uoKc+VsPEX9jRQQjdayBCjo
   B1t5anymse+PA7CrPmohFbI2mJnj3dJM9et4zwXWd9TiZODQ+oPSRCBaO
   bjj6HPO8O64iRKaYtot5Qf88IOMCI68cTxD8YBfe9XexMi6wW6xLvdM61
   Nlr3Iriguq3AtAPYg6ueWdNgr8nHozgA+oDqkf5X4Xq/rRhIrOYzAw3lX
   BiQCpw89R/8SupVfQDltUK8hco3w2e4VjcLcrSy5KZhclvwUXxnyaxOa2
   58d7dTHP9zlaYH/O6GiW91aHVnXcCZDecXhV5ZiGWr5JwfkvCefHWxSIc
   A==;
X-CSE-ConnectionGUID: oWznY2ffSqarfFIC8BEq2w==
X-CSE-MsgGUID: VXbXS8RXQHO3aQJZ0MCX2A==
X-IronPort-AV: E=Sophos;i="6.27,156,1787011200"; 
   d="scan'208";a="31152671"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 18:56:20 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:8919]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.175:2525] with esmtp (Farcaster)
 id f1b4118a-6202-4225-89df-e251ce4331da; Tue, 13 Oct 2026 18:56:20 +0000 (UTC)
X-Farcaster-Flow-ID: f1b4118a-6202-4225-89df-e251ce4331da
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 18:56:20 +0000
Received: from u34cccd802f2d52.amazon.com (10.187.170.30) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 18:56:19 +0000
From: Haris Okanovic <harisokn@amazon.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <harisokn@amazon.com>
Subject: [PATCH 0/4] perf: Manage single-CPU PMU affinity in perf core
Date: Tue, 13 Oct 2026 13:55:59 -0500
Message-ID: <20261013185603.1347265-1-harisokn@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

About 25 PMU drivers, nearly all under drivers/perf, drive their PMU from
a single CPU, and each implements the same logic independently: pick a CPU
at probe with cpumask_local_spread(), cpumask_any(), cpumask_any_and() or
similar, register a CPUHP state to handle hotplug migration, bind every
event to that CPU in event_init(), and publish it via a 'cpumask'
attribute.

Besides the duplicated code, that has two costs. On systems with many
PMUs, the arbitrary choice tends to land all of them on the same CPU,
concentrating overhead there. The chosen CPU also cannot be changed
afterwards, except via hotplug, which is awkward on systems that confine
background kernel work to housekeeping CPUs or otherwise isolate PMUs
from latency sensitive work.

These patches move the choice into perf core as a new "device" pmu::scope.
A driver describes which CPUs are eligible with an optional
filter_allowed_cpus() callback; core intersects that with the online CPUs,
picks one with cpumask_any_distribute() so instances spread out, migrates
events on hotplug, and reports the result through an optional migrate_cpu()
so the driver can follow with interrupt affinity.

'cpumask' is made writable for device scope, so users can also choose the
owning CPU deliberately, e.g. to move a PMU onto a housekeeping CPU. The
attribute is read-only or absent in other scopes. Reusing it was the
minimal change, and I'm happy to add a separate attribute instead if you
would rather 'cpumask' stayed read-only everywhere.

Only arm-cmn is converted in this series, as an example and because it is
what I can test today. I have prototype conversions for the other 24
drivers locally and will post them if the core approach looks right, but I
have no access to most of that hardware and will need help testing.

The series also carries two synchronization changes for events left behind
by migration: the __perf_pmu_remove() fix in patch 1 and the sequence
counter mechanism in patch 2. Neither problem is new. Under hotplug,
leftover events are torn down with the dying CPU, which limits the damage.
Migrating between two online CPUs leaves nothing to clean them up, so they
matter more once users can request migration. I'm open to suggestions on
different or better ways to close these races.

Tested arm-cmn on two platforms with CONFIG_PROVE_LOCKING=y:

  AWS m9g.metal-48xl CMN S3,  one mesh,   192 CPUs
  AWS m8g.metal-48xl CMN-700, two meshes, 192 CPUs

  - Events multiplex on the configured CPU, and the two meshes are placed
    on distinct CPUs at registration.
  - Offlining the owning CPU migrates every open event and updates the
    attribute; nothing is left behind on the dying CPU.
  - Writing 'cpumask' migrates open events, and offlining the vacated CPU
    afterwards strands nothing. Bad input is rejected with EINVAL, ERANGE
    or ENODEV without moving the PMU.
  - Hammering perf_event_open() from 64 threads while flipping 'cpumask'
    between two CPUs does not strand events.
  - No lockdep reports on either platform.

This supersedes the arm-cmn-only approach, following Robin Murphy's
suggestion that CPU affinity be generalized into perf core:

  https://lore.kernel.org/linux-arm-kernel/2d70be7b-12c0-46e0-b308-744a3159388a@arm.com/

Haris Okanovic (4):
  perf/core: Fix perf_pmu_migrate_context() leaving events behind
  perf/core: Add PERF_PMU_SCOPE_DEVICE
  perf/core: Allow userspace to select a device PMU's CPU
  perf/arm-cmn: Convert to PERF_PMU_SCOPE_DEVICE

 drivers/perf/arm-cmn.c     | 104 ++++------------
 include/linux/perf_event.h |  26 ++++
 kernel/events/core.c       | 247 +++++++++++++++++++++++++++++++++----
 3 files changed, 274 insertions(+), 103 deletions(-)

-- 
Haris Okanovic
AWS Graviton

