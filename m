Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD86AC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 15:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07BB61246
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 15:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbhIPPsf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 11:48:35 -0400
Received: from foss.arm.com ([217.140.110.172]:39402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239989AbhIPPsc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 11:48:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8009111B3;
        Thu, 16 Sep 2021 08:47:11 -0700 (PDT)
Received: from ubuntu-18-04-aarch64-spe-2.warwick.arm.com (ubuntu-18-04-aarch64-spe-2.warwick.arm.com [10.32.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F8083F5A1;
        Thu, 16 Sep 2021 08:47:09 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Date:   Thu, 16 Sep 2021 16:46:34 +0100
Message-Id: <20210916154635.1525-4-german.gomez@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210916154635.1525-1-german.gomez@arm.com>
References: <20210916154635.1525-1-german.gomez@arm.com>
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
---
 tools/perf/arch/arm64/util/arm-spe.c | 145 +++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index f8b03d164b42..56785034fc84 100644
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
2.17.1

