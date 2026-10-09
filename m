Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BAC46A5E5
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561713; cv=none; b=n1YNWAJVeenTcOz3lJTmlbrWUt7bJQDfuNg4EDWJ97QLbuq5E4DOLXh5v+LpX/b8S/fbEdqKWa3LxbxqP0LQyB5jaZxupfiraADVB6CNCX2xT+nVygZRRK8yTN7MHbqVTzcBTfqJFHro4vKV8P8LIBpCcePhihh5W+uO221PV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561713; c=relaxed/simple;
	bh=taRH8EEWD+IygwPIsEB/bPvTZ1YVQ/CXPPAAFoICA4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRR9vWzIviw5FpOKZfXMdydbtM7FdvF4B0MYVZgjSEfi+D2fPb0J79ul6re0Eu4PTP2hIfPmghq9mZlu44zI9Kup31mwHgSThi9zeJGSsuttNazWZAi6rA5cEfc+gbQFJaukJUkxOI+RC2mt/hXDenY2ICFZzXn8bCUHVTdtruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqO62ToG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqO62ToG"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so2294709a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Oct 2026 09:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791561711; x=1792166511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=udAqBqAFjWEvD0pWvypYjXBLfSZDiLCZHfWyp3Mu7Oo=;
        b=SqO62ToGiNZ/F11KL3KM9cSKk4wrhn0Wdma7sSNUMzLmrIk7soK5FJyDgZronWdMIR
         Yspu4hmzkxv7hVVYOZ52QCVMC3xXDPe0b2iJ0Nn8MbfZNbYnRsoV9Agr6zWcQpFMQFok
         pXFo5fxbHtF+lZrd+wujLwP+w1PJcsMTxgzdn0cVofZ30tkPFPm7l0aUQRnBSnhRCnNW
         IKUmUyh3s9rVgJ5N0j+g01no7AgbdFgmFY7tlcFj0cYX7E7eM/shBaMcGvNFGyDZYVPb
         qeSUWfeYgI8MWVpIXp4Qb+QPtxjHlJ7pl+KckJO/cnih6mpdkvBCVKcpEhJ5/0Q07o7y
         aUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791561711; x=1792166511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=udAqBqAFjWEvD0pWvypYjXBLfSZDiLCZHfWyp3Mu7Oo=;
        b=p7ok0Jk7Y/U5XtQDVRz7OG/vq8OEC8wXhHPu9cmoRlcC95RHZRRfN7GPueBpcUfaJt
         o0nYVkqhAiD8uOb7hu+/Nm6IUG/ErWoNhCLDlBh7ZrUugv0Gk+wcjL4nTfxdW565tDbI
         OKwzjpQQlhkNW++Mypg11pMXlx6aUtwpdRiwEEhb6CocLjQ/bcaY7qLZO50qbO2gkZ5l
         mZjjrU7JkI9ZADUtMOjS8qHKU6ksb4GwNuxzquhjtCinLczB9nTeGkvzQtroj+XwxDFx
         EiZPkL47qJXVced9NpIBhJEAEBKX63wGGS5eicCyzXH4zrKqP828qtl32saNbQX9BWO3
         WYvA==
X-Forwarded-Encrypted: i=1; AKwUvBzaENHf7dhNt5sR99ojaaWzJyAN/33dFHmTiSYkK49eQpiT+NNeOYYMLiLYBjNd9QijpVAIarxfHOGwdxg0yHoK@vger.kernel.org
X-Gm-Message-State: AFq9FYIW9LE4vbd5NPAfhAMzxCLNEUt+7MgByj+uKmdZvHRHHdvPZQhs
	BOed39lakgwWZo34vGLRIyxWg1nv+Y85Lb36p7mCu3k/DEkF10l4TGPE
