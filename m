Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27047F2F8
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370401; cv=none; b=iepLuWvCWHgRv1s3m477V/KlUcGHJi6xw9tmlPSFt70AW5tLUAguU4oW1G9qgxGOmTOyMpGJWxmTtZnZ5n3pNdf49tesnEUDCwUlQ2ahg5uodUAvp0uc4os/E8RpZgGPXBhESTFp//E6Br7VFKuoRIKCrTw/LHk7vyNnd9DDmo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370401; c=relaxed/simple;
	bh=Lfk3z/9XBW9KBFUf735HqXRDByIh7ATabYIoLTvAS5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJfXK013Z6BiMdxbeI67IQf7Mv12QBxhFewl7qKRO0BVu1cMWnssvX/uPryKbC+wYQUjYrwAWzUoHcUHB4zoApY0yqWw1K08FCAzpG3FX4mJVrRFRfGKy6iT43pEEm2pQIYUPuasVmH+pqj95nm290f0QXZfwWvT06/xFHL321Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WcA6PKtf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcA6PKtf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so12038075e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Oct 2026 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791370367; x=1791975167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NNNH9av8SFT8quNSTc63AF+CNNxl0BFefXFN7mUmANs=;
        b=WcA6PKtfsKB/+aXMutOJtrBjEdu0iJUn8qqSmpl2hzSNb1jSzJV5uWEndYqmhci5B+
         wxO6MjtX0iSpMG/QP7SSDUj0G3nv4QzbCrUonErLto9w3lLXI41CV9ojgyUnioHAfmUy
         6LLyskkCm98vUVDsdjsrj65Ri4RQUez5GI9DJU28sbkO/8s0ruGkjqCILppOZAcZz8X9
         SX9T+S+ioeSdIwvoh4xBxPk0A2g7t5B4vAcZua/g2SGVBu/hOLDu+N03poAZ4ab96n2p
         XBkyDLiB8m1sUk3RfG8lZQrdeoevySjKbi6WwY2g5B431jmJXzYuFIT46IMg8nZ4nzRM
         YFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791370367; x=1791975167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NNNH9av8SFT8quNSTc63AF+CNNxl0BFefXFN7mUmANs=;
        b=cYY07wTc0LMPhQdmRcJUefxNLB6C11AzKIEo2o5T7p6pVVXiT5sS0aX7jVLUECfK/p
         7C3QR2KDl/Bq7cv3EcYjjxfpB5xU/URBd72gANXevsw+h3uBo/3C3KW0KKxwi7AIwcq5
         FEGqiIpYOJGp1s4h1CVxRZWcEGZLYQCbl6x+uVyToYvZ6KKQaE+Pe+zDSfwTH8acJ4p+
         uHhMSs0CkjZfyhzPH0gC9nv8IfVl+xjRbF1tV2nQZPXsUdkwOvfXCv3oSNY5h7DJtzuu
         i3YL8EmTVCK8YnIVQEl1M8xhxEUufs0I/E4h0hck6gQjZlq8mNNL9FCtt/4Yv1TAH8v2
         T2bg==
X-Forwarded-Encrypted: i=1; AKwUvBxuk0MRs4kxCuzsmTzyl1ETeXH6pggcCp4+8a0o/M+WHVmLwp5qRgVw3ZvRQoZUaZKdkhbKf+TTUTWFNWerhL7h@vger.kernel.org
X-Gm-Message-State: AFuF++mWuDFlV3UMam8xDKfh0ugrU3hLgACsVTIfehh29HINmnm2ZokI
	fuJKG3/5Q5Q3I+qDB+FnoaT8SKxZ5UXL0ArzdhTR2GKwE1FSd9WerDHv0s4qZCHBHjo=
X-Gm-Gg: AYBFou1JJDzvcQ+TqljfAclWbB1hJzHaPVAZ46n2+jp/Bn+i/5BrBRhD/KLWes04t/3
	RkDiY4z5utK+4brHloibYFjO75/dNXvBzgqvhwcXQxWQouLeQg9zB4mL0EyU6g+s6hOx8GyqI80
	zNE6ajqSoO6FF35HdPqNOaMyhnOdudwqyVl8RM+77a5FDBiFNuADoQ7muMijTmB00pRnZmmEzy0
	KTnOw6vhJRlR/Zqzu/Bwqnu1uVSbnaUWv7CV4vD5zRa75t708SJtd4XlpwPKrYuyOoaHsuxC2lb
	XsA1zKmjT1A7w4Syd6C5xfylPfpHKpbOgTr7zpkg5JEEgqAJHzOw/d3uxDTzuSl9Ptl/19vq24n
	P9arBTLYEapHPwT/jvmz84sP7tOwH4QS6YT3bZ0saq1758HksxGIJVZ+vkzITiNZMto8H6DrcdL
	DEW+B9GFxDDrqoTqMaXRnzH6ZvS+l/h5J+Lbi0iIVKL76ESs6lQ6s7G3sYOmAKcIaPZg1kqOULn
	w==
