Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC2E472769
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135347; cv=none; b=WfNHj7ILJUvFSp2Wvg/hxnFJmucHqnnzVgXQKX60yPzh9QJfMZegxuR4PDOsxy8WZ3FIa1dx8TBD/upL7CSJ7ih3gqwUqCGjuk/jxkh2pm+so8FtBfl7B49Uz4+1ORm0Pa6ZMJch1A7TMQow/94JvzQ34uV1ZOzbnevNaodruAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135347; c=relaxed/simple;
	bh=WY4g1FX3KOsINxFxcihjvG7zDBBV5irFwGY1f9Xn/+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m99IQqOPeX1X5g9Frg5BClKH0Fb9pAAfhaMc4rwUL8BNaSvSCozWzdqRBNohqvz0PxWKCRDIIjImuUfck5ze6kSiwLibJI1AwKdKbcYGJ1Ol5Q7FHf9h24PSipX/1zJhQH7FicKZ+xyjcEC85CV0ZU5BVZt2eSyobhTanUwDGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRychkp7; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRychkp7"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-887d4b0e846so125878b3a.0
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Oct 2026 10:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791135333; x=1791740133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PgvN+U5L+vxxwU6majnVcc9UnL4NJDISt5o0/gGCBuQ=;
        b=RRychkp7uVQ45DmDqMyQb1zEV0mU5G2CIclYasjs/TqnJFWXA7jgLBImwxf0wFGMyY
         MmtZOz0ggb1o+vKNl/cvFb7GYgCkP9cfl699UUwM6VwnS67zoz/w/htf6E3cqgCzyRz3
         rEqgQVF6f+iE69zcCBGZI03tDWJADThq0c+Uh1c4opCFbPX5/WLriM9qGtQHmAJZNFHV
         3ZCqEKF+uJoJTNsTFVLGGh/R+VSm6k/lQUI6S3n5zC0Maf2uxBE0d1NIFPNwiZa+7YLj
         VPk4veRbPC8qPsTEsbFOqxZOZIxaE9D733LeQtYyM1ZJFqpBZdyp37Z58QPLLbbrpabs
         Qgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791135333; x=1791740133;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PgvN+U5L+vxxwU6majnVcc9UnL4NJDISt5o0/gGCBuQ=;
        b=B+jEf9ejLEhzcqNRo0BfJunHu9P0DzosZ6WoqVWNk9Aad1h4BO0Vqh3hTLpR24vtae
         B4ix8/xvzbIgl+7plGzINn0GF7pVyhTVYMH3/un+9ZslpRB6+z1Iha61o5MspVa7pDgN
         VTvjwRHXhaDXsB3MeXxQNADDsqdV3R7jgmUJGR9i4g2SAkTFsT3YlEPV7xyVzdtSlzbn
         Pi5S+4XWSeypp2GYYL7uLk7mPI7cUv8Z2fjKwqWzOX87NbdvoGZnXpga6hlcQJtSG3dv
         Nx/I/Gh3rZ2xQp5wLEYww775TxDSQ/HAafrCbiHojDZZ+N4GAsMMNlazFw4h/6BrFSA2
         1BMg==
X-Forwarded-Encrypted: i=1; AKwUvBx8jhu9JWO8ucbZPexsHJX06sSazFd93VEI53dDaXvRfWdsViBzMNsdP1belSRbQLQygoJkVRVSPA8uFeYtExlC@vger.kernel.org
X-Gm-Message-State: AFuF++kGQMSDJ1STRyBbhncj00kp22nkanaRJ3Oq0KVcGqS4FUXgM9ru
	SzDxrE0nouaY6FvFPBYUkoZEplovPZODAngFwSMCLrAYcpceAP0SCu3z
X-Gm-Gg: AYBFou3H2DYFpylsTQ+CYFMYCBRlb20foXCZiELqPK4ScVhHAu+hZKyaBo0G2CsZfE7
	KbdkXveyQehvCu4HPH9onvIRHXhTWQnVvZqvp8/z6l95VPVTK8ncKAyCLs2ZTQpmgc91nxkuXXU
	+JkrvzD3DIFka5SsHGJaAb6jLiEIqwLhla0vRW24juOStVyhgN0ucDE6nr8xrqQYIWOjxlR2CHr
	BVpq4uY41lPXXdUvn6elbMtt+3UvhG2zpHQaXyLrqQKWx2fwsz//FHclJeOCRrzECwR04I5Deka
	IyCV3hFZt493t9QdzpIi6KAoXMktcQ1j0nNcaym1RQljNDmRAMQkiSeuVyKEMZfEWDFXSQAPngE
	KG7EOVDINfh5NUCnsC2n9wYm0gswmW9bL6MT7VTqofdPX+Heczkyu1NGvO4cBaJH62fDhfmDgrQ
	uafQGpeV0ewWxN/I2FoxO3fKjd5OZTosLzDJlkKn3jHDKq8VNOvi+kBQ5gdrkDVx34MbUUr37TK
	5JBJYQgqk/RIYsFvSdKd7nHA5lM1w==
