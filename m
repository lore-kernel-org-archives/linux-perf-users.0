Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7657730E836;
	Mon,  1 Dec 2025 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588181; cv=none; b=K+KEAee19HTwvPJgXlRCWaHKcAK6vj9r3iD5jYipSKALXevU0wLt4X73O6tCKV1BdzLqkot85jPFL7oVXF5IhlVpxJ0KzSSKUm5JgZPC3u82HDmMWr7D0yW3WlFy7jyL1+wzzZ9IJTVLZ2TixQ1NwCK578DHg5RxCEPGGso9Adk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588181; c=relaxed/simple;
	bh=8RrcyuAmXl4l9e1cKb6duyp4YPXzhlLxNp/3AlZJifs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fqrp+Q1ahA5pSYEaR6qaxlOo2jPvJsFpPvdi2XgeYJsKCt9IWYrc9n7fumJaRenQaMJkc3b+JDfxKOfjdwDXsU7L34cNJ5wphhqRJ5Q7cWrCvT+E87B5cevS8jGYW+1z33z+yVAYkyuiX+jXAgeVku/GGtz7wc9qO8o4GdNu5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7915F1596;
	Mon,  1 Dec 2025 03:22:51 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C3B73F59E;
	Mon,  1 Dec 2025 03:22:56 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 01 Dec 2025 11:22:08 +0000
Subject: [PATCH 18/19] coresight: trbe: Add kunit tests
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-trbe_buffer_refactor_v1-1-v1-18-7da32b076b28@arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>, 
 Tamas Zsoldos <tamas.zsoldos@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764588125; l=26933;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=8RrcyuAmXl4l9e1cKb6duyp4YPXzhlLxNp/3AlZJifs=;
 b=5QDU0iQZnycrovffIn+bvP3nYITunOC/cf88qD7cIMaHRIDBgF0g67HHADsScSqZr4Nwnm3cU
 nptNHlTVFQaD5csXLmqd0FtzRXmwG/yyt+NeASH3wwXPVyqbXZCeEND
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add tests to verify the calculation of the limit and trigger count.

Because trigger mode can be disabled, provide two test suites: one with
trigger mode enabled and one with it disabled.

The cpudata structure is initialized by the test stub, so move its
definition into the header for including.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/Kconfig                |   9 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 .../coresight/coresight-trbe-kunit-tests.c         | 536 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-trbe.c       | 112 +----
 drivers/hwtracing/coresight/coresight-trbe.h       |  89 ++++
 5 files changed, 660 insertions(+), 87 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 6a4239ebb582e95f0ebe8e9c8738a726f27f60a1..f5758563c0090141cdca67f16e7b7b32e7c75bb8 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -214,6 +214,15 @@ config CORESIGHT_TRBE
 	  To compile this driver as a module, choose M here: the module will be
 	  called coresight-trbe.
 
+config CORESIGHT_TRBE_KUNIT_TESTS
+	tristate "Enable Coresight TRBE unit tests"
+	depends on KUNIT
+	depends on CORESIGHT_TRBE
+	default KUNIT_ALL_TESTS
+	help
+	  Enable Coresight TRBE unit tests. Only useful for development and not
+	  intended for production.
+
 config ULTRASOC_SMB
 	tristate "Ultrasoc system memory buffer drivers"
 	depends on ACPI || COMPILE_TEST
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index ab16d06783a572ea1308dfb3a30c96df9e5ffdb7..f8961f6883d167bc2c4bca8008eceb08c3c3a0e9 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
 obj-$(CONFIG_CORESIGHT_CTCU) += coresight-ctcu.o
 coresight-ctcu-y := coresight-ctcu-core.o
 obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