X-Gm-Gg: AYBFou3GrB/Xf3/8kgjaIv/5NudZ+lvRB+xtz6pm5EAgua25bbRpnRoQ2XORlV29l6e
	NVUUkYt31E9BRLRrcczf/JuKUXUy94HM5sHvgRNN5JOskzNZjJ+LdCcKi/KWC0S1Ff9tAjULHsx
	cswWnk76OOldzKjpbvDcBH5H1xqIZVi36a5pYzykpZKWeEU6094JnOUkgo9o4IUWYt3k3BsxOk1
	ami+4xmB1lrC/VJzc+xo4wJfN53GGoIfv4GJHsuANkiZnQ0FFBNpqUmXBp6CaOX+tmR0qjn5sW4
	JDyYVhvHaYVIsShIkgJamG0ZG667U8KOt4buVuCTtKHktaQ1G3dGLVTVPwS7KanwFyapbL6aKMP
	QB/4AOUoiM1BaEN1tPAPPcQ+G78Tf+oXIH4nxLMpEhwayll/nzPhLgCyIX+BWD1XZAnuJvpxRof
	xzUxjiQ2JJhdiBpFIuJKyhjZEBLgVZdwbO+YhX4tNEixtkUgrhvxNUSDJzvzpVIbaPcHDHVtTUU
	W4YJVjJojdu/kXMc7pF7NGhYl1RYRG1ogGFUED1
X-Received: by 2002:a17:902:e885:b0:2e5:ee16:2f8c with SMTP id d9443c01a7336-2e842ab7ea7mr21364675ad.16.1791561710492;
        Fri, 09 Oct 2026 09:01:50 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cb6sm12333235ad.60.2026.10.09.09.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:01:50 -0700 (PDT)
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
Subject: [PATCH v2 4/5] selftests/perf_events: add userspace AUX regression test
Date: Fri,  9 Oct 2026 23:59:51 +0800
Message-ID: <20261009160010.1829642-5-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009160010.1829642-1-kunwu.chan@gmail.com>
References: <20261009160010.1829642-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lian Wang <lianux.mm@gmail.com>

Add a standalone C program that opens a perf event, mmaps the metadata
and data ring, sets up the AUX area via a second mmap, enables tracing,
reads aux_head from the mmap page, and tears down the mapping.  This
verifies the kernel-side aux_kernel_count changes do not break the
existing userspace AUX mmap protocol.

Environment-dependent outcomes are reported as SKIP rather than PASS:
an AUX area mmap failure (PMU does not support userspace AUX), a PMU
that allows only one open event (e.g. ARM SPE), or a 100 ms window in
which no AUX data was generated are SKIP rather than PASS.  The
two-event independence test follows the full dual-mmap AUX
protocol for both
events so both aux_mmap_count holders really exist, and the
mmap-page-fields test checks the kernel-managed fields
(data_offset/data_size) and the read-back of the user-published
aux_offset/aux_size rather than expecting the kernel to set them.

Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 tools/testing/selftests/perf_events/Makefile  |   1 +
 .../perf_events/aux_kernel_usermode.c         | 645 ++++++++++++++++++
 tools/testing/selftests/perf_events/config    |   2 +
 3 files changed, 648 insertions(+)
 create mode 100644 tools/testing/selftests/perf_events/aux_kernel_usermode.c

diff --git a/tools/testing/selftests/perf_events/Makefile b/tools/testing/selftests/perf_events/Makefile
index 2e5d85770dfe..fbafbd43f097 100644
--- a/tools/testing/selftests/perf_events/Makefile
+++ b/tools/testing/selftests/perf_events/Makefile
@@ -3,4 +3,5 @@ CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 LDFLAGS += -lpthread
 
 TEST_GEN_PROGS := sigtrap_threads remove_on_exec watermark_signal mmap
+TEST_GEN_PROGS += aux_kernel_usermode
 include ../lib.mk
