Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C9D33EB06;
	Thu,  7 May 2026 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135877; cv=none; b=nANnot1jnNfO+++K5zJTDIofj4J6xcUXtiLX8bjm1ptT9GIWTQokoLtQ1Z346h80PxwkF2/ruUOVoQXtbu8uTgF2904YL4Y/swk6uYzA5DcF/ARlzt19iBqPezBbFs1vUE9IywHTNWHMCLmqFO8GOh2R1s5EwxRn0lsobUR4qok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135877; c=relaxed/simple;
	bh=pSqmmiQgnMaTo7f4KazajIpoOxo4mBgEJTMVOWqrfp4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mnnQtPKfPa+wm8dEb5DwdvvAQ5pwBVYJXgmUFqKi+wZA1SP0gh5x5HzCWf6IZVh869jh1xMYmWFLGMLSJrs/cRqxaUQdJDObOCKMjddR9xeSXYc7i7VBs6fru/5H3zLu+pUKEOh60QKeQpfb39DUQ5+93hX2YPQjpt2sshHWdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=X1WXfXJR; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=X1WXfXJR; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="X1WXfXJR";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="X1WXfXJR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CTWMLo4jsBct+sVjt0gEHIbyvUbpPYKjmDnTv4upbcQ=;
	b=X1WXfXJRxlpsQdJyxBrjUju1sHY/z4mQZOwc9NzXEL46Ft2/RSLmo6qlIOUdQGpEhCzz7bDa/
	Pd9/J44Sn4N6sAApXyld8YdA6N1KnwgAhXU0WMyoFszh/OrQA3Mpmi2IXnZKgC3gEoXKd/wgY1g
	be98SXZH0JfIELvZY09NWmA=
Received: from canpmsgout09.his.huawei.com (unknown [172.19.92.135])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gB2c870M4z1BGDP;
	Thu,  7 May 2026 14:37:28 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CTWMLo4jsBct+sVjt0gEHIbyvUbpPYKjmDnTv4upbcQ=;
	b=X1WXfXJRxlpsQdJyxBrjUju1sHY/z4mQZOwc9NzXEL46Ft2/RSLmo6qlIOUdQGpEhCzz7bDa/
	Pd9/J44Sn4N6sAApXyld8YdA6N1KnwgAhXU0WMyoFszh/OrQA3Mpmi2IXnZKgC3gEoXKd/wgY1g
	be98SXZH0JfIELvZY09NWmA=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gB2Rf3hc6z1cyQT;
	Thu,  7 May 2026 14:30:06 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9831840539;
	Thu,  7 May 2026 14:37:38 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 14:37:38 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 14:37:37 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@arm.com>,
	<john.g.garry@oracle.com>, <will@kernel.org>, <mike.leach@arm.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <jic23@kernel.org>, <leo.yan@linux.dev>, <robin.murphy@arm.com>,
	<linuxarm@huawei.com>, <hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [RFT PATCH v2 0/7] perf tool: Support iostat for multiple platform
Date: Thu, 7 May 2026 14:37:30 +0800
Message-ID: <20260507063737.3542950-1-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100008.china.huawei.com (7.202.194.111)

Currently, platform-specific iostat code for PMUs is implemented as a
common iostat callback interface and invoked based on what is being
built. This approach limits support for iostat across different types of
PMUs.

Support of HiSilicon PCIe PMU iostat was raised at [1], which uses the
similar approach.

To extend support of iostat across platforms, change common iostat
interface to framework to allow perf to probe PMU capabilities during
runtime and route iostat request to the correct PMU-specific functions.
Then HiSilicon PCIe PMU iostat is supported with the new framework.

Request For Test:
Refactors has been made to x86 iostat to adapt the iostat framework, the
probe function that checks if there's any PMU's name contains
'uncore_iio' may not work properly, tests of that would be appreciated.

[1] https://lore.kernel.org/all/20240208032518.25830-1-yangyicong@huawei.com/

Changes:

RFT v2:
- Replace typedefs with plain function pointer declaration.
- Replace _Bool with bool with the help of stdbool.h.
- Moved architecture-specific iostat implementation code to utils
  directory per Ian.
- Dropped PMU wildcard matching variation, and changed pmu_name to
  pmu_name_wildcard for wildcard PMU name matching.
- Changed PMU name pattern of x86 iostat to "uncore_iio".
- Minor refactors to iostat framework.
Link: https://lore.kernel.org/all/20260126123514.3238425-1-wangyushan12@huawei.com

Shiju Jose (2):
  perf-iostat: Extend iostat interface to support different iostat PMUs
  perf-iostat: Make x86 iostat compatible with new iostat framework

Yicong Yang (1):
  perf-iostat: Enable iostat mode for HiSilicon PCIe PMU

Yushan Wang (4):
  perf stat: Check color's length instead of the pointer
  perf stat: Save unnecessary print_metric() call
  perf-x86: iostat: Move iostat arch-specific implementation to util
  perf-x86: iostat: Change iostat_prefix() to static

 tools/perf/arch/x86/util/Build                |   1 -
 tools/perf/builtin-script.c                   |   2 +-
 tools/perf/util/Build                         |   2 +
 tools/perf/util/hisi-iostat.c                 | 478 ++++++++++++++++++
 tools/perf/util/iostat.c                      |  89 +++-
 tools/perf/util/iostat.h                      |  40 +-
 tools/perf/util/stat-display.c                |   4 +-
 tools/perf/util/stat-shadow.c                 |   4 +-
 .../x86/util/iostat.c => util/x86-iostat.c}   | 100 ++--
 9 files changed, 650 insertions(+), 70 deletions(-)
 create mode 100644 tools/perf/util/hisi-iostat.c
 rename tools/perf/{arch/x86/util/iostat.c => util/x86-iostat.c} (85%)

-- 
2.33.0