+obj-$(CONFIG_CORESIGHT_TRBE_KUNIT_TESTS) += coresight-trbe-kunit-tests.o
diff --git a/drivers/hwtracing/coresight/coresight-trbe-kunit-tests.c b/drivers/hwtracing/coresight/coresight-trbe-kunit-tests.c
new file mode 100644
index 0000000000000000000000000000000000000000..836f76dce155d533f9076e85dc97ba25221b7bbf
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trbe-kunit-tests.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/test.h>
+#include <kunit/device.h>
+#include <linux/coresight.h>
+
+#include "coresight-priv.h"
+#include "coresight-trbe.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+static void test_compute_offset(struct kunit *test)
+{
+	struct perf_output_handle handle = { 0 };
+	struct trbe_buf buf = { 0 };
+	struct trbe_cpudata cpudata = { .trbe_align = PAGE_SIZE };
+	unsigned long limit;
+
+	if (!static_branch_unlikely(&trbe_trigger_mode_bypass))
+		return;
+
+	cpudata.trbe_hw_align = 1;
+
+	buf.nr_pages = SZ_1M / SZ_4K;
+	buf.cpudata = &cpudata;
+
+	handle.rb = (void *)&buf;
+
+	/*
+	 * ### : Free space, $$$ : Filled space
+	 *
+	 * |################|################|
+	 * `head            `wakeup
+	 * `tail            `limit
+	 */
+	handle.head = 0;
+	handle.size = SZ_1M;
+	handle.wakeup = SZ_1M / 2;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M / 2);
+
+	/*
+	 * |################|################|
+	 * `head            `wakeup         `tail
+	 *                  `limit
+	 */
+	handle.head = 0;
+	handle.size = SZ_1M - 1;
+	handle.wakeup = SZ_1M / 2;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M / 2);
+
+	/*
+	 * |#################################|
+	 * `head                            `tail
+	 * `wakeup                         `limit
+	 */
+	handle.head = 0;
+	handle.size = SZ_1M - 1;
+	handle.wakeup = 0;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, 0);
+
+	/*
+	 * |#################################|
+	 * `head                            `tail
+	 *                                   `wakeup
+	 *                                 `limit
+	 */
+	handle.head = 0;
+	handle.size = SZ_1M - 1;
+	handle.wakeup = SZ_1M;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M - SZ_4K);
+
+	/*
+	 * |$$$$$$$$$$$$$$$$|########|#######|
+	 *                  `head           `tail
+	 *                           `wakeup
+	 *                                 `limit
+	 */
+	handle.head = SZ_1M / 2;
+	handle.size = SZ_1M / 2 - 1;
+	handle.wakeup = SZ_1M * 3 / 4;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M * 3 / 4);
+
+	/*
+	 * |$$$$$$$$|$$$$$$$|################|
+	 *                  `head           `tail
+	 *          `wakeup
+	 *                                 `limit
+	 */
+	handle.head = SZ_1M / 2;
+	handle.size = SZ_1M / 2 - 1;
+	handle.wakeup = SZ_1M * 1 / 4;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M - SZ_4K);
+
+	/*
+	 * |$$$$$$$$$$$$$$$$|################|
+	 *                  `head           `tail
+	 *                                  `wakeup
+	 *                                 `limit
+	 */
+	handle.head = SZ_1M / 2;
+	handle.size = SZ_1M / 2 - 1;
+	handle.wakeup = SZ_1M - 1;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M - SZ_4K);
+
+	/*
+	 * |#########|$$$$$$$$$$|########|###|
+	 *           `tail      `head    `wakeup
+	 *                                   `limit
+	 */
+	handle.head = SZ_1M * 3 / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = handle.head + SZ_1M / 8;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M * 7 / 8);
+
+	/*
+	 * |####|####|$$$$$$$$$$|############|
+	 *           `tail      `head
+	 *      `wakeup
+	 *                                   `limit
+	 */
+	handle.head = SZ_1M * 3 / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = SZ_1M + SZ_1M / 8;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M);
+
+	/*
+	 * |#######|########|$$$$$$$$$$$$$$$$|
+	 * `head   `wakeup  `>tail
+	 *         `limit
+	 */
+	handle.head = SZ_1M;
+	handle.wakeup = SZ_1M + SZ_1M / 8;
+	handle.size = SZ_1M / 2;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M / 8);
+
+	/*
+	 * |#######|$$$$$$$$$$$$$$$$$|#######|
+	 *         `tail             `head
+	 *         `wakeup
+	 *                                   `limit
+	 */
+	handle.head = SZ_1M * 3 / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = SZ_1M + SZ_1M / 4;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M);
+
+	/*
+	 * |#######|$$$$$$$$|$$$$$$$$|#######|
+	 *         `tail    `wakeup  `head
+	 *                                   `limit
+	 */
+	handle.head = SZ_1M * 3 / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = SZ_1M + SZ_1M / 2;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M);
+
+	/*
+	 * |$$$$$$$|########|########|$$$$$$$|
+	 *         `head    `wakeup  `tail
+	 *                           `limit
+	 */
+	handle.head = SZ_1M / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = SZ_1M / 2;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M / 2);
+
+	/*
+	 * |$$$$$$$|#################|$$$$$$$|
+	 *         `head             `tail
+	 *                           `wakeup
+	 *                           `limit
+	 */
+	handle.head = SZ_1M / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = SZ_1M * 3 / 4;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M * 3 / 4);
+
+	/*
+	 * |$$$$$$$|#################|$$$$$$$|
+	 * `wakeup `head             `tail
+	 *                           `limit
+	 */
+	handle.head = SZ_1M / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = 0;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M * 3 / 4);
+
+	/*
+	 * |$$$$$$|$$$$$$$$$$$$$$$$$$$$$$$$$$|
+	 *        `head
+	 *        `tail
+	 */
+	handle.head = SZ_1M / 4;
+	handle.size = 0;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, 0);
+
+	/*
+	 * |$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$|#$|
+	 *                                `head
+	 *                                  `tail
+	 */
+	handle.head = SZ_1M - SZ_1K * 2;
+	handle.size = SZ_1K;
+	handle.wakeup = 0;
+
+	limit = __trbe_normal_offset(&handle);
+	KUNIT_ASSERT_EQ(test, limit, 0);
+}
+
+static void test_compute_offset_and_counter(struct kunit *test)
+{
+	struct perf_output_handle handle = { 0 };
+	struct trbe_buf buf = { 0 };
+	struct trbe_cpudata cpudata = { .trbe_align = PAGE_SIZE };
+	unsigned long limit;
+	u64 count;
+
+	if (static_branch_unlikely(&trbe_trigger_mode_bypass))
+		return;
+
+	cpudata.trbe_hw_align = 1;
+
+	buf.nr_pages = SZ_1M / SZ_4K;
+	buf.cpudata = &cpudata;
+
+	handle.rb = (void *)&buf;
+
+	/*
+	 * ### : Free space, $$$ : Filled space
+	 *
+	 * |################|################|
+	 * `head            `wakeup          `limit
+	 * `tail
+	 * `----- count ----'
+	 */
+	handle.head = 0;
+	handle.size = SZ_1M;
+	handle.wakeup = SZ_1M / 2;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M);
+	KUNIT_ASSERT_EQ(test, count, SZ_1M / 2);
+
+	/*
+	 * |################|################|
+	 * `head            `wakeup         `tail
+	 *                                 `limit
+	 * `----- count ----'
+	 */
+	handle.head = 0;
+	handle.size = SZ_1M - 1;
+	handle.wakeup = SZ_1M / 2;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M - SZ_4K);
+	KUNIT_ASSERT_EQ(test, count, SZ_1M / 2);
+
+	/*
+	 * |#################################|
+	 * `head                            `tail
+	 * `wakeup                         `limit
+	 */
+	handle.head = 0;
+	handle.size = SZ_1M - 1;
+	handle.wakeup = 0;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M - SZ_4K);
+	KUNIT_ASSERT_EQ(test, count, 0);
+
+	/*
+	 * |#################################|
+	 * `head                            `tail
+	 *                                   `wakeup
+	 *                                 `limit
+	 */
+	handle.head = 0;
+	handle.size = SZ_1M - 1;
+	handle.wakeup = SZ_1M;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M - SZ_4K);
+	KUNIT_ASSERT_EQ(test, count, 0);
+
+	/*
+	 * |$$$$$$$$$$$$$$$$|########|#######|
+	 *                  `head           `tail
+	 *                           `wakeup
+	 *                                 `limit
+	 *                  [  count ]
+	 */
+	handle.head = SZ_1M / 2;
+	handle.size = SZ_1M / 2 - 1;
+	handle.wakeup = SZ_1M * 3 / 4;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M - SZ_4K);
+	KUNIT_ASSERT_EQ(test, count, SZ_1M / 4);
+
+	/*
+	 * |$$$$$$$$|$$$$$$$|################|
+	 *                  `head           `tail
+	 *          `wakeup
+	 *                                 `limit
+	 */
+	handle.head = SZ_1M / 2;
+	handle.size = SZ_1M / 2 - 1;
+	handle.wakeup = SZ_1M * 1 / 4;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M - SZ_4K);
+	KUNIT_ASSERT_EQ(test, count, 0);
+
+	/*
+	 * |$$$$$$$$$$$$$$$$|################|
+	 *                  `head           `tail
+	 *                                  `wakeup
+	 *                                 `limit
+	 */
+	handle.head = SZ_1M / 2;
+	handle.size = SZ_1M / 2 - 1;
+	handle.wakeup = SZ_1M - 1;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M - SZ_4K);
+	KUNIT_ASSERT_EQ(test, count, 0);
+
+	/*
+	 * |#########|$$$$$$$$$$|########|###|
+	 *           `tail      `head    `wakeup
+	 *                                   `limit
+	 *                      [  count ]
+	 */
+	handle.head = SZ_1M * 3 / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = handle.head + SZ_1M / 8;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M);
+	KUNIT_ASSERT_EQ(test, count, SZ_1M / 8);
+
+	/*
+	 * |####|####|$$$$$$$$$$|############|
+	 *           `tail      `head
+	 *      `wakeup
+	 *                                   `limit
+	 *                      [   count  >>>
+	 * >>>       ]
+	 */
+	handle.head = SZ_1M * 3 / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = SZ_1M + SZ_1M / 8;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M);
+	KUNIT_ASSERT_EQ(test, count, SZ_1M / 2);
+
+	/*
+	 * |#######|########|$$$$$$$$$$$$$$$$|
+	 * `head   `wakeup  `>tail
+	 *                  `limit
+	 * [ count ]
+	 */
+	handle.head = SZ_1M;
+	handle.wakeup = SZ_1M + SZ_1M / 8;
+	handle.size = SZ_1M / 2;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M / 2);
+	KUNIT_ASSERT_EQ(test, count, SZ_1M / 8);
+
+	/*
+	 * |#######|$$$$$$$$$$$$$$$$$|#######|
+	 *         `tail             `head
+	 *         `wakeup
+	 *                                   `limit
+	 *                           [ count >
+	 * >>>     ]
+	 */
+	handle.head = SZ_1M * 3 / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = SZ_1M + SZ_1M / 4;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M);
+	KUNIT_ASSERT_EQ(test, count, SZ_1M / 2);
+
+	/*
+	 * |#######|$$$$$$$$|$$$$$$$$|#######|
+	 *         `tail    `wakeup  `head
+	 *                                   `limit
+	 *                           [ count >
+	 * >>>     ]
+	 */
+	handle.head = SZ_1M * 3 / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = SZ_1M + SZ_1M / 2;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M);
+	KUNIT_ASSERT_EQ(test, count, SZ_1M / 2);
+
+	/*
+	 * |$$$$$$$|########|########|$$$$$$$|
+	 *         `head    `wakeup  `tail
+	 *                           `limit
+	 *         [ count  ]
+	 */
+	handle.head = SZ_1M / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = SZ_1M / 2;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M * 3 / 4);
+	KUNIT_ASSERT_EQ(test, count, SZ_1M / 4);
+
+	/*
+	 * |$$$$$$$|#################|$$$$$$$|
+	 *         `head             `tail
+	 *                           `wakeup
+	 *                           `limit
+	 */
+	handle.head = SZ_1M / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = SZ_1M * 3 / 4;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M * 3 / 4);
+	KUNIT_ASSERT_EQ(test, count, 0);
+
+	/*
+	 * |$$$$$$$|#################|$$$$$$$|
+	 * `wakeup `head             `tail
+	 *                           `limit
+	 */
+	handle.head = SZ_1M / 4;
+	handle.size = SZ_1M / 2;
+	handle.wakeup = 0;
+
+	limit = __trbe_normal_offset(&handle);
+	buf.trbe_limit = limit;
+	count = __trbe_normal_trigger_count(&handle);
+
+	KUNIT_ASSERT_EQ(test, limit, SZ_1M * 3 / 4);
+	KUNIT_ASSERT_EQ(test, count, 0);
+}
+
+static struct kunit_case coresight_trbe_testcases[] = {
+	KUNIT_CASE(test_compute_offset),
+	KUNIT_CASE(test_compute_offset_and_counter),
+	{}
+};
+
+static struct kunit_suite coresight_trbe_test_suite = {
+	.name = "coresight_trbe_test_suite",
+	.test_cases = coresight_trbe_testcases,
+};
+
+kunit_test_suites(&coresight_trbe_test_suite);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Leo Yan <leo.yan@arm.com>");
+MODULE_DESCRIPTION("Arm CoreSight TRBE KUnit tests");
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index ee9993d518d2a41f0d709b7d0690b2dfe0bef2d9..25d42683ab74b55efa2e19a2d77ab8ae2d68d228 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -54,92 +54,12 @@ enum trbe_fault_action {
 	TRBE_FAULT_ACT_FATAL,
 };
 
