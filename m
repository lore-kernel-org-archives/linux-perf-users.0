Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E01304BBF
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430924; cv=none; b=OkWix6DfH7eL76Fc6mtsTUj+Atvu6KwA6S+QvbF9yYg/fiv2/No55J3s0bvfXgw2GA6JvCBE0VQg7L3H+W5eyMHfvkuhCuMUlTbJJQAWG1Rvq44Rajz4d/I7hMiEPeH1bZTEnQgWDO0AD9d+JzpLsuysvTLqI0EudwYBaWImDCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430924; c=relaxed/simple;
	bh=JsU6dIbanAACv6/zXabYJF83vYn7Pti8YQFHcXX5TOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k1mWB7GSVTT6i1g1ZfFOuiDpJdV9u1al+DeiyGytObO/74AdAxX5a+0M47rs88xavLz5jZUWLiwEW+a4o4v8M2iB1fBzJyuU62dQA3t+U+oI3g2cHnYW52AV7ErMAqLVjhuq5pM3eOg2XkIK2abo+T4sVF56yJiP2Cr86k0f9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sQudvXE7; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sQudvXE7"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eTwA8vL6Im2v+uyk5X4ovdq50U/xpwJjkiF9udIQIcQ=;
	b=sQudvXE7YbO9ohqCC4wlpeeD4RA7NbzwvB4wmO4tBhTIA0UNTj4s9HmyqHUk72hjEbPBdqAP1
	v1bMxMuDyXXBZPHoYzAi219AvFwsz5rAtGQnfE8T+XgYMucoVPtUO4G9kZ6prbftnn9nirACd1n
	Xh9W+rtv7g+L4ty9C75C8ys=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f07F54SGNznTw8;
	Mon, 26 Jan 2026 20:31:21 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C2B140562;
	Mon, 26 Jan 2026 20:35:16 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Jan 2026 20:35:16 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 26 Jan 2026 20:35:15 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <mike.leach@linaro.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <peterz@infradead.org>,
	<john.g.garry@oracle.com>, <Jonathan.Cameron@huawei.com>,
	<shiju.jose@huawei.com>, <will@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <liuyonglong@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [RFT PATCH 0/7] perf tool: Support iostat for multiple platforms
Date: Mon, 26 Jan 2026 20:35:07 +0800
Message-ID: <20260126123514.3238425-1-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
probe function that checks if there's any PMU's name contains 'x86-iio'
may not work properly, tests of that would be appreciated.

[1] https://lore.kernel.org/all/4688a613-c94a-49b0-9d0f-09173c64082d@arm.com/

Shiju Jose (2):
  perf-iostat: Extend iostat interface to support different iostat PMUs
  perf-iostat: Make x86 iostat compatible with new iostat framework

Yicong Yang (1):
  perf-iostat: Enable iostat mode for HiSilicon PCIe PMU

Yushan Wang (4):
  perf stat: Check color's length instead of the pointer
  perf stat: Save unnecessary print_metric() call
  perf-x86: iostat: Change iostat_prefix() to static
  perf-iostat: Support wilder wildcard-match for pmus

 tools/perf/arch/arm64/util/Build         |   1 +
 tools/perf/arch/arm64/util/hisi-iostat.c | 479 +++++++++++++++++++++++
 tools/perf/arch/x86/util/iostat.c        | 105 +++--
 tools/perf/builtin-script.c              |   2 +-
 tools/perf/util/iostat.c                 |  79 ++--
 tools/perf/util/iostat.h                 |  21 +-
 tools/perf/util/pmus.c                   |  12 +-
 tools/perf/util/pmus.h                   |   3 +
 tools/perf/util/stat-display.c           |   4 +-
 tools/perf/util/stat-shadow.c            |   4 +-
 10 files changed, 638 insertions(+), 72 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/hisi-iostat.c

-- 
2.33.0

