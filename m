Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B63A961E
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982086; cv=none; b=EN7OyXDZlAH2K8F2lLGRbvi0PdtVyLnoa0TvLT+1Ivi1+yIiR0ynlvmHnGxFZinN//Dj+y3aaIUlRknfDBKlfRh8/BT0kSd/63Y+TfzUZ45kyqPvbr088x2z1qeAsgLzjlGaerwaHryS0bKPvjOg0GTcu/xzMsxTOGnktgXEdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982086; c=relaxed/simple;
	bh=gVwQ6XdElg+0LAgESVckqM0k2QkPIm0KKsqQ35uwZDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z2PXswIy6Eg+em2Z1kMIW+rTSwLouQO/E78AUkr6is1MSBP0j7gq9PiiFS1gvc4luRfqT3XWPK5fzyJA3Sks1WzfTmc7+R2YnnWPNoSuZCRkTy39Tjy9HglO68znJfjy2KasyM03nJaj9tuYq/7CIcOMukRxv5Cc6Mb2lR3h6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xkv0muE4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkv0muE4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so29102065e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786982083; x=1787586883; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CYoVZjftpouSJ7GJkuPaD9Nbny+lb8Qv46HwHPYwG5E=;
        b=xkv0muE41A8Xs6uCfuDilv4X0Tio/vbdUz36Q4/Pt29ie379sou+GgtQz6E7bOEsu8
         1LJysJza8o5wfSxqFOTAPjZs4qh+5OMAyZdoCEXTJ6dxl19DkVdiu3C90LZOhQAkhljm
         lAiRqtCIW/ZLLXlYBJvEDTh37XPdgcp/VsFwc4Yzhkjjlq59Ou3pYcE5wwQ9xJBwMYGg
         w8SN8rh8R4OGVvkKI0DzGznwYab/sVdi6+KIkgFElPuHuQ/bUL3F7iKerIpXHZB/Sn6g
         yqFvJBgcRmJWszcoyujDxax/F3LhcmTD/bYNwhU7Ki/abqHRBcRKpC6MbaCDeNkta+bO
         4czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786982083; x=1787586883;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CYoVZjftpouSJ7GJkuPaD9Nbny+lb8Qv46HwHPYwG5E=;
        b=ACJMVGMrrs3qhBFHCgRkRsKON2wIzA5F9hS5q6rRwMF4nv0zNrWzr+UB0xPIe8xdOO
         bQmW7iTm5l+BAPCFViXuJp58e8avia0iKBqWy3k9+af+mi6TxL4nSYi0fpDDoVMxpnC/
         jsfCg5w4PoOwTT9lyFmRmTvbISaLoHGDnvOPt0LDeoPp0wKjU+WoN5h/wdzm5z8gx2JL
         Wo6vumUUMTgpB9qc4W6sVJgL3HOnqKP0hdYmY8LIPsHrZPaMeDZUmVHtpBWfQ4IWJYBd
         KTKGf2dnpHZKMYLuWjBUhh4tbaYmV/sq43snV9IJduAKPsKT91wb6cq1wpgnbCMOJaXE
         5gYQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLBGROdTSGAN7GEif60lYPk+syABERG/bDj1EpTg47z5ruKNq7Rm1YO6K46/g1dixQ/XFqE/f8BUxJv2ywuSlX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/UsVTnmV+qCp54xQXodwDRr7d53WGb2/oSaA9nbGBW564d1y
	lOwrqmBmE+3aoqQB/CKJeWCLx89xWJQv3cyQH1Aq93mVDK2x17Norp3KI/uQWfnhkHc=
