Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB87BC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 16:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24E86102A
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 16:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhKIQdf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:33:35 -0500
Received: from foss.arm.com ([217.140.110.172]:35870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234428AbhKIQdf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 11:33:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ECA9101E;
        Tue,  9 Nov 2021 08:30:49 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D392C3F800;
        Tue,  9 Nov 2021 08:30:46 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] perf arm-spe: Implement find_snapshot callback
Date:   Tue,  9 Nov 2021 16:30:08 +0000
Message-Id: <20211109163009.92072-3-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211109163009.92072-1-german.gomez@arm.com>
References: <20211109163009.92072-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The head pointer of the AUX buffer managed by the arm_spe_pmu.c driver
is not monotonically increasing, therefore the find_snapshot callback is
needed in order to find the trace data within the AUX buffer and avoid
wasting space in the perf.data file.

The pointer is assumed to have wrapped if the buffer contains non-zero
data at the end. If it has wrapped, the entire contents of the AUX
buffer are stored in the perf.data file. Otherwise only the data up to
the head pointer is stored.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 145 +++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index f8b03d164..56785034f 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -23,6 +23,7 @@
 #include "../../../util/auxtrace.h"
 #include "../../../util/record.h"
 #include "../../../util/arm-spe.h"
+#include <tools/libc_compat.h> // reallocarray
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
@@ -31,6 +32,8 @@ struct arm_spe_recording {
 	struct auxtrace_record		itr;
 	struct perf_pmu			*arm_spe_pmu;
 	struct evlist		*evlist;
+	int			wrapped_cnt;
+	bool			*wrapped;
 };
 
 static void arm_spe_set_timestamp(struct auxtrace_record *itr,
@@ -299,6 +302,146 @@ static int arm_spe_snapshot_finish(struct auxtrace_record *itr)
 	return -EINVAL;
 }
 
+static int arm_spe_alloc_wrapped_array(struct arm_spe_recording *ptr, int idx)
+{
+	bool *wrapped;
+	int cnt = ptr->wrapped_cnt, new_cnt, i;
+
+	/*
+	 * No need to allocate, so return early.
+	 */
+	if (idx < cnt)
+		return 0;
+
+	/*
+	 * Make ptr->wrapped as big as idx.
+	 */
+	new_cnt = idx + 1;
+
+	/*
+	 * Free'ed in arm_spe_recording_free().
+	 */
+	wrapped = reallocarray(ptr->wrapped, new_cnt, sizeof(bool));
+	if (!wrapped)
+		return -ENOMEM;
+
+	/*
+	 * init new allocated values.
+	 */
+	for (i = cnt; i < new_cnt; i++)
+		wrapped[i] = false;
+
+	ptr->wrapped_cnt = new_cnt;
+	ptr->wrapped = wrapped;
+
+	return 0;
+}
+
+static bool arm_spe_buffer_has_wrapped(unsigned char *buffer,
+				      size_t buffer_size, u64 head)
+{
+	u64 i, watermark;
+	u64 *buf = (u64 *)buffer;
+	size_t buf_size = buffer_size;
+
+	/*
+	 * Defensively handle the case where head might be continually increasing - if its value is
+	 * equal or greater than the size of the ring buffer, then we can safely determine it has
+	 * wrapped around. Otherwise, continue to detect if head might have wrapped.
+	 */
+	if (head >= buffer_size)
+		return true;
+
+	/*
+	 * We want to look the very last 512 byte (chosen arbitrarily) in the ring buffer.
+	 */
+	watermark = buf_size - 512;
+
+	/*
+	 * The value of head is somewhere within the size of the ring buffer. This can be that there
+	 * hasn't been enough data to fill the ring buffer yet or the trace time was so long that
+	 * head has numerically wrapped around.  To find we need to check if we have data at the
+	 * very end of the ring buffer.  We can reliably do this because mmap'ed pages are zeroed
+	 * out and there is a fresh mapping with every new session.
+	 */
+
+	/*
+	 * head is less than 512 byte from the end of the ring buffer.
+	 */
+	if (head > watermark)
+		watermark = head;
+
+	/*
+	 * Speed things up by using 64 bit transactions (see "u64 *buf" above)
+	 */
+	watermark /= sizeof(u64);
+	buf_size /= sizeof(u64);
+
+	/*
+	 * If we find trace data at the end of the ring buffer, head has been there and has
+	 * numerically wrapped around at least once.
+	 */
+	for (i = watermark; i < buf_size; i++)
+		if (buf[i])
+			return true;
+
+	return false;
+}
+
+static int arm_spe_find_snapshot(struct auxtrace_record *itr, int idx,
+				  struct auxtrace_mmap *mm, unsigned char *data,
+				  u64 *head, u64 *old)
+{
+	int err;
+	bool wrapped;
+	struct arm_spe_recording *ptr =
+			container_of(itr, struct arm_spe_recording, itr);
+
+	/*
+	 * Allocate memory to keep track of wrapping if this is the first
+	 * time we deal with this *mm.
+	 */
+	if (idx >= ptr->wrapped_cnt) {
+		err = arm_spe_alloc_wrapped_array(ptr, idx);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * Check to see if *head has wrapped around.  If it hasn't only the
+	 * amount of data between *head and *old is snapshot'ed to avoid
+	 * bloating the perf.data file with zeros.  But as soon as *head has
+	 * wrapped around the entire size of the AUX ring buffer it taken.
+	 */
+	wrapped = ptr->wrapped[idx];
+	if (!wrapped && arm_spe_buffer_has_wrapped(data, mm->len, *head)) {
+		wrapped = true;
+		ptr->wrapped[idx] = true;
+	}
+
+	pr_debug3("%s: mmap index %d old head %zu new head %zu size %zu\n",
+		  __func__, idx, (size_t)*old, (size_t)*head, mm->len);
+
+	/*
+	 * No wrap has occurred, we can just use *head and *old.
+	 */
+	if (!wrapped)
+		return 0;
+
+	/*
+	 * *head has wrapped around - adjust *head and *old to pickup the
+	 * entire content of the AUX buffer.
+	 */
+	if (*head >= mm->len) {
+		*old = *head - mm->len;
+	} else {
+		*head += mm->len;
+		*old = *head - mm->len;
+	}
+
+	return 0;
+}
+
 static u64 arm_spe_reference(struct auxtrace_record *itr __maybe_unused)
 {
 	struct timespec ts;
@@ -313,6 +456,7 @@ static void arm_spe_recording_free(struct auxtrace_record *itr)
 	struct arm_spe_recording *sper =
 			container_of(itr, struct arm_spe_recording, itr);
 
+	free(sper->wrapped);
 	free(sper);
 }
 
@@ -336,6 +480,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	sper->itr.pmu = arm_spe_pmu;
 	sper->itr.snapshot_start = arm_spe_snapshot_start;
 	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
+	sper->itr.find_snapshot = arm_spe_find_snapshot;
 	sper->itr.parse_snapshot_options = arm_spe_parse_snapshot_options;
 	sper->itr.recording_options = arm_spe_recording_options;
 	sper->itr.info_priv_size = arm_spe_info_priv_size;
-- 
2.25.1

