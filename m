Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A813C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 16:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B2C610A0
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 16:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhKIQdb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:33:31 -0500
Received: from foss.arm.com ([217.140.110.172]:35852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234428AbhKIQda (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 11:33:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F282ED1;
        Tue,  9 Nov 2021 08:30:44 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F3C13F800;
        Tue,  9 Nov 2021 08:30:42 -0800 (PST)
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
Subject: [PATCH v2 1/3] perf arm-spe: Add snapshot mode support
Date:   Tue,  9 Nov 2021 16:30:07 +0000
Message-Id: <20211109163009.92072-2-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211109163009.92072-1-german.gomez@arm.com>
References: <20211109163009.92072-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch enables support for snapshot mode of arm_spe events,
including the implementation of the necessary callbacks (excluding
find_snapshot, which is to be included in a followup commit).

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 130 +++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index a4420d4df..f8b03d164 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -84,6 +84,55 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 	return 0;
 }
 
+static void
+arm_spe_snapshot_resolve_auxtrace_defaults(struct record_opts *opts,
+					   bool privileged)
+{
+	/*
+	 * The default snapshot size is the auxtrace mmap size. If neither auxtrace mmap size nor
+	 * snapshot size is specified, then the default is 4MiB for privileged users, 128KiB for
+	 * unprivileged users.
+	 *
+	 * The default auxtrace mmap size is 4MiB/page_size for privileged users, 128KiB for
+	 * unprivileged users. If an unprivileged user does not specify mmap pages, the mmap pages
+	 * will be reduced from the default 512KiB/page_size to 256KiB/page_size, otherwise the
+	 * user is likely to get an error as they exceed their mlock limmit.
+	 */
+
+	/*
+	 * No size were given to '-S' or '-m,', so go with the default
+	 */
+	if (!opts->auxtrace_snapshot_size && !opts->auxtrace_mmap_pages) {
+		if (privileged) {
+			opts->auxtrace_mmap_pages = MiB(4) / page_size;
+		} else {
+			opts->auxtrace_mmap_pages = KiB(128) / page_size;
+			if (opts->mmap_pages == UINT_MAX)
+				opts->mmap_pages = KiB(256) / page_size;
+		}
+	} else if (!opts->auxtrace_mmap_pages && !privileged && opts->mmap_pages == UINT_MAX) {
+		opts->mmap_pages = KiB(256) / page_size;
+	}
+
+	/*
+	 * '-m,xyz' was specified but no snapshot size, so make the snapshot size as big as the
+	 * auxtrace mmap area.
+	 */
+	if (!opts->auxtrace_snapshot_size)
+		opts->auxtrace_snapshot_size = opts->auxtrace_mmap_pages * (size_t)page_size;
+
+	/*
+	 * '-Sxyz' was specified but no auxtrace mmap area, so make the auxtrace mmap area big
+	 * enough to fit the requested snapshot size.
+	 */
+	if (!opts->auxtrace_mmap_pages) {
+		size_t sz = opts->auxtrace_snapshot_size;
+
+		sz = round_up(sz, page_size) / page_size;
+		opts->auxtrace_mmap_pages = roundup_pow_of_two(sz);
+	}
+}
+
 static int arm_spe_recording_options(struct auxtrace_record *itr,
 				     struct evlist *evlist,
 				     struct record_opts *opts)
@@ -115,6 +164,36 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	if (!opts->full_auxtrace)
 		return 0;
 
+	/*
+	 * we are in snapshot mode.
+	 */
+	if (opts->auxtrace_snapshot_mode) {
+		/*
+		 * Command arguments '-Sxyz' and/or '-m,xyz' are missing, so fill those in with
+		 * default values.
+		 */
+		if (!opts->auxtrace_snapshot_size || !opts->auxtrace_mmap_pages)
+			arm_spe_snapshot_resolve_auxtrace_defaults(opts, privileged);
+
+		/*
+		 * Snapshot size can't be bigger than the auxtrace area.
+		 */
+		if (opts->auxtrace_snapshot_size > opts->auxtrace_mmap_pages * (size_t)page_size) {
+			pr_err("Snapshot size %zu must not be greater than AUX area tracing mmap size %zu\n",
+			       opts->auxtrace_snapshot_size,
+			       opts->auxtrace_mmap_pages * (size_t)page_size);
+			return -EINVAL;
+		}
+
+		/*
+		 * Something went wrong somewhere - this shouldn't happen.
+		 */
+		if (!opts->auxtrace_snapshot_size || !opts->auxtrace_mmap_pages) {
+			pr_err("Failed to calculate default snapshot size and/or AUX area tracing mmap pages\n");
+			return -EINVAL;
+		}
+	}
+
 	/* We are in full trace mode but '-m,xyz' wasn't specified */
 	if (!opts->auxtrace_mmap_pages) {
 		if (privileged) {
@@ -138,6 +217,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
+	if (opts->auxtrace_snapshot_mode)
+		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
+			  opts->auxtrace_snapshot_size);
 
 	/*
 	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
@@ -172,6 +254,51 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+static int arm_spe_parse_snapshot_options(struct auxtrace_record *itr __maybe_unused,
+					 struct record_opts *opts,
+					 const char *str)
+{
+	unsigned long long snapshot_size = 0;
+	char *endptr;
+
+	if (str) {
+		snapshot_size = strtoull(str, &endptr, 0);
+		if (*endptr || snapshot_size > SIZE_MAX)
+			return -1;
+	}
+
+	opts->auxtrace_snapshot_mode = true;
+	opts->auxtrace_snapshot_size = snapshot_size;
+
+	return 0;
+}
+
+static int arm_spe_snapshot_start(struct auxtrace_record *itr)
+{
+	struct arm_spe_recording *ptr =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct evsel *evsel;
+
+	evlist__for_each_entry(ptr->evlist, evsel) {
+		if (evsel->core.attr.type == ptr->arm_spe_pmu->type)
+			return evsel__disable(evsel);
+	}
+	return -EINVAL;
+}
+
+static int arm_spe_snapshot_finish(struct auxtrace_record *itr)
+{
+	struct arm_spe_recording *ptr =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct evsel *evsel;
+
+	evlist__for_each_entry(ptr->evlist, evsel) {
+		if (evsel->core.attr.type == ptr->arm_spe_pmu->type)
+			return evsel__enable(evsel);
+	}
+	return -EINVAL;
+}
+
 static u64 arm_spe_reference(struct auxtrace_record *itr __maybe_unused)
 {
 	struct timespec ts;
@@ -207,6 +334,9 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 
 	sper->arm_spe_pmu = arm_spe_pmu;
 	sper->itr.pmu = arm_spe_pmu;
+	sper->itr.snapshot_start = arm_spe_snapshot_start;
+	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
+	sper->itr.parse_snapshot_options = arm_spe_parse_snapshot_options;
 	sper->itr.recording_options = arm_spe_recording_options;
 	sper->itr.info_priv_size = arm_spe_info_priv_size;
 	sper->itr.info_fill = arm_spe_info_fill;
-- 
2.25.1