X-Received: by 2002:a05:600c:3f08:b0:4a0:1723:2d8e with SMTP id 5b1f17b1804b1-4a1800ca17amr25117305e9.2.1791370366620;
        Wed, 07 Oct 2026 03:52:46 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d31767sm5182781f8f.51.2026.10.07.03.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 03:52:46 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 07 Oct 2026 11:52:13 +0100
Subject: [PATCH v6 2/2] perf tests: mmap-basic: fix user rdpmc detection
 logic
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rdpmc-detection-logic-v6-2-d7ed6a85f864@linaro.org>
References: <20261007-rdpmc-detection-logic-v6-0-d7ed6a85f864@linaro.org>
In-Reply-To: <20261007-rdpmc-detection-logic-v6-0-d7ed6a85f864@linaro.org>
To: Ian Rogers <irogers@google.com>, Michael Petlan <mpetlan@redhat.com>, 
 Qiao Zhao <qzhao@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

RISC-V and Arm control userspace counter access through
/proc/sys/kernel/perf_user_access. Add that as a fallback to
set_user_read() so the test can exercise both enabled and disabled
states on those platforms.

Document disabled, enabled and legacy states in user_read_state and fail
on values outside the known 0-2 range. Preserve and restore any value in
this range, rather than just 0 or 1.

Skip when the control files exist but can't be written to
(USER_READ_ERR_PERM). We can't rely on always being able to write to
them when an exclude_kernel=0 event can be opened because opening events
might succeed for non-root users when perf_event_paranoid=-1.

This test isn't run on unsupported platforms since the previous commit,
so we can simplify the following things:

 * Test that cap_user_rdpmc is always equal to the requested state
   rather than checking it only when disabled. As long as we stop
   setting the cap in the attr unconditionally on Arm, this is ok.

 * Remove the USER_READ_UNKNOWN/rdpmc_supported fallback in the checks.
   Now the expected state is always the one requested. USER_READ_UNKNOWN
   only controls whether to skip restoration of the state on unsupported
   platforms, so call it USER_READ_ERR_NO_FILE.

Signed-off-by: Qiao Zhao <qzhao@redhat.com>
[Re-write to fix bugs in set_user_read() and simplify tests]
Assisted-by: Codex:GPT-6.1-Sol
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/mmap-basic.c | 137 +++++++++++++++++++++++++++++-------------
 1 file changed, 94 insertions(+), 43 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 208cd889f23d..2d892a51a7f4 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -2,6 +2,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <stdlib.h>
+#include <unistd.h>
 
 #include <fcntl.h>
 #include <linux/err.h>
@@ -12,6 +13,8 @@
 #include <perf/evlist.h>
 #include <perf/mmap.h>
 
+#include <tools/config.h>
+
 #include "cpumap.h"
 #include "debug.h"
 #include "event.h"
@@ -182,50 +185,83 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 }
 
 enum user_read_state {
-	USER_READ_ENABLED,
-	USER_READ_DISABLED,
-	USER_READ_UNKNOWN,
+	USER_READ_ERR_PERM = -2,
+	USER_READ_ERR_NO_FILE = -1,
+
+	USER_READ_DISABLED = '0',
+	USER_READ_ENABLED = '1',
+#if defined(__i386__) || defined(__x86_64__) || (defined(__riscv) && __riscv_xlen == 64)
+	/* Unrestricted access on x86, legacy access on RISC-V. */
+	USER_READ_LEGACY = '2',
+#endif
+	USER_READ_MAX
 };
 
-static enum user_read_state set_user_read(struct perf_pmu *pmu, enum user_read_state enabled)
+static enum user_read_state user_read_file_op(int fd, enum user_read_state enabled)
 {
 	char buf[2] = {0, '\n'};
-	ssize_t len;
-	int events_fd, rdpmc_fd;
-	enum user_read_state old_user_read = USER_READ_UNKNOWN;
-
-	if (enabled == USER_READ_UNKNOWN)
-		return USER_READ_UNKNOWN;
-
-	events_fd = perf_pmu__event_source_devices_fd();
-	if (events_fd < 0)
-		return USER_READ_UNKNOWN;
+	ssize_t len = read(fd, buf, 1);
+	enum user_read_state old_user_read = USER_READ_ERR_NO_FILE;
 
-	rdpmc_fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
-	if (rdpmc_fd < 0) {
-		close(events_fd);
-		return USER_READ_UNKNOWN;
-	}
-
-	len = read(rdpmc_fd, buf, sizeof(buf));
-	if (len != sizeof(buf))
+	if (len <= 0) {
 		pr_debug("%s read failed\n", __func__);
+		goto out;
+	}
 
-	// Note, on Intel hybrid disabling on 1 PMU will implicitly disable on
-	// all the core PMUs.
-	old_user_read = (buf[0] == '1') ? USER_READ_ENABLED : USER_READ_DISABLED;
+	old_user_read = buf[0];
 
 	if (enabled != old_user_read) {
-		buf[0] = (enabled == USER_READ_ENABLED) ? '1' : '0';
-		len = write(rdpmc_fd, buf, sizeof(buf));
+		buf[0] = enabled;
+		lseek(fd, 0, SEEK_SET);
+		len = write(fd, buf, sizeof(buf));
 		if (len != sizeof(buf))
 			pr_debug("%s write failed\n", __func__);
 	}
-	close(rdpmc_fd);
-	close(events_fd);
+
+out:
+	close(fd);
 	return old_user_read;
 }
 
