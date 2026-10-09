Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F37451981
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561682; cv=none; b=ED7d03I6K1xAx51JfRbKP8q8YZaCoIH2UhPPA8iDiVrAWytcGgy6roZtoEVPWUlik3CH+gmfWrey2flLcvNwaR+c0rJFpQhHonqukgiUKwrP3Pc+ldbpHDTX6iPbUBI2d9ZHKX+M7bxQMxD0YwYu1+0rT4fpm9uVKF9VukvmKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561682; c=relaxed/simple;
	bh=//eirskig4g/hGcbjxz8IDMuoo7R7OhB3nsR0rOYwoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EomiqeXv+Csh4yXLi3UinyTQS72FJec6Qf4iW8wYgZy6hLO9sjT+2jj4AfeHvG1Jj6yrx0lnH2tvjOvJN9OiJCLyXbsKLMGRH1r6ha4klwroMI6mTIRo3kStqUwtKspJVVmv2E+bOD7VBpWEa7Kx5mwT7/dBNYeXZdd38MuiKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNABeUvs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNABeUvs"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e5378b281aso26218545ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Oct 2026 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791561678; x=1792166478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RQOBKNdFAUn44/fRc+ZMZn+3dRaAxQbsIS+NjNb1/XM=;
        b=gNABeUvsyWj7zfkkH05mJ9HTIzQz6b9O/l2aXt3Z9ZQW98HG0fs1QjPnvmmiJd7vK/
         gpABIxOakCj87MvRkQeTRfrJ97M/1h5aXlLVXA4kvEXCqOdH5yr5TFr8d3pbqXMg7Vap
         dKskyo11BtpEC+hMYyN3ZXyYDL8jTVpG6TlohKO7nl65RlSW5AAciDhev+u2hafXfdke
         rTXSQk9GzFORu9mE0Q6Xp2H08jt3uLgKOl+mFGJDKWP/CcGWWs5wFjm87ABaIIqqwI8F
         2tsev/JPtG/+GmoaiqaiQLVWZC27QcB/wWXv/pjphWnQkuii3lmSnc7vqjfURMZFRuMo
         gzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791561678; x=1792166478;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQOBKNdFAUn44/fRc+ZMZn+3dRaAxQbsIS+NjNb1/XM=;
        b=L5lAzbCZrNLgUTY8LDjIopZdkcZncQmOTsd8o8+p+CltO58YBLoriA/v0LkuDcXOWu
         XZb1xslLTqrhUDBqHtq6mEQIqVKtfNlRBC3DYbEh7/zKcqiMYX5ztizQHJh6NupXCU1w
         9VKmt61FhqkxIIx49Cpo1FxYEmal95nWXW+iKG6sBbqZlaq7NDNGp6JXhI+EldLUtz0H
         CDtBxdrxtLLPpbGQKygFwGTQsOxexXjFNjQWMDfRIaHVjF3JJrFDu4Y7NPDkRZOZ7bPF
         DOThjeNgcYEtCCvSq/3HabHWgOuEiOP3OFwvv0y8ObsUk8TNQDd0J/sGEUmL9Bn2YLyk
         gysg==
X-Forwarded-Encrypted: i=1; AKwUvBwa05sAKK8Siriy0ddPaoWOhzmbazPdmICPCWUcP5YCgiFJ/mej+V6fI5szSfexIRK7bzznlpNvdhMn/76eixIG@vger.kernel.org
X-Gm-Message-State: AFq9FYKmnjT32UJFpYpVg97km85FAidSFOjucWdRUwFmtei2UpOuLT0m
	Jfrt58X+wJs7RQjPLya0Aod7PUNvNp4oa15a6XKRAbm79kh+SAwpZHfk
X-Gm-Gg: AYBFou3Ai46aBD+1z0C2KmVwTkAK/Pmbr5XUJrxdm/2G5Pw82HHPCYAIO1FG3gt7nc5
	D7Af7S+W3FJRBxmTSRvZMbWQsmrVZ32BTpj1nq0YPmmlELicw4BMWnbZmHp7DE5n0LOR7W8KBwz
	yq4RQuhowG0yEKVedKn0Ymg1S+bGvnRPobfG+5+zg48R+8eJPpYiHblpSdC84C/BvmlsxM4IpIP
	1utDUsrkctahJyPjKrx56jtieZpM4Rw/oadvC2gxofvOkvC/FPMDzo1vGr50Ky6hwykUKXTjUCe
	jA0UmMAsp/PFfp/0r41WXQva1kRUvkc2T6d8uLeal7fOBlSMjyLsPk7ZvSYnoIKPfRz5/nvijx5
	IsW2T0q7/DaUKt74NBL4CnhclgDIgNDTXFNUOAgknuO63Wel/cZxWSynl+Aq1CSWus6rqzBmEVI
	07xrQlsySEYGTP0akdUnx6rKWXvL57GjR9NqHXthQSEQZTcdt879FRjzke32sYpJJykb2c77xiZ
	66xX2jQfMQJ/LiDVR7NF6yTHP9GsQ==
X-Received: by 2002:a17:902:c950:b0:2dd:c100:4b78 with SMTP id d9443c01a7336-2e842d02621mr19377505ad.47.1791561678008;
        Fri, 09 Oct 2026 09:01:18 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cb6sm12333235ad.60.2026.10.09.09.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:01:17 -0700 (PDT)
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
Subject: [PATCH v2 3/5] perf/core: add KUnit tests for AUX kernel-consumer API
Date: Fri,  9 Oct 2026 23:59:50 +0800
Message-ID: <20261009160010.1829642-4-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009160010.1829642-1-kunwu.chan@gmail.com>
References: <20261009160010.1829642-1-kunwu.chan@gmail.com>
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
 kernel/events/aux_kernel_test.c | 1172 +++++++++++++++++++++++++++++++
 lib/Kconfig.debug               |   14 +
 3 files changed, 1187 insertions(+)
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
index 000000000000..02564e16626f
--- /dev/null
+++ b/kernel/events/aux_kernel_test.c
@@ -0,0 +1,1172 @@
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
+	if (kunit_add_action_or_reset(test, aux_test_event_release, event))
+		return ERR_PTR(-ENOMEM);
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
+ *
+ * If any assertion fails while ev_b is in its artificial
+ * (aux_mmap_count=1, aux_kernel_count=0) state, the deferred cleanup
+ * would skip the AUX teardown.  Register a restore action so that
+ * the deferred release (LIFO: restore runs first) always sees valid
+ * kernel ownership.
+ */
+static void aux_test_restore_kernel_aux(void *p)
+{
+	struct perf_event *event = p;
+
+	if (event->rb) {
+		refcount_set(&event->rb->aux_kernel_count, 1);
+		refcount_set(&event->rb->aux_mmap_count, 0);
+	}
+}
+
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
+	 *
+	 * Register a restore action so that an assertion failure
+	 * between here and the manual restoration below does not leave
+	 * ev_b in a state the deferred release cannot tear down.
+	 */
+	refcount_set(&ev_b->rb->aux_mmap_count, 1);
+	refcount_set(&ev_b->rb->aux_kernel_count, 0);
+	if (kunit_add_action_or_reset(test, aux_test_restore_kernel_aux, ev_b))
+		return;
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
+	/* Cleanup B: the restore action handles the normal path too
+	 * (setting kernel ownership is idempotent), but we still call
+	 * release_aux explicitly so the test exercises the API.
+	 */
+	aux_test_restore_kernel_aux(ev_b);
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