X-Gm-Gg: AR+sD13xo4Bdk1vz3gTlBWRLcmFGY0fDXqbgHIxiw7gq49sAlM4lY2KI5CX0vkRkBQ3
	IpNLoqDHN+GrxsM/bB2D8NBsc/H0ot7R1oRYbFmMWFDgACPR40PTjx8doe+qGsrB8y3TMqc2/Fz
	K6KjoZ5dbwTPTOGSRAUppIrOe0q2EV4tYdfw5kt7bYu+w5Ctwu+vkrbseGaETLC9KLzXomPCZvr
	78oJ6EmrI4He0SBWvfPyo+e5ji3AUrFoMTxydYBrt+KQfiOoGnhbzlzkunEVYcsW3CQpovCiwlg
	72Lx5pa0vB8ezA2FROvtrBbSKn4ImAVU0E4MG47NYrWpebqk0dFKMFkNcH5KYVw3059KWRVa4ri
	4fbpUIpg6UD8JddWPoEIQG8jLIFDiU+FA27na7IEis+LYbEziZGZEmunPt4qHaPBqu5wbBm4mbS
	H+tRH58uldoZo0Q+/y4bwSTMK72XOewZdVOIzLS7Xtpf+ZCr9mGx4RZtE9iDV0zqia
X-Received: by 2002:a05:600c:1908:b0:499:841c:2016 with SMTP id 5b1f17b1804b1-4999fa6a973mr16566425e9.0.1786982082744;
        Mon, 17 Aug 2026 08:54:42 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610ecf4sm129358815e9.7.2026.08.17.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 08:54:42 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 17 Aug 2026 16:54:13 +0100
Subject: [PATCH v4] perf tests: mmap-basic: fix user rdpmc detection logic
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-rdpmc-detection-logic-v4-1-c22074578f6a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKQug2oC/0XMQQ6CMBCF4auQWTtkoKUIK+9hXNR2SpsIxdIYI
 +HuNm5cfsl7/w4bp8AbjNUOiV9hC3EpkKcKjNfLxBhsMbTUKjo3PSa7zgYtZza5bPERp1AsXK/
 lYNxdKijfNbEL71/3eit2Kc6YfWL9rwlBNBCRqFWnOknY4PPjdbwktl7n2sQZjuML1UtK2aIAA
 AA=
X-Change-ID: 20260817-rdpmc-detection-logic-d3f7a49cfb46
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

From: Qiao Zhao <qzhao@redhat.com>

RISC-V and Arm control userspace counter access through
/proc/sys/kernel/perf_user_access. Add that as a fallback to
set_user_read() so the test can test both the enabled and disabled
states on those platforms. RISC-V also uses a '2' value rather than just
0 or 1 so add support for restoring arbitrary values.

On Arm, cap_user_rdpmc will always be set when requested, even if the
global setting is disabled. This is so that the feature can be enabled
or revoked while events are live. Skip checking it on Arm for the
"expected disabled" case, otherwise the test will fail.

Add comments, more meaningful variable names and improve the error
messages so that it's clearer what this part of the test is doing.

Signed-off-by: Qiao Zhao <qzhao@redhat.com>
[Test pc->index, fix bugs in set_user_read(), and simplify commit msg]
Assisted-by: Codex:GPT-5.6
Signed-off-by: James Clark <james.clark@linaro.org>
---
I'm sending this to fix the comments that I left on the "V3 resend"
because I don't think Qiao sent a V4 and it's been quite a while.

There were also some unreported bugs that I found during testing.

Changes in V4:
 - Don't remove pc->index check. Without it Perf can silently fall back
   to the read() syscall and the test is useless.
 - Test the 'expected disabled' case for Arm in an ifdef to workaround
   platform differences.
 - lseek() before writing to perf_user_access otherwise it's ignored.
 - Support restoring arbitrary values to perf_user_access because RISC-V
   uses '2' for legacy mode.
 - Rename rdpmc_supported to rdpmc_expected as this is what the test
   expects, not what the system does.
 - Label pc->index as rdpmc_event_active for clarity.
 - Add comments and simplify the commit message.
---
 tools/perf/tests/mmap-basic.c | 137 ++++++++++++++++++++++++++++++------------
 1 file changed, 98 insertions(+), 39 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 5cec7644952c..4433a5df3d77 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <stdlib.h>
 
 #include <fcntl.h>