X-Received: by 2002:a05:6a20:9193:b0:3dd:85a8:4c50 with SMTP id adf61e73a8af0-3e0bd199513mr6705620637.20.1791135333090;
        Sun, 04 Oct 2026 10:35:33 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247930sm2678370b3a.54.2026.10.04.10.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:35:31 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: sj@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	akpm@linux-foundation.org,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/5] perf/core: add KUnit tests for AUX kernel-consumer API
Date: Mon,  5 Oct 2026 01:34:55 +0800
Message-ID: <20261004173458.837842-4-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004173458.837842-1-kunwu.chan@gmail.com>
References: <20261004173458.837842-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lian Wang <lianux.mm@gmail.com>

Add a KUnit test suite (perf_aux_kernel) for the perf_event_setup_aux(),
perf_event_release_aux(), perf_event_aux_head(), perf_event_aux_tail_set()
and perf_event_aux_copy() functions.

A self-contained dummy AUX PMU is registered in suite_init so that
every test is deterministic and needs no hardware.  The dummy
setup_aux pre-fills all pages with a recognisable pattern (0xAB);
aux_test_produce() advances the published head via
perf_aux_output_begin/end, and copy tests verify the pattern.

39 test cases cover setup/release lifecycle, writer admission and
blocking, head/tail/copy accessor contract validation (including
wrap-around, boundary cursors, and data correctness), buffer-full
behaviour, negative watermark rejection, independence of two
events on the same PMU, user/kernel coexistence simulation, and
concurrent release on the same event.

Every test event is released through a kunit_add_action() cleanup, so
a test aborted by a KUNIT_ASSERT_*() (which skips the remaining
manual cleanup) still releases its events.  The concurrent-release
test waits on a struct completion instead of a lockless
wait_event() condition, and does not kthread_stop() workers that exit
on their own.  The buffer-full test asserts that perf_aux_output_begin()
refuses a full non-overwrite buffer.

Gated by CONFIG_PERF_AUX_KERNEL_KUNIT_TEST.

Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 kernel/events/Makefile          |    1 +
 kernel/events/aux_kernel_test.c | 1152 +++++++++++++++++++++++++++++++
 lib/Kconfig.debug               |   14 +
 3 files changed, 1167 insertions(+)
 create mode 100644 kernel/events/aux_kernel_test.c

diff --git a/kernel/events/Makefile b/kernel/events/Makefile
index 91a62f566743..592604db2c76 100644
--- a/kernel/events/Makefile
+++ b/kernel/events/Makefile
@@ -3,4 +3,5 @@ obj-y := core.o ring_buffer.o callchain.o
 
 obj-$(CONFIG_HAVE_HW_BREAKPOINT) += hw_breakpoint.o
 obj-$(CONFIG_HW_BREAKPOINT_KUNIT_TEST) += hw_breakpoint_test.o
+obj-$(CONFIG_PERF_AUX_KERNEL_KUNIT_TEST) += aux_kernel_test.o
 obj-$(CONFIG_UPROBES) += uprobes.o