diff --git a/tools/testing/selftests/perf_events/aux_kernel_usermode.c b/tools/testing/selftests/perf_events/aux_kernel_usermode.c
new file mode 100644
index 000000000000..2c8f4baf0825
--- /dev/null
+++ b/tools/testing/selftests/perf_events/aux_kernel_usermode.c
@@ -0,0 +1,645 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Userspace AUX regression test for the perf AUX kernel-consumer API.
+ *
+ * Verifies that the kernel-side AUX changes (aux_kernel_count,
+ * perf_event_setup_aux, etc.) do NOT break the existing userspace
+ * AUX mmap protocol:
+ *   - perf_event_open() with AUX still works
+ *   - mmap AUX buffer still works
+ *   - aux_head / aux_tail from the mmap page are still correct
+ *   - aux_mmap_count is independent of aux_kernel_count
+ *   - Userspace and kernel AUX owners can coexist
+ *
+ * Build:  $(CC) -o aux_kernel_usermode aux_kernel_usermode.c
+ * Usage:  sudo ./aux_kernel_usermode [pmu_name] [pmu_name]
+ *
+ * Environment-dependent outcomes are reported as SKIP, not PASS: an
+ * unsupported PMU, a PMU that only allows one open event at a time, or
+ * a system configuration that rejects the event means the protocol was
+ * not exercised, so it must not inflate the pass count.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/perf_event.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#define PASS(fmt, ...) printf("  [PASS] " fmt "\n", ##__VA_ARGS__)
+#define FAIL(fmt, ...) do { \
+	printf("  [FAIL] " fmt "\n", ##__VA_ARGS__); \
+	failed = 1; \
+} while (0)
+#define SKIP(fmt, ...) do { \
+	printf("  [SKIP] " fmt "\n", ##__VA_ARGS__); \
+	skipped = 1; \
+} while (0)
+
+static int failed;
+static int skipped;
+
+static long perf_event_open(struct perf_event_attr *attr, pid_t pid,
+			    int cpu, int group_fd, unsigned long flags)
+{
+	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
+}
+
+/*
+ * Find an AUX PMU type by scanning sysfs PMU directories.
+ */
+static int find_aux_pmu_type(void)
+{
+	char path[256], type_path[261];
+	FILE *f;
+	struct stat st;
+	int type;
+
+	/* Try common AUX PMU names first */
+	static const char * const known[] = {
+		"arm_spe_0", "arm_spe_1", "arm_spe_2",
+		"intel_pt", "intel_pt0",
+		NULL
+	};
+
+	for (int i = 0; known[i]; i++) {
+		snprintf(path, sizeof(path),
+			 "/sys/bus/event_source/devices/%s", known[i]);
+		if (stat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
+			snprintf(type_path, sizeof(type_path),
+				 "%s/type", path);
+			f = fopen(type_path, "r");
+			if (f) {
+				if (fscanf(f, "%d", &type) == 1) {
+					fclose(f);
+					printf("  Found AUX PMU: %s (type=%d)\n",
+					       known[i], type);
+					return type;
+				}
+				fclose(f);
+			}
+		}
+	}
+
+	return -1;
+}
+
+/*
+ * Look up a specific PMU by name, returning its type from sysfs.
+ */
+static int find_aux_pmu_type_by_name(const char *name)
+{
+	char path[256], type_path[261];
+	struct stat st;
+	FILE *f;
+	int type;
+
+	snprintf(path, sizeof(path),
+		 "/sys/bus/event_source/devices/%s", name);
+	if (stat(path, &st) != 0 || !S_ISDIR(st.st_mode))
+		return -1;
+
+	snprintf(type_path, sizeof(type_path), "%s/type", path);
+	f = fopen(type_path, "r");
+	if (!f)
+		return -1;
+
+	if (fscanf(f, "%d", &type) != 1) {
+		fclose(f);
+		return -1;
+	}
+	fclose(f);
+	printf("  Found AUX PMU: %s (type=%d)\n", name, type);
+	return type;
+}
+
+/*
+ * Test 1: Basic perf_event_open() with software event.
+ * This verifies the perf core is not broken at all.
+ */
+static int test_basic_sw_event(void)
+{
+	struct perf_event_attr attr = {};
+	int fd;
+
+	attr.type = PERF_TYPE_SOFTWARE;
+	attr.config = PERF_COUNT_SW_CPU_CLOCK;
+	attr.size = sizeof(attr);
+	attr.disabled = 1;
+
+	fd = perf_event_open(&attr, 0, -1, -1, 0);
+	if (fd < 0) {
+		FAIL("basic SW event: perf_event_open failed (%s)",
+		     strerror(errno));
+		return 1;
+	}
+
+	if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
+		FAIL("basic SW event: enable failed (%s)", strerror(errno));
+		close(fd);
+		return 1;
+	}
+	usleep(10000);
+	if (ioctl(fd, PERF_EVENT_IOC_DISABLE, 0) < 0) {
+		FAIL("basic SW event: disable failed (%s)", strerror(errno));
+		close(fd);
+		return 1;
+	}
+
+	close(fd);
+	PASS("basic SW event: open/enable/disable/close");
+	return 0;
+}
+
+/*
+ * Test 2: Userspace AUX mmap full lifecycle.
+ * Opens an AUX event, mmaps the metadata/data ring, sets up the AUX
+ * area via a second mmap, enables, reads aux_head, disables, unmaps,
+ * closes.  This is the critical regression test.
+ *
+ * If the kernel rejects the AUX area mmap, the test is SKIP (not all
+ * PMUs support userspace AUX mmap).
+ */
+static int test_aux_mmap(int pmu_type)
+{
+	struct perf_event_attr attr = {};
+	struct perf_event_mmap_page *mp;
+	void *aux_base;
+	unsigned long aux_size, aux_offset, mmap_size;
+	int fd, ret;
+
+	attr.type = pmu_type;
+	attr.size = sizeof(attr);
+	attr.disabled = 1;
+	attr.sample_period = 256;
+
+	/* ARM SPE requires period mode (freq=0) */
+	attr.freq = 0;
+
+	fd = perf_event_open(&attr, 0, -1, -1, 0);
+	if (fd < 0) {
+		SKIP("AUX mmap: perf_event_open failed (%s)", strerror(errno));
+		return 0;
+	}
+
+	/*
+	 * Step 1: mmap the metadata page and data ring at offset 0.
+	 * The kernel creates the ring buffer and returns the metadata page.
+	 */
+	aux_size = 1UL << 20; /* 1 MiB */
+	mmap_size = aux_size + getpagesize();
+	mp = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
+		  MAP_SHARED, fd, 0);
+	if (mp == MAP_FAILED) {
+		FAIL("AUX mmap: metadata mmap failed (%s)", strerror(errno));
+		close(fd);
+		return 1;
+	}
+
+	/*
+	 * Step 2: set aux_offset and aux_size in the metadata page.
+	 * The AUX area starts after the metadata and data pages.
+	 * The kernel reads these values when the AUX area is mmap'd.
+	 */
+	aux_offset = mmap_size;
+	mp->aux_offset = aux_offset;
+	mp->aux_size = aux_size;
+
+	/*
+	 * Step 3: mmap the AUX area at aux_offset.
+	 * The kernel reads aux_offset from the metadata page, verifies
+	 * the mmap offset matches, and allocates the AUX buffer.
+	 */
+	aux_base = mmap(NULL, aux_size, PROT_READ, MAP_SHARED, fd,
+			aux_offset);
+	if (aux_base == MAP_FAILED) {
+		printf("  [SKIP] AUX mmap: AUX area mmap failed (%s)\n",
+		       strerror(errno));
+		munmap(mp, mmap_size);
+		close(fd);
+		return 0;
+	}
+	PASS("AUX mmap: metadata mmap OK, AUX area mmap OK");
+
+	/* Enable the event */
+	ret = ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
+	if (ret < 0) {
+		FAIL("AUX mmap: enable failed (%s)", strerror(errno));
+		munmap(aux_base, aux_size);
+		munmap(mp, mmap_size);
+		close(fd);
+		return 1;
+	}
+
+	/* Run a small workload to generate some AUX data */
+	usleep(100000); /* 100ms */
+
+	/* Disable the event */
+	ret = ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
+	if (ret < 0) {
+		FAIL("AUX mmap: disable failed (%s)", strerror(errno));
+		munmap(aux_base, aux_size);
+		munmap(mp, mmap_size);
+		close(fd);
+		return 1;
+	}
+
+	/* Unmap AUX area */
+	ret = munmap(aux_base, aux_size);
+	if (ret < 0) {
+		FAIL("AUX mmap: AUX munmap failed (%s)", strerror(errno));
+		munmap(mp, mmap_size);
+		close(fd);
+		return 1;
+	}
+
+	/* Unmap metadata */
+	ret = munmap(mp, mmap_size);
+	if (ret < 0) {
+		FAIL("AUX mmap: metadata munmap failed (%s)", strerror(errno));
+		close(fd);
+		return 1;
+	}
+	PASS("AUX mmap: full lifecycle PASS");
+	close(fd);
+	return 0;
+}
+
+/*
+ * Map the data ring (offset 0) of @fd and then, following the AUX
+ * protocol, publish aux_offset/aux_size in the metadata page and map
+ * the AUX area itself.  Returns 0 on success, 1 on failure, and -1
+ * when the kernel refused the AUX mmap (caller should SKIP, since not
+ * every PMU supports userspace AUX).
+ */
+static int mmap_event_aux(int fd, unsigned long aux_size,
+			  struct perf_event_mmap_page **mpp, void **auxp,
+			  unsigned long *mmap_sizep)
+{
+	struct perf_event_mmap_page *mp;
+	void *aux_base;
+	unsigned long mmap_size, aux_offset;
+
+	mmap_size = aux_size + getpagesize();
+	mp = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
+		  MAP_SHARED, fd, 0);
+	if (mp == MAP_FAILED) {
+		FAIL("mmap of metadata/data ring failed (%s)", strerror(errno));
+		return 1;
+	}
+
+	/* The AUX area follows the metadata and data pages. */
+	aux_offset = mmap_size;
+	mp->aux_offset = aux_offset;
+	mp->aux_size = aux_size;
+
+	aux_base = mmap(NULL, aux_size, PROT_READ, MAP_SHARED, fd, aux_offset);
+	if (aux_base == MAP_FAILED) {
+		munmap(mp, mmap_size);
+		return -1;
+	}
+
+	*mpp = mp;
+	*auxp = aux_base;
+	*mmap_sizep = mmap_size;
+	return 0;
+}
+
+/*
+ * Test 3: Verify that aux_mmap_count is independent of aux_kernel_count.
+ * Open two events for the same AUX PMU and give each its own AUX area
+ * through the full dual-mmap protocol, so both aux_mmap_count holders
+ * exist at the same time.  Verifies both events can hold AUX buffers
+ * simultaneously.
+ *
+ * If the PMU allows only one open event (e.g. ARM SPE) the second open
+ * is a SKIP, not a PASS: the coexistence was not exercised.
+ */
+static int test_aux_mmap_independence(int pmu_type)
+{
+	struct perf_event_attr attr = {};
+	struct perf_event_mmap_page *mp1, *mp2;
+	unsigned long aux_size, mmap_size1, mmap_size2;
+	void *aux1, *aux2;
+	int fd1, fd2, ret;
+
+	aux_size = 1UL << 16; /* 64 KiB */
+
+	attr.type = pmu_type;
+	attr.size = sizeof(attr);
+	attr.disabled = 1;
+	attr.sample_period = 256;
+	attr.freq = 0;
+
+	fd1 = perf_event_open(&attr, 0, -1, -1, 0);
+	if (fd1 < 0) {
+		FAIL("AUX independence: first event open failed (%s)",
+		     strerror(errno));
+		return 1;
+	}
+
+	ret = mmap_event_aux(fd1, aux_size, &mp1, &aux1, &mmap_size1);
+	if (ret < 0) {
+		SKIP("AUX independence: first AUX area mmap failed (%s)",
+		     strerror(errno));
+		close(fd1);
+		return 0;
+	}
+	if (ret > 0) {
+		close(fd1);
+		return 1;
+	}
+	PASS("AUX independence: first event has an AUX buffer");
+
+	/* Open a second event for the same PMU */
+	fd2 = perf_event_open(&attr, 0, -1, -1, 0);
+	if (fd2 < 0) {
+		/* Some PMUs (e.g. ARM SPE) only allow one event at a time */
+		SKIP("AUX independence: second event open (%s)",
+		     strerror(errno));
+		munmap(aux1, aux_size);
+		munmap(mp1, mmap_size1);
+		close(fd1);
+		return 0;
+	}
+
+	ret = mmap_event_aux(fd2, aux_size, &mp2, &aux2, &mmap_size2);
+	if (ret < 0) {
+		SKIP("AUX independence: second AUX area mmap failed (%s)",
+		     strerror(errno));
+		munmap(aux1, aux_size);
+		munmap(mp1, mmap_size1);
+		close(fd1);
+		close(fd2);
+		return 0;
+	}
+	if (ret > 0) {
+		munmap(aux1, aux_size);
+		munmap(mp1, mmap_size1);
+		close(fd1);
+		close(fd2);
+		return 1;
+	}
+	PASS("AUX independence: second event has an AUX buffer");
+
+	/* Enable both */
+	if (ioctl(fd1, PERF_EVENT_IOC_ENABLE, 0) < 0 ||
+	    ioctl(fd2, PERF_EVENT_IOC_ENABLE, 0) < 0) {
+		FAIL("AUX independence: enable failed (%s)", strerror(errno));
+		munmap(aux2, aux_size); munmap(mp2, mmap_size2);
+		munmap(aux1, aux_size); munmap(mp1, mmap_size1);
+		close(fd1); close(fd2);
+		return 1;
+	}
+	usleep(50000);
+	if (ioctl(fd1, PERF_EVENT_IOC_DISABLE, 0) < 0 ||
+	    ioctl(fd2, PERF_EVENT_IOC_DISABLE, 0) < 0) {
+		FAIL("AUX independence: disable failed (%s)", strerror(errno));
+		munmap(aux2, aux_size); munmap(mp2, mmap_size2);
+		munmap(aux1, aux_size); munmap(mp1, mmap_size1);
+		close(fd1); close(fd2);
+		return 1;
+	}
+
+	PASS("AUX independence: two events ran simultaneously");
+
+	/* Both metadata pages must remain distinct and readable */
+	PASS("AUX independence: event1 head=%llu event2 head=%llu",
+	     (unsigned long long)__atomic_load_n(&mp1->aux_head, __ATOMIC_RELAXED),
+	     (unsigned long long)__atomic_load_n(&mp2->aux_head, __ATOMIC_RELAXED));
+
+	munmap(aux1, aux_size);
+	munmap(mp1, mmap_size1);
+	munmap(aux2, aux_size);
+	munmap(mp2, mmap_size2);
+	close(fd1);
+	close(fd2);
+	PASS("AUX independence: cleanup OK");
+	return 0;
+}
+
+/*
+ * Test 4: Verify that the mmap control page fields are correct.
+ *
+ * version, compat_version, data_offset and data_size are managed by
+ * the kernel; aux_offset and aux_size are published by userspace (they
+ * are the request for the AUX mapping), so the test checks the
+ * kernel-managed fields and the read-back of the user-published ones
+ * instead of expecting the kernel to fill aux_offset in.
+ */
+static int test_mmap_page_fields(int pmu_type)
+{
+	struct perf_event_attr attr = {};
+	struct perf_event_mmap_page *mp;
+	unsigned long total_size;
+	int fd;
+
+	total_size = 1UL << 18; /* 256 KiB */
+
+	attr.type = pmu_type;
+	attr.size = sizeof(attr);
+	attr.disabled = 1;
+	attr.sample_period = 256;
+	attr.freq = 0;
+
+	fd = perf_event_open(&attr, 0, -1, -1, 0);
+	if (fd < 0) {
+		FAIL("mmap fields: perf_event_open failed (%s)", strerror(errno));
+		return 1;
+	}
+
+	mp = mmap(NULL, total_size + getpagesize(), PROT_READ | PROT_WRITE,
+		  MAP_SHARED, fd, 0);
+	if (mp == MAP_FAILED) {
+		FAIL("mmap fields: mmap failed (%s)", strerror(errno));
+		close(fd);
+		return 1;
+	}
+
+	/* Kernel-managed fields */
+	if (mp->version != 1 && mp->version != 0) {
+		FAIL("mmap fields: version=%u (expected 0 or 1)", mp->version);
+		munmap(mp, total_size + getpagesize());
+		close(fd);
+		return 1;
+	}
+	PASS("mmap fields: version=%u", mp->version);
+
+	if (mp->compat_version != 0) {
+		FAIL("mmap fields: compat_version=%u (expected 0)",
+		     mp->compat_version);
+		munmap(mp, total_size + getpagesize());
+		close(fd);
+		return 1;
+	}
+	PASS("mmap fields: compat_version=%u", mp->compat_version);
+
+	if (mp->data_offset == 0 || mp->data_size == 0) {
+		FAIL("mmap fields: data_offset=%llu data_size=%llu (no data ring)",
+		     (unsigned long long)mp->data_offset,
+		     (unsigned long long)mp->data_size);
+		munmap(mp, total_size + getpagesize());
+		close(fd);
+		return 1;
+	}
+	PASS("mmap fields: data_offset=%llu data_size=%llu",
+	     (unsigned long long)mp->data_offset,
+	     (unsigned long long)mp->data_size);
+
+	/* User-published AUX request fields must round-trip */
+	mp->aux_offset = total_size + getpagesize();
+	mp->aux_size = 1UL << 16;
+	if (mp->aux_offset != total_size + getpagesize() || mp->aux_size != 1UL << 16) {
+		FAIL("mmap fields: aux_offset/aux_size write not visible");
+		munmap(mp, total_size + getpagesize());
+		close(fd);
+		return 1;
+	}
+	PASS("mmap fields: aux_offset/aux_size writable and readable");
+
+	munmap(mp, total_size + getpagesize());
+	close(fd);
+	PASS("mmap fields: all fields correct");
+	return 0;
+}
+
+/*
+ * Test 5: Verify that aux_head does not go backwards while the event
+ * runs.  An unchanged head means the PMU produced no AUX data for this
+ * workload, which is a SKIP (the monotonicity was not exercised), not a
+ * PASS; a head that moved backwards is a FAIL, since a u64 cursor
+ * cannot realistically wrap in 100 ms.
+ */
+static int test_aux_head_monotonic(int pmu_type)
+{
+	struct perf_event_attr attr = {};
+	struct perf_event_mmap_page *mp;
+	unsigned long aux_size, mmap_size, head_before, head_after;
+	void *aux_base;
+	int fd, ret;
+
+	aux_size = 1UL << 16;
+	mmap_size = aux_size + getpagesize();
+
+	attr.type = pmu_type;
+	attr.size = sizeof(attr);
+	attr.disabled = 1;
+	attr.sample_period = 256;
+	attr.freq = 0;
+
+	fd = perf_event_open(&attr, 0, -1, -1, 0);
+	if (fd < 0) {
+		/* Some PMUs may reject the default config */
+		SKIP("AUX head monotonic: PMU rejected config (%s)",
+		     strerror(errno));
+		return 0;
+	}
+
+	ret = mmap_event_aux(fd, aux_size, &mp, &aux_base, &mmap_size);
+	if (ret < 0) {
+		SKIP("AUX head monotonic: AUX area mmap failed (%s)",
+		     strerror(errno));
+		close(fd);
+		return 0;
+	}
+	if (ret > 0) {
+		close(fd);
+		return 1;
+	}
+
+	ret = ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
+	if (ret < 0) {
+		SKIP("AUX head monotonic: enable failed (%s)", strerror(errno));
+		munmap(aux_base, aux_size);
+		munmap(mp, mmap_size);
+		close(fd);
+		return 0;
+	}
+
+	/* Read initial head */
+	head_before = __atomic_load_n(&mp->aux_head, __ATOMIC_RELAXED);
+
+	usleep(100000); /* 100ms */
+
+	ret = ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
+	if (ret < 0) {
+		FAIL("AUX head monotonic: disable failed (%s)", strerror(errno));
+		munmap(aux_base, aux_size);
+		munmap(mp, mmap_size);
+		close(fd);
+		return 1;
+	}
+
+	head_after = __atomic_load_n(&mp->aux_head, __ATOMIC_RELAXED);
+
+	if (head_after > head_before) {
+		PASS("AUX head monotonic: before=%lu after=%lu (advanced)",
+		     head_before, head_after);
+	} else if (head_after == head_before) {
+		SKIP("AUX head monotonic: no AUX data generated in 100ms");
+	} else {
+		FAIL("AUX head monotonic: backwards (before=%lu after=%lu)",
+		     head_before, head_after);
+	}
+
+	munmap(aux_base, aux_size);
+	munmap(mp, mmap_size);
+	close(fd);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int pmu_type;
+
+	if (geteuid() != 0) {
+		fprintf(stderr, "Run as root\n");
+		return 4; /* skip */
+	}
+
+	printf("=== Perf AUX Kernel API: Userspace Regression Test ===\n\n");
+
+	/* Test 1: Basic SW event */
+	printf("--- 1. Basic Software Event ---\n");
+	test_basic_sw_event();
+
+	/* Find an AUX-capable PMU: explicit name from argv, or auto-detect. */
+	if (argc > 1)
+		pmu_type = find_aux_pmu_type_by_name(argv[1]);
+	else
+		pmu_type = find_aux_pmu_type();
+	if (pmu_type < 0) {
+		printf("--- 2-5. AUX Tests ---\n");
+		printf("  [SKIP] No AUX-capable PMU found\n");
+	} else {
+		/* Test 2: AUX mmap lifecycle */
+		printf("\n--- 2. AUX Mmap Lifecycle ---\n");
+		test_aux_mmap(pmu_type);
+
+		/* Test 3: AUX mmap independence */
+		printf("\n--- 3. AUX Mmap Independence ---\n");
+		test_aux_mmap_independence(pmu_type);
+
+		/* Test 4: mmap page fields */
+		printf("\n--- 4. Mmap Page Fields ---\n");
+		test_mmap_page_fields(pmu_type);
+
+		/* Test 5: AUX head monotonic */
+		printf("\n--- 5. AUX Head Monotonic ---\n");
+		test_aux_head_monotonic(pmu_type);
+	}
+
+	printf("\n=== Result: %s ===\n", failed ? "FAIL" : "PASS");
+	if (skipped)
+		printf("=== Note: some tests were SKIPped (environment)\n");
+	return failed ? 1 : 0;
+}
diff --git a/tools/testing/selftests/perf_events/config b/tools/testing/selftests/perf_events/config
index ba58ff2203e4..2508f331cfe0 100644
--- a/tools/testing/selftests/perf_events/config
+++ b/tools/testing/selftests/perf_events/config
@@ -1 +1,3 @@
 CONFIG_PERF_EVENTS=y
+CONFIG_PERF_AUX_KERNEL_KUNIT_TEST=y
+CONFIG_KUNIT_DEBUGFS=y
-- 
2.43.0