@@ -182,47 +183,77 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 }
 
 enum user_read_state {
-	USER_READ_ENABLED,
-	USER_READ_DISABLED,
-	USER_READ_UNKNOWN,
+	USER_READ_UNKNOWN = -1,
+	USER_READ_DISABLED = 0,
+	USER_READ_ENABLED = 1,
 };
 
-static enum user_read_state set_user_read(struct perf_pmu *pmu, enum user_read_state enabled)
+static int set_user_read_fd(int fd, int enabled)
 {
-	char buf[2] = {0, '\n'};
+	char buf[32], *endptr;
+	long value;
 	ssize_t len;
-	int events_fd, rdpmc_fd;
-	enum user_read_state old_user_read = USER_READ_UNKNOWN;
+	int old_user_read;
 
-	if (enabled == USER_READ_UNKNOWN)
+	len = read(fd, buf, sizeof(buf) - 1);
+	if (len <= 0) {
+		pr_debug("%s read failed\n", __func__);
 		return USER_READ_UNKNOWN;
+	}
+	buf[len] = '\0';
 
-	events_fd = perf_pmu__event_source_devices_fd();
-	if (events_fd < 0)
+	errno = 0;
+	value = strtol(buf, &endptr, 10);
+	if (errno || endptr == buf || value < 0 || value > INT_MAX) {
+		pr_debug("%s invalid value: %s\n", __func__, buf);
 		return USER_READ_UNKNOWN;
+	}
+	old_user_read = value;
 
-	rdpmc_fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
-	if (rdpmc_fd < 0) {
-		close(events_fd);
-		return USER_READ_UNKNOWN;
+	if (enabled == old_user_read)
+		return old_user_read;
+
+	len = scnprintf(buf, sizeof(buf), "%d\n", enabled);
+	if (lseek(fd, 0, SEEK_SET) < 0) {
+		pr_debug("%s seek failed\n", __func__);
+		return old_user_read;
 	}
+	if (write(fd, buf, len) != len)
+		pr_debug("%s write failed\n", __func__);
 
-	len = read(rdpmc_fd, buf, sizeof(buf));
-	if (len != sizeof(buf))
-		pr_debug("%s read failed\n", __func__);
+	return old_user_read;
+}
+
+static int set_user_read(struct perf_pmu *pmu, int enabled)
+{
+	int events_fd, fd, old_user_read;
 
-	// Note, on Intel hybrid disabling on 1 PMU will implicitly disable on
-	// all the core PMUs.
-	old_user_read = (buf[0] == '1') ? USER_READ_ENABLED : USER_READ_DISABLED;
+	if (enabled == USER_READ_UNKNOWN)
+		return USER_READ_UNKNOWN;
 
-	if (enabled != old_user_read) {
-		buf[0] = (enabled == USER_READ_ENABLED) ? '1' : '0';
-		len = write(rdpmc_fd, buf, sizeof(buf));
-		if (len != sizeof(buf))
-			pr_debug("%s write failed\n", __func__);
+	events_fd = perf_pmu__event_source_devices_fd();
+	if (events_fd >= 0) {
+		fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
+		if (fd >= 0) {
+			/*
+			 * Note, on Intel hybrid disabling on 1 PMU will
+			 * implicitly disable on all the core PMUs.
+			 */
+			old_user_read = set_user_read_fd(fd, enabled);
+			close(fd);
+			close(events_fd);
+			return old_user_read;
+		}
+		close(events_fd);
 	}
-	close(rdpmc_fd);
-	close(events_fd);
+
+	/* Fallback: perf_user_access interface (arm64, riscv, or similar) */
+	fd = open("/proc/sys/kernel/perf_user_access", O_RDWR);
+	if (fd < 0)
+		return USER_READ_UNKNOWN;
+
+	old_user_read = set_user_read_fd(fd, enabled);
+	close(fd);
 	return old_user_read;
 }
 
@@ -240,7 +271,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 	perf_thread_map__set_pid(threads, 0, 0);
 
 	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-		enum user_read_state saved_user_read_state = set_user_read(pmu, enabled);
+		int saved_user_read_state = set_user_read(pmu, enabled);
 		struct perf_event_attr attr = {
 			.type	= PERF_TYPE_HARDWARE,
 			.config	= perf_pmus__supports_extended_type()
@@ -253,7 +284,8 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 		struct perf_evsel *evsel = NULL;
 		int err;
 		struct perf_event_mmap_page *pc;
-		bool mapped = false, opened = false, rdpmc_supported;
+		bool mapped = false, opened = false, rdpmc_expected;
+		bool rdpmc_event_active;
 		struct perf_counts_values counts = { .val = 0 };
 
 
@@ -301,26 +333,53 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 			goto cleanup;
 		}
 
+		/*
+		 * When pc->index == 0, userspace access is disabled and Perf
+		 * will silently use the read() syscall instead. Test this to
+		 * make sure we're not doing that.
+		 */
+		rdpmc_event_active = pc->index;
+
+		/*
+		 * If we couldn't set the state, test that whatever state we're
+		 * already in is the expected one.
+		 */
 		if (saved_user_read_state == USER_READ_UNKNOWN)
-			rdpmc_supported = pc->cap_user_rdpmc && pc->index;
+			rdpmc_expected = pc->cap_user_rdpmc && rdpmc_event_active;
 		else
-			rdpmc_supported = (enabled == USER_READ_ENABLED);
+			rdpmc_expected = (enabled == USER_READ_ENABLED);
 
-		if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index)) {
-			pr_err("User space counter reading for PMU %s [Failed unexpected supported counter access %d %d]\n",
-				pmu->name, pc->cap_user_rdpmc, pc->index);
+		if (rdpmc_expected && (!pc->cap_user_rdpmc || !rdpmc_event_active)) {
+			pr_err("User space counter reading for PMU %s [Failed. rdpmc event should be both enabled and active %d %d]\n",
+				pmu->name, pc->cap_user_rdpmc, rdpmc_event_active);
 			ret = TEST_FAIL;
 			goto cleanup;
 		}
 
-		if (!rdpmc_supported && pc->cap_user_rdpmc) {
-			pr_err("User space counter reading for PMU %s [Failed unexpected unsupported counter access %d]\n",
-				pmu->name, pc->cap_user_rdpmc);
+#ifdef __aarch64__
+		/*
+		 * On Arm, pc->cap_user_rdpmc is set when the event is opened
+		 * with userspace counter access, regardless of whether rdpmc is
+		 * enabled or not via sysfs. The event is always opened with it
+		 * in this test, so don't check it in the expected disabled
+		 * case.
+		 */
+		if (!rdpmc_expected && rdpmc_event_active) {
+			pr_err("User space counter reading for PMU %s [Failed. rdpmc event should be inactive %d]\n",
+				pmu->name, rdpmc_event_active);
+			ret = TEST_FAIL;
+			goto cleanup;
+		}
+#else
+		if (!rdpmc_expected && pc->cap_user_rdpmc) {
+			pr_err("User space counter reading for PMU %s [Failed. rdpmc event should be disabled and inactive %d %d]\n",
+				pmu->name, pc->cap_user_rdpmc, rdpmc_event_active);
 			ret = TEST_FAIL;
 			goto cleanup;
 		}
+#endif
 
-		if (rdpmc_supported && pc->pmc_width < 32) {
+		if (rdpmc_expected && pc->pmc_width < 32) {
 			pr_err("User space counter reading for PMU %s [Failed width not set %d]\n",
 				pmu->name, pc->pmc_width);
 			ret = TEST_FAIL;
@@ -328,7 +387,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 		}
 
 		perf_evsel__read(evsel, 0, 0, &counts);
-		if (rdpmc_supported && counts.val == 0) {
+		if (rdpmc_expected && counts.val == 0) {
 			pr_err("User space counter reading for PMU %s [Failed read]\n", pmu->name);
 			ret = TEST_FAIL;
 			goto cleanup;

---
base-commit: 6ae6fb96ccd48032b00a38d5f8e0e0a2cce4972b
change-id: 20260817-rdpmc-detection-logic-d3f7a49cfb46

Best regards,
--  
James Clark <james.clark@linaro.org>