+static enum user_read_state set_user_read(struct perf_pmu *pmu,
+					  enum user_read_state enabled)
+{
+	int events_fd, fd;
+	enum user_read_state ret = USER_READ_ERR_NO_FILE;
+
+	if (enabled == USER_READ_ERR_NO_FILE || enabled == USER_READ_ERR_PERM)
+		return enabled;
+
+	events_fd = perf_pmu__event_source_devices_fd();
+	if (events_fd >= 0) {
+		fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
+		if (fd >= 0) {
+			/*
+			 * Note, on Intel hybrid disabling on 1 PMU will implicitly
+			 * disable on all the core PMUs.
+			 */
+			ret = user_read_file_op(fd, enabled);
+			close(events_fd);
+			return ret;
+		} else if (errno == EACCES || errno == EROFS) {
+			/* Permissions failure, flag the failure for a skip. */
+			close(events_fd);
+			return USER_READ_ERR_PERM;
+		}
+		close(events_fd);
+	}
+
+	/* Fallback: perf_user_access interface (arm64, riscv, or similar) */
+	fd = open("/proc/sys/kernel/perf_user_access", O_RDWR);
+	if (fd >= 0)
+		ret = user_read_file_op(fd, enabled);
+	else if (errno == EACCES || errno == EROFS)
+		ret = USER_READ_ERR_PERM;
+
+	return ret;
+}
+
+
 static int test_stat_user_read(u64 event, enum user_read_state enabled)
 {
 	struct perf_pmu *pmu = NULL;
@@ -246,9 +282,6 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 			.config	= perf_pmus__supports_extended_type()
 			? event | ((u64)pmu->type << PERF_PMU_TYPE_SHIFT)
 				: event,
-#ifdef __aarch64__
-			.config1 = 0x2,		/* Request user access */
-#endif
 		};
 		struct perf_evsel *evsel = NULL;
 		int err;
@@ -256,8 +289,28 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 		bool mapped = false, opened = false, rdpmc_supported;
 		struct perf_counts_values counts = { .val = 0 };
 
+		if (__is_defined(__aarch64__) && enabled == USER_READ_ENABLED)
+			attr.config1 = 0x2;  /* Request user access */
 
 		pr_debug("User space counter reading for PMU %s\n", pmu->name);
+
+		if (saved_user_read_state == USER_READ_ERR_PERM) {
+			pr_debug("User space counter reading for PMU %s [Failed to get user read state]\n",
+				 pmu->name);
+			ret = TEST_SKIP;
+			goto cleanup;
+		}
+
+		/* Check value is in the expected range */
+		if (saved_user_read_state != USER_READ_ERR_NO_FILE &&
+		    (saved_user_read_state < USER_READ_DISABLED ||
+		     saved_user_read_state >= USER_READ_MAX)) {
+			pr_err("User space counter reading for PMU %s [Unexpected current state %d]\n",
+				pmu->name, saved_user_read_state);
+			ret = TEST_FAIL;
+			goto cleanup;
+		}
+
 		/*
 		 * Restrict scheduling to only use the rdpmc on the CPUs the
 		 * event can be on. If the test doesn't run on the CPU of the
@@ -301,21 +354,18 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 			goto cleanup;
 		}
 
-		if (saved_user_read_state == USER_READ_UNKNOWN)
-			rdpmc_supported = pc->cap_user_rdpmc && pc->index;
-		else
-			rdpmc_supported = (enabled == USER_READ_ENABLED);
+		rdpmc_supported = (enabled == USER_READ_ENABLED);
 
-		if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index)) {
-			pr_err("User space counter reading for PMU %s [Failed unexpected supported counter access %d %d]\n",
-				pmu->name, pc->cap_user_rdpmc, pc->index);
+		if (rdpmc_supported && !pc->index) {
+			pr_err("User space counter reading for PMU %s [index must be set when enabled %d]\n",
+				pmu->name, pc->index);
 			ret = TEST_FAIL;
 			goto cleanup;
 		}
 
-		if (!rdpmc_supported && pc->cap_user_rdpmc) {
-			pr_err("User space counter reading for PMU %s [Failed unexpected unsupported counter access %d]\n",
-				pmu->name, pc->cap_user_rdpmc);
+		if (rdpmc_supported != pc->cap_user_rdpmc) {
+			pr_err("User space counter reading for PMU %s [cap should match requested state %d %d]\n",
+				pmu->name, pc->cap_user_rdpmc, rdpmc_supported);
 			ret = TEST_FAIL;
 			goto cleanup;
 		}
@@ -363,7 +413,8 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 			perf_evsel__munmap(evsel);
 		if (opened)
 			perf_evsel__close(evsel);
-		perf_evsel__delete(evsel);
+		if (evsel)
+			perf_evsel__delete(evsel);
 
 		/* If the affinity was changed, then put it back to all CPUs. */
 		if (pmu->cpus != NULL) {

-- 
2.43.0