-struct trbe_buf {
-	/*
-	 * Even though trbe_base represents vmap()
-	 * mapped allocated buffer's start address,
-	 * it's being as unsigned long for various
-	 * arithmetic and comparision operations &
-	 * also to be consistent with trbe_write &
-	 * trbe_limit sibling pointers.
-	 */
-	unsigned long trbe_base;
-	/* The base programmed into the TRBE */
-	unsigned long trbe_hw_base;
-	unsigned long trbe_limit;
-	unsigned long trbe_write;
-	unsigned long trbe_count;
-	int nr_pages;
-	void **pages;
-	bool snapshot;
-	struct trbe_cpudata *cpudata;
-};
-
-/*
- * TRBE erratum list
- *
- * The errata are defined in arm64 generic cpu_errata framework.
- * Since the errata work arounds could be applied individually
- * to the affected CPUs inside the TRBE driver, we need to know if
- * a given CPU is affected by the erratum. Unlike the other erratum
- * work arounds, TRBE driver needs to check multiple times during
- * a trace session. Thus we need a quicker access to per-CPU
- * errata and not issue costly this_cpu_has_cap() everytime.
- * We keep a set of the affected errata in trbe_cpudata, per TRBE.
- *
- * We rely on the corresponding cpucaps to be defined for a given
- * TRBE erratum. We map the given cpucap into a TRBE internal number
- * to make the tracking of the errata lean.
- *
- * This helps in :
- *   - Not duplicating the detection logic
- *   - Streamlined detection of erratum across the system
- */
-#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
-#define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE	1
-#define TRBE_NEEDS_DRAIN_AFTER_DISABLE		2
-#define TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE	3
-#define TRBE_IS_BROKEN				4
-
-static int trbe_errata_cpucaps[] = {
-	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
-	[TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
-	[TRBE_NEEDS_DRAIN_AFTER_DISABLE] = ARM64_WORKAROUND_2064142,
-	[TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE] = ARM64_WORKAROUND_2038923,
-	[TRBE_IS_BROKEN] = ARM64_WORKAROUND_1902691,
-	-1,		/* Sentinel, must be the last entry */
-};
-
-/* The total number of listed errata in trbe_errata_cpucaps */
-#define TRBE_ERRATA_MAX			(ARRAY_SIZE(trbe_errata_cpucaps) - 1)
-
 /*
  * Safe limit for the number of bytes that may be overwritten
  * when ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE is triggered.
  */
 #define TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP_BYTES	256
 
-/*
- * struct trbe_cpudata: TRBE instance specific data
- * @trbe_flag		- TRBE dirty/access flag support
- * @trbe_hw_align	- Actual TRBE alignment required for TRBPTR_EL1.
- * @trbe_align		- Software alignment used for the TRBPTR_EL1.
- * @cpu			- CPU this TRBE belongs to.
- * @mode		- Mode of current operation. (perf/disabled)
- * @drvdata		- TRBE specific drvdata
- * @errata		- Bit map for the errata on this TRBE.
- */
-struct trbe_cpudata {
-	bool trbe_flag;
-	u64 trbe_hw_align;
-	u64 trbe_align;
-	int cpu;
-	enum cs_mode mode;
-	struct trbe_buf *buf;
-	struct trbe_drvdata *drvdata;
-	DECLARE_BITMAP(errata, TRBE_ERRATA_MAX);
-};
-
 struct trbe_drvdata {
 	struct trbe_cpudata __percpu *cpudata;
 	struct perf_output_handle * __percpu *handle;
@@ -150,7 +70,8 @@ struct trbe_drvdata {
 	struct platform_device *pdev;
 };
 
-DEFINE_STATIC_KEY_FALSE(trbe_trigger_mode_bypass);
+VISIBLE_IF_KUNIT DEFINE_STATIC_KEY_FALSE(trbe_trigger_mode_bypass);
+EXPORT_SYMBOL_IF_KUNIT(trbe_trigger_mode_bypass);
 
 #define trbe_trigger_mode_need_bypass(cpudata)		\
 	(trbe_may_overwrite_in_fill_mode((cpudata)) ||	\
@@ -333,8 +254,17 @@ static void __trbe_pad_buf(struct trbe_buf *buf, u64 offset, int len)
 
 static void trbe_pad_buf(struct perf_output_handle *handle, int len)
 {
-	struct trbe_buf *buf = etm_perf_sink_config(handle);
-	u64 head = PERF_IDX2OFF(handle->head, buf);
+	struct trbe_buf *buf;
+	u64 head;
+
+	if (kunit_get_current_test()) {
+		handle->head += len;
+		handle->size -= len;
+		return;
+	}
+
+	buf = etm_perf_sink_config(handle);
+	head = PERF_IDX2OFF(handle->head, buf);
 
 	__trbe_pad_buf(buf, head, len);
 	if (!buf->snapshot)
@@ -383,9 +313,11 @@ static u64 trbe_min_trace_buf_size(struct perf_output_handle *handle)
  * %%%% - Free area, disabled, trace will not be written
  * ==== - Free area, padded with ETE_IGNORE_PACKET, trace will be skipped
  */
-static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
+VISIBLE_IF_KUNIT
+unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
 {
-	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	struct trbe_buf *buf =
+		kunit_get_current_test() ? handle->rb : etm_perf_sink_config(handle);
 	struct trbe_cpudata *cpudata = buf->cpudata;
 	const u64 bufsize = buf->nr_pages * PAGE_SIZE;
 	u64 limit = bufsize;
@@ -525,9 +457,13 @@ static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
 	return 0;
 }
 
-static u64 __trbe_normal_trigger_count(struct perf_output_handle *handle)
+EXPORT_SYMBOL_IF_KUNIT(__trbe_normal_offset);
+
+VISIBLE_IF_KUNIT
+u64 __trbe_normal_trigger_count(struct perf_output_handle *handle)
 {
-	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	struct trbe_buf *buf =
+		kunit_get_current_test() ? handle->rb : etm_perf_sink_config(handle);
 	struct trbe_cpudata *cpudata = buf->cpudata;
 	u64 limit, head, wakeup;
 	u64 count = 0;
@@ -558,6 +494,8 @@ static u64 __trbe_normal_trigger_count(struct perf_output_handle *handle)
 	return count;
 }
 
+EXPORT_SYMBOL_IF_KUNIT(__trbe_normal_trigger_count);
+
 static int trbe_normal_offset(struct perf_output_handle *handle)
 {
 	struct trbe_buf *buf = etm_perf_sink_config(handle);
diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
index 4c65d164a946ec9860825e7564196745b60d730b..8f90836b5f71d44213699ec1915d59864863a4db 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.h
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -17,8 +17,91 @@
 #include <linux/platform_device.h>
 #include <linux/smp.h>
 
+#include <kunit/test-bug.h>
+#include <kunit/visibility.h>
+
 #include "coresight-etm-perf.h"
 
+struct trbe_buf {
+	/*
+	 * Even though trbe_base represents vmap()
+	 * mapped allocated buffer's start address,
+	 * it's being as unsigned long for various
+	 * arithmetic and comparision operations &
+	 * also to be consistent with trbe_write &
+	 * trbe_limit sibling pointers.
+	 */
+	unsigned long trbe_base;
+	/* The base programmed into the TRBE */
+	unsigned long trbe_hw_base;
+	unsigned long trbe_limit;
+	unsigned long trbe_write;
+	unsigned long trbe_count;
+	int nr_pages;
+	void **pages;
+	bool snapshot;
+	struct trbe_cpudata *cpudata;
+};
+
+/*
+ * TRBE erratum list
+ *
+ * The errata are defined in arm64 generic cpu_errata framework.
+ * Since the errata work arounds could be applied individually
+ * to the affected CPUs inside the TRBE driver, we need to know if
+ * a given CPU is affected by the erratum. Unlike the other erratum
+ * work arounds, TRBE driver needs to check multiple times during
+ * a trace session. Thus we need a quicker access to per-CPU
+ * errata and not issue costly this_cpu_has_cap() everytime.
+ * We keep a set of the affected errata in trbe_cpudata, per TRBE.
+ *
+ * We rely on the corresponding cpucaps to be defined for a given
+ * TRBE erratum. We map the given cpucap into a TRBE internal number
+ * to make the tracking of the errata lean.
+ *
+ * This helps in :
+ *   - Not duplicating the detection logic
+ *   - Streamlined detection of erratum across the system
+ */
+#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
+#define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE	1
+#define TRBE_NEEDS_DRAIN_AFTER_DISABLE		2
+#define TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE	3
+#define TRBE_IS_BROKEN				4
+
+static int trbe_errata_cpucaps[] = {
+	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
+	[TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
+	[TRBE_NEEDS_DRAIN_AFTER_DISABLE] = ARM64_WORKAROUND_2064142,
+	[TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE] = ARM64_WORKAROUND_2038923,
+	[TRBE_IS_BROKEN] = ARM64_WORKAROUND_1902691,
+	-1,		/* Sentinel, must be the last entry */
+};
+
+/* The total number of listed errata in trbe_errata_cpucaps */
+#define TRBE_ERRATA_MAX			(ARRAY_SIZE(trbe_errata_cpucaps) - 1)
+
+/*
+ * struct trbe_cpudata: TRBE instance specific data
+ * @trbe_flag		- TRBE dirty/access flag support
+ * @trbe_hw_align	- Actual TRBE alignment required for TRBPTR_EL1.
+ * @trbe_align		- Software alignment used for the TRBPTR_EL1.
+ * @cpu			- CPU this TRBE belongs to.
+ * @mode		- Mode of current operation. (perf/disabled)
+ * @drvdata		- TRBE specific drvdata
+ * @errata		- Bit map for the errata on this TRBE.
+ */
+struct trbe_cpudata {
+	bool trbe_flag;
+	u64 trbe_hw_align;
+	u64 trbe_align;
+	int cpu;
+	enum cs_mode mode;
+	struct trbe_buf *buf;
+	struct trbe_drvdata *drvdata;
+	DECLARE_BITMAP(errata, TRBE_ERRATA_MAX);
+};
+
 static inline bool is_trbe_available(void)
 {
 	u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
@@ -153,3 +236,9 @@ static inline void set_trbe_base_pointer(unsigned long addr)
 	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
 	write_sysreg_s(addr, SYS_TRBBASER_EL1);
 }
+
+#if IS_ENABLED(CONFIG_KUNIT)
+DECLARE_STATIC_KEY_FALSE(trbe_trigger_mode_bypass);
+unsigned long __trbe_normal_offset(struct perf_output_handle *handle);
+u64 __trbe_normal_trigger_count(struct perf_output_handle *handle);
+#endif

-- 
2.34.1