diff --git a/kernel/events/aux_kernel_test.c b/kernel/events/aux_kernel_test.c
new file mode 100644
index 000000000000..fa481b8015db
--- /dev/null
+++ b/kernel/events/aux_kernel_test.c
@@ -0,0 +1,1152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the perf AUX kernel-consumer API.
+ *
+ * Tests the exported functions:
+ *   - perf_event_setup_aux() / perf_event_release_aux()
+ *   - perf_event_aux_head() / perf_event_aux_tail_set() / perf_event_aux_copy()
+ *
+ * A self-contained dummy AUX PMU is registered in suite_init so that
+ * every test is deterministic and requires no hardware.  The dummy
+ * setup_aux pre-fills all pages with a recognisable pattern (0xAB);
+ * aux_test_produce() advances the published head via
+ * perf_aux_output_begin/end, and copy tests verify the pattern.
+ *
+ * Every event created by aux_test_create_event() is released through a
+ * kunit_add_action() cleanup, so a test aborted by a KUNIT_ASSERT_*()
+ * (which skips the remaining manual cleanup) still releases its events.
+ *
+ * Run via debugfs:
+ *   echo run > /sys/kernel/debug/kunit/perf_aux_kernel/run
+ *   cat /sys/kernel/debug/kunit/perf_aux_kernel/results
+ */
+
+#include <kunit/test.h>
+#include <linux/completion.h>
+#include <linux/kthread.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+#include "internal.h"
+
+/* ---- Dummy AUX PMU ---- */
+
+static struct pmu dummy_aux_pmu;
+static int dummy_aux_pmu_type = -1;
+
+static int dummy_aux_event_init(struct perf_event *event)
+{
+	return 0;
+}
+
+static void dummy_aux_event_read(struct perf_event *event) { }
+
+static int dummy_aux_event_add(struct perf_event *event, int mode)
+{
+	return 0;
+}
+
+static void dummy_aux_event_del(struct perf_event *event, int mode) { }
+
+static void dummy_aux_event_start(struct perf_event *event, int mode) { }
+
+static void dummy_aux_event_stop(struct perf_event *event, int mode) { }
+
+static void *dummy_aux_setup_aux(struct perf_event *event, void **pages,
+				 int nr_pages, bool overwrite)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++)
+		memset(pages[i], 0xAB, PAGE_SIZE);
+
+	return pages;
+}
+
+static void dummy_aux_free_aux(void *priv)
+{
+	/* aux_priv is the pages array; __rb_free_aux frees it via kfree. */
+}
+
+static int dummy_aux_pmu_register(void)
+{
+	int ret;
+
+	if (dummy_aux_pmu_type >= 0)
+		return 0;
+
+	memset(&dummy_aux_pmu, 0, sizeof(dummy_aux_pmu));
+	dummy_aux_pmu.event_init = dummy_aux_event_init;
+	dummy_aux_pmu.add = dummy_aux_event_add;
+	dummy_aux_pmu.del = dummy_aux_event_del;
+	dummy_aux_pmu.start = dummy_aux_event_start;
+	dummy_aux_pmu.stop = dummy_aux_event_stop;
+	dummy_aux_pmu.read = dummy_aux_event_read;
+	dummy_aux_pmu.setup_aux = dummy_aux_setup_aux;
+	dummy_aux_pmu.free_aux = dummy_aux_free_aux;
+	dummy_aux_pmu.capabilities = PERF_PMU_CAP_ITRACE;
+	dummy_aux_pmu.task_ctx_nr = perf_sw_context;
+
+	ret = perf_pmu_register(&dummy_aux_pmu, "dummy_aux", -1);
+	if (ret)
+		return ret;
+
+	dummy_aux_pmu_type = dummy_aux_pmu.type;
+	return 0;
+}
+
+static void dummy_aux_pmu_unregister(void)
+{
+	if (dummy_aux_pmu_type >= 0)
+		perf_pmu_unregister(&dummy_aux_pmu);
+	dummy_aux_pmu_type = -1;
+}
+
+static int suite_init(struct kunit_suite *suite)
+{
+	return dummy_aux_pmu_register();
+}
+
+static void suite_exit(struct kunit_suite *suite)
+{
+	dummy_aux_pmu_unregister();
+}
+
+/* ---- Helpers ---- */
+
+/*
+ * Deferred cleanup for the kernel events created by the tests.
+ *
+ * Registering this via kunit_add_action() makes every test abort-safe:
+ * KUNIT_ASSERT_* macros (and kunit_skip()) terminate the test by
+ * throwing, which skips the remaining manual cleanup, but KUnit still
+ * runs registered actions on the aborted test's exit.  A test that
+ * already called perf_event_release_aux() itself is not affected: a
+ * second release is a no-op, and the LIFO ordering of actions handles
+ * tests that create more than one event.
+ */
+static void aux_test_event_release(void *p)
+{
+	struct perf_event *event = p;
+
+	perf_event_release_aux(event);
+	perf_event_release_kernel(event);
+}
+
+static struct perf_event *aux_test_create_event(struct kunit *test)
+{
+	struct perf_event_attr attr = {};
+	struct perf_event *event;
+
+	attr.type = dummy_aux_pmu_type;
+	attr.size = sizeof(attr);
+	attr.disabled = 1;
+
+	event = perf_event_create_kernel_counter(&attr, raw_smp_processor_id(),
+						 NULL, NULL, NULL);
+	if (IS_ERR(event))
+		return event;
+
+	if (kunit_add_action_or_reset(test, aux_test_event_release, event)) {
+		perf_event_release_kernel(event);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return event;
+}
+
+/*
+ * Advance the AUX head by @bytes via perf_aux_output_begin/end.
+ * The pages are pre-filled with 0xAB in dummy_aux_setup_aux, so
+ * the data is already present; this function only publishes it.
+ */
+static unsigned long aux_test_produce(struct perf_event *event, unsigned long bytes)
+{
+	struct perf_output_handle handle;
+	unsigned long head, written = 0;
+
+	while (written < bytes) {
+		unsigned long chunk = min_t(unsigned long, bytes - written, 1024);
+
+		if (!perf_aux_output_begin(&handle, event))
+			break;
+		chunk = min_t(unsigned long, chunk, handle.size);
+		perf_aux_output_end(&handle, chunk);
+		written += chunk;
+	}
+
+	head = perf_event_aux_head(event);
+	return head;
+}
+
+/* ---- Patch-1: Setup / release tests ---- */
+
+static void test_setup_rejects_non_power_of_two(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 3, 0);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+
+	ret = perf_event_setup_aux(event, 0, 0);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+
+	ret = perf_event_setup_aux(event, 6, 0);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+}
+
+static void test_setup_accepts_power_of_two(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	int i, ret;
+	int pages[] = { 1, 2, 4, 8, 16, 32, 64 };
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	for (i = 0; i < ARRAY_SIZE(pages); i++) {
+		ret = perf_event_setup_aux(event, pages[i], 0);
+		KUNIT_EXPECT_EQ_MSG(test, 0, ret,
+				    "setup_aux(%d pages) expected 0, got %d",
+				    pages[i], ret);
+		if (ret == 0)
+			perf_event_release_aux(event);
+	}
+}
+
+static void test_setup_rejects_double(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, -EBUSY, ret);
+
+	perf_event_release_aux(event);
+}
+
+static void test_setup_parent_event_rejected(struct kunit *test)
+{
+	struct perf_event *parent = aux_test_create_event(test);
+	struct perf_event *child = aux_test_create_event(test);
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, child);
+
+	child->parent = parent;
+
+	ret = perf_event_setup_aux(child, 1, 0);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+
+	/* Restore before the deferred cleanup releases the events. */
+	child->parent = NULL;
+}
+
+static void test_writer_admitted_after_setup(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	unsigned long head;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head = aux_test_produce(event, 512);
+	KUNIT_EXPECT_GT(test, head, 0);
+
+	perf_event_release_aux(event);
+}
+
+static void test_writer_blocked_after_release(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	struct perf_output_handle handle;
+	void *addr;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	perf_event_release_aux(event);
+
+	addr = perf_aux_output_begin(&handle, event);
+	KUNIT_EXPECT_NULL(test, addr);
+}
+
+static void test_release_noop_without_rb(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	perf_event_release_aux(event);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+static void test_setup_release_roundtrip(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	perf_event_release_aux(event);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+static void test_multi_setup_release_cycle(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	int i, ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	for (i = 0; i < 3; i++) {
+		ret = perf_event_setup_aux(event, 1, 0);
+		KUNIT_ASSERT_EQ_MSG(test, 0, ret,
+				    "cycle %d: setup_aux failed", i);
+		perf_event_release_aux(event);
+	}
+}
+
+static void test_double_release_clean(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	perf_event_release_aux(event);
+	perf_event_release_aux(event);
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/* ---- Patch-2: Accessor tests ---- */
+
+static void test_head_initial_zero(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	unsigned long head;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head = perf_event_aux_head(event);
+	KUNIT_EXPECT_EQ(test, 0, head);
+
+	perf_event_release_aux(event);
+}
+
+static void test_head_advances_after_produce(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	unsigned long head;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head = aux_test_produce(event, 512);
+	KUNIT_EXPECT_GT(test, head, 0);
+
+	perf_event_release_aux(event);
+}
+
+static void test_copy_full_window(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	const unsigned long buf_size = PAGE_SIZE;
+	void *buf;
+	unsigned long head;
+	long copied;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head = aux_test_produce(event, buf_size / 2);
+	KUNIT_EXPECT_GT(test, head, 0);
+
+	buf = kunit_kmalloc(test, head, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	copied = perf_event_aux_copy(event, 0, head, buf);
+	KUNIT_EXPECT_EQ_MSG(test, (long)head, copied,
+			    "copy(0, %lu) returned %ld, expected %lu",
+			    head, copied, head);
+
+	perf_event_release_aux(event);
+}
+
+static void test_copy_wrap(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	const unsigned long buf_size = 2 * PAGE_SIZE;
+	void *buf;
+	unsigned long head, tail;
+	long copied;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 2, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	/* Fill the buffer to near-full */
+	head = aux_test_produce(event, buf_size);
+	KUNIT_EXPECT_GT(test, head, 0);
+
+	/* Consume half to free space */
+	tail = head / 2;
+	ret = perf_event_aux_tail_set(event, tail);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	/* Produce more — head now wraps past buf_size */
+	head = aux_test_produce(event, buf_size);
+	KUNIT_EXPECT_GT(test, head, buf_size);
+
+	/* Copy a window that spans the ring wrap point */
+	buf = kunit_kmalloc(test, buf_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	copied = perf_event_aux_copy(event, tail, head, buf);
+	KUNIT_EXPECT_GT(test, copied, 0);
+	KUNIT_EXPECT_LE(test, copied, (long)buf_size);
+
+	perf_event_release_aux(event);
+}
+
+static void test_copy_zero_len(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	void *buf;
+	long copied;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	buf = kunit_kmalloc(test, 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	copied = perf_event_aux_copy(event, 0, 0, buf);
+	KUNIT_EXPECT_EQ(test, 0, copied);
+
+	perf_event_release_aux(event);
+}
+
+static void test_copy_rejects_rewound(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	const unsigned long buf_size = PAGE_SIZE;
+	void *buf;
+	long copied;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	aux_test_produce(event, buf_size / 2);
+
+	buf = kunit_kmalloc(test, 64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	/* Reversed cursor range. */
+	copied = perf_event_aux_copy(event, 100, 50, buf);
+	KUNIT_EXPECT_EQ(test, -EINVAL, copied);
+
+	perf_event_release_aux(event);
+}
+
+static void test_copy_rejects_future(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	unsigned long head;
+	void *buf;
+	long copied;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head = aux_test_produce(event, 512);
+	KUNIT_EXPECT_GT(test, head, 0);
+
+	buf = kunit_kmalloc(test, 64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	/* to > head: future cursor */
+	copied = perf_event_aux_copy(event, head, head + 64, buf);
+	KUNIT_EXPECT_EQ(test, -EINVAL, copied);
+
+	perf_event_release_aux(event);
+}
+
+static void test_copy_rejects_oversized(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	const unsigned long buf_size = PAGE_SIZE;
+	void *buf;
+	long copied;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	aux_test_produce(event, 512);
+
+	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	/* Window extends past the published producer cursor. */
+	copied = perf_event_aux_copy(event, 0, 2 * buf_size, buf);
+	KUNIT_EXPECT_EQ(test, -EINVAL, copied);
+
+	perf_event_release_aux(event);
+}
+
+static void test_copy_rejects_null_buf(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	long copied;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	copied = perf_event_aux_copy(event, 0, 0, NULL);
+	KUNIT_EXPECT_EQ(test, -EINVAL, copied);
+
+	perf_event_release_aux(event);
+}
+
+static void test_copy_no_rb_enoent(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	void *buf;
+	long ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	buf = kunit_kmalloc(test, 64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	ret = perf_event_aux_copy(event, 0, 64, buf);
+	KUNIT_EXPECT_EQ(test, -ENOENT, ret);
+}
+
+static void test_tail_set_valid_frees_space(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	unsigned long head;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head = aux_test_produce(event, 512);
+	KUNIT_EXPECT_GT(test, head, 0);
+
+	ret = perf_event_aux_tail_set(event, head / 2);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	perf_event_release_aux(event);
+}
+
+static void test_tail_set_rejects_future(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	/* tail=1 when head=0: future */
+	ret = perf_event_aux_tail_set(event, 1);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+
+	perf_event_release_aux(event);
+}
+
+static void test_tail_set_accepts_within_ring_window(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	const unsigned long buf_size = PAGE_SIZE;
+	unsigned long head, tail;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	/* Produce enough data so head - tail <= aux_size for a large tail */
+	head = aux_test_produce(event, buf_size / 2);
+	KUNIT_EXPECT_GT(test, head, 0);
+
+	/*
+	 * Set tail within the current [old_tail, head] window.
+	 */
+	tail = head / 4;
+	ret = perf_event_aux_tail_set(event, tail);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	perf_event_release_aux(event);
+}
+
+static void test_tail_set_rejects_behind_ring(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	const unsigned long buf_size = PAGE_SIZE;
+	unsigned long head;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head = aux_test_produce(event, buf_size / 2);
+	KUNIT_EXPECT_GT(test, head, 0);
+
+	/*
+	 * Cursor outside the current producer window.  The requested
+	 * tail is not between head - aux_size and head, so the
+	 * modular-distance check must reject it.
+	 */
+	ret = perf_event_aux_tail_set(event, head + buf_size + 1);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+
+	perf_event_release_aux(event);
+}
+
+static void test_tail_set_no_rb_enoent(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_aux_tail_set(event, 0);
+	KUNIT_EXPECT_EQ(test, -ENOENT, ret);
+}
+
+static void test_head_no_rb_zero(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	unsigned long head;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	head = perf_event_aux_head(event);
+	KUNIT_EXPECT_EQ(test, 0, head);
+}
+
+/* ---- Additional boundary and correctness tests ---- */
+
+static void test_setup_rejects_negative_watermark(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, -1);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+
+	ret = perf_event_setup_aux(event, 1, -4096);
+	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
+}
+
+static void test_tail_set_noop(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	ret = perf_event_aux_tail_set(event, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	perf_event_release_aux(event);
+}
+
+static void test_tail_set_consume_all(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	unsigned long head;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head = aux_test_produce(event, 512);
+	KUNIT_EXPECT_GT(test, head, 0);
+
+	ret = perf_event_aux_tail_set(event, head);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	perf_event_release_aux(event);
+}
+
+static void test_copy_data_correctness(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	void *buf;
+	unsigned long head;
+	long copied;
+	int ret, i;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head = aux_test_produce(event, 512);
+	KUNIT_EXPECT_GT(test, head, 0);
+
+	buf = kunit_kmalloc(test, head, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	copied = perf_event_aux_copy(event, 0, head, buf);
+	KUNIT_EXPECT_EQ(test, (long)head, copied);
+
+	for (i = 0; i < copied; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, 0xAB, ((u8 *)buf)[i],
+				    "data mismatch at offset %d", i);
+		if (((u8 *)buf)[i] != 0xAB)
+			break;
+	}
+
+	perf_event_release_aux(event);
+}
+
+static void test_multi_produce_copy_cycle(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	void *buf;
+	unsigned long head, tail = 0;
+	long copied;
+	int ret, cycle;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	for (cycle = 0; cycle < 3; cycle++) {
+		head = aux_test_produce(event, 256);
+		KUNIT_EXPECT_GT(test, head, tail);
+
+		copied = perf_event_aux_copy(event, tail, head, buf);
+		KUNIT_EXPECT_EQ(test, (long)(head - tail), copied);
+
+		ret = perf_event_aux_tail_set(event, head);
+		KUNIT_EXPECT_EQ(test, 0, ret);
+		tail = head;
+	}
+
+	perf_event_release_aux(event);
+}
+
+static void test_copy_rejects_already_consumed(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	void *buf;
+	unsigned long head, tail;
+	long copied;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head = aux_test_produce(event, 512);
+	KUNIT_EXPECT_GT(test, head, 0);
+
+	tail = head / 2;
+	ret = perf_event_aux_tail_set(event, tail);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	buf = kunit_kmalloc(test, 64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	copied = perf_event_aux_copy(event, tail - 1, tail, buf);
+	KUNIT_EXPECT_EQ(test, -EINVAL, copied);
+
+	perf_event_release_aux(event);
+}
+
+static void test_output_end_zero_size(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	struct perf_output_handle handle;
+	void *addr;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	addr = perf_aux_output_begin(&handle, event);
+	KUNIT_ASSERT_NOT_NULL(test, addr);
+
+	perf_aux_output_end(&handle, 0);
+	KUNIT_EXPECT_EQ(test, 0, perf_event_aux_head(event));
+
+	perf_event_release_aux(event);
+}
+
+static void test_buffer_full_stops_producer(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	struct perf_output_handle handle;
+	const unsigned long buf_size = PAGE_SIZE;
+	unsigned long head;
+	void *addr;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head = aux_test_produce(event, buf_size);
+	KUNIT_EXPECT_GT(test, head, 0);
+
+	addr = perf_aux_output_begin(&handle, event);
+	/*
+	 * The buffer is full and no consumer has freed space, so a new
+	 * non-overwrite transaction must be refused outright, not handed a
+	 * zero-size window.
+	 */
+	KUNIT_EXPECT_NULL_MSG(test, addr,
+			      "begin() must refuse a full non-overwrite buffer");
+	if (addr) {
+		/* Unexpected: keep the AUX refcount balanced. */
+		KUNIT_EXPECT_EQ(test, 0, handle.size);
+		perf_aux_output_end(&handle, 0);
+	}
+
+	perf_event_release_aux(event);
+}
+
+static void test_setup_with_explicit_watermark(struct kunit *test)
+{
+	struct perf_event *event = aux_test_create_event(test);
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	ret = perf_event_setup_aux(event, 2, 4096);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	perf_event_release_aux(event);
+
+	ret = perf_event_setup_aux(event, 4, 8192);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	perf_event_release_aux(event);
+}
+
+static void test_two_events_independent(struct kunit *test)
+{
+	struct perf_event *ev_a = aux_test_create_event(test);
+	struct perf_event *ev_b = aux_test_create_event(test);
+	unsigned long head_a, head_b;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ev_a);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ev_b);
+
+	ret = perf_event_setup_aux(ev_a, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	ret = perf_event_setup_aux(ev_b, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head_a = aux_test_produce(ev_a, 512);
+	head_b = perf_event_aux_head(ev_b);
+
+	KUNIT_EXPECT_GT(test, head_a, 0);
+	KUNIT_EXPECT_EQ(test, 0, head_b);
+
+	head_b = aux_test_produce(ev_b, 256);
+	KUNIT_EXPECT_GT(test, head_b, 0);
+	KUNIT_EXPECT_EQ(test, head_a, perf_event_aux_head(ev_a));
+
+	perf_event_release_aux(ev_a);
+	perf_event_release_aux(ev_b);
+}
+
+static void test_release_one_does_not_affect_other(struct kunit *test)
+{
+	struct perf_event *ev_a = aux_test_create_event(test);
+	struct perf_event *ev_b = aux_test_create_event(test);
+	unsigned long head_b;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ev_a);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ev_b);
+
+	ret = perf_event_setup_aux(ev_a, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	ret = perf_event_setup_aux(ev_b, 1, 0);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	head_b = aux_test_produce(ev_b, 512);
+	KUNIT_EXPECT_GT(test, head_b, 0);
+
+	perf_event_release_aux(ev_a);
+
+	KUNIT_EXPECT_EQ(test, head_b, perf_event_aux_head(ev_b));
+	KUNIT_EXPECT_GT(test, aux_test_produce(ev_b, 256), head_b);
+
+	perf_event_release_aux(ev_b);
+}
+
+/*
+ * Test: kernel consumer and simulated userspace consumer coexist on
+ * the same PMU without interfering.
+ *
+ * Event A uses aux_kernel_count (via perf_event_setup_aux).
+ * Event B swaps its refcounts to aux_mmap_count=1 to simulate a
+ * userspace mmap'd consumer.  Both rings on the same dummy PMU.
+ *
+ *   - produce on A → B's head is unaffected
+ *   - produce on B → A's head is unaffected
+ *   - release A (kernel) → B still produces
+ */
+static void test_user_kernel_coexistence(struct kunit *test)
+{
+	struct perf_event *ev_a = aux_test_create_event(test);
+	struct perf_event *ev_b = aux_test_create_event(test);
+	struct perf_output_handle handle_a, handle_b;
+	unsigned long a_head_before, b_head_before;
+	void *addr;
+	int ret;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ev_a);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ev_b);
+
+	/* Event A: kernel consumer */
+	ret = perf_event_setup_aux(ev_a, 1, 0);
+	KUNIT_ASSERT_EQ(test, 0, ret);
+
+	/* Event B: start with kernel setup, then simulate userspace.
+	 * ASSERT: the refcount_set() below dereferences ev_b->rb.
+	 */
+	ret = perf_event_setup_aux(ev_b, 1, 0);
+	KUNIT_ASSERT_EQ(test, 0, ret);
+
+	/* Simulate userspace ownership: swap refcounts on B's rb.
+	 * perf_mmap() would set aux_mmap_count=1 for a userspace event.
+	 */
+	refcount_set(&ev_b->rb->aux_mmap_count, 1);
+	refcount_set(&ev_b->rb->aux_kernel_count, 0);
+
+	/* Produce on A — B's head stays 0 */
+	addr = perf_aux_output_begin(&handle_a, ev_a);
+	KUNIT_ASSERT_NOT_NULL(test, addr);
+	perf_aux_output_end(&handle_a, 512);
+	KUNIT_EXPECT_GT(test, ev_a->rb->aux_head, 0);
+	KUNIT_EXPECT_EQ(test, 0, ev_b->rb->aux_head);
+
+	/* Produce on B — A's head unchanged */
+	a_head_before = ev_a->rb->aux_head;
+	addr = perf_aux_output_begin(&handle_b, ev_b);
+	KUNIT_ASSERT_NOT_NULL(test, addr);
+	perf_aux_output_end(&handle_b, 256);
+	KUNIT_EXPECT_GT(test, ev_b->rb->aux_head, 0);
+	KUNIT_EXPECT_EQ(test, a_head_before, ev_a->rb->aux_head);
+
+	/* Release A (kernel) — B still produces */
+	b_head_before = ev_b->rb->aux_head;
+	perf_event_release_aux(ev_a);
+	addr = perf_aux_output_begin(&handle_b, ev_b);
+	KUNIT_ASSERT_NOT_NULL(test, addr);
+	perf_aux_output_end(&handle_b, 128);
+	KUNIT_EXPECT_GT(test, ev_b->rb->aux_head, b_head_before);
+
+	/* Cleanup B: restore kernel ownership so the deferred release
+	 * path (and the explicit one below) tears the buffer down.
+	 */
+	refcount_set(&ev_b->rb->aux_kernel_count, 1);
+	refcount_set(&ev_b->rb->aux_mmap_count, 0);
+	perf_event_release_aux(ev_b);
+}
+
+/*
+ * Test: two kthreads concurrently call perf_event_release_aux() on the
+ * same event.  perf_event_release_aux() serialises the whole teardown on
+ * event->mmap_mutex, so exactly one caller drops aux_kernel_count and
+ * performs the teardown while the other observes event->rb == NULL and
+ * returns as a no-op.  The test verifies the race is handled without a
+ * refcount underflow warning, crash, or leak.
+ */
+struct concurrent_release_ctx {
+	struct perf_event *event;
+	struct completion done;
+};
+
+static int concurrent_release_thread(void *data)
+{
+	struct concurrent_release_ctx *ctx = data;
+
+	perf_event_release_aux(ctx->event);
+	complete(&ctx->done);
+
+	return 0;
+}
+
+static void test_concurrent_release(struct kunit *test)
+{
+	struct concurrent_release_ctx ctx;
+	struct task_struct *threads[2];
+	struct perf_event *event;
+	int created = 0, i;
+
+	event = aux_test_create_event(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, event);
+
+	KUNIT_ASSERT_EQ(test, 0, perf_event_setup_aux(event, 1, 0));
+
+	ctx.event = event;
+	init_completion(&ctx.done);
+
+	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+		threads[i] = kthread_run(concurrent_release_thread, &ctx,
+					 "aux_crel_%d", i);
+		if (IS_ERR(threads[i])) {
+			threads[i] = NULL;
+			break;
+		}
+		created++;
+	}
+
+	/*
+	 * Wait for every thread that was actually created before returning:
+	 * ctx lives on this stack, and a struct completion is the right
+	 * wait/notify primitive for an on-stack waiter (unlike a lockless
+	 * wait_event() condition, which the worker could satisfy via
+	 * atomic_dec_and_test() before it gets to wake_up()).
+	 *
+	 * No kthread_stop() here: the workers do not check
+	 * kthread_should_stop() and exit on their own after complete(), and
+	 * stopping an already-exited kthread would touch freed memory.
+	 */
+	for (i = 0; i < created; i++)
+		wait_for_completion(&ctx.done);
+
+	if (created != ARRAY_SIZE(threads))
+		kunit_warn(test, "only %d/%zu release threads created\n",
+			   created, ARRAY_SIZE(threads));
+
+	/*
+	 * If no worker could run, tear the buffer down here; if one did,
+	 * this is the documented no-op second release.  The deferred
+	 * cleanup action releases the event itself.
+	 */
+	perf_event_release_aux(event);
+}
+
+static struct kunit_case aux_kernel_test_cases[] = {
+	KUNIT_CASE(test_setup_rejects_non_power_of_two),
+	KUNIT_CASE(test_setup_accepts_power_of_two),
+	KUNIT_CASE(test_setup_rejects_double),
+	KUNIT_CASE(test_setup_parent_event_rejected),
+	KUNIT_CASE(test_setup_rejects_negative_watermark),
+	KUNIT_CASE(test_setup_with_explicit_watermark),
+	KUNIT_CASE(test_writer_admitted_after_setup),
+	KUNIT_CASE(test_writer_blocked_after_release),
+	KUNIT_CASE(test_release_noop_without_rb),
+	KUNIT_CASE(test_setup_release_roundtrip),
+	KUNIT_CASE(test_multi_setup_release_cycle),
+	KUNIT_CASE(test_double_release_clean),
+	KUNIT_CASE(test_two_events_independent),
+	KUNIT_CASE(test_release_one_does_not_affect_other),
+	KUNIT_CASE(test_user_kernel_coexistence),
+	KUNIT_CASE(test_concurrent_release),
+	KUNIT_CASE(test_head_initial_zero),
+	KUNIT_CASE(test_head_advances_after_produce),
+	KUNIT_CASE(test_head_no_rb_zero),
+	KUNIT_CASE(test_copy_full_window),
+	KUNIT_CASE(test_copy_wrap),
+	KUNIT_CASE(test_copy_zero_len),
+	KUNIT_CASE(test_copy_data_correctness),
+	KUNIT_CASE(test_copy_rejects_rewound),
+	KUNIT_CASE(test_copy_rejects_future),
+	KUNIT_CASE(test_copy_rejects_oversized),
+	KUNIT_CASE(test_copy_rejects_null_buf),
+	KUNIT_CASE(test_copy_rejects_already_consumed),
+	KUNIT_CASE(test_copy_no_rb_enoent),
+	KUNIT_CASE(test_tail_set_valid_frees_space),
+	KUNIT_CASE(test_tail_set_rejects_future),
+	KUNIT_CASE(test_tail_set_accepts_within_ring_window),
+	KUNIT_CASE(test_tail_set_rejects_behind_ring),
+	KUNIT_CASE(test_tail_set_noop),
+	KUNIT_CASE(test_tail_set_consume_all),
+	KUNIT_CASE(test_tail_set_no_rb_enoent),
+	KUNIT_CASE(test_multi_produce_copy_cycle),
+	KUNIT_CASE(test_output_end_zero_size),
+	KUNIT_CASE(test_buffer_full_stops_producer),
+	{},
+};
+
+static struct kunit_suite aux_kernel_test_suite = {
+	.name = "perf_aux_kernel",
+	.suite_init = suite_init,
+	.suite_exit = suite_exit,
+	.test_cases = aux_kernel_test_cases,
+};
+
+kunit_test_suite(aux_kernel_test_suite);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625..7db7eb07c2f2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3073,6 +3073,20 @@ config HW_BREAKPOINT_KUNIT_TEST
 
 	  If unsure, say N.
 
+config PERF_AUX_KERNEL_KUNIT_TEST
+	bool "Test perf AUX kernel-consumer API" if !KUNIT_ALL_TESTS
+	depends on PERF_EVENTS=y
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Tests for the perf AUX kernel-consumer API functions:
+	  perf_event_setup_aux(), perf_event_release_aux(),
+	  perf_event_aux_head(), perf_event_aux_tail_set(), and
+	  perf_event_aux_copy().  Uses a dummy AUX PMU and does
+	  not require AUX-capable hardware.
+
+	  If unsure, say N.
+
 source "lib/crypto/tests/Kconfig"
 
 config SIPHASH_KUNIT_TEST
-- 
2.43.0

